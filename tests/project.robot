*** Settings ***
Suite Setup
Suite Teardown    Close All Browsers
Test Setup        Launch Browser  https://www.n11.com/
Test Teardown     When Test Fail Take Screenshot
Resource          ../Variables/MainFunctions.robot
Resource          ../Facilities/N11Facilities.robot
Library           Selenium2Library

*** Variables ***

*** Test Cases ***
01.N11TestCase-KeyTorc
    N11TestCase


*** Keywords ***
