Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 17 Feb 2017 10:33:23 +0100
Message-ID: <CACRpkdYXk_MKhaeQLqGA+8Q4g5qy-DkRymC0Ecf+_qsm+cBoBQ@mail.gmail.com>
Subject: Some throughput tests with MQ and BFQ on MMC/SD
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Ritesh Harjani <riteshh@codeaurora.org>, Avri Altman <Avri.Altman@sandisk.com>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Paolo Valente <paolo.valente@linaro.org>, =?UTF-8?Q?Per_F=C3=B6rlin?= <per.forlin@axis.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

This week I tested the following:

- Merge the in-flight BFQ work from Paolo with my MMC MQ patch set
- Enable BFQ
- Run a few iterations of classic throughput tests

dd on whole internal eMMC, 7.38 GiB:

sync
echo 3 > /proc/sys/vm/drop_caches
sync
time dd if=/dev/mmcblk3 of=/dev/null
time dd if=/dev/mmcblk3 of=/dev/null bs=1M

iozone on a Noname SD card 2GB

mount /dev/mmcblk0p1 /mnt
sync
echo 3 > /proc/sys/vm/drop_caches
sync
iozone -az -i0 -i1 -i2 -s 20m -I -f /mnt/foo.test

The results:

Before patches (v4.10-rc8):

7918845952 bytes (7.4GB) copied, 194.504059 seconds, 38.8MB/s
real    3m 14.51s
user    0m 7.41s
sys     1m 10.34s

7918845952 bytes (7.4GB) copied, 176.519531 seconds, 42.8MB/s
real    2m 56.53s
user    0m 0.06s
sys     0m 36.57s

Command line used: iozone -az -i0 -i1 -i2 -s 20m -I -f /mnt/foo.test
Output is in kBytes/sec

                                                   random    random
   kB  reclen    write  rewrite    read    reread    read     write
20480       4     1960     2105     5991     6023     5202       40
20480       8     4636     4901     9087     9103     9066       80
20480      16     5522     5663    12237    12242    12206      163
20480      32     5976     6031    14915    14917    14901      333
20480      64     6286     6387    16737    16763    16738      678
20480     128     6720     6757    17876    17857    17865     1403
20480     256     6846     6909    18230    17568    16719     3039
20480     512     7204     7229    18471    18751    18834     7209
20480    1024     7257     7315    18684    18044    18095     7337
20480    2048     7322     7388    18605    18802    19437     7401
20480    4096     7553     7652    21510    21108    21503     7688
20480    8192     7534     7745    22164    22300    22490     7758
20480   16384     7357     7818    23053    23048    23056     7834


After MMC MQ patches:

7918845952 bytes (7.4GB) copied, 196.907776 seconds, 38.4MB/s
real    3m 16.91s
user    0m 7.17s
sys     1m 8.03s

7918845952 bytes (7.4GB) copied, 192.595734 seconds, 39.2MB/s
real    3m 12.60s
user    0m 0.12s
sys     0m 33.11s

Command line used: iozone -az -i0 -i1 -i2 -s 20m -I -f /mnt/foo.test
                                                   random    random
   kB  reclen    write  rewrite    read    reread    read     write
20480       4     2049     2154     5991     5998     5934       40
20480       8     4654     4921     9081     9075     9028       81
20480      16     5572     5747    12250    12252    12177      164
20480      32     6040     6084    14858    14895    14833      335
20480      64     6370     6449    16759    16770    16715      682
20480     128     6834     6814    17882    17843    17878     1411
20480     256     6892     6900    18526    18105    18430     3066
20480     512     7239     7254    18839    18864    18837     7258
20480    1024     7342     6453    18787    18161    17522     7343
20480    2048     7408     7439    17891    18211    19029     7472
20480    4096     7641     7703    20950    21044    20900     7705
20480    8192     7584     7811    22261    22170    22385     7809
20480   16384     7407     7873    23033    23050    23048     7905


After MMC MQ+BFQ patches:

7918845952 bytes (7.4GB) copied, 197.097717 seconds, 38.3MB/s
real    3m 17.10s
user    0m 7.67s
sys     1m 7.33s

7552+0 records in
7552+0 records out
7918845952 bytes (7.4GB) copied, 187.119538 seconds, 40.4MB/s
real    3m 7.12s
user    0m 0.11s
sys     0m 34.61s

Command line used: iozone -az -i0 -i1 -i2 -s 20m -I -f /mnt/foo.test
Output is in kBytes/sec
                                                   random    random
   kB  reclen    write  rewrite    read    reread    read     write
20480       4     1734     1786     5923     5166     5894       40
20480       8     4614     4853     8950     8949     8909       80
20480      16     5525     5705    12086    12098    12040      164
20480      32     6027     6040    14765    14793    14755      334
20480      64     6341     6404    16696    16697    16670      680
20480     128     6799     6842    17830    17833    17814     1407
20480     256     6848     6849    17394    18251    17537     3054
20480     512     7191     7229    18545    18628    18801     7224
20480    1024     7241     7331    17845    17909    18206     7302
20480    2048     7375     7433    18794    19288    19675     7426
20480    4096     7583     7696    21024    21194    21082     7659
20480    8192     7555     7767    22068    22170    22168     7808
20480   16384     7350     7831    23021    23032    23050     7870


As you can see there are no huge performance regressions with these
kinds of "raw" throughput tests.

These iozone figures are unintuitive unless your head can
plot logarithmic, look at the charts here for a more visual presentation
of the iozone results:
https://docs.google.com/spreadsheets/d/1rm72TiGlTnzDeGLR__aqvjcJ2UkA-Ro3-XyKA8r1M-c

Compare this to the performance change we got when first introducing
the asynchronous requests:
https://wiki.linaro.org/WorkingGroups/KernelArchived/Specs/StoragePerfMMC-async-req

The patches need some issues fixed from the build server
complaints and some robustness hammering, but after that I
think they will be ripe for merging for v4.12.

Yours,
Linus Walleij
