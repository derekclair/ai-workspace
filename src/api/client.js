/**
 * IQGeo API Client
 * Handles API interactions with rate limiting and retries
 */

const axios = require('axios');
const config = require('./config.json');

class IQGeoApiClient {
  constructor() {
    this.axios = axios.create({
      baseURL: config.baseUrl,
      timeout: config.api.timeout,
      headers: {
        'Content-Type': 'application/json'
      }
    });

    this.requestCount = 0;
    this.lastResetTime = Date.now();
    
    // Add request interceptor for rate limiting
    this.axios.interceptors.request.use(async (config) => {
      if (this.shouldRateLimit()) {
        await this.delay(this.getDelayTime());
      }
      this.requestCount++;
      return config;
    });

    // Add response interceptor for retries
    this.axios.interceptors.response.use(
      response => response,
      async error => {
        if (!error.config || !error.config.retryCount) {
          error.config.retryCount = 0;
        }

        if (error.config.retryCount >= config.api.retryAttempts) {
          return Promise.reject(error);
        }

        error.config.retryCount++;
        await this.delay(config.api.retryDelay * error.config.retryCount);
        return this.axios(error.config);
      }
    );
  }

  /**
   * Check if we should apply rate limiting
   */
  shouldRateLimit() {
    if (!config.rateLimit.enabled) return false;

    const now = Date.now();
    const oneMinute = 60 * 1000;

    if (now - this.lastResetTime >= oneMinute) {
      this.requestCount = 0;
      this.lastResetTime = now;
      return false;
    }

    return this.requestCount >= config.rateLimit.maxRequestsPerMinute;
  }

  /**
   * Calculate delay time for rate limiting
   */
  getDelayTime() {
    const now = Date.now();
    const timeUntilReset = (this.lastResetTime + 60000) - now;
    return Math.max(0, timeUntilReset);
  }

  /**
   * Utility method for adding delay
   */
  async delay(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  /**
   * Send data to the conflict fixer
   * @param {Object} data - The data to send
   * @returns {Promise} API response
   */
  async sendConflictData(data) {
    try {
      const response = await this.axios.post(config.endpoints.conflictFixer, data);
      return response.data;
    } catch (error) {
      console.error('Error sending conflict data:', error.message);
      throw error;
    }
  }

  /**
   * Get current conflict status
   * @returns {Promise} API response
   */
  async getConflictStatus() {
    try {
      const response = await this.axios.get(config.endpoints.conflictFixer);
      return response.data;
    } catch (error) {
      console.error('Error getting conflict status:', error.message);
      throw error;
    }
  }
}

module.exports = new IQGeoApiClient();