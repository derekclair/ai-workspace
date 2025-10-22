# To-Do

## Completed ✅

- [x] Configure comprehensive `chat.tools.terminal.autoApprove` settings
- [x] Add Sequential Thinking MCP server configuration
- [x] Create comprehensive documentation in `docs/CONFIGURATION.md`
- [x] Update AGENTS.md with project context
- [x] Update .github/copilot-instructions.md with detailed guidance
- [x] Add proper .gitignore file
- [x] Fix filename typo: mpc.json → mcp.json
- [x] Update README.md with comprehensive overview

## High Priority 🔴

- [ ] IQGeo Conflict Fixer API Integration
  - Phase 1: API Analysis and Documentation
    - [ ] Analyze API endpoints and authentication
    - [ ] Document data structures and validation rules
    - [ ] Update iqgeo-api.instructions.md
  - Phase 2: Mock Data Strategy
    - [ ] Define data templates and scenarios
    - [ ] Update data generation prompts
    - [ ] Create validation scripts
  - Phase 3: Implementation
    - [ ] Create API interaction scripts
    - [ ] Implement data generation
    - [ ] Add error handling and logging
  - Phase 4: Testing
    - [ ] Validate data and API interactions
    - [ ] Performance testing
  - Phase 5: Documentation
    - [ ] Update all documentation
    - [ ] Create usage guidelines

- [x] Add PostgreSQL MCP server and configure database
  ```json
  "postgres": {
    "command": "npx",
    "args": [
      "-y",
      "@modelcontextprotocol/server-postgres",
      "postgresql://localhost/mydb"
    ]
  }
  ```
  - Set up local PostgreSQL instance
  - Create sample database and seed data
  - Document connection configuration
  - Add usage examples

- [ ] Add Playwright MCP server for automated testing
  ```json
  "playwright": {
    "command": "npx",
    "args": [
      "-y",
      "@microsoft/mcp-server-playwright"
    ]
  }
  ```
  - Document test automation workflows
  - Create example test scenarios
  - Add best practices for AI-driven testing

## Medium Priority 🟡

- [ ] Explore `chat.promptFilesLocations` setting
  - Document how to use custom prompt locations
  - Add examples of organizing prompts by project
  - Test effectiveness with different structures

- [ ] Review `chat.renderRelatedFiles` setting
  - Document when to enable/disable
  - Test impact on chat experience
  - Add to configuration guide

- [ ] Create example custom prompt workflows
  - Git workflow automation
  - Code review assistance
  - Documentation generation
  - Infrastructure provisioning

- [ ] Add CI/CD examples
  - GitHub Actions workflow for validation
  - Terraform plan automation
  - Documentation linting
  - Configuration validation

## Low Priority 🟢

- [ ] Add more domain-specific instruction files
  - Python best practices
  - JavaScript/TypeScript guidelines
  - Kubernetes configurations
  - Database design patterns

- [ ] Create video tutorials
  - Setting up the workspace
  - Using custom prompts
  - Configuring MCP servers
  - Security best practices

- [ ] Add example projects
  - Simple web app with Terraform
  - Serverless function deployment
  - Container-based application
  - Multi-service architecture

- [ ] Enhance .github/scripts/
  - Validation script for configurations
  - Setup script for new users
  - Health check for MCP servers
  - (optional) Backup script for local `.config/memory.json` — user-managed

## Documentation Improvements 📝

- [ ] Add architecture diagrams
  - MCP server interaction flow
  - Configuration hierarchy
  - Security model visualization

- [ ] Create troubleshooting guide
  - Common error messages
  - Step-by-step debugging
  - FAQ section

- [ ] Add usage examples for each MCP server
  - GitHub server workflows
  - Atlassian integration patterns
  - Terraform best practices
  - Memory server tips

- [ ] Document advanced configurations
  - Multi-environment setups
  - Team collaboration patterns
  - Custom tool development
  - Performance optimization

## Research & Exploration 🔬

- [ ] Evaluate additional MCP servers
  - Kubernetes MCP server
  - Cloud provider servers (Azure, GCP)
  - Monitoring and observability tools
  - Development tools (ESLint, Prettier)

- [ ] Test agent mode capabilities
  - Complex multi-file refactoring
  - Cross-repository operations
  - Large-scale documentation updates
  - Infrastructure migrations

- [ ] Explore prompt engineering techniques
  - Few-shot learning patterns
  - Chain-of-thought prompting
  - Retrieval-augmented generation
  - Context optimization

- [ ] Investigate security enhancements
  - Sandboxed execution environments
  - Command whitelisting strategies
  - Audit logging
  - Access control patterns

## Community & Sharing 🌐

- [ ] Create contributing guidelines
- [ ] Add code of conduct
- [ ] Set up issue templates
- [ ] Create pull request template
- [ ] Add license file
- [ ] Create changelog
- [ ] Set up GitHub Discussions
- [ ] Add badges to README

## Notes

- Items marked with 🔴 should be completed first
- Items marked with 🟡 are nice-to-have improvements
- Items marked with 🟢 are long-term enhancements
- Review and update this list monthly
- Move completed items to the "Completed" section

## Ideas for Future Consideration

- Integration with other AI tools (Claude Desktop, Cursor)
- Custom MCP server development
- Workspace templates for different tech stacks
- Automated workspace setup tool
- Performance benchmarking
- Cost tracking for AI API usage
