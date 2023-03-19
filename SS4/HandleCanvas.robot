*** Settings ***
Library           SeleniumLibrary

*** Keywords ***
Get Canvas Data
    [Arguments]  ${id}
    ${js_code}=  Catenate  SEPARATOR=\n
    ...  var canvas = document.getElementById("${id}");
    ...  var ctx = canvas.getContext("2d");
    ...  var data = ctx.getImageData(0, 0, canvas.width, canvas.height).data;
    ${data}=  Execute Javascript  ${js_code}
    [Return]  ${data}

*** Test Cases ***
Open HTML file
    Open Browser    C:\\Users\\Admin\\OneDrive\\Desktop\\a.html    chrome
    ${canvas}=    Execute Javascript    return document.getElementById('myChart');
    ${ctx}=    Execute Javascript    return ${canvas}.getContext('2d');
    ${data}=    Execute Javascript    return ${ctx}.getImageData(0, 0, ${canvas}.width, ${canvas}.height).data;
    ${chartWidth}=    Execute Javascript    return ${canvas}.width;
    ${chartHeight}=    Execute Javascript    return ${canvas}.height;
    ${centerX}=    Set Variable    ${chartWidth} / 2;
    ${centerY}=    Set Variable    ${chartHeight} / 2;
    ${radius}=    Set Variable    ${chartWidth} / 2 * 0.8;
    ${startAngle}=    Set Variable    0;
    ${endAngle}=    Set Variable    2 * Math.PI;
    ${totalValue}=    Set Variable    0;
    ${hoverValue}=    Set Variable    0;

    FOR    ${i}    IN RANGE    0    ${data.__len__()}    4
        ${r}=    Set Variable    ${data[${i}]};
        ${g}=    Set Variable    ${data[${i} + 1]};
        ${b}=    Set Variable    ${data[${i} + 2]};
        ${a}=    Set Variable    ${data[${i} + 3]};
        ${value}=    Execute Javascript    return ${r} + ${g} + ${b};
        Run Keyword If    ${value} > 0
            ${totalValue}=    Evaluate    ${totalValue} + ${value};
            Run Keyword If    ${hoverValue} == 0
                ${hoverValue}=    Set Variable    ${value};

    ${hoverAngle}=    Execute Javascript    return ${hoverValue} / ${totalValue} * 2 * Math.PI;
    ${hoverX}=    Execute Javascript    return ${centerX} + ${radius} * Math.sin(${hoverAngle} - ${startAngle}) / 2;
    ${hoverY}=    Execute Javascript    return ${centerY} - ${radius} * Math.cos(${hoverAngle} - ${startAngle}) / 2;
    Execute Javascript    ${canvas}.dispatchEvent(new MouseEvent('mousemove', {'clientX': ${hoverX}, 'clientY': ${hoverY}}));

    Sleep    10
