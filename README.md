# Scruffy

A simple script to continuously test and report the quality of your DSL connection.

I made this because my ISP is full of shit, and doesn't run automated tests. Or if they do, they're programmed by people that couldn't count past ten because they ran out of fingers.

## Setup

```
sudo ln -s /absolute/path/to/project /usr/local/bin
cd /usr/local/bin/scruffy
bundle install
whenever --update-crontab
```

## Output

Every 30 minutes, the quality of your internet is tested and the result stored at `logs/YYYY-MM.log`

The output of the cronjobs is stored at `logs/cron.log`
