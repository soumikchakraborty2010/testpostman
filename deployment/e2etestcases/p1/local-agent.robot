*** Settings ***
Documentation
Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/printers.page.robot
Resource          ../../../resources/fleet/agents.page.robot
Resource          ../../../resources/fleet/localagents.page.robot
Resource          ../../../resources/fleet/ews.pages.robot


Suite Setup       Initializing user
Test Setup        Initiate Browser
Test Teardown     Closer Browser And Log Error


*** Keywords ***

Initializing user
    Set Suite Variable   ${IDP_USER}
    @{skipSetup}=  Create List  Local Agent Activation Panel validation  Install Local Agent
    Set Suite Variable    @{skipSetup}

Initiate Browser
    Skip Test for DEV
    Skip Test for QA
    ${status}=  Run Keyword And Return Status    List Should Contain Value    ${skipSetup}    ${TEST_NAME}
    IF  ${status} == ${False}
      Select Browser    ${BROWSER_NAME}
      Go To Fleet Management Portal
      Log in To CFM
      Select Organization   ${ORG_NAME}
      Advance To Printers Page
      Assert On Printers Page
    END

Closer Browser And Log Error
   ${status}=  Run Keyword And Return Status    List Should Contain Value    ${skipSetup}    ${TEST_NAME}
   IF  ${status} == ${False}
     Console Log On Failure
     Close Browser
   END

*** Test Cases ***

Download Local Agent
  [Documentation]    144955
  [Tags]    Go-Live-Client-downloads    Full-Suite-Client-downloads
  ${Package_Type}    Set Variable    Windows x64 installer
  Go To Agents Tab
  Advance To Local Agents Page
  Download Local Agent
  Verify OS Type DropDown
  Select install package type   ${Package_Type}
  Select Download Agent with Activation Code
  Get Latest File name    /    *.zip
  Move file to ExternalFiles Directory    ${lastModifiedFile}
  Compare file size
  Compare file name
  Delete File

Install Local Agent
  [Documentation]    144956
  [Tags]    Go-Live-Client-downloads    Full-Suite-Client-downloads
  Launch Local Agent Installation and run Installer

Generate Activation Code from LCS
  [Documentation]    251304
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui    Full-Suite-Agent-service
  Go To Agents Tab
  Advance To Local Agents Page
  Generate Activation Code Local Agent

Local Agent Activation Panel validation
  [Documentation]    251305
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui    Full-Suite-Agent-service
  Local Agent Panel validation

Validate Local Agent Activated in LCS
  [Documentation]    251306
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui
  Go To Agents Tab
  Advance To Local Agents Page
  Verify Local Agent Activated in ALP  printerCount=1

Status Filter Validation
  [Documentation]    144960
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui
  Go To Agents Tab
  Advance To Local Agents Page
  Check Local Agent Status Filter
  Select Agent Status

Update Number of Supported Activations
  [Documentation]    144957
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui
  ${activationRange}  Set Variable    100
  Go To Agents Tab
  Advance To Local Agents Page
  Select Activation Code  ${activationRange}

Edit Local Agent
  [Documentation]    144954
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui    Full-Suite-Agent-service
  ${LOG LEVEL}    Set Variable    Summary
  ${PollingInterval}    Set Variable    1440
  Go To Agents Tab
  Advance To Local Agents Page
  Get the Hostname
  Search For LocalAgentName
  Select LocalAgentName
  Select Edit Agent   ${LOG LEVEL}  ${PollingInterval}
  Task Initial Status Validation    "Update local agent configuration"
  Task Completion Status Validation    "Update local agent configuration"
  Verify Updated local agent configuration      ${LOG LEVEL}  ${PollingInterval}

Deactivate Local Agent
  [Documentation]    144963
  [Tags]    Go-Live-Agent-service    Full-Suite-Agent-service
  Go To Agents Tab
  Advance To Local Agents Page
  Get the Hostname
  Search For LocalAgentName
  Select LocalAgentName
  Check Deactivate Action

Expire Activation Code
  [Documentation]    251307
  [Tags]    Full-Suite-Asset-management-ui
  Go To Agents Tab
  Advance To Local Agents Page
  Expire Activation Code

Delete Local Agent
  [Documentation]    144964
  [Tags]    Go-Live-Agent-service    Full-Suite-Agent-service
  Go To Agents Tab
  Advance To Local Agents Page
  Get the Hostname
  Search For LocalAgentName
  Select LocalAgentName
  Check Delete Action