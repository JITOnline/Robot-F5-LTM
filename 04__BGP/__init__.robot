*** Settings ***
Documentation    BGP Routing Protocol Tests
Resource        ../common.resource
Library         ../F5Rest.py  ${f5_primary}     ${user}     WITH NAME  primary
Library         ../F5Rest.py  ${f5_secondary}   ${user}     WITH NAME  secondary
Variables       settings.yaml
Suite Setup     Setup F5
#Suite Teardown  Teardown

*** Keywords ***
Setup F5
    [Documentation]     Setup for the F5 BGP routing tests.
    [tags]  Setup
    # ZebOS config is pushed in suite setup
    # Add v4 peers (deprecated))
    # Add v6 peers (deprecated)
    # Log ZebOS configuration
    ${result}       primary.imish -c 'show run'
    Log             ${result}
    ${result}       secondary.imish -c 'show run'
    Log             ${result}

Add v4 peers
    [Documentation]     Add IPv4 Peers to the ZebOS Configuration
    :for    ${neighbor}     IN  @{v4_peers}
    \   primary.imish -c 'enable','conf t','router bgp ${asn}','neighbor ${neighbor} peer-group ${v4_peer_group}'
    \   primary.imish -c 'enable','conf t','router bgp ${asn}','address-family ipv4','neighbor ${neighbor} activate'
    \   secondary.imish -c 'enable','conf t','router bgp ${asn}','neighbor ${neighbor} peer-group ${v4_peer_group}'
    \   secondary.imish -c 'enable','conf t','router bgp ${asn}','address-family ipv4','neighbor ${neighbor} activate'

Add v6 peers
    [Documentation]     Add IPv6 Peers to the ZebOS Configuration
    :for    ${neighbor}     IN  @{v6_peers}
    \   primary.imish -c 'enable','conf t','router bgp ${asn}','neighbor ${neighbor} peer-group ${v6_peer_group}'
    \   primary.imish -c 'enable','conf t','router bgp ${asn}','address-family ipv6','neighbor ${neighbor} activate'
    \   secondary.imish -c 'enable','conf t','router bgp ${asn}','neighbor ${neighbor} peer-group ${v6_peer_group}'
    \   secondary.imish -c 'enable','conf t','router bgp ${asn}','address-family ipv6','neighbor ${neighbor} activate'

Teardown
    [Documentation]     Teardown the configuration for this test suite.
    [tags]  Teardown
    No Operation