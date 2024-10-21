*** Settings ***
Documentation     Test cases for user login functionality.
Library           SeleniumLibrary
Library           DateTime
Library           OperatingSystem
Suite Setup       Create Folder For Screenshots
Suite Teardown    Delete All Screenshots
Test Setup        Open Browser To Login Page
Test Teardown     Close Browser

*** Variables ***
${URL}            https://dicedreams-eta.vercel.app/sign-in#loaded
${BROWSER}        chrome
${TIME_FORMAT}    %Y%m%d_%H%M%S

*** Test Cases ***
TC 1.0.001 ทดสอบการเข้าสู่ระบบด้วยข้อมูลที่ถูกต้อง
    [Documentation]    ทดสอบการเข้าสู่ระบบด้วยข้อมูลที่ถูกต้อง
    [Tags]    login    positive
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Input Valid Credentials
    Page Should Contain    ออกจากระบบ
    Run Keyword And Continue On Failure    Execute JavaScript    return localStorage.getItem('access_token');
    Sleep    5s
    Capture Page Screenshot    screenshots/TC-1/success_${TIMESTAMP}.png

TC 1.0.002 ทดสอบการเข้าสู่ระบบเมื่อกรอก E-mail หรือ Username ผิด
    [Documentation]    ทดสอบการเข้าสู่ระบบด้วย E-mail หรือ Username ที่ผิด
    [Tags]    login    negative
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Input Text    id=identifier    wrongemail@gmail.com
    Input Text    id=password    wrongpassword
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    คุณกรอก E-mail ไม่ถูกต้อง
    Capture Page Screenshot    screenshots/TC-2/fail_${TIMESTAMP}.png

TC 1.0.003 ทดสอบการเข้าสู่ระบบเมื่อกรอก Password ผิด
    [Documentation]    ทดสอบการเข้าสู่ระบบด้วย Password ที่ผิด
    [Tags]    login    negative
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Input Text    id=identifier    Worapakorn2@gmail.com
    Input Text    id=password    wrongpassword
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    คุณกรอก Password ผิด กรุณากรอก Password ให้ถูกต้อง
    Capture Page Screenshot    screenshots/TC-3/fail_${TIMESTAMP}.png

TC 1.0.004 ทดสอบการเข้าสู่ระบบโดยไม่กรอกข้อมูล
    [Documentation]    ทดสอบการเข้าสู่ระบบโดยไม่กรอกข้อมูล
    [Tags]    login    negative
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Click Button    xpath=//button[@type="submit"]
    Page Should Contain    กรุณากรอกอีเมลหรือชื่อผู้ใช้
    Page Should Contain    กรุณากรอกรหัสผ่าน
    Capture Page Screenshot    screenshots/TC-4/fail_${TIMESTAMP}.png

*** Keywords ***
Create Folder For Screenshots
    Create Directory    screenshots

Delete All Screenshots
    Remove Directory    screenshots    recursive=True

Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Input Valid Credentials
    Input Text    id=identifier    Worapakorn2@gmail.com
    Input Text    id=password    111111
    Click Button    xpath=//button[@type="submit"]
