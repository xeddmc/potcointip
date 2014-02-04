# Reddit Potcointip bot

This is a fork of vindimy's ALTcointip bot(https://github.com/vindimy/altcointip) to work with Potcoin.

## Introduction

For introduction to and use of Potcointip bot, see __http://www.reddit.com/r/potcoin/wiki/index__

## Getting Started


### Python Dependencies

The following Python libraries are necessary to run Potcointip bot:

* __jinja2__ (http://jinja.pocoo.org/)
* __pifkoin__ (https://github.com/dpifke/pifkoin)
* __praw__ (https://github.com/praw-dev/praw)
* __sqlalchemy__ (http://www.sqlalchemy.org/)
* __yaml__ (http://pyyaml.org/wiki/PyYAML)

You can install `jinja2`, `praw`, `sqlalchemy`, and `yaml` using `pip` (Python Package Index tool) or a package manager in your OS. For `pifkoin`, you'll need to copy or symlink its "python" subdirectory to `src/ctb/pifkoin`.

* Example

`sudo pip install yaml`

The above command will install yaml using pip.

### Database

Create a new MySQL database instance and run included SQL file [potcointip.sql](potcointip.sql) to create necessary tables. Create a MySQL user and grant it all privileges on the database. If you don't like to deal with command-line MySQL, use `phpMyAdmin`.

### Coin Daemons

Download the potcoin daemon executable. Create a configuration file for it in appropriate directory (such as `~/.potcoin/potcin.conf` for Potcoin), specifying `rpcuser`, `rpcpassword`, `rpcport`, and `server=1`, then start the daemon. It will take some time for the daemon to download the blockchain, after which you should verify that it's accepting commands (such as `potcoind getinfo` and `potcoind listaccounts`).

### Reddit Account

You should create a dedicated Reddit account for your bot. Initially, Reddit will ask for CAPTCHA input when bot posts a comment or message. To remove CAPTCHA requirement, the bot account needs to accumulate positive karma (2 link karma).

### Configuration

Copy included set of configuration files [src/conf-sample/](src/conf-sample/) as `src/conf/` and edit `reddit.yml`, `db.yml`, `coins.yml`, and `regex.yml`, specifying necessary settings.

Most configuration options are described inline in provided sample configuration files.

### Running the Bot

1. Ensure MySQL is running and accepting connections given configured username/password
1. Ensure each configured coin daemon is running and responding to commands
1. Ensure Reddit authenticates configured user. _Note that from new users Reddit will require CAPTCHA responses when posting and sending messages. You will be able to type in CAPTCHA responses when required._
1. Execute `_start.sh` from [src](src/) directory. The command will not return for as long as the bot is running.

Potcointip bot is configured by default to append INFO-level log messages to `logs/info.log`, and WARNING-level log messages to `logs/warning.log`, while DEBUG-level log messages are output to the console.

### Cron: Backups

Backups are very important! The last thing you want is losing user wallets or record of transactions in the databse. 

There are three simple backup scripts included that support backing up database, wallets, and configuration files to local directory and (optionally) to a remote host with `rsync`. Make sure to schedule regular backups with cron and test whether they are actually performed. Example cron configuration:

    0 8,20 * * * cd /path/to/potcointip/src && python _backup_db.py ~/backups
    0 9,21 * * * cd /path/to/potcointip/src && python _backup_wallets.py ~/backups
    0 10 * * * cd /path/to/potcointip/src && python _backup_config.py ~/backups

### Cron: Statistics

Potcointip bot can be configured to generate tipping statistics pages (overall and per-user) and publish them using subreddit's wiki. After you configure and enable statistics in configuration, add the following cron job to update the main statistics page periodically:

    0 */3 * * * cd /path/to/potcointip/src && python _update_stats.py
