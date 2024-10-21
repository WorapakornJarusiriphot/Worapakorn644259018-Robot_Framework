*** Settings ***
Documentation     Test cases for user login functionality.
Library           SeleniumLibrary

*** Variables ***
${URL}            https://dicedreams-eta.vercel.app/sign-in#loaded

*** Test Cases ***
TC 1.0.001 ทดสอบการเข้าสู่ระบบและตรวจสอบสิทธิ
    [Documentation]    ทดสอบการเข้าสู่ระบบด้วยข้อมูลที่ถูกต้องและตรวจสอบสิทธิ
    [Tags]    login    positive
    Open Browser    ${URL}    firefox
    Maximize Browser Window
    Input Text    id=identifier    Worapakorn2@gmail.com
    Input Text    id=password    111111
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    1s
    Click Button    xpath=//button[@type="submit"]
    Wait Until Element Is Visible    xpath=//button[text()="ออกจากระบบ"]    3s
    Location Should Be    https://dicedreams-eta.vercel.app/
    #Page Should Contain    ออกจากระบบ
    Run Keyword And Continue On Failure    Execute JavaScript    return localStorage.getItem('access_token');
    Sleep    10s
    Close Browser

TC 1.0.002 ทดสอบการเข้าสู่ระบบเมื่อกรอก E-mail หรือ Username ผิด
    [Documentation]    ทดสอบการเข้าสู่ระบบด้วย E-mail หรือ Username ที่ผิด
    [Tags]    login    negative
    Open Browser    ${URL}    firefox
    Maximize Browser Window
    Input Text    id=identifier    wrongemail@gmail.com
    Input Text    id=password    wrongpassword
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    1s
    Click Button    xpath=//button[@type="submit"]
    #Page Should Contain    คุณกรอก E-mail ไม่ถูกต้อง
    Close Browser

TC 1.0.003 ทดสอบการเข้าสู่ระบบเมื่อกรอก Password ผิด
    [Documentation]    ทดสอบการเข้าสู่ระบบด้วย Password ที่ผิด
    [Tags]    login    negative
    Open Browser    ${URL}    firefox
    Maximize Browser Window
    Input Text    id=identifier    Worapakorn2@gmail.com
    Input Text    id=password    wrongpassword
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    1s
    Click Button    xpath=//button[@type="submit"]
    #Page Should Contain    คุณกรอก Password ผิด กรุณากรอก Password ให้ถูกต้อง
    Close Browser

TC 1.0.004 ทดสอบการเข้าสู่ระบบโดยไม่กรอกข้อมูล
    [Documentation]    ทดสอบการเข้าสู่ระบบโดยไม่กรอกข้อมูล
    [Tags]    login    negative
    Open Browser    ${URL}    firefox
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    1s
    Click Button    xpath=//button[@type="submit"]
    #Page Should Contain    กรุณากรอกอีเมลหรือชื่อผู้ใช้
    #Page Should Contain    กรุณากรอกรหัสผ่าน
    Close Browser
