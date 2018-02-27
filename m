Return-Path: <jiufei.xue@linux.alibaba.com>
From: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Subject: [PATCH 2/4] block: bio_check_eod() needs to consider partition
To: Christoph Hellwig <hch@lst.de>, Shaohua Li <shli@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>, caspar@linux.alibaba.com,
 Joseph Qi <joseph.qi@linux.alibaba.com>
References: <014d8f0c-31db-c18b-855e-5e425b9499be@linux.alibaba.com>
Message-ID: <20096c45-3e41-f24a-9fd6-f733f6d7c78e@linux.alibaba.com>
Date: Tue, 27 Feb 2018 20:11:12 +0800
MIME-Version: 1.0
In-Reply-To: <014d8f0c-31db-c18b-855e-5e425b9499be@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

bio_check_eod() should check partiton size not the whole
disk if bio->bi_partno is not zero.

Fixes: 74d46992e0d9 ("block: replace bi_bdev with a gendisk pointer and partitions index")
Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
---
 block/blk-core.c | 79 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6d82c4f..5fb5278 100644
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
@@ -2093,11 +2093,45 @@ static noinline int should_fail_bio(struct bio *bio)
 ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
 
 /*
+ * Check whether this bio extends beyond the end of the device.
+ */
+static inline int bio_check_eod(struct bio *bio, unsigned int nr_sectors,
+				struct hd_struct *part)
+{
+	sector_t maxsector;
+
+	if (!nr_sectors)
+		return 0;
+
+	/* Test device or partition size, when known. */
+	if (part->partno)
+		maxsector = part_nr_sects_read(part);
+	else
+		maxsector = get_capacity(bio->bi_disk);
+	if (maxsector) {
+		sector_t sector = bio->bi_iter.bi_sector;
+
+		if (maxsector < nr_sectors || maxsector - nr_sectors < sector) {
+			/*
+			 * This may well happen - the kernel calls bread()
+			 * without checking the size of the device, e.g., when
+			 * mounting a device.
+			 */
+			handle_bad_sector(bio, maxsector);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+/*
  * Remap block n of partition p to block n+start(p) of the disk.
  */
 static inline int blk_partition_remap(struct bio *bio)
 {
 	struct hd_struct *p;
+	int nr_sectors = bio_sectors(bio);
 	int ret = 0;
 
 	rcu_read_lock();
@@ -2108,11 +2142,16 @@ static inline int blk_partition_remap(struct bio *bio)
 		goto out;
 	}
 
+	if (bio_check_eod(bio, nr_sectors, p)) {
+		ret = -EIO;
+		goto out;
+	}
+
 	/*
 	 * Zone reset does not include bi_size so bio_sectors() is always 0.
 	 * Include a test for the reset op code and perform the remap if needed.
 	 */
-	if (!bio_sectors(bio) && bio_op(bio) != REQ_OP_ZONE_RESET)
+	if (!nr_sectors && bio_op(bio) != REQ_OP_ZONE_RESET)
 		goto out;
 
 	bio->bi_iter.bi_sector += p->start_sect;
@@ -2125,35 +2164,6 @@ static inline int blk_partition_remap(struct bio *bio)
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
@@ -2164,9 +2174,6 @@ static inline int bio_check_eod(struct bio *bio, unsigned int nr_sectors)
 
 	might_sleep();
 
-	if (bio_check_eod(bio, nr_sectors))
-		goto end_io;
-
 	q = bio->bi_disk->queue;
 	if (unlikely(!q)) {
 		printk(KERN_ERR
@@ -2194,7 +2201,7 @@ static inline int bio_check_eod(struct bio *bio, unsigned int nr_sectors)
 			goto end_io;
 	}
 
-	if (bio_check_eod(bio, nr_sectors))
+	if (bio_check_eod(bio, nr_sectors, &bio->bi_disk->part0))
 		goto end_io;
 
 	/*
-- 
1.9.4
