*** Settings ***
Documentation

Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot
Resource          ../../../resources/fleet/agents.page.robot
Resource    ../../../resources/fleet/fleetagents.page.robot

Suite Setup       Initializing user
Test Setup        Open Browser
Test Teardown     Closer Browser And Log Error


*** Keywords ***
Initializing user
    Set Suite Variable   ${IDP_USER}
    Set Suite Variable    ${Fleet_Agent_Name}   Robot-Test-Fleet-Agent
Open Browser
    Select Browser    ${BROWSER_NAME}
    Skip Test for EA
    Skip Test for NA

Closer Browser And Log Error
    Console Log On Failure
    Close Browser



*** Test Cases ***
Creation of Fleet agent and Downloading Installation Package
  [Documentation]    144925
  [Tags]    Go-Live-Client-downloads    Full-Suite-Client-downloads    Go-Live-Agent-service    Full-Suite-Agent-service
  Skip Test for DEV
  Skip Test for QA
  ${Expected_Agent_Status}    Set Variable   Activation required
  ${Expected_Agent_Configuration}   Set Variable   Default
  ${Fleet_Agent_Description}    Set Variable  Robot-Test-Fleet-Agent-Description
  ${Expected_number_of_printers}   Set Variable  0
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Advance To Agents Page
  Assert On Agents Page
  Advance to fleet agents tab without waiting for grid
  Deletion of Pre-existing Fleet Agent    ${Fleet_Agent_Name}
  Create A New Fleet Agent    ${Fleet_Agent_Name}     ${Fleet_Agent_Description}
  Validate creation of fleet agent    ${Fleet_Agent_Name}   ${Expected_Agent_Status}   ${Expected_Agent_Configuration}  ${Fleet_Agent_Description}
  Advance To Agents Page
  Assert On Agents Page
  Validate Agent Status Filter
  Search For FleetAgentName    ${Fleet_Agent_Name}
  Validate activation status in grid for the searched fleet agent    ${Expected_Agent_Status}
  Validate No. of printers in grid for the searched fleet agent  ${Expected_number_of_printers}
  Navigating into the searched fleet agent
  Download and Validate installation package

Validate Fleet Agent Activation
  [Documentation]    144914
  [Tags]    Go-Live-Agent-service    Full-Suite-Agent-service
  Skip Test for DEV
  Skip Test for QA
  ${Expected_Agent_Status}  Set Variable   Communicating
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Advance To Agents Page
  Assert On Agents Page
  Search For FleetAgentName    ${Fleet_Agent_Name}
  Navigating into the searched fleet agent
  Generate Fleet Agent Activation Code
  Copy Fleet Agent Activation Code
  Open New Tab
  Navigate to Fleet Agent Page
  Activate Fleet Agent    ${Expected_Agent_Status}
  Validate agent status   ${Expected_Agent_Status}

Discovering and Enrolling Printers Through Fleet Agent
  [Documentation]    144924
  [Tags]    Go-Live-Agent-service    Full-Suite-Agent-service
  Skip Test for DEV
  Skip Test for QA
  ${Expected_Agent_Status}  Set Variable   Communicating
  ${Expected_number_of_printers}   Set Variable  1
  ${desired_printer_to_get_enrolled_and_discovered}    Set Variable  10.195.129.148
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Advance To Agents Page
  Assert On Agents Page
  Search For FleetAgentName    ${Fleet_Agent_Name}
  Navigating into the searched fleet agent
  Validate agent status   ${Expected_Agent_Status}
  Edit Discovery Criteria of Fleet Agent  ${desired_printer_to_get_enrolled_and_discovered}
  Discover printers and validate discovery     ${Fleet_Agent_Name}  ${Expected_number_of_printers}   ${desired_printer_to_get_enrolled_and_discovered}

Deactivation of Fleet Agent
  [Documentation]    144928
  [Tags]    Go-Live-Agent-service    Full-Suite-Agent-service
  Skip Test for DEV
  Skip Test for QA
  ${Expected_Agent_Status}    Set Variable   Deactivated
  ${Expected_number_of_printers}   Set Variable  0
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Advance To Agents Page
  Assert On Agents Page
  Advance to fleet agents tab without waiting for grid
  Search For FleetAgentName    ${Fleet_Agent_Name}
  Navigating into the searched fleet agent
  Deactivate Fleet Agent     ${Fleet_Agent_Name}
  Advance To Agents Page
  Assert On Agents Page
  Advance to fleet agents tab without waiting for grid
  Search For FleetAgentName    ${Fleet_Agent_Name}
  Validate activation status in grid for the searched fleet agent    ${Expected_Agent_Status}
  Validate No. of printers in grid for the searched fleet agent  ${Expected_number_of_printers}

Deletion of Fleet Agent
  [Documentation]    144929
  [Tags]    Go-Live-Agent-service    Full-Suite-Agent-service
  Skip Test for DEV
  Skip Test for QA
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Advance To Agents Page
  Assert On Agents Page
  Advance to fleet agents tab without waiting for grid
  Search For FleetAgentName    ${Fleet_Agent_Name}
  Navigating into the searched fleet agent
  Delete fleet agent    ${Fleet_Agent_Name}

Validation of Fleet Agent Settings
  [Documentation]    144923
  [Tags]    Go-Live-Agent-service    Full-Suite-Agent-service
  Skip Test for DEV
  Skip Test for QA
  ${Expected_Agent_Configuration}   Set Variable    Custom
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Advance To Agents Page
  Assert On Agents Page
  Search For FleetAgentName    ${Fleet_Agent_Name}
  Navigating into the searched fleet agent
  Edit Other Settings of Fleet Agent
  Validate Agent Settings in Agent Details Page  ${Expected_Agent_Configuration}

Validate Fleet Agent Status
  [Documentation]    144918
  [Tags]    Go-Live-Agent-service    Full-Suite-Agent-service
  Skip Test for DEV
  Skip Test for QA
  ${Expected_Agent_Status}  Set Variable   Communicating
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Advance To Agents Page
  Assert On Agents Page
  Search For FleetAgentName    ${Fleet_Agent_Name}
  Navigating into the searched fleet agent
  Validate agent status   ${Expected_Agent_Status}
  ${printer_count}=   Get Number of enrolled printer(s) from Agents Page
  Get timestamp from Agents Page
  Advance To Agents Page
  Agent status validation in grid page    ${Fleet_Agent_Name}     ${Expected_Agent_Status}
  Validate No. of printers in grid for the searched fleet agent  ${printer_count}
  Open New Tab
  Navigate to Fleet Agent Page
  Validate communication status   ${Expected_Agent_Status}
  Validate enrolled printer count   ${printer_count}
  Validate activation timestamp   ${activation_time}    ${activation_year}

Validate Fleet Agent Identification
  [Documentation]    144922
  [Tags]    Go-Live-Agent-service    Full-Suite-Agent-service
  Skip Test for DEV
  Skip Test for QA
  ${Fleet_Agent_Description}   Set Variable   Robot-Test-Fleet-Agent-Description
  Go To Fleet Management Portal
  Log in To CFM
  Select Organization   ${ORG_NAME}
  Advance To Printers Page
  Advance To Agents Page
  Assert On Agents Page
  Search For FleetAgentName    ${Fleet_Agent_Name}
  Navigating into the searched fleet agent
  Validate agent type
  Validate agent ID    ${Fleet_Agent_Name}
  Validate agent description   ${Fleet_Agent_Description}
  Validate if the Fleet Agent is Password protected
  Validate Fleet Agent IP Address in Agent Details page