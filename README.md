# profile-mac
mac rc / profiles


## Enable Postfix (MTA)

source: [Configuring Postfix to Send Mail from Mac OS X Mountain Lion](https://benjaminrojas.net/configuring-postfix-to-send-mail-from-mac-os-x-mountain-lion/) 
source: [Sign in using App Passwords](https://support.google.com/accounts/answer/185833)
source: [Configure Postfix for Gmail SMTP in Mac OSX](https://gist.github.com/joech4n/d59e7bc9f99273fbda31)

### Update postfix config

First, 
- Update `/etc/postfix/main.cf`
- Create `/etc/postfix/sasl_passwd`.
- Create `/etc/postfix/sasl_passwd.db` by running `sudo postmap sasl_passwd`
- Run `sudo postfix start`, check `/var/log/mail.log`
- Try to send mail to you `date | mail -s my-subject EMAIL@ADDRESS`, then check `/var/log/mail.log`.


### LaunchDaemon

- First, [disable SIP](http://www.shoutpedia.com/enable-disable-system-integrity-protection-rootless-mac-os/).


- Update `/System/Library/LaunchDaemon/com.apple.postfix.master.plist`
  - Remove -e 60 from `ProgramArgument`
  - Add `KeepAlive`:

        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>Label</key>
            <string>com.apple.postfix.master</string>
            <key>Program</key>
            <string>/usr/libexec/postfix/master</string>
            <key>ProgramArguments</key>
            <array>
                <string>master</string>
            </array>
            <key>QueueDirectories</key>
            <array>
                <string>/var/spool/postfix/maildrop</string>
            </array>
            <key>AbandonProcessGroup</key>
            <true/>
            <key>KeepAlive</key>
            <true/>
        </dict>
        </plist>

- unload / load the plist file

        $ sudo launchctl unload /System/Library/LaunchDaemons/com.apple.postfix.master.plist
        $ sudo launchctl load /System/Library/LaunchDaemons/com.apple.postfix.master.plist
        $ ps -ef | grep master   # to check postfix master process alive

- Enable SIP again.
