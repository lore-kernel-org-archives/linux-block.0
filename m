Return-Path: <BATV+f6fb34e83e736936479f+5316+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: jiufei.xue@linux.alibaba.com,
	Bart.VanAssche@wdc.com,
	linux-block@vger.kernel.org
Subject: [PATCH v3] block: bio_check_eod() needs to consider partitions
Date: Wed, 14 Mar 2018 16:56:53 +0100
Message-Id: <20180314155653.14861-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

bio_check_eod() should check partiton size not the whole disk if
bio->bi_partno is non-zero.  Does this by taking the call to bio_check_eod
into blk_partition_remap.

Based on an earlier patch from Jiufei Xue.

Fixes: 74d46992e0d9 ("block: replace bi_bdev with a gendisk pointer and partitions index")
Reported-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 93 ++++++++++++++++++++++++--------------------------------
 1 file changed, 40 insertions(+), 53 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6d82c4f7fadd..47ee24611126 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2023,7 +2023,7 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 	return BLK_QC_T_NONE;
 }
 
-static void handle_bad_sector(struct bio *bio)
+static void handle_bad_sector(struct bio *bio, sector_t maxsector)
 {
 	char b[BDEVNAME_SIZE];
 
@@ -2031,7 +2031,7 @@ static void handle_bad_sector(struct bio *bio)
 	printk(KERN_INFO "%s: rw=%d, want=%Lu, limit=%Lu\n",
 			bio_devname(bio, b), bio->bi_opf,
 			(unsigned long long)bio_end_sector(bio),
-			(long long)get_capacity(bio->bi_disk));
+			(long long)maxsector);
 }
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
@@ -2092,68 +2092,59 @@ static noinline int should_fail_bio(struct bio *bio)
 }
 ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
 
+/*
+ * Check whether this bio extends beyond the end of the device or partition.
+ * This may well happen - the kernel calls bread() without checking the size of
+ * the device, e.g., when mounting a file system.
+ */
+static inline int bio_check_eod(struct bio *bio, sector_t maxsector)
+{
+	unsigned int nr_sectors = bio_sectors(bio);
+
+	if (nr_sectors && maxsector &&
+	    (nr_sectors > maxsector ||
+	     bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
+		handle_bad_sector(bio, maxsector);
+		return -EIO;
+	}
+	return 0;
+}
+
 /*
  * Remap block n of partition p to block n+start(p) of the disk.
  */
 static inline int blk_partition_remap(struct bio *bio)
 {
 	struct hd_struct *p;
-	int ret = 0;
+	int ret = -EIO;
 
 	rcu_read_lock();
 	p = __disk_get_part(bio->bi_disk, bio->bi_partno);
-	if (unlikely(!p || should_fail_request(p, bio->bi_iter.bi_size) ||
-		     bio_check_ro(bio, p))) {
-		ret = -EIO;
+	if (unlikely(!p))
+		goto out;
+	if (unlikely(should_fail_request(p, bio->bi_iter.bi_size)))
+		goto out;
+	if (unlikely(bio_check_ro(bio, p)))
 		goto out;
-	}
 
 	/*
 	 * Zone reset does not include bi_size so bio_sectors() is always 0.
 	 * Include a test for the reset op code and perform the remap if needed.
 	 */
-	if (!bio_sectors(bio) && bio_op(bio) != REQ_OP_ZONE_RESET)
-		goto out;
-
-	bio->bi_iter.bi_sector += p->start_sect;
-	bio->bi_partno = 0;
-	trace_block_bio_remap(bio->bi_disk->queue, bio, part_devt(p),
-			      bio->bi_iter.bi_sector - p->start_sect);
-
+	if (bio_sectors(bio) || bio_op(bio) == REQ_OP_ZONE_RESET) {
+		if (bio_check_eod(bio, part_nr_sects_read(p)))
+			goto out;
+		bio->bi_iter.bi_sector += p->start_sect;
+		bio->bi_partno = 0;
+		trace_block_bio_remap(bio->bi_disk->queue, bio, part_devt(p),
+				      bio->bi_iter.bi_sector - p->start_sect);
+	}
+	ret = 0;
 out:
 	rcu_read_unlock();
 	return ret;
 }
 
-/*
- * Check whether this bio extends beyond the end of the device.
- */
-static inline int bio_check_eod(struct bio *bio, unsigned int nr_sectors)
-{
-	sector_t maxsector;
-
-	if (!nr_sectors)
-		return 0;
-
-	/* Test device or partition size, when known. */
-	maxsector = get_capacity(bio->bi_disk);
-	if (maxsector) {
-		sector_t sector = bio->bi_iter.bi_sector;
-
-		if (maxsector < nr_sectors || maxsector - nr_sectors < sector) {
-			/*
-			 * This may well happen - the kernel calls bread()
-			 * without checking the size of the device, e.g., when
-			 * mounting a device.
-			 */
-			handle_bad_sector(bio);
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
 static noinline_for_stack bool
 generic_make_request_checks(struct bio *bio)
 {
@@ -2164,9 +2155,6 @@ generic_make_request_checks(struct bio *bio)
 
 	might_sleep();
 
-	if (bio_check_eod(bio, nr_sectors))
-		goto end_io;
-
 	q = bio->bi_disk->queue;
 	if (unlikely(!q)) {
 		printk(KERN_ERR
@@ -2186,17 +2174,16 @@ generic_make_request_checks(struct bio *bio)
 	if (should_fail_bio(bio))
 		goto end_io;
 
-	if (!bio->bi_partno) {
-		if (unlikely(bio_check_ro(bio, &bio->bi_disk->part0)))
+	if (bio->bi_partno) {
+		if (unlikely(blk_partition_remap(bio)))
 			goto end_io;
 	} else {
-		if (blk_partition_remap(bio))
+		if (unlikely(bio_check_ro(bio, &bio->bi_disk->part0)))
+			goto end_io;
+		if (unlikely(bio_check_eod(bio, get_capacity(bio->bi_disk))))
 			goto end_io;
 	}
 
-	if (bio_check_eod(bio, nr_sectors))
-		goto end_io;
-
 	/*
 	 * Filter flush bio's early so that make_request based
 	 * drivers without flush support don't have to worry
-- 
2.14.2
