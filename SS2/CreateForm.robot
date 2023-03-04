*** Settings ***
Documentation   Demo test case to open demoqa website
Library         SeleniumLibrary

*** Test Cases ***
Open DemoQA Website
    [Documentation]    Open demoqa website in browser
    Open Browser    https://demoqa.com/    chrome
    Maximize Browser Window
    Title Should Be    ToolsQA
    Close Browser
