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
    Set Suite Variable    ${newViewName}    automation-test-all-org-${uniqueNumber}
    Set Suite Variable    ${editedViewName}     ${newViewName}-edited

Initiate Browser
    Select Browser    ${BROWSER_NAME}
    Go To Fleet Management Portal
    Log in To CFM
    Select All Organization Option
    Advance To Printers Page
    Assert On Printers Page

Closer Browser And Log Error
    Advance to Printer Landing Page
    Run Keyword If Test Failed    Select View    Standard
    Console Log On Failure
    Close Browser


*** Test Cases ***
Creation of view in all org
  [Documentation]    144881
  [Tags]    Go-Live-View-service    Go-Live-Asset-management-ui    Full-Suite-View-service    Full-Suite-Asset-management-ui
    Create View    ${newViewName}
    Create View Validation All Org

Edition of view in all org
  [Documentation]    144883
  [Tags]    Go-Live-View-service    Go-Live-Asset-management-ui    Full-Suite-View-service    Full-Suite-Asset-management-ui
    Edit View    ${newViewName}    ${editedViewName}
    Skip If    '${isViewNamePresent}' == 'False'    The view with name '${newViewName}' is not present to be edited.
    Advance to Printer Landing Page
    Edit View Validation all Org   ${editedViewName}

Copy view in all org
  [Documentation]    144886
  [Tags]    Go-Live-View-service    Go-Live-Asset-management-ui    Full-Suite-View-service    Full-Suite-Asset-management-ui
    GoTo Manage View Page
    Copy View    ${editedViewName}

Deletion of view in all org
  [Documentation]    144887
  [Tags]    Go-Live-View-service    Go-Live-Asset-management-ui    Full-Suite-View-service    Full-Suite-Asset-management-ui
    GoTo Manage View Page
    Delete View    Copy of ${editedViewName}
    Delete View    ${editedViewName}

Quick view in all org
  [Documentation]    227032
  [Tags]    Go-Live-View-service    Full-Suite-View-service    Full-Suite-Asset-management-ui    Go-Live-Asset-management-ui
    Create Quick View for all Org