twitter-geo-data
================

A script for gathering large amounts of twitter geo data over several days. Simply run the script and data will be dumped into a log rotated tsv.

## Detailed usage instructions
Before you can get started, you'll need a developer account for Twitter.

1- Create a Twitter account first if you don't have one. [Click here](https://twitter.com/)

2- Create a Twitter application. [Click here](https://dev.twitter.com/apps/new)

3- Add Consumer key, Consumer secret, Access token, Access token secret to the credentials.json file.

4- Make sure you have Ruby installed (use 1.9.3 for best results). You'll also need the bundler gem installed.
To get it, run:
> gem install bundler

5- Run bundler
> bundle install

6- Let the script run and collect data
> ./collect.rb

If you want the task to run in the background, simply do:
> ./collect.rb&

All collected data will be placed in data/geo-data.tsv. The logs will rotate every day automatically.
Data will be logged as tab separated with the following format:
created_at  tweet_id    tweet_language  tweet_country   lat lng

Misc notes:
* This script has only been tested with ruby-1.9.3-p327. You should use that for best results.
* Only geo tagged tweets will be logged.
* This script uses the sample stream, which only sees a very small fraction of tweets.
* Not all tweets are annotated with a tweet_country
* If twitter isn't able to determine the language of a tweet, the language code will be und
