*** Settings ***
Library     SeleniumLibrary
Library     DataDriver     file=../data/register.xlsx   sheet_name=sheet1
Resource    ../pages/register_Page.robot
Test Template       Register New User

*** Test Cases ***

Register User with data from Excel
    [Tags]      register
    ${firstname}    ${lastname}     ${email}    ${telephone}    ${password}     ${confirm_password}    ${newsletter}

*** Keywords ***
Register New User
    [Arguments]    ${firstname}    ${lastname}    ${email}    ${telephone}    ${password}    ${confirm_password}    ${newsletter}

    Open Register Page
    Enter First Name       ${firstname}
    Enter Last Name        ${lastname}
    Enter Email            ${email}
    Enter Telephone        ${telephone}
    Enter Password         ${password}
    Confirm Password       ${confirm_password}

    Run Keyword If    '${newsletter}' == 'Yes'    Select Newsletter Yes
    ...               ELSE                        Select Newsletter No

    Accept Privacy Policy
    Click Continue
    Verify Registration Success
    Close Browser
