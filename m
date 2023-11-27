Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KWspGncb"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D39C1A5
	for <linux-block@vger.kernel.org>; Sun, 26 Nov 2023 23:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9GPxLlAAbAn5ecuFIoNe2gon1TvpEZ33fBcyS7Qycvg=; b=KWspGncbwp6oomqHelwwUWdCqW
	/MfYb4sKnAs/r/sNhGXnsRUHEglBdnIN05pqbkNOnN8LEGd4rhx3//RCW3wSY5g+p+l5abQznmQsm
	aZDO9T95K7FDTUVje3l6B0QFTzTc+YNaxiVLj6SONYTzVC6LZQjYcJ7QnNOIn6PNB+l/DniYIm6mR
	UJYlIDwR5pCdvl2A6NSRMJ3m5NnsXwuGpdPBW45tE++1q8+IR4x59TMwDBfoPeFwFed1Q8YLEFiLt
	rWtjyVqYVBHVa1+Ukwwz7yVOnTdk2iemmIjeLk9HZ/QS6Ahiyg5UcrNlcxYS6vnjGfrkFJUE20BwH
	argA0O2g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r7VuY-001hyK-05;
	Mon, 27 Nov 2023 07:20:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	dlemoal@kernel.org
Subject: [PATCH] block: move a few definitions out of CONFIG_BLK_DEV_ZONED
Date: Mon, 27 Nov 2023 08:20:02 +0100
Message-Id: <20231127072002.1332685-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Allow using a few symbols with IS_ENABLED instead of #idef by moving
the declarations out of #idef CONFIG_BLK_DEV_ZONED, and move
bdev_nr_zones into the remaining  #idef CONFIG_BLK_DEV_ZONED, #else
block below.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 51fa7ffdee83b4..17c0a7d0d319eb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -331,22 +331,13 @@ typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
 
 void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model);
 
-#ifdef CONFIG_BLK_DEV_ZONED
 #define BLK_ALL_ZONES  ((unsigned int)-1)
 int blkdev_report_zones(struct block_device *bdev, sector_t sector,
-			unsigned int nr_zones, report_zones_cb cb, void *data);
-unsigned int bdev_nr_zones(struct block_device *bdev);
-extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
-			    sector_t sectors, sector_t nr_sectors,
-			    gfp_t gfp_mask);
+		unsigned int nr_zones, report_zones_cb cb, void *data);
+int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
+		sector_t sectors, sector_t nr_sectors, gfp_t gfp_mask);
 int blk_revalidate_disk_zones(struct gendisk *disk,
-			      void (*update_driver_data)(struct gendisk *disk));
-#else /* CONFIG_BLK_DEV_ZONED */
-static inline unsigned int bdev_nr_zones(struct block_device *bdev)
-{
-	return 0;
-}
-#endif /* CONFIG_BLK_DEV_ZONED */
+		void (*update_driver_data)(struct gendisk *disk));
 
 /*
  * Independent access ranges: struct blk_independent_access_range describes
@@ -643,6 +634,8 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
 }
 
 #ifdef CONFIG_BLK_DEV_ZONED
+unsigned int bdev_nr_zones(struct block_device *bdev);
+
 static inline unsigned int disk_nr_zones(struct gendisk *disk)
 {
 	return blk_queue_is_zoned(disk->queue) ? disk->nr_zones : 0;
@@ -687,6 +680,11 @@ static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
 }
 
 #else /* CONFIG_BLK_DEV_ZONED */
+static inline unsigned int bdev_nr_zones(struct block_device *bdev)
+{
+	return 0;
+}
+
 static inline unsigned int disk_nr_zones(struct gendisk *disk)
 {
 	return 0;
-- 
2.39.2

