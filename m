Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCE8C3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1688322D6D
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DHUBIShL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfHUGNx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:13:53 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45763 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfHUGNx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 02:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566368033; x=1597904033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=22LbrGmdfgSiYBlO20Pie1yzItTe2eIxl9QDNaARVf4=;
  b=DHUBIShLwYdadf4jBaAqipOG+re9qph975n6bLmnQtKCfO4c++FR3zZM
   wBg4HG/MLock7w495KxU4VciVEww099wXp51aSJ7GVRupIkA5d0yLNX7g
   1PjGYv8/qCVkjirZB0awZlxsTtPtDeC/2ezL4s9YwzKKBc3a/ArQsJ9f7
   tn2/tuviclprCbbsuQcLVX3/mhmaDeBZ0WwU2EmVaoVUjF1tMIFtU5gyh
   aIxHDIbVQ0AkkARfF3d1u3WffNwjHsYQj5546yCvT918p09o6QL1vh6BU
   zX3RS5gvrsm0wQg1RS/1cmSrei4epzyAkF1h4OOMnQ8QqlWSCeCaMlUqc
   Q==;
IronPort-SDR: s8JJWeII689Wjf+3gzPj6BDdHrSPr2w3r22yISgcuDFfORultqQRiihSDZmap/R4DE9fHZdTW3
 pZB+1x4MvkxNeRF7w8WWNMX6pfOnsj0Z9eScuDMgLdzaCXXw+baAZlXDuevxs15sFr9LTkY3kL
 lr3y7AEbdZxTZPZ/ym6MryJE7c4ioLN78jPRt5wm/J7IV2dZMZ3bcYeLAFovVqACHvJkBRP2d4
 UxBn3K8zj9y9oHQ27I+WzInw3bonsWVyoMDbZv4y0m1qVf0R/gv/BaoT7rwKp17Gvf6KRwBggz
 1Us=
X-IronPort-AV: E=Sophos;i="5.64,411,1559491200"; 
   d="scan'208";a="120898307"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 14:13:53 +0800
IronPort-SDR: ha3qAplBazpsuqLYmWiQudjXvMv40GaB72/T+ULE15rLpVfmeTTVc8lOPn6yIHvBA45/taxeBP
 PDSrbymIiaAXKzaYMjbIrYuanQuq0ENwSVqm0R5JGghRVCS2wDGvPls4LRU/jxmNQPHSVmkJcp
 BkI7mnP+8tuPTcU+iVZGf6TJM6HM+i1dOaOxU3mA2dwUnbrF5xN7N8GKRQsblkGxNzSWwoFA+g
 O7eJDwoUKC6bhvuAjHLUCGZvtXUd9TJndDUOSihRHrWqTvR8dHY17YxsPFlWMU5Sj8DF8N4sLy
 vFlQwOYJWwI1jCgy2Z4u4DUE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 23:11:14 -0700
IronPort-SDR: vdms8fkYU7kFg+9rKjdFm5sRinTGU0Veh/veX0/V5K/+X6twGGnmmCxB6RlZhsZOoTT2ITLHOC
 LmjjhxHUqi0z5E0TJZA7Xsa9DwhvyxTPXEwUd2DziVtGWvMq91ARUS0g+cBACxJ2IAVSxhgtWe
 MCMQopB5yijhico8KQ0Lul1jPKXQDIsSh3tLqXGDZrWS31mUQVBU1vhP9QMMmG0AYR33DesRvO
 63Je7B6YdJgQEYnWWRRk9ABgDXU9QHcRyBnXfEd+GPvZc19nHpI1vqQZfQ/dm8LDxznfsNWmW4
 FB4=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Aug 2019 23:13:52 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 5/6] null_blk: create a helper for zoned devices
Date:   Tue, 20 Aug 2019 23:13:13 -0700
Message-Id: <20190821061314.3262-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com>
References: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com>
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
 drivers/block/null_blk.h       | 19 +++++++++++++------
 drivers/block/null_blk_main.c  | 31 +++++++++++++++++++++++--------
 drivers/block/null_blk_zoned.c | 23 ++++++++++-------------
 3 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index a1b9929bd911..1a8d5a12461f 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -90,9 +90,9 @@ int null_zone_init(struct nullb_device *dev);
 void null_zone_exit(struct nullb_device *dev);
 int null_zone_report(struct gendisk *disk, sector_t sector,
 		     struct blk_zone *zones, unsigned int *nr_zones);
-void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
-			unsigned int nr_sectors);
-void null_zone_reset(struct nullb_cmd *cmd, sector_t sector);
+blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
+			     unsigned int nr_sectors);
+blk_status_t null_zone_reset(struct nullb_cmd *cmd, sector_t sector);
 #else
 static inline int null_zone_init(struct nullb_device *dev)
 {
@@ -106,10 +106,17 @@ static inline int null_zone_report(struct gendisk *disk, sector_t sector,
 {
 	return -EOPNOTSUPP;
 }
-static inline void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
-				   unsigned int nr_sectors)
+static inline blk_status_t null_zone_write(struct nullb_cmd *cmd,
+					   sector_t sector,
+					   unsigned int nr_sectors)
 {
+	return BLK_STS_NOTSUPP;
+}
+
+static inline blk_status_t null_zone_reset(struct nullb_cmd *cmd,
+					   sector_t sector)
+{
+	return BLK_STS_NOTSUPP;
 }
-static inline void null_zone_reset(struct nullb_cmd *cmd, sector_t sector) {}
 #endif /* CONFIG_BLK_DEV_ZONED */
 #endif /* __NULL_BLK_H */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 4299274cccfb..501af79bffb2 100644
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
@@ -1209,14 +1229,9 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
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
index 8c7f5bf81975..4e48b4e088ae 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -84,7 +84,7 @@ int null_zone_report(struct gendisk *disk, sector_t sector,
 	return 0;
 }
 
-void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
+blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
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
+blk_status_t null_zone_reset(struct nullb_cmd *cmd, sector_t sector)
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
@@ -149,4 +145,5 @@ void null_zone_reset(struct nullb_cmd *cmd, sector_t sector)
 		cmd->error = BLK_STS_NOTSUPP;
 		break;
 	}
+	return BLK_STS_OK;
 }
-- 
2.17.0

