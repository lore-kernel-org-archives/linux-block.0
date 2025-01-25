Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3DB1EE01C
	for <linux-block@vger.kernel.org>; Sat, 25 Jan 2025 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768557; cv=none; b=W6mBxyvrlQ09SPcEG9oD0ErFgzTsY+cBEB9IxnH63AhX1I/jfqvirfImGoLAfd2tvk1asUL8o5Bb1VHGbXnJTG1Mx3mKhRWTw56EKOb02ayf4Hc5BKVHDO/yrW/lgSue/szJD5Q/AjNEl5LwHUuS+YbPFKHWAzmlRhkUOfnWEq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768557; c=relaxed/simple;
	bh=1QFpEu855IlPwUN5hPDhMUG1oE9IAvShlL7oNmWUxpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhBju4pXOJh4VWskTpkpxZDRk11gVVyPQiN7lA7NyXD4wGqF/lY5sr3yxO3W4Exk4EVCnZ/wkrIpItM/FvPrfk+4KHWPAx8UBXt9mouQkAT4Mjmh1Q6iwRJfG5j4WLGmUrlmuEL1a1lRNz59AVy91ZNl0YT7KZ4QjpMFLQ2SDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mkkSKwbn; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mkkSKwbn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737768555; x=1769304555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1QFpEu855IlPwUN5hPDhMUG1oE9IAvShlL7oNmWUxpY=;
  b=mkkSKwbndnI85l0tOMQAhtv6psnfcLOohn05ns4Ansa2lWUu3UkE2lkJ
   bG82s9iqbkKry/HAfKHJDJ9qXpkIQrfYfBqFOtvEwAFyt73bc0lRo/Bpb
   9eMI5o/ywpyDXhb9LkhrRgdIQuwnnQscK58/ZOi9O30s18NHv2Oclgx6e
   z3XVBvGmIbCiM6c4Ct/pUyNTCJ1ak3X2FP3klEasjhSLfVSOFmzXx14I8
   s64C+/ZoTiI6ilyB6QKum0J0ue3c88+oZvO4lkPUB4xRIQG5380v1fulZ
   39aAwEdp9Jqt6Mfn6jO1zOd49E56baIa2VbbzgemlOmRpogZBaq1MN3gF
   A==;
X-CSE-ConnectionGUID: BX1FQoAaSnKYyZR8aIatwg==
X-CSE-MsgGUID: y5SBXSZOQT+IRywaeNXYww==
X-IronPort-AV: E=Sophos;i="6.13,232,1732550400"; 
   d="scan'208";a="37973941"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2025 09:29:15 +0800
IronPort-SDR: 679430d0_e2J5zYCH9AWwXy95323YGt09458rBN5kCsQXXK7hq6zfYrV
 KxUqCNoYxMD5hpHmdpxoMR5d6Rcwo6vP1e+cvvw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2025 16:31:13 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Jan 2025 17:29:14 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v5 5/5] null_blk: do partial IO for bad blocks
Date: Sat, 25 Jan 2025 10:29:08 +0900
Message-ID: <20250125012908.1259887-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250125012908.1259887-1-shinichiro.kawasaki@wdc.com>
References: <20250125012908.1259887-1-shinichiro.kawasaki@wdc.com>
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

