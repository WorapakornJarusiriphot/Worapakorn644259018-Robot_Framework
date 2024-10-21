*** Settings ***
Documentation     Test cases for user login functionality.
Library           SeleniumLibrary
Library           DateTime
Library           OperatingSystem
Suite Setup       Create Folder For Screenshots
# Suite Teardown    Delete All Screenshots
Test Setup        Open Browser To Login Page
Test Teardown     Close Browser

*** Variables ***
${URL}            https://dicedreams-eta.vercel.app/sign-in#loaded
${BROWSER}        chrome
${TIME_FORMAT}    %Y%m%d_%H%M%S

*** Test Cases ***
TC 9001 ทดสอบการเข้าร่วม โพสต์นัดเล่น ที่หน้า Home
    [Documentation]    ทดสอบการเข้าสู่ระบบด้วยข้อมูลที่ถูกต้อง
    [Tags]    login    positive
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    Input Valid Credentials
    Wait Until Element Is Visible    id=Create-PostGames    timeout=10s
    Click Button    id=Create-PostGames
    # รอจนกว่าปุ่มจะปรากฏและคลิก
    Wait Until Element Is Visible    id=participate    timeout=10s
    Click Button    id=participate
    # คลิกปุ่มยืนยันการเข้าร่วม
    Click Button    id=agree
    Wait Until Element Is Visible    //div[contains(@class, 'MuiAlert-message') and contains(text(), 'สร้างโพสต์สำเร็จ!')]    timeout=30s
    # Run Keyword And Continue On Failure    Execute JavaScript    document.getElementById("Sign-Out").click();
    Sleep    2s
    Capture Page Screenshot    screenshots/TC-9/TC9001-success_${TIMESTAMP}.png

# TC 10002 ทดสอบการเข้าร่วม โพสต์นัดเล่น ที่หน้ารายละเอียดโพสต์
#     [Documentation]    ทดสอบการเข้าสู่ระบบด้วย E-mail หรือ Username ที่ผิด
#     [Tags]    login    negative
#     ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
#     Input Text    id=identifier    wrongemail@gmail.com
#     Input Text    id=password    wrongpassword
#     Click Button    xpath=//button[@type="submit"]
#     Set Selenium Timeout    10s
#     Wait Until Element Is Visible    xpath=//p[contains(text(),'คุณกรอก E-mail ไม่ถูกต้อง')]    timeout=10s
#     Page Should Contain    คุณกรอก E-mail ไม่ถูกต้อง
#     Capture Page Screenshot    screenshots/TC-10/TC10002-success_${TIMESTAMP}.png

*** Keywords ***
Create Folder For Screenshots
    Create Directory    screenshots

# Delete All Screenshots
#     Remove Directory    screenshots    recursive=True

Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Input Valid Credentials
    Input Text    id=identifier    Worapakorn2@gmail.com
    Input Text    id=password    111111
    Click Button    xpath=//button[@type="submit"]
