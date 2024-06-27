Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BEF13BACC
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486871; cv=none; b=RFBNOAUeXoIjAp4Q8KTiwdg59Thvc4EcQCN8+p8Wb/6EP0dpbY8GUBZECVnWHKANyGsqXaMMwhZFhzrLrkno3bWInwaP8WHyQB51Z3OqtMkiMfrnOeaKX/UnpSKNgD66pYuVJR6uALu/Kl3B0qbzxgfq3I83q2yBoD9SJ1nVaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486871; c=relaxed/simple;
	bh=IAIrfTPTIFFPp6wPvBSUxk2ZuBVJi9UM/CNyE9DIlWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzS93hI4wPrMMz7fCu/naon0SaVXIH0ShZrqNWDt9PqJnnMc7hj+T/wModyvv04WCEZAsCjTxIpk8HwNqrhMMWy+Yxk77Bde3/iWAF1VtqU2T9Lzp5KaYhwoaqHW38aF0BMGtjmQi2ftB8fzG1Skc7lh+5y1w+e0T3eZVcNzXhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4JY9oCso; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4JY9oCso"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=z61DvDhem9T/lryMPJw14QyCPVA/HnNvdxdxDj0mWNA=; b=4JY9oCsontrlHDAWuOIgBj9yjY
	QM09UxYj5rPfLwt5e9e/H5EB1i/WJHwyMcBN5Ojq/hqDxdOIAh5jD2twKE8yj62kGtPvxHhxkeYC1
	yh/BV5RRRYm8aB53+n4INDSBIB+aql1zySNIAa2L/CqRPF2MsBFPz3TcYNzCQRdO0fwd8TsUZb9c4
	FJbRyX7r69twra4qY3WwJKTSxdpRWG9ue9PC6oH9ZYUMaKmLVTvhKjvg+gWR8MX+hijrFcgLznKsT
	3MoGFCoEN1HsD/HPy5s+c0R0945oUgWW9FN8j6eT/Z6NHhrWek3QKFH+/VI5uNwafxeRqIngP2NeS
	UNcx9UHA==;
Received: from [2001:4bb8:2dc:6d4c:6789:3c0c:a17:a2fe] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMn59-0000000A7Kf-3O6X;
	Thu, 27 Jun 2024 11:14:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: pass a gendisk to the queue_sysfs_entry methods
Date: Thu, 27 Jun 2024 13:14:03 +0200
Message-ID: <20240627111407.476276-4-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627111407.476276-1-hch@lst.de>
References: <20240627111407.476276-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The kobject for the queue entries is embedded into a struct gendisk.
Pass it to the sysfs methods instead of the request_queue derived from
it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c | 180 +++++++++++++++++++++++-----------------------
 block/elevator.c  |   9 +--
 block/elevator.h  |   4 +-
 3 files changed, 96 insertions(+), 97 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index a769fb441b58da..60116d13cb8043 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -22,8 +22,8 @@
 
 struct queue_sysfs_entry {
 	struct attribute attr;
-	ssize_t (*show)(struct request_queue *, char *);
-	ssize_t (*store)(struct request_queue *, const char *, size_t);
+	ssize_t (*show)(struct gendisk *disk, char *page);
+	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
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
@@ -68,42 +68,35 @@ queue_requests_store(struct request_queue *q, const char *page, size_t count)
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
-
-	if (!q->disk)
-		return -EINVAL;
-	ra_kb = q->disk->bdi->ra_pages << (PAGE_SHIFT - 10);
-	return queue_var_show(ra_kb, page);
+	return queue_var_show(disk->bdi->ra_pages << (PAGE_SHIFT - 10), page);
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
 
 #define QUEUE_SYSFS_LIMIT_SHOW(_field)					\
-static ssize_t queue_##_field##_show(struct request_queue *q, char *page) \
+static ssize_t queue_##_field##_show(struct gendisk *disk, char *page)	\
 {									\
-	return queue_var_show(q->limits._field, page);			\
+	return queue_var_show(disk->queue->limits._field, page);	\
 }
 
 QUEUE_SYSFS_LIMIT_SHOW(max_segments)
@@ -125,10 +118,11 @@ QUEUE_SYSFS_LIMIT_SHOW(atomic_write_unit_min)
 QUEUE_SYSFS_LIMIT_SHOW(atomic_write_unit_max)
 
 #define QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(_field)			\
-static ssize_t queue_##_field##_show(struct request_queue *q, char *page) \
+static ssize_t queue_##_field##_show(struct gendisk *disk, char *page)	\
 {									\
 	return sprintf(page, "%llu\n",					\
-		(unsigned long long)q->limits._field << SECTOR_SHIFT);	\
+		(unsigned long long)disk->queue->limits._field <<	\
+			SECTOR_SHIFT);					\
 }
 
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_discard_sectors)
@@ -138,16 +132,16 @@ QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(atomic_write_max_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(atomic_write_boundary_sectors)
 
 #define QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_KB(_field)			\
-static ssize_t queue_##_field##_show(struct request_queue *q, char *page) \
+static ssize_t queue_##_field##_show(struct gendisk *disk, char *page)	\
 {									\
-	return queue_var_show(q->limits._field >> 1, page);		\
+	return queue_var_show(disk->queue->limits._field >> 1, page);	\
 }
 
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_KB(max_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_KB(max_hw_sectors)
 
 #define QUEUE_SYSFS_SHOW_CONST(_name, _val)				\
-static ssize_t queue_##_name##_show(struct request_queue *q, char *page) \
+static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)	\
 {									\
 	return sprintf(page, "%d\n", _val);				\
 }
@@ -157,7 +151,7 @@ QUEUE_SYSFS_SHOW_CONST(discard_zeroes_data, 0)
 QUEUE_SYSFS_SHOW_CONST(write_same_max, 0)
 QUEUE_SYSFS_SHOW_CONST(poll_delay, -1)
 
-static ssize_t queue_max_discard_sectors_store(struct request_queue *q,
+static ssize_t queue_max_discard_sectors_store(struct gendisk *disk,
 		const char *page, size_t count)
 {
 	unsigned long max_discard_bytes;
@@ -169,15 +163,15 @@ static ssize_t queue_max_discard_sectors_store(struct request_queue *q,
 	if (ret < 0)
 		return ret;
 
-	if (max_discard_bytes & (q->limits.discard_granularity - 1))
+	if (max_discard_bytes & (disk->queue->limits.discard_granularity - 1))
 		return -EINVAL;
 
 	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
 		return -EINVAL;
 
-	lim = queue_limits_start_update(q);
+	lim = queue_limits_start_update(disk->queue);
 	lim.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
-	err = queue_limits_commit_update(q, &lim);
+	err = queue_limits_commit_update(disk->queue, &lim);
 	if (err)
 		return err;
 	return ret;
@@ -188,15 +182,15 @@ static ssize_t queue_max_discard_sectors_store(struct request_queue *q,
  * underlying queue limits, but actually contains a calculation.  Because of
  * that we can't simply use QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES here.
  */
-static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
+static ssize_t queue_zone_append_max_show(struct gendisk *disk, char *page)
 {
-	unsigned long long max_sectors = queue_max_zone_append_sectors(q);
-
-	return sprintf(page, "%llu\n", max_sectors << SECTOR_SHIFT);
+	return sprintf(page, "%llu\n",
+		(u64)queue_max_zone_append_sectors(disk->queue) <<
+			SECTOR_SHIFT);
 }
 
 static ssize_t
-queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
+queue_max_sectors_store(struct gendisk *disk, const char *page, size_t count)
 {
 	unsigned long max_sectors_kb;
 	struct queue_limits lim;
@@ -207,15 +201,15 @@ queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 	if (ret < 0)
 		return ret;
 
-	lim = queue_limits_start_update(q);
+	lim = queue_limits_start_update(disk->queue);
 	lim.max_user_sectors = max_sectors_kb << 1;
-	err = queue_limits_commit_update(q, &lim);
+	err = queue_limits_commit_update(disk->queue, &lim);
 	if (err)
 		return err;
 	return ret;
 }
 
-static ssize_t queue_feature_store(struct request_queue *q, const char *page,
+static ssize_t queue_feature_store(struct gendisk *disk, const char *page,
 		size_t count, blk_features_t feature)
 {
 	struct queue_limits lim;
@@ -226,26 +220,27 @@ static ssize_t queue_feature_store(struct request_queue *q, const char *page,
 	if (ret < 0)
 		return ret;
 
-	lim = queue_limits_start_update(q);
+	lim = queue_limits_start_update(disk->queue);
 	if (val)
 		lim.features |= feature;
 	else
 		lim.features &= ~feature;
-	ret = queue_limits_commit_update(q, &lim);
+	ret = queue_limits_commit_update(disk->queue, &lim);
 	if (ret)
 		return ret;
 	return count;
 }
 
-#define QUEUE_SYSFS_FEATURE(_name, _feature)				 \
-static ssize_t queue_##_name##_show(struct request_queue *q, char *page) \
-{									 \
-	return sprintf(page, "%u\n", !!(q->limits.features & _feature)); \
-}									 \
-static ssize_t queue_##_name##_store(struct request_queue *q,		 \
-		const char *page, size_t count)				 \
-{									 \
-	return queue_feature_store(q, page, count, _feature);		 \
+#define QUEUE_SYSFS_FEATURE(_name, _feature)				\
+static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)	\
+{									\
+	return sprintf(page, "%u\n",					\
+		!!(disk->queue->limits.features & _feature));		\
+}									\
+static ssize_t queue_##_name##_store(struct gendisk *disk,		\
+		const char *page, size_t count)				\
+{									\
+	return queue_feature_store(disk, page, count, _feature);	\
 }
 
 QUEUE_SYSFS_FEATURE(rotational, BLK_FEAT_ROTATIONAL)
@@ -253,35 +248,36 @@ QUEUE_SYSFS_FEATURE(add_random, BLK_FEAT_ADD_RANDOM)
 QUEUE_SYSFS_FEATURE(iostats, BLK_FEAT_IO_STAT)
 QUEUE_SYSFS_FEATURE(stable_writes, BLK_FEAT_STABLE_WRITES);
 
-#define QUEUE_SYSFS_FEATURE_SHOW(_name, _feature)			 \
-static ssize_t queue_##_name##_show(struct request_queue *q, char *page) \
-{									 \
-	return sprintf(page, "%u\n", !!(q->limits.features & _feature)); \
+#define QUEUE_SYSFS_FEATURE_SHOW(_name, _feature)			\
+static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)	\
+{									\
+	return sprintf(page, "%u\n",					\
+		!!(disk->queue->limits.features & _feature));		\
 }
 
 QUEUE_SYSFS_FEATURE_SHOW(poll, BLK_FEAT_POLL);
 QUEUE_SYSFS_FEATURE_SHOW(fua, BLK_FEAT_FUA);
 QUEUE_SYSFS_FEATURE_SHOW(dax, BLK_FEAT_DAX);
 
-static ssize_t queue_zoned_show(struct request_queue *q, char *page)
+static ssize_t queue_zoned_show(struct gendisk *disk, char *page)
 {
-	if (blk_queue_is_zoned(q))
+	if (blk_queue_is_zoned(disk->queue))
 		return sprintf(page, "host-managed\n");
 	return sprintf(page, "none\n");
 }
 
-static ssize_t queue_nr_zones_show(struct request_queue *q, char *page)
+static ssize_t queue_nr_zones_show(struct gendisk *disk, char *page)
 {
-	return queue_var_show(disk_nr_zones(q->disk), page);
+	return queue_var_show(disk_nr_zones(disk), page);
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
@@ -290,29 +286,30 @@ static ssize_t queue_nomerges_store(struct request_queue *q, const char *page,
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
+	struct request_queue *q = disk->queue;
 	unsigned long val;
 
 	ret = queue_var_store(&val, page, count);
@@ -333,28 +330,28 @@ queue_rq_affinity_store(struct request_queue *q, const char *page, size_t count)
 	return ret;
 }
 
-static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
+static ssize_t queue_poll_delay_store(struct gendisk *disk, const char *page,
 				size_t count)
 {
 	return count;
 }
 
-static ssize_t queue_poll_store(struct request_queue *q, const char *page,
+static ssize_t queue_poll_store(struct gendisk *disk, const char *page,
 				size_t count)
 {
-	if (!(q->limits.features & BLK_FEAT_POLL))
+	if (!(disk->queue->limits.features & BLK_FEAT_POLL))
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
+static ssize_t queue_io_timeout_store(struct gendisk *disk, const char *page,
 				  size_t count)
 {
 	unsigned int val;
@@ -364,19 +361,19 @@ static ssize_t queue_io_timeout_store(struct request_queue *q, const char *page,
 	if (err || val == 0)
 		return -EINVAL;
 
-	blk_queue_rq_timeout(q, msecs_to_jiffies(val));
+	blk_queue_rq_timeout(disk->queue, msecs_to_jiffies(val));
 
 	return count;
 }
 
-static ssize_t queue_wc_show(struct request_queue *q, char *page)
+static ssize_t queue_wc_show(struct gendisk *disk, char *page)
 {
-	if (blk_queue_write_cache(q))
+	if (blk_queue_write_cache(disk->queue))
 		return sprintf(page, "write back\n");
 	return sprintf(page, "write through\n");
 }
 
-static ssize_t queue_wc_store(struct request_queue *q, const char *page,
+static ssize_t queue_wc_store(struct gendisk *disk, const char *page,
 			      size_t count)
 {
 	struct queue_limits lim;
@@ -392,12 +389,12 @@ static ssize_t queue_wc_store(struct request_queue *q, const char *page,
 		return -EINVAL;
 	}
 
-	lim = queue_limits_start_update(q);
+	lim = queue_limits_start_update(disk->queue);
 	if (disable)
 		lim.flags |= BLK_FLAG_WRITE_CACHE_DISABLED;
 	else
 		lim.flags &= ~BLK_FLAG_WRITE_CACHE_DISABLED;
-	err = queue_limits_commit_update(q, &lim);
+	err = queue_limits_commit_update(disk->queue, &lim);
 	if (err)
 		return err;
 	return count;
@@ -489,20 +486,22 @@ static ssize_t queue_var_store64(s64 *var, const char *page)
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
+		div_u64(wbt_get_min_lat(disk->queue), 1000));
 }
 
-static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
+static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 				  size_t count)
 {
+	struct request_queue *q = disk->queue;
 	struct rq_qos *rqos;
 	ssize_t ret;
 	s64 val;
@@ -515,7 +514,7 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 
 	rqos = wbt_rq_qos(q);
 	if (!rqos) {
-		ret = wbt_init(q->disk);
+		ret = wbt_init(disk);
 		if (ret)
 			return ret;
 	}
@@ -649,14 +648,13 @@ queue_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 {
 	struct queue_sysfs_entry *entry = to_queue(attr);
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
-	struct request_queue *q = disk->queue;
 	ssize_t res;
 
 	if (!entry->show)
 		return -EIO;
-	mutex_lock(&q->sysfs_lock);
-	res = entry->show(q, page);
-	mutex_unlock(&q->sysfs_lock);
+	mutex_lock(&disk->queue->sysfs_lock);
+	res = entry->show(disk, page);
+	mutex_unlock(&disk->queue->sysfs_lock);
 	return res;
 }
 
@@ -674,7 +672,7 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 
 	blk_mq_freeze_queue(q);
 	mutex_lock(&q->sysfs_lock);
-	res = entry->store(q, page, length);
+	res = entry->store(disk, page, length);
 	mutex_unlock(&q->sysfs_lock);
 	blk_mq_unfreeze_queue(q);
 	return res;
diff --git a/block/elevator.c b/block/elevator.c
index f64ebd726e588a..f13d552a32c8b8 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -709,24 +709,25 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
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
+	struct request_queue *q = disk->queue;
 	struct elevator_queue *eq = q->elevator;
 	struct elevator_type *cur = NULL, *e;
 	int len = 0;
diff --git a/block/elevator.h b/block/elevator.h
index e9a050a96e5305..3fe18e1a869275 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -147,8 +147,8 @@ extern void elv_unregister(struct elevator_type *);
 /*
  * io scheduler sysfs switching
  */
-extern ssize_t elv_iosched_show(struct request_queue *, char *);
-extern ssize_t elv_iosched_store(struct request_queue *, const char *, size_t);
+ssize_t elv_iosched_show(struct gendisk *disk, char *page);
+ssize_t elv_iosched_store(struct gendisk *disk, const char *page, size_t count);
 
 extern bool elv_bio_merge_ok(struct request *, struct bio *);
 extern struct elevator_queue *elevator_alloc(struct request_queue *,
-- 
2.43.0

