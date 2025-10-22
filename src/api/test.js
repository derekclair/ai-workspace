const apiClient = require('./client');

async function testApiConnection() {
  try {
    console.log('Testing API connection...');
    const status = await apiClient.getConflictStatus();
    console.log('Connection successful:', status);
  } catch (error) {
    console.error('API test failed:', error.message);
  }
}

// Example data sender function
async function sendTestData(data) {
  try {
    console.log('Sending test data...');
    const response = await apiClient.sendConflictData(data);
    console.log('Data sent successfully:', response);
  } catch (error) {
    console.error('Failed to send data:', error.message);
  }
}

// Export test functions
module.exports = {
  testApiConnection,
  sendTestData
};