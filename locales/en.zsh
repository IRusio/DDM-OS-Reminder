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
