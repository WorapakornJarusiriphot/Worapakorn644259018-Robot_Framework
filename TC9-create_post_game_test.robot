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
${UPLOAD_IMAGE_PATH}    D:\\Users\\Dell\\Pictures\\MagicTheGathering.jpg

*** Test Cases ***
TC 9001 ทดสอบการสร้างโพสต์นัดเล่น
    [Documentation]    ทดสอบการสร้างโพสต์นัดเล่น
    [Tags]    create_post    positive
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}

    # เข้าสู่ระบบด้วยข้อมูลที่ถูกต้อง
    Input Valid Credentials

    # รอจนกว่าปุ่ม 'สร้างโพสต์' จะปรากฏและสามารถใช้งานได้
    Wait Until Element Is Visible    xpath=//a[@id='Create-PostGames']    timeout=10s
    Wait Until Element Is Enabled    xpath=//a[@id='Create-PostGames']    timeout=5s

    # เลื่อนมุมมองไปยังปุ่ม 'สร้างโพสต์'
    Scroll Element Into View    xpath=//a[@id='Create-PostGames']

    # คลิกปุ่ม 'สร้างโพสต์'
    Click Element    xpath=//a[@id='Create-PostGames']

    # รอจนหน้าสร้างโพสต์โหลดแล้ว
    Wait Until Element Is Visible    xpath=//h4[contains(text(),'สร้างโพสต์นัดเล่น')]    timeout=10s

    # เลือกชื่อบอร์ดเกม
    Click Element    id=game-select
    Wait Until Element Is Visible    xpath=//ul[@role='listbox']    timeout=5s
    Scroll Element Into View    xpath=//li[contains(text(),'Magic the gathering')]
    Click Element    xpath=//li[contains(text(),'Magic the gathering')]

    # กรอกข้อมูลในฟิลด์ "รายละเอียดของโพสต์"
    Input Text    id=detail_post    เอา Magic the gathering ตัวเสริมมาด้วยก็ดีนะ เพราะเรามีแค่ตัวหลัก

    # ใช้ JavaScript ในการอัปโหลดรูปภาพผ่าน Dropzone
    ${js}    Set Variable    return document.querySelector('input[type="file"]').style.display = 'block';
    Execute JavaScript    ${js}
    
    Choose File    xpath=//input[@type='file']    ${UPLOAD_IMAGE_PATH}

    # รอให้ไฟล์ถูกอัปโหลด
    Sleep    3s

    # เลื่อนมุมมองไปที่ปุ่ม "สร้างโพสต์นัดเล่น"
    Scroll Element Into View    id=PostGames

    # รอให้ปุ่ม 'สร้างโพสต์นัดเล่น' พร้อมก่อนคลิก
    Wait Until Element Is Visible    id=PostGames    timeout=5s
    Wait Until Element Is Enabled    id=PostGames    timeout=5s

    # คลิกปุ่ม "สร้างโพสต์นัดเล่น"
    Click Button    id=PostGames

    # รอข้อความแสดงผล "สร้างโพสต์สำเร็จ!" และเพิ่มเวลา timeout ให้มากขึ้น
    Wait Until Element Is Visible    //div[contains(@class, 'MuiAlert-message') and contains(text(), 'สร้างโพสต์สำเร็จ!')]    timeout=30s

    # ถ่ายภาพหน้าจอเมื่อสำเร็จ
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
    Input Text    id=identifier    worapakorn13
    Input Text    id=password    123456
    Click Button    xpath=//button[@type="submit"]
