*** Settings ***
Documentation     Test cases for user login functionality.
Library           SeleniumLibrary
Suite Setup       Open Browser    ${URL}    firefox
Suite Teardown    Close Browser
Test Setup        Maximize Browser Window

*** Variables ***
${URL}            http://localhost:3000/sign-in

*** Test Cases ***
TC 1.0.001 ทดสอบการเข้าสู่ระบบและตรวจสอบสิทธิ
    [Documentation]    ทดสอบการเข้าสู่ระบบด้วยข้อมูลที่ถูกต้องและตรวจสอบสิทธิ
    [Tags]    login    positive
    Input Text    id=identifier    Worapakorn2@gmail.com
    Input Text    id=password    111111
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    10s
    Click Button    xpath=//button[@type="submit"]
    Wait Until Element Is Visible    xpath=//button[text()="ออกจากระบบ"]    10s
    Location Should Be    http://localhost:3000/
    Page Should Contain    ออกจากระบบ
    Run Keyword And Continue On Failure    Execute JavaScript    return localStorage.getItem('access_token');

TC 1.0.002 ทดสอบการเข้าสู่ระบบเมื่อกรอก E-mail หรือ Username ผิด
    [Documentation]    ทดสอบการเข้าสู่ระบบด้วย E-mail หรือ Username ที่ผิด
    [Tags]    login    negative
    Input Text    id=identifier    wrongemail@gmail.com
    Input Text    id=password    wrongpassword
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    10s
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    คุณกรอก E-mail ไม่ถูกต้อง

TC 1.0.003 ทดสอบการเข้าสู่ระบบเมื่อกรอก Password ผิด
    [Documentation]    ทดสอบการเข้าสู่ระบบด้วย Password ที่ผิด
    [Tags]    login    negative
    Input Text    id=identifier    Worapakorn2@gmail.com
    Input Text    id=password    wrongpassword
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    10s
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    คุณกรอก Password ผิด กรุณากรอก Password ให้ถูกต้อง

TC 1.0.004 ทดสอบการเข้าสู่ระบบโดยไม่กรอกข้อมูล
    [Documentation]    ทดสอบการเข้าสู่ระบบโดยไม่กรอกข้อมูล
    [Tags]    login    negative
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    10s
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    กรุณากรอกอีเมลหรือชื่อผู้ใช้
    Page Should Contain    กรุณากรอกรหัสผ่าน
