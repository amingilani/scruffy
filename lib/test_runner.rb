require 'speedtest'
require 'httparty'
require 'fileutils'

# The TestRunner
class TestRunner
  attr_accessor :test_params
  attr_accessor :test
  attr_accessor :result

  def initialize
    test
  end

  def test
    @test = Speedtest::Test.new test_params
  end

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

  def run_at
    raise 'Test not yet run' if @start_at.nil?
    @start_at
  end

  def result
    @start_at ||= Time.now
    if @result.nil?
      puts "The time is: #{Time.now}"
      @result = @test.run
    end
    @end_at ||= Time.now

    @result
  end

  def host_info
    response = HTTParty.get 'https://ifconfig.co/json'
    JSON.parse(response.body)
  end

  def to_data
    {
      local_info: host_info,
      test_params: @test_params,
      latency: result.latency,
      upload_rate: upload_rate_hash,
      download_rate: download_rate_hash,
      server: result.server,
      time: timestamp_hash
    }
  end

  private

  def upload_rate_hash
    {
      raw: result.upload_rate,
      pretty: result.pretty_upload_rate
    }
  end

  def download_rate_hash
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
end
