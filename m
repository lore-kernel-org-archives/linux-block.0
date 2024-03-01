Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E523B289
	for <linux-block@vger.kernel.org>; Fri,  1 Mar 2024 19:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321204; cv=none; b=XVFs0dSiIsNNc0W8Rsx88ErEpiO7xrXD7H+Jl888HHaCUGEI2WrkWsh7cCT4UMRL+cXmyI66F6pSM6S5F3/MtPf/doummmfCk5TYemHE17FFpmBnNaZrj/iUmU9MCjfYf/APEDDxKudwLMSCihM7idOhfkZF2adgjjDJJq/WmWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321204; c=relaxed/simple;
	bh=yd7PVRwiT59lOhC3Ybwp5+GGCrFtxBYtZuy/coSWh3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWaMMwP2VFN23e6kCLmuj2CUZMa2UJUFIwh+qFe2vjLeOI99omYNfhgRz4LGb/WAyJtPCoHMQEctKrVbBSKi9+aWljBkXD9dbeKa4IYDIPPhtZY+0fwO9IsJbU22gNkd2ZS34viAF4uR+iMqNeOG3O9zOGxzVd3urt+7wJil/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eimr+HQJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eimr+HQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F2AC433F1;
	Fri,  1 Mar 2024 19:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709321204;
	bh=yd7PVRwiT59lOhC3Ybwp5+GGCrFtxBYtZuy/coSWh3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eimr+HQJTgAU7bfr+G2+7q0wYPQvv59L9U1GLR8T8InTfCaLygieujqYK+TLgDQal
	 Tn4my1h1dGk19zzaXlsaxt2pk5ZEnWAzTkSIy0hSXFi3Vun+/ffp9KVnKCGfI2s64E
	 SnIum6AEEaZhiv1YXXv7aVtWvRV6W/XKqNzwCEhR2eZo2xkcH0p+qXoolCFc5U0Spj
	 KEteZWo+srfMngLKIDLKPEqYI71s8QfRpug6UbDaXfPJTEoueHeOmyOzWuQ+iY7B3d
	 ww07wabbzJP0J6kGPta75jnY3UlO5Z/wcGiCI4SEYEjGEpXSEgROZeI8fgBMetZtbX
	 PLEQTnJ08zPaw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] block: Rename disk_set_max_open/active_zones()
Date: Sat,  2 Mar 2024 04:26:39 +0900
Message-ID: <20240301192639.410183-4-dlemoal@kernel.org>
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

Given that the max_open_zones and max_active_zones attributes of a zoned
block device have been moved to the device request queue limit, rename
the functions disk_set_max_open_zones() and disk_set_max_active_zones()
to blk_queue_max_open_zones() and blk_queue_max_active_zones() to be
consistent with other request queue limit setting functions.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/host/zns.c |  4 ++--
 drivers/scsi/sd_zbc.c   |  6 +++---
 include/linux/blkdev.h  | 26 ++++++++++++++------------
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 96d9206efc5e..7f86b169c373 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -111,8 +111,8 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 
 	blk_queue_zoned(q);
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
-	disk_set_max_open_zones(ns->disk, le32_to_cpu(id->mor) + 1);
-	disk_set_max_active_zones(ns->disk, le32_to_cpu(id->mar) + 1);
+	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
+	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
 free_data:
 	kfree(id);
 	return status;
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 26af5ab7d7c1..2971c3269296 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -943,10 +943,10 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE])
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
 	if (sdkp->zones_max_open == U32_MAX)
-		disk_set_max_open_zones(disk, 0);
+		blk_queue_max_open_zones(q, 0);
 	else
-		disk_set_max_open_zones(disk, sdkp->zones_max_open);
-	disk_set_max_active_zones(disk, 0);
+		blk_queue_max_open_zones(q, sdkp->zones_max_open);
+	blk_queue_max_active_zones(q, 0);
 	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
 
 	sdkp->early_zone_info.nr_zones = nr_zones;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1081c2d9e6bd..55a68983fae8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -615,6 +615,20 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
 	return IS_ENABLED(CONFIG_BLK_DEV_ZONED) && q->limits.zoned;
 }
 
+static inline void blk_queue_max_open_zones(struct request_queue *q,
+					    unsigned int max_open_zones)
+{
+	WARN_ON_ONCE(!IS_ENABLED(CONFIG_BLK_DEV_ZONED));
+	q->limits.max_open_zones = max_open_zones;
+}
+
+static inline void blk_queue_max_active_zones(struct request_queue *q,
+					      unsigned int max_active_zones)
+{
+	WARN_ON_ONCE(!IS_ENABLED(CONFIG_BLK_DEV_ZONED));
+	q->limits.max_active_zones = max_active_zones;
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 unsigned int bdev_nr_zones(struct block_device *bdev);
 
@@ -639,18 +653,6 @@ static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
 	return !test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
 }
 
-static inline void disk_set_max_open_zones(struct gendisk *disk,
-		unsigned int max_open_zones)
-{
-	disk->queue->limits.max_open_zones = max_open_zones;
-}
-
-static inline void disk_set_max_active_zones(struct gendisk *disk,
-		unsigned int max_active_zones)
-{
-	disk->queue->limits.max_active_zones = max_active_zones;
-}
-
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	return bdev->bd_disk->queue->limits.max_open_zones;
-- 
2.44.0

