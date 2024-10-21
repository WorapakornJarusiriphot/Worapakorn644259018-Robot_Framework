*** Settings ***
Documentation     Test cases for user registration functionality.
Library           SeleniumLibrary
Library           OperatingSystem
Library           DateTime
Suite Setup       Create Folder For Screenshots
Test Setup        Open Browser To Registration Page
Test Teardown     Close Browser

*** Variables ***
${URL}            https://dicedreams-eta.vercel.app/sign-up
${BROWSER}        chrome
${TIME_FORMAT}    %Y%m%d%H%M%S

*** Test Cases ***
TC 2.0.001 ทดสอบการสมัครสมาชิกด้วยข้อมูลที่ถูกต้อง
    [Documentation]    ทดสอบการสมัครสมาชิกด้วยข้อมูลที่ถูกต้อง
    [Tags]    registration    positive
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Fill Registration Form
    Fill Birthdate    0
    Fill Birthdate    1
    Fill Birthdate    0
    Fill Birthdate    1
    Fill Birthdate    1
    Fill Birthdate    9
    Fill Birthdate    9
    Fill Birthdate    0
    Press Keys    css=input[placeholder="MM/DD/YYYY"]    \\13
    Sleep    1s
    Wait Until Element Is Visible    xpath=//p[contains(text(),'สมัครสมาชิกสำเร็จ!')]    timeout=30s
    Capture Page Screenshot    screenshots/TC-2/TC20001-success_${TIMESTAMP}.png

TC 2.0.002 ทดสอบการสมัครสมาชิกโดยไม่กรอกข้อมูล
    [Documentation]    ทดสอบการสมัครสมาชิกโดยไม่กรอกข้อมูล
    [Tags]    registration    negative
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Click Button    css=button[type="submit"]
    Wait Until Element Is Visible    xpath=//p[contains(text(),'กรุณากรอกชื่อจริง')]    timeout=10s
    Wait Until Element Is Visible    xpath=//p[contains(text(),'กรุณากรอกนามสกุล')]    timeout=10s
    Wait Until Element Is Visible    xpath=//p[contains(text(),'กรุณากรอกชื่อผู้ใช้')]    timeout=10s
    Wait Until Element Is Visible    xpath=//p[contains(text(),'กรุณากรอกหมายเลขโทรศัพท์')]    timeout=10s
    Wait Until Element Is Visible    xpath=//p[contains(text(),'กรุณากรอกอีเมล')]    timeout=10s
    Wait Until Element Is Visible    xpath=//p[contains(text(),'กรุณากรอกรหัสผ่าน')]    timeout=10s
    Wait Until Element Is Visible    xpath=//p[contains(text(),'กรุณาเลือกวันเกิด')]    timeout=10s
    Wait Until Element Is Visible    xpath=//p[contains(text(),'กรุณาเลือกเพศ')]    timeout=10s
    Capture Page Screenshot    screenshots/TC-2/TC20002-fail_${TIMESTAMP}.png

TC 2.0.003 ทดสอบการสมัครสมาชิกด้วยอีเมลที่ไม่ถูกต้อง
    [Documentation]    ทดสอบการสมัครสมาชิกด้วยอีเมลที่ไม่ถูกต้อง
    [Tags]    registration    negative
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Fill Registration Form With Invalid Email
    Fill Birthdate    01/01/1990
    Press Keys    css=input[placeholder="MM/DD/YYYY"]    \\13
    Sleep    1s
    Wait Until Element Is Visible    xpath=//p[contains(text(),'กรุณากรอกอีเมลให้ถูกต้อง')]    timeout=10s
    Capture Page Screenshot    screenshots/TC-2/TC20003-fail_${TIMESTAMP}.png

TC 2.0.004 ทดสอบการสมัครสมาชิกด้วย Username ที่ซ้ำกับในฐานข้อมูล
    [Documentation]    ทดสอบการสมัครสมาชิกด้วย Username ซ้ำ
    [Tags]    registration    negative
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Fill Registration Form With Duplicate Username
    Fill Birthdate    01/01/2000
    Press Keys    css=input[placeholder="MM/DD/YYYY"]    \\13
    Sleep    30s
    Wait Until Element Is Visible    xpath=//p[contains(text(),'Username นี้มีคนใช้แล้ว')]    timeout=10s
    Capture Page Screenshot    screenshots/TC-2/TC20004-fail_${TIMESTAMP}.png

TC 2.0.005 ตรวจสอบการสมัครสมาชิกด้วย Password ที่ไม่ถูกต้อง
    [Documentation]    ทดสอบการสมัครสมาชิกด้วย Password ที่ไม่ถูกต้อง
    [Tags]    registration    negative
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Fill Registration Form With Invalid Password
    Fill Birthdate    01/01/2000
    Press Keys    css=input[placeholder="MM/DD/YYYY"]    \\13
    Sleep    30s
    Wait Until Element Is Visible    xpath=//p[contains(text(),'รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร')]    timeout=10s
    Capture Page Screenshot    screenshots/TC-2/TC20005-fail_${TIMESTAMP}.png

TC 2.0.006 ตรวจสอบการสมัครสมาชิกด้วยหมายเลขโทรศัพท์ที่ไม่ถูกต้อง
    [Documentation]    ทดสอบการสมัครสมาชิกด้วยหมายเลขโทรศัพท์ที่ไม่ถูกต้อง
    [Tags]    registration    negative
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Fill Registration Form With Invalid PhoneNumber
    Fill Birthdate    01/01/1990
    Press Keys    css=input[placeholder="MM/DD/YYYY"]    \\13
    Sleep    30s
    Wait Until Element Is Visible    xpath=//p[contains(text(),'เบอร์โทรศัพท์ต้องเป็นหมายเลขเบอร์โทรศัพท์จริงๆเท่านั้น')]    timeout=10s
    Capture Page Screenshot    screenshots/TC-2/TC20006-fail_${TIMESTAMP}.png

TC 2.0.007 ตรวจสอบการสมัครสมาชิกด้วย Phone Number ที่ไม่ถูกต้อง
    [Documentation]    ตรวจสอบการสมัครสมาชิกด้วย Phone Number ที่ไม่ถูกต้อง
    [Tags]    registration    negative
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Fill Registration Form With Invalid PhoneNumber
    Fill Birthdate    01/01/1990
    Press Keys    css=input[placeholder="MM/DD/YYYY"]    \\13
    Sleep    30s
    Wait Until Element Is Visible    xpath=//p[contains(text(),'เบอร์โทรศัพท์ต้องเป็นหมายเลขเบอร์โทรศัพท์จริงๆเท่านั้น')]    timeout=10s
    Capture Page Screenshot    screenshots/TC-2/TC20007-fail_${TIMESTAMP}.png

TC 2.0.008 ตรวจสอบการสมัครสมาชิกด้วยวันเกิดที่ไม่ถูกต้อง
    [Documentation]    ตรวจสอบการสมัครสมาชิกด้วยวันเกิดที่ไม่ถูกต้อง
    [Tags]    registration    negative
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Fill Registration Form
    Fill Birthdate    01/01/2022
    Press Keys    css=input[placeholder="MM/DD/YYYY"]    \\13
    Sleep    30s
    Wait Until Element Is Visible    xpath=//p[contains(text(),'วันเกิดต้องไม่ต่ำกว่า 10 ปีจากวันปัจจุบัน')]    timeout=10s
    Capture Page Screenshot    screenshots/TC-2/TC20008-fail_${TIMESTAMP}.png

*** Keywords ***
Create Folder For Screenshots
    Create Directory    screenshots

Open Browser To Registration Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Fill Registration Form
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    Click Element    css=input[type='radio'][value='ชาย']
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Input Text    id=username    worapakorn${TIMESTAMP}
    Input Text    id=phoneNumber    0623844415
    Input Text    id=email    worapakorn${TIMESTAMP}@gmail.com
    Input Text    id=password    Password-123
    # Click Button    css=button[aria-label="Choose date"]

    # รอการเลือกวัน เดือน ปี และดำเนินการเลือกปี เดือน และวัน
    # Wait Until Element Is Visible    css=button.MuiPickersCalendarHeader-switchHeader    timeout=5s
    # Wait Until Element Is Enabled    css=button.MuiPickersCalendarHeader-switchHeader    timeout=5s
    # Click Element    css=button.MuiPickersCalendarHeader-switchHeader
    # Click Element    xpath=//div[contains(text(),'1990')]
    # Click Element    xpath=//div[contains(text(),'January')]
    # Click Element    xpath=//td[@role='gridcell' and text()='1']
    # Click Element    xpath=//button[@data-testid='calendar-ok']

Fill Birthdate
    [Arguments]    ${birthdate}
    Set Focus To Element    css=input[placeholder="MM/DD/YYYY"]
    Execute JavaScript    document.getElementById(":R1ld7hkl9uuja:").value="${birthdate}"
    Sleep    1s

Fill Registration Form With Invalid Email
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    Click Element    css=input[type='radio'][value='ชาย']
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Input Text    id=username    worapakorn${TIMESTAMP}
    Input Text    id=phoneNumber    0623844415
    Input Text    id=email    worapakorn.invalid
    Input Text    id=password    Password-123
    # Click Button    css=button[aria-label="Choose date"]

Fill Registration Form With Duplicate Username
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    Click Element    css=input[type='radio'][value='ชาย']
    Input Text    id=username    WOJA
    Input Text    id=phoneNumber    0623844415
    Input Text    id=email    Worapakorn@gmail.com
    Input Text    id=password    Password-123
    # Click Button    css=button[aria-label="Choose date"]

Fill Registration Form With Invalid PhoneNumber
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    Click Element    css=input[type='radio'][value='ชาย']
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Input Text    id=username    worapakorn${TIMESTAMP}
    Input Text    id=phoneNumber    abc12345
    Input Text    id=email    worapakorn${TIMESTAMP}@gmail.com
    Input Text    id=password    Password-123
    Click Element    id=phoneNumber
    # Click Button    css=button[aria-label="Choose date"]

Fill Registration Form With Invalid Password
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    Click Element    css=input[type='radio'][value='ชาย']
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Input Text    id=username    worapakorn${TIMESTAMP}
    Input Text    id=phoneNumber    0623844415
    Input Text    id=email    worapakorn${TIMESTAMP}@gmail.com
    Input Text    id=password    pass
    Click Element    id=password
    # Click Button    css=button[aria-label="Choose date"]

    # Wait Until Element Is Visible    css=button.MuiPickersCalendarHeader-switchHeader    timeout=5s
    # Wait Until Element Is Enabled    css=button.MuiPickersCalendarHeader-switchHeader    timeout=5s
    # Click Element    css=button.MuiPickersCalendarHeader-switchHeader
    # Click Element    xpath=//div[contains(text(),'2000')]
    # Click Element    xpath=//div[contains(text(),'February')]
    # Click Element    xpath=//td[@role='gridcell' and text()='5']
    # Click Element    xpath=//button[@data-testid='calendar-ok']
    Click Button    css=button[type="submit"]