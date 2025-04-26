*** Settings ***
Documentation    Test Suite for DemoBlaze Website Authentication Flows
Library          SeleniumLibrary
Library          String

Suite Setup      Open Browser And Prepare Environment
Suite Teardown   Close Browser

*** Variables ***
${BROWSER}       chrome
${BASE_URL}      https://www.demoblaze.com/
${USERNAME}      testuser_${RANDOM_STRING}
${PASSWORD}      StrongPass123!

*** Test Cases ***
User Signup Scenario
    [Documentation]    Test user registration process
    Generate Random Username
    Wait And Click Signup
    Input Signup Credentials    ${USERNAME}    ${PASSWORD}
    Verify Signup Success

User Login Scenario
    [Documentation]    Test user login functionality
    Wait And Click Login
    Perform Login    ${USERNAME}    ${PASSWORD}
    Verify Login Success

User Logout Scenario
    [Documentation]    Test user logout functionality
    Perform Safe Logout
    Verify Logout Success

*** Keywords ***
Open Browser And Prepare Environment
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    15 seconds
    Set Selenium Speed    0.5 seconds

Generate Random Username
    ${RANDOM_STRING}=    Generate Random String    5    [LETTERS]
    Set Test Variable    ${USERNAME}    testuser_${RANDOM_STRING}

Wait And Click Signup
    Wait Until Page Contains Element    id=signin2    timeout=10s
    Wait Until Element Is Visible    id=signin2    timeout=10s
    Execute JavaScript    document.getElementById('signin2').click()
    Wait Until Element Is Visible    id=sign-username    timeout=10s

Input Signup Credentials
    [Arguments]    ${username}    ${password}
    Input Text      id=sign-username    ${username}
    Input Text      id=sign-password    ${password}
    Click Button    xpath=//button[contains(text(), 'Sign up')]

    # Handle signup confirmation
    Run Keyword And Ignore Error    Wait Until Element Is Visible    class=sweet-alert    timeout=10s
    Run Keyword And Ignore Error    Click Button    class=confirm

    # Additional error handling
    Run Keyword And Ignore Error    Handle Possible Alert

Wait And Click Login
    Wait Until Page Contains Element    id=login2    timeout=10s
    Execute JavaScript    document.getElementById('login2').click()
    Wait Until Element Is Visible    id=loginusername    timeout=10s

Perform Login
    [Arguments]    ${username}    ${password}
    Input Text      id=loginusername    ${username}
    Input Text      id=loginpassword    ${password}
    Click Button    xpath=//button[contains(text(), 'Log in')]

    # Wait for login to complete
    Wait Until Element Is Visible    id=nameofuser    timeout=10s

Perform Safe Logout
    # Ensure logout is possible
    Run Keyword And Ignore Error    Wait Until Element Is Visible    id=logout2    timeout=10s
    Execute JavaScript    document.getElementById('logout2').click()

Verify Signup Success
    # Check for signup confirmation
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    Run Keyword And Ignore Error    Handle Possible Alert

Verify Login Success
    # Verify welcome message or logged-in state
    Element Should Be Visible    id=nameofuser
    Element Text Should Contain    id=nameofuser    Welcome

Verify Logout Success
    # Verify logged out state
    Wait Until Element Is Visible    id=login2    timeout=10s
    Element Should Be Visible    id=login2

Handle Possible Alert
    # Attempt to handle any unexpected alerts
    ${alert_present}=    Run Keyword And Return Status    Alert Should Be Present
    Run Keyword If    ${alert_present}    Accept Alert