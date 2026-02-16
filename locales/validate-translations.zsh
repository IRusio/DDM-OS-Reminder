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
declare -A englishKeys=("${(@kv)translations}")

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
