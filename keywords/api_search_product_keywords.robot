*** Keywords ***
Set Query Parameter for API Search
    [Arguments]            ${search_query}    ${limit}    ${page}    ${store_id}    ${x_subject_id}    ${price_range}    ${visibility}
    ${query_param}         Create Dictionary
    Set To Dictionary    ${query_param}    searchQuery=${search_query}
    Set To Dictionary    ${query_param}    limit=${limit}
    Set To Dictionary    ${query_param}    page=${page}
    Set To Dictionary    ${query_param}    store_id=${store_id}
    Set To Dictionary    ${query_param}    x_subject_id=${x_subject_id}
    Set To Dictionary    ${query_param}    price_range=${price_range}
    Set To Dictionary    ${query_param}    visibility=${visibility}
    Set Test Variable      ${params}    ${query_param}
    Log To Console    ${params}

Input encoded eligible product name in Thai in searchQuery parameter
    [Arguments]    ${search_query}
    Set Query Parameter for API Search    ${search_query}    ${limit}    ${page}    ${store_id}    ${x_subject_id}    ${price_range}    ${visibility}

Get Request API
    [Arguments]    ${alias}    ${host_url}     ${uri}      ${params}
    Create Session    ${alias}    ${host_url}    disable_warnings=1
    # Get Request
     ${response}     Get On Session     alias=${alias}      url=${uri}      params=${params}    expected_status=Anything
    #Get Response Code
    ${http_response_code}    Set Variable    ${response.status_code}
    Set Test Variable    ${http_response_code}  ${http_response_code}
    [Return]     ${response.json()}


Send API Search Request
    Log To Console    Params: ${params}
    ${response_body}    Get Request API    API-Search    ${host_url}    ${search_uri}    ${params}
    # Log To Console    Http Response Code: ${http_response_code}
    # Log To Console    Response Body: ${response_body}
    Set Test Variable    ${response_body}    ${response_body}

Verify HTTP Status Code Should Be 200
    BuiltIn.Should Be Equal As Integers    ${http_response_code}    200

Verify Search Term Value In Response Data Should Be Equal Product Name Keyword
    [Arguments]    ${expected_product_name_keyword}
    ${search_term_value_list}    Get Value From Json    ${response_body}    $.products.search_criteria.filterGroups[3].filters[0].value
    ${search_term_value}    Get From List    ${search_term_value_list}    ${0}
    Should Be Equal As Strings    ${search_term_value}   ${expected_product_name_keyword}