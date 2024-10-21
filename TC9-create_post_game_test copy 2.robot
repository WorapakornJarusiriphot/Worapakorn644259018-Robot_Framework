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
${UPLOAD_IMAGE_PATH}    D:\Users\Dell\Pictures\81AlnMS8z7L.jpg

*** Test Cases ***
TC 9001 ทดสอบการสร้างโพสต์นัดเล่น
    [Documentation]    ทดสอบการสร้างโพสต์นัดเล่น
    [Tags]    create_post    positive
    ${TIMESTAMP}=    Get Current Date    result_format=${TIME_FORMAT}
    
    # เข้าสู่ระบบด้วยข้อมูลที่ถูกต้อง
    Input Valid Credentials

    # รอจนกว่าปุ่ม 'สร้างโพสต์' จะปรากฏ
    Wait Until Element Is Visible    xpath=//a[@id='Create-PostGames']    timeout=10s
    
    # คลิกปุ่ม 'สร้างโพสต์'
    Click Element    xpath=//a[@id='Create-PostGames']
    
    # รอจนหน้าสร้างโพสต์โหลดแล้วคลิก
    Wait Until Element Is Visible    xpath=//h4[contains(text(),'สร้างโพสต์นัดเล่น')]    timeout=10s
    
    # เลือกชื่อบอร์ดเกม
    Click Element    id=game-select
    Click Element    xpath=//li[text()='ชื่อบอร์ดเกมที่ต้องการเลือก']    # คุณสามารถปรับชื่อเกมได้ตามต้องการ
    
    # กรอกข้อมูลในฟิลด์ "รายละเอียดของโพสต์"
    Input Text    id=detail_post    รายละเอียดของโพสต์ทดสอบ
    
    # เลือกจำนวนผู้เล่น
    Click Element    id=num_people
    Click Element    xpath=//li[text()='4']    # ตัวอย่างเลือกจำนวนผู้เล่น 4 คน
    
    # เลือกวันที่และเวลา
    Input Text    xpath=//input[@placeholder='MM/DD/YYYY']    09/26/2024
    Input Text    xpath=//input[@placeholder='hh:mm aa']    08:00 PM
    
    # อัปโหลดรูปภาพ
    Choose File    id=games_image    ${UPLOAD_IMAGE_PATH}
    
    # คลิกปุ่ม "สร้างโพสต์นัดเล่น"
    Click Button    id=PostGames
    
    # รอข้อความแสดงผล "สร้างโพสต์สำเร็จ!"
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
    Input Text    id=identifier    Worapakorn2@gmail.com
    Input Text    id=password    111111
    Click Button    xpath=//button[@type="submit"]
