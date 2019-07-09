Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B65C73C46
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 19:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9EB2073D
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 19:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rPkRgFVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfGITWH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:22:07 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:6039 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGITWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 15:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562700126; x=1594236126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vka4gF+q3n34jM3TSnV4rsQD0pK1SOSpD7LRw7fJHTk=;
  b=rPkRgFVcxB42vx73dvVBeBAhF4hvw5cbbWayh1kRb+5VyRODb1U0u/PO
   7wzgG9MyDFNgb1KPCQ1oUrSyyCTl/cc9R8fw3ORo0x8VgwM86tvRHRzv1
   qDTrDGgRdakWi+dArL17ma0fP9juwt8qx1yAwAzVfi+Ue69NBj73r6Dtt
   p3s9tXonCVLJKu6dvA/N/MFP7WUcyButdUhOrVfSIXEe4Q4NnTEXbZ9gy
   Ftk0ZY9pk6vBLKZ39FOJINBwPAGiDYg3EnOr9mBYUYia/ryolnNG+VzNB
   rvZG4gqs5M9jWfpdX4KxFB0YzbbQ4sssuQiS4zaX+tCoD2JZvPNGoWrdJ
   g==;
IronPort-SDR: UcYW8qVBRYkTv0TAiZlDqbE897NtmqtSWvlwyEeL34h7dPhLRanLW0hmJ46iV34FlEgfTWBII6
 Ap1PmIUjVmDg7o8raQogccgLR36p7f4Mg3ZizPSaljBDc4Jp6tja5oaqYjRdGYthDYMJEcFLiY
 qVGimS7O8j9qs8XEmdRyw4GQBciHV5Fp+BCs5Tz7ujxmbsgXmjfLqE6naB5hDl3ckD1Ew/qrvp
 hCW50dZ+4VQX1wo8MBhrr7ZF2zJKm1WlvmX01+Q7sRfbop7wpb++REaDGJxi1MKSlPv0GPmDvA
 8PQ=
X-IronPort-AV: E=Sophos;i="5.63,471,1557158400"; 
   d="scan'208";a="113750754"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 03:22:06 +0800
IronPort-SDR: TBXsQRgzGX6yqlW6OLQgTRz7peh0nJgpqewbYabjEq7K8DeK06J7dh8Hsg/1Cfn3N5ioccv+zB
 p7ENJiUYX3PdLn6IxnNlDC891HbrlMGFTcSQDLfc2oZy4BdDkQfShpZo1noICjmzSrPs+XtOy8
 q5cPe/JHRaDiNiMn7JnYoa4c1ZKjc4IItbVaAJCrK771RM98dq3ailfZM9PfSdR9o4xhz5iak7
 h6dVpSaDvUXhMxWUN/2SNqaewSvEDRp0u/Y91eF9gGL8nJPG8wIVFZ7kCfm8vA/EPv5pYbhLX1
 ldjsLi+FgACND1NXpAwFKcOL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 09 Jul 2019 12:20:52 -0700
IronPort-SDR: +jtQ0NeqSwr1KLmICk4efLmnVD5S8oNjUqIzuv4/Wpc9iRR7ra24nFYxGRr1Kn/fHdyx9kGMAK
 yx83r07ig4+LFDYaq3iA8WWrCoTChOwK6ikXdYci5uV8xzE/Q4ZDgObgrnpwkBpYLNFxqf2bbB
 +ef2wfWdAmjoEqR/Mxj2XC01uEJm3uBxIqwAcLoPZN6FIar5nYSkGEiYScSGra2/hT1JWlxKsZ
 6D8sciezMOBzJ4yzUOKMzXxlKV9vWT5x+oqzvNH+2YNbsP7Zgh7PLjTnn3hlmw2lphoTH8XOL6
 a0E=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 12:22:06 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 5/6] null_blk: create a helper for zoned devices
Date:   Tue,  9 Jul 2019 12:21:31 -0700
Message-Id: <20190709192132.24723-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190709192132.24723-1-chaitanya.kulkarni@wdc.com>
References: <20190709192132.24723-1-chaitanya.kulkarni@wdc.com>
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
memory backed case in the null_handle_cmd().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk.h       | 20 ++++++++++++++------
 drivers/block/null_blk_main.c  | 29 +++++++++++++++++++++++------
 drivers/block/null_blk_zoned.c | 29 ++++++++++++-----------------
 3 files changed, 49 insertions(+), 29 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 34b22d6523ba..3681b992f7ea 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -91,9 +91,9 @@ void null_zone_exit(struct nullb_device *dev);
 int null_zone_report(struct gendisk *disk, sector_t sector,
 		     struct blk_zone *zones, unsigned int *nr_zones,
 		     gfp_t gfp_mask);
-void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
-			unsigned int nr_sectors);
-void null_zone_reset(struct nullb_cmd *cmd, sector_t sector);
+blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
+			     unsigned int nr_sectors);
+blk_status_t null_zone_reset(struct nullb_cmd *cmd, sector_t sector);
 #else
 static inline int null_zone_init(struct nullb_device *dev)
 {
@@ -107,10 +107,18 @@ static inline int null_zone_report(struct gendisk *disk, sector_t sector,
 {
 	return -EOPNOTSUPP;
 }
-static inline void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
-				   unsigned int nr_sectors)
+
+static inline blk_status_t null_zone_write(struct nullb_cmd *cmd,
+					   sector_t sector,
+					   unsigned int nr_sectors)
+{
+	return BLK_STS_NOTSUPP;
+}
+
+static inline blk_status_t null_zone_reset(struct nullb_cmd *cmd,
+					   sector_t sector)
 {
+	return BLK_STS_NOTSUPP;
 }
-static inline void null_zone_reset(struct nullb_cmd *cmd, sector_t sector) {}
 #endif /* CONFIG_BLK_DEV_ZONED */
 #endif /* __NULL_BLK_H */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 7c503626a15c..8ec3753aaf9b 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1182,6 +1182,26 @@ static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
 	return errno_to_blk_status(err);
 }
 
+static inline blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
+					     enum req_opf op, sector_t sector,
+					     sector_t nr_sectors)
+{
+	blk_status_t sts = BLK_STS_OK;
+
+	switch (op) {
+	case REQ_OP_WRITE:
+		sts = null_zone_write(cmd, sector, nr_sectors);
+		break;
+	case REQ_OP_ZONE_RESET:
+		sts = null_zone_reset(cmd, sector);
+		break;
+	default:
+		break;
+	}
+
+	return sts;
+}
+
 static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 				    sector_t nr_sectors, enum req_opf op)
 {
@@ -1209,12 +1229,9 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 	if (dev->memory_backed)
 		cmd->error = null_handle_memory_backed(cmd, op);
 
-	if (!cmd->error && dev->zoned) {
-		if (op == REQ_OP_WRITE)
-			null_zone_write(cmd, sector, nr_sectors);
-		else if (op == REQ_OP_ZONE_RESET)
-			null_zone_reset(cmd, sector);
-	}
+	if (!cmd->error && dev->zoned)
+		cmd->error = null_handle_zoned(cmd, op, sector, nr_sectors);
+
 out:
 	/* Complete IO by inline, softirq or timer */
 	switch (dev->irqmode) {
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index fca0c97ff1aa..111b9ae6af6c 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -85,8 +85,8 @@ int null_zone_report(struct gendisk *disk, sector_t sector,
 	return 0;
 }
 
-void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
-		     unsigned int nr_sectors)
+blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
+			     unsigned int nr_sectors)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
@@ -95,15 +95,12 @@ void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	switch (zone->cond) {
 	case BLK_ZONE_COND_FULL:
 		/* Cannot write to a full zone */
-		cmd->error = BLK_STS_IOERR;
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
@@ -111,27 +108,25 @@ void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		zone->wp += nr_sectors;
 		if (zone->wp == zone->start + zone->len)
 			zone->cond = BLK_ZONE_COND_FULL;
-		break;
+		return BLK_STS_OK;
 	case BLK_ZONE_COND_NOT_WP:
-		break;
+		return BLK_STS_OK;
 	default:
 		/* Invalid zone condition */
-		cmd->error = BLK_STS_IOERR;
-		break;
+		return BLK_STS_IOERR;
 	}
 }
 
-void null_zone_reset(struct nullb_cmd *cmd, sector_t sector)
+blk_status_t null_zone_reset(struct nullb_cmd *cmd, sector_t sector)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
 	struct blk_zone *zone = &dev->zones[zno];
 
-	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
-		cmd->error = BLK_STS_IOERR;
-		return;
-	}
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		return BLK_STS_IOERR;
 
 	zone->cond = BLK_ZONE_COND_EMPTY;
 	zone->wp = zone->start;
+	return BLK_STS_OK;
 }
-- 
2.17.0

