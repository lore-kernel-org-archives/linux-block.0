Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FA03B1AC
	for <linux-block@vger.kernel.org>; Fri,  1 Mar 2024 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321204; cv=none; b=TF9GyppODZlcdyYfK5z/RjQwsxsiNRWgP6usK2fNwwtON7CMvm0cS8NasPJuCWkjF5kKrlhzwyWrRzLJnL5oNyxIhajHuR1e8/Q5WaBhRhb6JrityzsNiO/i6elD+lKZYJ6fD09S1wOo44LuF4CdBVzgUl5e3M1cj7BoDOUN2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321204; c=relaxed/simple;
	bh=oGGwxmwRvIoDbvO7OkowjDueUy+e3pw4/hsWEadHa1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucd1Nd3O142hrf3SssrBE5d304dPYH3GW6jEUIQhHkiZjZmecv92uhJXukTPb1/3fVu12b2W52USKmc5VQgL7oqVLRHG1jFqx3R85Be9Mj2BI5A24Qy0It2vW5LxYVn4aZH54xJIDd69+1oDly1xeHjyvfJkso+pjFOOk7s/iWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQQ+f/5J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQQ+f/5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4547C433C7;
	Fri,  1 Mar 2024 19:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709321203;
	bh=oGGwxmwRvIoDbvO7OkowjDueUy+e3pw4/hsWEadHa1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQQ+f/5JNgMudM7NM8T8nSHHgg/FzZt1R+Pfwu4ZZxHlfNXSbrtWler/D5VUPd1Ye
	 kYouujXDQwkDDM0tGN2S4IjVvTQhHdFqqJjwhPQS01eOAnKJ6x9dDvygv6CMVgqiGa
	 hLeM1HiWbMF83UpgJUt9HoNv8eBSQGeghIZ4amM+d8zfb9rn5PuAKW6yVRKcAr6jAt
	 F8TVLgPHA24czgquQPumszDxrOuaIelm6HLjLl/SxkTI+XCCvGbfDeankhQIdDSTIG
	 1SNjm8MRlZvAwfcMHQbYtNCcU+e190zgQCdzPPgznAYykiNKYl6rEudIwQQumH5OW7
	 Y1seAd9M2Keew==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] block: Rename disk_set_zoned()
Date: Sat,  2 Mar 2024 04:26:38 +0900
Message-ID: <20240301192639.410183-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301192639.410183-1-dlemoal@kernel.org>
References: <20240301192639.410183-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The disk_set_zoned() function operates on the zoned request queue limit
of a block device and does not change anything to the gendisk of the
device. To reflect this behavior and to be consistent with other request
queue limit setting functions, rename disk_set_zoned() to
blk_queue_zoned().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-settings.c    | 10 ++++------
 drivers/nvme/host/zns.c |  2 +-
 drivers/scsi/sd.c       |  2 +-
 include/linux/blkdev.h  |  4 ++--
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 13865a9f8972..a5102b1cd006 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -1108,13 +1108,11 @@ bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
 EXPORT_SYMBOL_GPL(blk_queue_can_use_dma_map_merging);
 
 /**
- * disk_set_zoned - inidicate a zoned device
- * @disk:	gendisk to configure
+ * blk_queue_zoned - indicate a zoned device
+ * @q:		the request queue for the device
  */
-void disk_set_zoned(struct gendisk *disk)
+void blk_queue_zoned(struct request_queue *q)
 {
-	struct request_queue *q = disk->queue;
-
 	WARN_ON_ONCE(!IS_ENABLED(CONFIG_BLK_DEV_ZONED));
 
 	/*
@@ -1124,7 +1122,7 @@ void disk_set_zoned(struct gendisk *disk)
 	q->limits.zoned = true;
 	blk_queue_zone_write_granularity(q, queue_logical_block_size(q));
 }
-EXPORT_SYMBOL_GPL(disk_set_zoned);
+EXPORT_SYMBOL_GPL(blk_queue_zoned);
 
 int bdev_alignment_offset(struct block_device *bdev)
 {
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 499bbb0eee8d..96d9206efc5e 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -109,7 +109,7 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 		goto free_data;
 	}
 
-	disk_set_zoned(ns->disk);
+	blk_queue_zoned(q);
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	disk_set_max_open_zones(ns->disk, le32_to_cpu(id->mor) + 1);
 	disk_set_max_active_zones(ns->disk, le32_to_cpu(id->mar) + 1);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 0833b3e6aa6e..477451a36038 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3141,7 +3141,7 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 		/*
 		 * Host-managed.
 		 */
-		disk_set_zoned(sdkp->disk);
+		blk_queue_zoned(q);
 
 		/*
 		 * Per ZBC and ZAC specifications, writes in sequential write
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 285e82723d64..1081c2d9e6bd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -321,8 +321,6 @@ struct queue_limits {
 typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
 			       void *data);
 
-void disk_set_zoned(struct gendisk *disk);
-
 #define BLK_ALL_ZONES  ((unsigned int)-1)
 int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data);
@@ -610,6 +608,8 @@ static inline enum rpm_status queue_rpm_status(struct request_queue *q)
 }
 #endif
 
+void blk_queue_zoned(struct request_queue *q);
+
 static inline bool blk_queue_is_zoned(struct request_queue *q)
 {
 	return IS_ENABLED(CONFIG_BLK_DEV_ZONED) && q->limits.zoned;
-- 
2.44.0

