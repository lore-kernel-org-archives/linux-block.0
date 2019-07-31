Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0348EC32751
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 21:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CC72064A
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 21:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zsop2ziV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfGaVB1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:01:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41827 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfGaVB0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 17:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564606887; x=1596142887;
  h=from:to:cc:subject:date:message-id;
  bh=IT2YTs8hYq4UQkQP19ySPniU6eJiIs6as6XZj1IUnbc=;
  b=Zsop2ziVfML+2H4KS087T6qOBYEPbbNKHkHukqYrL/00rVNlATr09Ft3
   Q+iTQevUJhrdaJxJuThJcQ8JYXT22DWl514ia64xHVzwgRYW2QSFdmqaa
   JW3OLwaQegoyomPQXUCswScPHHp5QRA6yah0mhoaO84U4xX9LcK9bfeq3
   RzObsYtsLMDB/249Xdki4WbI7pQ3KbohGNfEmlH+zp+by+PAp8kjFlQQD
   ecLXi2n1R44hpl3X9U2miBm25ulGoUSgkZiribbWGcSgukH2207LxP0Et
   xYvXnSfmnSoqnTVCOpEpFnw10whczEwH91ccynd61ah/fGrPIFwDhtAKc
   A==;
IronPort-SDR: hC3/M3DkFA+FgL7ai+TdXkhgAJlIs0eFCwxdc84R1bxDO+WUqHsQnbRQ5rGknHiwdYJdVoXBcX
 tpyLzMngebIHSkJ1QqiJOaOaeR3NBvy/9oVV5UU7bpmviGpT9nDBuxINZfBwqLBSw6+IYZ83zQ
 giMSIJpX6fr73f0oHxOFQ6GYsqwxoOR/Ln1eocTWNvQVv3tkJF6xvC8GOKdvWxABSpdLxcjXwr
 BY4L8Acgt/uOHhvw8aIP4x7X8WcvBvWdqCDV609gBbcX4AVIZXCvmQA9QSVpVAKZ1xnyxDJFzh
 OZQ=
X-IronPort-AV: E=Sophos;i="5.64,331,1559491200"; 
   d="scan'208";a="119303830"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 05:01:23 +0800
IronPort-SDR: A/BZJLWoP5Ot/Zqigbwe4ahoX0PdX4C0B+fI7LjU9UQtgZwxVsBSTHhJSsLM0M0FQ1/CF/8Zxy
 jy1ySg72W9YZkfnj8V0JJOgKDfZfvgvWSsLZmniIcahsr3NTqKpB5WwZquMGSd3tHWzG8pCxVK
 RuAuj27NexXTaJxVTIigmeWQDFN1Va0UUkMrjJZk4djgw9fHtePz8lrjZi51PMUKpAU1mUd5ZT
 dSLWUAftDQnDro7ehVRnSZyGdOk0jGDCN1bgyRE3GrLYzGtNdanQQrJSM95Pnfo5uzqyGezvh0
 8xfjyQJHLb4YaAA6mpNWunP/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 13:59:20 -0700
IronPort-SDR: qYKJ6LwVU851eAUWH4O+CV1yW4yRcJSlxvJag+DL8pqeCpxdfEMYZ6Tr4Vhq6dndTTEHM9/50A
 EOmdjwz3SrdA/qV5UCB6vfD7rNW0FqmAvfEXDgVEBAw8tHN2nxO7GGmgffHFI+1XumDIoiSPrE
 g6P0aOdng1p4Ct33MnonSq/8GzAluo3TRgDzWyZJK1BqtcaM0+ovz/UYBni3of57a47XP8DkON
 MzxDUHFY+iu/VA6Ip7Rx9Ip3gMXX2WWaWQI1ISVfnxkFY5+BLjaqR/k+9O+gyO/pQUh3Tr9z5K
 Wzo=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2019 14:01:19 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, dennis@kernel.org,
        hare@suse.com, damien.lemoal@wdc.com, sagi@grimberg.me,
        dennisszhou@gmail.com, jthumshirn@suse.de, osandov@fb.com,
        ming.lei@redhat.com, tj@kernel.org, bvanassche@acm.org,
        martin.petersen@oracle.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/4] block: introduce REQ_OP_ZONE_RESET_ALL
Date:   Wed, 31 Jul 2019 14:00:58 -0700
Message-Id: <20190731210102.3472-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

In current implementation Zoned block device issues one bio at a time
based on the range of the offset and zones specified from userspace
tools like blkzone. Worst case scenario it will issue N requests which
are equal to the number of the zones when the application wants to
reset the drive, e.g. mkfs.

Zone Block devices allow issuing zone reset all operation [1] 
which can essentially reset all the available zones with only one
command.

This patch series introduces new REQ_OP_ZONE_RESET_ALL operation. Along
with that, we also introduce QUEUE_FLAG_ZONE_RESETALL (and respective
helpers) which is needed to be set by the low-level driver in order to
enable the REQ_OP_ZONE_RESET_ALL.

In this series we implement the REQ_OP_ZONE_RESET_ALL for sd and
null_blk block drivers.

Following is the performance difference measured for null_blk when
configured with 16TB size with zone size = 64MB for collecting
the overhead only for the Linux Block Layer. Please note that this
doesn't include any device overhead which will be additional on the
top of these numbers.

# modprobe null_blk zone_size=64 gb=16384 nr_devices=1 zoned=1
# for i in 1 2 3 4 5 ; do time blkzone reset /dev/nullb0 ; done 

------------------------------------------------------
| Time |  REQ_OP_ZONE_RESET | REQ_OP_ZONE_RESET_ALL |
------------------------------------------------------
| real |            0m4.622s|               0m0.014s|
| user |            0m0.000s|               0m0.000s|
| sys  |            0m2.762s|               0m0.011s|
|---------------------------------------------------|
| real |            0m4.565s|               0m0.013s|
| user |            0m0.000s|               0m0.000s|
| sys  |            0m2.729s|               0m0.010s|
|---------------------------------------------------|
| real |            0m4.536s|               0m0.013s|
| user |            0m0.001s|               0m0.000s|
| sys  |            0m2.703s|               0m0.011s|
|---------------------------------------------------|
| real |            0m4.619s|               0m0.013s|
| user |            0m0.001s|               0m0.002s|
| sys  |            0m2.759s|               0m0.009s|
|---------------------------------------------------|
| real |            0m4.529s|               0m0.012s|
| user |            0m0.002s|               0m0.000s|
| sys  |            0m2.696s|               0m0.010s|
------------------------------------------------------

In case anyone is interested please have a look at the test log.
We mainly test 4 scenarios:-

1. TCMU-Runner REQ_OP_ZONE_RESET :-

   Issue zone reset in reverse order and observe the zone report cmd 
   wptr. This scenario should translate into issuing N block layer
   REQ_OP_ZONE_RESET requests. On success Zone write pointer values
   should be set to 0x0 in the blkzone report command in the reverse
   order.
   (blkzone -o ${zone_start_offset} ${DEV})

2. TCMU-Runner REQ_OP_ZONE_RESET_ALL :-

   Issue zone reset with the length of the device, this should translate
   into the REQ_OP_ZONE_RESET_ALL and observe the zone report cmd wptr.
   (blkzone reset ${DEV})

3. Test for null_blk REQ_OP_ZONE_RESET :-

   Same as #1. 

4. Test for null_blk REQ_OP_ZONE_RESET_ALL :-

   Same as #2.

Chaitanya Kulkarni (4):
  block: add req op to reset all zones and flag
  blk-zoned: implement REQ_OP_ZONE_RESET_ALL
  scsi: implement REQ_OP_ZONE_RESET_ALL
  null_blk: implement REQ_OP_ZONE_RESET_ALL

 block/blk-core.c               |  5 +++++
 block/blk-zoned.c              | 40 ++++++++++++++++++++++++++++++++++
 drivers/block/null_blk_main.c  |  3 +++
 drivers/block/null_blk_zoned.c | 28 +++++++++++++++++++-----
 drivers/scsi/sd.c              |  7 +++++-
 drivers/scsi/sd.h              |  5 +++--
 drivers/scsi/sd_zbc.c          |  9 ++++++--
 include/linux/blk_types.h      |  2 ++
 include/linux/blkdev.h         |  3 +++
 9 files changed, 91 insertions(+), 11 deletions(-)


Following are the test results for the null_blk and tcmu-runner based
sd device :-

1. TCMU-Runner REQ_OP_ZONE_RESET:-

a. Populate the zones :-

# ./reset_all_test.sh /dev/sdd  
dd if=/dev/zero of=/dev/sdd bs=4096 count=1 seek=0
dd if=/dev/zero of=/dev/sdd bs=4096 count=2 seek=32768
dd if=/dev/zero of=/dev/sdd bs=4096 count=4 seek=65536
dd if=/dev/zero of=/dev/sdd bs=4096 count=8 seek=98304
dd if=/dev/zero of=/dev/sdd bs=4096 count=16 seek=131072
dd if=/dev/zero of=/dev/sdd bs=4096 count=32 seek=163840
dd if=/dev/zero of=/dev/sdd bs=4096 count=64 seek=196608
dd if=/dev/zero of=/dev/sdd bs=4096 count=128 seek=229376
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000080 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000100 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000200 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000400 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]

b. Now Issue zone reset (REQ_OP_ZONE_RESET) starting from the last zone to the
   0rth and report zones :-

Starting REQ_OP_ZONE_RESET test :- 
blkzone reset -o 1835008 /dev/sdd
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000080 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000100 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000200 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 7 :-  REQ_OP_ZONE_RESET : Pass
---------------------------------------------------------------
blkzone reset -o 1572864 /dev/sdd
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000080 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000100 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 6 :-  REQ_OP_ZONE_RESET : Pass
---------------------------------------------------------------
blkzone reset -o 1310720 /dev/sdd
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000080 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 5 :-  REQ_OP_ZONE_RESET : Pass
---------------------------------------------------------------
blkzone reset -o 1048576 /dev/sdd
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 4 :-  REQ_OP_ZONE_RESET : Pass
---------------------------------------------------------------
blkzone reset -o 786432 /dev/sdd
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 3 :-  REQ_OP_ZONE_RESET : Pass
---------------------------------------------------------------
blkzone reset -o 524288 /dev/sdd
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 2 :-  REQ_OP_ZONE_RESET : Pass
---------------------------------------------------------------
blkzone reset -o 262144 /dev/sdd
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 1 :-  REQ_OP_ZONE_RESET : Pass
---------------------------------------------------------------
blkzone reset -o 0 /dev/sdd
  start: 0x000000000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 0 :-  REQ_OP_ZONE_RESET : Pass
---------------------------------------------------------------

2. TCMU-Runner REQ_OP_ZONE_RESET_ALL:-

a. Populate the zones :-

dd if=/dev/zero of=/dev/sdd bs=4096 count=1 seek=0
dd if=/dev/zero of=/dev/sdd bs=4096 count=2 seek=32768
dd if=/dev/zero of=/dev/sdd bs=4096 count=4 seek=65536
dd if=/dev/zero of=/dev/sdd bs=4096 count=8 seek=98304
dd if=/dev/zero of=/dev/sdd bs=4096 count=16 seek=131072
dd if=/dev/zero of=/dev/sdd bs=4096 count=32 seek=163840
dd if=/dev/zero of=/dev/sdd bs=4096 count=64 seek=196608
dd if=/dev/zero of=/dev/sdd bs=4096 count=128 seek=229376
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond: 4(cl) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000080 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000100 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000200 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000400 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
-------------------------------------------------

b. Issue REQ_OP_ZONE_RESET_ALL and report :-
blkzone reset /dev/sdd
  start: 0x000000000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
REQ_OP_ZONE_RESET_ALL : Pass
# 


3. Test for null_blk (REQ_OP_ZONE_RESET) :-

a. Load the null_blk and populate the zones :-
# modprobe null_blk zoned=1 zone_size=128 gb=1 bs=4096
# ./reset_all_test.sh /dev/nullb0
dd if=/dev/zero of=/dev/nullb0 bs=4096 count=1 seek=0
dd if=/dev/zero of=/dev/nullb0 bs=4096 count=2 seek=32768
dd if=/dev/zero of=/dev/nullb0 bs=4096 count=4 seek=65536
dd if=/dev/zero of=/dev/nullb0 bs=4096 count=8 seek=98304
dd if=/dev/zero of=/dev/nullb0 bs=4096 count=16 seek=131072
dd if=/dev/zero of=/dev/nullb0 bs=4096 count=32 seek=163840
dd if=/dev/zero of=/dev/nullb0 bs=4096 count=64 seek=196608
dd if=/dev/zero of=/dev/nullb0 bs=4096 count=128 seek=229376
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000080 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000100 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000200 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000400 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]

b. Now Issue zone reset (REQ_OP_ZONE_RESET) starting from the last zone to the
   0rth and report zones :-

Starting REQ_OP_ZONE_RESET test :- 
blkzone reset -o 1835008 /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000080 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000100 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000200 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 7 :- ---------------------------------------------------------------
blkzone reset -o 1572864 /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000080 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000100 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 6 :- ---------------------------------------------------------------
blkzone reset -o 1310720 /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000080 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 5 :- ---------------------------------------------------------------
blkzone reset -o 1048576 /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 4 :- ---------------------------------------------------------------
blkzone reset -o 786432 /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 3 :- ---------------------------------------------------------------
blkzone reset -o 524288 /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 2 :- ---------------------------------------------------------------
blkzone reset -o 262144 /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 1 :- ---------------------------------------------------------------
blkzone reset -o 0 /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
ZONEID 0 :- ---------------------------------------------------------------

4. Test for null_blk (REQ_OP_ZONE_RESET_ALL) :-

a. Populate the zones :-
dd if=/dev/zero of=/dev/nullb0 bs=4096 count=1 seek=0
dd if=/dev/zero of=/dev/nullb0 bs=4096 count=2 seek=32768
dd if=/dev/zero of=/dev/nullb0 bs=4096 count=4 seek=65536
dd if=/dev/zero of=/dev/nullb0 bs=4096 count=8 seek=98304
dd if=/dev/zero of=/dev/nullb0 bs=4096 count=16 seek=131072
dd if=/dev/zero of=/dev/nullb0 bs=4096 count=32 seek=163840
dd if=/dev/zero of=/dev/nullb0 bs=4096 count=64 seek=196608
dd if=/dev/zero of=/dev/nullb0 bs=4096 count=128 seek=229376
  start: 0x000000000, len 0x040000, wptr 0x000008 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000010 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000020 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000040 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000080 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000100 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000200 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000400 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
-------------------------------------------------
b. Issue REQ_OP_ZONE_RESET_ALL and report :-
blkzone reset /dev/sdd
  start: 0x000000000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
# 
-- 
2.17.0

