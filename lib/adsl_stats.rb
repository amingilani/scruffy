require 'snmp'

# Fetches the ADSL stats via SNMP from the router
class AdslStats
  include SNMP
  def initialize
    define_oids
    Manager.open(host: '192.168.1.1') do |manager|
      response = manager.get([
                               @adslAtucCurrSnrMgn_OID,
                               @adslAtucCurrAtn_OID,
                               @adslAtucCurrOutputPwr_OID,
                               @adslAtucCurrAttainableRate_OID,
                               @adslAturCurrSnrMgn_OID,
                               @adslAturCurrAtn_OID,
                               @adslAturCurrOutputPwr_OID,
                               @adslAturCurrAttainableRate_OID,
                               @adslAturChanCurrTxRate_OID
                             ])
      @list = response.varbind_list
    end
    @list
  end

  private

  # def define_oids
  #   @adslAtucCurrSnrMgn_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.2.1.4.4'
  #   @adslAtucCurrAtn_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.2.1.5.4'
  #   @adslAtucCurrOutputPwr_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.2.1.7'
  #   @adslAtucCurrAttainableRate_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.2.1.8'
  #   @adslAturCurrSnrMgn_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.3.1.4'
  #   @adslAturCurrAtn_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.3.1.5'
  #   @adslAturCurrOutputPwr_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.3.1.7'
  #   @adslAturCurrAttainableRate_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.3.1.8'
  #   @adslAturChanCurrTxRate_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.5.1.2'
  # end

  def define_oids
    @adslAtucCurrSnrMgn_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.2.1.4.4'
    @adslAtucCurrAtn_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.2.1.5.4'
    @adslAtucCurrOutputPwr_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.2.1.7.4'
    @adslAtucCurrAttainableRate_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.2.1.8.4'
    @adslAturCurrSnrMgn_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.3.1.4.4'
    @adslAturCurrAtn_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.3.1.5.4'
    @adslAturCurrOutputPwr_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.3.1.7.4'
    @adslAturCurrAttainableRate_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.3.1.8.4'
    @adslAturChanCurrTxRate_OID = ObjectId.new '1.3.6.1.2.1.10.94.1.1.5.1.2.4'
  end
end
