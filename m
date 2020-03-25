Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F535C2D0E5
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 18:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0052074D
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 18:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mnaJGuLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCYSzG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:55:06 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50381 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgCYSzG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 14:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585162505; x=1616698505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/2tm6JN+K9WUiZK2olNqJaWYqm2PGe61MNQ88PYLHEE=;
  b=mnaJGuLldd71YtZMo8IoyDq3ldqVxI0Fgwn4pqyVfaakzEH7tvUzYlrW
   T80I2aafpbk4qPKQ2wb9ldfd8v88KsxNQT49vIhONuRdQGOrZLBt8fP38
   I7N3G8mEowbifqJqCFpQ1ed444uiEpcR7e2rFGi9MQ0xaMZ7Lf0MXyFQs
   OGpctSQBxujV3L8SHvmOgeVIGwFSWW1gKWpnV/iF3ZVrOtc7BqVjrXdq3
   RyEvKpOnPD+STECyzhj6AN06pglblTS/IJSqgI0Gn1nBT9nQZEiCC29RT
   JAIt9PusIZ0C6arGqsZ3t3Yc6mblxnzucVyycrdaI8ooEsdEaoyMnYvlh
   g==;
IronPort-SDR: HWgq7ub6CR90bzdFyNMciDYp1J80l5NxhkOW9uCWurKtHe1HapM0berM7f1Q0FTyspVrrCrhVA
 NrDMC8/AJxcje+AlR0ew8W4tejjuojIQymxak8uWao4ntqv9p+vkUIti7LWZZ10wB0lbZUMyEz
 8XMPpyfAAUx3x+AyV8dIUcO/uQv+x7byOG20Q4OEQWMm3pqmMozdDwcwqRFqCq4KVZzYoRNSXh
 Du5ADX3oAzdAzWozjrtpbr9uS76FCxnaj8bP3zPJvODLjhOtWbn1M8vzID9vb6m1wkxEkGyG1N
 XRs=
X-IronPort-AV: E=Sophos;i="5.72,305,1580745600"; 
   d="scan'208";a="241991757"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2020 02:55:05 +0800
IronPort-SDR: Wp8A8cNUThVhvfZ3qmXa4zpZJLV4rGlHcjb02IQXhuIGqFfiy8jc4rAHy7sGzqQvlWXIo56jI2
 Menz32R+srDHvNWBzm0jYfD9Use3DAZXEjJwWXz23dhqur40alNKhnCbwl8Ru5YAOLF1rCSGE0
 X/BPs0eNY6dKboQcRsYNSSlJrqknloht9aJMGQUxPw2rIM7yDUqv/UpLs6MMz3VxzsW4ezbpc6
 7RJBam9B44s4D4n1An/F2QMS4EkCFrzZiDnJX86WKuuLagtOUgZTdGuvS18mcdsSenBt85cpjP
 TUJ7BQF7gKQroIHzyfHyT2wA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 11:46:43 -0700
IronPort-SDR: /tudSr/UXH/+5vPP2CS3ojmhtteZPGSH60a9Mawk7fXRjC3w7JtHDRHihTiw821dsKY8zvoZUN
 noEzXzja/ZjZqzKgwEbiUCJJemyjg+tk3Lku8c2WGech1F8tbd5t2WV6LwOPvEsSD60TrQ6qrL
 jS+lAeblf7pF07aafzT1pD/WFFAa9yjDc5BtWcoukXrppLIXQRAZT3tvtHNQlTL+hp2fE812nB
 WXyERoY4JymABuvrQtsPXVLwkK2U4vwN9CeZhQqIhq6vazynuiKr1VtN0KrVCGQFClFrEhEw2Z
 p9g=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Mar 2020 11:55:05 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 0/3] null_blk: add tracepoints for zoned mode
Date:   Wed, 25 Mar 2020 10:49:53 -0700
Message-Id: <20200325174956.16719-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Recently we've added several new operations for zoned block devices
blk-zone.c (ZBD). These operations have a direct effect on the
zone-state machine present in the null_blk_zoned.c. 

This will allow us to add new testcases in blktests in order to verify
the correct operations on the driver side.

This is a small patch series which adds tracepoints for the null_blk
block driver when configured in a zoned mode (with command line
parameter zoned=1).

The first patch is a prep patch that adds a helper to stringify zone
conditions which we use in the trace, the second patch adds new
tracepoint definitions and the third patch allows null_blk_zoned to
trace operations.

Please have a look at the end for sample test output which has tests
for CONFIG_BLK_DEV_ZONED and !CONFIG_BLK_DEV_ZONED.

Regards,
Chaitanya              

Changes from V3: -

1. Move blk_zone_cond_str() declaration under CONFIG_BLK_DEV_ZONED in
   blkdev.h.

Changes from V2 : -

1. Only compile null_blk_trace.c file if tracing and blk_dev_zoned is
   enabled.
2. Add a test log with and without CONFIG_BLK_DEV_ZONED.
3. Move Change log to the cover-letter.
4. Declare blk_zone_cond_str() without any CONFIG_BLK_DEV_ZONED
   conditions. 
5. Add a comment to the ${KDIR_HOME}/drivers/block/Makefile about
   whay we need ccflags-y.
6. Fix cover-letter header.
7. Add a copyright banner in null_blk_trace.c.

Changes from V1 : -

1. Move blk_zone_cond_str() to blk-zoned.c.
2. Mark zone_cond_namd array static.
3. Remove BLK_ZONE_COND_LAST.
4. Get rid of inline prefix for blk_zone_cond_str().
5. Use CONFIG_BLK_DEV_ZONE for null_blk_trace.o. 

Chaitanya Kulkarni (3):
  block: add a zone condition debug helper
  null_blk: add tracepoint helpers for zoned mode
  null_blk: add trace in null_blk_zoned.c

 block/blk-zoned.c              | 32 ++++++++++++++
 drivers/block/Makefile         |  6 +++
 drivers/block/null_blk_trace.c | 21 +++++++++
 drivers/block/null_blk_trace.h | 79 ++++++++++++++++++++++++++++++++++
 drivers/block/null_blk_zoned.c | 12 +++++-
 include/linux/blkdev.h         |  4 ++
 6 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 drivers/block/null_blk_trace.c
 create mode 100644 drivers/block/null_blk_trace.h

Test Results :-

1. With CONFIG_BLK_DEV_ZONED DISABLED :-
----------------------------------------

# zcat /proc/config.gz | grep BLK_DEV_ZONED 
# CONFIG_BLK_DEV_ZONED is not set
# makej M=drivers/block
  MODPOST 11 modules
  CC [M]  drivers/block/brd.mod.o
  CC [M]  drivers/block/floppy.mod.o
  CC [M]  drivers/block/loop.mod.o
  CC [M]  drivers/block/mtip32xx/mtip32xx.mod.o
  CC [M]  drivers/block/null_blk.mod.o    <---
  CC [M]  drivers/block/pktcdvd.mod.o
  CC [M]  drivers/block/rbd.mod.o
  CC [M]  drivers/block/sx8.mod.o
  CC [M]  drivers/block/virtio_blk.mod.o
  CC [M]  drivers/block/xen-blkfront.mod.o
  CC [M]  drivers/block/zram/zram.mod.o
  LD [M]  drivers/block/xen-blkfront.ko
  LD [M]  drivers/block/brd.ko
  LD [M]  drivers/block/rbd.ko
  LD [M]  drivers/block/virtio_blk.ko
  LD [M]  drivers/block/sx8.ko
  LD [M]  drivers/block/floppy.ko
  LD [M]  drivers/block/null_blk.ko       <---
  LD [M]  drivers/block/pktcdvd.ko
  LD [M]  drivers/block/loop.ko
  LD [M]  drivers/block/zram/zram.ko
  LD [M]  drivers/block/mtip32xx/mtip32xx.ko
# insmod drivers/block/null_blk.ko 
# dmesg  -c
[ 1610.279303] null_blk: loading out-of-tree module taints kernel.
[ 1610.279390] null_blk: module verification failed: signature and/or required key missing - tainting kernel
[ 1610.290823] null_blk: module loaded
# rmmod  drivers/block/null_blk.ko 
# insmod drivers/block/null_blk.ko zoned=1
insmod: ERROR: could not insert module drivers/block/null_blk.ko: Invalid parameters
# dmesg  -c
[ 1627.347747] null_blk: CONFIG_BLK_DEV_ZONED not enabled
# ls /sys/kernel/debug/tracing/events/ | grep null
# echo $?
1

2. With CONFIG_BLK_DEV_ZONED ENABLED :-
---------------------------------------

# zcat /proc/config.gz | grep BLK_DEV_ZONED
CONFIG_BLK_DEV_ZONED=y
# makej M=drivers/block/
  AR      drivers/block//built-in.a
  CC [M]  drivers/block//floppy.o
  CC [M]  drivers/block//brd.o
  CC [M]  drivers/block//loop.o
  CC [M]  drivers/block//pktcdvd.o
  CC [M]  drivers/block//virtio_blk.o
  CC [M]  drivers/block//zram/zcomp.o
  CC [M]  drivers/block//mtip32xx/mtip32xx.o
  CC [M]  drivers/block//sx8.o
  CC [M]  drivers/block//zram/zram_drv.o
  CC [M]  drivers/block//rbd.o
  CC [M]  drivers/block//xen-blkfront.o
  CC [M]  drivers/block//null_blk_main.o  <---
  CC [M]  drivers/block//null_blk_trace.o <---
  CC [M]  drivers/block//null_blk_zoned.o <---
  LD [M]  drivers/block//zram/zram.o
  LD [M]  drivers/block//null_blk.o
  MODPOST 11 modules
  CC [M]  drivers/block//brd.mod.o
  CC [M]  drivers/block//floppy.mod.o
  CC [M]  drivers/block//loop.mod.o
  CC [M]  drivers/block//mtip32xx/mtip32xx.mod.o
  CC [M]  drivers/block//null_blk.mod.o   <---
  CC [M]  drivers/block//pktcdvd.mod.o
  CC [M]  drivers/block//rbd.mod.o
  CC [M]  drivers/block//sx8.mod.o
  CC [M]  drivers/block//virtio_blk.mod.o
  CC [M]  drivers/block//xen-blkfront.mod.o
  CC [M]  drivers/block//zram/zram.mod.o
  LD [M]  drivers/block//pktcdvd.ko
  LD [M]  drivers/block//floppy.ko
  LD [M]  drivers/block//brd.ko
  LD [M]  drivers/block//mtip32xx/mtip32xx.ko
  LD [M]  drivers/block//loop.ko
  LD [M]  drivers/block//virtio_blk.ko
  LD [M]  drivers/block//null_blk.ko
  LD [M]  drivers/block//rbd.ko
  LD [M]  drivers/block//xen-blkfront.ko
  LD [M]  drivers/block//sx8.ko
  LD [M]  drivers/block//zram/zram.ko
# insmod drivers/block/null_blk.ko
# dmesg -c
[  543.576548] null_blk: module loaded
# lsblk | grep nullb0
nullb0          252:0    0   250G  0 disk 
# rmmod null_blk
# insmod drivers/block/null_blk.ko zoned=1 zone_size=128 gb=1
# dmesg -c
[  543.654579] null_blk: module loaded
# lsblk | grep nullb0
nullb0          252:0    0     1G  0 disk 
# blkzone report /dev/nullb0
  start: 0x000000000, len 0x040000, capacity: 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, capacity: 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, capacity: 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, capacity: 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, capacity: 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, capacity: 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, capacity: 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, capacity: 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
# echo 1 > /sys/kernel/debug/tracing/events/nullb/enable 
# for i in open close finish reset; do blkzone $i /dev/nullb0 ; done
# cat /sys/kernel/debug/tracing/trace_pipe 
   nullb_zone_op: disk=nullb0,  req=ZONE_OPEN       zone_no=0 zone_cond=EXP_OPEN  
   nullb_zone_op: disk=nullb0,  req=ZONE_OPEN       zone_no=1 zone_cond=EXP_OPEN  
   nullb_zone_op: disk=nullb0,  req=ZONE_OPEN       zone_no=2 zone_cond=EXP_OPEN  
   nullb_zone_op: disk=nullb0,  req=ZONE_OPEN       zone_no=3 zone_cond=EXP_OPEN  
   nullb_zone_op: disk=nullb0,  req=ZONE_OPEN       zone_no=4 zone_cond=EXP_OPEN  
   nullb_zone_op: disk=nullb0,  req=ZONE_OPEN       zone_no=5 zone_cond=EXP_OPEN  
   nullb_zone_op: disk=nullb0,  req=ZONE_OPEN       zone_no=6 zone_cond=EXP_OPEN  
   nullb_zone_op: disk=nullb0,  req=ZONE_OPEN       zone_no=7 zone_cond=EXP_OPEN  
   nullb_zone_op: disk=nullb0,  req=ZONE_CLOSE      zone_no=0 zone_cond=EMPTY     
   nullb_zone_op: disk=nullb0,  req=ZONE_CLOSE      zone_no=1 zone_cond=EMPTY     
   nullb_zone_op: disk=nullb0,  req=ZONE_CLOSE      zone_no=2 zone_cond=EMPTY     
   nullb_zone_op: disk=nullb0,  req=ZONE_CLOSE      zone_no=3 zone_cond=EMPTY     
   nullb_zone_op: disk=nullb0,  req=ZONE_CLOSE      zone_no=4 zone_cond=EMPTY     
   nullb_zone_op: disk=nullb0,  req=ZONE_CLOSE      zone_no=5 zone_cond=EMPTY     
   nullb_zone_op: disk=nullb0,  req=ZONE_CLOSE      zone_no=6 zone_cond=EMPTY     
   nullb_zone_op: disk=nullb0,  req=ZONE_CLOSE      zone_no=7 zone_cond=EMPTY     
   nullb_zone_op: disk=nullb0,  req=ZONE_FINISH     zone_no=0 zone_cond=FULL      
   nullb_zone_op: disk=nullb0,  req=ZONE_FINISH     zone_no=1 zone_cond=FULL      
   nullb_zone_op: disk=nullb0,  req=ZONE_FINISH     zone_no=2 zone_cond=FULL      
   nullb_zone_op: disk=nullb0,  req=ZONE_FINISH     zone_no=3 zone_cond=FULL      
   nullb_zone_op: disk=nullb0,  req=ZONE_FINISH     zone_no=4 zone_cond=FULL      
   nullb_zone_op: disk=nullb0,  req=ZONE_FINISH     zone_no=5 zone_cond=FULL      
   nullb_zone_op: disk=nullb0,  req=ZONE_FINISH     zone_no=6 zone_cond=FULL      
   nullb_zone_op: disk=nullb0,  req=ZONE_FINISH     zone_no=7 zone_cond=FULL      
   nullb_zone_op: disk=nullb0,  req=ZONE_RESET_ALL  zone_no=0 zone_cond=EMPTY     
   nullb_zone_op: disk=nullb0,  req=WRITE           zone_no=0 zone_cond=IMP_OPEN  
   nullb_zone_op: disk=nullb0,  req=WRITE           zone_no=0 zone_cond=IMP_OPEN  
   nullb_zone_op: disk=nullb0,  req=WRITE           zone_no=0 zone_cond=IMP_OPEN  
   nullb_zone_op: disk=nullb0,  req=WRITE           zone_no=0 zone_cond=IMP_OPEN  
   nullb_zone_op: disk=nullb0,  req=WRITE           zone_no=0 zone_cond=IMP_OPEN  

-- 
2.22.0

