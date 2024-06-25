*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    http://localhost:3000/sign-in

*** Test Cases ***
Login With Valid Credentials
    Open Browser    ${URL}    firefox
    Input Text    id=identifier    Worapakorn2@gmail.com
    Input Text    id=password    111111
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    10s
    Click Button    xpath=//button[@type="submit"]
    Wait Until Element Is Visible    xpath=//button[text()="ออกจากระบบ"]    10s
    Location Should Be    http://localhost:3000/
    Page Should Contain    ออกจากระบบ
    Run Keyword And Continue On Failure    Execute JavaScript    return localStorage.getItem('access_token');
    Close Browser

Login With Invalid Username
    Open Browser    ${URL}    firefox
    Input Text    id=identifier    wrongemail@gmail.com
    Input Text    id=password    wrongpassword
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    10s
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    คุณกรอก E-mail ไม่ถูกต้อง
    Close Browser

Login With Invalid Password
    Open Browser    ${URL}    firefox
    Input Text    id=identifier    Worapakorn2@gmail.com
    Input Text    id=password    wrongpassword
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    10s
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    คุณกรอก Password ผิด กรุณากรอก Password ให้ถูกต้อง
    Close Browser

Login Without Any Data
    Open Browser    ${URL}    firefox
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    10s
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    กรุณากรอกอีเมลหรือชื่อผู้ใช้
    Page Should Contain    กรุณากรอกรหัสผ่าน
    Close Browser
