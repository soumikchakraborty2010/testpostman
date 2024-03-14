*** Settings ***
Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/printers.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/fleet/api.calls.robot
Library           ../../.././libs/UtilityFunctions.py
Resource          ../../.././libs/UtilityFunctions.py

Suite Setup       Initializing user
Test Setup        Initiate Browser
Test Teardown     Closer Browser And Log Error

*** Variables ***

@{inputcolumnnamelist}     Diagnostic Events

*** Keywords ***
Initializing user
    Set Suite Variable   ${IDP_USER}
Initiate Browser
    Select Browser    ${BROWSER_NAME}
Closer Browser And Log Error
    Console Log On Failure
    Close Browser

*** Test Cases ***
Validate diagnostic event alert from PDP
  [Documentation]    191861
  [Tags]    Full-Suite-Asset-management-ui    Go-Live-Asset-management-ui
    ${accessToken}=             Generate Root Token
    ${accountID}=               Get Account ID Based On Org Name    ${accessToken}
    ${assetInfo}=               Get Asset Info by IpAddress   ${accessToken}  ${accountID}
    ${fleetRootAdminToken}=     Generate Fleet Root Admin Token
    Delete Diagnostic Event Alert   ${fleetRootAdminToken}   ${assetInfo}
    ${alert}=                   Generate Diagnostic Event Alert   ${fleetRootAdminToken}   ${assetInfo}
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization    ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Search in Listing page  ${PRINTER_IP}
    Click ip address in grid   ${PRINTER_IP}
    Validate diagnostic event alert present in PDP    ${alert}
    Delete Diagnostic Event Alert   ${fleetRootAdminToken}   ${assetInfo}

Validate diagnostic event alert from PLP
  [Documentation]    191862
  [Tags]    Full-Suite-Asset-management-ui
    ${accessToken}=             Generate Root Token
    ${accountID}=               Get Account ID Based On Org Name    ${accessToken}
    ${assetInfo}=               Get Asset Info by IpAddress   ${accessToken}  ${accountID}
    ${fleetRootAdminToken}=     Generate Fleet Root Admin Token
    Delete Diagnostic Event Alert   ${fleetRootAdminToken}   ${assetInfo}
    ${alert}=                   Generate Diagnostic Event Alert   ${fleetRootAdminToken}   ${assetInfo}
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization    ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    From Quick View Select column     @{inputcolumnnamelist}
    Search in Listing page  ${PRINTER_IP}
    Validate Diagnostic Event Present in PLP   ${alert}
    Delete Diagnostic Event Alert   ${fleetRootAdminToken}   ${assetInfo}
    Select View    Standard

Validate Diagnostic Event Views
  [Documentation]    191863
  [Tags]    Full-Suite-Asset-management-ui
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization  ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Validate Diagnostic option in Quick view
    Validate Diagnostic option in Custom view

Validate Diagnostic Event Filter Facet
  [Documentation]    191864
  [Tags]    Full-Suite-Asset-management-ui
    ${accessToken}=             Generate Root Token
    ${accountID}=               Get Account ID Based On Org Name    ${accessToken}
    ${assetInfo}=               Get Asset Info by IpAddress   ${accessToken}  ${accountID}
    ${fleetRootAdminToken}=     Generate Fleet Root Admin Token
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization   ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
    Validate Diagnostic Event Filter facet name
    Delete Diagnostic Event Alert   ${fleetRootAdminToken}   ${assetInfo}
    Validate No Events in Filter
    ${alert}=   Generate Diagnostic Event Alert   ${fleetRootAdminToken}   ${assetInfo}
    Validate Warning in Filter
    Select Diagnostic Event Filter and validate correct IP   ${PRINTER_IP}

Validate diagnostic event job for Healthcheck
  [Documentation]    251248
  [Tags]    Full-Suite-Agent-service    Go-Live-data-processor-service    Full-Suite-data-processor-service
   ${dataset}=     Set Variable    HEALTHCHECK
   ${fleetCollectorId}=    Set Variable    10
   ${volume}=     Set Variable    1
   ${printerAccessToken}=      Generate Printer Access Token
   Generate HEALTHCHECK and HEALTHCHECK TWO data   ${printerAccessToken}   ${dataset}
   ${isDatasetAbsent}=         Check for data-set from device   ${printerAccessToken}      ${dataset}
   Skip If    ${isDatasetAbsent}     ${dataset} dataset is not present in the printer
   Set Fleet Collector Id     ${printerAccessToken}   ${fleetCollectorId}
   Set Dataset Volume level   ${printerAccessToken}   ${dataset}   ${volume}
   ${accessToken}=             Generate Root Token
   ${accountID}=               Get Account ID Based On Org Name    ${accessToken}
   ${assetInfo}=               Get Asset Info by IpAddress   ${accessToken}  ${accountID}
   Post Upload Analytics Datasets Job    ${accessToken}   ${accountID}  ${dataset}  ${assetInfo}
   ${azureBlobFileUrl}=   Validate Upload Analytics Datasets Job completion from Agent Queue   ${accessToken}   ${assetInfo}  ${dataset}
   Validate metadata from azure blob   ${azureBlobFileUrl}   ${assetInfo}  ${dataset}

Validate diagnostic event job for Healthcheck2
  [Documentation]    191866
  [Tags]    Full-Suite-Agent-service    Go-Live-data-processor-service    Full-Suite-data-processor-service
   ${dataset}=     Set Variable    HEALTHCHECK2
   ${fleetCollectorId}=    Set Variable    10
   ${volume}=     Set Variable    1
   ${printerAccessToken}=      Generate Printer Access Token
   Generate HEALTHCHECK and HEALTHCHECK TWO data   ${printerAccessToken}   ${dataset}
   ${isDatasetAbsent}=         Check for data-set from device   ${printerAccessToken}      ${dataset}
   Skip If    ${isDatasetAbsent}     ${dataset} dataset is not present in the printer
   Set Fleet Collector Id     ${printerAccessToken}   ${fleetCollectorId}
   Set Dataset Volume level   ${printerAccessToken}   ${dataset}   ${volume}
   ${accessToken}=             Generate Root Token
   ${accountID}=               Get Account ID Based On Org Name    ${accessToken}
   ${assetInfo}=               Get Asset Info by IpAddress   ${accessToken}  ${accountID}
   Post Upload Analytics Datasets Job    ${accessToken}   ${accountID}  ${dataset}  ${assetInfo}
   ${azureBlobFileUrl}=   Validate Upload Analytics Datasets Job completion from Agent Queue   ${accessToken}   ${assetInfo}  ${dataset}
   Validate metadata from azure blob   ${azureBlobFileUrl}   ${assetInfo}  ${dataset}

Validate diagnostic event job for ADS
  [Documentation]    251249
  [Tags]    Full-Suite-Agent-service    Go-Live-data-processor-service    Full-Suite-data-processor-service
   ${dataset}=     Set Variable    ADS
   ${fleetCollectorId}=    Set Variable    10
   ${volume}=     Set Variable    1
   ${printerAccessToken}=      Generate Printer Access Token
   ${isDatasetAbsent}=         Check for data-set from device   ${printerAccessToken}      ${dataset}
   Skip If    ${isDatasetAbsent}     ${dataset} dataset is not present in the printer
   Set Fleet Collector Id     ${printerAccessToken}   ${fleetCollectorId}
   Set Dataset Volume level   ${printerAccessToken}   ${dataset}   ${volume}
   ${accessToken}=             Generate Root Token
   ${accountID}=               Get Account ID Based On Org Name    ${accessToken}
   ${assetInfo}=               Get Asset Info by IpAddress   ${accessToken}  ${accountID}
   Post Upload Analytics Datasets Job    ${accessToken}   ${accountID}  ${dataset}  ${assetInfo}
   ${azureBlobFileUrl}=   Validate Upload Analytics Datasets Job completion from Agent Queue   ${accessToken}   ${assetInfo}  ${dataset}
   Validate metadata from azure blob   ${azureBlobFileUrl}   ${assetInfo}  ${dataset}

Validate diagnostic event job for BASIC
  [Documentation]    251250
  [Tags]    Full-Suite-Agent-service    Go-Live-data-processor-service    Full-Suite-data-processor-service
   ${dataset}=     Set Variable    BASIC
   ${fleetCollectorId}=    Set Variable    10
   ${volume}=     Set Variable    1
   ${printerAccessToken}=      Generate Printer Access Token
   ${isDatasetAbsent}=         Check for data-set from device   ${printerAccessToken}      ${dataset}
   Skip If    ${isDatasetAbsent}     ${dataset} dataset is not present in the printer
   Set Fleet Collector Id     ${printerAccessToken}   ${fleetCollectorId}
   Set Dataset Volume level   ${printerAccessToken}   ${dataset}   ${volume}
   ${accessToken}=             Generate Root Token
   ${accountID}=               Get Account ID Based On Org Name    ${accessToken}
   ${assetInfo}=               Get Asset Info by IpAddress   ${accessToken}  ${accountID}
   Post Upload Analytics Datasets Job    ${accessToken}   ${accountID}  ${dataset}  ${assetInfo}
   ${azureBlobFileUrl}=   Validate Upload Analytics Datasets Job completion from Agent Queue   ${accessToken}   ${assetInfo}  ${dataset}
   Validate metadata from azure blob   ${azureBlobFileUrl}   ${assetInfo}  ${dataset}

Validate diagnostic event job for SUPPLY
  [Documentation]    251251
  [Tags]    Full-Suite-Agent-service    Go-Live-data-processor-service    Full-Suite-data-processor-service
   ${dataset}=     Set Variable    SUPPLY
   ${fleetCollectorId}=    Set Variable    10
   ${volume}=     Set Variable    1
   ${printerAccessToken}=      Generate Printer Access Token
   ${isDatasetAbsent}=         Check for data-set from device   ${printerAccessToken}      ${dataset}
   Skip If    ${isDatasetAbsent}     ${dataset} dataset is not present in the printer
   Set Fleet Collector Id     ${printerAccessToken}   ${fleetCollectorId}
   Set Dataset Volume level   ${printerAccessToken}   ${dataset}   ${volume}
   ${accessToken}=             Generate Root Token
   ${accountID}=               Get Account ID Based On Org Name    ${accessToken}
   ${assetInfo}=               Get Asset Info by IpAddress   ${accessToken}  ${accountID}
   Post Upload Analytics Datasets Job    ${accessToken}   ${accountID}  ${dataset}  ${assetInfo}
   ${azureBlobFileUrl}=   Validate Upload Analytics Datasets Job completion from Agent Queue   ${accessToken}   ${assetInfo}  ${dataset}
   Validate metadata from azure blob   ${azureBlobFileUrl}   ${assetInfo}  ${dataset}

Validate diagnostic event job for MENU_HTML
  [Documentation]    251252
  [Tags]    Full-Suite-Agent-service    Go-Live-data-processor-service    Full-Suite-data-processor-service
   ${dataset}=     Set Variable    MENU_HTML
   ${fleetCollectorId}=    Set Variable    10
   ${volume}=     Set Variable    1
   ${printerAccessToken}=      Generate Printer Access Token
   ${isDatasetAbsent}=         Check for data-set from device   ${printerAccessToken}      ${dataset}
   Skip If    ${isDatasetAbsent}     ${dataset} dataset is not present in the printer
   Set Fleet Collector Id     ${printerAccessToken}   ${fleetCollectorId}
   Set Dataset Volume level   ${printerAccessToken}   ${dataset}   ${volume}
   ${accessToken}=             Generate Root Token
   ${accountID}=               Get Account ID Based On Org Name    ${accessToken}
   ${assetInfo}=               Get Asset Info by IpAddress   ${accessToken}  ${accountID}
   Post Upload Analytics Datasets Job    ${accessToken}   ${accountID}  ${dataset}  ${assetInfo}
   ${azureBlobFileUrl}=   Validate Upload Analytics Datasets Job completion from Agent Queue   ${accessToken}   ${assetInfo}  ${dataset}
   Validate metadata from azure blob   ${azureBlobFileUrl}   ${assetInfo}  ${dataset}