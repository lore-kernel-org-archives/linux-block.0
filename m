Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF3922F170
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 04:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736915359; cv=none; b=ErtCT8R8ZpNIQDsi4w6XTVFLhnrYjUu7lomvvijSYtaapZNMd/N2kQgVw+b73qLxT4buHjipwkfo7NF89XqGO4+pi9VbLwu6ZDbgxOstL1KM+7MaUr7fuaDmhSLShlvA2D6fp0X1wU1s4Bhtu+e4GBA9BNV5oCY5CMs5oMiuuvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736915359; c=relaxed/simple;
	bh=mxB2cG4m3EKJMNrpLvuXaRaJ4gdaqOkpIm9mnVn6aHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqfKJBiUtjMKD/GZd1N05V9GOytfwJXnhUAMxK3A8iMIM7ACW0TZ3g3cj3e+KjNLvwndiExFw00jvKY8RQtpeaHmtcfyPEzjb5ijaj1qmNIXQ6H9NeYzErIhtIJfFIvQ3b6NyNy2zc+3VRPw6e3j7V7ASv/LAp6iJ3u06yS8tkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=U9M1qncy; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U9M1qncy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736915358; x=1768451358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mxB2cG4m3EKJMNrpLvuXaRaJ4gdaqOkpIm9mnVn6aHE=;
  b=U9M1qncyLpv50Egc3geZotUAQczQRdoumIMchE9b5rXpND6xiAA02Kvu
   VCOT05jaVzkgUEcqZ3HPUuiQ62xOeR5zT1Y3mXIeMrpbe+AMnzWJH0e31
   8RFEZs6debsQDDF+Xd2ny9N5iwjG07nRn06bB5MMNKpRAQ/bCCtm8jldS
   xvK6K+/BVBUALiBPREhX0T9nKi4IaotgC/R+c+kKAX1oGCGH/CuP8o23w
   ayvuPkUJksmt6KHtr+bcDgvFyRRcOkT8k9gC6EpV7oG99qARfHy5z7bOE
   DHsPR5OYc5V10yDV74wRH+/j1+3XynD+n1jxbUkkweENvK25ti9ax9y3G
   A==;
X-CSE-ConnectionGUID: xKf1HnblTHq3aBd0Y6CGAQ==
X-CSE-MsgGUID: 564nkL1sRD+AIqwhcXZgtw==
X-IronPort-AV: E=Sophos;i="6.12,316,1728921600"; 
   d="scan'208";a="35958019"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2025 12:29:18 +0800
IronPort-SDR: 67872ac5_tiGj0ySPPW2s29rC6eULsypsgg/U0rLQdHUk8O2umPqNpq4
 3QFNhFbnS1kSDEkGCJLEtQe2jizITkGt8RuSilQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jan 2025 19:25:58 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Jan 2025 20:29:16 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH for-next v3 5/5] null_blk: do partial IO for bad blocks
Date: Wed, 15 Jan 2025 13:29:10 +0900
Message-ID: <20250115042910.1149966-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250115042910.1149966-1-shinichiro.kawasaki@wdc.com>
References: <20250115042910.1149966-1-shinichiro.kawasaki@wdc.com>
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

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/null_blk/main.c     | 39 ++++++++++++++++++++++++-------
 drivers/block/null_blk/null_blk.h |  4 ++--
 drivers/block/null_blk/zoned.c    |  9 ++++---
 3 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 71c86775354e..d9332b013844 100644
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
@@ -1320,19 +1322,39 @@ static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
 	return sts;
 }
 
+/*
+ * Check if the command should fail for the badblocks. If so, return
+ * BLK_STS_IOERR and return number of partial I/O sectors.
+ *
+ * @cmd:        The command to handle.
+ * @sector:     The start sector for I/O.
+ * @nr_sectors: The caller specifies number of sectors to write or read.
+ *              Returns number of sectors to be written or read for partial I/O.
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
 
@@ -1391,18 +1413,19 @@ blk_status_t null_process_cmd(struct nullb_cmd *cmd, enum req_op op,
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
index 09dae8d018aa..c9f984445005 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -353,6 +353,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
 	struct nullb_zone *zone = &dev->zones[zno];
+	blk_status_t badblocks_ret = BLK_STS_OK;
 	blk_status_t ret;
 
 	trace_nullb_zone_op(cmd, zno, zone->cond);
@@ -390,9 +391,11 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
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
 
 	if (zone->cond == BLK_ZONE_COND_CLOSED ||
@@ -438,7 +441,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		zone->cond = BLK_ZONE_COND_FULL;
 	}
 
-	ret = BLK_STS_OK;
+	ret = badblocks_ret;
 
 unlock_zone:
 	null_unlock_zone(dev, zone);
-- 
2.47.0

