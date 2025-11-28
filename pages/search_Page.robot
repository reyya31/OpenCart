*** Settings ***
Library    SeleniumLibrary
Library    String
Resource   ../locators/product_search_Locators.robot


*** Keywords ***

Open Home Page
    Open Browser    https://opencart.abstracta.us/index.php?route=common/home    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    ${SEARCH_INPUT}

Enter Search Text
    [Arguments]    ${search_text}
    Input Text    ${SEARCH_INPUT}    ${search_text}

Click Search Button
    Click Button    ${SEARCH_BTN}
    Sleep    1s

Get Search Results
    ${results}=    Get WebElements    ${SEARCH_RESULTS}
    RETURN    ${results}

Verify Search Result Contains
    [Arguments]    ${search_keyword}
    ${results}=    Get Search Results
    ${found}=    False

    FOR    ${item}    IN    @{results}
        ${name}=    Get Text    ${item}
        ${name}=    Strip String    ${name}
        Run Keyword If    '${search_keyword.lower()}' in '${name.lower()}'    ${found}=    Set Variable    True
    END

    Should Be True    ${found}    msg=Search results do not contain '${search_keyword}'

Verify No Product Message
    Wait Until Page Contains Element    ${NO_PRODUCT_MSG}    10s