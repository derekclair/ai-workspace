# GitHub Copilot Instructions

This file provides project-specific instructions for GitHub Copilot and Copilot Chat when working in this repository.

## Project Context

This is an **AI Workspace** - a reference implementation for AI-enhanced development. The primary goals are:

1. Demonstrate best practices for AI-assisted development
2. Showcase security-conscious configurations
3. Provide reusable templates and patterns
4. Document MCP server integration

**Target Audience**: Developers looking to set up AI-enhanced workspaces

## Tech Stack

### Primary Technologies
- **Language**: Markdown, JSON, Shell, Terraform
- **Editor**: VS Code
- **AI Tools**: GitHub Copilot with MCP servers
- **Infrastructure**: Terraform (AWS focus)

### Development Environment
- **OS**: macOS (with bash instead of zsh)
- **Terminal**: Bash with COPILOT environment variable
- **Container Runtime**: Docker

## Coding Standards

### Language-Specific Conventions
- Markdown (`.md`)
   - Use ATX-style headers (`#` not `===`)
   - Include table of contents for documents > 3 sections
   - Use fenced code blocks with language identifiers
   - Link to related documentation
   - Prefer relative links for internal references
- JSON (`.json`) Configuration Files
   - **Indentation**: 2 spaces
   - **Comments**: Use `//` for inline comments in VS Code settings
   - **Organization**: Group related settings together
   - **Documentation**: Add comments for non-obvious configurations
- Shell (`.sh`) Scripts
   - **Shebang**: `#!/usr/bin/env bash`
   - **Error handling**: Use `set -e` and `set -u`
   - **Comments**: Explain complex logic
   - **Linting**: Follow shellcheck recommendations
- Terraform (`.tf`)
   - **Style**: Follow Terraform style guide
   - **State**: Never commit state files
   - **Secrets**: Use variables, never hardcode
   - **Modules**: Prefer official modules when available

## Project Structure

```
ai-workspace/
├── .github/
│   ├── copilot-instructions.md    # This file
│   ├── instructions/              # Domain-specific instructions
│   ├── prompts/                   # Custom prompts
│   └── scripts/                   # Utility scripts
├── .vscode/
│   ├── settings.json              # Workspace settings
│   ├── mcp.json                   # MCP server config
│   └── extensions.json            # Recommended extensions
├── docs/
│   └── CONFIGURATION.md           # Detailed config docs
├── AGENTS.md                      # AI agent instructions
└── README.md                      # Project overview
```

## Security & Auto-Approval

### Terminal Command Philosophy

**Auto-approve safe, read-only operations:**
- Git: `status`, `diff`, `log`, `show`
- File inspection: `cat`, `ls`, `pwd`
- Package inspection: `npm list`, `yarn list`
- Infrastructure: `terraform validate`, `terraform show`

**Always require confirmation for:**
- Write operations: `git push`, `npm install`
- Destructive operations: `rm`, `kill`
- Network operations: `curl`, `wget`
- Privilege changes: `chmod`, `chown`

### File Edit Philosophy

**Auto-approve:**
- Source code files (*.js, *.ts, *.py, etc.)
- Documentation files (*.md)
- Test files

**Require confirmation:**
- Configuration files (`package.json`, `.env`)
- VS Code settings (`.vscode/*.json`)
- Infrastructure code (`*.tf`, `*.tfvars`)
- CI/CD workflows (`.github/workflows/*`)

## Communication Style

### When Writing Documentation
- **Be clear and explicit** about security implications
- **Provide examples** for complex configurations
- **Link to official documentation** when available
- **Explain the "why"** not just the "what"
- **Consider multiple skill levels** - this is a reference repo

### When Suggesting Code
- **Prioritize security** over convenience
- **Follow established patterns** in the repository
- **Include comments** for non-obvious logic
- **Suggest improvements** but respect existing decisions
- **Provide rationale** for significant changes

### When Responding to Questions
- **Reference existing documentation** first
- **Provide specific examples** from the project
- **Explain trade-offs** when multiple approaches exist
- **Consider the learning objective** - teaching is a goal

## Common Workflows

### Adding a New MCP Server

1. Add configuration to `.vscode/mcp.json`
2. Document in `docs/CONFIGURATION.md`:
   - Purpose and capabilities
   - Configuration options
   - Usage examples
   - Common issues
3. Update README.md if significant
4. Test server initialization
5. Add to TODO.md if setup needs completion

### Creating a Custom Prompt

1. Create `*.prompt.md` in `.github/prompts/`
2. Include frontmatter:
   ```yaml
   ---
   mode: 'agent'
   description: 'Brief description'
   ---
   ```
3. Write clear instructions for the AI
4. Include examples of usage
5. Document in README.md

### Adding Domain-Specific Instructions

1. Create `*.instructions.md` in `.github/instructions/`
2. Follow format of existing files:
   - Overview of the domain
   - Best practices
   - Common patterns
   - Example code
3. Reference from AGENTS.md if relevant
4. Test effectiveness with Copilot

## MCP Server Usage

### Available Servers

**GitHub** - Repository management
- Create issues and PRs
- Review code
- Search repositories
- Manage projects

**Atlassian** - Jira and Confluence
- Create and update Jira issues
- Search Confluence pages
- Manage projects

**Terraform** - Infrastructure as Code
- Validate configurations
- Access documentation
- Plan infrastructure

**Memory** - Persistent context (externally managed)
- Store project-specific information (managed locally by the developer)
- Remember preferences
- Maintain context across sessions

Note: The repository does not start or manage a memory server by default. If you use a local memory server (for example, Claude Desktop), configure it to mount the workspace `.config` directory so memory is persisted locally and not committed to the repository.

**Sequential Thinking** - Complex problem-solving
- Break down complex tasks
- Structured reasoning
- Step-by-step analysis

### When to Use Each Server

- **GitHub**: Working with repositories, issues, PRs
- **Atlassian**: Project management and documentation
- **Terraform**: Infrastructure planning and validation
- **Memory**: Maintaining context across sessions
- **Sequential Thinking**: Complex architectural decisions, debugging intricate issues

## Best Practices

### Configuration Changes

When suggesting configuration changes:
1. **Explain the impact** clearly
2. **Provide before/after examples**
3. **Document security implications**
4. **Reference official documentation**
5. **Consider edge cases**

### Documentation

When creating or updating documentation:
1. **Update all relevant files** (README, CONFIGURATION, AGENTS)
2. **Include practical examples**
3. **Link between related sections**
4. **Keep consistent formatting**
5. **Verify links work**

### Code Suggestions

When suggesting code:
1. **Follow existing patterns** in the repository
2. **Include error handling**
3. **Add helpful comments**
4. **Consider security implications**
5. **Test suggestions** when possible

## Troubleshooting Guidance

When helping troubleshoot:
1. **Check common issues first** (documented in CONFIGURATION.md)
2. **Verify prerequisites** (VS Code version, extensions, etc.)
3. **Suggest systematic debugging** (logs, settings, restarts)
4. **Provide specific solutions** not just general advice
5. **Document new issues** for future reference

## References

- [VS Code Copilot Documentation](https://code.visualstudio.com/docs/copilot)
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [MCP Specification](https://modelcontextprotocol.io/)
- [VS Code Settings Reference](https://code.visualstudio.com/docs/getstarted/settings)

## Notes for AI Assistants

- This is a **reference/example repository** - optimize for clarity and teaching
- **Security is paramount** - never compromise security for convenience
- **Documentation is key** - well-documented configs are more valuable than clever ones
- **Examples matter** - include practical examples wherever possible
- **Think about the audience** - developers of varying skill levels will use this
