*** Settings ***
Library    SeleniumLibrary
 
*** Variables ***
${URL}         https://www.saucedemo.com

${BROWSER}     chrome
 
*** Test Cases ***
Login Exitoso Con Usuario Valido
    Abrir Sitio Swag Labs
    Iniciar Sesion    standard_user    secret_sauce
    Verificar Login Exitoso
    [Teardown]    Close Browser
 
Login Fallido Con Usuario Bloqueado
    Abrir Sitio Swag Labs
    Iniciar Sesion    locked_out_user    secret_sauce
    Verificar Mensaje De Error
    [Teardown]    Close Browser
 
*** Keywords ***
Abrir Sitio Swag Labs
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
 
Iniciar Sesion
    [Arguments]    ${usuario}    ${clave}
    Input Text        id:user-name    ${usuario}
    Input Password     id:password    ${clave}
    Click Button        id:login-button
 
Verificar Login Exitoso
    Wait Until Page Contains    Products    timeout=5s
 
Verificar Mensaje De Error
    Element Should Be Visible    css:h3[data-test='error']
