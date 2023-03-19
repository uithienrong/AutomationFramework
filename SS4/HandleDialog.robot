*** Settings ***
Library    SeleniumLibrary

*** Variable ***
#Variables
${testUserName}     hientest    
${testPW}           User@123

#Xpath
${username}         //input[@id="userName"]
${password}         //input[@id="password"]
${loginBtn}         //button[@id="login"]
${BookStorePage}     //ul[@class="menu-list"]//span[text()="Book Store"]
${BookStoreTitle}       //div[@class="main-header" and text()="Book Store"]
${AddToCollection}     //button[text()="Add To Your Collection"]
${loginUserName}     //label[@id="userName-label" and contains(text(),"User Name")]/following-sibling::label[contains(text(),"${testUserName}")]

*** Keywords ***
Navigate to BookStore Page
    Wait Until Element Is Enabled    ${BookStorePage}
    Click Element    ${BookStorePage}
    Wait Until Element Is Visible    ${BookStoreTitle}

Login To Login Form
    Open Browser    https://demoqa.com/login    chrome
    Maximize Browser Window
    Execute JavaScript    document.getElementById("fixedban").remove();
    Execute JavaScript    document.querySelector("footer").remove();
    Input Text    ${username}    ${testUserName}
    Input Text    ${password}    ${testPW}
    Click Element     ${loginBtn}
    Wait Until Element Is Visible    ${loginUserName}

Select A Book
    [Arguments]    ${bookName}
    ${bookElement}=   Set Variable    //a[contains(text(),"${bookName}")]
    Wait Until Element Is Enabled    ${bookElement}
    Click Element    ${bookElement}
 
*** Test Cases ***
Demo Dialog
    Login To Login Form
    Navigate to BookStore Page
    Select A Book    Git Pocket Guide
    Wait Until Element Is Enabled     ${AddToCollection}
    Click Element    ${AddToCollection}
    ${message} =	Handle Alert	ACCEPT
    Log To Console    ${message}
    Sleep    10

