*** Keywords ***
Navigate To OfficeMate Homepage
    RPA.Browser.Selenium.Open Browser    ${homepage_url}    browser=${web_browser}
    RPA.Browser.Selenium.Maximize Browser Window    

Input Eligible Product Name in English in Search Field
    RPA.Browser.Selenium.Select Frame    //iframe[@classname='sp-fancybox-iframe sp-fancybox-skin sp-fancybox-iframe-11313']
    RPA.Browser.Selenium.Click Element When Visible   ${ads_close_button}
    RPA.Browser.Selenium.Wait Until Element Is Visible    ${search_field}
    RPA.Browser.Selenium.Input Text    ${search_field}    ${product_name_en}
    RPA.Browser.Selenium.Capture Page Screenshot    ../result/screenshots/Input_Eligible_Product_Name_in_English_in_Search_Field.png
    RPA.Browser.Selenium.Click Element    ${search_button}

Verify Search Result Title
    [Arguments]    ${expected_search_result_title}
    RPA.Browser.Selenium.Wait Until Element Is Visible    ${search_result_title}
    ${actual_search_result_title}    RPA.Browser.Selenium.Get Text    ${search_result_title}
    Should Be Equal    ${expected_search_result_title}    ${actual_search_result_title}

Verify All Product Name Should Match Search Keyword
    [Arguments]    ${expected_result}
    RPA.Browser.Selenium.Wait Until Element Is Visible    ${all_product_name}
    ${total_product}    RPA.Browser.Selenium.Get Element Count    ${all_product_name}
    FOR  ${index}  IN  ${total_product}
        ${actual_product_name}    RPA.Browser.Selenium.Get Text    //a[@data-product-position='${index}']
        ${result}    BuiltIn.Should Match Regexp    ${actual_product_name}    ${expected_result}
    END
    RPA.Browser.Selenium.Capture Page Screenshot    ../result/screenshots/Search_Result_Input_Eligible_Product_Name_in_English.png