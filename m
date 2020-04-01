Return-Path: <SRS0=ADX+=5R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBDAC2D0F1
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 01:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BD920BED
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 01:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qu74vUzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbgDABHb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 21:07:31 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16250 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387872AbgDABHb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 21:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585703251; x=1617239251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LUGhOqnMs22ezlgqbFjTtx4/fh0ItgU0JRV3Kfac5hE=;
  b=qu74vUzFEBaKcYDL3/WBcYOgv431XmljHFh0IIU1fkCRQiwRyNAsPxFX
   6nIR0jfI/7Rngz2MpBWkcZKuNbbcbPijEjLkBwOs9H3rmJgCKYfPAIZVT
   Gxd1WnyZ/d9zi2wi09ExtcZYuCcQsSV9+vXQvIJtKI6DJvXgmM1f29Fk6
   uG3suqAv/iM9PTGltT1psN+vz4JQ6brzBXfLw3JZAaU5TVQ0AwLEH0pVC
   HxAObXHuYBN7PRJe1mcgxr7RE/RlOpI2vCBVWLEFy67iKiBVelJMq3huD
   87CyqJrBdRQd58fGDckSqdrAGzVB8crjqpeq3IUB6iWF2hwpnEJoeAnzj
   A==;
IronPort-SDR: 4t3sRB/3VlYl89F2pNY+mzMTMlAy2DAsBx8buDiiAKmuo/iHfbpTZarw7rlS0pKjLZu0qnWH3F
 WFM9b84amz8UtpUCQaCDWCoyYkBQ1H+WN+2nBtF8NPDqDk+KbSU8EjMlsXWXp+5DKr5YqwTXIZ
 0lMQJuYNBLQj5/AkI4fwo4Sxtqw0UzEDMdYUfKyfNtsGCrPDW7AZVQLk5qEWx2XJ/ywoKc5J9t
 ntIp9Be0eewVpBi2QGiOk/c7hWbljuwg6lpkifb89Ihm3IW779iEnkfG8+rrZ/ZG/b4orEq3Pg
 Nds=
X-IronPort-AV: E=Sophos;i="5.72,329,1580745600"; 
   d="scan'208";a="134531019"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2020 09:07:31 +0800
IronPort-SDR: SvLPpi8FpjktaVB7lRmLe8Z/HYMq6XQlO4eEv9haSSgOJrdh6a7p3FmB6TpHIyUp6Y16mhx4Y1
 CJhgtxN+0LVDmy9h6OQnuyYHAdNvKYoTPLZ2UnCZo/Pp+U2sW4VUVkKZf+kTopiEys5kTeU1rU
 7n/jf4er+k0utvaXpezn+K04UucupOF+goUSLed1dB3mKGILYVzVGtJu99PebHXNFTwRo2N/VV
 Qno3G3gYUianXaqoB1tyqbTrfJSVFQNIzFSlMWFH8O4Iguaeq1A22g71PQFZ4/ADdkGSy+W18P
 HzLYLMpjznFv6VrluSPbySpt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 17:58:24 -0700
IronPort-SDR: kttoFujAl06YCWjCYJnJU0z0IYCqzPQIvMLh/VFG+TiGpdyeBSE9w5Gu+YMQ0U9KD1/hwCRZZQ
 USpICieGL7M8IcwxmoT+u8e1ORWl59TtA1m4s9I8R0+3rPZ2eshYeLmAJyZEDJCvzFePa/vHua
 ProKwY4zWR4AMaeDr/5mwyCzBs9s9oh1rNQNR45hq3MQpTuYMnQ8V7Io7vsXsF2tYo1sXJiY/I
 sjgw6liGBjSkKpN7cuu+hBzUtPQiO6e0Vck3n7URtejJlxUfyVAlZbwDgFrfsnwthnbLvUJMs2
 YXg=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 31 Mar 2020 18:07:30 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/2] block: null_blk: Fix zoned command handling
Date:   Wed,  1 Apr 2020 10:07:27 +0900
Message-Id: <20200401010728.800937-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401010728.800937-1-damien.lemoal@wdc.com>
References: <20200401010728.800937-1-damien.lemoal@wdc.com>
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
---
 drivers/block/null_blk.h       | 15 +++++++++------
 drivers/block/null_blk_main.c  | 35 +++++++++++++++++++++++-----------
 drivers/block/null_blk_zoned.c | 20 +++++++++++--------
 3 files changed, 45 insertions(+), 25 deletions(-)

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
index e9d66cc0d6b9..1d8141dfba6e 100644
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
index ed34785dd64b..3a50897f3432 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -121,11 +121,14 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
 	struct blk_zone *zone = &dev->zones[zno];
+	blk_status_t ret;
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
@@ -138,17 +141,18 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
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
-	return BLK_STS_OK;
 }
 
 static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
@@ -206,8 +210,8 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 	return BLK_STS_OK;
 }
 
-blk_status_t null_handle_zoned(struct nullb_cmd *cmd, enum req_opf op,
-			       sector_t sector, sector_t nr_sectors)
+blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
+				    sector_t sector, sector_t nr_sectors)
 {
 	switch (op) {
 	case REQ_OP_WRITE:
@@ -219,6 +223,6 @@ blk_status_t null_handle_zoned(struct nullb_cmd *cmd, enum req_opf op,
 	case REQ_OP_ZONE_FINISH:
 		return null_zone_mgmt(cmd, op, sector);
 	default:
-		return BLK_STS_OK;
+		return null_process_cmd(cmd, op, sector, nr_sectors);
 	}
 }
-- 
2.25.1

