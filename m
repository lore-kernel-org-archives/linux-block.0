Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32609C3A589
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 04:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED47C233FD
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 04:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g16sZ7FM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391765AbfHWEqH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 00:46:07 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3505 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389942AbfHWEqH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 00:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566535566; x=1598071566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Zyc6Q21AD+S60XUr9dTGz/44uiWt6W5q9gCT0tzG6ME=;
  b=g16sZ7FM4BnJR3hxDcwzcL9pgPr9zRhgGXc09iIbbC8aVDuq/2RVcvwi
   Cv2Z3ukq7fsBfq0fbX2tExOn4dc1nU1XRTlsVBgi4zIvuKoZlIFJhfE9A
   M/YyyzeyvZFcLMCkLPJEGxq6N3nWThvF0c9ZXPx/ikKDXm7X0GQI5ihkz
   L3hcAAAQrpTBNGeyNfvJu2X+1MSMnfl0Ht5ioHSZiSIIxFqmT8ytjlkqd
   ZLDslCvDtV1FR7HxZpQTzKvDE3NDKi3AanBD/+roTM1+CL2BOiO8Am7pL
   AhCg+EJyuDskX6iBd2/QOwSduDmyugSWVvVfD8jlkCIli0KGl/hULuXjN
   w==;
IronPort-SDR: V5gPrUk1UpgEMhKtTw7nqSYd3J/lhgSkHns1HwHD8rpLvgQafV2YhWBeqLpZIy0j87Li5S9iJi
 Ydz2bUky79M/YAhR9nlPRKZ0yYt92njkdL0wjSuo6xPUVbBL1ROe0JlJm3WTitw3hdPCNYDYjo
 IbquZ1vptZ+5o61/v/NrAtRd1k3q0rWHrGZZ7ChVpk86vwlYoqcimmvt0iuBCvLnp0GjtytKVA
 5Rg6CTK680rBWePaYqJmaXx1hxnGR/sMR4ZPmAcdn9dmrdxEJQfN9OTkaxrg+G0UtBa1wfLZ9x
 bjU=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="116493578"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 12:46:06 +0800
IronPort-SDR: jWNCI7Z09+qMT8Ha3wHxbhZtVMYkZDVrnHslmyYwr7Gk6BTzrX40T+wlJqnszsFJoFCWWW0qPi
 zKGmIbcfHlb22yjajSMkORd8aAfLbJ05xqrQ/mBUETFkX4DxbIon0VunMu0tcEwKy9KHiwe3OJ
 FtsPKrjVjCGhMSA78Pi85CJ12g/JgxxOzku7NhUdBcWwl5dZueCMXKAgZWgsL+DCiusy8Axhu/
 V7tYjnrKPr7ot2o5nWbH7EigH4Devtcun1koJOVax4G6Xz+6wZo6IK5/QLZbCM6rxDLshBd4Mv
 PIDOc7io20GpBDiJ7mHHLm6Z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 21:43:24 -0700
IronPort-SDR: h5JVtagmr1DBWiv4PWLhpNGXGbaNxxyZUzMShFprlese9Nx07qwPc0OIopgIe1tVJbMWObQKV9
 wKweP15H/ZtGEOSd3DGKTrRWPR5y7j8cgFJGmx/upXoJjjJPTiu+9PkJ/vuM/7wJr8upRdN3kD
 k6m/MFOly2oQ1WASOUOete5soKFFi8ZAlOIScSH1iugf6CG5qr3eyyzLGh0Yu0VjSeyfwPdMxn
 m7mKyiZnTui7dj6r4oQHKXegmJtPxZc7VP/j8IkWC7wViXxhsRiW/YsX7cfk8wwVnp6NLIq3Lk
 U30=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Aug 2019 21:46:06 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 5/6] null_blk: create a helper for zoned devices
Date:   Thu, 22 Aug 2019 21:45:18 -0700
Message-Id: <20190823044519.3939-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190823044519.3939-1-chaitanya.kulkarni@wdc.com>
References: <20190823044519.3939-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch creates a helper function for handling zoned block device
operations.

This patch also restructured the code for null_blk_zoned.c and uses the
pattern to return blk_status_t and catch the error in the function
null_handle_cmd() into cmd->error variable instead of setting it up in
the deeper layer just like the way it is done for flush, badblocks and
memory backed case in the null_handle_cmd(). We also move
null_handle_zoned() to the null_blk_zoned.c to keep the zoned code
separate.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk.h       | 13 ++++++------
 drivers/block/null_blk_main.c  | 11 +++-------
 drivers/block/null_blk_zoned.c | 38 ++++++++++++++++++++++------------
 3 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index a1b9929bd911..4895c02e0c65 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -90,9 +90,9 @@ int null_zone_init(struct nullb_device *dev);
 void null_zone_exit(struct nullb_device *dev);
 int null_zone_report(struct gendisk *disk, sector_t sector,
 		     struct blk_zone *zones, unsigned int *nr_zones);
-void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
-			unsigned int nr_sectors);
-void null_zone_reset(struct nullb_cmd *cmd, sector_t sector);
+inline blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
+				      enum req_opf op, sector_t sector,
+				      sector_t nr_sectors);
 #else
 static inline int null_zone_init(struct nullb_device *dev)
 {
@@ -106,10 +106,11 @@ static inline int null_zone_report(struct gendisk *disk, sector_t sector,
 {
 	return -EOPNOTSUPP;
 }
-static inline void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
-				   unsigned int nr_sectors)
+static inline blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
+					     enum req_opf op, sector_t sector,
+					     sector_t nr_sectors)
 {
+	return BLK_STS_NOTSUPP;
 }
-static inline void null_zone_reset(struct nullb_cmd *cmd, sector_t sector) {}
 #endif /* CONFIG_BLK_DEV_ZONED */
 #endif /* __NULL_BLK_H */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 4299274cccfb..bf40c3115bb9 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1209,14 +1209,9 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 	if (dev->memory_backed)
 		cmd->error = null_handle_memory_backed(cmd, op);
 
-	if (!cmd->error && dev->zoned) {
-		if (op == REQ_OP_WRITE)
-			null_zone_write(cmd, sector, nr_sectors);
-		else if (op == REQ_OP_ZONE_RESET)
-			null_zone_reset(cmd, sector);
-		else if (op == REQ_OP_ZONE_RESET_ALL)
-			null_zone_reset(cmd, 0);
-	}
+	if (!cmd->error && dev->zoned)
+		cmd->error = null_handle_zoned(cmd, op, sector, nr_sectors);
+
 out:
 	/* Complete IO by inline, softirq or timer */
 	switch (dev->irqmode) {
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 8c7f5bf81975..90092247e7eb 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -84,7 +84,7 @@ int null_zone_report(struct gendisk *disk, sector_t sector,
 	return 0;
 }
 
-void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
+static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		     unsigned int nr_sectors)
 {
 	struct nullb_device *dev = cmd->nq->dev;
@@ -95,14 +95,12 @@ void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	case BLK_ZONE_COND_FULL:
 		/* Cannot write to a full zone */
 		cmd->error = BLK_STS_IOERR;
-		break;
+		return BLK_STS_IOERR;
 	case BLK_ZONE_COND_EMPTY:
 	case BLK_ZONE_COND_IMP_OPEN:
 		/* Writes must be at the write pointer position */
-		if (sector != zone->wp) {
-			cmd->error = BLK_STS_IOERR;
-			break;
-		}
+		if (sector != zone->wp)
+			return BLK_STS_IOERR;
 
 		if (zone->cond == BLK_ZONE_COND_EMPTY)
 			zone->cond = BLK_ZONE_COND_IMP_OPEN;
@@ -115,12 +113,12 @@ void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		break;
 	default:
 		/* Invalid zone condition */
-		cmd->error = BLK_STS_IOERR;
-		break;
+		return BLK_STS_IOERR;
 	}
+	return BLK_STS_OK;
 }
 
-void null_zone_reset(struct nullb_cmd *cmd, sector_t sector)
+static blk_status_t null_zone_reset(struct nullb_cmd *cmd, sector_t sector)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
@@ -137,10 +135,8 @@ void null_zone_reset(struct nullb_cmd *cmd, sector_t sector)
 		}
 		break;
 	case REQ_OP_ZONE_RESET:
-		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
-			cmd->error = BLK_STS_IOERR;
-			return;
-		}
+		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+			return BLK_STS_IOERR;
 
 		zone->cond = BLK_ZONE_COND_EMPTY;
 		zone->wp = zone->start;
@@ -149,4 +145,20 @@ void null_zone_reset(struct nullb_cmd *cmd, sector_t sector)
 		cmd->error = BLK_STS_NOTSUPP;
 		break;
 	}
+	return BLK_STS_OK;
+}
+
+inline blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
+				       enum req_opf op, sector_t sector,
+				       sector_t nr_sectors)
+{
+	switch (op) {
+	case REQ_OP_WRITE:
+		return null_zone_write(cmd, sector, nr_sectors);
+	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_RESET_ALL:
+		return null_zone_reset(cmd, sector);
+	default:
+		return BLK_STS_OK;
+	}
 }
-- 
2.17.0

