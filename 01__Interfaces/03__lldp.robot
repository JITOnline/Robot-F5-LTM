*** Settings ***
Resource    ../common.resource
Library     ../F5Rest.py  ${f5_primary}     ${user}

*** Test Cases ***
Show net lldp-neighbors
    [Documentation]
    tmsh show net lldp-neighbors all-properties
