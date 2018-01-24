# versions
Script to fetch (and store) the latest platform versions

Run the script:

    ./versions.sh magento

To include it in a cron:

    ./versions.sh -q magento

To list all platform's versions (from the files created by the script):

    for i in `ls`; do echo -e "$i:\t`cat $i`"; done

Would output something like:

    magento:	1.9.3.7
    magento2:	2.2.2
    prestashop:	1.7.2.4
    prestashop16:	1.6.1.17
    prestashop17:	1.7.2.4
    wordpress:	4.9.2

