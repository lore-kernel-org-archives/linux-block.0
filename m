Return-Path: <SRS0=AW5R=4G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D706BC34047
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B086C2464E
	for <linux-block@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DllHCT1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgBRR2y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:28:54 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:19382 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBRR2p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Feb 2020 12:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582046926; x=1613582926;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y1DvgfMLY6am9T4EUoU2acjdmlJYxmMPJUoxeuMBSAQ=;
  b=DllHCT1dIIGzuYaQKzyexcOOcz/i0Z3vuDerfPKWManS0cMXwbBTnFo0
   1VWAAdheeUiYDoCuTwjloUFgv+cH5hyEYvqHu4IvyG/l6wo/6qTUGvQs/
   u40YM3UEeoUh0JyZpXK0lqxlebyPAWh1ugivlKXz+smG8rf3IaQDUteNB
   l9IWsuF1qOchGt6UbJrD3+X9S/shmtdE4vhgspLQjPE0rPofBQLYkLbjb
   6fULaLJqnkMOf17CE6VosCnypqDwEOPEp3Ue7AZd2fxADZcmaxAeek+wC
   IieCOZn7FuV4Cmj5mZTelFa361r0FH39NzAMR+JPwViSe1oAssjkvbvQC
   Q==;
IronPort-SDR: EpwGJJFdpnzrUbLOzvLjRradncKT+XrYmbr8uOcfObcxdYKg+3QBqTrmyRAs/N+1zy1YQ1Ho55
 CBiVvQkctGhFuBaMj5ztE4BGkPpcs+MGcDT0GkUlvz8Kt9MfwIChjIH0Ns5OpdPKtZJJPNmlXw
 ROSirmrBENJzquYgwxhTam+XzY5f4MOXaPTlzky4l+9O0wgkpd6GQ3uNfbBLZF8SFXMX6Si9RP
 MhKXPmRh7u6rMy9WcNDHzeLijJPKuUuyOz0M8X1gh8z8fDkFfbkzpjslCy6B4pJtKlSIxVcDAT
 ZIg=
X-IronPort-AV: E=Sophos;i="5.70,456,1574092800"; 
   d="scan'208";a="231976942"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2020 01:28:46 +0800
IronPort-SDR: jbjSf+yI8eX1+bYTItf3PpGmHLfIMq4yj64nZ/BiJTuHz5uxqmmn6GBqU4AG6g/+Or+gSTZ5ZF
 LNrFWar5MKFc419LDvYneSYU8zl2ja4Y030xhgFe9VaJHbacS5ZSwEI7zqorC5SD6Ospr6m8ln
 cBDryzZGRIOrRkVP939DaPRcQlHJU1Aj/sYOOAA+TiU04QD0R8oknQssBP3bQ8uM6TBlmM47QL
 GYLX/g1tcOZbZsCF60Fz9jU6+j7Zowbzs7eLx7McV+YfOtZL+TsL+f8+7i5SJQgWYzTVZYocgp
 RPSfe9rxUdZf0BBuq58vFPTN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 09:21:23 -0800
IronPort-SDR: regFz++hL4c3o5HKRALSPtrF2eG8fZPUbvrKNo0ZQMVqs8flhrZd6nWuJaBafKVew1BiWjNpdM
 X+i7wXe0zn/xbcBOohcQfMUDD5A4fWVE2NWoZEiB58Fpav6/7qfaqCurdkq1Dc/166wojW/sdo
 6vcZARtRScdZEhYimSSIzeVhFUEKhzNkRUp9oqs//XSvny62QTVsFGpnp1w2yeLh+khnwF/iy+
 rjMNelvyGzh3Zmx2J91gKgz0PGwQyezHXFyehlU+Z8qvgmr40Xl507fsE7m0ooEoI1g29LVcoc
 eZI=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2020 09:28:44 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     damien.lemoal@wdc.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 0/3] null_blk: add tracnepoints for zoned mode
Date:   Tue, 18 Feb 2020 09:28:37 -0800
Message-Id: <20200218172840.4097-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Recently we've added several new operations for zoned block devices
blk-zone.c ZBD). These operations have a direct effect on the
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

Please have a look at the end for sample output.

The change-log is present in the respective patches.

Regards,
Chaitanya              


Chaitanya Kulkarni (3):
  block: add a zone condition debug helper
  null_blk: add tracepoint helpers for zoned mode
  null_blk: add trace in null_blk_zoned.c

 block/blk-zoned.c              | 32 ++++++++++++++
 drivers/block/Makefile         |  3 ++
 drivers/block/null_blk_trace.c | 20 +++++++++
 drivers/block/null_blk_trace.h | 78 ++++++++++++++++++++++++++++++++++
 drivers/block/null_blk_zoned.c | 12 +++++-
 include/linux/blkdev.h         | 10 +++++
 6 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 drivers/block/null_blk_trace.c
 create mode 100644 drivers/block/null_blk_trace.h


Sample Test Output :-

# modprobe null_blk zoned=1 zone_size=128 gb=1 bs=4096
# cd /sys/kernel/debug/tracing/
# echo 1 > events/nullb/enable; cat trace_pipe 
# for i in open close finish reset; do blkzone $i /dev/nullb0; done 
# dd if=/dev/zero of=/dev/nullb0 bs=4k count=5

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
2.22.1

