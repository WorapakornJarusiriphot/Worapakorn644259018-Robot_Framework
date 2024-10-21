*** Settings ***
Documentation     Test cases for user registration functionality.
Library           SeleniumLibrary
Library           OperatingSystem
Library           DateTime
Suite Setup       Create Folder For Screenshots
Suite Teardown    Delete All Screenshots
Test Setup        Open Browser To Registration Page
Test Teardown     Close Browser

*** Variables ***
${URL}            https://dicedreams-eta.vercel.app/sign-up
${BROWSER}        chrome
${TIME_FORMAT}    %Y%m%d_%H%M%S
${TIME_FORMAT}    %Y%m%d_%H%M%S

*** Test Cases ***
TC 2.0.001 ทดสอบการสมัครสมาชิกด้วยข้อมูลที่ถูกต้อง
    [Documentation]    ทดสอบการสมัครสมาชิกด้วยข้อมูลที่ถูกต้อง
    [Tags]    registration    positive
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Fill Registration Form
    Page Should Contain    สมัครสมาชิกสำเร็จ!
    Capture Page Screenshot    screenshots/TC-1/success_${TIMESTAMP}.png

TC 2.0.002 ทดสอบการสมัครสมาชิกโดยไม่กรอกข้อมูล
    [Documentation]    ทดสอบการสมัครสมาชิกโดยไม่กรอกข้อมูล
    [Tags]    registration    negative
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Click Button    css=button[type="submit"]
    Page Should Contain    กรุณากรอกชื่อจริง
    Page Should Contain    กรุณากรอกนามสกุล
    Page Should Contain    กรุณากรอกชื่อผู้ใช้
    Page Should Contain    กรุณากรอกหมายเลขโทรศัพท์
    Page Should Contain    กรุณากรอกอีเมล
    Page Should Contain    กรุณากรอกรหัสผ่าน
    Page Should Contain    กรุณาเลือกวันเกิด
    Page Should Contain    กรุณาเลือกเพศ
    Capture Page Screenshot    screenshots/TC-2/fail_${TIMESTAMP}.png

TC 2.0.006 ตรวจสอบการสมัครสมาชิกด้วย Password ที่ไม่ถูกต้อง
    [Documentation]    ตรวจสอบการสมัครสมาชิกด้วย Password ที่ไม่ถูกต้อง
    [Tags]    registration    negative
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Fill Registration Form With Invalid Password
    Should Contain Either Text    รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร    รหัสผ่านต้องมีอักษรพิมพ์ใหญ่
    Capture Page Screenshot    screenshots/TC-6/fail_${TIMESTAMP}.png

*** Keywords ***
Create Folder For Screenshots
    Create Directory    screenshots

Delete All Screenshots
    Remove Directory    screenshots    recursive=True

Open Browser To Registration Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Fill Registration Form
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    ${TIMESTAMP}=    Set Variable    
    Input Text    id=username    worapakorn${TIMESTAMP}
    Input Text    id=phoneNumber    0623844415
    Input Text    id=email    worapakorn${TIMESTAMP}@gmail.com
    Input Text    id=password    Password-123
    Click Element    css=input[placeholder="MM/DD/YYYY"]
    Press Keys    css=input[placeholder="MM/DD/YYYY"]    01/01/1990
    Click Element    css=input[type='radio'][value='ชาย']
    Click Button    css=button[type="submit"]

Fill Registration Form With Invalid Password
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    ${TIMESTAMP}=    Set Variable    
    Input Text    id=username    worapakorn${TIMESTAMP}
    Input Text    id=phoneNumber    0623844415
    Input Text    id=email    worapakorn${TIMESTAMP}@gmail.com
    Input Text    id=password    pass
    Click Element    css=input[placeholder="MM/DD/YYYY"]
    Press Keys    css=input[placeholder="MM/DD/YYYY"]    01/01/2000
    Click Element    css=input[type='radio'][value='ชาย']
    Click Button    css=button[type="submit"]

Should Contain Either Text
    [Arguments]    ${text1}    ${text2}
    ${page_text}=    Get Text    xpath=//*   # ดึงข้อความทั้งหมดในหน้า
    Run Keyword If    '${text1}' in '${page_text}' or '${text2}' in '${page_text}'    Log    Text found
    ...    ELSE    Fail    None of the expected texts were found

Generate Timestamp
    ${TIMESTAMP}=    Get Time    ${TIME_FORMAT}
    [Return]    ${TIMESTAMP}