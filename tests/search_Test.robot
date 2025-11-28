*** Settings ***
Library           SeleniumLibrary
Library           DataDriver    file=../data/product_search.xlsx    sheet_name=Sheet1
Resource          ../pages/search_Page.robot

Suite Setup       Open Home Page
Suite Teardown    Close Browser
Test Template     Search Product Template

*** Test Cases ***
Search Products
    [Tags]    search    smoke

*** Keywords ***
Search Product Template
    [Arguments]    ${search_keyword}    ${expected_result}

    Enter Search Text    ${search_keyword}
    Click Search Button

    IF    '${expected_result}'=='success'
        Verify Search Result Contains    ${search_keyword}
    ELSE IF    '${expected_result}'=='fail'
        Verify No Product Message
    END
