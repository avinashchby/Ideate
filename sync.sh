#!/usr/bin/env bash
# sync.sh — copy ideate skill files to the active Claude Code install
# Run this after pulling or editing locally: ./sync.sh

set -euo pipefail

SKILL_DIR="$HOME/.claude/skills/ideate"
SRC="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$SKILL_DIR/references"
cp "$SRC/SKILL.md" "$SKILL_DIR/SKILL.md"
cp "$SRC/references/"*.md "$SKILL_DIR/references/"

echo "✓ ideate synced → $SKILL_DIR"
