*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${BROWSER}      Chrome
${URL}          https://www.demoblaze.com
${USERNAME}     testfffuser123
${PASSWORD}     Tesfefdfdt@123

*** Test Cases ***
Sign Up
    Open Browser  ${URL}  ${BROWSER}
    Click Element  //a[@id='signin2']
    Sleep  2s
    Input Text  //input[@id='sign-username']  ${USERNAME}
    Input Text  //input[@id='sign-password']  ${PASSWORD}
    Click Button  //button[contains(text(),'Sign up')]
    Sleep  2s
    Handle Alert
    Close Browser

Login and Logout
    Open Browser  ${URL}  ${BROWSER}
    Click Element  //a[@id='login2']
    Sleep  2s
    Input Text  //input[@id='loginusername']  ${USERNAME}
    Input Text  //input[@id='loginpassword']  ${PASSWORD}
    Click Button  //button[contains(text(),'Log in')]
    Sleep  3s
    Element Should Be Visible  //a[@id='logout2']
    Click Element  //a[@id='logout2']
    Sleep  2s
    Element Should Be Visible  //a[@id='login2']
    Close Browser
