Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36261 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbcKPGvE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2016 01:51:04 -0500
Received: by mail-pg0-f67.google.com with SMTP id x23so13868320pgx.3
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2016 22:51:04 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@fb.com
Cc: martin.petersen@oracle.com, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: [PATCH 2/5] block: add support for REQ_OP_WRITE_ZEROES
Date: Tue, 15 Nov 2016 22:50:36 -0800
Message-Id: <1479279039-25818-3-git-send-email-chaitanya.kulkarni@hgst.com>
In-Reply-To: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This adds a new block layer operation to zero out a range of
LBAs. This allows to implement zeroing for devices that don't use
either discard with a predictable zero pattern or WRITE SAME of zeroes.
The prominent example of that is NVMe with the Write Zeroes command,
but in the future this should also help with improving the way
zeroing discards work.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
---
 block/bio.c               |  1 +
 block/blk-core.c          |  4 ++++
 block/blk-lib.c           | 58 +++++++++++++++++++++++++++++++++++++++++++++--
 block/blk-merge.c         | 17 ++++++++++----
 block/blk-wbt.c           |  5 ++--
 include/linux/bio.h       | 25 +++++++++++---------
 include/linux/blk_types.h |  2 ++
 include/linux/blkdev.h    |  6 +++++
 8 files changed, 99 insertions(+), 19 deletions(-)

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
index eea2465..31e211f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1942,6 +1942,10 @@ static inline int bio_check_eod(struct bio *bio, unsigned int nr_sectors)
 		if (!bdev_is_zoned(bio->bi_bdev))
 			goto not_supported;
 		break;
+	case REQ_OP_WRITE_ZEROES:
+		if (!blk_queue_write_zeroes(q))
+			goto not_supported;
+		break;
 	default:
 		break;
 	}
diff --git a/block/blk-lib.c b/block/blk-lib.c
index bfb28b0..b6db957 100644
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
+	if (!blk_queue_write_zeroes(q))
+		return -EOPNOTSUPP;
+
+	/* Ensure that max_write_zeroes_sectors doesn't overflow bi_size */
+	max_write_zeroes_sectors = UINT_MAX >> 9;
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
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 20712f0..83abaff 100644
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
index 13b2f2a..9c843ec 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -595,6 +595,7 @@ struct request_queue {
 #define QUEUE_FLAG_FLUSH_NQ    25	/* flush not queueuable */
 #define QUEUE_FLAG_DAX         26	/* device supports DAX */
 #define QUEUE_FLAG_STATS       27	/* track rq completion times */
+#define QUEUE_FLAG_WRITE_ZEROES 28	/* device supports write zeroes */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
@@ -685,6 +686,8 @@ static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
 #define blk_queue_secure_erase(q) \
 	(test_bit(QUEUE_FLAG_SECERASE, &(q)->queue_flags))
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
+#define blk_queue_write_zeroes(q) \
+	(test_bit(QUEUE_FLAG_WRITE_ZEROES, &(q)->queue_flags))
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
@@ -773,6 +776,9 @@ static inline bool rq_mergeable(struct request *rq)
 	if (req_op(rq) == REQ_OP_FLUSH)
 		return false;
 
+	if (req_op(rq) == REQ_OP_WRITE_ZEROES)
+		return false;
+
 	if (rq->cmd_flags & REQ_NOMERGE_FLAGS)
 		return false;
 	if (rq->rq_flags & RQF_NOMERGE_FLAGS)
-- 
1.8.3.1

