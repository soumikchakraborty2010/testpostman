*** Settings ***
Documentation

Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/fleet/agents.page.robot
Resource          ../../.././resources/fleet/nativeagents.page.robot
Resource          ../../.././resources/fleet/ews.pages.robot
Resource          ../../.././resources/fleet/configurations.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../.././resources/common/printersettings-validation.robot
Library           ../../.././libs/UtilityFunctions.py
Resource          ../../.././libs/UtilityFunctions.py


Suite Setup       Initializing user
Test Setup        Initiate Browser And Deploy Cleanup File
Test Teardown     Closer Browser And Log Error

*** Variables ***

&{noncredsecuritysettings}
...  network.AIRPRINT_ENABLED=true
...  network.MOPRIA_USER_ENABLED=true
...  SECURITY__DISK_ENCRYPTION__ENABLED=1
...  mfp.networkScan.limitEmailRecipients=0
...  NETWORK__FORCE_HTTPS_CONNECTIONS=false
...  mfp.securityCertmon.enabled=false
...  mfp.securityCertmon.repeatInterval=2
...  UI__SHOW_PASSWORD=false
...  network.IPP_PRINT_ENABLED=true
...  network.IPP_FAX_ENABLED=true
...  network.IPP_OVER_USB_ENABLED=true
...  network.ESCL_ENABLED=true
...  les.applications.enable=1
...  SECURITY__LDAP__CERTIFICATE_VERIFICATION=0
...  SECURITY__PORT_ACCESS__TCP9198=true
...  ports.optional.parallel.1.enabled=false
...  PRINT__EMULSEC_DISABLEISWACCESS=true
...  PRINT__EMULSEC_PAGETIMEOUT_MINUTES=60
...  PRINT__EMULSEC_ALWAYSTERMINATE=false
...  PRINT__PJL_FILE_ACCESS_CONTROL=true
...  SECURITY__SNMP__VERSION__3__CONTEXT_NAME=
...  NETWORK__TCPIP4__TLS1_3_SSL_CIPHER_LIST=TLS_AES_256_GCM_SHA384:TLS_AES_128_GCM_SHA256
...  mfp.general.enableCompositeUsb=true
...  printer.usb.disableIo=1
...  DWPACTIVATE=false
...  NETWORK__WIRELESS__SECURITY_MODE=0
...  NETWORK__WIRELESS__WPA_PSK_ENCRYPTION_MODE=4
${cleanUpFileName}    cleanupnoncredsecurtysettings

*** Keywords ***
Initializing user
    Set Suite Variable   ${IDP_USER}
    Skip Test for DEV
Initiate Browser And Deploy Cleanup File
    Select Browser    ${BROWSER_NAME}
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization   ${ORG_NAME}
    Advance To the Printers Page
    Get Printer Device Family and Deploy cleanup File    ${PRINTER_IP}    ${IDP_USER}    ${IDP_PASSWORD}    ${orgId}    ${cleanUpFileName}

Closer Browser And Log Error
    Console Log On Failure
    Close Browser


*** Test Cases ***

Validate printer settings creation and deployment with non cred security settings
  [Documentation]    218342
  [Tags]    Full-Suite-Configuration-service
    Advance to Configuration Page
    ${nameOfConfig} =   Create a configuration    @{noncredsecuritysettingsUiNameList}    typeToCreate=Publish
    Advance to Printer Landing Page
    Deploy Configuration    ${PRINTER_IP}     ${nameOfConfig}
    Search in Listing page   ${PRINTER_IP}
    Click ip address in grid  ${PRINTER_IP}
    Task Initial Status Validation  "Deploy configuration"
    Task Completion Status Validation   "Deploy configuration"
    Latest Task Validation  "Deploy configuration"  ${nameOfConfig} [v1]   "Completed"     True
    Advance to Configuration Page
    Delete a Configuration     ${nameOfConfig}
    Validating Enforced Settings Value    ${PRINTER_IP}     ${noncredsecuritysettings}
