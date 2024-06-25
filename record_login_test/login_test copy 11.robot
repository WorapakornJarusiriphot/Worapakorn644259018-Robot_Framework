*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    http://localhost:3000/sign-in

*** Test Cases ***
TC 1.0.001 ทดสอบการเข้าสู่ระบบและตรวจสอบสิทธิ
    Open Browser    ${URL}    firefox
    Input Text    id=identifier    Worapakorn2@gmail.com
    Input Text    id=password    111111
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    1s
    Click Button    xpath=//button[@type="submit"]
    Wait Until Element Is Visible    xpath=//button[text()="ออกจากระบบ"]    5s
    Location Should Be    http://localhost:3000/
    Page Should Contain    ออกจากระบบ
    Run Keyword And Continue On Failure    Execute JavaScript    return localStorage.getItem('access_token');
    Close Browser

TC 1.0.002 ทดสอบการเข้าสู่ระบบเมื่อกรอก E-mail หรือ Username ผิด
    Open Browser    ${URL}    firefox
    Input Text    id=identifier    wrongemail@gmail.com
    Input Text    id=password    wrongpassword
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    1s
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    คุณกรอก E-mail ไม่ถูกต้อง
    Close Browser

TC 1.0.003 ทดสอบการเข้าสู่ระบบเมื่อกรอก Password ผิด
    Open Browser    ${URL}    firefox
    Input Text    id=identifier    Worapakorn2@gmail.com
    Input Text    id=password    wrongpassword
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    1s
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    คุณกรอก Password ผิด กรุณากรอก Password ให้ถูกต้อง
    Close Browser

TC 1.0.004 ทดสอบการเข้าสู่ระบบโดยไม่กรอกข้อมูล
    Open Browser    ${URL}    firefox
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    1s
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    กรุณากรอกอีเมลหรือชื่อผู้ใช้
    Page Should Contain    กรุณากรอกรหัสผ่าน
    Close Browser
