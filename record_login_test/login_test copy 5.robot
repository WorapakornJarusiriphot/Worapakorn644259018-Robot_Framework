*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    http://localhost:3000/sign-in

*** Test Cases ***
Login With Valid Credentials
    Open Browser    ${URL}    chrome
    Input Text    id=identifier    Worapakorn2@gmail.com
    Input Text    id=password    111111
    Click Button    button[type="submit"]
    Page Should Contain    Home
    Close Browser

Login With Invalid Username
    Open Browser    ${URL}    chrome
    Input Text    id=identifier    wrongemail@gmail.com
    Input Text    id=password    111111
    Click Button    button[type="submit"]
    Page Should Contain    คุณกรอก E-mail ไม่ถูกต้อง
    Close Browser

Login With Invalid Password
    Open Browser    ${URL}    chrome
    Input Text    id=identifier    Worapakorn2@gmail.com
    Input Text    id=password    wrongpassword
    Click Button    button[type="submit"]
    Page Should Contain    คุณกรอก Password ผิด กรุณากรอก Password ให้ถูกต้อง
    Close Browser

Login Without Any Data
    Open Browser    ${URL}    chrome
    Click Button    button[type="submit"]
    Page Should Contain    กรุณากรอกอีเมลหรือชื่อผู้ใช้
    Page Should Contain    กรุณากรอกรหัสผ่าน
    Close Browser
