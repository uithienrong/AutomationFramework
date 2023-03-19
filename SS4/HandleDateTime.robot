*** Settings ***
Library    SeleniumLibrary
Library    DateTime

*** Variable ***
${DateOfBirthTxt}    //input[@id="dateOfBirthInput"]
${MonthSelect}      //select[contains(@class,"month-select")]
${YearSelect}      //select[contains(@class,"year-select")]

*** Keywords ***
Input Date For Practice Form
    [Arguments]    ${Year}    ${Month}    ${Date}
    Wait Until Element Is Enabled    ${DateOfBirthTxt}
    Click Element                    ${DateOfBirthTxt}
    ${monthValue}=    Get Month from Input value    ${Month}
    Wait Until Element Is Enabled    ${MonthSelect}
    Select From List by Label        ${MonthSelect}    ${monthValue}
    Wait Until Element Is Enabled    ${YearSelect}
    Select From List by Label        ${YearSelect}    ${Year}
    Select Day from Input value    ${Date}    ${monthValue}

Get Month from Input value
    [Arguments]    ${MonthInput}
    ${month}=    Convert Date    2022-${MonthInput}-01    result_format=%B
    Return From Keyword    ${month}

Select Day from Input value
    [Arguments]    ${DayInput}    ${MonthInput}
    ${day}=    Set Variable    //div[contains(text(),"${DayInput}") and contains(@aria-label,"${MonthInput}")]
    Wait Until Element Is Enabled    ${day}
    Click Element    ${day}

Login To Practice Form
    Open Browser    https://demoqa.com/automation-practice-form    chrome
    Maximize Browser Window
    Execute JavaScript    document.getElementById("fixedban").remove();
    Execute JavaScript    document.querySelector("footer").remove();
 
*** Test Cases ***
Input Date Of Birth
    Login To Practice Form
    Input Date For Practice Form    1969    11    30
    Sleep    10

