# AI Workspace

An example workspace demonstrating best practices for AI-assisted development with GitHub Copilot, VS Code, and MCP servers.

## Overview

This repository serves as a reference implementation for setting up an AI-enhanced development environment. It showcases:

- **GitHub Copilot** integration with custom prompts and instructions
- **Model Context Protocol (MCP)** servers for extended AI capabilities
- **Security-conscious auto-approval** settings for terminal and file operations
- **Project-specific context** through `copilot-instructions.md` and domain-specific instruction files

## Quick Start

### Prerequisites

- VS Code (version 1.99+)
- GitHub Copilot subscription
- Node.js (for NPX-based MCP servers)
- Docker (for containerized MCP servers)

### Setup

1. **Clone this repository**:
   ```bash
   git clone <repository-url>
   cd ai-workspace
   ```

2. **Open in VS Code**:
   ```bash
   code .
   ```

3. **Install recommended extensions**:
   - VS Code will prompt you to install recommended extensions
   - Or manually install from `.vscode/extensions.json`

4. **Review and adjust configurations**:
   - See [`docs/CONFIGURATION.md`](docs/CONFIGURATION.md) for detailed configuration guide
   - Adjust AWS profile and region in `.vscode/mcp.json`
   - Review auto-approval patterns in `.vscode/settings.json`

5. **Start using AI features**:
   - Open GitHub Copilot Chat (⌃⌘I / Ctrl+Alt+I)
   - Try the custom prompts in `.github/prompts/`
   - Use `/` commands to trigger custom prompts

## Features

### 🤖 AI-Powered Development

- **Agent Mode**: Autonomous coding with multi-step reasoning
- **Custom Prompts**: Pre-built prompts for common workflows
- **Sequential Thinking**: Complex problem-solving with structured reasoning

### 🔧 MCP Servers

This workspace includes several MCP servers that extend AI capabilities:

- **GitHub**: Manage issues, PRs, and repositories
- **Atlassian**: Integrate Jira and Confluence
- **Terraform**: Infrastructure as Code assistance
- **AWS Terraform**: AWS-specific IaC support
- **Docker**: Container management
- **Memory**: Persistent context across sessions
- **Sequential Thinking**: Structured problem decomposition

See [`docs/CONFIGURATION.md`](docs/CONFIGURATION.md) for detailed information on each server.

### 🔒 Security Features

- **Selective auto-approval**: Only safe, read-only commands are auto-approved
- **File protection**: Critical configuration files require manual review
- **Explicit deny lists**: Dangerous commands are explicitly blocked
- **Auditable patterns**: All patterns are documented and version-controlled

### 📝 Context & Instructions

- **`.github/copilot-instructions.md`**: Project-wide instructions for Copilot
- **`.github/instructions/`**: Domain-specific instruction files
- **`.github/prompts/`**: Reusable prompt templates

## Working with AI Agents

### Context Files

AI agents use several files to understand your project:

1. **`.github/copilot-instructions.md`**: Project-wide instructions for Copilot
3. **`.github/instructions/*.instructions.md`**: Domain-specific guidance

Enable these features in settings:
```json
{
  "chat.useAgentsMdFile": true,
  "chat.useNestedAgentsMdFiles": true
}
```

### Custom Prompts

Use custom prompts with the `/` command:

- `/terraform` - Terraform-specific assistance
- `/documentation-writer` - Generate documentation
- `/react-component` - Create React components

Custom prompts are stored in `.github/prompts/` and can be triggered by name in chat.

### Auto-Approval Patterns

The workspace uses carefully crafted auto-approval patterns to balance productivity and security.

**Safe commands** (auto-approved):
- Git read operations: `git status`, `git diff`, `git log`
- File inspection: `cat`, `ls`, `pwd`
- Safe operations: `echo`, `terraform validate`

**Dangerous commands** (require confirmation):
- Destructive: `rm`, `rmdir`, `del`
- Privileged: `chmod`, `chown`, `kill`
- Network: `curl`, `wget`
- Installations: `npm install`, `pip install`

See [Terminal Auto-Approval](docs/CONFIGURATION.md#terminal-auto-approval) for complete configuration.

## Project Structure

```
ai-workspace/
├── .github/
│   ├── copilot-instructions.md       # Project-wide Copilot instructions
│   ├── instructions/                 # Domain-specific instructions
│   │   ├── terraform.instructions.md
│   │   ├── postgres.instructions.md
│   │   └── ...
│   ├── prompts/                      # Custom prompt templates
│   │   ├── terraform.prompt.md
│   │   ├── documentation-writer.prompt.md
│   │   └── ...
│   └── scripts/                      # Utility scripts
│       └── fix-line-endings.sh
├── .vscode/
│   ├── settings.json                 # Workspace settings
│   ├── mcp.json                      # MCP server configuration
│   ├── extensions.json               # Recommended extensions
│   └── task-list.mdc                 # Task management
├── .config/
│   └── memory.json                   # (optional) local persistent memory storage (gitignored)
├── docs/
│   └── CONFIGURATION.md              # Detailed configuration guide
├── README.md                         # This file
└── TODO.md                           # Project tasks
```

## Configuration

All configurations are documented in [`docs/CONFIGURATION.md`](docs/CONFIGURATION.md), including:

- VS Code settings explanation
- MCP server setup and usage
- Terminal auto-approval patterns
- File edit auto-approval rules
- Security considerations
- Troubleshooting guide

## Best Practices

### 1. Security

- **Review auto-approval patterns** before enabling
- **Keep dangerous commands blocked**
- **Regularly audit configurations**
- **Use workspace settings** for project-specific rules

### 2. Context Management

- **Keep `copilot-instructions.md` updated** with current project context
- **Document decisions** in instruction files
- **Use custom prompts** for repeated workflows
- **Leverage memory server** for persistent context

### 3. MCP Server Usage

- **Disable unused servers** to improve performance
- **Pin versions** for stability
- **Use environment variables** for sensitive configuration
- **Monitor server logs** in VS Code Output panel

### 4. Team Collaboration

- **Version control configurations** to share with team
- **Document custom patterns** and their rationale
- **Create team-specific prompts** for common workflows
- **Review and update** configurations regularly

## Troubleshooting

### MCP Servers Not Starting

1. Check VS Code Output panel → "GitHub Copilot Chat"
2. Verify command availability: `which npx` or `which docker`
3. Restart VS Code after configuration changes
4. Check server logs for specific errors

### Auto-Approval Not Working

1. Verify pattern syntax (regex requires `/pattern/`)
2. Test pattern matches against actual commands
3. Check for conflicting rules (more specific rules win)
4. Review VS Code settings for typos

### Chat Not Using Context

1. Ensure `chat.useAgentsMdFile` setting is enabled
2. Check that `copilot-instructions.md` contains project context
3. Verify `.github/copilot-instructions.md` exists
4. Restart VS Code to reload context files

See [`docs/CONFIGURATION.md#troubleshooting`](docs/CONFIGURATION.md#troubleshooting) for more solutions.

## TODO

See [TODO.md](TODO.md) for planned improvements and tasks.

## QA Testing

This workspace supports automated testing with Playwright MCP server. See the [Microsoft Playwright MCP](https://github.com/microsoft/playwright-mcp) documentation for setup instructions.

## Additional Resources

- [VS Code Copilot Documentation](https://code.visualstudio.com/docs/copilot)
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [MCP Specification](https://modelcontextprotocol.io/)
- [Awesome MCP Servers](https://github.com/modelcontextprotocol/servers)
- [VS Code Agent Mode](https://code.visualstudio.com/docs/copilot/chat/chat-agent-mode)

## Contributing

This is an example repository. Feel free to fork and adapt to your needs. If you find improvements or have suggestions, contributions are welcome!

## License

[Add your license here]
