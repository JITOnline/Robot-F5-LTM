*** Settings ***
Resource    ../common.resource
Variables   settings.yaml
Library     ../F5Rest.py  ${f5_primary}   ${user}

*** Test Cases ***
V4 Route Health Injection
    [Documentation]     Not Implemented
    No Operation

V6 Route Health Injection
    [Documentation]     Not Implemented
    No Operation
