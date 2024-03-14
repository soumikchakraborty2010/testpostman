*** Settings ***
Documentation

Resource          ../../.././resources/common/resource.robot
Resource          ../../.././resources/fleet/org.selection.page.robot
Resource          ../../.././resources/fleet/grid.robot

Suite Setup       Initializing user
Test Setup        Initiate Browser
Test Teardown     Closer Browser And Log Error


*** Keywords ***
Initializing user
    Set Suite Variable   ${IDP_USER}
    ${uniqueNumber}    Generate random string    4    0123456789
    Set Suite Variable    ${newViewName}    automation-test-single-org-${uniqueNumber}
    Set Suite Variable    ${editedViewName}     ${newViewName}-edited
Initiate Browser
    Select Browser    ${BROWSER_NAME}
    Go To Fleet Management Portal
    Log in To CFM
    Select Organization   ${ORG_NAME}
    Advance To Printers Page
    Assert On Printers Page
Closer Browser And Log Error
    Advance to Printer Landing Page
    Run Keyword If Test Failed    Select View    Standard
    Console Log On Failure
    Close Browser


*** Test Cases ***
Creation of view in single org
  [Documentation]    144880
  [Tags]    Go-Live-View-service    Go-Live-Asset-management-ui    Full-Suite-View-service    Full-Suite-Asset-management-ui
    Create View    ${newViewName}
    Create View Validation Single Org

Edition of view in single org
  [Documentation]    144882
  [Tags]    Go-Live-View-service    Go-Live-Asset-management-ui    Full-Suite-View-service    Full-Suite-Asset-management-ui
    Edit View    ${newViewName}    ${editedViewName}
    Skip If    '${isViewNamePresent}' == 'False'    The view with name '${newViewName}' is not present to be edited.
    Advance to Printer Landing Page
    Edit View Validation singel Org   ${editedViewName}

Copy view in Single org
  [Documentation]    144885
  [Tags]    Go-Live-View-service    Go-Live-Asset-management-ui    Full-Suite-View-service    Full-Suite-Asset-management-ui
    GoTo Manage View Page
    Copy View    ${editedViewName}

Deletion of view in single org
  [Documentation]    144884
  [Tags]    Go-Live-View-service    Go-Live-Asset-management-ui    Full-Suite-View-service    Full-Suite-Asset-management-ui
    GoTo Manage View Page
    Delete View    Copy of ${editedViewName}
    Delete View    ${editedViewName}

Quick view in single org
  [Documentation]    144890
  [Tags]    Go-Live-View-service    Go-Live-Asset-management-ui    Full-Suite-View-service    Full-Suite-Asset-management-ui
    Create Quick View

Search Child Org View in All Org
  [Documentation]    144889
  [Tags]    Go-Live-Asset-management-ui    Full-Suite-Asset-management-ui
    Create View    ${newViewName}
    Create View Validation Single Org
    Navigate to Org Selection Page
    Select All Organization Option
    Advance To Printers Page
    Assert On Printers Page
    Validate child org view in All Org    ${newViewName}
    GoTo Manage View Page
    Delete View    ${newViewName}




