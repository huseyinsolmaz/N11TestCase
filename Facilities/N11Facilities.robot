*** Settings ***
Resource   ../Variables/N11Variables.robot
Resource   ../Variables/MainFunctions.robot
Library    Selenium2Library

*** Keywords ***
N11TestCase
    OpenN11Page
    LoginN11  ${userMail}  ${userPassword}
    SearchOnN11  Samsung
    GoToSecondPage
    ChooseProductAndFavorite
    GoToMyFavoritePage
    CheckProductNameOnFavoritePage
    DeleteProductOnFavorite

DeleteProductOnFavorite
    Wait And Click Element  ${favoritedeletelink}
    wait for element  ${favoritedeletemessage}
    ${favoriteDelmessage}=  Get Text  ${favoritedeletemessage}
    Run Keyword if    '${favoriteDelmessage}'=='Ürününüz listeden silindi.'    Log    DELETED  level=WARN
    ...    ELSE   FAIL   Not DELETED
    Wait And Click Element  ${favoriteDeleteMessageOkButton}

CheckProductNameOnFavoritePage
    Wait For Element  ${favoriteProductId}
    ${favoriteProductIdSecond}=  Get Element Attribute    ${favoriteProductId}@id
    log   ${productIDOnSearchPage} -- ${favoriteProductIdSecond}  level=WARN
    Run Keyword if    '${productIDOnSearchPage}'=='${favoriteProductIdSecond}'    Log    You are correct Product  level=WARN
    ...    ELSE   FAIL   WrongProduct

GoToMyFavoritePage
    Wait For Element  ${myAccount}
    Mouse Over   ${myAccount}
    Wait And Click Element  ${favoriteList}
    Wait And Click Element  ${favoriteLink}

ChooseProductAndFavorite
    Wait For Element  ${thirdProductId}
    ${productIDOnSearchPage}=  Get Element Attribute    ${thirdProductId}@id
    Set Global Variable  ${productIDOnSearchPage}
    Wait And Click Element  ${thirdProductFacIcon}

GoToSecondPage
    Wait And Click Element  ${secondPage}
    ${currentPageNumber}=    Get Text  ${currentPage}
    Run Keyword if    '${currentPageNumber}'=='2'    Log    You are in Second Page     level=WARN
    ...    ELSE   You are in ${currentPageNumber}


SearchOnN11
    [Arguments]  ${searchKeyword}
    Wait And Send Text  ${searchinput}  ${searchKeyword}
    Wait And Click Element  ${searchbutton}
    ${currentSearchKey}=    Get Text  ${searchKeyText}
    Run Keyword if    '${currentSearchKey}'=='${searchKeyword}'    Log    You are correct keyword -- ${searchKeyword}     level=WARN
    ...    ELSE    FAIL   You are in ${currentSearchKey}

OpenN11Page
    Go To  ${N11_URL}
    ${current_url}=    Get Location
    Run Keyword if    '${current_url}'=='https://www.n11.com/'    Log    You are in N11 website    level=WARN
    ...    ELSE    FAIL   You are in ${current_url}

LoginN11
    [Arguments]  ${loginEmail}  ${loginPassword}
    Wait And Click Element  ${signInLinkN11}
    Wait And Send Text  ${emailinput}  ${LoginEMail}
    Wait And Send Text  ${passwordinput}  ${loginPassword}
    Wait And Click Element  ${loginbutton}
