Return-Path: <SRS0=Iyu6=4D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D28EC35242
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 00:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5862083B
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 00:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lQUYb7rN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgBOA6B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:58:01 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49846 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgBOA6A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 19:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581728280; x=1613264280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gD1skkDmGJHe05d4BOl8LGuzLYSqtI8mjmeXb2ght7U=;
  b=lQUYb7rNfp0SFwSS1P0AXRJ1dctPE6Pzy9dFQZx/ioXIAogPvIaLb3NY
   3XlRKRBtooM1I/WLaqVV8kEreclvAnzD+rPtql02tO8Q5S0bTkQygr4+6
   jubTwrxK5fsfPQE5YCXI8mByfQMeiLbc0hld8IL6rT+OOMxkslK3Evy+T
   TP315rTcYMFjP1eUlO7f2PgPG5S2/JvFOl8hWoX9W+Xz9etmsC7XbC2dw
   w9qcoJ8DcNIexatSqysQi63eakEPoNmPRbSQ7SEgEvEKXsazt1m01nfF8
   N/e71J9ojhddg3WaYs2GYCEV2d8b+zda4ppDIUwx2YpTW2VyKVLQcF6pg
   g==;
IronPort-SDR: 8Y3DuM9BZGKOc9O9AfTk7ckw+sKM58GWbmFCVqpjWQ+UxKmU0SjJOtzMx5H02mlmtkFpsZpgcK
 knehYAizj2yVxCWmYm4smwkrjxpFTRjmWrELNe1BZ6Bs6BlSt8Eu1Wl+EFam1PoS+ha7BCeb45
 NbVh6EtOIKHsGLYDWQCD8uGyUNjSQvaEVU32iG8sLyeJxpUd4/yLOnPFiGpANEymfcWBlulBbQ
 PkB3bVDraIj1MWT58WyDeqi7niH4jBDVwe/KMN3sxmO7E9ynN8F6elvoKiDf3W271CcTIXw3fL
 G8w=
X-IronPort-AV: E=Sophos;i="5.70,442,1574092800"; 
   d="scan'208";a="129905392"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2020 08:57:59 +0800
IronPort-SDR: a+9SUcIk4Spwm8kC6B14/aYvqVYQ7FAiti4G6unfsleRvaUL/V9mJiWuUeimVhQm59UkVfy3Co
 h5l35xJZ1rjhrg1DfhHTQDVKtfMPn/H42900QAot1WVD3Xb6kjIHWFXKbtuRW35ptEUu/xyQoE
 aFE/IV7HTfRx0pDCcKOlNxkxnsxT/GP/S1SiNAM05EsfLZdORnBk8BK3v9BwvIrUjzDsap8EfY
 PW6iupt0CXF5wFLVLywLZNtY1NacUndkfidTfx3R5G6FAs9+6aqH2VyFMhqNMELaOVOaCHQAr6
 trEjVvntvN2TN/zkacUQR/oD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 16:50:45 -0800
IronPort-SDR: DoYvh1Llc3oiL9bvqIwQ3dlFykHwDtSP/XUUGFw2bmBSCgmjO1BY8+l/crZj+n8WgIT0o0cPC9
 C7O244ArHEtU9+wH7KcnJ/IEl7odqUVupGLwXbsnOIZBrogDC2Y7j015JHtbTI1r6R/MWUUGlC
 +sX/9Lp4S7rlbH3fUQlDGPwfiV0sc5W5wyKKm8Ni0MqneoMbOMqwWfwrXaij9QA9REiRFMxei7
 BjLPiQ2dfnn1EUrO8nNfwKoSXLoViLOqcnRBcw8NBWJZPU7GAnriJWgICy9KihLJlbrJGFXtJm
 6dQ=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Feb 2020 16:58:00 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, damien.lemoal@wdc.com
Cc:     kbusch@kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/3] null_blk: add tracnepoints for zoned mode
Date:   Fri, 14 Feb 2020 16:57:55 -0800
Message-Id: <20200215005758.3212-1-chaitanya.kulkarni@wdc.com>
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

P.S. I've kept the helper function blk_zone_cond_str() into header
file, please let me know if it needs to be in the blk-zoned.c.

Regards,
Chaitanya              

Chaitanya Kulkarni (3):
  block: add zone condition debug helpers
  null_blk: add tracepoint helpers for zoned mode
  null_blk: add trace in null_blk_zoned.c

 block/blk-zoned.c              | 14 ++++++
 drivers/block/Makefile         |  3 ++
 drivers/block/null_blk_trace.c | 20 +++++++++
 drivers/block/null_blk_trace.h | 78 ++++++++++++++++++++++++++++++++++
 drivers/block/null_blk_zoned.c | 12 +++++-
 include/linux/blkdev.h         | 26 ++++++++++++
 include/uapi/linux/blkzoned.h  |  1 +
 7 files changed, 153 insertions(+), 1 deletion(-)
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

