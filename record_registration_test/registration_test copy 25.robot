*** Settings ***
Documentation     Test cases for user registration functionality.
Library           SeleniumLibrary
Suite Setup       Open Browser    ${URL}    firefox
Suite Teardown    Close Browser
Test Setup        Maximize Browser Window

*** Variables ***
${URL}            http://localhost:3000/sign-up

*** Keywords ***
Should Contain Either Text
    [Arguments]    ${text1}    ${text2}    ${text3}    ${text4}
    ${status1}=    Run Keyword And Return Status    Page Should Contain    ${text1}
    ${status2}=    Run Keyword And Return Status    Page Should Contain    ${text2}
    ${status3}=    Run Keyword And Return Status    Page Should Contain    ${text3}
    ${status4}=    Run Keyword And Return Status    Page Should Contain    ${text4}
    Run Keyword If    '${status1}' == 'True' or '${status2}' == 'True' or '${status3}' == 'True' or '${status4}' == 'True'    Pass Execution    Text Found
    Fail    None of the texts were found

*** Test Cases ***
TC 2.0.001 ทดสอบการสมัครสมาชิกด้วยข้อมูลที่ถูกต้อง
    [Documentation]    ทดสอบการสมัครสมาชิกด้วยข้อมูลที่ถูกต้อง
    [Tags]    registration    positive
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    Input Text    id=username    worapakorn123
    Input Text    id=phoneNumber    0623844415
    Input Text    id=email    worapakorn123@gmail.com
    Input Text    id=password    Password-123
    Click Element    css=input[placeholder="MM/DD/YYYY"]
    Press Keys    css=input[placeholder="MM/DD/YYYY"]    01/01/1990
    Click Element    css=input[type='radio'][value='ชาย']
    Click Button    css=button[type="submit"]
    Page Should Contain    สมัครสมาชิกสำเร็จ!

TC 2.0.002 ทดสอบการสมัครสมาชิกโดยไม่กรอกข้อมูล
    [Documentation]    ทดสอบการสมัครสมาชิกโดยไม่กรอกข้อมูล
    [Tags]    registration    negative
    Click Button    css=button[type="submit"]    
    Page Should Contain    กรุณากรอกชื่อจริง
    Page Should Contain    กรุณากรอกนามสกุล
    Page Should Contain    กรุณากรอกชื่อผู้ใช้
    Page Should Contain    กรุณากรอกหมายเลขโทรศัพท์
    Page Should Contain    กรุณากรอกอีเมล
    Page Should Contain    กรุณากรอกรหัสผ่าน
    Page Should Contain    กรุณาเลือกวันเกิด
    Page Should Contain    กรุณาเลือกเพศ

TC 2.0.003 ทดสอบการสมัครสมาชิกด้วยอีเมลที่ไม่ถูกต้อง
    [Documentation]    ทดสอบการสมัครสมาชิกด้วยอีเมลที่ไม่ถูกต้อง
    [Tags]    registration    negative
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    Input Text    id=username    worapakorn123
    Input Text    id=phoneNumber    0623844415
    Input Text    id=email    worapakorn.invalid.com
    Input Text    id=password    Password-123
    Click Element    css=input[placeholder="MM/DD/YYYY"]
    Press Keys    css=input[placeholder="MM/DD/YYYY"]    01/01/1990
    Click Element    css=input[type='radio'][value='ชาย']
    Click Button    css=button[type="submit"]
    Page Should Contain    กรุณากรอกอีเมลให้ถูกต้อง

TC 2.0.004 ทดสอบการสมัครสมาชิกด้วย E-mail หรือ Username ซ้ำกับในฐานข้อมูล
    [Documentation]    ทดสอบการสมัครสมาชิกด้วย E-mail หรือ Username ซ้ำกับในฐานข้อมูล
    [Tags]    registration    negative
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    Input Text    id=username    worapakorn20
    Input Text    id=phoneNumber    0623844415
    Input Text    id=email    worapakorn20@gmail.com
    Input Text    id=password    Password-123
    Click Element    css=input[placeholder="MM/DD/YYYY"]
    Press Keys    css=input[placeholder="MM/DD/YYYY"]    05/13/2024
    Click Element    css=input[type='radio'][value='ชาย']
    Click Button    css=button[type="submit"]
    Page Should Contain    Username นี้มีคนใช้แล้ว
    Page Should Contain    Email นี้มีคนใช้แล้ว

TC 2.0.005 ตรวจสอบการสมัครสมาชิกด้วย Username ซ้ำ
    [Documentation]    ตรวจสอบการสมัครสมาชิกด้วย Username ซ้ำ
    [Tags]    registration    negative
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    Input Text    id=username    worapakorn20
    Input Text    id=phoneNumber    0623844415
    Input Text    id=email    worapakorn@example.com
    Input Text    id=password    Password-123
    Click Element    css=input[placeholder="MM/DD/YYYY"]
    Press Keys    css=input[placeholder="MM/DD/YYYY"]    01/01/2000
    Click Element    css=input[type='radio'][value='ชาย']
    Click Button    css=button[type="submit"]
    Page Should Contain    Username นี้มีคนใช้แล้ว

TC 2.0.006 ตรวจสอบการสมัครสมาชิกด้วย Password ที่ไม่ถูกต้อง
    [Documentation]    ตรวจสอบการสมัครสมาชิกด้วย Password ที่ไม่ถูกต้อง
    [Tags]    registration    negative
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    Input Text    id=username    worapakorn123
    Input Text    id=phoneNumber    0623844415
    Input Text    id=email    worapakorn@example.com
    Input Text    id=password    pass
    Click Element    css=input[placeholder="MM/DD/YYYY"]
    Press Keys    css=input[placeholder="MM/DD/YYYY"]    01/01/2000
    Click Element    css=input[type='radio'][value='ชาย']
    Click Button    css=button[type="submit"]
    Should Contain Either Text    รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร    รหัสผ่านต้องมีอักษรพิมพ์ใหญ่    รหัสผ่านต้องมีตัวเลข    รหัสผ่านต้องมีสัญลักษณ์พิเศษ

TC 2.0.007 ตรวจสอบการสมัครสมาชิกด้วย Phone Number ที่ไม่ถูกต้อง
    [Documentation]    ตรวจสอบการสมัครสมาชิกด้วย Phone Number ที่ไม่ถูกต้อง
    [Tags]    registration    negative
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    Input Text    id=username    worapakorn123
    Input Text    id=phoneNumber    abcdefgh
    Input Text    id=email    worapakorn@example.com
    Input Text    id=password    Password-123
    Click Element    css=input[placeholder="MM/DD/YYYY"]
    Press Keys    css=input[placeholder="MM/DD/YYYY"]    01/01/2000
    Click Element    css=input[type='radio'][value='ชาย']
    Click Button    css=button[type="submit"]
    Page Should Contain    เบอร์โทรศัพท์ต้องเป็นหมายเลขเบอร์โทรศัพท์จริงๆเท่านั้น

TC 2.0.008 ตรวจสอบการสมัครสมาชิกด้วยวันเกิดที่ไม่ถูกต้อง
    [Documentation]    ตรวจสอบการสมัครสมาชิกด้วยวันเกิดที่ไม่ถูกต้อง
    [Tags]    registration    negative
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    Input Text    id=username    worapakorn123
    Input Text    id=phoneNumber    0623844415
    Input Text    id=email    worapakorn@example.com
    Input Text    id=password    Password-123
    Click Element    css=input[placeholder="MM/DD/YYYY"]
    Press Keys    css=input[placeholder="MM/DD/YYYY"]    01/01/2022
    Click Element    css=input[type='radio'][value='ชาย']
    Click Button    css=button[type="submit"]
    Page Should Contain    วันเกิดต้องไม่ต่ำกว่า 10 ปีจากวันปัจจุบัน
    Close Browser
