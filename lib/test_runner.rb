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
    {
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
      latency: {
        pretty: result.latency
      },
      upload_rate: {
        raw: result.upload_rate,
        pretty: result.pretty_upload_rate
      },
      download_rate: {
        raw: result.download_rate,
        pretty: result.pretty_download_rate
      },
      server: result.server,
      time: { start_at: @start_at,
              end_at: @end_at }
    }
  end

  def save_to_file(folder = 'logs')
    date = "#{Time.now.year}-#{Time.now.month}"

    FileUtils.mkdir_p(folder) unless File.directory?(folder)
    line = to_data.to_json

    open("#{folder}/#{date}.json", 'a') do |f|
      f << "#{line}\n"
    end
  end
end
