# Agent Instructions

This file provides context and instructions to AI agents working in this repository. It helps agents understand project conventions, best practices, and specific requirements.

## Project Overview

This is an **AI Workspace** - a reference implementation demonstrating best practices for AI-assisted development. The workspace showcases integration between GitHub Copilot, VS Code, and MCP servers.

## Project Goals

1. Demonstrate AI-enhanced development workflows
2. Showcase security-conscious auto-approval configurations
3. Provide reusable custom prompts and instructions
4. Document MCP server integration patterns

## Tech Stack

### Core Technologies
- **Editor**: VS Code
- **AI**: GitHub Copilot with MCP servers
- **Infrastructure**: Terraform
- **Documentation**: Markdown

### MCP Servers
- GitHub (repository management)
- Terraform (infrastructure as code)
- AWS Terraform (AWS-specific IaC)
- Atlassian (Jira/Confluence)
- Docker (container management)
- Memory (persistent context)
- Sequential Thinking (structured problem-solving)

## Coding Standards

### General Principles

1. **Security First**: Never auto-approve destructive operations
2. **Clarity**: Prefer readable code over clever code
3. **Documentation**: All configurations should be well-documented
4. **Testing**: Include tests when appropriate

### Language-Specific Conventions

1. Markdown (`.md`)
   - Use ATX-style headers (`#` prefix)
   - Include table of contents for long documents
   - Use code blocks with language identifiers
   - Keep line length reasonable (80-120 characters)
   - Use relative links for internal references
2. JSON (`.json`) Configuration
   - Use 2-space indentation
   - Include comments (in settings.json, use `//` comments)
   - Group related settings together
   - Document non-obvious configurations
3. Shell (`.sh`) Scripts
   - Use `#!/usr/bin/env bash` shebang
   - Include error handling (`set -e`, `set -u`)
   - Add comments for complex operations
   - Follow shellcheck recommendations

## Project-Specific Conventions

### File Organization

- **Configuration files**: `.vscode/` directory
- **Instructions**: `.github/instructions/` directory
- **Prompts**: `.github/prompts/` directory
- **Documentation**: `docs/` directory
- **Scripts**: `.github/scripts/` directory

### Naming Conventions

- **Instruction files**: `*.instructions.md`
- **Prompt files**: `*.prompt.md`
- **Configuration files**: Use standard names (e.g., `settings.json`, `mcp.json`)

### Documentation Requirements

When creating or updating features:

1. **Update README.md** with high-level overview
2. **Update docs/CONFIGURATION.md** with technical details
3. **Add examples** in relevant instruction files
4. **Document rationale** for non-obvious decisions

## Auto-Approval Philosophy

### Terminal Commands

**Auto-approve:**
- Read-only operations (git status, ls, cat)
- Safe inspections (terraform validate, npm list)
- Non-destructive operations (echo, pwd)

**Require confirmation:**
- Write operations (git push, npm install)
- Destructive operations (rm, kill)
- Network operations (curl, wget)
- Privilege changes (chmod, chown)

### File Edits

**Auto-approve:**
- Source code files
- Documentation files
- Test files

**Require confirmation:**
- Configuration files (package.json, .env)
- VS Code settings
- Infrastructure definitions (*.tf)
- CI/CD workflows

## Working with AI Agents

### Context Awareness

Agents should be aware of:
- The security-conscious approach to auto-approval
- The importance of documentation
- The example/reference nature of this repository
- The need for clear explanations in all configurations

### Best Practices for Agents

1. **Ask before destructive operations**: Even if auto-approval is configured
2. **Explain configurations**: Especially security-related settings
3. **Provide examples**: When documenting patterns or configurations
4. **Consider the audience**: This is an example repo, optimize for clarity
5. **Reference documentation**: Link to official docs when appropriate

### Response Style

When working in this repository:
- Be clear and explicit about security implications
- Provide rationale for configuration decisions
- Include examples and use cases
- Link to relevant documentation
- Consider both novice and advanced users

## Common Tasks

### Adding a New MCP Server

1. Add server configuration to `.vscode/mcp.json`
2. Document the server in `docs/CONFIGURATION.md`
3. Update README.md if significant
4. Add usage examples if applicable
5. Test that the server starts correctly

### Creating a Custom Prompt

1. Create `*.prompt.md` file in `.github/prompts/`
2. Include frontmatter with mode and description
3. Document the prompt's purpose and usage
4. Add examples of when to use the prompt
5. Update documentation if needed

### Adding an Instruction File

1. Create `*.instructions.md` file in `.github/instructions/`
2. Follow the format of existing instruction files
3. Include clear examples and guidelines
4. Reference from AGENTS.md if relevant
5. Test with Copilot to ensure effectiveness

## Security Considerations

### Sensitive Information

- **Never commit**: API keys, passwords, tokens
- **Use environment variables**: For sensitive configuration
- **Document required variables**: In README or CONFIGURATION.md
- **Provide examples**: Use placeholder values

### Auto-Approval Risks

When configuring auto-approval patterns:
- Consider worst-case scenarios
- Test patterns thoroughly
- Document the rationale
- Review regularly
- Start restrictive, relax as needed

## References

- [VS Code Documentation](https://code.visualstudio.com/docs)
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [MCP Documentation](https://modelcontextprotocol.io/)
- [Terraform Documentation](https://www.terraform.io/docs)

## Questions?

For questions about this workspace or AI-assisted development patterns, refer to:
- README.md for overview
- docs/CONFIGURATION.md for technical details
- TODO.md for planned improvements
