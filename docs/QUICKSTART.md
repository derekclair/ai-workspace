# Quick Start Guide

Get up and running with the AI Workspace in 5 minutes.

## Prerequisites Check

Before starting, ensure you have:

- [ ] VS Code version 1.99 or higher
- [ ] GitHub Copilot subscription (or Copilot Free)
- [ ] Node.js (for NPX-based MCP servers)
- [ ] Docker (for containerized MCP servers)

## Step 1: Clone and Open (1 minute)

```bash
# Clone the repository
git clone <repository-url>
cd ai-workspace

# Open in VS Code
code .
```

## Step 2: Install Extensions (1 minute)

VS Code will prompt you to install recommended extensions. Click "Install All" or install manually:

- GitHub Copilot
- GitHub Copilot Chat
- Kubernetes Tools (optional)
- GitHub Issue Notebooks (optional)

**Or via command:**
```bash
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat
```

## Step 3: Configure Environment (2 minutes)

### Option A: Use Default Configuration (Recommended)

The default configuration is ready to use! Just review:

1. **`.vscode/settings.json`** - Auto-approval patterns
2. **`.vscode/mcp.json`** - MCP servers

### Option B: Customize for Your Environment

If you need AWS or specific configurations:

1. **Edit `.vscode/mcp.json`**:
   ```json
   {
     "aws.terraform": {
       "env": {
         "AWS_PROFILE": "your-profile",  // Change this
         "AWS_REGION": "your-region"     // Change this
       }
     }
   }
   ```

2. **Review auto-approval patterns** in `.vscode/settings.json` if needed

## Step 4: Verify Setup (1 minute)

1. **Open Copilot Chat**: Press `⌃⌘I` (Mac) or `Ctrl+Alt+I` (Windows/Linux)

2. **Check MCP servers**:
   - Look for "MCP" status in the VS Code status bar
   - Click to see active servers

3. **Test a command**:
   Type in chat: "List the MCP servers configured in this workspace"

## First Tasks to Try

### 1. Use a Custom Prompt

```
/terraform help me understand the configuration
```

### 2. Try Agent Mode

1. Switch to "Agent" mode in chat dropdown
2. Type: "Create a simple README for a Python project"
3. Watch it work autonomously

### 3. Test Auto-Approval

1. In chat, ask: "What is the current git status?"
2. Notice it runs without confirmation (safe command)

### 4. Use Sequential Thinking

For complex problems:
```
Using sequential thinking, help me design a CI/CD pipeline for this workspace
```

## Next Steps

### Learn the Basics

- **Read the README**: [`README.md`](README.md)
- **Review Configuration**: [`docs/CONFIGURATION.md`](docs/CONFIGURATION.md)
- **Understand Security**: Check auto-approval patterns

### Customize Your Workspace

1. **Add domain-specific instructions** in `.github/instructions/`
2. **Create custom prompts** in `.github/prompts/`
3. **Update AGENTS.md** with your project context

### Explore MCP Servers

Try each server:
- **GitHub**: "Create a new issue for improving documentation"
- **Memory**: "Remember that I prefer TypeScript over JavaScript"
- **Sequential Thinking**: Use for complex problem-solving

## Common Issues & Solutions

### MCP Servers Not Starting

**Check:**
```bash
# Verify NPX is available
which npx

# Verify Docker is running
docker ps
```

**Fix:**
- Restart VS Code
- Check Output panel → "GitHub Copilot Chat"
- Verify server configurations in `.vscode/mcp.json`

### Commands Not Auto-Approving

**Check:**
- Pattern syntax in `.vscode/settings.json`
- Command matches exactly (case-sensitive for non-regex)
- No conflicting deny rules

**Example regex pattern:**
```json
"/^git\\s+status\\b/": true  // ✅ Correct
"git status": true           // ❌ Won't match with arguments
```

### Chat Not Using Context

**Enable context features:**
```json
{
  "chat.useAgentsMdFile": true,
  "chat.useNestedAgentsMdFiles": true
}
```

**Then restart VS Code**

## Tips for Success

### 1. Security First
- Review auto-approval patterns before enabling
- Start restrictive, relax as you gain confidence
- Never auto-approve destructive commands

### 2. Document Everything
- Keep AGENTS.md updated with project context
- Document custom patterns and their rationale
- Maintain instruction files for your domain

### 3. Leverage Custom Prompts
- Create prompts for repeated workflows
- Store them in `.github/prompts/`
- Share with your team via version control

### 4. Use Agent Mode Wisely
- Great for complex, multi-step tasks
- Monitor its actions, especially terminal commands
- Learn from what it does

### 5. Maintain Context
- Use the Memory server for persistent context
- Update AGENTS.md regularly
- Keep copilot-instructions.md current

## Getting Help

- **Documentation**: [`docs/CONFIGURATION.md`](docs/CONFIGURATION.md)
- **Troubleshooting**: See CONFIGURATION.md → Troubleshooting section
- **Examples**: Check `.github/prompts/` and `.github/instructions/`
- **TODO**: See [`TODO.md`](TODO.md) for known limitations

## What's Next?

1. **Customize for your needs**: Adjust configurations, add your own prompts
2. **Explore MCP servers**: Try each one to understand capabilities
3. **Share with your team**: Version control makes it easy
4. **Contribute improvements**: Found something useful? Add it!

## Resources

- [VS Code Copilot Docs](https://code.visualstudio.com/docs/copilot)
- [GitHub Copilot Docs](https://docs.github.com/en/copilot)
- [MCP Specification](https://modelcontextprotocol.io/)
- [Awesome MCP Servers](https://github.com/modelcontextprotocol/servers)

---

**Time to first productive use: ~5 minutes** ⚡

Ready to enhance your development workflow with AI assistance!
