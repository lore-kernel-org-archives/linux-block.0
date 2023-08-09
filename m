Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EB2C04A6A
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 14:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjHIOgK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Aug 2023 10:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjHIOgJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 10:36:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26991FCC
        for <linux-block@vger.kernel.org>; Wed,  9 Aug 2023 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LWilCwC5NN0/S9TGkOMOMQBGXwt9fD5Q+xEJeo4Vvf4=; b=fQ/+1FHX7WB4FdFKp5Roxnfjly
        AweIsYKpA4sTMlgtn+PWToLIw+kJz5Glj6NeSUkxnjtjC9rP/CWk+XyHqRsq6M6pt++V+kNCY27gU
        V19QjXnQXjdfmued9Cx8krVWvh8go4B+5ggEn61xi8Kt3UrDJkdl7pX7sGfJnD/lyvzB0rPgDAfO+
        3tXc3WHELFGXJi10cb9s1Ii9ijpVXIrSwuMoswj7Aeo+S4mrpWuMoZbpdrzcu4XtWTdFeXS45I/hd
        klDnqFob49vP3ezVwFmHshlZ7JCG4SSv05e1FrXvFLxYIGH5l2s8267n/QKQQaAvKeudHViucDnYn
        XfGujfDg==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTkIB-005BRO-2e;
        Wed, 09 Aug 2023 14:36:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: pass a gendisk to the queue_sysfs_entry handlers
Date:   Wed,  9 Aug 2023 07:36:07 -0700
Message-Id: <20230809143607.1247798-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Despite the name in sysfs, the "queue" sysfs entries are associated
with the gendisk a that is the only block object that registers with
sysfs.  Pass the gendisk to the handlers so that we can propagate it
further in follow on patches.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c    | 288 ++++++++++++++++++++++---------------------
 block/blk-throttle.c |  15 +--
 block/blk.h          |   6 +-
 block/elevator.c     |  16 +--
 block/elevator.h     |   4 +-
 5 files changed, 167 insertions(+), 162 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 63e4812623361d..503bb2cd508656 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -22,8 +22,8 @@
 
 struct queue_sysfs_entry {
 	struct attribute attr;
-	ssize_t (*show)(struct request_queue *, char *);
-	ssize_t (*store)(struct request_queue *, const char *, size_t);
+	ssize_t (*show)(struct gendisk *, char *);
+	ssize_t (*store)(struct gendisk *, const char *, size_t);
 };
 
 static ssize_t
@@ -47,18 +47,18 @@ queue_var_store(unsigned long *var, const char *page, size_t count)
 	return count;
 }
 
-static ssize_t queue_requests_show(struct request_queue *q, char *page)
+static ssize_t queue_requests_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(q->nr_requests, page);
+	return queue_var_show(disk->queue->nr_requests, page);
 }
 
 static ssize_t
-queue_requests_store(struct request_queue *q, const char *page, size_t count)
+queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 {
 	unsigned long nr;
 	int ret, err;
 
-	if (!queue_is_mq(q))
+	if (!queue_is_mq(disk->queue))
 		return -EINVAL;
 
 	ret = queue_var_store(&nr, page, count);
@@ -68,167 +68,169 @@ queue_requests_store(struct request_queue *q, const char *page, size_t count)
 	if (nr < BLKDEV_MIN_RQ)
 		nr = BLKDEV_MIN_RQ;
 
-	err = blk_mq_update_nr_requests(q, nr);
+	err = blk_mq_update_nr_requests(disk->queue, nr);
 	if (err)
 		return err;
 
 	return ret;
 }
 
-static ssize_t queue_ra_show(struct request_queue *q, char *page)
+static ssize_t queue_ra_show(struct gendisk *disk, char *page)
 {
-	unsigned long ra_kb;
+	unsigned long ra_kb = disk->bdi->ra_pages << (PAGE_SHIFT - 10);
 
-	if (!q->disk)
-		return -EINVAL;
-	ra_kb = q->disk->bdi->ra_pages << (PAGE_SHIFT - 10);
 	return queue_var_show(ra_kb, page);
 }
 
 static ssize_t
-queue_ra_store(struct request_queue *q, const char *page, size_t count)
+queue_ra_store(struct gendisk *disk, const char *page, size_t count)
 {
 	unsigned long ra_kb;
 	ssize_t ret;
 
-	if (!q->disk)
-		return -EINVAL;
 	ret = queue_var_store(&ra_kb, page, count);
 	if (ret < 0)
 		return ret;
-	q->disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
+	disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
 	return ret;
 }
 
-static ssize_t queue_max_sectors_show(struct request_queue *q, char *page)
+static ssize_t queue_max_sectors_show(struct gendisk *disk, char *page)
 {
-	int max_sectors_kb = queue_max_sectors(q) >> 1;
+	int max_sectors_kb = queue_max_sectors(disk->queue) >> 1;
 
 	return queue_var_show(max_sectors_kb, page);
 }
 
-static ssize_t queue_max_segments_show(struct request_queue *q, char *page)
+static ssize_t queue_max_segments_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(queue_max_segments(q), page);
+	return queue_var_show(queue_max_segments(disk->queue), page);
 }
 
-static ssize_t queue_max_discard_segments_show(struct request_queue *q,
+static ssize_t queue_max_discard_segments_show(struct gendisk *disk,
 		char *page)
 {
-	return queue_var_show(queue_max_discard_segments(q), page);
+	return queue_var_show(queue_max_discard_segments(disk->queue), page);
 }
 
-static ssize_t queue_max_integrity_segments_show(struct request_queue *q, char *page)
+static ssize_t queue_max_integrity_segments_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(q->limits.max_integrity_segments, page);
+	return queue_var_show(disk->queue->limits.max_integrity_segments, page);
 }
 
-static ssize_t queue_max_segment_size_show(struct request_queue *q, char *page)
+static ssize_t queue_max_segment_size_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(queue_max_segment_size(q), page);
+	return queue_var_show(queue_max_segment_size(disk->queue), page);
 }
 
-static ssize_t queue_logical_block_size_show(struct request_queue *q, char *page)
+static ssize_t queue_logical_block_size_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(queue_logical_block_size(q), page);
+	return queue_var_show(queue_logical_block_size(disk->queue), page);
 }
 
-static ssize_t queue_physical_block_size_show(struct request_queue *q, char *page)
+static ssize_t queue_physical_block_size_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(queue_physical_block_size(q), page);
+	return queue_var_show(queue_physical_block_size(disk->queue), page);
 }
 
-static ssize_t queue_chunk_sectors_show(struct request_queue *q, char *page)
+static ssize_t queue_chunk_sectors_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(q->limits.chunk_sectors, page);
+	return queue_var_show(disk->queue->limits.chunk_sectors, page);
 }
 
-static ssize_t queue_io_min_show(struct request_queue *q, char *page)
+static ssize_t queue_io_min_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(queue_io_min(q), page);
+	return queue_var_show(queue_io_min(disk->queue), page);
 }
 
-static ssize_t queue_io_opt_show(struct request_queue *q, char *page)
+static ssize_t queue_io_opt_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(queue_io_opt(q), page);
+	return queue_var_show(queue_io_opt(disk->queue), page);
 }
 
-static ssize_t queue_discard_granularity_show(struct request_queue *q, char *page)
+static ssize_t queue_discard_granularity_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(q->limits.discard_granularity, page);
+	return queue_var_show(disk->queue->limits.discard_granularity, page);
 }
 
-static ssize_t queue_discard_max_hw_show(struct request_queue *q, char *page)
+static ssize_t queue_discard_max_hw_show(struct gendisk *disk, char *page)
 {
+	struct queue_limits *lim = &disk->queue->limits;
 
 	return sprintf(page, "%llu\n",
-		(unsigned long long)q->limits.max_hw_discard_sectors << 9);
+		(unsigned long long)lim->max_hw_discard_sectors << 9);
 }
 
-static ssize_t queue_discard_max_show(struct request_queue *q, char *page)
+static ssize_t queue_discard_max_show(struct gendisk *disk, char *page)
 {
+	struct queue_limits *lim = &disk->queue->limits;
+
 	return sprintf(page, "%llu\n",
-		       (unsigned long long)q->limits.max_discard_sectors << 9);
+		       (unsigned long long)lim->max_discard_sectors << 9);
 }
 
-static ssize_t queue_discard_max_store(struct request_queue *q,
+static ssize_t queue_discard_max_store(struct gendisk *disk,
 				       const char *page, size_t count)
 {
 	unsigned long max_discard;
 	ssize_t ret = queue_var_store(&max_discard, page, count);
+	struct queue_limits *lim = &disk->queue->limits;
 
 	if (ret < 0)
 		return ret;
 
-	if (max_discard & (q->limits.discard_granularity - 1))
+	if (max_discard & (lim->discard_granularity - 1))
 		return -EINVAL;
 
 	max_discard >>= 9;
 	if (max_discard > UINT_MAX)
 		return -EINVAL;
 
-	if (max_discard > q->limits.max_hw_discard_sectors)
-		max_discard = q->limits.max_hw_discard_sectors;
-
-	q->limits.max_discard_sectors = max_discard;
+	if (max_discard > lim->max_hw_discard_sectors)
+		max_discard = lim->max_hw_discard_sectors;
+	lim->max_discard_sectors = max_discard;
 	return ret;
 }
 
-static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *page)
+static ssize_t queue_discard_zeroes_data_show(struct gendisk *disk, char *page)
 {
 	return queue_var_show(0, page);
 }
 
-static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
+static ssize_t queue_write_same_max_show(struct gendisk *disk, char *page)
 {
 	return queue_var_show(0, page);
 }
 
-static ssize_t queue_write_zeroes_max_show(struct request_queue *q, char *page)
+static ssize_t queue_write_zeroes_max_show(struct gendisk *disk, char *page)
 {
+	struct queue_limits *lim = &disk->queue->limits;
+
 	return sprintf(page, "%llu\n",
-		(unsigned long long)q->limits.max_write_zeroes_sectors << 9);
+		(unsigned long long)lim->max_write_zeroes_sectors << 9);
 }
 
-static ssize_t queue_zone_write_granularity_show(struct request_queue *q,
+static ssize_t queue_zone_write_granularity_show(struct gendisk *disk,
 						 char *page)
 {
-	return queue_var_show(queue_zone_write_granularity(q), page);
+	return queue_var_show(queue_zone_write_granularity(disk->queue), page);
 }
 
-static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
+static ssize_t queue_zone_append_max_show(struct gendisk *disk, char *page)
 {
-	unsigned long long max_sectors = q->limits.max_zone_append_sectors;
+	unsigned long long max_sectors =
+		disk->queue->limits.max_zone_append_sectors;
 
 	return sprintf(page, "%llu\n", max_sectors << SECTOR_SHIFT);
 }
 
 static ssize_t
-queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
+queue_max_sectors_store(struct gendisk *disk, const char *page, size_t count)
 {
+	struct queue_limits *lim = &disk->queue->limits;
 	unsigned long var;
 	unsigned int max_sectors_kb,
-		max_hw_sectors_kb = queue_max_hw_sectors(q) >> 1,
+		max_hw_sectors_kb = queue_max_hw_sectors(disk->queue) >> 1,
 			page_kb = 1 << (PAGE_SHIFT - 10);
 	ssize_t ret = queue_var_store(&var, page, count);
 
@@ -237,54 +239,53 @@ queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 
 	max_sectors_kb = (unsigned int)var;
 	max_hw_sectors_kb = min_not_zero(max_hw_sectors_kb,
-					 q->limits.max_dev_sectors >> 1);
+					 lim->max_dev_sectors >> 1);
 	if (max_sectors_kb == 0) {
-		q->limits.max_user_sectors = 0;
+		lim->max_user_sectors = 0;
 		max_sectors_kb = min(max_hw_sectors_kb,
 				     BLK_DEF_MAX_SECTORS >> 1);
 	} else {
 		if (max_sectors_kb > max_hw_sectors_kb ||
 		    max_sectors_kb < page_kb)
 			return -EINVAL;
-		q->limits.max_user_sectors = max_sectors_kb << 1;
+		lim->max_user_sectors = max_sectors_kb << 1;
 	}
 
-	spin_lock_irq(&q->queue_lock);
-	q->limits.max_sectors = max_sectors_kb << 1;
-	if (q->disk)
-		q->disk->bdi->io_pages = max_sectors_kb >> (PAGE_SHIFT - 10);
-	spin_unlock_irq(&q->queue_lock);
+	spin_lock_irq(&disk->queue->queue_lock);
+	lim->max_sectors = max_sectors_kb << 1;
+	disk->bdi->io_pages = max_sectors_kb >> (PAGE_SHIFT - 10);
+	spin_unlock_irq(&disk->queue->queue_lock);
 
 	return ret;
 }
 
-static ssize_t queue_max_hw_sectors_show(struct request_queue *q, char *page)
+static ssize_t queue_max_hw_sectors_show(struct gendisk *disk, char *page)
 {
-	int max_hw_sectors_kb = queue_max_hw_sectors(q) >> 1;
+	int max_hw_sectors_kb = queue_max_hw_sectors(disk->queue) >> 1;
 
 	return queue_var_show(max_hw_sectors_kb, page);
 }
 
-static ssize_t queue_virt_boundary_mask_show(struct request_queue *q, char *page)
+static ssize_t queue_virt_boundary_mask_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(q->limits.virt_boundary_mask, page);
+	return queue_var_show(disk->queue->limits.virt_boundary_mask, page);
 }
 
-static ssize_t queue_dma_alignment_show(struct request_queue *q, char *page)
+static ssize_t queue_dma_alignment_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(queue_dma_alignment(q), page);
+	return queue_var_show(queue_dma_alignment(disk->queue), page);
 }
 
 #define QUEUE_SYSFS_BIT_FNS(name, flag, neg)				\
 static ssize_t								\
-queue_##name##_show(struct request_queue *q, char *page)		\
+queue_##name##_show(struct gendisk *disk, char *page)		\
 {									\
 	int bit;							\
-	bit = test_bit(QUEUE_FLAG_##flag, &q->queue_flags);		\
+	bit = test_bit(QUEUE_FLAG_##flag, &disk->queue->queue_flags);	\
 	return queue_var_show(neg ? !bit : bit, page);			\
 }									\
 static ssize_t								\
-queue_##name##_store(struct request_queue *q, const char *page, size_t count) \
+queue_##name##_store(struct gendisk *disk, const char *page, size_t count) \
 {									\
 	unsigned long val;						\
 	ssize_t ret;							\
@@ -295,9 +296,9 @@ queue_##name##_store(struct request_queue *q, const char *page, size_t count) \
 		val = !val;						\
 									\
 	if (val)							\
-		blk_queue_flag_set(QUEUE_FLAG_##flag, q);		\
+		blk_queue_flag_set(QUEUE_FLAG_##flag, disk->queue);	\
 	else								\
-		blk_queue_flag_clear(QUEUE_FLAG_##flag, q);		\
+		blk_queue_flag_clear(QUEUE_FLAG_##flag, disk->queue);	\
 	return ret;							\
 }
 
@@ -307,9 +308,9 @@ QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
 QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
 #undef QUEUE_SYSFS_BIT_FNS
 
-static ssize_t queue_zoned_show(struct request_queue *q, char *page)
+static ssize_t queue_zoned_show(struct gendisk *disk, char *page)
 {
-	switch (blk_queue_zoned_model(q)) {
+	switch (blk_queue_zoned_model(disk->queue)) {
 	case BLK_ZONED_HA:
 		return sprintf(page, "host-aware\n");
 	case BLK_ZONED_HM:
@@ -319,28 +320,28 @@ static ssize_t queue_zoned_show(struct request_queue *q, char *page)
 	}
 }
 
-static ssize_t queue_nr_zones_show(struct request_queue *q, char *page)
+static ssize_t queue_nr_zones_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(disk_nr_zones(q->disk), page);
+	return queue_var_show(disk_nr_zones(disk), page);
 }
 
-static ssize_t queue_max_open_zones_show(struct request_queue *q, char *page)
+static ssize_t queue_max_open_zones_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(bdev_max_open_zones(q->disk->part0), page);
+	return queue_var_show(bdev_max_open_zones(disk->part0), page);
 }
 
-static ssize_t queue_max_active_zones_show(struct request_queue *q, char *page)
+static ssize_t queue_max_active_zones_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(bdev_max_active_zones(q->disk->part0), page);
+	return queue_var_show(bdev_max_active_zones(disk->part0), page);
 }
 
-static ssize_t queue_nomerges_show(struct request_queue *q, char *page)
+static ssize_t queue_nomerges_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show((blk_queue_nomerges(q) << 1) |
-			       blk_queue_noxmerges(q), page);
+	return queue_var_show((blk_queue_nomerges(disk->queue) << 1) |
+			       blk_queue_noxmerges(disk->queue), page);
 }
 
-static ssize_t queue_nomerges_store(struct request_queue *q, const char *page,
+static ssize_t queue_nomerges_store(struct gendisk *disk, const char *page,
 				    size_t count)
 {
 	unsigned long nm;
@@ -349,26 +350,26 @@ static ssize_t queue_nomerges_store(struct request_queue *q, const char *page,
 	if (ret < 0)
 		return ret;
 
-	blk_queue_flag_clear(QUEUE_FLAG_NOMERGES, q);
-	blk_queue_flag_clear(QUEUE_FLAG_NOXMERGES, q);
+	blk_queue_flag_clear(QUEUE_FLAG_NOMERGES, disk->queue);
+	blk_queue_flag_clear(QUEUE_FLAG_NOXMERGES, disk->queue);
 	if (nm == 2)
-		blk_queue_flag_set(QUEUE_FLAG_NOMERGES, q);
+		blk_queue_flag_set(QUEUE_FLAG_NOMERGES, disk->queue);
 	else if (nm)
-		blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
+		blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, disk->queue);
 
 	return ret;
 }
 
-static ssize_t queue_rq_affinity_show(struct request_queue *q, char *page)
+static ssize_t queue_rq_affinity_show(struct gendisk *disk, char *page)
 {
-	bool set = test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags);
-	bool force = test_bit(QUEUE_FLAG_SAME_FORCE, &q->queue_flags);
+	bool set = test_bit(QUEUE_FLAG_SAME_COMP, &disk->queue->queue_flags);
+	bool force = test_bit(QUEUE_FLAG_SAME_FORCE, &disk->queue->queue_flags);
 
 	return queue_var_show(set << force, page);
 }
 
 static ssize_t
-queue_rq_affinity_store(struct request_queue *q, const char *page, size_t count)
+queue_rq_affinity_store(struct gendisk *disk, const char *page, size_t count)
 {
 	ssize_t ret = -EINVAL;
 #ifdef CONFIG_SMP
@@ -379,52 +380,53 @@ queue_rq_affinity_store(struct request_queue *q, const char *page, size_t count)
 		return ret;
 
 	if (val == 2) {
-		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
-		blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, q);
+		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, disk->queue);
+		blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, disk->queue);
 	} else if (val == 1) {
-		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, q);
-		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
+		blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, disk->queue);
+		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, disk->queue);
 	} else if (val == 0) {
-		blk_queue_flag_clear(QUEUE_FLAG_SAME_COMP, q);
-		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, q);
+		blk_queue_flag_clear(QUEUE_FLAG_SAME_COMP, disk->queue);
+		blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, disk->queue);
 	}
 #endif
 	return ret;
 }
 
-static ssize_t queue_poll_delay_show(struct request_queue *q, char *page)
+static ssize_t queue_poll_delay_show(struct gendisk *disk, char *page)
 {
 	return sprintf(page, "%d\n", -1);
 }
 
-static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
-				size_t count)
+static ssize_t queue_poll_delay_store(struct gendisk *disk, const char *page,
+		size_t count)
 {
 	return count;
 }
 
-static ssize_t queue_poll_show(struct request_queue *q, char *page)
+static ssize_t queue_poll_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(test_bit(QUEUE_FLAG_POLL, &q->queue_flags), page);
+	return queue_var_show(test_bit(QUEUE_FLAG_POLL,
+			&disk->queue->queue_flags), page);
 }
 
-static ssize_t queue_poll_store(struct request_queue *q, const char *page,
+static ssize_t queue_poll_store(struct gendisk *disk, const char *page,
 				size_t count)
 {
-	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+	if (!test_bit(QUEUE_FLAG_POLL, &disk->queue->queue_flags))
 		return -EINVAL;
 	pr_info_ratelimited("writes to the poll attribute are ignored.\n");
 	pr_info_ratelimited("please use driver specific parameters instead.\n");
 	return count;
 }
 
-static ssize_t queue_io_timeout_show(struct request_queue *q, char *page)
+static ssize_t queue_io_timeout_show(struct gendisk *disk, char *page)
 {
-	return sprintf(page, "%u\n", jiffies_to_msecs(q->rq_timeout));
+	return sprintf(page, "%u\n", jiffies_to_msecs(disk->queue->rq_timeout));
 }
 
-static ssize_t queue_io_timeout_store(struct request_queue *q, const char *page,
-				  size_t count)
+static ssize_t queue_io_timeout_store(struct gendisk *disk, const char *page,
+		size_t count)
 {
 	unsigned int val;
 	int err;
@@ -433,29 +435,29 @@ static ssize_t queue_io_timeout_store(struct request_queue *q, const char *page,
 	if (err || val == 0)
 		return -EINVAL;
 
-	blk_queue_rq_timeout(q, msecs_to_jiffies(val));
+	blk_queue_rq_timeout(disk->queue, msecs_to_jiffies(val));
 
 	return count;
 }
 
-static ssize_t queue_wc_show(struct request_queue *q, char *page)
+static ssize_t queue_wc_show(struct gendisk *disk, char *page)
 {
-	if (test_bit(QUEUE_FLAG_WC, &q->queue_flags))
+	if (test_bit(QUEUE_FLAG_WC, &disk->queue->queue_flags))
 		return sprintf(page, "write back\n");
 
 	return sprintf(page, "write through\n");
 }
 
-static ssize_t queue_wc_store(struct request_queue *q, const char *page,
+static ssize_t queue_wc_store(struct gendisk *disk, const char *page,
 			      size_t count)
 {
 	if (!strncmp(page, "write back", 10)) {
-		if (!test_bit(QUEUE_FLAG_HW_WC, &q->queue_flags))
+		if (!test_bit(QUEUE_FLAG_HW_WC, &disk->queue->queue_flags))
 			return -EINVAL;
-		blk_queue_flag_set(QUEUE_FLAG_WC, q);
+		blk_queue_flag_set(QUEUE_FLAG_WC, disk->queue);
 	} else if (!strncmp(page, "write through", 13) ||
 		 !strncmp(page, "none", 4)) {
-		blk_queue_flag_clear(QUEUE_FLAG_WC, q);
+		blk_queue_flag_clear(QUEUE_FLAG_WC, disk->queue);
 	} else {
 		return -EINVAL;
 	}
@@ -463,14 +465,15 @@ static ssize_t queue_wc_store(struct request_queue *q, const char *page,
 	return count;
 }
 
-static ssize_t queue_fua_show(struct request_queue *q, char *page)
+static ssize_t queue_fua_show(struct gendisk *disk, char *page)
 {
-	return sprintf(page, "%u\n", test_bit(QUEUE_FLAG_FUA, &q->queue_flags));
+	return sprintf(page, "%u\n",
+		test_bit(QUEUE_FLAG_FUA, &disk->queue->queue_flags));
 }
 
-static ssize_t queue_dax_show(struct request_queue *q, char *page)
+static ssize_t queue_dax_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(blk_queue_dax(q), page);
+	return queue_var_show(blk_queue_dax(disk->queue), page);
 }
 
 #define QUEUE_RO_ENTRY(_prefix, _name)			\
@@ -557,19 +560,20 @@ static ssize_t queue_var_store64(s64 *var, const char *page)
 	return 0;
 }
 
-static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
+static ssize_t queue_wb_lat_show(struct gendisk *disk, char *page)
 {
-	if (!wbt_rq_qos(q))
+	if (!wbt_rq_qos(disk->queue))
 		return -EINVAL;
 
-	if (wbt_disabled(q))
+	if (wbt_disabled(disk->queue))
 		return sprintf(page, "0\n");
 
-	return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
+	return sprintf(page, "%llu\n",
+			div_u64(wbt_get_min_lat(disk->queue), 1000));
 }
 
-static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
-				  size_t count)
+static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
+			size_t count)
 {
 	struct rq_qos *rqos;
 	ssize_t ret;
@@ -581,19 +585,19 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 	if (val < -1)
 		return -EINVAL;
 
-	rqos = wbt_rq_qos(q);
+	rqos = wbt_rq_qos(disk->queue);
 	if (!rqos) {
-		ret = wbt_init(q->disk);
+		ret = wbt_init(disk);
 		if (ret)
 			return ret;
 	}
 
 	if (val == -1)
-		val = wbt_default_latency_nsec(q);
+		val = wbt_default_latency_nsec(disk->queue);
 	else if (val >= 0)
 		val *= 1000ULL;
 
-	if (wbt_get_min_lat(q) == val)
+	if (wbt_get_min_lat(disk->queue) == val)
 		return count;
 
 	/*
@@ -601,13 +605,13 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 	 * ends up either enabling or disabling wbt completely. We can't
 	 * have IO inflight if that happens.
 	 */
-	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue(q);
+	blk_mq_freeze_queue(disk->queue);
+	blk_mq_quiesce_queue(disk->queue);
 
-	wbt_set_min_lat(q, val);
+	wbt_set_min_lat(disk->queue, val);
 
-	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
+	blk_mq_unquiesce_queue(disk->queue);
+	blk_mq_unfreeze_queue(disk->queue);
 
 	return count;
 }
@@ -722,7 +726,7 @@ queue_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 	if (!entry->show)
 		return -EIO;
 	mutex_lock(&q->sysfs_lock);
-	res = entry->show(q, page);
+	res = entry->show(disk, page);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
 }
@@ -740,7 +744,7 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 		return -EIO;
 
 	mutex_lock(&q->sysfs_lock);
-	res = entry->store(q, page, length);
+	res = entry->store(disk, page, length);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
 }
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7397ff199d6695..d00599fb55ea16 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2446,27 +2446,28 @@ void blk_throtl_register(struct gendisk *disk)
 }
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page)
+ssize_t blk_throtl_sample_time_show(struct gendisk *disk, char *page)
 {
-	if (!q->td)
+	if (!disk->queue->td)
 		return -EINVAL;
-	return sprintf(page, "%u\n", jiffies_to_msecs(q->td->throtl_slice));
+	return sprintf(page, "%u\n",
+			jiffies_to_msecs(disk->queue->td->throtl_slice));
 }
 
-ssize_t blk_throtl_sample_time_store(struct request_queue *q,
-	const char *page, size_t count)
+ssize_t blk_throtl_sample_time_store(struct gendisk *disk, const char *page,
+		size_t count)
 {
 	unsigned long v;
 	unsigned long t;
 
-	if (!q->td)
+	if (!disk->queue->td)
 		return -EINVAL;
 	if (kstrtoul(page, 10, &v))
 		return -EINVAL;
 	t = msecs_to_jiffies(v);
 	if (t == 0 || t > MAX_THROTL_SLICE)
 		return -EINVAL;
-	q->td->throtl_slice = t;
+	disk->queue->td->throtl_slice = t;
 	return count;
 }
 #endif
diff --git a/block/blk.h b/block/blk.h
index 686712e1383526..26737993a922e0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -363,9 +363,9 @@ static inline void ioc_clear_queue(struct request_queue *q)
 #endif /* CONFIG_BLK_ICQ */
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
-extern ssize_t blk_throtl_sample_time_store(struct request_queue *q,
-	const char *page, size_t count);
+ssize_t blk_throtl_sample_time_show(struct gendisk *disk, char *page);
+ssize_t blk_throtl_sample_time_store(struct gendisk *disk, const char *page,
+		size_t count);
 extern void blk_throtl_bio_endio(struct bio *bio);
 extern void blk_throtl_stat_add(struct request *rq, u64 time);
 #else
diff --git a/block/elevator.c b/block/elevator.c
index 8400e303fbcbd6..61b43e866785fe 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -742,32 +742,32 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 	return ret;
 }
 
-ssize_t elv_iosched_store(struct request_queue *q, const char *buf,
+ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 			  size_t count)
 {
 	char elevator_name[ELV_NAME_MAX];
 	int ret;
 
-	if (!elv_support_iosched(q))
+	if (!elv_support_iosched(disk->queue))
 		return count;
 
 	strscpy(elevator_name, buf, sizeof(elevator_name));
-	ret = elevator_change(q, strstrip(elevator_name));
+	ret = elevator_change(disk->queue, strstrip(elevator_name));
 	if (!ret)
 		return count;
 	return ret;
 }
 
-ssize_t elv_iosched_show(struct request_queue *q, char *name)
+ssize_t elv_iosched_show(struct gendisk *disk, char *name)
 {
-	struct elevator_queue *eq = q->elevator;
+	struct elevator_queue *eq = disk->queue->elevator;
 	struct elevator_type *cur = NULL, *e;
 	int len = 0;
 
-	if (!elv_support_iosched(q))
+	if (!elv_support_iosched(disk->queue))
 		return sprintf(name, "none\n");
 
-	if (!q->elevator) {
+	if (!disk->queue->elevator) {
 		len += sprintf(name+len, "[none] ");
 	} else {
 		len += sprintf(name+len, "none ");
@@ -778,7 +778,7 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
 	list_for_each_entry(e, &elv_list, list) {
 		if (e == cur)
 			len += sprintf(name+len, "[%s] ", e->elevator_name);
-		else if (elv_support_features(q, e))
+		else if (elv_support_features(disk->queue, e))
 			len += sprintf(name+len, "%s ", e->elevator_name);
 	}
 	spin_unlock(&elv_list_lock);
diff --git a/block/elevator.h b/block/elevator.h
index 7ca3d7b6ed8289..261e2dbf729e3c 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -148,8 +148,8 @@ extern void elv_unregister(struct elevator_type *);
 /*
  * io scheduler sysfs switching
  */
-extern ssize_t elv_iosched_show(struct request_queue *, char *);
-extern ssize_t elv_iosched_store(struct request_queue *, const char *, size_t);
+ssize_t elv_iosched_show(struct gendisk *, char *);
+ssize_t elv_iosched_store(struct gendisk *, const char *, size_t);
 
 extern bool elv_bio_merge_ok(struct request *, struct bio *);
 extern struct elevator_queue *elevator_alloc(struct request_queue *,
-- 
2.39.2

