*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://reqres.in/api
${API_KEY}     free_user_3GDPRcTBN35d29H0jjuAAP3746c

*** Test Cases ***
Obtener Lista De Usuarios
    &{headers}=    Create Dictionary    x-api-key=${API_KEY}
    Create Session    reqres    ${BASE_URL}    headers=${headers}
    ${response}=    GET On Session    reqres    url=/users?page=2
    Status Should Be    200    ${response}
    ${total}=    Get From Dictionary    ${response.json()}    total
    Should Be True    ${total} > 0

Crear Nuevo Usuario
    &{headers}=    Create Dictionary    x-api-key=${API_KEY}
    Create Session    reqres    ${BASE_URL}    headers=${headers}
    &{payload}=    Create Dictionary    name=Carlos    job=QA Engineer
    ${response}=    POST On Session    reqres    /users    json=${payload}
    Status Should Be    201    ${response}
    Should Be Equal    ${response.json()}[name]    Carlos

Obtener Usuario Inexistente
    &{headers}=    Create Dictionary    x-api-key=${API_KEY}
    Create Session    reqres    ${BASE_URL}    headers=${headers}
    ${response}=    GET On Session    reqres    url=/unknown/999    expected_status=404
    Status Should Be    404    ${response}