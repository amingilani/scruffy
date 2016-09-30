require 'snmp'

# Fetches the ADSL stats via SNMP from the router
class AdslStats
  include SNMP

  attr_accessor :result

  def initialize
    define_oids
    Manager.open(host: '192.168.1.1') do |manager|
      response = manager.get(@oids.map(&:last))
      @list = response.varbind_list
    end
    # result is a hash of oid names and values
    @result = @list
              .each_with_index
              .map { |v, i| [@oids.map(&:first)[i], v.value.to_i] }
              .to_h
  end

  private

  def foo(list)
    new_list = []
    list.each do |member|
      new_list << member
    end
    new_list
  end

  def define_oids
    @oids = [
      ['upstream_snr_margin', '1.3.6.1.2.1.10.94.1.1.2.1.4.4'],
      ['upstream_attenuation', '1.3.6.1.2.1.10.94.1.1.2.1.5.4'],
      ['upstream_output_power', '1.3.6.1.2.1.10.94.1.1.3.1.7.4'],
      ['upstream_attainable_rate', '1.3.6.1.2.1.10.94.1.1.2.1.8.4'],
      ['downstream_snr_margin', '1.3.6.1.2.1.10.94.1.1.3.1.4.4'],
      ['downstream_attenuation', '1.3.6.1.2.1.10.94.1.1.3.1.5.4'],
      ['downstream_output_power', '1.3.6.1.2.1.10.94.1.1.2.1.7.4'],
      ['downstream_attainable_rate', '1.3.6.1.2.1.10.94.1.1.3.1.8.4']
    ]
  end
end
