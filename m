Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9C126F2A
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 03:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718939709; cv=none; b=kNZdftL/SgiowZ40A42UmBOiucrQtM4EvnIZeD9sMJA6GHoep3PpM4BP4ixUJwBozT8zNWwpgEJPXEURPJEnXg8Ak06QQUe+0IVRBd7xgckG4cP/K9NejcC1BIgWHzZly6X+7LzcifdkMUo4uimzKLCY+VSeUw+waizcHVQEtAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718939709; c=relaxed/simple;
	bh=hyeHUQzKxHu0Z0rCElV+wnnqHZEk3blNqU8GFCUKn4Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a38NVEocz/hLwrhH8YSOWn/Ph85oJ+MlEXqFmRcIPzeyyPw4/HSz9q7gHhwypsGBIpMBAU8y8b+HWRXO5fymmrXaLWjPTAKGfPMxiuOu441px3dSJfpx8LzZa5IuzjTEJd03e34xqjc+GDj2SyW09NnM5u52mDUi2CrOQ28sadk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7QiM+YR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7QiM+YR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C931C4AF07;
	Fri, 21 Jun 2024 03:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718939708;
	bh=hyeHUQzKxHu0Z0rCElV+wnnqHZEk3blNqU8GFCUKn4Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f7QiM+YRET9QTSXVotAYVQMibgOt/fSxZmcpccT+dK/N2rY7v7lXUcb8MGaXqDftT
	 DNCMamp2L543v3iX6eooW532U7orLRnMlw8aaMcD+YpIlEKEgGV7+PSzaQSZGaRpX7
	 L/fXdsSkBwP3arimVwAtOlZ/TBp8Wxy8mrdSrOLw3f5UJcj0gddWD+p3wifOCX7N55
	 us14dncwmDZUYwue4XTutmrxZQ51vqY+SfBMKxwbEUd8sQcLEVZbTNkOZFcs8/VGaS
	 3RE6/k2W3NsEJL1CC4RnrmzjZNzihXgbyaj0Hj2nF2StIm0ea0JJmO2ZUl3EW9v9ud
	 MlAi1ZZqnxORA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: Define bdev_nr_zones() as an inline function
Date: Fri, 21 Jun 2024 12:15:05 +0900
Message-ID: <20240621031506.759397-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621031506.759397-1-dlemoal@kernel.org>
References: <20240621031506.759397-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need for bdev_nr_zones() to be an exported function
calculating the number of zones of a block device. Instead, given that
all callers use this helper with a fully initialized block device that
has a gendisk, we can redefine this function as an inline helper in
blkdev.h.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c      | 18 ------------------
 include/linux/blkdev.h |  6 +++++-
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 137842dbb59a..07831fb67201 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -115,24 +115,6 @@ const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
 }
 EXPORT_SYMBOL_GPL(blk_zone_cond_str);
 
-/**
- * bdev_nr_zones - Get number of zones
- * @bdev:	Target device
- *
- * Return the total number of zones of a zoned block device.  For a block
- * device without zone capabilities, the number of zones is always 0.
- */
-unsigned int bdev_nr_zones(struct block_device *bdev)
-{
-	sector_t zone_sectors = bdev_zone_sectors(bdev);
-
-	if (!bdev_is_zoned(bdev))
-		return 0;
-	return (bdev_nr_sectors(bdev) + zone_sectors - 1) >>
-		ilog2(zone_sectors);
-}
-EXPORT_SYMBOL_GPL(bdev_nr_zones);
-
 /**
  * blkdev_report_zones - Get zones information
  * @bdev:	Target block device
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2800231046a9..1078a7d51295 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -673,7 +673,6 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
 }
 
 #ifdef CONFIG_BLK_DEV_ZONED
-unsigned int bdev_nr_zones(struct block_device *bdev);
 
 static inline unsigned int disk_nr_zones(struct gendisk *disk)
 {
@@ -687,6 +686,11 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 	return sector >> ilog2(disk->queue->limits.chunk_sectors);
 }
 
+static inline unsigned int bdev_nr_zones(struct block_device *bdev)
+{
+	return disk_nr_zones(bdev->bd_disk);
+}
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	return bdev->bd_disk->queue->limits.max_open_zones;
-- 
2.45.2

