require 'dotenv'

@hosts = {
  # local network
  localhost: '127.0.0.1',
  gateway_lan: '192.168.1.1',
  gateway_wan: '',

  # PTCL DNS
  dns_ptcl_1: '203.99.163.203',
  dns_ptcl_2: '119.159.255.132',
  dns_ptcl_3: '119.159.255.12',
  dns_ptcl_4: '182.176.39.17',
  dns_ptcl_5: '202.125.132.12',
  dns_ptcl_6: '203.125.132.9',
  dns_ptcl_7: '116.71.241.198',
  dns_ptcl_8: '116.71.241.214',
  dns_ptcl_9: '116.71.241.216',
  dns_ptcl_10: '203.99.163.203',
  dns_ptcl_11: '119.159.255.132',

  # Global Internet
  dns_google_1: '8.8.8.8',
  dns_google_2: '8.8.4.4',
  dns_opendns_1: '208.67.222.222',
  dns_opendns_2: '208.67.220.220'
}
