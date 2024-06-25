*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    http://localhost:3000/sign-up

*** Test Cases ***
Register With Valid Data
    Open Browser    ${URL}    firefox
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    Input Text    id=username    worapakorn123
    Input Text    id=phoneNumber    0812345678
    Input Text    id=email    worapakorn@gmail.com
    Input Text    id=password    Password-123
    Click Element    css=input[placeholder="MM/DD/YYYY"]
    Input Text    css=input[placeholder="MM/DD/YYYY"]    01/01/1990
    Click Element    css=input[type='radio'][value='ชาย']
    Click Button    css=button[type="submit"]
    Page Should Contain    สมัครสมาชิกสำเร็จ!
    Close Browser

Register Without Any Data
    Open Browser    ${URL}    firefox
    Click Button    css=button[type="submit"]
    Page Should Contain    กรุณากรอกชื่อจริง
    Page Should Contain    กรุณากรอกนามสกุล
    Page Should Contain    กรุณากรอกชื่อผู้ใช้
    Page Should Contain    กรุณากรอกหมายเลขโทรศัพท์
    Page Should Contain    กรุณากรอกอีเมล
    Page Should Contain    กรุณากรอกรหัสผ่าน
    Page Should Contain    กรุณาเลือกวันเกิด
    Page Should Contain    กรุณาเลือกเพศ
    Close Browser

Register With Invalid Email
    Open Browser    ${URL}    firefox
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    Input Text    id=username    worapakorn123
    Input Text    id=phoneNumber    0812345678
    Input Text    id=email    worapakorn@invalid
    Input Text    id=password    Password-123
    Click Element    css=input[placeholder="MM/DD/YYYY"]
    Input Text    css=input[placeholder="MM/DD/YYYY"]    01/01/1990
    Click Element    css=input[type='radio'][value='ชาย']
    Click Button    css=button[type="submit"]
    Page Should Contain    กรุณากรอกอีเมลให้ถูกต้อง
    Close Browser

Register With Duplicate Email Or Username
    Open Browser    ${URL}    firefox
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    Input Text    id=username    worapakorn20
    Input Text    id=phoneNumber    0623844415
    Input Text    id=email    worapakorn20@gmail.com
    Input Text    id=password    Password-123
    Click Element    css=input[placeholder="MM/DD/YYYY"]
    Input Text    css=input[placeholder="MM/DD/YYYY"]    05/13/2024
    Click Element    css=input[type='radio'][value='ชาย']
    Click Button    css=button[type="submit"]
    Page Should Contain    E-mail หรือ Username นี้มีอยู่ในระบบแล้ว
    Close Browser
