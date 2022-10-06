***Settings***
Library  Selenium2Library
Suite Teardown    Close Browser 

***Variables***
${URL}  https://www.metro.taipei/cp.aspx?n=91974F2B13D997F1
${browser}  chrome  
@{Station_list1}  西門  古亭  北投  南港  板橋  
@{Station_list2}  affwqfqwefwq  123412  opweopr

***Test Cases***
Information Process
    Open Browser to Maximize
    FOR    ${INDEX}    IN    @{Station_list1}
        Enter Information    ${INDEX}
        Jugde Information    ${INDEX}
    END
    FOR    ${INDEX}    IN    @{Station_list2}
        Enter Information    ${INDEX}
        Jugde Information    ${INDEX}
    END

***Keywords***
Open Browser to Maximize
    [Documentation]  Open browser to max size
    Open Browser  ${URL}  ${browser}
    Maximize Browser Window
    
Enter Information
    [Arguments]  ${station_name}
    [Documentation]  Enter Information
    
    Wait Until Page Contains Element    //*[@id ="txt_Search2"]    10
    Click Element    //*[@id = "txt_Search2"]
    Input Text       //*[@id = "txt_Search2"]    ${station_name}
    Click Element    //*[@class ="group base-wrapper"]//*[@class = "CCMS_SearchBtn"]

Jugde Information 
    [Arguments]    ${station_name}
    [Documentation]  Judge Imformation

    ${handles}=    Get Window Handles

    # ${List}=       Get Length    ${station_name}
    # FOR    ${var}    IN RANGE    ${List}  
    #     Switch Window    ${handles}[${var}]
    #     Exit For loop If    ${var} > 0
    # END

    Switch Window    ${handles}[1]

    Wait Until Page Contains Element    //*[@id ="tabs"]/ul/li[1]    10
    ${as}    Run Keyword And Return Status    Wait Until Page Does Not Contain Element   //div//ul//div//div[@class = "alert alert-danger"]
    ${Text}    Get Text    //ul[@class ="nav nav-tabs"]//h4
        
    IF  "${as}" == "True"
        Log To Console    "${station_name}" 此字串輸入正確且有${Text}個相關資訊
    ELSE IF    "${as}" == "False" 
        Log To Console    "${station_name}" 此字串輸入錯誤且有${Text}個相關資訊
    END

    Close Window
    Switch Window    ${handles}[0]  