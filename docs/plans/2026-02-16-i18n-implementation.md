# Internationalization (i18n) Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add automatic language detection and translation support for DDM OS Reminder prompts and messages.

**Architecture:** Three-layer system with language files (locales/*.zsh), automatic language detection via AppleLocale, and MDM plist override support. English and Polish translations at launch.

**Tech Stack:** Zsh shell scripting, macOS defaults command, associative arrays

---

## Task 1: Create Locales Directory Structure

**Files:**
- Create: `locales/`
- Create: `locales/en.zsh`

**Step 1: Create locales directory**

Run: `mkdir -p locales`
Expected: Directory created successfully

**Step 2: Create English translation file**

Create `locales/en.zsh` with the following content:

```zsh
#!/bin/zsh
# English translations for DDM OS Reminder
# This file contains all user-facing strings that can be localized

declare -A translations=(
    # UI Text
    ["title"]="macOS {titleMessageUpdateOrUpgrade} Required"
    ["button1text"]="Open Software Update"
    ["button2text"]="Remind Me Later"
    ["infobuttontext"]="Update macOS on Mac"

    # Warning Messages
    ["excessiveUptimeWarningMessage"]="<br><br>**Note:** Your Mac has been powered-on for **{uptimeHumanReadable}**. For more reliable results, please manually restart your Mac before proceeding."
    ["diskSpaceWarningMessage"]="<br><br>**Note:** Your Mac has only **{diskSpaceHumanReadable}**, which may prevent this macOS {titleMessageUpdateOrUpgrade:l}."

    # Update Staging Messages
    ["stagedUpdateMessage"]="<br><br>**Good news!** The macOS {ddmVersionString} update has already been downloaded to your Mac and is ready to install. Installation will proceed quickly when you click **{button1text}**."
    ["partiallyStagedUpdateMessage"]="<br><br>Your Mac has begun downloading and preparing required macOS update components. Installation will be quicker once all assets have finished staging."
    ["pendingDownloadMessage"]="<br><br>Your Mac will begin downloading the update shortly."

    # Complex UI Text
    ["message"]="**A required macOS {titleMessageUpdateOrUpgrade:l} is now available**<br><br>Happy {weekday}, {loggedInUserFirstname}!<br><br>Please {titleMessageUpdateOrUpgrade:l} to macOS **{ddmVersionString}** to ensure your Mac remains secure and compliant with organizational policies.{updateReadyMessage}<br><br>To perform the {titleMessageUpdateOrUpgrade:l} now, click **{button1text}**, review the on-screen instructions, then click **{softwareUpdateButtonText}**.<br><br>If you are unable to perform this {titleMessageUpdateOrUpgrade:l} now, click **{button2text}** to be reminded again later (which is disabled when the deadline is imminent).<br><br>However, your device **will automatically restart and {titleMessageUpdateOrUpgrade:l}** on **{ddmEnforcedInstallDateHumanReadable}** if you have not {titleMessageUpdateOrUpgrade:l}d before the deadline.{excessiveUptimeWarningMessage}{diskSpaceWarningMessage}<br><br>For assistance, please contact **{supportTeamName}** by clicking the (?) button in the bottom, right-hand corner."
    ["infobox"]="**Current:** macOS {installedmacOSVersion}<br><br>**Required:** macOS {ddmVersionString}<br><br>**Deadline:** {ddmVersionStringDeadlineHumanReadable}<br><br>**Day(s) Remaining:** {ddmVersionStringDaysRemaining}<br><br>**Last Restart:** {uptimeHumanReadable}<br><br>**Free Disk Space:** {diskSpaceHumanReadable}"
    ["helpmessage"]="For assistance, please contact: **{supportTeamName}**<br>- **Telephone:** {supportTeamPhone}<br>- **Email:** {supportTeamEmail}<br>- **Website:** {supportTeamWebsite}<br>- **Knowledge Base Article:** {supportKBURL}<br><br>**User Information:**<br>- **Full Name:** {userfullname}<br>- **User Name:** {username}<br><br>**Computer Information:**<br>- **Computer Name:** {computername}<br>- **Serial Number:** {serialnumber}<br>- **macOS:** {osversion}<br><br>**Script Information:**<br>- **Dialog:** {dialogVersion}<br>- **Script:** {scriptVersion}<br>"

    # Support Information
    ["supportKB"]="Update macOS on Mac"
    ["supportKBURL"]="[Update macOS on Mac](https://support.apple.com/108382)"
)
```

**Step 3: Verify file creation**

Run: `ls -la locales/`
Expected: Shows `en.zsh` file

**Step 4: Commit**

```bash
git add locales/en.zsh
git commit -m "feat(i18n): add English translation file

Extract all user-facing strings into locales/en.zsh"
```

---

## Task 2: Create Polish Translation File

**Files:**
- Create: `locales/pl.zsh`

**Step 1: Create Polish translation file**

Create `locales/pl.zsh` with Polish translations:

```zsh
#!/bin/zsh
# Polish translations for DDM OS Reminder
# Polskie tłumaczenia dla DDM OS Reminder

declare -A translations=(
    # UI Text
    ["title"]="Wymagana aktualizacja macOS {titleMessageUpdateOrUpgrade}"
    ["button1text"]="Otwórz Aktualizację Oprogramowania"
    ["button2text"]="Przypomnij Mi Później"
    ["infobuttontext"]="Zaktualizuj macOS na Mac"

    # Warning Messages
    ["excessiveUptimeWarningMessage"]="<br><br>**Uwaga:** Twój Mac jest włączony od **{uptimeHumanReadable}**. Aby uzyskać bardziej niezawodne wyniki, należy ręcznie uruchomić ponownie Mac przed kontynuowaniem."
    ["diskSpaceWarningMessage"]="<br><br>**Uwaga:** Twój Mac ma tylko **{diskSpaceHumanReadable}**, co może uniemożliwić tę aktualizację macOS {titleMessageUpdateOrUpgrade:l}."

    # Update Staging Messages
    ["stagedUpdateMessage"]="<br><br>**Dobra wiadomość!** Aktualizacja macOS {ddmVersionString} została już pobrana na Twojego Maca i jest gotowa do zainstalowania. Instalacja będzie przebiegać szybko po kliknięciu **{button1text}**."
    ["partiallyStagedUpdateMessage"]="<br><br>Twój Mac rozpoczął pobieranie i przygotowywanie wymaganych komponentów aktualizacji macOS. Instalacja będzie szybsza po zakończeniu pobierania wszystkich zasobów."
    ["pendingDownloadMessage"]="<br><br>Twój Mac wkrótce rozpocznie pobieranie aktualizacji."

    # Complex UI Text
    ["message"]="**Dostępna jest wymagana aktualizacja macOS {titleMessageUpdateOrUpgrade:l}**<br><br>Wesołych {weekday}, {loggedInUserFirstname}!<br><br>Zaktualizuj do macOS **{ddmVersionString}**, aby zapewnić, że Twój Mac pozostanie bezpieczny i zgodny z zasadami organizacji.{updateReadyMessage}<br><br>Aby przeprowadzić {titleMessageUpdateOrUpgrade:l} teraz, kliknij **{button1text}**, przejrzyj instrukcje wyświetlane na ekranie, a następnie kliknij **{softwareUpdateButtonText}**.<br><br>Jeśli nie możesz teraz wykonać tej {titleMessageUpdateOrUpgrade:l}, kliknij **{button2text}**, aby otrzymać przypomnienie później (co jest wyłączone, gdy termin jest bliski).<br><br>Twoje urządzenie **automatycznie uruchomi się ponownie i zaktualizuje** w dniu **{ddmEnforcedInstallDateHumanReadable}**, jeśli nie zaktualizujesz przed terminem.{excessiveUptimeWarningMessage}{diskSpaceWarningMessage}<br><br>Aby uzyskać pomoc, skontaktuj się z **{supportTeamName}**, klikając przycisk (?) w prawym dolnym rogu."
    ["infobox"]="**Obecny:** macOS {installedmacOSVersion}<br><br>**Wymagany:** macOS {ddmVersionString}<br><br>**Termin:** {ddmVersionStringDeadlineHumanReadable}<br><br>**Pozostało dni:** {ddmVersionStringDaysRemaining}<br><br>**Ostatni restart:** {uptimeHumanReadable}<br><br>**Wolne miejsce na dysku:** {diskSpaceHumanReadable}"
    ["helpmessage"]="Aby uzyskać pomoc, skontaktuj się z: **{supportTeamName}**<br>- **Telefon:** {supportTeamPhone}<br>- **Email:** {supportTeamEmail}<br>- **Strona internetowa:** {supportTeamWebsite}<br>- **Artykuł bazy wiedzy:** {supportKBURL}<br><br>**Informacje o użytkowniku:**<br>- **Imię i nazwisko:** {userfullname}<br>- **Nazwa użytkownika:** {username}<br><br>**Informacje o komputerze:**<br>- **Nazwa komputera:** {computername}<br>- **Numer seryjny:** {serialnumber}<br>- **macOS:** {osversion}<br><br>**Informacje o skrypcie:**<br>- **Dialog:** {dialogVersion}<br>- **Skrypt:** {scriptVersion}<br>"

    # Support Information
    ["supportKB"]="Zaktualizuj macOS na Mac"
    ["supportKBURL"]="[Zaktualizuj macOS na Mac](https://support.apple.com/108382)"
)
```

**Step 2: Verify file creation**

Run: `ls -la locales/`
Expected: Shows both `en.zsh` and `pl.zsh` files

**Step 3: Commit**

```bash
git add locales/pl.zsh
git commit -m "feat(i18n): add Polish translation file

Add complete Polish translations for all user-facing strings"
```

---

## Task 3: Implement loadTranslations Function

**Files:**
- Modify: `reminderDialog.zsh:204-250` (after DDM Version Validation function, before preference functions)

**Step 1: Add loadTranslations function**

Add this function after the `isValidDDMVersionString()` function (around line 250):

```zsh
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Load Translations based on system language
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

function loadTranslations() {
    local systemLocale=$(defaults read -g AppleLocale 2>/dev/null || echo "en_US")
    local langCode="${systemLocale:0:2}"
    local scriptDirectory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local langFile="${scriptDirectory}/locales/${langCode}.zsh"

    # Load English baseline (always available)
    if [[ -f "${scriptDirectory}/locales/en.zsh" ]]; then
        source "${scriptDirectory}/locales/en.zsh"
        declare -A englishTranslations=("${(@kv)translations}")
    else
        error "Missing English translation file: ${scriptDirectory}/locales/en.zsh"
        return 1
    fi

    # Load target language if not English
    if [[ "${langCode}" != "en" && -f "${langFile}" ]]; then
        source "${langFile}"
        info "Loaded translations for language: ${langCode}"

        # Check for missing translations and use English fallback
        for key in "${(@k)englishTranslations}"; do
            if [[ -z "${translations[$key]}" ]]; then
                warning "Missing translation for '${key}' in ${langCode}, using English"
                translations[$key]="${englishTranslations[$key]}"
            fi
        done
    else
        if [[ "${langCode}" != "en" ]]; then
            notice "Language '${langCode}' not available, using English"
        fi
        # Use English translations
        declare -A translations=("${(@kv)englishTranslations}")
    fi

    # Merge translations into preferenceConfiguration
    # Only override the string keys that have translations
    for key in "${(@k)translations}"; do
        if [[ -n "${preferenceConfiguration[$key]}" ]]; then
            preferenceConfiguration[$key]="string|${translations[$key]}"
        fi
    done
}
```

**Step 2: Verify function added**

Run: `grep -n "^function loadTranslations" reminderDialog.zsh`
Expected: Shows line number where function is defined

**Step 3: Commit**

```bash
git add reminderDialog.zsh
git commit -m "feat(i18n): implement loadTranslations function

Add function to detect system language, load appropriate
translation file, and merge into preferenceConfiguration"
```

---

## Task 4: Integrate loadTranslations Into Script Flow

**Files:**
- Modify: `reminderDialog.zsh:1310` (where loadPreferenceOverrides is called)

**Step 1: Call loadTranslations before loadPreferenceOverrides**

Find the section around line 1310 that has:
```zsh
loadPreferenceOverrides
```

Change it to:
```zsh
loadTranslations

loadPreferenceOverrides
```

This ensures translations load first, then plist overrides can supersede them.

**Step 2: Verify the change**

Run: `grep -A1 "^loadTranslations" reminderDialog.zsh | grep -v "^function"`
Expected: Shows `loadTranslations` followed by empty line or `loadPreferenceOverrides`

**Step 3: Test basic functionality**

Run: `zsh reminderDialog.zsh demo`
Expected: Script runs without errors (should see English by default)

**Step 4: Commit**

```bash
git add reminderDialog.zsh
git commit -m "feat(i18n): integrate loadTranslations into script flow

Call loadTranslations before loadPreferenceOverrides to apply
translations while preserving plist override capability"
```

---

## Task 5: Enhance Demo Mode for Language Testing

**Files:**
- Modify: `reminderDialog.zsh:1334` (demo mode section)

**Step 1: Add language parameter support to demo mode**

Find the demo mode section (around line 1334):
```zsh
if [[ "${1}" == "demo" ]]; then
```

Change it to support a second parameter for language override:
```zsh
if [[ "${1}" == "demo" ]]; then

    notice "Demo mode enabled"

    # Check if a language code was specified as second parameter
    if [[ -n "${2}" ]]; then
        demoLangOverride="${2}"
        notice "Demo language override: ${demoLangOverride}"
        # Temporarily override AppleLocale for this demo run
        export DEMO_LANG="${demoLangOverride}"
    fi
```

**Step 2: Update loadTranslations to respect demo override**

In the `loadTranslations()` function, change the first line:
```zsh
local systemLocale=$(defaults read -g AppleLocale 2>/dev/null || echo "en_US")
```

To:
```zsh
local systemLocale="${DEMO_LANG:-$(defaults read -g AppleLocale 2>/dev/null || echo "en_US")}"
```

**Step 3: Test English demo**

Run: `zsh reminderDialog.zsh demo en`
Expected: Dialog shows in English

**Step 4: Test Polish demo**

Run: `zsh reminderDialog.zsh demo pl`
Expected: Dialog shows in Polish (if Polish translations are correct)

**Step 5: Test default demo**

Run: `zsh reminderDialog.zsh demo`
Expected: Dialog shows in system language

**Step 6: Commit**

```bash
git add reminderDialog.zsh
git commit -m "feat(i18n): enhance demo mode for language testing

Allow demo mode to accept language code parameter:
  zsh reminderDialog.zsh demo pl"
```

---

## Task 6: Create Translation Validation Script

**Files:**
- Create: `locales/validate-translations.zsh`

**Step 1: Create validation script**

Create `locales/validate-translations.zsh`:

```zsh
#!/bin/zsh
# Validation script for DDM OS Reminder translations
# Checks that all language files have the required keys

set -euo pipefail

scriptDir="$(cd "$(dirname "${0}")" && pwd)"
exitCode=0

# Load English as baseline
if [[ ! -f "${scriptDir}/en.zsh" ]]; then
    echo "ERROR: Missing English baseline: ${scriptDir}/en.zsh"
    exit 1
fi

source "${scriptDir}/en.zsh"
declare -A englishKeys=("${(@k)translations}")

echo "Validating translations against English baseline..."
echo "English translation keys: ${#englishKeys[@]}"
echo ""

# Check each language file
for langFile in "${scriptDir}"/*.zsh; do
    langFileName="$(basename "${langFile}")"

    # Skip English and this validation script
    if [[ "${langFileName}" == "en.zsh" || "${langFileName}" == "validate-translations.zsh" ]]; then
        continue
    fi

    langCode="${langFileName%.zsh}"
    echo "Checking ${langCode}..."

    # Source the language file
    source "${langFile}"

    # Check for missing keys
    missingKeys=()
    for key in "${(@k)englishKeys}"; do
        if [[ -z "${translations[$key]}" ]]; then
            missingKeys+=("${key}")
        fi
    done

    # Check for extra keys
    extraKeys=()
    for key in "${(@k)translations}"; do
        if [[ -z "${englishKeys[$key]}" ]]; then
            extraKeys+=("${key}")
        fi
    done

    # Report results
    if [[ ${#missingKeys[@]} -gt 0 ]]; then
        echo "  ❌ Missing keys: ${missingKeys[@]}"
        exitCode=1
    fi

    if [[ ${#extraKeys[@]} -gt 0 ]]; then
        echo "  ⚠️  Extra keys (not in English): ${extraKeys[@]}"
    fi

    if [[ ${#missingKeys[@]} -eq 0 && ${#extraKeys[@]} -eq 0 ]]; then
        echo "  ✅ All keys present and valid"
    fi

    echo ""
done

if [[ ${exitCode} -eq 0 ]]; then
    echo "✅ All translations validated successfully"
else
    echo "❌ Translation validation failed"
fi

exit ${exitCode}
```

**Step 2: Make script executable**

Run: `chmod +x locales/validate-translations.zsh`
Expected: Script is now executable

**Step 3: Test validation script**

Run: `zsh locales/validate-translations.zsh`
Expected: Shows validation results for all language files

**Step 4: Commit**

```bash
git add locales/validate-translations.zsh
git commit -m "feat(i18n): add translation validation script

Validates that all language files contain required keys
and identifies missing or extra keys"
```

---

## Task 7: Update assemble.zsh to Include Locales

**Files:**
- Modify: `assemble.zsh:~40-50` (around baseScript/messageScript definitions)

**Step 1: Read current assemble.zsh to understand structure**

Run: `grep -n "messageScript=" assemble.zsh`
Expected: Shows line where messageScript is defined

**Step 2: Find where files are embedded**

Run: `grep -n "cat.*messageScript" assemble.zsh | head -5`
Expected: Shows where messageScript is embedded into output

**Step 3: Add logic to embed locale files**

Find the section where the script embeds `reminderDialog.zsh` (search for line that reads from `messageScript`).

Before that section, add code to embed locale files:

```zsh
# Embed locale files
info "Embedding locale files..."
echo "" >> "${tmpScript}"
echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #" >> "${tmpScript}"
echo "# Embedded Locale Files" >> "${tmpScript}"
echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #" >> "${tmpScript}"
echo "" >> "${tmpScript}"

# Create locale directory at runtime
echo 'localeDir="/tmp/ddm-os-reminder-locales-$$"' >> "${tmpScript}"
echo 'mkdir -p "${localeDir}"' >> "${tmpScript}"
echo "" >> "${tmpScript}"

# Embed each locale file as a here-document
for localeFile in "${projectDir}/locales"/*.zsh; do
    if [[ -f "${localeFile}" ]]; then
        localeFileName="$(basename "${localeFile}")"
        echo "# Embed ${localeFileName}" >> "${tmpScript}"
        echo "cat > \"\${localeDir}/${localeFileName}\" <<'LOCALE_FILE_EOF'" >> "${tmpScript}"
        cat "${localeFile}" >> "${tmpScript}"
        echo "LOCALE_FILE_EOF" >> "${tmpScript}"
        echo "" >> "${tmpScript}"
    fi
done

echo "" >> "${tmpScript}"
```

**Step 4: Update loadTranslations to use runtime locale directory**

In reminderDialog.zsh, update the `loadTranslations()` function to check for the runtime locale directory first:

```zsh
function loadTranslations() {
    local systemLocale="${DEMO_LANG:-$(defaults read -g AppleLocale 2>/dev/null || echo "en_US")}"
    local langCode="${systemLocale:0:2}"
    local scriptDirectory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # Check for embedded locale files first (when running assembled script)
    local localeBaseDir
    if [[ -d "/tmp/ddm-os-reminder-locales-$$" ]]; then
        localeBaseDir="/tmp/ddm-os-reminder-locales-$$"
    elif [[ -d "${scriptDirectory}/locales" ]]; then
        localeBaseDir="${scriptDirectory}/locales"
    else
        error "No locale directory found"
        return 1
    fi

    local langFile="${localeBaseDir}/${langCode}.zsh"

    # Load English baseline (always available)
    if [[ -f "${localeBaseDir}/en.zsh" ]]; then
        source "${localeBaseDir}/en.zsh"
        declare -A englishTranslations=("${(@kv)translations}")
    else
        error "Missing English translation file: ${localeBaseDir}/en.zsh"
        return 1
    fi

    # ... rest of function remains the same
}
```

**Step 5: Test assembly**

Run: `zsh assemble.zsh --help`
Expected: Shows help for assembly script

**Step 6: Commit**

```bash
git add assemble.zsh reminderDialog.zsh
git commit -m "feat(i18n): update assemble script to embed locales

Embed locale files into assembled script and update
loadTranslations to find embedded locales at runtime"
```

---

## Task 8: Create Locales README Documentation

**Files:**
- Create: `locales/README.md`

**Step 1: Create comprehensive README**

Create `locales/README.md`:

```markdown
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
```

**Step 2: Verify README created**

Run: `cat locales/README.md | head -20`
Expected: Shows first 20 lines of README

**Step 3: Commit**

```bash
git add locales/README.md
git commit -m "docs(i18n): add translation guide for locales

Comprehensive guide for adding new languages including:
- Step-by-step instructions
- Placeholder documentation
- Testing procedures
- Translation guidelines"
```

---

## Task 9: Update Main README with i18n Information

**Files:**
- Modify: `README.md:~32` (after "Demonstration Mode" in Features section)

**Step 1: Add i18n section to Features**

In the Features section of README.md (around line 32), add after Demonstration Mode:

```markdown
- **Multilingual Support**: Automatically detects and displays messages in the user's configured language (currently English and Polish, with easy extensibility for additional languages).
```

**Step 2: Add new Internationalization section**

After the "Features" section but before "Support", add:

```markdown
## Internationalization

DDM OS Reminder automatically detects your Mac's configured language and displays messages accordingly.

### Supported Languages
- **English** (en) - Default/fallback language
- **Polish** (pl) - Polski

### How It Works
The script detects the system language from `AppleLocale` settings and loads the appropriate translation file from the `locales/` directory. If a translation is unavailable, it falls back to English.

### MDM Overrides
Administrators can still override any message via Configuration Profile/plist, regardless of the detected language. This allows for organization-specific wording when needed.

### Adding New Languages
Want to contribute a translation? See [locales/README.md](locales/README.md) for detailed instructions on adding new languages.

### Testing Languages
Use demo mode to test different languages:
```bash
zsh reminderDialog.zsh demo           # Uses system language
zsh reminderDialog.zsh demo pl        # Forces Polish
zsh reminderDialog.zsh demo en        # Forces English
```
```

**Step 3: Verify README updates**

Run: `grep -n "Internationalization" README.md`
Expected: Shows line number of new section

**Step 4: Commit**

```bash
git add README.md
git commit -m "docs(i18n): update README with internationalization info

Add documentation for multilingual support including:
- Supported languages
- How language detection works
- MDM override behavior
- Adding new languages
- Testing different languages"
```

---

## Task 10: Final Testing and Validation

**Files:**
- Test: `reminderDialog.zsh`, `locales/en.zsh`, `locales/pl.zsh`

**Step 1: Run translation validation**

Run: `zsh locales/validate-translations.zsh`
Expected: `✅ All translations validated successfully`

**Step 2: Test English demo mode**

Run: `zsh reminderDialog.zsh demo en`
Expected: Dialog appears in English with all placeholders replaced correctly

**Step 3: Test Polish demo mode**

Run: `zsh reminderDialog.zsh demo pl`
Expected: Dialog appears in Polish with all placeholders replaced correctly

**Step 4: Test system language detection**

Run: `defaults read -g AppleLocale`
Expected: Shows your system locale (e.g., "en_PL")

Run: `zsh reminderDialog.zsh demo`
Expected: Dialog appears in detected language

**Step 5: Test with non-existent language**

Run: `zsh reminderDialog.zsh demo de`
Expected: Logs "Language 'de' not available, using English" and shows English dialog

**Step 6: Test assembled script**

Run: `zsh assemble.zsh your.domain --lane test`
Expected: Creates assembled script in Artifacts/ directory

Run: `zsh Artifacts/ddm-os-reminder-*.zsh demo pl`
Expected: Assembled script works with Polish language

**Step 7: Check logs for warnings**

Run: `tail -50 /var/log/org.churchofjesuschrist.log | grep -i translation`
Expected: No unexpected errors, only info/notice messages

**Step 8: Create final commit**

```bash
git add -A
git commit -m "test(i18n): verify all i18n functionality

Validated:
- Translation file completeness
- Language detection and fallback
- Demo mode with language parameters
- Assembled script with embedded locales
- Log messages for missing translations"
```

---

## Implementation Notes

### Key Design Decisions
1. **Separate files per language** - Easy to maintain and contribute
2. **English as baseline** - Always available, used for missing keys
3. **Runtime embedding** - Assembled script includes all locales
4. **Plist overrides honored** - Existing customization workflows preserved
5. **Demo mode enhanced** - Easy testing without changing system language

### Testing Checklist
- [ ] English translation file complete
- [ ] Polish translation file complete
- [ ] Validation script passes
- [ ] Demo mode works with both languages
- [ ] System language detection works
- [ ] Fallback to English works for unsupported languages
- [ ] Plist overrides still functional
- [ ] Assembled script includes locales
- [ ] Assembled script runs with translations
- [ ] All placeholders resolve correctly
- [ ] Markdown formatting renders properly

### Troubleshooting
**Problem:** "Missing English translation file" error
- **Solution:** Ensure `locales/en.zsh` exists and is readable

**Problem:** Polish shows English for some messages
- **Solution:** Check validation script output for missing keys

**Problem:** Demo mode doesn't respect language parameter
- **Solution:** Verify `DEMO_LANG` environment variable is set correctly

**Problem:** Assembled script can't find locales
- **Solution:** Check that assemble.zsh embeds locale files to `/tmp/ddm-os-reminder-locales-$$`

### Future Enhancements
- Add more languages (German, Spanish, French, Japanese, etc.)
- Per-language plist override keys (e.g., `TitlePL`, `TitleEN`)
- Regional variations (e.g., en_US vs en_GB)
- Date format localization
- Number format localization
