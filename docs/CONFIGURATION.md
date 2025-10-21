# AI Workspace Configuration Guide

This document provides comprehensive configuration details for the AI workspace features and tools.

## Table of Contents

1. [VS Code Settings](#vs-code-settings)
2. [MCP Servers](#mcp-servers)
3. [GitHub Copilot](#github-copilot)
4. [Terminal Auto-Approval](#terminal-auto-approval)
5. [File Edit Auto-Approval](#file-edit-auto-approval)

---

## VS Code Settings

### Core Settings (`.vscode/settings.json`)

Our workspace uses specific VS Code settings to optimize the AI-assisted development experience:

#### MCP Configuration
```json
{
  "chat.mcp.access": "all",          // Enable full MCP access
  "chat.mcp.autostart": true,        // Auto-start MCP servers
  "chat.mcp.gallery.enabled": true   // Enable MCP gallery
}
```

#### Copilot Chat Settings
```json
{
  "chat.renderRelatedFiles": false,      // Reduce noise in chat
  "chat.todoListTool.descriptionField": true  // Enable descriptions in TODO tool
}
```

#### Terminal Configuration
```json
{
  "chat.tools.terminal.autoReplyToPrompts": true,
  "chat.tools.terminal.terminalProfile.osx": {
    "path": "bash",
    "args": [],
    "env": {
      "COPILOT": "1"  // Signal to scripts that Copilot is running
    }
  }
}
```

---

## MCP Servers

### What are MCP Servers?

Model Context Protocol (MCP) servers extend Claude and GitHub Copilot's capabilities by providing additional tools and context. Our workspace uses several MCP servers to enhance development workflows.

### Configured Servers (`.vscode/mcp.json`)

#### 1. GitHub MCP Server
**Purpose**: Interact with GitHub APIs, repositories, issues, and pull requests.

```json
{
  "github/github-mcp-server": {
    "type": "http",
    "url": "https://api.githubcopilot.com/mcp/",
    "gallery": "https://api.mcp.github.com/v0/servers/ab12cd34-5678-90ef-1234-567890abcdef",
    "version": "0.13.0"
  }
}
```

**Capabilities**:
- Create and manage issues
- Create pull requests
- Review code
- Search repositories
- Manage projects

#### 2. Atlassian MCP Server
**Purpose**: Integrate with Jira and Confluence for issue tracking and documentation.

```json
{
  "atlassian/atlassian-mcp-server": {
    "type": "http",
    "url": "https://mcp.atlassian.com/v1/sse",
    "gallery": "https://api.mcp.github.com/v0/servers/28c650c6-5e61-4ab7-9eb2-505be6350476",
    "version": "1.0.0"
  }
}
```

**Capabilities**:
- Create and update Jira issues
- Search Confluence pages
- Manage Atlassian projects

#### 3. HashiCorp Terraform MCP Server
**Purpose**: Work with Terraform infrastructure as code.

```json
{
  "hashicorp/terraform-mcp-server": {
    "type": "stdio",
    "command": "docker",
    "args": ["run", "-i", "--rm", "hashicorp/terraform-mcp-server"],
    "version": "1.0.0"
  }
}
```

**Capabilities**:
- Validate Terraform configurations
- Plan infrastructure changes
- Access Terraform documentation

#### 4. AWS Terraform MCP Server
**Purpose**: AWS-specific Terraform operations and documentation.

```json
{
  "aws.terraform": {
    "disabled": false,
    "command": "uvx",
    "args": ["awslabs.terraform-mcp-server@latest"],
    "env": {
      "AWS_PROFILE": "sandbox",
      "AWS_REGION": "us-west-2",
      "FASTMCP_LOG_LEVEL": "ERROR"
    },
    "autoApprove": []
  }
}
```

**Configuration Notes**:
- Set `AWS_PROFILE` to your desired AWS profile
- Set `AWS_REGION` to your default region
- Adjust `FASTMCP_LOG_LEVEL` for debugging (INFO, DEBUG, ERROR)

#### 5. Docker MCP Server
**Purpose**: Manage Docker containers and compose services.

```json
{
  "Docker": {
    "disabled": false,
    "command": "docker",
    "args": ["mcp", "gateway", "run"]
  }
}
```

**Capabilities**:
- List and manage containers
- Inspect images
- Execute commands in containers

#### 6. Memory (externally managed)
**Purpose**: Provide persistent memory across chat sessions. In this repository we do not run a local memory MCP server by default. Memory is expected to be managed by a local desktop application (for example, Claude Desktop) or another environment-specific process.

Notes:
- The repository previously included examples for running a local memory server; those have been removed to avoid accidentally storing conversation history in the repo.
- Local memory files are stored under `.config/` and are intentionally gitignored. If you use Claude Desktop or another client, configure it to point to the workspace `.config` folder for persistence.

Example (Claude Desktop config snippet) - user-managed:

```json
"memory": { "command": "docker", "args": ["run","-i","-v","<workspace>/.config:/app/.config","--env","MEMORY_FILE_PATH=/<workspace>/.config/memory.jsonl","--rm","mcp/memory"] }
```

This keeps memory management local to the developer's machine and out of repository control.

#### 7. Sequential Thinking MCP Server (RECOMMENDED)
**Purpose**: Enable structured, step-by-step problem solving for complex tasks.

```json
{
  "sequential-thinking": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"],
    "env": {
      "DISABLE_THOUGHT_LOGGING": "false"
    }
  }
}
```

**When to Use**:
- Complex problem decomposition
- Multi-step reasoning tasks
- Architectural decision-making
- Algorithm design
- Debug complex issues

**Configuration Options**:
- `DISABLE_THOUGHT_LOGGING`: Set to `"true"` to disable logging of thought processes

**Documentation**: [Sequential Thinking MCP Server](https://github.com/modelcontextprotocol/servers/tree/main/src/sequentialthinking)

---

## GitHub Copilot

### Copilot Instructions (single source of truth)

This workspace uses `.github/copilot-instructions.md` as the single source of truth for AI agent guidance and Copilot context. It consolidates agent-facing guidance that was previously duplicated in `AGENTS.md`.

Recommended settings to enable Copilot guidance in VS Code:

```json
{
  "chat.useAgentsMdFile": true,
  "chat.useNestedAgentsMdFiles": true
}
```

The `.github/copilot-instructions.md` file should include:

- Tech stack
- Coding standards
- Project structure
- Common patterns
- Best practices

---

## Terminal Auto-Approval

### Configuration (`chat.tools.terminal.autoApprove`)

Terminal auto-approval allows safe commands to run without confirmation. Our configuration balances productivity with security.

#### Safe Commands (Auto-Approved)

```json
{
  "chat.tools.terminal.autoApprove": {
    // Git read-only operations
    "/^git\\s+(status|diff|log|show|branch|remote)\\b/": true,
    
    // Directory navigation and inspection
    "/^(ls|pwd|cd)\\b/": true,
    
    // File inspection (read-only)
    "/^(cat|less|more|head|tail)\\b/": true,
    
    // NPM/Yarn read operations
    "/^npm\\s+(list|ls|view|show)\\b/": true,
    "/^yarn\\s+list\\b/": true,
    
    // Echo for testing
    "/^echo\\b/": true,
    
    // Terraform read operations
    "/^terraform\\s+(validate|fmt|show|output|version)\\b/": true
  }
}
```

#### Dangerous Commands (Explicitly Denied)

```json
{
  "chat.tools.terminal.autoApprove": {
    // File deletion
    "rm": false,
    "rmdir": false,
    "del": false,
    "/^Remove-Item\\b/i": false,
    
    // Process management
    "kill": false,
    "killall": false,
    
    // Permission changes
    "chmod": false,
    "chown": false,
    
    // Git write operations
    "/^git\\s+(push|reset|revert|clean|rm)\\b/": false,
    
    // Network operations
    "curl": false,
    "wget": false,
    
    // Execution
    "eval": false,
    "exec": false,
    
    // Package installation (should be reviewed)
    "/^npm\\s+install\\b/": false,
    "/^yarn\\s+add\\b/": false,
    "/^pip\\s+install\\b/": false
  }
}
```

### Pattern Syntax

- **Regex patterns**: Wrap in forward slashes: `/pattern/`
- **Exact matches**: Use plain strings: `"rm"`
- **Case-insensitive**: Add `i` flag: `/^Remove-Item\\b/i`

### Security Considerations

1. **Review before enabling**: Understand what each pattern matches
2. **Start restrictive**: Add patterns as needed, don't enable all commands
3. **Project-specific**: Adjust based on your workflow and risk tolerance
4. **Regular audits**: Review and update patterns periodically

---

## File Edit Auto-Approval

### Configuration (`chat.tools.edits.autoApprove`)

File edit auto-approval controls which files can be modified without confirmation.

#### Current Configuration

```json
{
  "chat.tools.edits.autoApprove": {
    // Auto-approve all files by default
    "**/*": true,
    
    // Except VS Code configuration
    "**/.vscode/*.json": false,
    
    // Except Git internals
    "**/.git/**": false,
    
    // Except critical config files
    "**/{package.json,package-lock.json,server.xml,build.rs,web.config,.gitattributes,.env}": false,
    
    // Except .NET project files
    "**/*.{csproj,fsproj,vbproj}": false
  }
}
```

#### Rationale

- **Source code**: Auto-approved for rapid iteration
- **Configuration**: Manual review to prevent misconfigurations
- **Dependencies**: Manual review to avoid unexpected changes
- **Project files**: Manual review to maintain project integrity

#### Customization

Add patterns based on your project:

```json
{
  "chat.tools.edits.autoApprove": {
    // Terraform files require review
    "**/*.tf": false,
    "**/*.tfvars": false,
    
    // Database migrations require review
    "**/migrations/**": false,
    
    // CI/CD configurations require review
    "**/.github/workflows/**": false
  }
}
```

---

## Best Practices

### 1. MCP Server Management

- **Enable only needed servers**: Disable unused servers to reduce overhead
- **Version pinning**: Use specific versions for stability
- **Environment variables**: Use `.env` files for sensitive configuration

### 2. Security

- **Never auto-approve destructive commands**: Review before execution
- **Audit configurations regularly**: Review and update patterns
- **Use workspace settings**: Project-specific rules in workspace, not user settings

### 3. Performance

- **Disable unused MCP servers**: Reduces startup time
- **Adjust logging levels**: Reduce verbosity in production
- **Use HTTP servers when available**: Generally faster than stdio

### 4. Documentation

- **Keep AGENTS.md updated**: Ensure AI assistants have current context
- **Document custom patterns**: Explain why specific patterns are allowed/denied
- **Version control**: Commit configuration files to share with team

---

## Troubleshooting

### MCP Server Not Starting

1. Check server name in `mcp.json` (must match exactly)
2. Verify command availability: `which npx` or `which docker`
3. Check VS Code Output panel: "GitHub Copilot Chat" channel
4. Restart VS Code: Sometimes required after configuration changes

### Terminal Commands Not Auto-Approving

1. Verify `chat.tools.terminal.autoApprove` is configured
2. Check pattern syntax (regex vs. string)
3. Test pattern matches: Commands must match exactly
4. Check for conflicting rules: More specific rules override general ones

### File Edits Not Auto-Approving

1. Verify `chat.tools.edits.autoApprove` is configured
2. Check file path patterns: Use glob syntax correctly
3. Verify file is not in exception list
4. Test with a simple pattern: Start with `"**/*": true`

---

## Additional Resources

- [VS Code Copilot Documentation](https://code.visualstudio.com/docs/copilot)
- [MCP Specification](https://modelcontextprotocol.io/)
- [GitHub Copilot Settings Reference](https://code.visualstudio.com/docs/copilot/reference/copilot-settings)
- [Sequential Thinking MCP Server](https://github.com/modelcontextprotocol/servers/tree/main/src/sequentialthinking)
