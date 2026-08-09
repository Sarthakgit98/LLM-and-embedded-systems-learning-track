#!/usr/bin/env bash
#
# git-sync.sh — helper for the Learning Plans repo
#
# Usage:
#   ./git-sync.sh push [message]   Stage all changes, commit, push to GitHub
#   ./git-sync.sh sync             Fetch remote, then rebase local work onto origin/<branch>
#   ./git-sync.sh status           Show working-tree status vs remote
#
# Notes:
#   - Always operates on the branch you are currently on (defaults to main).
#   - 'sync' prefers rebase (linear history). If you have no local commits
#     but are behind, it fast-forwards instead.
#   - If you are BOTH ahead and behind, 'sync' rebases your local commits on
#     top of the remote ones — resolve conflicts if any, then ./git-sync.sh push.

set -euo pipefail
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

REMOTE="${GIT_REMOTE:-origin}"
BRANCH="$(git symbolic-ref --short HEAD 2>/dev/null || echo main)"

usage() {
  sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'
  exit 1
}

case "${1:-}" in
  push)
    MSG="${2:-}"
    git add -A
    if git diff --cached --quiet; then
      echo "✔ Nothing to commit — working tree clean."
    else
      if [[ -z "$MSG" ]]; then
        MSG="update learning plan materials ($(date '+%Y-%m-%d %H:%M'))"
      fi
      git commit -m "$MSG"
      echo "✔ Committed: $MSG"
    fi
    echo "→ Pushing to ${REMOTE}/${BRANCH} ..."
    git push "$REMOTE" "$BRANCH"
    echo "✔ Push complete."
    ;;

  sync|rebase)
    echo "→ Fetching ${REMOTE} ..."
    git fetch "$REMOTE"
    status="$(git status -sb | head -1)"
    if [[ "$status" == *"$BRANCH"* && "$status" == *"[ahead"* ]]; then
      echo "→ Local commits ahead of ${REMOTE}/${BRANCH}; rebasing ..."
      git rebase "$REMOTE/$BRANCH"
      echo "✔ Rebase complete. Run ./git-sync.sh push to publish."
    elif [[ "$status" == *"[behind"* ]]; then
      echo "→ Behind ${REMOTE}/${BRANCH}; fast-forwarding ..."
      git pull --ff-only "$REMOTE" "$BRANCH"
      echo "✔ Up to date."
    else
      echo "✔ Already up to date."
    fi
    ;;

  status)
    git fetch "$REMOTE" --quiet
    git status -sb
    echo ""
    git log --oneline --left-right --graph "${REMOTE}/${BRANCH}...HEAD" 2>/dev/null | head -10 || true
    ;;

  *)
    usage
    ;;
esac
