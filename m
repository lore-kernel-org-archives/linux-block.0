Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7899 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757809AbcK3U3a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2016 15:29:30 -0500
From: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
To: axboe@fb.com
Cc: martin.petersen@oracle.com, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: [PATCH V2 2/5] block: add support for REQ_OP_WRITE_ZEROES
Date: Wed, 30 Nov 2016 12:28:59 -0800
Message-Id: <1480537742-15190-2-git-send-email-chaitanya.kulkarni@hgst.com>
In-Reply-To: <1480537742-15190-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1480537742-15190-1-git-send-email-chaitanya.kulkarni@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This adds a new block layer operation to zero out a range of
LBAs. This allows to implement zeroing for devices that don't use
either discard with a predictable zero pattern or WRITE SAME of zeroes.
The prominent example of that is NVMe with the Write Zeroes command,
but in the future, this should also help with improving the way
zeroing discards work. For this operation, suitable entry is exported in
sysfs which indicate the number of maximum bytes allowed in one
write zeroes operation by the device.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
---
 Documentation/ABI/testing/sysfs-block | 13 ++++++++
 block/bio.c                           |  1 +
 block/blk-core.c                      |  4 +++
 block/blk-lib.c                       | 58 +++++++++++++++++++++++++++++++++--
 block/blk-merge.c                     | 17 +++++++---
 block/blk-settings.c                  | 17 ++++++++++
 block/blk-sysfs.c                     | 11 +++++++
 block/blk-wbt.c                       |  5 +--
 include/linux/bio.h                   | 25 ++++++++-------
 include/linux/blk_types.h             |  2 ++
 include/linux/blkdev.h                | 19 ++++++++++++
 11 files changed, 153 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index ee2d5cd..2da04ce 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -235,6 +235,19 @@ Description:
 		write_same_max_bytes is 0, write same is not supported
 		by the device.
 
+What:		/sys/block/<disk>/queue/write_zeroes_max_bytes
+Date:		November 2016
+Contact:	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
+Description:
+		Devices that support write zeroes operation in which a
+		single request can be issued to zero out the range of
+		contiguous blocks on storage without having any payload
+		in the request. This can be used to optimize writing zeroes
+		to the devices. write_zeroes_max_bytes indicates how many
+		bytes can be written in a single write zeroes command. If
+		write_zeroes_max_bytes is 0, write zeroes is not supported
+		by the device.
+
 What:		/sys/block/<disk>/queue/zoned
 Date:		September 2016
 Contact:	Damien Le Moal <damien.lemoal@hgst.com>
diff --git a/block/bio.c b/block/bio.c
index 2cf6eba..39fa10a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -670,6 +670,7 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
+	case REQ_OP_WRITE_ZEROES:
 		break;
 	case REQ_OP_WRITE_SAME:
 		bio->bi_io_vec[bio->bi_vcnt++] = bio_src->bi_io_vec[0];
diff --git a/block/blk-core.c b/block/blk-core.c
index 473dd69..7438936 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1945,6 +1945,10 @@ static inline int bio_check_eod(struct bio *bio, unsigned int nr_sectors)
 		if (!bdev_is_zoned(bio->bi_bdev))
 			goto not_supported;
 		break;
+	case REQ_OP_WRITE_ZEROES:
+		if (!bdev_write_zeroes_sectors(bio->bi_bdev))
+			goto not_supported;
+		break;
 	default:
 		break;
 	}
diff --git a/block/blk-lib.c b/block/blk-lib.c
index bfb28b0..510a6fb 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -227,6 +227,55 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 EXPORT_SYMBOL(blkdev_issue_write_same);
 
 /**
+ * __blkdev_issue_write_zeroes - generate number of bios with WRITE ZEROES
+ * @bdev:	blockdev to issue
+ * @sector:	start sector
+ * @nr_sects:	number of sectors to write
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ * @biop:	pointer to anchor bio
+ *
+ * Description:
+ *  Generate and issue number of bios(REQ_OP_WRITE_ZEROES) with zerofiled pages.
+ */
+static int __blkdev_issue_write_zeroes(struct block_device *bdev,
+		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
+		struct bio **biop)
+{
+	struct bio *bio = *biop;
+	unsigned int max_write_zeroes_sectors;
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (!q)
+		return -ENXIO;
+
+	/* Ensure that max_write_zeroes_sectors doesn't overflow bi_size */
+	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev);
+
+	if (max_write_zeroes_sectors == 0)
+		return -EOPNOTSUPP;
+
+	while (nr_sects) {
+		bio = next_bio(bio, 0, gfp_mask);
+		bio->bi_iter.bi_sector = sector;
+		bio->bi_bdev = bdev;
+		bio_set_op_attrs(bio, REQ_OP_WRITE_ZEROES, 0);
+
+		if (nr_sects > max_write_zeroes_sectors) {
+			bio->bi_iter.bi_size = max_write_zeroes_sectors << 9;
+			nr_sects -= max_write_zeroes_sectors;
+			sector += max_write_zeroes_sectors;
+		} else {
+			bio->bi_iter.bi_size = nr_sects << 9;
+			nr_sects = 0;
+		}
+		cond_resched();
+	}
+
+	*biop = bio;
+	return 0;
+}
+
+/**
  * __blkdev_issue_zeroout - generate number of zero filed write bios
  * @bdev:	blockdev to issue
  * @sector:	start sector
@@ -259,6 +308,11 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 			goto out;
 	}
 
+	ret = __blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp_mask,
+			biop);
+	if (ret == 0 || (ret && ret != -EOPNOTSUPP))
+		goto out;
+
 	ret = __blkdev_issue_write_same(bdev, sector, nr_sects, gfp_mask,
 			ZERO_PAGE(0), biop);
 	if (ret == 0 || (ret && ret != -EOPNOTSUPP))
@@ -304,8 +358,8 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
  *  the discard request fail, if the discard flag is not set, or if
  *  discard_zeroes_data is not supported, this function will resort to
  *  zeroing the blocks manually, thus provisioning (allocating,
- *  anchoring) them. If the block device supports the WRITE SAME command
- *  blkdev_issue_zeroout() will use it to optimize the process of
+ *  anchoring) them. If the block device supports WRITE ZEROES or WRITE SAME
+ *  command(s), blkdev_issue_zeroout() will use it to optimize the process of
  *  clearing the block range. Otherwise the zeroing will be performed
  *  using regular WRITE calls.
  */
diff --git a/block/blk-merge.c b/block/blk-merge.c
index fda6a12..cf2848c 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -199,6 +199,10 @@ void blk_queue_split(struct request_queue *q, struct bio **bio,
 	case REQ_OP_SECURE_ERASE:
 		split = blk_bio_discard_split(q, *bio, bs, &nsegs);
 		break;
+	case REQ_OP_WRITE_ZEROES:
+		split = NULL;
+		nsegs = (*bio)->bi_phys_segments;
+		break;
 	case REQ_OP_WRITE_SAME:
 		split = blk_bio_write_same_split(q, *bio, bs, &nsegs);
 		break;
@@ -241,11 +245,15 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	 * This should probably be returning 0, but blk_add_request_payload()
 	 * (Christoph!!!!)
 	 */
-	if (bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_SECURE_ERASE)
-		return 1;
-
-	if (bio_op(bio) == REQ_OP_WRITE_SAME)
+	switch (bio_op(bio)) {
+	case REQ_OP_DISCARD:
+	case REQ_OP_SECURE_ERASE:
+	case REQ_OP_WRITE_SAME:
+	case REQ_OP_WRITE_ZEROES:
 		return 1;
+	default:
+		break;
+	}
 
 	fbio = bio;
 	cluster = blk_queue_cluster(q);
@@ -416,6 +424,7 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
+	case REQ_OP_WRITE_ZEROES:
 		/*
 		 * This is a hack - drivers should be neither modifying the
 		 * biovec, nor relying on bi_vcnt - but because of
diff --git a/block/blk-settings.c b/block/blk-settings.c
index c7ccabc..8a2bc12 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -96,6 +96,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = 0;
 	lim->chunk_sectors = 0;
 	lim->max_write_same_sectors = 0;
+	lim->max_write_zeroes_sectors = 0;
 	lim->max_discard_sectors = 0;
 	lim->max_hw_discard_sectors = 0;
 	lim->discard_granularity = 0;
@@ -132,6 +133,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_sectors = UINT_MAX;
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_same_sectors = UINT_MAX;
+	lim->max_write_zeroes_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -300,6 +302,19 @@ void blk_queue_max_write_same_sectors(struct request_queue *q,
 EXPORT_SYMBOL(blk_queue_max_write_same_sectors);
 
 /**
+ * blk_queue_max_write_zeroes_sectors - set max sectors for a single
+ *                                      write zeroes
+ * @q:  the request queue for the device
+ * @max_write_zeroes_sectors: maximum number of sectors to write per command
+ **/
+void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
+		unsigned int max_write_zeroes_sectors)
+{
+	q->limits.max_write_zeroes_sectors = max_write_zeroes_sectors;
+}
+EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
+
+/**
  * blk_queue_max_segments - set max hw segments for a request for this queue
  * @q:  the request queue for the device
  * @max_segments:  max number of segments
@@ -527,6 +542,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
 	t->max_write_same_sectors = min(t->max_write_same_sectors,
 					b->max_write_same_sectors);
+	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
+					b->max_write_zeroes_sectors);
 	t->bounce_pfn = min_not_zero(t->bounce_pfn, b->bounce_pfn);
 
 	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1855c67..46f03b2 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -211,6 +211,11 @@ static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
 		(unsigned long long)q->limits.max_write_same_sectors << 9);
 }
 
+static ssize_t queue_write_zeroes_max_show(struct request_queue *q, char *page)
+{
+	return sprintf(page, "%llu\n",
+		(unsigned long long)q->limits.max_write_zeroes_sectors << 9);
+}
 
 static ssize_t
 queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
@@ -593,6 +598,11 @@ static ssize_t queue_stats_show(struct request_queue *q, char *page)
 	.show = queue_write_same_max_show,
 };
 
+static struct queue_sysfs_entry queue_write_zeroes_max_entry = {
+	.attr = {.name = "write_zeroes_max_bytes", .mode = S_IRUGO },
+	.show = queue_write_zeroes_max_show,
+};
+
 static struct queue_sysfs_entry queue_nonrot_entry = {
 	.attr = {.name = "rotational", .mode = S_IRUGO | S_IWUSR },
 	.show = queue_show_nonrot,
@@ -682,6 +692,7 @@ static ssize_t queue_stats_show(struct request_queue *q, char *page)
 	&queue_discard_max_hw_entry.attr,
 	&queue_discard_zeroes_data_entry.attr,
 	&queue_write_same_max_entry.attr,
+	&queue_write_zeroes_max_entry.attr,
 	&queue_nonrot_entry.attr,
 	&queue_zoned_entry.attr,
 	&queue_nomerges_entry.attr,
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 9f97594..0e34740 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -575,9 +575,10 @@ static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
 	const int op = bio_op(bio);
 
 	/*
-	 * If not a WRITE (or a discard), do nothing
+	 * If not a WRITE (or a discard or write zeroes), do nothing
 	 */
-	if (!(op == REQ_OP_WRITE || op == REQ_OP_DISCARD))
+	if (!(op == REQ_OP_WRITE || op == REQ_OP_DISCARD ||
+				op == REQ_OP_WRITE_ZEROES))
 		return false;
 
 	/*
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d367cd3..491c7e9 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -76,7 +76,8 @@ static inline bool bio_has_data(struct bio *bio)
 	if (bio &&
 	    bio->bi_iter.bi_size &&
 	    bio_op(bio) != REQ_OP_DISCARD &&
-	    bio_op(bio) != REQ_OP_SECURE_ERASE)
+	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
+	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
 		return true;
 
 	return false;
@@ -86,7 +87,8 @@ static inline bool bio_no_advance_iter(struct bio *bio)
 {
 	return bio_op(bio) == REQ_OP_DISCARD ||
 	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
-	       bio_op(bio) == REQ_OP_WRITE_SAME;
+	       bio_op(bio) == REQ_OP_WRITE_SAME ||
+	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
 }
 
 static inline bool bio_mergeable(struct bio *bio)
@@ -188,18 +190,19 @@ static inline unsigned bio_segments(struct bio *bio)
 	struct bvec_iter iter;
 
 	/*
-	 * We special case discard/write same, because they interpret bi_size
-	 * differently:
+	 * We special case discard/write same/write zeroes, because they
+	 * interpret bi_size differently:
 	 */
 
-	if (bio_op(bio) == REQ_OP_DISCARD)
-		return 1;
-
-	if (bio_op(bio) == REQ_OP_SECURE_ERASE)
-		return 1;
-
-	if (bio_op(bio) == REQ_OP_WRITE_SAME)
+	switch (bio_op(bio)) {
+	case REQ_OP_DISCARD:
+	case REQ_OP_SECURE_ERASE:
+	case REQ_OP_WRITE_SAME:
+	case REQ_OP_WRITE_ZEROES:
 		return 1;
+	default:
+		break;
+	}
 
 	bio_for_each_segment(bv, bio, iter)
 		segs++;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4d0044d..2b0aebf 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -159,6 +159,8 @@ enum req_opf {
 	REQ_OP_ZONE_RESET	= 6,
 	/* write the same sector many times */
 	REQ_OP_WRITE_SAME	= 7,
+	/* write the zero filled sector many times */
+	REQ_OP_WRITE_ZEROES	= 8,
 
 	REQ_OP_LAST,
 };
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7e9d8a0..ebeef2b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -323,6 +323,7 @@ struct queue_limits {
 	unsigned int		max_discard_sectors;
 	unsigned int		max_hw_discard_sectors;
 	unsigned int		max_write_same_sectors;
+	unsigned int		max_write_zeroes_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
 
@@ -774,6 +775,9 @@ static inline bool rq_mergeable(struct request *rq)
 	if (req_op(rq) == REQ_OP_FLUSH)
 		return false;
 
+	if (req_op(rq) == REQ_OP_WRITE_ZEROES)
+		return false;
+
 	if (rq->cmd_flags & REQ_NOMERGE_FLAGS)
 		return false;
 	if (rq->rq_flags & RQF_NOMERGE_FLAGS)
@@ -1004,6 +1008,9 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 	if (unlikely(op == REQ_OP_WRITE_SAME))
 		return q->limits.max_write_same_sectors;
 
+	if (unlikely(op == REQ_OP_WRITE_ZEROES))
+		return q->limits.max_write_zeroes_sectors;
+
 	return q->limits.max_sectors;
 }
 
@@ -1107,6 +1114,8 @@ extern void blk_queue_max_discard_sectors(struct request_queue *q,
 		unsigned int max_discard_sectors);
 extern void blk_queue_max_write_same_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
+extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
+		unsigned int max_write_same_sectors);
 extern void blk_queue_logical_block_size(struct request_queue *, unsigned short);
 extern void blk_queue_physical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_alignment_offset(struct request_queue *q,
@@ -1475,6 +1484,16 @@ static inline unsigned int bdev_write_same(struct block_device *bdev)
 	return 0;
 }
 
+static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (q)
+		return q->limits.max_write_zeroes_sectors;
+
+	return 0;
+}
+
 static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
1.8.3.1

