*** Settings ***
Resource    ../resources/test_data.robot
Resource    ../Keywords/api_search_product_keywords.robot
Library     ../libraries/encode_base64.py
Library     RequestsLibrary
Library     Collections
Library     JSONLibrary

*** Test Cases ***
TC006 Verify result in case search product by encoded eligible product name in Thai
    Input encoded eligible product name in Thai in searchQuery parameter    ${product_name_th}
    Send API Search Request
    Verify HTTP Status Code Should Be 200
    Verify Search Term Value In Response Data Should Be Equal Product Name Keyword    ${product_name_th}