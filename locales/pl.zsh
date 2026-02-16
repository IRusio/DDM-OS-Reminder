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
