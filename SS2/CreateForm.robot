*** Settings ***
Documentation   Demo test case to open demoqa website
Library         SeleniumLibrary

*** Test Cases ***
Open DemoQA Website
    [Documentation]    Open demoqa website in browser
    Open Browser    https://demoqa.com/    chrome
    Maximize Browser Window
    Title Should Be    DEMOQA
    Wait Until Element Is Enabled    //h5[contains(text(),"Forms")]
    Click Element    //h5[contains(text(),"Forms")]
    Wait Until Element Is Visible    //span[contains(text(),"Practice Form")]
    Click Element    //span[contains(text(),"Practice Form")]
    Wait Until Element Is Visible    //div[contains(text(),"Practice Form")]
    Input Text    //input[@id="firstName"]    John
    Input Text    //input[@id="lastName"]    Doe
    Input Text    //input[@id="userEmail"]    johndoe@example.com
    Click Element    //input[contains(@value,"Male")]/..
    Input Text    //input[@id="userNumber"]    1234567890
    Click Element    //input[@id="dateOfBirthInput"]
    Press Keys  //input[@id="dateOfBirthInput"]    CTRL+A ${SPACE}
    Clear Element Text  //input[@id="dateOfBirthInput"]
    Input Text    //input[@id="dateOfBirthInput"]    01 Jan 2000
    Press Keys  //div[@id="subjectsContainer"]    Maths    ENTER
    Click Element    //label[contains(text(),"Sports")]
    Click Element    //label[contains(text(),"Music")]
    Input Text    //textarea[@id="currentAddress"]    123 Main St
    ${iframes} =    Get WebElements    //iframe[contains(@id,"google_ads")]
    FOR    ${iframe}    IN    @{iframes}
        ${iframe_id} =    Get Element Attribute    ${iframe}    id
        Execute JavaScript    document.getElementById('${iframe_id}').style.display = 'none';
    END
    Sleep    2
    Scroll Element Into View    //button[@id="submit"]
    Click Element    //div[@id="state"]//div[contains(@class,"indicatorContainer")]/../..
    Press Keys  //div[@id="state"]//div[contains(@class,"indicatorContainer")]     NCR    ENTER
    Scroll Element Into View    //div[@id="city"]
    Click Element    //div[@id="city"]
    Press Keys  //div[@id="city"]     Delhi    ENTER
    Press Keys  None    ENTER
    Sleep    5
    Close Browser
