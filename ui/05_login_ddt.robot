*** Settings ***
Library     SeleniumLibrary
Resource    login_page.resource
Suite Setup       Open Browser    https://www.saucedemo.com    chrome
Suite Teardown    Close Browser
Test Template     Validar Intento De Login
 
*** Test Cases ***           USUARIO              CLAVE            RESULTADO_ESPERADO
Usuario estandar             standard_user        secret_sauce     exito
Usuario bloqueado            locked_out_user      secret_sauce     error
Clave incorrecta             standard_user        clave_invalida   error
Usuario vacio                ${EMPTY}             secret_sauce     error
 
*** Keywords ***
Validar Intento De Login
    [Arguments]    ${usuario}    ${clave}    ${resultado}
    Go To    https://www.saucedemo.com
    Ingresar Credenciales    ${usuario}    ${clave}
    Run Keyword If    '${resultado}' == 'exito'
    ...    Wait Until Page Contains    Products
    ...    ELSE
    ...    Element Should Be Visible    css:h3[data-test='error']

Agregar Al Carrito
    [Documentation]    Hace clic en el botón "Add to cart" del producto indicado.
    [Arguments]    ${boton_producto}
    Click Button    ${boton_producto}

Verificar Cantidad En Carrito
    [Documentation]    Valida que el ícono del carrito muestre la cantidad esperada.
    [Arguments]    ${cantidad_esperada}
    Element Text Should Be    css:.shopping_cart_badge 