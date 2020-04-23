Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23CFC55185
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 03:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB32720767
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 03:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ArknReVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgDWDCl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 23:02:41 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26228 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgDWDCk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 23:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587610960; x=1619146960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=76LiDw8ZtqUT1cqFKXQnb/Nt5dZXLMAGDMK7U4qXzWo=;
  b=ArknReVZMIJsx6b3/Q8apXzov79Yd/DB/8WkcHGGs9+8RYWYmOiT/+Ao
   YPkvnA6tWIpnY8MYkBVsfPLuIqxkIS9vMYYOpSH+V+zqJvn7yNtOLObGq
   /wPdGgSae0B5eByOgVTrgBpPGs3dajt7FlSIbFTlNQLd2AdxSGdnZIjWF
   fUmtQcbQGo02M1P0y+n3JZZp9h7peCHR0lcObhVI69FSW54gZQwaF77j+
   dHNC0xHJTMfXnFaZ1DQDUwCCZzK6wMZbTaCiOXZMoGZ2ONIlGh98dNGJ5
   X9Vyuvt83rXhKhoze8WmkQQvmKC4Rkm/W3jIX2Z65gmvezmqsCrfPI8XZ
   g==;
IronPort-SDR: hwuWzmDWmfU4bo1upUYBApbZ0FTCWrWGmOiYw71ouURIHWEussXczzWOwsbIkFr121QTpy+PLC
 5R/jKHfRcANCl0oRWNouRngZC1P3Q+/vRi8apwsl0D3UD5NFSbSa72evdPendCCDcMugwm1w6g
 9hb4F+NGuvZgdO6Or3X60oRGqHvdzA755/67Z/aOjBRKb942NBw5gPZvSE6UYOwk/12cvloMPw
 EsqrNca6RngL901m6UFqNSSY6Y/0K5GDuBqdL0LjRbn3QJn+y+RpPLpb1Mq2dh/PK//K6P9+kE
 mcM=
X-IronPort-AV: E=Sophos;i="5.73,305,1583164800"; 
   d="scan'208";a="140292053"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 11:02:40 +0800
IronPort-SDR: ZexnJL+vLiW9FSws31ire8g6Z2BYQ0T9K4EvBq6MIU1QfYfuGs4u3AbxGYSxP0DRnhbd9nbZrc
 gOic/ar+41RlnP9Tee/xSx91iLIN9NCwo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 19:53:29 -0700
IronPort-SDR: P0YoFadZt/t7goEhBzwObD5RpUVU8vHtoy9ay6+7ctvegIq35IOX2+E7Jom9aAbMK/29+g4Foo
 Rscg/1RPHs9w==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Apr 2020 20:02:40 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 1/2] null_blk: Fix zoned command handling
Date:   Thu, 23 Apr 2020 12:02:37 +0900
Message-Id: <20200423030238.494843-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200423030238.494843-1-damien.lemoal@wdc.com>
References: <20200423030238.494843-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For write operations issued to a null_blk device with zoned mode
enabled, the state and write pointer position of the zone targeted by
the command should be checked before badblocks and memory backing
are handled as the write may be first failed due to, for instance, a
sector position not aligned with the zone write pointer. This order of
checking for errors reflects more accuratly the behavior of physical
zoned devices.

Furthermore, the write pointer position of the target zone should be
incremented only and only if no errors are reported by badblocks and
memory backing handling.

To fix this, introduce the small helper function null_process_cmd()
which execute null_handle_badblocks() and null_handle_memory_backed()
and use this function in null_zone_write() to correctly handle write
requests to zoned null devices depending on the type and state of the
write target zone. Also call this function in null_handle_zoned() to
process read requests to zoned null devices.

null_process_cmd() is called directly from null_handle_cmd() for
regular null devices, resulting in no functional change for these type
of devices. To have symmetric names, the function null_handle_zoned()
is renamed to null_process_zoned_cmd().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/null_blk.h       | 15 +++++++++------
 drivers/block/null_blk_main.c  | 35 +++++++++++++++++++++++-----------
 drivers/block/null_blk_zoned.c | 24 +++++++++++++----------
 3 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 62b660821dbc..83320cbed85b 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -85,14 +85,18 @@ struct nullb {
 	char disk_name[DISK_NAME_LEN];
 };
 
+blk_status_t null_process_cmd(struct nullb_cmd *cmd,
+			      enum req_opf op, sector_t sector,
+			      unsigned int nr_sectors);
+
 #ifdef CONFIG_BLK_DEV_ZONED
 int null_zone_init(struct nullb_device *dev);
 void null_zone_exit(struct nullb_device *dev);
 int null_report_zones(struct gendisk *disk, sector_t sector,
 		      unsigned int nr_zones, report_zones_cb cb, void *data);
-blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
-				enum req_opf op, sector_t sector,
-				sector_t nr_sectors);
+blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd,
+				    enum req_opf op, sector_t sector,
+				    sector_t nr_sectors);
 size_t null_zone_valid_read_len(struct nullb *nullb,
 				sector_t sector, unsigned int len);
 #else
@@ -102,9 +106,8 @@ static inline int null_zone_init(struct nullb_device *dev)
 	return -EINVAL;
 }
 static inline void null_zone_exit(struct nullb_device *dev) {}
-static inline blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
-					     enum req_opf op, sector_t sector,
-					     sector_t nr_sectors)
+static inline blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd,
+			enum req_opf op, sector_t sector, sector_t nr_sectors)
 {
 	return BLK_STS_NOTSUPP;
 }
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 4e1c0712278e..8335e2b04aac 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1276,6 +1276,25 @@ static inline void nullb_complete_cmd(struct nullb_cmd *cmd)
 	}
 }
 
+blk_status_t null_process_cmd(struct nullb_cmd *cmd,
+			      enum req_opf op, sector_t sector,
+			      unsigned int nr_sectors)
+{
+	struct nullb_device *dev = cmd->nq->dev;
+	blk_status_t ret;
+
+	if (dev->badblocks.shift != -1) {
+		ret = null_handle_badblocks(cmd, sector, nr_sectors);
+		if (ret != BLK_STS_OK)
+			return ret;
+	}
+
+	if (dev->memory_backed)
+		return null_handle_memory_backed(cmd, op);
+
+	return BLK_STS_OK;
+}
+
 static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 				    sector_t nr_sectors, enum req_opf op)
 {
@@ -1294,17 +1313,11 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 		goto out;
 	}
 
-	if (nullb->dev->badblocks.shift != -1) {
-		cmd->error = null_handle_badblocks(cmd, sector, nr_sectors);
-		if (cmd->error != BLK_STS_OK)
-			goto out;
-	}
-
-	if (dev->memory_backed)
-		cmd->error = null_handle_memory_backed(cmd, op);
-
-	if (!cmd->error && dev->zoned)
-		cmd->error = null_handle_zoned(cmd, op, sector, nr_sectors);
+	if (dev->zoned)
+		cmd->error = null_process_zoned_cmd(cmd, op,
+						    sector, nr_sectors);
+	else
+		cmd->error = null_process_cmd(cmd, op, sector, nr_sectors);
 
 out:
 	nullb_complete_cmd(cmd);
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 673618d8222a..2e9add7d89a4 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -126,11 +126,16 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
 	struct blk_zone *zone = &dev->zones[zno];
+	blk_status_t ret;
+
+	trace_nullb_zone_op(cmd, zno, zone->cond);
+
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		return null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
 
 	switch (zone->cond) {
 	case BLK_ZONE_COND_FULL:
 		/* Cannot write to a full zone */
-		cmd->error = BLK_STS_IOERR;
 		return BLK_STS_IOERR;
 	case BLK_ZONE_COND_EMPTY:
 	case BLK_ZONE_COND_IMP_OPEN:
@@ -143,19 +148,18 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
 			zone->cond = BLK_ZONE_COND_IMP_OPEN;
 
+		ret = null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
+		if (ret != BLK_STS_OK)
+			return ret;
+
 		zone->wp += nr_sectors;
 		if (zone->wp == zone->start + zone->len)
 			zone->cond = BLK_ZONE_COND_FULL;
-		break;
-	case BLK_ZONE_COND_NOT_WP:
-		break;
+		return BLK_STS_OK;
 	default:
 		/* Invalid zone condition */
 		return BLK_STS_IOERR;
 	}
-
-	trace_nullb_zone_op(cmd, zno, zone->cond);
-	return BLK_STS_OK;
 }
 
 static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
@@ -216,8 +220,8 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 	return BLK_STS_OK;
 }
 
-blk_status_t null_handle_zoned(struct nullb_cmd *cmd, enum req_opf op,
-			       sector_t sector, sector_t nr_sectors)
+blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
+				    sector_t sector, sector_t nr_sectors)
 {
 	switch (op) {
 	case REQ_OP_WRITE:
@@ -229,6 +233,6 @@ blk_status_t null_handle_zoned(struct nullb_cmd *cmd, enum req_opf op,
 	case REQ_OP_ZONE_FINISH:
 		return null_zone_mgmt(cmd, op, sector);
 	default:
-		return BLK_STS_OK;
+		return null_process_cmd(cmd, op, sector, nr_sectors);
 	}
 }
-- 
2.25.3

