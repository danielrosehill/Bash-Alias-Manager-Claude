#!/bin/bash

# Bash Alias Backup Script
# Creates timestamped backups of ~/.bash_aliases

set -e  # Exit on error

# Configuration
ALIASES_FILE="$HOME/.bash_aliases"
BACKUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/bash_aliases_${TIMESTAMP}.backup"

# Maximum number of backups to keep (set to 0 to keep all)
MAX_BACKUPS=10

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored messages
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check if .bash_aliases exists
if [[ ! -f "$ALIASES_FILE" ]]; then
    print_error "Aliases file not found at: $ALIASES_FILE"
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create backup
cp "$ALIASES_FILE" "$BACKUP_FILE"
print_success "Backup created: $BACKUP_FILE"

# Count number of aliases
ALIAS_COUNT=$(grep -c "^alias " "$ALIASES_FILE" || echo "0")
print_success "Backed up $ALIAS_COUNT aliases"

# Clean up old backups if MAX_BACKUPS is set
if [[ $MAX_BACKUPS -gt 0 ]]; then
    BACKUP_COUNT=$(ls -1 "$BACKUP_DIR"/bash_aliases_*.backup 2>/dev/null | wc -l)

    if [[ $BACKUP_COUNT -gt $MAX_BACKUPS ]]; then
        REMOVE_COUNT=$((BACKUP_COUNT - MAX_BACKUPS))
        print_warning "Found $BACKUP_COUNT backups, removing oldest $REMOVE_COUNT..."

        # Remove oldest backups
        ls -1t "$BACKUP_DIR"/bash_aliases_*.backup | tail -n "$REMOVE_COUNT" | xargs rm -f
        print_success "Cleanup complete. Keeping $MAX_BACKUPS most recent backups"
    fi
fi

# Display backup info
BACKUP_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
print_success "Backup size: $BACKUP_SIZE"

echo ""
echo "Backup location: $BACKUP_FILE"
