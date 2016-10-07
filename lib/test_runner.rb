require 'speedtest'
require 'httparty'
require 'fileutils'

# The TestRunner
class TestRunner
  attr_accessor :test_params
  attr_accessor :test
  attr_accessor :result
  attr_accessor :error

  def initialize
    test
  end

  # The default test params
  # @return [Hash]
  def test_params
    @test_params ||= {
      download_runs: 1,
      upload_runs: 1,
      ping_runs: 10,
      download_sizes: [750, 1500],
      upload_sizes: [10_000, 400_000],
      debug: true
    }
  end

  # Define a new test with the default test params
  # @return [Speedtest]
  def test
    @test = Speedtest::Test.new test_params
  end

  # Return the result of the test
  # @return [Speedtest::run]
  def result
    @start_at ||= Time.now
    if @result.nil?
      begin
        @result = @test.run
      rescue
        @result = nil
      end
    end
    @end_at ||= Time.now
    @result
  end

  # Was an error encountered during this test?
  def error
    @error ||= false
  end

  def host_info
    begin
      response = HTTParty.get 'https://ifconfig.co/json'
      result = JSON.parse(response.body)
    rescue
      @error = true
      result = nil
    end
    result
  end

  def to_data
    {
      local_info: host_info,
      test_params: @test_params,
      latency: latency,
      upload_rate: upload_rate_hash,
      download_rate: download_rate_hash,
      server: server,
      time: timestamp_hash,
      error: error
    }
  end

  private

  def upload_rate_hash
    return nil if result.nil?
    {
      raw: result.upload_rate,
      pretty: result.pretty_upload_rate
    }
  end

  def download_rate_hash
    return nil if result.nil?
    {
      raw: result.download_rate,
      pretty: result.pretty_download_rate
    }
  end

  def timestamp_hash
    {
      start_at: @start_at,
      end_at: @end_at
    }
  end

  def latency
    result.nil? ? nil : result.latency
  end

  def server
    result.nil? ? nil : result.server
  end
end
