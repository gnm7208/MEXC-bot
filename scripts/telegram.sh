#!/usr/bin/env bash
# Telegram notification wrapper. Sends a message to a Telegram chat via Bot API.
# Usage: bash scripts/telegram.sh "<message>"
#        echo "<message>" | bash scripts/telegram.sh
#
# Required env vars (set as cloud routine environment variables):
#   TELEGRAM_BOT_TOKEN — get from @BotFather: /newbot
#   TELEGRAM_CHAT_ID   — your personal chat ID; DM @userinfobot to find it
#
# Setup (one-time):
#   1. Message @BotFather on Telegram → /newbot → copy the token
#   2. Message @userinfobot → copy your chat ID (a number like 123456789)
#   3. Add TELEGRAM_BOT_TOKEN and TELEGRAM_CHAT_ID to cloud routine environment variables
#
# Falls back silently if credentials are unset — never breaks a routine.
set -euo pipefail

if [[ $# -gt 0 ]]; then
  msg="$*"
else
  msg="$(cat)"
fi

if [[ -z "${msg// /}" ]]; then
  echo "usage: bash scripts/telegram.sh \"<message>\"" >&2
  exit 1
fi

if [[ -z "${TELEGRAM_BOT_TOKEN:-}" || -z "${TELEGRAM_CHAT_ID:-}" ]]; then
  echo "[telegram] TELEGRAM_BOT_TOKEN or TELEGRAM_CHAT_ID not set — skipping"
  exit 0
fi

stamp="$(date '+%Y-%m-%d %H:%M %Z')"
full_msg="${stamp}: ${msg}"

# Telegram message length limit is 4096 chars; truncate if needed
if [[ ${#full_msg} -gt 4000 ]]; then
  full_msg="${full_msg:0:4000}...[truncated]"
fi

response=$(curl -fsS -X POST \
  "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
  -d "chat_id=${TELEGRAM_CHAT_ID}" \
  --data-urlencode "text=${full_msg}" \
  -d "parse_mode=Markdown" \
  2>&1) || {
  echo "[telegram] send failed: $response"
  exit 0  # never block a routine due to telegram failure
}

echo "[telegram] sent"
