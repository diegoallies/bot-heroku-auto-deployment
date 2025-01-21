#!/bin/bash

# Script to Deploy to Heroku Automatically
# Dynamically prompts the user for inputs

# Inform user about Heroku naming rules
echo "Note: Heroku app name must be lowercase and contain only letters, digits, and dashes."
echo "Heroku app name must start with a letter, end with a letter or digit."

# Prompt for Heroku app name
read -p "Enter your Heroku App Name: " APP_NAME
APP_NAME=$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]')  # Convert to lowercase

# Prompt for Heroku email
read -p "Enter your Heroku Email: " HEROKU_EMAIL

# Prompt for Heroku API Key
read -sp "Enter your Heroku API Key (Optional): " HEROKU_API_KEY
echo ""

# Prompt for Git commit message
read -p "Enter Git Commit Message: " GIT_COMMIT_MSG

# Prompt for Git branch name (default: master)
read -p "Enter Git Branch Name (default: master): " GIT_BRANCH
GIT_BRANCH=${GIT_BRANCH:-master}

# Prompt for environment variables (optional)
read -p "Enter SESSION_ID (or leave blank): " SESSION_ID
read -p "Enter BOT_NAME (or leave blank): " BOT_NAME
read -p "Enter OWNER_NUMBER (or leave blank): " OWNER_NUMBER
read -p "Enter OWNER_NAME (or leave blank): " OWNER_NAME

# 1. Initialize a new Git repository
echo "Initializing a new Git repository..."
git init

# 2. Add all files to Git
echo "Adding files to Git..."
git add .

# 3. Create a commit
echo "Creating commit..."
git commit -m "$GIT_COMMIT_MSG"

# 4. Log in to Heroku (if not logged in already)
echo "Logging in to Heroku..."
heroku login

# 5. Create a new Heroku app
echo "Creating new Heroku app with name '$APP_NAME'..."
heroku create "$APP_NAME"

# 6. Add Heroku remote
echo "Adding Heroku remote..."
git remote add heroku https://git.heroku.com/"$APP_NAME".git

# 7. Push changes to Heroku (Deploy the app)
echo "Pushing code to Heroku..."
git push heroku "$GIT_BRANCH":master --force

# 8. Set all environment variables on Heroku
echo "Setting Heroku environment variables..."

# Set all user-defined environment variables
[ -n "$SESSION_ID" ] && heroku config:set SESSION_ID="$SESSION_ID" --app "$APP_NAME"
[ -n "$BOT_NAME" ] && heroku config:set BOT_NAME="$BOT_NAME" --app "$APP_NAME"
[ -n "$OWNER_NUMBER" ] && heroku config:set OWNER_NUMBER="$OWNER_NUMBER" --app "$APP_NAME"
[ -n "$OWNER_NAME" ] && heroku config:set OWNER_NAME="$OWNER_NAME" --app "$APP_NAME"

# Set default config variables
heroku config:set PREFIX="." --app "$APP_NAME"
heroku config:set CUSTOM_REACT="false" --app "$APP_NAME"
heroku config:set CUSTOM_REACT_EMOJIS="💝,💖,💗,❤️‍🩹,❤️,🧡,💛,💚,💙,💜,🤎,🖤,🤍" --app "$APP_NAME"
heroku config:set DELETE_LINKS="false" --app "$APP_NAME"
heroku config:set DESCRIPTION="*© Gᴇɴᴇʀᴀᴛᴇᴅ ʙʏ Encrypto-27*" --app "$APP_NAME"
heroku config:set ALIVE_IMG="https://i.ibb.co/Hr5gqMN/IMG-20250120-WA0066.jpg" --app "$APP_NAME"
heroku config:set LIVE_MSG="> [🎐] ENCRYPTO-27-AI ɪs ᴏɴʟɪɴᴇ*⚡" --app "$APP_NAME"
heroku config:set READ_MESSAGE="false" --app "$APP_NAME"
heroku config:set AUTO_REACT="false" --app "$APP_NAME"
heroku config:set ANTI_BAD="false" --app "$APP_NAME"
heroku config:set AUTO_STATUS_SEEN="true" --app "$APP_NAME"
heroku config:set AUTO_STATUS_REPLY="false" --app "$APP_NAME"
heroku config:set AUTO_STATUS_MSG="*[❄️] Hi there, 𝔼ℕℂℝ𝕐ℙ𝕋𝕆-𝟚𝟟 𝔸𝕀 𝔹𝕆𝕋 has viewed your Status🎐*" --app "$APP_NAME"
heroku config:set MODE="public" --app "$APP_NAME"
heroku config:set ANTI_LINK="true" --app "$APP_NAME"
heroku config:set AUTO_VOICE="true" --app "$APP_NAME"
heroku config:set AUTO_STICKER="true" --app "$APP_NAME"
heroku config:set AUTO_REPLY="true" --app "$APP_NAME"
heroku config:set ALWAYS_ONLINE="true" --app "$APP_NAME"
heroku config:set PUBLIC_MODE="true" --app "$APP_NAME"
heroku config:set AUTO_TYPING="true" --app "$APP_NAME"
heroku config:set READ_CMD="true" --app "$APP_NAME"
heroku config:set AUTO_RECORDING="true" --app "$APP_NAME"

# 9. Open the app in the browser (optional)
echo "Opening app in browser..."
heroku open --app "$APP_NAME"

echo "All tasks completed successfully!"
