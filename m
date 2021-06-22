Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F375DC2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C91F561040
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFVXWQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 19:22:16 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20383 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFVXWQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 19:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624403999; x=1655939999;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6EIyEKJp8sCXdCM9jWjRZhD0V0r4RVX4yiV+YpLx0UI=;
  b=aVoej8+alXrSo6kuvaJ4FvpCCmj82rACJ0BDnYrHotm816bNSaL/V0Rd
   0LXOd7H1kWXJzZViZl6+qw7j6F4mmUqkdBqqp4Eq3427SVlwz+s8oMfcT
   LSo02e7Vtl/HL+Yzyq4RY7t6tnvqCpxS2khc7GWyqpUF3mJ72BiLqEhWA
   QK6F73Gpr3Gvo5ZU9SGoIKM3B+Uqdy+YgmCwF3KfcpcGY1dw1hfdwk2MA
   X1zFM4/AkS4RbCJiHT9CI/eZp3EIVazfiUU6PhhJHsV3y007Prt7lq/1+
   pAOuTqRPgSZDLmdxIdKUp+pZaUfVuT8k4yO28hllTd4UlwYHUdcuW36Y3
   A==;
IronPort-SDR: RUfYpLxP9HGIl7J/2yfGBjwBLQ+CjOfIPzYPJ2nQ/Du7wJ3zcYEDMamNKlQxqWKYkVdOy63NPp
 z+WLSK3y/9IjgUl6XDBBe2QotqjqHUpAI6visTP6xkWKbujBWWJ03Ncuk/3VSRnhn0//bQzzN7
 9gxiOARHLc/oglxqrRnXSgNRm587D1XMkGbreo4BPCNnJzOvf+udiKHKvKSrxeTqrcU9DmN+6/
 4dPH0zbm9PYP0KotCAO41XY3zx17tURNhxhqob8uKgmrbE9eTtmsjArWMfwyNsf3Ldp1x92yuP
 VCk=
X-IronPort-AV: E=Sophos;i="5.83,292,1616428800"; 
   d="scan'208";a="172632920"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2021 07:19:59 +0800
IronPort-SDR: s4y2GzeFKZJEzWoyzySCgXbjTbvsYbTfmgikRoAwG1UuO+OmXZJFPOGAXq6g+zO5ERKsRt7LqJ
 i5S8l2AdZYyZPg5YgIb5pTdRTajPn778l/XlFq0tWWlCvD+24sm5q41gdpCgJ0DtTeWqXBnBuC
 cXqa0qTVUKua2BkkrRcXFsprrPbrKwdCRZAoFCexB8rJw3qETC63GjAh+ooTw5aRhabLjfzykl
 i8pBk5af5OcSgBKSNlaB+E8QZ95r5RqkdbaH64Ia1J860RhUQUuR4wohTKRwdIxn87PKR1Wg9n
 b557P+2ldEp1X+D3FrcqAetk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:58:36 -0700
IronPort-SDR: bvLm7govy5AUFB6QRgoxsZFKayQTj/tXAejh9/rt63F2jrXvI2CGVCTQ3LxTKQYnU/05YT0jXv
 raLXhaKe4od1qPHXWF0TAIdUolm2msbrUZfM4DAvhJDvG7WQgZfix1z2R/vAjdXgiXobOrnCLm
 ojP+6UNaQUEAq6emXNJ6xsxv1P98CwLN6iA3TiRyb/8j0YdbYq539L4dsa0g5/H96C5Z13GA5n
 mI/kU3Lwt1mybiJV2r174+tHaPh6ax6LZel/HW0Y65D/ZECbJrm6prndrOgziaKG4IKeWpV1tP
 O1c=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Jun 2021 16:19:59 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/9] loop: small clenaup
Date:   Tue, 22 Jun 2021 16:19:42 -0700
Message-Id: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This has few improvment and cleanups such as using sysfs_emit() for the
sysfs dev attributes and removing variables that are only used once and
a cleanup with fixing declaration.

Below is the test log where 10 loop devices created, each deivce is
linked to it's own file in /tmp/loopX, formatted with xfs and mounted on
/mnt/loopX. For each device it reads the offset, sizelimit, autoclear,
partscan, and dio attr from sysfs using cat command, then it runs fio
verify job on it.

In summary write-verify fio job seems to work fine :-

write-and-verify: (groupid=0, jobs=1): err= 0: pid=17434: Tue Jun 22 01:19:46 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=17480: Tue Jun 22 01:20:44 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=17580: Tue Jun 22 01:21:53 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=17630: Tue Jun 22 01:23:07 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=17680: Tue Jun 22 01:24:20 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=17792: Tue Jun 22 01:25:31 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=17949: Tue Jun 22 01:26:50 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=18028: Tue Jun 22 01:28:01 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=18179: Tue Jun 22 01:29:12 2021
write-and-verify: (groupid=0, jobs=1): err= 0: pid=18300: Tue Jun 22 01:30:15 2021

-ck

Chaitanya Kulkarni (9):
  loop: use sysfs_emit() in the sysfs offset show
  loop: use sysfs_emit() in the sysfs sizelimit show
  loop: use sysfs_emit() in the sysfs autoclear show
  loop: use sysfs_emit() in the sysfs partscan show
  loop: use sysfs_emit() in the sysfs dio show
  loop: remove extra variable in lo_fallocate()
  loop: remove extra variable in lo_req_flush
  loop: remove the extra line in declaration
  loop: allow user to set the queue depth

 drivers/block/loop.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

# gitlog -9 
79bae3edbc3e (HEAD -> for-next) loop: allow user to set the queue depth
bc711b2d44a7 loop: remove the extra line in declaration
7c871452de8c loop: remove extra variable in lo_req_flush
cb228a9f1d68 loop: remove extra variable in lo_fallocate()
325aab6e5d65 loop: use sysfs_emit() in the sysfs dio show
6817f2e8e765 loop: use sysfs_emit() in the sysfs partscan show
a96444f66e15 loop: use sysfs_emit() in the sysfs autoclear show
56cfb89c1644 loop: use sysfs_emit() in the sysfs sizelimit show
2c6c098456c2 loop: use sysfs_emit() in the sysfs offset show
# ./test_loop.sh 10 
+ FILE=/tmp/loop
+ LOOP_MNT=/mnt/loop
+ NN=10
+ unload_loop
++ shuf -i 1-10 -n 10
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop3
umount: /mnt/loop3: mountpoint not found
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop6
umount: /mnt/loop6: mountpoint not found
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop7
umount: /mnt/loop7: mountpoint not found
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop10
umount: /mnt/loop10: mountpoint not found
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop1
umount: /mnt/loop1: mountpoint not found
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop4
umount: /mnt/loop4: mountpoint not found
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop9
umount: /mnt/loop9: mountpoint not found
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop2
umount: /mnt/loop2: mountpoint not found
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop8
umount: /mnt/loop8: mountpoint not found
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop5
umount: /mnt/loop5: mountpoint not found
+ losetup -D
+ sleep 3
+ rmmod loop
rmmod: ERROR: Module loop is not currently loaded
+ modprobe -r loop
+ lsmod
+ grep loop
+ rm -fr '/mnt/loop*'
+ compile_loop
++ nproc
+ make -j 64 M=drivers/block modules
+ HOST=drivers/block/
++ uname -r
+ HOST_DEST=/lib/modules/5.13.0-rc6blk+/kernel/drivers/block
+ cp drivers/block//loop.ko /lib/modules/5.13.0-rc6blk+/kernel/drivers/block/
+ load_loop
+ insmod drivers/block/loop.ko max_loop=11 hw_queue_depth=256
++ shuf -i 1-10 -n 10
+ for i in '`shuf -i  1-$NN -n $NN`'
+ mkdir -p /mnt/loop3
+ truncate -s 2048M /tmp/loop3
+ /root/util-linux/losetup --direct-io=on /dev/loop3 /tmp/loop3
+ /root/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE  DIO LOG-SEC
/dev/loop3         0      0         0  0 /tmp/loop3   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop3
Discarding blocks...Done.
meta-data=/dev/loop3             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
+ mount /dev/loop3 /mnt/loop3
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop3/loop/offset : '
cat /sys/block/loop3/loop/offset : + cat /sys/block/loop3/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop3/loop/sizelimit : '
cat /sys/block/loop3/loop/sizelimit : + cat /sys/block/loop3/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop3/loop/autoclear : '
cat /sys/block/loop3/loop/autoclear : + cat /sys/block/loop3/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop3/loop/partscan : '
cat /sys/block/loop3/loop/partscan : + cat /sys/block/loop3/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop3/loop/dio : '
cat /sys/block/loop3/loop/dio : + cat /sys/block/loop3/loop/dio
1
+ for i in '`shuf -i  1-$NN -n $NN`'
+ mkdir -p /mnt/loop4
+ truncate -s 2048M /tmp/loop4
+ /root/util-linux/losetup --direct-io=on /dev/loop4 /tmp/loop4
+ /root/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE  DIO LOG-SEC
/dev/loop4         0      0         0  0 /tmp/loop4   1     512
/dev/loop3         0      0         0  0 /tmp/loop3   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop4
Discarding blocks...Done.
meta-data=/dev/loop4             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
+ mount /dev/loop4 /mnt/loop4
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop4/loop/offset : '
cat /sys/block/loop4/loop/offset : + cat /sys/block/loop4/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop4/loop/sizelimit : '
cat /sys/block/loop4/loop/sizelimit : + cat /sys/block/loop4/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop4/loop/autoclear : '
cat /sys/block/loop4/loop/autoclear : + cat /sys/block/loop4/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop4/loop/partscan : '
cat /sys/block/loop4/loop/partscan : + cat /sys/block/loop4/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop4/loop/dio : '
cat /sys/block/loop4/loop/dio : + cat /sys/block/loop4/loop/dio
1
+ for i in '`shuf -i  1-$NN -n $NN`'
+ mkdir -p /mnt/loop6
+ truncate -s 2048M /tmp/loop6
+ /root/util-linux/losetup --direct-io=on /dev/loop6 /tmp/loop6
+ /root/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE  DIO LOG-SEC
/dev/loop6         0      0         0  0 /tmp/loop6   1     512
/dev/loop4         0      0         0  0 /tmp/loop4   1     512
/dev/loop3         0      0         0  0 /tmp/loop3   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop6
Discarding blocks...Done.
meta-data=/dev/loop6             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
+ mount /dev/loop6 /mnt/loop6
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop6/loop/offset : '
cat /sys/block/loop6/loop/offset : + cat /sys/block/loop6/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop6/loop/sizelimit : '
cat /sys/block/loop6/loop/sizelimit : + cat /sys/block/loop6/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop6/loop/autoclear : '
cat /sys/block/loop6/loop/autoclear : + cat /sys/block/loop6/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop6/loop/partscan : '
cat /sys/block/loop6/loop/partscan : + cat /sys/block/loop6/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop6/loop/dio : '
cat /sys/block/loop6/loop/dio : + cat /sys/block/loop6/loop/dio
1
+ for i in '`shuf -i  1-$NN -n $NN`'
+ mkdir -p /mnt/loop2
+ truncate -s 2048M /tmp/loop2
+ /root/util-linux/losetup --direct-io=on /dev/loop2 /tmp/loop2
+ /root/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE  DIO LOG-SEC
/dev/loop6         0      0         0  0 /tmp/loop6   1     512
/dev/loop4         0      0         0  0 /tmp/loop4   1     512
/dev/loop2         0      0         0  0 /tmp/loop2   1     512
/dev/loop3         0      0         0  0 /tmp/loop3   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop2
Discarding blocks...Done.
meta-data=/dev/loop2             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
+ mount /dev/loop2 /mnt/loop2
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop2/loop/offset : '
cat /sys/block/loop2/loop/offset : + cat /sys/block/loop2/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop2/loop/sizelimit : '
cat /sys/block/loop2/loop/sizelimit : + cat /sys/block/loop2/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop2/loop/autoclear : '
cat /sys/block/loop2/loop/autoclear : + cat /sys/block/loop2/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop2/loop/partscan : '
cat /sys/block/loop2/loop/partscan : + cat /sys/block/loop2/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop2/loop/dio : '
cat /sys/block/loop2/loop/dio : + cat /sys/block/loop2/loop/dio
1
+ for i in '`shuf -i  1-$NN -n $NN`'
+ mkdir -p /mnt/loop7
+ truncate -s 2048M /tmp/loop7
+ /root/util-linux/losetup --direct-io=on /dev/loop7 /tmp/loop7
+ /root/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE  DIO LOG-SEC
/dev/loop6         0      0         0  0 /tmp/loop6   1     512
/dev/loop4         0      0         0  0 /tmp/loop4   1     512
/dev/loop2         0      0         0  0 /tmp/loop2   1     512
/dev/loop7         0      0         0  0 /tmp/loop7   1     512
/dev/loop3         0      0         0  0 /tmp/loop3   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop7
Discarding blocks...Done.
meta-data=/dev/loop7             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
+ mount /dev/loop7 /mnt/loop7
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop7/loop/offset : '
cat /sys/block/loop7/loop/offset : + cat /sys/block/loop7/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop7/loop/sizelimit : '
cat /sys/block/loop7/loop/sizelimit : + cat /sys/block/loop7/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop7/loop/autoclear : '
cat /sys/block/loop7/loop/autoclear : + cat /sys/block/loop7/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop7/loop/partscan : '
cat /sys/block/loop7/loop/partscan : + cat /sys/block/loop7/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop7/loop/dio : '
cat /sys/block/loop7/loop/dio : + cat /sys/block/loop7/loop/dio
1
+ for i in '`shuf -i  1-$NN -n $NN`'
+ mkdir -p /mnt/loop8
+ truncate -s 2048M /tmp/loop8
+ /root/util-linux/losetup --direct-io=on /dev/loop8 /tmp/loop8
+ /root/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE  DIO LOG-SEC
/dev/loop8         0      0         0  0 /tmp/loop8   1     512
/dev/loop6         0      0         0  0 /tmp/loop6   1     512
/dev/loop4         0      0         0  0 /tmp/loop4   1     512
/dev/loop2         0      0         0  0 /tmp/loop2   1     512
/dev/loop7         0      0         0  0 /tmp/loop7   1     512
/dev/loop3         0      0         0  0 /tmp/loop3   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop8
Discarding blocks...Done.
meta-data=/dev/loop8             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
+ mount /dev/loop8 /mnt/loop8
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop8/loop/offset : '
cat /sys/block/loop8/loop/offset : + cat /sys/block/loop8/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop8/loop/sizelimit : '
cat /sys/block/loop8/loop/sizelimit : + cat /sys/block/loop8/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop8/loop/autoclear : '
cat /sys/block/loop8/loop/autoclear : + cat /sys/block/loop8/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop8/loop/partscan : '
cat /sys/block/loop8/loop/partscan : + cat /sys/block/loop8/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop8/loop/dio : '
cat /sys/block/loop8/loop/dio : + cat /sys/block/loop8/loop/dio
1
+ for i in '`shuf -i  1-$NN -n $NN`'
+ mkdir -p /mnt/loop9
+ truncate -s 2048M /tmp/loop9
+ /root/util-linux/losetup --direct-io=on /dev/loop9 /tmp/loop9
+ /root/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE  DIO LOG-SEC
/dev/loop8         0      0         0  0 /tmp/loop8   1     512
/dev/loop6         0      0         0  0 /tmp/loop6   1     512
/dev/loop4         0      0         0  0 /tmp/loop4   1     512
/dev/loop2         0      0         0  0 /tmp/loop2   1     512
/dev/loop9         0      0         0  0 /tmp/loop9   1     512
/dev/loop7         0      0         0  0 /tmp/loop7   1     512
/dev/loop3         0      0         0  0 /tmp/loop3   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop9
Discarding blocks...Done.
meta-data=/dev/loop9             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
+ mount /dev/loop9 /mnt/loop9
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop9/loop/offset : '
cat /sys/block/loop9/loop/offset : + cat /sys/block/loop9/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop9/loop/sizelimit : '
cat /sys/block/loop9/loop/sizelimit : + cat /sys/block/loop9/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop9/loop/autoclear : '
cat /sys/block/loop9/loop/autoclear : + cat /sys/block/loop9/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop9/loop/partscan : '
cat /sys/block/loop9/loop/partscan : + cat /sys/block/loop9/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop9/loop/dio : '
cat /sys/block/loop9/loop/dio : + cat /sys/block/loop9/loop/dio
1
+ for i in '`shuf -i  1-$NN -n $NN`'
+ mkdir -p /mnt/loop5
+ truncate -s 2048M /tmp/loop5
+ /root/util-linux/losetup --direct-io=on /dev/loop5 /tmp/loop5
+ /root/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE  DIO LOG-SEC
/dev/loop8         0      0         0  0 /tmp/loop8   1     512
/dev/loop6         0      0         0  0 /tmp/loop6   1     512
/dev/loop4         0      0         0  0 /tmp/loop4   1     512
/dev/loop2         0      0         0  0 /tmp/loop2   1     512
/dev/loop9         0      0         0  0 /tmp/loop9   1     512
/dev/loop7         0      0         0  0 /tmp/loop7   1     512
/dev/loop5         0      0         0  0 /tmp/loop5   1     512
/dev/loop3         0      0         0  0 /tmp/loop3   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop5
Discarding blocks...Done.
meta-data=/dev/loop5             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
+ mount /dev/loop5 /mnt/loop5
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop5/loop/offset : '
cat /sys/block/loop5/loop/offset : + cat /sys/block/loop5/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop5/loop/sizelimit : '
cat /sys/block/loop5/loop/sizelimit : + cat /sys/block/loop5/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop5/loop/autoclear : '
cat /sys/block/loop5/loop/autoclear : + cat /sys/block/loop5/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop5/loop/partscan : '
cat /sys/block/loop5/loop/partscan : + cat /sys/block/loop5/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop5/loop/dio : '
cat /sys/block/loop5/loop/dio : + cat /sys/block/loop5/loop/dio
1
+ for i in '`shuf -i  1-$NN -n $NN`'
+ mkdir -p /mnt/loop1
+ truncate -s 2048M /tmp/loop1
+ /root/util-linux/losetup --direct-io=on /dev/loop1 /tmp/loop1
+ /root/util-linux/losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE  DIO LOG-SEC
/dev/loop1         0      0         0  0 /tmp/loop1   1     512
/dev/loop8         0      0         0  0 /tmp/loop8   1     512
/dev/loop6         0      0         0  0 /tmp/loop6   1     512
/dev/loop4         0      0         0  0 /tmp/loop4   1     512
/dev/loop2         0      0         0  0 /tmp/loop2   1     512
/dev/loop9         0      0         0  0 /tmp/loop9   1     512
/dev/loop7         0      0         0  0 /tmp/loop7   1     512
/dev/loop5         0      0         0  0 /tmp/loop5   1     512
/dev/loop3         0      0         0  0 /tmp/loop3   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop1
Discarding blocks...Done.
meta-data=/dev/loop1             isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
+ mount /dev/loop1 /mnt/loop1
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop1/loop/offset : '
cat /sys/block/loop1/loop/offset : + cat /sys/block/loop1/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop1/loop/sizelimit : '
cat /sys/block/loop1/loop/sizelimit : + cat /sys/block/loop1/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop1/loop/autoclear : '
cat /sys/block/loop1/loop/autoclear : + cat /sys/block/loop1/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop1/loop/partscan : '
cat /sys/block/loop1/loop/partscan : + cat /sys/block/loop1/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop1/loop/dio : '
cat /sys/block/loop1/loop/dio : + cat /sys/block/loop1/loop/dio
1
+ for i in '`shuf -i  1-$NN -n $NN`'
+ mkdir -p /mnt/loop10
+ truncate -s 2048M /tmp/loop10
+ /root/util-linux/losetup --direct-io=on /dev/loop10 /tmp/loop10
+ /root/util-linux/losetup
NAME        SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE   DIO LOG-SEC
/dev/loop1          0      0         0  0 /tmp/loop1    1     512
/dev/loop8          0      0         0  0 /tmp/loop8    1     512
/dev/loop6          0      0         0  0 /tmp/loop6    1     512
/dev/loop4          0      0         0  0 /tmp/loop4    1     512
/dev/loop2          0      0         0  0 /tmp/loop2    1     512
/dev/loop9          0      0         0  0 /tmp/loop9    1     512
/dev/loop7          0      0         0  0 /tmp/loop7    1     512
/dev/loop5          0      0         0  0 /tmp/loop5    1     512
/dev/loop3          0      0         0  0 /tmp/loop3    1     512
/dev/loop10         0      0         0  0 /tmp/loop10   1     512
+ sleep 1
+ mkfs.xfs -f /dev/loop10
Discarding blocks...Done.
meta-data=/dev/loop10            isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
+ mount /dev/loop10 /mnt/loop10
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop10/loop/offset : '
cat /sys/block/loop10/loop/offset : + cat /sys/block/loop10/loop/offset
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop10/loop/sizelimit : '
cat /sys/block/loop10/loop/sizelimit : + cat /sys/block/loop10/loop/sizelimit
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop10/loop/autoclear : '
cat /sys/block/loop10/loop/autoclear : + cat /sys/block/loop10/loop/autoclear
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop10/loop/partscan : '
cat /sys/block/loop10/loop/partscan : + cat /sys/block/loop10/loop/partscan
0
+ for attr in offset sizelimit autoclear partscan dio
+ echo -n 'cat /sys/block/loop10/loop/dio : '
cat /sys/block/loop10/loop/dio : + cat /sys/block/loop10/loop/dio
1
+ mount
+ grep loop
/dev/loop3 on /mnt/loop3 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop4 on /mnt/loop4 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop6 on /mnt/loop6 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop2 on /mnt/loop2 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop7 on /mnt/loop7 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop8 on /mnt/loop8 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop9 on /mnt/loop9 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop5 on /mnt/loop5 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop1 on /mnt/loop1 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/loop10 on /mnt/loop10 type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
+ dmesg -c
[ 4861.197941] XFS (loop5): Unmounting Filesystem
[ 4863.459901] XFS (loop9): Unmounting Filesystem
[ 4864.045881] XFS (loop7): Unmounting Filesystem
[ 4864.434878] XFS (loop4): Unmounting Filesystem
[ 4864.744874] XFS (loop2): Unmounting Filesystem
[ 4865.086875] XFS (loop8): Unmounting Filesystem
[ 4865.552881] XFS (loop10): Unmounting Filesystem
[ 4865.857916] XFS (loop1): Unmounting Filesystem
[ 4867.370924] XFS (loop3): Unmounting Filesystem
[ 4867.726864] XFS (loop6): Unmounting Filesystem
[ 4887.878685] loop: module loaded
[ 4887.949970] loop3: detected capacity change from 0 to 4194304
[ 4889.963104] XFS (loop3): Mounting V5 Filesystem
[ 4889.975494] XFS (loop3): Ending clean mount
[ 4889.975702] xfs filesystem being mounted at /mnt/loop3 supports timestamps until 2038 (0x7fffffff)
[ 4890.059469] loop4: detected capacity change from 0 to 4194304
[ 4897.521788] XFS (loop4): Mounting V5 Filesystem
[ 4897.537420] XFS (loop4): Ending clean mount
[ 4897.537587] xfs filesystem being mounted at /mnt/loop4 supports timestamps until 2038 (0x7fffffff)
[ 4897.622681] loop6: detected capacity change from 0 to 4194304
[ 4899.359934] XFS (loop6): Mounting V5 Filesystem
[ 4899.372093] XFS (loop6): Ending clean mount
[ 4899.372236] xfs filesystem being mounted at /mnt/loop6 supports timestamps until 2038 (0x7fffffff)
[ 4899.463029] loop2: detected capacity change from 0 to 4194304
[ 4902.203624] XFS (loop2): Mounting V5 Filesystem
[ 4902.216891] XFS (loop2): Ending clean mount
[ 4902.217060] xfs filesystem being mounted at /mnt/loop2 supports timestamps until 2038 (0x7fffffff)
[ 4902.303834] loop7: detected capacity change from 0 to 4194304
[ 4904.126384] XFS (loop7): Mounting V5 Filesystem
[ 4904.138864] XFS (loop7): Ending clean mount
[ 4904.139011] xfs filesystem being mounted at /mnt/loop7 supports timestamps until 2038 (0x7fffffff)
[ 4904.217516] loop8: detected capacity change from 0 to 4194304
[ 4907.738610] XFS (loop8): Mounting V5 Filesystem
[ 4907.751410] XFS (loop8): Ending clean mount
[ 4907.751550] xfs filesystem being mounted at /mnt/loop8 supports timestamps until 2038 (0x7fffffff)
[ 4907.832522] loop9: detected capacity change from 0 to 4194304
[ 4909.480132] XFS (loop9): Mounting V5 Filesystem
[ 4909.493792] XFS (loop9): Ending clean mount
[ 4909.494016] xfs filesystem being mounted at /mnt/loop9 supports timestamps until 2038 (0x7fffffff)
[ 4909.572326] loop5: detected capacity change from 0 to 4194304
[ 4911.457907] XFS (loop5): Mounting V5 Filesystem
[ 4911.470880] XFS (loop5): Ending clean mount
[ 4911.471038] xfs filesystem being mounted at /mnt/loop5 supports timestamps until 2038 (0x7fffffff)
[ 4911.559518] loop1: detected capacity change from 0 to 4194304
[ 4913.433757] XFS (loop1): Mounting V5 Filesystem
[ 4913.448956] XFS (loop1): Ending clean mount
[ 4913.449118] xfs filesystem being mounted at /mnt/loop1 supports timestamps until 2038 (0x7fffffff)
[ 4913.527403] loop10: detected capacity change from 0 to 4194304
[ 4915.194571] XFS (loop10): Mounting V5 Filesystem
[ 4915.208365] XFS (loop10): Ending clean mount
[ 4915.208533] xfs filesystem being mounted at /mnt/loop10 supports timestamps until 2038 (0x7fffffff)
+ df -h /mnt/loop1 /mnt/loop10 /mnt/loop2 /mnt/loop3 /mnt/loop4 /mnt/loop5 /mnt/loop6 /mnt/loop7 /mnt/loop8 /mnt/loop9
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop1      2.0G   33M  2.0G   2% /mnt/loop1
/dev/loop10     2.0G   33M  2.0G   2% /mnt/loop10
/dev/loop2      2.0G   33M  2.0G   2% /mnt/loop2
/dev/loop3      2.0G   33M  2.0G   2% /mnt/loop3
/dev/loop4      2.0G   33M  2.0G   2% /mnt/loop4
/dev/loop5      2.0G   33M  2.0G   2% /mnt/loop5
/dev/loop6      2.0G   33M  2.0G   2% /mnt/loop6
/dev/loop7      2.0G   33M  2.0G   2% /mnt/loop7
/dev/loop8      2.0G   33M  2.0G   2% /mnt/loop8
/dev/loop9      2.0G   33M  2.0G   2% /mnt/loop9
++ shuf -i 1-10 -n 10
+ for i in '`shuf -i 1-$NN -n $NN`'
+ fallocate -o 0 -l 524288000 /mnt/loop7/testfile
+ fio fio/verify.fio --filename=/mnt/loop7/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.8-5-g464b
Starting 1 process
Jobs: 1 (f=0): [f(1)][100.0%][r=16.7MiB/s,w=0KiB/s][r=4274,w=0 IOPS][eta 00m:00s]     
write-and-verify: (groupid=0, jobs=1): err= 0: pid=17434: Tue Jun 22 01:19:46 2021
   read: IOPS=3154, BW=12.3MiB/s (12.9MB/s)(316MiB/25685msec)
    slat (usec): min=12, max=904, avg=20.59, stdev=18.50
    clat (usec): min=340, max=7102.3k, avg=5049.36, stdev=98954.79
     lat (usec): min=391, max=7102.3k, avg=5070.14, stdev=98954.78
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    4],
     | 70.00th=[    4], 80.00th=[    5], 90.00th=[    5], 95.00th=[    5],
     | 99.00th=[    6], 99.50th=[    6], 99.90th=[   59], 99.95th=[  123],
     | 99.99th=[ 7013]
  write: IOPS=3047, BW=11.9MiB/s (12.5MB/s)(500MiB/42007msec)
    slat (usec): min=14, max=4011, avg=37.51, stdev=48.42
    clat (usec): min=448, max=4274.3k, avg=5211.48, stdev=69368.44
     lat (usec): min=504, max=4274.3k, avg=5249.22, stdev=69368.54
    clat percentiles (usec):
     |  1.00th=[   1139],  5.00th=[   1811], 10.00th=[   2278],
     | 20.00th=[   2737], 30.00th=[   2999], 40.00th=[   3163],
     | 50.00th=[   3326], 60.00th=[   3523], 70.00th=[   3818],
     | 80.00th=[   4293], 90.00th=[   5276], 95.00th=[   6718],
     | 99.00th=[   9765], 99.50th=[  13698], 99.90th=[ 147850],
     | 99.95th=[ 329253], 99.99th=[4278191]
   bw (  KiB/s): min=   16, max=20224, per=100.00%, avg=14837.81, stdev=6761.49, samples=69
   iops        : min=    4, max= 5056, avg=3709.45, stdev=1690.37, samples=69
  lat (usec)   : 500=0.01%, 750=0.19%, 1000=0.24%
  lat (msec)   : 2=3.64%, 4=72.46%, 10=22.78%, 20=0.42%, 50=0.06%
  lat (msec)   : 100=0.05%, 250=0.10%, 500=0.01%, 750=0.01%
  cpu          : usr=1.94%, sys=10.84%, ctx=166879, majf=0, minf=1916
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=81012,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=12.3MiB/s (12.9MB/s), 12.3MiB/s-12.3MiB/s (12.9MB/s-12.9MB/s), io=316MiB (332MB), run=25685-25685msec
  WRITE: bw=11.9MiB/s (12.5MB/s), 11.9MiB/s-11.9MiB/s (12.5MB/s-12.5MB/s), io=500MiB (524MB), run=42007-42007msec

Disk stats (read/write):
  loop7: ios=80272/128070, merge=0/0, ticks=405947/682548, in_queue=1094276, util=99.86%
+ for i in '`shuf -i 1-$NN -n $NN`'
+ fallocate -o 0 -l 524288000 /mnt/loop1/testfile
+ fio fio/verify.fio --filename=/mnt/loop1/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.8-5-g464b
Starting 1 process
Jobs: 1 (f=1): [V(1)][82.4%][r=20.1MiB/s,w=0KiB/s][r=5150,w=0 IOPS][eta 00m:12s]      
write-and-verify: (groupid=0, jobs=1): err= 0: pid=17480: Tue Jun 22 01:20:44 2021
   read: IOPS=4340, BW=16.0MiB/s (17.8MB/s)(316MiB/18620msec)
    slat (usec): min=12, max=496, avg=19.31, stdev=11.81
    clat (usec): min=343, max=222421, avg=3663.76, stdev=4648.02
     lat (usec): min=396, max=222493, avg=3683.26, stdev=4649.25
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    4],
     | 70.00th=[    4], 80.00th=[    4], 90.00th=[    5], 95.00th=[    5],
     | 99.00th=[    6], 99.50th=[    6], 99.90th=[   75], 99.95th=[  123],
     | 99.99th=[  180]
  write: IOPS=3426, BW=13.4MiB/s (14.0MB/s)(500MiB/37354msec)
    slat (usec): min=14, max=3934, avg=37.25, stdev=45.77
    clat (usec): min=447, max=3034.1k, avg=4630.07, stdev=42682.45
     lat (usec): min=484, max=3034.2k, avg=4667.54, stdev=42682.51
    clat percentiles (usec):
     |  1.00th=[   1139],  5.00th=[   1876], 10.00th=[   2311],
     | 20.00th=[   2769], 30.00th=[   2999], 40.00th=[   3163],
     | 50.00th=[   3326], 60.00th=[   3523], 70.00th=[   3785],
     | 80.00th=[   4293], 90.00th=[   5211], 95.00th=[   6390],
     | 99.00th=[   9634], 99.50th=[  12256], 99.90th=[ 123208],
     | 99.95th=[ 231736], 99.99th=[2566915]
   bw (  KiB/s): min=   64, max=20536, per=100.00%, avg=15512.76, stdev=6026.12, samples=66
   iops        : min=   16, max= 5134, avg=3878.18, stdev=1506.53, samples=66
  lat (usec)   : 500=0.02%, 750=0.18%, 1000=0.23%
  lat (msec)   : 2=3.27%, 4=74.97%, 10=20.66%, 20=0.42%, 50=0.04%
  lat (msec)   : 100=0.08%, 250=0.10%, 500=0.01%, 750=0.01%
  cpu          : usr=2.33%, sys=12.94%, ctx=166072, majf=0, minf=1911
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80827,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=16.0MiB/s (17.8MB/s), 16.0MiB/s-16.0MiB/s (17.8MB/s-17.8MB/s), io=316MiB (331MB), run=18620-18620msec
  WRITE: bw=13.4MiB/s (14.0MB/s), 13.4MiB/s-13.4MiB/s (14.0MB/s-14.0MB/s), io=500MiB (524MB), run=37354-37354msec

Disk stats (read/write):
  loop1: ios=80486/128074, merge=0/0, ticks=294759/588124, in_queue=886005, util=99.87%
+ for i in '`shuf -i 1-$NN -n $NN`'
+ fallocate -o 0 -l 524288000 /mnt/loop6/testfile
+ fio fio/verify.fio --filename=/mnt/loop6/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.8-5-g464b
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.0%][r=18.6MiB/s,w=0KiB/s][r=4773,w=0 IOPS][eta 00m:16s]      
write-and-verify: (groupid=0, jobs=1): err= 0: pid=17580: Tue Jun 22 01:21:53 2021
   read: IOPS=2774, BW=10.8MiB/s (11.4MB/s)(316MiB/29179msec)
    slat (usec): min=11, max=2302, avg=24.47, stdev=34.44
    clat (usec): min=299, max=8908.9k, avg=5739.38, stdev=126674.62
     lat (usec): min=351, max=8908.9k, avg=5764.12, stdev=126674.57
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    3], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    4],
     | 70.00th=[    4], 80.00th=[    5], 90.00th=[    5], 95.00th=[    6],
     | 99.00th=[   10], 99.50th=[   11], 99.90th=[   59], 99.95th=[   65],
     | 99.99th=[ 8926]
  write: IOPS=3261, BW=12.7MiB/s (13.4MB/s)(500MiB/39244msec)
    slat (usec): min=14, max=5530, avg=38.78, stdev=49.23
    clat (usec): min=204, max=4739.8k, avg=4864.77, stdev=59719.99
     lat (usec): min=473, max=4739.8k, avg=4903.78, stdev=59720.04
    clat percentiles (usec):
     |  1.00th=[   1156],  5.00th=[   1844], 10.00th=[   2278],
     | 20.00th=[   2737], 30.00th=[   2999], 40.00th=[   3163],
     | 50.00th=[   3326], 60.00th=[   3523], 70.00th=[   3818],
     | 80.00th=[   4293], 90.00th=[   5276], 95.00th=[   6456],
     | 99.00th=[   9896], 99.50th=[  12911], 99.90th=[ 105382],
     | 99.95th=[ 333448], 99.99th=[4395631]
   bw (  KiB/s): min=   64, max=20160, per=100.00%, avg=15279.39, stdev=6054.72, samples=67
   iops        : min=   16, max= 5040, avg=3819.78, stdev=1513.67, samples=67
  lat (usec)   : 250=0.01%, 500=0.02%, 750=0.17%, 1000=0.22%
  lat (msec)   : 2=3.56%, 4=72.34%, 10=22.80%, 20=0.69%, 50=0.01%
  lat (msec)   : 100=0.10%, 250=0.04%, 500=0.01%, 750=0.01%
  cpu          : usr=1.97%, sys=11.12%, ctx=170086, majf=0, minf=1914
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80953,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=10.8MiB/s (11.4MB/s), 10.8MiB/s-10.8MiB/s (11.4MB/s-11.4MB/s), io=316MiB (332MB), run=29179-29179msec
  WRITE: bw=12.7MiB/s (13.4MB/s), 12.7MiB/s-12.7MiB/s (13.4MB/s-13.4MB/s), io=500MiB (524MB), run=39244-39244msec

Disk stats (read/write):
  loop6: ios=80569/128064, merge=0/0, ticks=461919/680066, in_queue=1153292, util=99.84%
+ for i in '`shuf -i 1-$NN -n $NN`'
+ fallocate -o 0 -l 524288000 /mnt/loop8/testfile
+ fio fio/verify.fio --filename=/mnt/loop8/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.8-5-g464b
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.8%][r=18.1MiB/s,w=0KiB/s][r=4640,w=0 IOPS][eta 00m:16s]      
write-and-verify: (groupid=0, jobs=1): err= 0: pid=17630: Tue Jun 22 01:23:07 2021
   read: IOPS=3154, BW=12.3MiB/s (12.9MB/s)(316MiB/25644msec)
    slat (usec): min=12, max=1732, avg=20.20, stdev=14.08
    clat (usec): min=366, max=7915.3k, avg=5049.94, stdev=110367.19
     lat (usec): min=423, max=7915.3k, avg=5070.30, stdev=110367.15
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    3], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    4],
     | 70.00th=[    4], 80.00th=[    4], 90.00th=[    5], 95.00th=[    5],
     | 99.00th=[    6], 99.50th=[    6], 99.90th=[   70], 99.95th=[  115],
     | 99.99th=[ 7819]
  write: IOPS=2749, BW=10.7MiB/s (11.3MB/s)(500MiB/46557msec)
    slat (usec): min=14, max=3689, avg=37.87, stdev=54.55
    clat (usec): min=438, max=8286.2k, avg=5779.76, stdev=99151.99
     lat (usec): min=475, max=8286.2k, avg=5817.86, stdev=99152.19
    clat percentiles (usec):
     |  1.00th=[   1254],  5.00th=[   1926], 10.00th=[   2343],
     | 20.00th=[   2769], 30.00th=[   2999], 40.00th=[   3163],
     | 50.00th=[   3326], 60.00th=[   3523], 70.00th=[   3818],
     | 80.00th=[   4293], 90.00th=[   5276], 95.00th=[   6456],
     | 99.00th=[  10814], 99.50th=[  15664], 99.90th=[ 229639],
     | 99.95th=[ 367002], 99.99th=[8153727]
   bw (  KiB/s): min=   80, max=20528, per=100.00%, avg=14218.97, stdev=6939.08, samples=72
   iops        : min=   20, max= 5132, avg=3554.69, stdev=1734.78, samples=72
  lat (usec)   : 500=0.01%, 750=0.12%, 1000=0.18%
  lat (msec)   : 2=3.17%, 4=75.36%, 10=20.38%, 20=0.50%, 50=0.02%
  lat (msec)   : 100=0.06%, 250=0.15%, 500=0.02%
  cpu          : usr=1.75%, sys=10.06%, ctx=171259, majf=0, minf=1912
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80882,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=12.3MiB/s (12.9MB/s), 12.3MiB/s-12.3MiB/s (12.9MB/s-12.9MB/s), io=316MiB (331MB), run=25644-25644msec
  WRITE: bw=10.7MiB/s (11.3MB/s), 10.7MiB/s-10.7MiB/s (11.3MB/s-11.3MB/s), io=500MiB (524MB), run=46557-46557msec

Disk stats (read/write):
  loop8: ios=80443/128076, merge=0/0, ticks=406622/758753, in_queue=1171913, util=90.93%
+ for i in '`shuf -i 1-$NN -n $NN`'
+ fallocate -o 0 -l 524288000 /mnt/loop10/testfile
+ fio fio/verify.fio --filename=/mnt/loop10/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.8-5-g464b
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.8%][r=9633KiB/s,w=0KiB/s][r=2408,w=0 IOPS][eta 00m:16s]   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=17680: Tue Jun 22 01:24:20 2021
   read: IOPS=3076, BW=12.0MiB/s (12.6MB/s)(315MiB/26211msec)
    slat (usec): min=13, max=1824, avg=21.09, stdev=18.53
    clat (usec): min=480, max=7498.9k, avg=5175.91, stdev=104916.83
     lat (usec): min=548, max=7498.9k, avg=5197.18, stdev=104916.80
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    4],
     | 70.00th=[    4], 80.00th=[    4], 90.00th=[    5], 95.00th=[    5],
     | 99.00th=[    6], 99.50th=[    9], 99.90th=[   81], 99.95th=[  150],
     | 99.99th=[ 7416]
  write: IOPS=2798, BW=10.9MiB/s (11.5MB/s)(500MiB/45737msec)
    slat (usec): min=14, max=6680, avg=36.81, stdev=41.50
    clat (usec): min=449, max=7596.4k, avg=5678.44, stdev=93747.43
     lat (usec): min=507, max=7596.4k, avg=5715.48, stdev=93747.53
    clat percentiles (usec):
     |  1.00th=[   1221],  5.00th=[   1926], 10.00th=[   2343],
     | 20.00th=[   2769], 30.00th=[   2999], 40.00th=[   3163],
     | 50.00th=[   3326], 60.00th=[   3523], 70.00th=[   3818],
     | 80.00th=[   4293], 90.00th=[   5276], 95.00th=[   6390],
     | 99.00th=[   9110], 99.50th=[  12518], 99.90th=[ 189793],
     | 99.95th=[ 396362], 99.99th=[7482639]
   bw (  KiB/s): min=   24, max=20144, per=100.00%, avg=14421.66, stdev=6800.87, samples=71
   iops        : min=    6, max= 5036, avg=3605.41, stdev=1700.22, samples=71
  lat (usec)   : 500=0.01%, 750=0.14%, 1000=0.21%
  lat (msec)   : 2=3.16%, 4=74.33%, 10=21.54%, 20=0.29%, 50=0.05%
  lat (msec)   : 100=0.09%, 250=0.14%, 500=0.02%, 750=0.01%
  cpu          : usr=1.95%, sys=10.37%, ctx=168893, majf=0, minf=1906
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80648,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=12.0MiB/s (12.6MB/s), 12.0MiB/s-12.0MiB/s (12.6MB/s-12.6MB/s), io=315MiB (330MB), run=26211-26211msec
  WRITE: bw=10.9MiB/s (11.5MB/s), 10.9MiB/s-10.9MiB/s (11.5MB/s-11.5MB/s), io=500MiB (524MB), run=45737-45737msec

Disk stats (read/write):
  loop10: ios=80648/128096, merge=0/1, ticks=417176/784119, in_queue=1212263, util=99.78%
+ for i in '`shuf -i 1-$NN -n $NN`'
+ fallocate -o 0 -l 524288000 /mnt/loop3/testfile
+ fio fio/verify.fio --filename=/mnt/loop3/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.8-5-g464b
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.2%][r=15.8MiB/s,w=0KiB/s][r=4042,w=0 IOPS][eta 00m:16s]      
write-and-verify: (groupid=0, jobs=1): err= 0: pid=17792: Tue Jun 22 01:25:31 2021
   read: IOPS=3028, BW=11.8MiB/s (12.4MB/s)(316MiB/26722msec)
    slat (usec): min=11, max=1198, avg=19.08, stdev=16.42
    clat (usec): min=296, max=8275.7k, avg=5261.00, stdev=115686.50
     lat (usec): min=358, max=8275.7k, avg=5280.25, stdev=115686.50
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    4],
     | 70.00th=[    4], 80.00th=[    4], 90.00th=[    5], 95.00th=[    5],
     | 99.00th=[    6], 99.50th=[    9], 99.90th=[   84], 99.95th=[  109],
     | 99.99th=[ 8221]
  write: IOPS=3023, BW=11.8MiB/s (12.4MB/s)(500MiB/42331msec)
    slat (usec): min=14, max=3812, avg=39.09, stdev=55.33
    clat (usec): min=345, max=4045.0k, avg=5250.30, stdev=57625.19
     lat (usec): min=400, max=4045.1k, avg=5289.63, stdev=57625.64
    clat percentiles (usec):
     |  1.00th=[   1254],  5.00th=[   1942], 10.00th=[   2376],
     | 20.00th=[   2802], 30.00th=[   3032], 40.00th=[   3163],
     | 50.00th=[   3326], 60.00th=[   3523], 70.00th=[   3785],
     | 80.00th=[   4293], 90.00th=[   5342], 95.00th=[   6652],
     | 99.00th=[  10028], 99.50th=[  13566], 99.90th=[ 283116],
     | 99.95th=[ 429917], 99.99th=[4043310]
   bw (  KiB/s): min=   40, max=20343, per=100.00%, avg=14415.72, stdev=6395.60, samples=71
   iops        : min=   10, max= 5085, avg=3603.83, stdev=1598.94, samples=71
  lat (usec)   : 500=0.01%, 750=0.13%, 1000=0.19%
  lat (msec)   : 2=3.06%, 4=76.23%, 10=19.58%, 20=0.48%, 50=0.05%
  lat (msec)   : 100=0.08%, 250=0.10%, 500=0.04%
  cpu          : usr=1.91%, sys=10.40%, ctx=169739, majf=0, minf=1913
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80933,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=11.8MiB/s (12.4MB/s), 11.8MiB/s-11.8MiB/s (12.4MB/s-12.4MB/s), io=316MiB (332MB), run=26722-26722msec
  WRITE: bw=11.8MiB/s (12.4MB/s), 11.8MiB/s-11.8MiB/s (12.4MB/s-12.4MB/s), io=500MiB (524MB), run=42331-42331msec

Disk stats (read/write):
  loop3: ios=80697/128076, merge=0/0, ticks=424513/687123, in_queue=1117965, util=99.84%
+ for i in '`shuf -i 1-$NN -n $NN`'
+ fallocate -o 0 -l 524288000 /mnt/loop5/testfile
+ fio fio/verify.fio --filename=/mnt/loop5/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.8-5-g464b
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.2%][r=18.5MiB/s,w=0KiB/s][r=4723,w=0 IOPS][eta 00m:18s]     
write-and-verify: (groupid=0, jobs=1): err= 0: pid=17949: Tue Jun 22 01:26:50 2021
   read: IOPS=3797, BW=14.8MiB/s (15.6MB/s)(316MiB/21310msec)
    slat (usec): min=12, max=1645, avg=21.24, stdev=19.08
    clat (usec): min=344, max=3224.3k, avg=4189.49, stdev=45153.85
     lat (usec): min=385, max=3224.3k, avg=4210.90, stdev=45153.88
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    4],
     | 70.00th=[    4], 80.00th=[    4], 90.00th=[    5], 95.00th=[    5],
     | 99.00th=[    6], 99.50th=[    7], 99.90th=[   53], 99.95th=[   83],
     | 99.99th=[ 3239]
  write: IOPS=2246, BW=8988KiB/s (9203kB/s)(500MiB/56968msec)
    slat (usec): min=13, max=5020, avg=36.87, stdev=48.05
    clat (usec): min=442, max=6274.5k, avg=7082.13, stdev=106334.81
     lat (usec): min=483, max=6274.5k, avg=7119.24, stdev=106334.93
    clat percentiles (usec):
     |  1.00th=[   1221],  5.00th=[   1975], 10.00th=[   2409],
     | 20.00th=[   2835], 30.00th=[   3064], 40.00th=[   3228],
     | 50.00th=[   3392], 60.00th=[   3556], 70.00th=[   3851],
     | 80.00th=[   4359], 90.00th=[   5342], 95.00th=[   6718],
     | 99.00th=[  11076], 99.50th=[  24773], 99.90th=[ 591397],
     | 99.95th=[2197816], 99.99th=[6006244]
   bw (  KiB/s): min=   56, max=19904, per=100.00%, avg=12486.01, stdev=7497.88, samples=82
   iops        : min=   14, max= 4976, avg=3121.48, stdev=1874.46, samples=82
  lat (usec)   : 500=0.01%, 750=0.14%, 1000=0.18%
  lat (msec)   : 2=2.90%, 4=75.64%, 10=20.22%, 20=0.48%, 50=0.09%
  lat (msec)   : 100=0.08%, 250=0.14%, 500=0.03%, 750=0.01%, 1000=0.01%
  cpu          : usr=1.74%, sys=9.53%, ctx=170900, majf=0, minf=1912
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80918,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=14.8MiB/s (15.6MB/s), 14.8MiB/s-14.8MiB/s (15.6MB/s-15.6MB/s), io=316MiB (331MB), run=21310-21310msec
  WRITE: bw=8988KiB/s (9203kB/s), 8988KiB/s-8988KiB/s (9203kB/s-9203kB/s), io=500MiB (524MB), run=56968-56968msec

Disk stats (read/write):
  loop5: ios=80858/128102, merge=0/0, ticks=338585/931134, in_queue=1276111, util=97.92%
+ for i in '`shuf -i 1-$NN -n $NN`'
+ fallocate -o 0 -l 524288000 /mnt/loop2/testfile
+ fio fio/verify.fio --filename=/mnt/loop2/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.8-5-g464b
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.4%][r=17.2MiB/s,w=0KiB/s][r=4416,w=0 IOPS][eta 00m:16s]     
write-and-verify: (groupid=0, jobs=1): err= 0: pid=18028: Tue Jun 22 01:28:01 2021
   read: IOPS=3316, BW=12.0MiB/s (13.6MB/s)(316MiB/24374msec)
    slat (usec): min=12, max=1728, avg=20.83, stdev=16.48
    clat (usec): min=349, max=6106.8k, avg=4800.99, stdev=85915.09
     lat (usec): min=403, max=6106.8k, avg=4822.03, stdev=85915.06
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    4], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    4],
     | 70.00th=[    4], 80.00th=[    4], 90.00th=[    5], 95.00th=[    5],
     | 99.00th=[    6], 99.50th=[    6], 99.90th=[   42], 99.95th=[  142],
     | 99.99th=[ 6074]
  write: IOPS=2842, BW=11.1MiB/s (11.6MB/s)(500MiB/45023msec)
    slat (usec): min=13, max=6926, avg=37.89, stdev=53.94
    clat (usec): min=398, max=7537.5k, avg=5588.11, stdev=87245.69
     lat (usec): min=435, max=7537.6k, avg=5626.24, stdev=87245.89
    clat percentiles (usec):
     |  1.00th=[   1172],  5.00th=[   1942], 10.00th=[   2376],
     | 20.00th=[   2802], 30.00th=[   3032], 40.00th=[   3163],
     | 50.00th=[   3326], 60.00th=[   3523], 70.00th=[   3785],
     | 80.00th=[   4293], 90.00th=[   5276], 95.00th=[   6652],
     | 99.00th=[  10683], 99.50th=[  15008], 99.90th=[ 177210],
     | 99.95th=[ 700449], 99.99th=[7012877]
   bw (  KiB/s): min=   24, max=20096, per=100.00%, avg=14026.60, stdev=7197.62, samples=73
   iops        : min=    6, max= 5024, avg=3506.64, stdev=1799.41, samples=73
  lat (usec)   : 500=0.02%, 750=0.13%, 1000=0.22%
  lat (msec)   : 2=3.08%, 4=74.22%, 10=21.56%, 20=0.46%, 50=0.06%
  lat (msec)   : 100=0.04%, 250=0.15%, 500=0.01%, 750=0.01%, 1000=0.01%
  cpu          : usr=1.92%, sys=10.50%, ctx=171338, majf=0, minf=1911
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80828,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=12.0MiB/s (13.6MB/s), 12.0MiB/s-12.0MiB/s (13.6MB/s-13.6MB/s), io=316MiB (331MB), run=24374-24374msec
  WRITE: bw=11.1MiB/s (11.6MB/s), 11.1MiB/s-11.1MiB/s (11.6MB/s-11.6MB/s), io=500MiB (524MB), run=45023-45023msec

Disk stats (read/write):
  loop2: ios=80460/128067, merge=0/0, ticks=386643/722358, in_queue=1113839, util=91.01%
+ for i in '`shuf -i 1-$NN -n $NN`'
+ fallocate -o 0 -l 524288000 /mnt/loop4/testfile
+ fio fio/verify.fio --filename=/mnt/loop4/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.8-5-g464b
Starting 1 process
Jobs: 1 (f=1): [V(1)][80.2%][r=17.0MiB/s,w=0KiB/s][r=4596,w=0 IOPS][eta 00m:17s]    
write-and-verify: (groupid=0, jobs=1): err= 0: pid=18179: Tue Jun 22 01:29:12 2021
   read: IOPS=3395, BW=13.3MiB/s (13.9MB/s)(316MiB/23795msec)
    slat (usec): min=12, max=1132, avg=19.87, stdev=13.15
    clat (usec): min=300, max=3333.0k, avg=4689.17, stdev=50426.66
     lat (usec): min=349, max=3333.0k, avg=4709.21, stdev=50426.85
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    4], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    4],
     | 70.00th=[    4], 80.00th=[    4], 90.00th=[    5], 95.00th=[    5],
     | 99.00th=[    7], 99.50th=[   10], 99.90th=[   77], 99.95th=[  355],
     | 99.99th=[ 3339]
  write: IOPS=2821, BW=11.0MiB/s (11.6MB/s)(500MiB/45360msec)
    slat (usec): min=14, max=3558, avg=35.63, stdev=37.46
    clat (usec): min=425, max=4571.3k, avg=5632.46, stdev=65758.43
     lat (usec): min=461, max=4571.4k, avg=5668.35, stdev=65758.69
    clat percentiles (usec):
     |  1.00th=[   1237],  5.00th=[   1942], 10.00th=[   2376],
     | 20.00th=[   2802], 30.00th=[   3032], 40.00th=[   3195],
     | 50.00th=[   3359], 60.00th=[   3523], 70.00th=[   3818],
     | 80.00th=[   4293], 90.00th=[   5211], 95.00th=[   6521],
     | 99.00th=[  10683], 99.50th=[  28443], 99.90th=[ 200279],
     | 99.95th=[1052771], 99.99th=[4043310]
   bw (  KiB/s): min=   56, max=20368, per=100.00%, avg=13835.14, stdev=6824.54, samples=74
   iops        : min=   14, max= 5092, avg=3458.76, stdev=1706.15, samples=74
  lat (usec)   : 500=0.01%, 750=0.14%, 1000=0.18%
  lat (msec)   : 2=3.04%, 4=74.35%, 10=21.44%, 20=0.40%, 50=0.11%
  lat (msec)   : 100=0.12%, 250=0.14%, 500=0.02%, 750=0.01%, 1000=0.01%
  cpu          : usr=1.94%, sys=10.57%, ctx=171162, majf=0, minf=1911
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80801,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=13.3MiB/s (13.9MB/s), 13.3MiB/s-13.3MiB/s (13.9MB/s-13.9MB/s), io=316MiB (331MB), run=23795-23795msec
  WRITE: bw=11.0MiB/s (11.6MB/s), 11.0MiB/s-11.0MiB/s (11.6MB/s-11.6MB/s), io=500MiB (524MB), run=45360-45360msec

Disk stats (read/write):
  loop4: ios=80470/128076, merge=0/0, ticks=377332/753568, in_queue=1138503, util=99.87%
+ for i in '`shuf -i 1-$NN -n $NN`'
+ fallocate -o 0 -l 524288000 /mnt/loop9/testfile
+ fio fio/verify.fio --filename=/mnt/loop9/testfile
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.8-5-g464b
Starting 1 process
Jobs: 1 (f=1): [V(1)][81.6%][r=18.4MiB/s,w=0KiB/s][r=4704,w=0 IOPS][eta 00m:14s]   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=18300: Tue Jun 22 01:30:15 2021
   read: IOPS=3081, BW=12.0MiB/s (12.6MB/s)(316MiB/26269msec)
    slat (usec): min=12, max=677, avg=20.48, stdev=15.82
    clat (usec): min=310, max=6297.3k, avg=5168.96, stdev=90289.45
     lat (usec): min=363, max=6297.3k, avg=5189.63, stdev=90289.42
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    4], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    4],
     | 70.00th=[    4], 80.00th=[    4], 90.00th=[    5], 95.00th=[    5],
     | 99.00th=[    7], 99.50th=[    9], 99.90th=[   81], 99.95th=[  184],
     | 99.99th=[ 6275]
  write: IOPS=3576, BW=13.0MiB/s (14.6MB/s)(500MiB/35790msec)
    slat (usec): min=14, max=4000, avg=36.26, stdev=39.58
    clat (usec): min=304, max=4562.7k, avg=4435.57, stdev=46610.70
     lat (usec): min=462, max=4562.7k, avg=4472.06, stdev=46610.74
    clat percentiles (usec):
     |  1.00th=[   1156],  5.00th=[   1893], 10.00th=[   2376],
     | 20.00th=[   2835], 30.00th=[   3064], 40.00th=[   3195],
     | 50.00th=[   3359], 60.00th=[   3589], 70.00th=[   3884],
     | 80.00th=[   4359], 90.00th=[   5211], 95.00th=[   6128],
     | 99.00th=[   8586], 99.50th=[  11076], 99.90th=[ 162530],
     | 99.95th=[ 185598], 99.99th=[3942646]
   bw (  KiB/s): min=   96, max=20064, per=100.00%, avg=15750.58, stdev=5428.81, samples=65
   iops        : min=   24, max= 5016, avg=3937.60, stdev=1357.20, samples=65
  lat (usec)   : 500=0.01%, 750=0.19%, 1000=0.21%
  lat (msec)   : 2=3.22%, 4=73.90%, 10=21.94%, 20=0.27%, 50=0.06%
  lat (msec)   : 100=0.06%, 250=0.11%, 500=0.01%, 750=0.01%, 1000=0.01%
  cpu          : usr=2.15%, sys=11.73%, ctx=171171, majf=0, minf=1913
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=80947,128000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=12.0MiB/s (12.6MB/s), 12.0MiB/s-12.0MiB/s (12.6MB/s-12.6MB/s), io=316MiB (332MB), run=26269-26269msec
  WRITE: bw=13.0MiB/s (14.6MB/s), 13.0MiB/s-13.0MiB/s (14.6MB/s-14.6MB/s), io=500MiB (524MB), run=35790-35790msec

Disk stats (read/write):
  loop9: ios=80889/128077, merge=0/4, ticks=418098/583896, in_queue=1007958, util=96.45%
+ df -h /mnt/loop1 /mnt/loop10 /mnt/loop2 /mnt/loop3 /mnt/loop4 /mnt/loop5 /mnt/loop6 /mnt/loop7 /mnt/loop8 /mnt/loop9
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop1      2.0G  534M  1.5G  27% /mnt/loop1
/dev/loop10     2.0G  534M  1.5G  27% /mnt/loop10
/dev/loop2      2.0G  534M  1.5G  27% /mnt/loop2
/dev/loop3      2.0G  534M  1.5G  27% /mnt/loop3
/dev/loop4      2.0G  534M  1.5G  27% /mnt/loop4
/dev/loop5      2.0G  534M  1.5G  27% /mnt/loop5
/dev/loop6      2.0G  534M  1.5G  27% /mnt/loop6
/dev/loop7      2.0G  534M  1.5G  27% /mnt/loop7
/dev/loop8      2.0G  534M  1.5G  27% /mnt/loop8
/dev/loop9      2.0G  534M  1.5G  27% /mnt/loop9
+ unload_loop
++ shuf -i 1-10 -n 10
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop9
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop4
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop3
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop8
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop2
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop10
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop5
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop7
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop6
+ for i in '`shuf -i 1-$NN -n $NN`'
+ umount /mnt/loop1
+ losetup -D
+ sleep 3
+ rmmod loop
+ modprobe -r loop
+ lsmod
+ grep loop
+ rm -fr /mnt/loop1 /mnt/loop10 /mnt/loop2 /mnt/loop3 /mnt/loop4 /mnt/loop5 /mnt/loop6 /mnt/loop7 /mnt/loop8 /mnt/loop9
# 

-- 
2.22.1

