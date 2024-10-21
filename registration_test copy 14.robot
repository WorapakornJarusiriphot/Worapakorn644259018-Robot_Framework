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

*** Test Cases ***
TC 2.0.001 ทดสอบการสมัครสมาชิกด้วยข้อมูลที่ถูกต้อง
    [Documentation]    ทดสอบการสมัครสมาชิกด้วยข้อมูลที่ถูกต้อง
    [Tags]    registration    positive
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Fill Registration Form
    Wait Until Element Is Visible    xpath=//p[contains(text(),'สมัครสมาชิกสำเร็จ!')]    timeout=10s
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
    Wait Until Element Is Visible    xpath=//p[contains(text(),'กรุณากรอกอีเมลให้ถูกต้อง')]    timeout=10s
    Capture Page Screenshot    screenshots/TC-2/TC20003-fail_${TIMESTAMP}.png

TC 2.0.004 ทดสอบการสมัครสมาชิกด้วย Username ที่ซ้ำกับในฐานข้อมูล
    [Documentation]    ทดสอบการสมัครสมาชิกด้วย Username ซ้ำ
    [Tags]    registration    negative
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Fill Registration Form With Duplicate Username
    Wait Until Element Is Visible    xpath=//p[contains(text(),'Username นี้มีคนใช้แล้ว')]    timeout=10s
    Capture Page Screenshot    screenshots/TC-2/TC20004-fail_${TIMESTAMP}.png

TC 2.0.005 ตรวจสอบการสมัครสมาชิกด้วย Password ที่ไม่ถูกต้อง
    [Documentation]    ทดสอบการสมัครสมาชิกด้วย Password ที่ไม่ถูกต้อง
    [Tags]    registration    negative
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Fill Registration Form With Invalid Password
    Wait Until Element Is Visible    xpath=//p[contains(text(),'รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร')]    timeout=10s
    Wait Until Element Is Visible    xpath=//p[contains(text(),'รหัสผ่านต้องมีอักษรพิมพ์ใหญ่')]    timeout=10s
    Capture Page Screenshot    screenshots/TC-2/TC20005-fail_${TIMESTAMP}.png

TC 2.0.006 ตรวจสอบการสมัครสมาชิกด้วยหมายเลขโทรศัพท์ที่ไม่ถูกต้อง
    [Documentation]    ทดสอบการสมัครสมาชิกด้วยหมายเลขโทรศัพท์ที่ไม่ถูกต้อง
    [Tags]    registration    negative
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Fill Registration Form With Invalid PhoneNumber
    Wait Until Element Is Visible    xpath=//p[contains(text(),'กรุณากรอกหมายเลขโทรศัพท์ที่ถูกต้อง')]    timeout=10s
    Capture Page Screenshot    screenshots/TC-2/TC20006-fail_${TIMESTAMP}.png

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
    Input Text    id=:R1ld7hkl9uuja:    01/01/1990
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
    Input Text    id=:R1ld7hkl9uuja:    01/01/2000
    Click Element    css=input[type='radio'][value='ชาย']
    Click Button    css=button[type="submit"]

Fill Registration Form With Invalid Email
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    ${TIMESTAMP}=    Set Variable    
    Input Text    id=username    worapakorn${TIMESTAMP}
    Input Text    id=phoneNumber    0623844415
    Input Text    id=email    worapakorn.invalid
    Input Text    id=password    Password-123
    Input Text    id=:R1ld7hkl9uuja:    01/01/1990
    Click Element    css=input[type='radio'][value='ชาย']
    Click Button    css=button[type="submit"]

Fill Registration Form With Duplicate Username
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    Input Text    id=username    worapakorn_existing
    Input Text    id=phoneNumber    0623844415
    Input Text    id=email    worapakorn_existing@gmail.com
    Input Text    id=password    Password-123
    Input Text    id=:R1ld7hkl9uuja:    01/01/2000
    Click Element    css=input[type='radio'][value='ชาย']
    Click Button    css=button[type="submit"]

Fill Registration Form With Invalid PhoneNumber
    Input Text    id=firstName    วรปกร
    Input Text    id=lastName    จารุศิริพจน์
    ${TIMESTAMP}=    Set Variable    
    Input Text    id=username    worapakorn${TIMESTAMP}
    Input Text    id=phoneNumber    abc12345
    Input Text    id=email    worapakorn${TIMESTAMP}@gmail.com
    Input Text    id=password    Password-123
    Input Text    id=:R1ld7hkl9uuja:    01/01/1990
    Click Element    css=input[type='radio'][value='ชาย']
    Click Button    css=button[type="submit"]

Should Contain Either Text
    [Arguments]    ${text1}    ${text2}
    ${page_text}=    Get Text    xpath=//*
    Run Keyword If    '${text1}' in '${page_text}' or '${text2}' in '${page_text}'    Log    Text found
    ...    ELSE    Fail    None of the expected texts were found

Generate Timestamp
    ${TIMESTAMP}=    Get Time    ${TIME_FORMAT}
    [Return]    ${TIMESTAMP}
