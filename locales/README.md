# DDM OS Reminder - Translation Guide

This directory contains translation files for DDM OS Reminder. Each language has its own file that contains all user-facing strings.

## Adding a New Language

1. Copy `en.zsh` to a new file named with the ISO 639-1 language code (e.g., `de.zsh` for German, `es.zsh` for Spanish)
2. Translate all string values in the new file
3. **Preserve all variable placeholders** (e.g., `{ddmVersionString}`, `{loggedInUserFirstname}`)
4. **Preserve all markdown formatting** (e.g., `**bold**`, `<br>` line breaks)
5. Run validation: `zsh validate-translations.zsh`
6. Test with demo mode: `zsh ../reminderDialog.zsh demo XX` (replace XX with your language code)

## Translation Keys

### UI Elements
- `title` - Main dialog title
- `button1text` - Primary action button (Open Software Update)
- `button2text` - Secondary action button (Remind Me Later)
- `infobuttontext` - Help button text

### Warning Messages
- `excessiveUptimeWarningMessage` - Shown when Mac has been on too long
- `diskSpaceWarningMessage` - Shown when disk space is low

### Update Status Messages
- `stagedUpdateMessage` - Update is fully downloaded and ready
- `partiallyStagedUpdateMessage` - Update is currently downloading
- `pendingDownloadMessage` - Update will begin downloading soon

### Complex Messages
- `message` - Main dialog message body (long, with many placeholders)
- `infobox` - Information sidebar showing system details
- `helpmessage` - Help dialog content with support information

### Support Information
- `supportKB` - Knowledge base article title
- `supportKBURL` - Markdown link to KB article

## Variable Placeholders

Placeholders are replaced at runtime with dynamic values. **Do not translate these:**

- `{titleMessageUpdateOrUpgrade}` - "Update" or "Upgrade" depending on macOS version change
- `{titleMessageUpdateOrUpgrade:l}` - Lowercase version of above
- `{weekday}` - Current day of week
- `{loggedInUserFirstname}` - User's first name
- `{ddmVersionString}` - Required macOS version (e.g., "15.3")
- `{updateReadyMessage}` - Dynamic message about update staging status
- `{button1text}` - Reference to button1 text
- `{button2text}` - Reference to button2 text
- `{softwareUpdateButtonText}` - Button text in System Settings
- `{ddmEnforcedInstallDateHumanReadable}` - Deadline in human-readable format
- `{excessiveUptimeWarningMessage}` - Dynamically inserted warning
- `{diskSpaceWarningMessage}` - Dynamically inserted warning
- `{supportTeamName}` - IT support team name
- `{uptimeHumanReadable}` - How long Mac has been on
- `{diskSpaceHumanReadable}` - Available disk space
- `{installedmacOSVersion}` - Currently installed macOS version
- `{ddmVersionStringDeadlineHumanReadable}` - Deadline date/time
- `{ddmVersionStringDaysRemaining}` - Days until deadline
- `{supportTeamPhone}` - IT support phone number
- `{supportTeamEmail}` - IT support email
- `{supportTeamWebsite}` - IT support website
- `{supportKBURL}` - Knowledge base article URL
- `{userfullname}` - User's full name
- `{username}` - User's username
- `{computername}` - Computer hostname
- `{serialnumber}` - Mac serial number
- `{osversion}` - Current macOS version string
- `{dialogVersion}` - swiftDialog version
- `{scriptVersion}` - Script version

## Markdown Formatting

Translations use markdown for formatting. Common patterns:

- `**text**` - Bold text
- `<br>` - Line break
- `<br><br>` - Paragraph break
- `[Link Text](https://url)` - Hyperlink

## Testing Your Translation

### Demo Mode
Test your translation with demo mode:
```bash
cd /path/to/DDM-OS-Reminder
zsh reminderDialog.zsh demo XX
```
Replace `XX` with your language code (e.g., `pl` for Polish).

### Validation
Validate your translation file:
```bash
cd locales
zsh validate-translations.zsh
```

This checks for:
- Missing keys
- Extra keys not in English
- Proper file structure

### System Language Testing
To test with actual system language detection:
1. Change your Mac's language in System Settings
2. Run: `zsh reminderDialog.zsh demo`
3. Verify it loads your translation

## Supported Languages

Currently supported languages:
- **en** - English (base language)
- **pl** - Polish (Polski)

To add your language, follow the steps in "Adding a New Language" above.

## Translation Guidelines

1. **Tone**: Professional but friendly
2. **Length**: Try to keep similar length to English where possible
3. **Technical Terms**: macOS, Mac, DDM - do not translate these
4. **Placeholders**: Never translate, always preserve exactly
5. **Markdown**: Preserve all formatting tags
6. **Context**: The dialog appears when a Mac needs a system update

## Example Translation Snippet

English (`en.zsh`):
```zsh
["title"]="macOS {titleMessageUpdateOrUpgrade} Required"
["button1text"]="Open Software Update"
```

Polish (`pl.zsh`):
```zsh
["title"]="Wymagana aktualizacja macOS {titleMessageUpdateOrUpgrade}"
["button1text"]="Otwórz Aktualizację Oprogramowania"
```

Notice how:
- The placeholder `{titleMessageUpdateOrUpgrade}` is preserved
- "macOS" is not translated
- The meaning is adapted to Polish grammar

## Getting Help

- See main [README.md](../README.md) for project overview
- Report translation issues at https://github.com/dan-snelson/DDM-OS-Reminder/issues
- Discuss translations in [#ddm-os-reminders](https://macadmins.slack.com/archives/C09LVE2NVML) on Mac Admins Slack
