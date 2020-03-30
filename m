Return-Path: <SRS0=FzxQ=5P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55140C2D0ED
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 04:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4EA20786
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 04:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aWBBaUKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgC3EBV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Mar 2020 00:01:21 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:56281 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgC3EBU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Mar 2020 00:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585540880; x=1617076880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=etl1chxNo6bUbZ+vxe9H7yFweT2qhxvJGhP0/O8f7LY=;
  b=aWBBaUKV/CaivObRWW8gPwtwctLOIcSDpPxcQMXIUfWFK5xN9Uz0oNdw
   rMPhfBHh06Sn8DiiP3t6VViybYXUR1CYGhdq5YX9mCZa0FLITjwRjxtMH
   RiPTXaxCaIDsVhJw/aJo67pW1L+Qay05ptf17QS8AL8bII+t08akjxUqD
   mK7+UagmZWT2pJ0Ojvnou9b5qT9YUdMEAX9EFKdIpOB4GPpWPCm6K153b
   sQOZBQVIhG0yG/1ert9tK0deHXzcqYz7PX/2VRgnJvRh/Q8sY//UoIEbS
   gDEpZVqCKPbDPUdwbSxvWWWExycIbYGFaGHQzeI9k6wGAAAR8n5mBRPO2
   Q==;
IronPort-SDR: cJmYWCwAkqqpRWFiefJ5VNR6AxJsioQgIBchTlVsrJJ+sS4oF9AKJhs2FWde4Ti+qZjcw/YCkj
 lKotZ/m00gxYSBy7VgkYmzeZSeKjpkuoF09S32k544dIQMZUYpTEuUqROeES2qjwRhB0oCWo1b
 TnifIKf3lBxBLdD3oZqwJqH9VcjEekFZqlb8ePwoTnh7ZFbZrEVQkhJ1bx4+x9GhiJwCEXgOCV
 YnzdR/CTn/3Yh8RF7yI4q2xe14hUySslSdCrhISQscZ4LKDgZB9NcJlJkRgFfzwFY0bMk4//CA
 rGs=
X-IronPort-AV: E=Sophos;i="5.72,322,1580745600"; 
   d="scan'208";a="242386363"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2020 12:01:20 +0800
IronPort-SDR: 3oY5e46clHGIpE73Nret/yRIgquePPFszD8YrZgk577G1HR9qeNA51v1juI84F8jeZ6wwC+49y
 K274rXXYbbgmxTdb142JPzyCNStP2FUpU23PsyPUwur+z0eWrgRv2BYy2mgfj8Pi7NzWxB9lgY
 vfF3QQ2Qd84k/jkoCJBrLNPMy3lqG36oeGJ+Vk5Tg7iDfwj2uJYEPxnFKQ0QQoB0pxzqUcW+r7
 ctidME6SJooBnOg3oqPDl8cZ/fM1EIPrWwyffqHwfRg0AfHFe+e4lh6aVNcRyKsHhsj05+Lntd
 WUu0AMmEoaYYndnKBWqGFua5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 20:52:16 -0700
IronPort-SDR: yCdf0VsXCsbO8H8w9pzAA2B0HAH90PkoNjtrtWEsxPP9UFuDzwI5p4MMiMz/oI2RHEVUzA04o5
 YnjLBh2Is1bFO64Yt1lDOhWvOEUD098ivt31puTyW5VaUUrjoOcHBxeJIE/FMK/luXUdYo32zJ
 WdVRWF1W1CQqW4dV7xvmmC0ImbWf995RNMBIHhmVyHayIKecjJ+zHTnnAZNBKsEyBt7IzECh+l
 6Z+2YvHt3KK6MT1EwgIHd3oYGH6+kkM9Bu0Wc8JScWLhsJOYOotBfNBAEChiOl9tFvYxRUnqIM
 D6Y=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2020 21:01:19 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/2] block: null_blk: Fix zoned command handling
Date:   Mon, 30 Mar 2020 13:01:16 +0900
Message-Id: <20200330040116.178731-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330040116.178731-1-damien.lemoal@wdc.com>
References: <20200330040116.178731-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For writes operations issued to a null_blk device with zoned mode
enabled, the state and write pointer position of the zone targeted by
the write command should be checked before badblocks and memory backing
is handled as the write may be first failed due to, for instance, a
sector position not aligned with the zone write pointer. This als
reflects more accuratly the behavior of a physical zoned device.

Furthermore, the write pointer position of the target zone should be
incremented only and only if no errors are reported by badblocks and
memory backing handling.

To fix this, introduce the small inline helper function
null_process_cmd() which execute null_handle_badblocks() and
null_handle_memory_backed() and use this function in null_zone_write()
to correctly handle write requests to zoned null devices depending on
the type and state of the write target zone. Also call this function
in null_handle_zoned() to process read requests to zoned null devices.
This new helper is called from null_handle_cmd() only for regular null
devices, resulting in no functional change for these.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk.h       | 23 +++++++++++++++++++++++
 drivers/block/null_blk_main.c  | 24 ++++++++++--------------
 drivers/block/null_blk_zoned.c | 16 ++++++++++------
 3 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 2874463f1d42..b2a0869aef47 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -85,6 +85,29 @@ struct nullb {
 	char disk_name[DISK_NAME_LEN];
 };
 
+blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
+				   sector_t sector, sector_t nr_sectors);
+blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req_opf op);
+
+static inline blk_status_t null_process_cmd(struct nullb_cmd *cmd,
+					    enum req_opf op, sector_t sector,
+					    unsigned int nr_sectors)
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
 #ifdef CONFIG_BLK_DEV_ZONED
 int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q);
 int null_register_zoned_dev(struct nullb *nullb);
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 60f09fac6404..36bfaf1e8dbd 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1214,9 +1214,8 @@ static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
 	return sts;
 }
 
-static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
-						 sector_t sector,
-						 sector_t nr_sectors)
+blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
+				   sector_t sector, sector_t nr_sectors)
 {
 	struct badblocks *bb = &cmd->nq->dev->badblocks;
 	sector_t first_bad;
@@ -1228,12 +1227,14 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
 	return BLK_STS_OK;
 }
 
-static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
-						     enum req_opf op)
+blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req_opf op)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	int err;
 
+	if (!dev->memory_backed)
+		return BLK_STS_OK;
+
 	if (dev->queue_mode == NULL_Q_BIO)
 		err = null_handle_bio(cmd);
 	else
@@ -1286,17 +1287,12 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 		goto out;
 	}
 
-	if (nullb->dev->badblocks.shift != -1) {
-		cmd->error = null_handle_badblocks(cmd, sector, nr_sectors);
-		if (cmd->error != BLK_STS_OK)
-			goto out;
+	if (dev->zoned) {
+		cmd->error = null_handle_zoned(cmd, op, sector, nr_sectors);
+		goto out;
 	}
 
-	if (dev->memory_backed)
-		cmd->error = null_handle_memory_backed(cmd, op);
-
-	if (!cmd->error && dev->zoned)
-		cmd->error = null_handle_zoned(cmd, op, sector, nr_sectors);
+	cmd->error = null_process_cmd(cmd, op, sector, nr_sectors);
 
 out:
 	nullb_complete_cmd(cmd);
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 8259f3212a28..c60b19432a2e 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -138,11 +138,14 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
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
@@ -155,17 +158,18 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
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
@@ -236,6 +240,6 @@ blk_status_t null_handle_zoned(struct nullb_cmd *cmd, enum req_opf op,
 	case REQ_OP_ZONE_FINISH:
 		return null_zone_mgmt(cmd, op, sector);
 	default:
-		return BLK_STS_OK;
+		return null_process_cmd(cmd, op, sector, nr_sectors);
 	}
 }
-- 
2.25.1

