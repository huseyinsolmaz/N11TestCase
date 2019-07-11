*** Settings ***
Resource      ../Variables/variables.robot
Library           Collections
Library           String
Library           Selenium2Library
Library           OperatingSystem
Resource          Variables.robot
Library           FakerLibrary

*** Keywords ***
Launch Browser
    [Arguments]  ${url}=${amazonUrl}
    HeadlessChrome  ${url}
    Maximize Browser Window

wait for home page
    [Arguments]    ${elementName}
    Wait Until Keyword Succeeds    30 sec    1 sec    Page Should Contain Element    ${elementName}
    Log    Homepage is viewed    level=WARN
    Capture Page Screenshot

wait for element
    [Arguments]    ${element}    ${timeout}=10 sec    ${interval}=1 sec
    Wait Until Keyword Succeeds    ${timeout}    ${interval}    Page Should Contain Element    ${element}
    Capture Page Screenshot

Wait And Click Element
    [Arguments]    ${element}    ${timeout}=10 sec    ${interval}=1 sec
    wait for element    ${element}    ${timeout}    ${interval}
    click on element    ${element}

click text if exists
    [Arguments]    ${text1}=    ${text2}=    ${text3}=    ${text4}=    ${text5}=    ${text6}=
    ...    ${text7}=    ${text8}=    ${text9}=    ${text10}=
    :FOR    ${i}    IN RANGE    1    10
    \    ${status}    ${value}=    Run Keyword And Ignore Error    Page Should Contain Element    name=${text${i}}
    \    Run keyword if    '${status}'=='PASS'    Click Element    name=${text${i}}
    \    Run keyword if    '${status}'=='PASS'    log    clicked on ${text${i}}    level=WARN
    \    Exit For Loop If    '${status}'=='PASS'
    ${EMPTY}

switch windows
    [Arguments]    ${windowNumber}    @{windowNames}
    Get Window Names    select window    name=@{windowNames}[${windowNumber}]

wait for element by xpath
    [Arguments]    ${element}    ${timeout}=10 sec    ${interval}=1 sec
    Wait Until Keyword Succeeds    ${timeout}    ${interval}    Page Should Contain Element    xpath=${element}

click on element by xpath
    [Arguments]    ${element}
    Click Element    xpath=${element}

Wait And Click Element By Xpath
    [Arguments]    ${element}    ${timeout}=10 sec    ${interval}=1 sec
    wait for element by xpath    xpath=${element}    ${timeout}    ${interval}
    click on element by xpath    xpath=${element}

Wait And Send Text
    [Arguments]    ${element}    ${text}    ${timeout}=10 sec    ${interval}=1 sec
    wait for element    ${element}    ${timeout}    ${interval}
    send text to element    ${element}    ${text}

send text to element
    [Arguments]    ${element}    ${text}
    Input Text    ${element}    ${text}

Select IFrame
    [Arguments]    ${element}
    wait for element    ${element}
    Select Frame    ${element}

click on element
    [Arguments]    ${element}
    Click Element    ${element}

Is Text Found
    [Arguments]    ${text}
    ${status}    ${value}=    Run keyword and ignore error    Page Should Contain Textfield    ${text}
    [Return]    ${status}

focus element
    [Arguments]    ${element}
    Focus    ${element}

Wait And Focus Element
    [Arguments]    ${element}    ${timeout}=10 sec    ${interval}=1 sec
    wait for element    ${element}    ${timeout}    ${interval}
    focus element    ${element}

Create Random Text
    ${randomText}    Generate Random String    8    [LOWER]
    Comment    ${randomText}    Set Variable    ${randomText}

Create Random Email
    ${randomText}    Generate Random String    8    [LOWER]
    ${randomText}    Set Variable    ${randomText}@gmail.com

When Test Fail Take Screenshot
    Run Keyword If Test Failed    Capture Page Screenshot
    Run Keyword If Test Failed    Close Browser
    Run Keyword If Test Passed    Close Browser

Wait And Scroll To Element
    [Arguments]    ${element}    ${timeout}=10 sec    ${interval}=1 sec
    wait for element    ${element}    ${timeout}    ${interval}
    scroll to element    ${element}

scroll to element
    [Arguments]    ${element}
    wait for element    ${element}
    Scroll Element Into View    ${element}

Wait Element And Get Text
    [Arguments]    ${element}    ${timeout}=10 sec    ${interval}=1 sec
    wait for element    ${element}    ${timeout}    ${interval}
    get text    ${element}

get text from element
    [Arguments]    ${element}
    Get Text    ${element}

Wait Element And Get Value
    [Arguments]    ${element}    ${timeout}=10 sec    ${interval}=1 sec
    wait for element    ${element}    ${timeout}    ${interval}
    get value from element    ${element}

get value from element
    [Arguments]    ${element}
    Get Value    ${element}

Generate Random First Name
    ${randomFirstName}=    FakerLibrary.first_name
    Set Global Variable    ${randomFirstName}

Generate Random Last Name
    ${randomLastname}=    FakerLibrary.first_name
    Set Global Variable    ${randomLastname}

Generate Random Date
    ${randomDate}=    FakerLibrary.date    pattern=%d-%m-%Y
    ${randomDate}=    Remove String    ${randomDate}    -
    Set Global Variable    ${randomDate}

Generate Random Phone
    ${randomPhone}=    FakerLibrary.Phone_number
    Set Global Variable    ${randomPhone}

Generate Random Text
    [Arguments]    ${nb_word}
    ${randomText}=    FakerLibrary.sentence    nb_words=${nb_word}
    Set Global Variable    ${randomText}

Generate Random Number
    [arguments]  ${digits}
    ${randomNumber}=  Random Number  ${digits}
    Set Global Variable  ${randomNumber}

Delete Attribute By Id
    [Arguments]    ${locationId}    ${attribute}
    Execute Javascript    document.getElementById("${locationId}").removeAttribute("${attribute}");


Scroll To Element with header
  [arguments]   ${elementLocationForScroll}  ${header}=${headerId}
  ${width}	${height} =	Get Element Size	${header}
  ${elementLocationForScroll}=  Get Vertical Position  ${textMessageSelection}
  ${elementLocationForScroll}=  Evaluate  ${elementLocationForScroll}-(3*${height})
  Execute Javascript    window.scrollTo(0,${elementLocationForScroll})

Scroll To Location
  [arguments]    ${y}
  Execute Javascript    window.scrollTo(0,${y})

Set Chrome Options
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    : FOR    ${option}    IN    @{chrome_arguments}
    \    Call Method    ${options}    add_argument    ${option}
    [Return]    ${options}

HeadlessChrome
    [Arguments]   ${URL}   ${alias}=None
    Set Environment Variable   webdriver.chrome.driver   ${CURDIR}/chromedriver.exe
    Set Screenshot Directory  ${CURDIR}/../Tests/testresults/${TEST_NAME}
    ${chrome_options}=    Set Chrome Options
    ${ws}=    Set Variable    window-size=1920,1200
    ${disableLogging}=    Set Variable    --log-level=3
    Call Method   ${chrome_options}    add_argument    ${ws}
    Call Method   ${chrome_options}    add_argument    ${disableLogging}
    Create Webdriver    Chrome   ${alias}   chrome_options=${chrome_options}
    Go To  ${URL}
    Capture Page Screenshot
