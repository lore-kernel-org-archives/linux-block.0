Return-Path: <hch@lst.de>
Date: Wed, 28 Feb 2018 18:48:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Shaohua Li <shli@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>, caspar@linux.alibaba.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 2/4] block: bio_check_eod() needs to consider partition
Message-ID: <20180228174809.GA18158@lst.de>
References: <014d8f0c-31db-c18b-855e-5e425b9499be@linux.alibaba.com> <20096c45-3e41-f24a-9fd6-f733f6d7c78e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20096c45-3e41-f24a-9fd6-f733f6d7c78e@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

Hmm.  I'd rather just kill off bio_check_eod and move the check
to blk_partition_remap so that we only have to check once.

What do you think of this version?  Probably needs to be split into
one or two prep patches and the real change.

diff --git a/block/blk-core.c b/block/blk-core.c
index 3ba4326a63b5..36a3cb042ca7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2009,7 +2009,7 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 	return BLK_QC_T_NONE;
 }
 
-static void handle_bad_sector(struct bio *bio)
+static void handle_bad_sector(struct bio *bio, sector_t maxsector)
 {
 	char b[BDEVNAME_SIZE];
 
@@ -2017,7 +2017,7 @@ static void handle_bad_sector(struct bio *bio)
 	printk(KERN_INFO "%s: rw=%d, want=%Lu, limit=%Lu\n",
 			bio_devname(bio, b), bio->bi_opf,
 			(unsigned long long)bio_end_sector(bio),
-			(long long)get_capacity(bio->bi_disk));
+			(long long)maxsector);
 }
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
@@ -2060,57 +2060,47 @@ static inline bool should_fail_request(struct hd_struct *part,
  */
 static inline int blk_partition_remap(struct bio *bio)
 {
-	struct hd_struct *p;
-	int ret = 0;
+	sector_t maxsector = get_capacity(bio->bi_disk);
+	int nr_sectors = bio_sectors(bio);
 
 	/*
 	 * Zone reset does not include bi_size so bio_sectors() is always 0.
 	 * Include a test for the reset op code and perform the remap if needed.
 	 */
-	if (!bio->bi_partno ||
-	    (!bio_sectors(bio) && bio_op(bio) != REQ_OP_ZONE_RESET))
+	if (!nr_sectors && bio_op(bio) != REQ_OP_ZONE_RESET)
 		return 0;
 
-	rcu_read_lock();
-	p = __disk_get_part(bio->bi_disk, bio->bi_partno);
-	if (likely(p && !should_fail_request(p, bio->bi_iter.bi_size))) {
+	if (bio->bi_partno) {
+		struct hd_struct *p;
+
+		rcu_read_lock();
+		p = __disk_get_part(bio->bi_disk, bio->bi_partno);
+		if (unlikely(!p ||
+			     should_fail_request(p, bio->bi_iter.bi_size))) {
+			rcu_read_unlock();
+			pr_info("%s: fail for partition %d\n",
+				__func__, bio->bi_partno);
+			return -EIO;
+		}
+
 		bio->bi_iter.bi_sector += p->start_sect;
 		bio->bi_partno = 0;
 		trace_block_bio_remap(bio->bi_disk->queue, bio, part_devt(p),
 				bio->bi_iter.bi_sector - p->start_sect);
-	} else {
-		printk("%s: fail for partition %d\n", __func__, bio->bi_partno);
-		ret = -EIO;
+		maxsector = part_nr_sects_read(p);
+		rcu_read_unlock();
 	}
-	rcu_read_unlock();
 
-	return ret;
-}
-
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
+	/*
+	 * Check whether this bio extends beyond the end of the device or
+	 * partition.  This may well happen - the kernel calls bread() without
+	 * checking the size of the device, e.g., when mounting a file system.
+	 */
+	if (nr_sectors && maxsector &&
+	    (nr_sectors > maxsector ||
+	     bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
+		handle_bad_sector(bio, maxsector);
+		return -EIO;
 	}
 
 	return 0;
@@ -2126,9 +2116,6 @@ generic_make_request_checks(struct bio *bio)
 
 	might_sleep();
 
-	if (bio_check_eod(bio, nr_sectors))
-		goto end_io;
-
 	q = bio->bi_disk->queue;
 	if (unlikely(!q)) {
 		printk(KERN_ERR
@@ -2152,9 +2139,6 @@ generic_make_request_checks(struct bio *bio)
 	if (blk_partition_remap(bio))
 		goto end_io;
 
-	if (bio_check_eod(bio, nr_sectors))
-		goto end_io;
-
 	/*
 	 * Filter flush bio's early so that make_request based
 	 * drivers without flush support don't have to worry
