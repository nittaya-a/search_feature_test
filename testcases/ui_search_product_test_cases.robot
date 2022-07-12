*** Settings ***
Resource            ../resources/locators.robot
Resource            ../resources/test_data.robot
Resource            ../Keywords/ui_search_product_keywords.robot
Library             SeleniumLibrary
Library             RPA.Browser.Selenium
Library             BuiltIn
Suite Setup         RPA.Browser.Selenium.Set Selenium Implicit Wait    ${implicit_wait}
Suite Teardown      RPA.Browser.Selenium.Close All Browsers    
Test Teardown       RPA.Browser.Selenium.Close Browser 

*** Test Cases ***
TC001_Verify_result_in_case_search_product_by_eligible_product_name_in_English
    Navigate To OfficeMate Homepage
    Input Eligible Product Name in English in Search Field
    Verify Search Result Title    Search results for "${product_name_en}"
    Verify All Product Name Should Match Search Keyword    ${product_name_en}