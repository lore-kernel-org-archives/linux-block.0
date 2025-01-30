Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FAF1B0415
	for <linux-block@vger.kernel.org>; Thu, 30 Jan 2025 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738225637; cv=none; b=QAD3eUc4cMfgT8VnLTkQLEMh71H+pd7BclA+CX2+cqBTje/hac44lC1TjOjicVU01RI+cdDt4L2sCp+e134BLkbBLdKHD4jd1uWLpNjkU7Cov/Fv7kx28s0kqbzUk2zjYp1yeN4BQG+iUYPKQvNjzTQgh0um2vxvglP12ff8B7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738225637; c=relaxed/simple;
	bh=13WItm/cmZtHL87Hk457nTb6ISavmMO8sjEE8fA7cgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANFMDIw7Wk4600b7PYpq3yAQxK1KzStfxqLi2PyuT0RTVd3KfDI1WsFsigClMP9Tn9FIhGPQkWsc82mzY0xDo2q3KYQ19IIsa+2FX7u4nVfF7z6j7bgvLdH0DEEflYL+iTFb0vqAgyKUF2xe30BGL2iNPlZAj6UE6B0Q0iW+hOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=p6Vwdk0p; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p6Vwdk0p"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738225635; x=1769761635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=13WItm/cmZtHL87Hk457nTb6ISavmMO8sjEE8fA7cgU=;
  b=p6Vwdk0pCYhbSpBHm2TwGIdVg3j1RzXj7Ge/ZYJ3oJUc5ch2Kby8nB5a
   riNCJRq6g2Vom2jjoqOR6UNboMHMpw0nMkoOKaJAK5/kdttm52bIeVMho
   +PfDaNo8fMmFGtPrLwTjyMfATK89xr/94Bk/2RSWNeUey81sS80RlMfvE
   MV588+5x+xa8+LYNfmoRPfL9dtshMwW1uUaYjpp7reujqG9XF9Vy5w9hl
   R/9OQpQ5cRvTaTieMdHcWt1zGqQR/X0nvli1Kw0XPDHMElNahA3LHFIGC
   pacTp80ZgINNC/d+sSCEfm0K9P3sb3jNOpa2gLxmkBBmAYbu0VPr1c/g3
   A==;
X-CSE-ConnectionGUID: +S/ytE9yQ0a0Y37bwNCOfw==
X-CSE-MsgGUID: +V5s6u2nQ3yxj9QaDeHInA==
X-IronPort-AV: E=Sophos;i="6.13,244,1732550400"; 
   d="scan'208";a="38377850"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2025 16:27:11 +0800
IronPort-SDR: 679b2a3e_E9oWve04MN2u3wD/rwFI2cp9DCc75lPCKG1kz6vyxoLWw9Z
 I0icI4sZrpPnYy8vt6h/7W1JEJmVyeKc93zf7JA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2025 23:29:03 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jan 2025 00:27:11 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v6 5/5] null_blk: do partial IO for bad blocks
Date: Thu, 30 Jan 2025 17:27:03 +0900
Message-ID: <20250130082703.1330857-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250130082703.1330857-1-shinichiro.kawasaki@wdc.com>
References: <20250130082703.1330857-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current null_blk implementation checks if any bad blocks exist in
the target blocks of each IO. If so, the IO fails and data is not
transferred for all of the IO target blocks. However, when real storage
devices have bad blocks, the devices may transfer data partially up to
the first bad blocks (e.g., SAS drives). Especially, when the IO is a
write operation, such partial IO leaves partially written data on the
device.

To simulate such partial IO using null_blk, introduce the new parameter
'badblocks_partial_io'. When this parameter is set,
null_handle_badblocks() returns the number of the sectors for the
partial IO as its third pointer argument. Pass the returned number of
sectors to the following calls to null_handle_memory_backend() in
null_process_cmd() and null_zone_write().

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c     | 40 ++++++++++++++++++++++++-------
 drivers/block/null_blk/null_blk.h |  4 ++--
 drivers/block/null_blk/zoned.c    |  9 ++++---
 3 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 802576698812..31d44cef6841 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -474,6 +474,7 @@ NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
 NULLB_DEVICE_ATTR(fua, bool, NULL);
 NULLB_DEVICE_ATTR(rotational, bool, NULL);
 NULLB_DEVICE_ATTR(badblocks_once, bool, NULL);
+NULLB_DEVICE_ATTR(badblocks_partial_io, bool, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
 {
@@ -595,6 +596,7 @@ CONFIGFS_ATTR_WO(nullb_device_, zone_offline);
 static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_badblocks,
 	&nullb_device_attr_badblocks_once,
+	&nullb_device_attr_badblocks_partial_io,
 	&nullb_device_attr_blocking,
 	&nullb_device_attr_blocksize,
 	&nullb_device_attr_cache_size,
@@ -1321,19 +1323,40 @@ static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
 	return sts;
 }
 
+/*
+ * Check if the command should fail for the badblocks. If so, return
+ * BLK_STS_IOERR and return number of partial I/O sectors to be written or read,
+ * which may be less than the requested number of sectors.
+ *
+ * @cmd:        The command to handle.
+ * @sector:     The start sector for I/O.
+ * @nr_sectors: Specifies number of sectors to write or read, and returns the
+ *              number of sectors to be written or read.
+ */
 blk_status_t null_handle_badblocks(struct nullb_cmd *cmd, sector_t sector,
-				   sector_t nr_sectors)
+				   unsigned int *nr_sectors)
 {
 	struct badblocks *bb = &cmd->nq->dev->badblocks;
+	struct nullb_device *dev = cmd->nq->dev;
+	unsigned int block_sectors = dev->blocksize >> SECTOR_SHIFT;
 	sector_t first_bad;
 	int bad_sectors;
+	unsigned int partial_io_sectors = 0;
 
-	if (!badblocks_check(bb, sector, nr_sectors, &first_bad, &bad_sectors))
+	if (!badblocks_check(bb, sector, *nr_sectors, &first_bad, &bad_sectors))
 		return BLK_STS_OK;
 
 	if (cmd->nq->dev->badblocks_once)
 		badblocks_clear(bb, first_bad, bad_sectors);
 
+	if (cmd->nq->dev->badblocks_partial_io) {
+		if (!IS_ALIGNED(first_bad, block_sectors))
+			first_bad = ALIGN_DOWN(first_bad, block_sectors);
+		if (sector < first_bad)
+			partial_io_sectors = first_bad - sector;
+	}
+	*nr_sectors = partial_io_sectors;
+
 	return BLK_STS_IOERR;
 }
 
@@ -1392,18 +1415,19 @@ blk_status_t null_process_cmd(struct nullb_cmd *cmd, enum req_op op,
 			      sector_t sector, unsigned int nr_sectors)
 {
 	struct nullb_device *dev = cmd->nq->dev;
+	blk_status_t badblocks_ret = BLK_STS_OK;
 	blk_status_t ret;
 
-	if (dev->badblocks.shift != -1) {
-		ret = null_handle_badblocks(cmd, sector, nr_sectors);
+	if (dev->badblocks.shift != -1)
+		badblocks_ret = null_handle_badblocks(cmd, sector, &nr_sectors);
+
+	if (dev->memory_backed && nr_sectors) {
+		ret = null_handle_memory_backed(cmd, op, sector, nr_sectors);
 		if (ret != BLK_STS_OK)
 			return ret;
 	}
 
-	if (dev->memory_backed)
-		return null_handle_memory_backed(cmd, op, sector, nr_sectors);
-
-	return BLK_STS_OK;
+	return badblocks_ret;
 }
 
 static void null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index ee60f3a88796..7bb6128dbaaf 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -64,6 +64,7 @@ struct nullb_device {
 	unsigned int curr_cache;
 	struct badblocks badblocks;
 	bool badblocks_once;
+	bool badblocks_partial_io;
 
 	unsigned int nr_zones;
 	unsigned int nr_zones_imp_open;
@@ -133,11 +134,10 @@ blk_status_t null_handle_discard(struct nullb_device *dev, sector_t sector,
 blk_status_t null_process_cmd(struct nullb_cmd *cmd, enum req_op op,
 			      sector_t sector, unsigned int nr_sectors);
 blk_status_t null_handle_badblocks(struct nullb_cmd *cmd, sector_t sector,
-				   sector_t nr_sectors);
+				   unsigned int *nr_sectors);
 blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req_op op,
 				       sector_t sector, sector_t nr_sectors);
 
-
 #ifdef CONFIG_BLK_DEV_ZONED
 int null_init_zoned_dev(struct nullb_device *dev, struct queue_limits *lim);
 int null_register_zoned_dev(struct nullb *nullb);
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 7677f6cf23f4..4e5728f45989 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -353,6 +353,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
 	struct nullb_zone *zone = &dev->zones[zno];
+	blk_status_t badblocks_ret = BLK_STS_OK;
 	blk_status_t ret;
 
 	trace_nullb_zone_op(cmd, zno, zone->cond);
@@ -413,9 +414,11 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	}
 
 	if (dev->badblocks.shift != -1) {
-		ret = null_handle_badblocks(cmd, sector, nr_sectors);
-		if (ret != BLK_STS_OK)
+		badblocks_ret = null_handle_badblocks(cmd, sector, &nr_sectors);
+		if (badblocks_ret != BLK_STS_OK && !nr_sectors) {
+			ret = badblocks_ret;
 			goto unlock_zone;
+		}
 	}
 
 	if (dev->memory_backed) {
@@ -438,7 +441,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		zone->cond = BLK_ZONE_COND_FULL;
 	}
 
-	ret = BLK_STS_OK;
+	ret = badblocks_ret;
 
 unlock_zone:
 	null_unlock_zone(dev, zone);
-- 
2.47.0

