# resources/common_keywords.robot
*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Open Browser To DemoBlaze
    Open Browser    https://www.demoblaze.com/    browser=${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    10 seconds

# resources/locators.robot
*** Variables ***
# Login Page Locators
${LOGIN_USERNAME_FIELD}    id=loginusername
${LOGIN_PASSWORD_FIELD}    id=loginpassword
${LOGIN_BUTTON}            xpath=//button[contains(text(), 'Log in')]

# Signup Page Locators
${SIGNUP_USERNAME_FIELD}    id=sign-username
${SIGNUP_PASSWORD_FIELD}    id=sign-password
${SIGNUP_BUTTON}            xpath=//button[contains(text(), 'Sign up')]