Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C31C433FF
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 17:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BDC2087E
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 17:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jwaNG0vv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbfHAR1J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:27:09 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50974 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfHAR1I (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 13:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564680428; x=1596216428;
  h=from:to:cc:subject:date:message-id;
  bh=UgZyzlDPmvpkcRm9aKqpxG3RpH5XruKDKydt80tVJJw=;
  b=jwaNG0vvn46r07+2zkkr+/Ugb7ZMM7aHgziHAyJRlDb8ZFF7VhYdvJo7
   kTD9dhIM2q5oVQG8brSBHXbur9Ca6/0dWd0YUSvOhVYcmiY8oKw23ccs9
   gc9aef/8lB3vkgS9Wo3cGuCX4mlVUc/ZqAlHKCrLaG0uJzYmD0iVQH62z
   2jtjUS803nb7rJvfZ29KX/OxgcUNLmmGBzRYaycMvbslnuF1vKFlHapZn
   xR1La0i0IkO9ZipGcivQ/66T5eKzo5ITievQ47Y/V8BIDHGX4P9sb4X7Q
   7Pni7iVsiDbOHN0VlESnK0a/UXmnqV9IdVL1Q9ZmhO8XJnVMfgIAg47Kh
   g==;
IronPort-SDR: mwtZOU/w54cR9fngmLDMFY76nh1x7yZ7WP3ubgIJBmCtKdggYb1S4xB2MadKxU9ta0xszqP6Rh
 1he16g/DZT19iOmW7VGIwzZw1+4IGLAsteQ6eJcQVeH7lJJ2NFfJ7cOYLfPmZxEBr8zSn/xPzP
 8qVP2A7SngHta/iKCRpqEwli/dF/QrPAGElhP0fucvpvGo6wTWVjx/jMvg7BJrFvQSHWbw0bn4
 eqWhutIHUAzmlbyowH7a9YaUFc6cKjRopcLUgyzrwot4usp8VSQRpPvihtliAouyNC4a0wt+Kj
 Trc=
X-IronPort-AV: E=Sophos;i="5.64,334,1559491200"; 
   d="scan'208";a="116323208"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2019 01:26:54 +0800
IronPort-SDR: 4wkNseb3vqEsKsZb8TMgnUPxPcFql7l0FvYwqB1Ztt5BsPs/sq4SKMyV5HnCMZwsQQB45bw0n1
 NQ8IXq6HTMs13Gk8HjKBsmH4p2VKz2O3gwzlGEE2Mw44fgEtkwP4w6BvlFHOtxplDne2TiirG9
 LnwKqTrmAczzMG1ZRRYq7fQ+cGDYsnA/s3mgdMmssNFLREtFQGLVPm14SUtCN4w50fhqKT+A2/
 1vxQEOEu62MFb91djwfJnKqAZeya17VGKnqyW2J5MQBppRkX6tMbvwpYPUWioFCRbxqIMjYP+u
 CSVe7eeYS9UtkKy0xajmqyeS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 10:24:53 -0700
IronPort-SDR: bs/31Ga9R+LrzoE4HBcS+d1X+RY3HG/JM2bcNAsRtmIxnp1CNzjx5fQZzVyG/+Cpd1G5Hq1bY5
 oqe6HMLZCCDA//KlovWb+VxyaekSLC/xyRkZpsLzeb4ZSY84XXGeP2BAPkn49M3yg4y1N0uZ8H
 z3wdaOIuonSNGC8LNJdvclI0gDSaoSAlZhSden9obbuus1mLwqMh1emLNkTkD1woz4vUj5Plxm
 AM+EhMZhz84iI+11ZuHlA8AKM+H5xY0yDYmRBmE5OI0gLRwKGOumfv7JfaG+JMQTZNU/ZlrS7q
 J8E=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Aug 2019 10:26:55 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, dennis@kernel.org,
        hare@suse.com, damien.lemoal@wdc.com, sagi@grimberg.me,
        dennisszhou@gmail.com, jthumshirn@suse.de, osandov@fb.com,
        ming.lei@redhat.com, tj@kernel.org, bvanassche@acm.org,
        martin.petersen@oracle.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 0/4] block: introduce REQ_OP_ZONE_RESET_ALL
Date:   Thu,  1 Aug 2019 10:26:34 -0700
Message-Id: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
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

* Changes from V1:-

1. Get rid of the NULL assignment for bio in
   __blkdev_reset_all_zones().
2. Update comment for sd_zbc_setup_reset_cmnd().
3. Move call to set QUEUE_FLAG_ZONE_RESETALL flag into
   sd_zbc_read_zones().

Chaitanya Kulkarni (4):
  block: add req op to reset all zones and flag
  blk-zoned: implement REQ_OP_ZONE_RESET_ALL
  scsi: implement REQ_OP_ZONE_RESET_ALL
  null_blk: implement REQ_OP_ZONE_RESET_ALL

 block/blk-core.c               |  5 +++++
 block/blk-zoned.c              | 39 ++++++++++++++++++++++++++++++++++
 drivers/block/null_blk_main.c  |  3 +++
 drivers/block/null_blk_zoned.c | 28 ++++++++++++++++++------
 drivers/scsi/sd.c              |  5 ++++-
 drivers/scsi/sd.h              |  5 +++--
 drivers/scsi/sd_zbc.c          | 10 +++++++--
 include/linux/blk_types.h      |  2 ++
 include/linux/blkdev.h         |  3 +++
 9 files changed, 89 insertions(+), 11 deletions(-)

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

