# Bash Alias Manager

A Claude Code-powered tool for managing bash aliases systematically.

## Purpose

This repository provides a structured workflow for managing bash aliases located at `~/.bash_aliases`. It enables:

- **Adding** new aliases following common conventions
- **Editing** existing aliases
- **Deleting** or pruning unused aliases
- **Ideating** useful alias patterns based on community best practices
- **Backing up** alias configurations with timestamps

## Workflow

When making changes to bash aliases, the tool:

1. Researches common conventions when requested
2. Updates `~/.bash_aliases`
3. Tests changes by sourcing bash
4. Triggers YADM push to sync dotfiles

## Backups

Timestamped backups of `~/.bash_aliases` are stored in the `backups/` directory (git-ignored) for easy recovery.

## Usage

Run Claude Code in this repository and request alias management operations:

```bash
claude code
```

Example prompts:
- "Add an alias to recurse to the root of a git project"
- "Show me all aliases related to git"
- "Remove duplicate or conflicting aliases"
- "What are common aliases for docker commands?"

## Requirements

- Bash shell
- YADM (dotfiles manager)
- Claude Code CLI

## Author

Daniel Rosehill