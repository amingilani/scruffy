# Scruffy

A simple script to continuously test and report the quality of your DSL connection.

## Why

My ISP is full of sh*t, and doesn't run automated tests. Or if they do, they're programmed by people that have trouble counting past ten because they run out of fingers.

## How it works

Scruffy checks and logs:

1. Speed via [speedtest](https://speedtest.net);
2. Local IP details via [ifconfig](https://ifconfig.co)
3. ADSL Line stats via SNMP from your ADSL router

## Setup

1. Log into your router's configuration panel and enable SNMP.
2. Do the following:

    ```
    sudo ln -s /absolute/path/to/project /usr/local/bin
    cd /usr/local/bin/scruffy
    bundle install
    whenever --update-crontab
    ```

## Output

Every 30 minutes, the scruffy stores the result at `logs/YYYY-MM.log`

```js
{
    // testing the speed of your internet
    "speed_test": {
      // local information
        "local_info": {
            "ip": "182.185.205.84", // local ip address
            "ip_decimal": 3065630036, // in decimal
            "country": "Pakistan", // detected country
            "city": "Islamabad" // detected city
        },
        // parameters used to test the system
        "test_params": {
            "download_runs": 1, // times download tests ran
            "upload_runs": 1, // times upload tests ran
            "ping_runs": 10, // times latency tests ran
            "download_sizes": [750, 1500], // sizes download tested
            "upload_sizes": [10000, 400000], // sizes upload tested
            "debug": true // debug mode enabled during test?
        },
        // result latency in milliseconds
        "latency": 138.1456,
        // result uploadrate
        "upload_rate": {
            "raw": 715336.7880156462, // bytes
            "pretty": "698.57 Kbps" // in a pretty format
        },
        "download_rate": {
            "raw": 1829020.0705889228, // bytes
            "pretty": "1.74 Mbps"// in a pretty format
        },
        "server": "http://speedtest.ptcl.net",
        "time": {
            "start_at": "2016-09-30 23:51:45 +0500", // started at
            "end_at": "2016-09-30 23:53:27 +0500" // finished at
        }
    },
    // adsl line tests, these are self explanatory
    "adsl_test": {
        "upstream_snr_margin": 70,
        "upstream_attenuation": 79,
        "upstream_output_power": 108,
        "upstream_attainable_rate": 1128000,
        "downstream_snr_margin": 328,
        "downstream_attenuation": 185,
        "downstream_output_power": 0,
        "downstream_attainable_rate": 20704000
    }
}
```

## TODO

1. Use SQLite to store the log instead of a file.
2. Show analytics via a webserver
3. Sync backup db to s3 periodically
