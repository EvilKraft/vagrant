## Synopsis

My Vagrant configuration


## Installation

1. Install Oracle VirtualBox https://www.virtualbox.org/wiki/Downloads

2. Install Vagrant https://www.vagrantup.com/downloads.html

3. Clone this repository to some directory on your machine. Inside that directory execute the following steps.

4. Edit Vagrantfile file.

4.1. On line 4 replace change value of IP_ADDRESS_PRIVATE with an actual number.

4.2. On line 6 replace change value of public IP_ADDRESS with an actual number.

4.3. On line 7 replace change value of DEFAULT_GETAWAY with an actual number.

4.4. On line 9-11 choose one of provsion scripts

4.5. On line 14 set value of PROJECT_WWW_DIR to the directory on your machine with your PHP projects.

4.6. On line 15 set value of PROJECT_LOG_DIR to the directory where you want to keep Apache logs.

4.7. On line 16 set value of PROJECT_SENDMAIL_DIR to the directory where you want to receive the e-mails sent by sendmail.

4.8. On line 21 set array of network interfaces you want vagrant coose from

8. Run console command "vagrant up".

9. Enjoy! :)

P.S. default username ans password (with sudo) are "vagrant"

