*** Settings ***
Library    SeleniumLibrary
 
*** Variables ***
${INPUT_USER}      id:user-name
${INPUT_PASS}      id:password
${BTN_LOGIN}        id:login-button
${MSG_ERROR}        css:h3[data-test='error']
 
*** Keywords ***
Ingresar Credenciales
    [Arguments]    ${usuario}    ${clave}
    Input Text        ${INPUT_USER}    ${usuario}
    Input Password     ${INPUT_PASS}    ${clave}
    Click Button        ${BTN_LOGIN}
