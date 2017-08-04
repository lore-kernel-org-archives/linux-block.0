Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: brking@linux.vnet.ibm.com,
	bart.vanassche@wdc.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/6] block: pass in queue to inflight accounting
Date: Fri,  4 Aug 2017 09:04:18 -0600
Message-Id: <1501859062-11120-3-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

No functional change in this patch, just in preparation for
basing the inflight mechanism on the queue in question.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 block/bio.c                   | 16 ++++++++--------
 block/blk-core.c              | 22 ++++++++++++----------
 block/blk-merge.c             |  4 ++--
 block/genhd.c                 |  4 ++--
 block/partition-generic.c     |  5 +++--
 drivers/block/drbd/drbd_req.c | 10 +++++++---
 drivers/block/rsxx/dev.c      |  6 +++---
 drivers/block/zram/zram_drv.c |  5 +++--
 drivers/md/bcache/request.c   |  7 ++++---
 drivers/md/dm.c               |  6 +++---
 drivers/nvdimm/nd.h           |  5 +++--
 include/linux/bio.h           |  9 +++++----
 include/linux/genhd.h         | 14 +++++++++-----
 13 files changed, 64 insertions(+), 49 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e241bbc49f14..ecd1a9c7a301 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1736,29 +1736,29 @@ void bio_check_pages_dirty(struct bio *bio)
 	}
 }
 
-void generic_start_io_acct(int rw, unsigned long sectors,
-			   struct hd_struct *part)
+void generic_start_io_acct(struct request_queue *q, int rw,
+			   unsigned long sectors, struct hd_struct *part)
 {
 	int cpu = part_stat_lock();
 
-	part_round_stats(cpu, part);
+	part_round_stats(q, cpu, part);
 	part_stat_inc(cpu, part, ios[rw]);
 	part_stat_add(cpu, part, sectors[rw], sectors);
-	part_inc_in_flight(part, rw);
+	part_inc_in_flight(q, part, rw);
 
 	part_stat_unlock();
 }
 EXPORT_SYMBOL(generic_start_io_acct);
 
-void generic_end_io_acct(int rw, struct hd_struct *part,
-			 unsigned long start_time)
+void generic_end_io_acct(struct request_queue *q, int rw,
+			 struct hd_struct *part, unsigned long start_time)
 {
 	unsigned long duration = jiffies - start_time;
 	int cpu = part_stat_lock();
 
 	part_stat_add(cpu, part, ticks[rw], duration);
-	part_round_stats(cpu, part);
-	part_dec_in_flight(part, rw);
+	part_round_stats(q, cpu, part);
+	part_dec_in_flight(q, part, rw);
 
 	part_stat_unlock();
 }
diff --git a/block/blk-core.c b/block/blk-core.c
index dbecbf4a64e0..8ee954c12e9d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1469,15 +1469,15 @@ static void add_acct_request(struct request_queue *q, struct request *rq,
 	__elv_add_request(q, rq, where);
 }
 
-static void part_round_stats_single(int cpu, struct hd_struct *part,
-				    unsigned long now)
+static void part_round_stats_single(struct request_queue *q, int cpu,
+				    struct hd_struct *part, unsigned long now)
 {
 	int inflight;
 
 	if (now == part->stamp)
 		return;
 
-	inflight = part_in_flight(part);
+	inflight = part_in_flight(q, part);
 	if (inflight) {
 		__part_stat_add(cpu, part, time_in_queue,
 				inflight * (now - part->stamp));
@@ -1488,6 +1488,7 @@ static void part_round_stats_single(int cpu, struct hd_struct *part,
 
 /**
  * part_round_stats() - Round off the performance stats on a struct disk_stats.
+ * @q: target block queue
  * @cpu: cpu number for stats access
  * @part: target partition
  *
@@ -1502,13 +1503,14 @@ static void part_round_stats_single(int cpu, struct hd_struct *part,
  * /proc/diskstats.  This accounts immediately for all queue usage up to
  * the current jiffies and restarts the counters again.
  */
-void part_round_stats(int cpu, struct hd_struct *part)
+void part_round_stats(struct request_queue *q, int cpu, struct hd_struct *part)
 {
 	unsigned long now = jiffies;
 
 	if (part->partno)
-		part_round_stats_single(cpu, &part_to_disk(part)->part0, now);
-	part_round_stats_single(cpu, part, now);
+		part_round_stats_single(q, cpu, &part_to_disk(part)->part0,
+						now);
+	part_round_stats_single(q, cpu, part, now);
 }
 EXPORT_SYMBOL_GPL(part_round_stats);
 
@@ -2431,8 +2433,8 @@ void blk_account_io_done(struct request *req)
 
 		part_stat_inc(cpu, part, ios[rw]);
 		part_stat_add(cpu, part, ticks[rw], duration);
-		part_round_stats(cpu, part);
-		part_dec_in_flight(part, rw);
+		part_round_stats(req->q, cpu, part);
+		part_dec_in_flight(req->q, part, rw);
 
 		hd_struct_put(part);
 		part_stat_unlock();
@@ -2489,8 +2491,8 @@ void blk_account_io_start(struct request *rq, bool new_io)
 			part = &rq->rq_disk->part0;
 			hd_struct_get(part);
 		}
-		part_round_stats(cpu, part);
-		part_inc_in_flight(part, rw);
+		part_round_stats(rq->q, cpu, part);
+		part_inc_in_flight(rq->q, part, rw);
 		rq->part = part;
 	}
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 99038830fb42..05f116bfb99d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -633,8 +633,8 @@ static void blk_account_io_merge(struct request *req)
 		cpu = part_stat_lock();
 		part = req->part;
 
-		part_round_stats(cpu, part);
-		part_dec_in_flight(part, rq_data_dir(req));
+		part_round_stats(req->q, cpu, part);
+		part_dec_in_flight(req->q, part, rq_data_dir(req));
 
 		hd_struct_put(part);
 		part_stat_unlock();
diff --git a/block/genhd.c b/block/genhd.c
index 7f520fa25d16..f735af67a0c9 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1217,7 +1217,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	disk_part_iter_init(&piter, gp, DISK_PITER_INCL_EMPTY_PART0);
 	while ((hd = disk_part_iter_next(&piter))) {
 		cpu = part_stat_lock();
-		part_round_stats(cpu, hd);
+		part_round_stats(gp->queue, cpu, hd);
 		part_stat_unlock();
 		seq_printf(seqf, "%4d %7d %s %lu %lu %lu "
 			   "%u %lu %lu %lu %u %u %u %u\n",
@@ -1231,7 +1231,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   part_stat_read(hd, merges[WRITE]),
 			   part_stat_read(hd, sectors[WRITE]),
 			   jiffies_to_msecs(part_stat_read(hd, ticks[WRITE])),
-			   part_in_flight(hd),
+			   part_in_flight(gp->queue, hd),
 			   jiffies_to_msecs(part_stat_read(hd, io_ticks)),
 			   jiffies_to_msecs(part_stat_read(hd, time_in_queue))
 			);
diff --git a/block/partition-generic.c b/block/partition-generic.c
index c5ec8246e25e..d1bdd61e1d71 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -112,10 +112,11 @@ ssize_t part_stat_show(struct device *dev,
 		       struct device_attribute *attr, char *buf)
 {
 	struct hd_struct *p = dev_to_part(dev);
+	struct request_queue *q = dev_to_disk(dev)->queue;
 	int cpu;
 
 	cpu = part_stat_lock();
-	part_round_stats(cpu, p);
+	part_round_stats(q, cpu, p);
 	part_stat_unlock();
 	return sprintf(buf,
 		"%8lu %8lu %8llu %8u "
@@ -130,7 +131,7 @@ ssize_t part_stat_show(struct device *dev,
 		part_stat_read(p, merges[WRITE]),
 		(unsigned long long)part_stat_read(p, sectors[WRITE]),
 		jiffies_to_msecs(part_stat_read(p, ticks[WRITE])),
-		part_in_flight(p),
+		part_in_flight(q, p),
 		jiffies_to_msecs(part_stat_read(p, io_ticks)),
 		jiffies_to_msecs(part_stat_read(p, time_in_queue)));
 }
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index f6e865b2d543..8d6b5d137b5e 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -36,14 +36,18 @@ static bool drbd_may_do_local_read(struct drbd_device *device, sector_t sector,
 /* Update disk stats at start of I/O request */
 static void _drbd_start_io_acct(struct drbd_device *device, struct drbd_request *req)
 {
-	generic_start_io_acct(bio_data_dir(req->master_bio), req->i.size >> 9,
-			      &device->vdisk->part0);
+	struct request_queue *q = device->rq_queue;
+
+	generic_start_io_acct(q, bio_data_dir(req->master_bio),
+				req->i.size >> 9, &device->vdisk->part0);
 }
 
 /* Update disk stats when completing request upwards */
 static void _drbd_end_io_acct(struct drbd_device *device, struct drbd_request *req)
 {
-	generic_end_io_acct(bio_data_dir(req->master_bio),
+	struct request_queue *q = device->rq_queue;
+
+	generic_end_io_acct(q, bio_data_dir(req->master_bio),
 			    &device->vdisk->part0, req->start_jif);
 }
 
diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index 7f4acebf4657..e397d3ee7308 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -112,7 +112,7 @@ static const struct block_device_operations rsxx_fops = {
 
 static void disk_stats_start(struct rsxx_cardinfo *card, struct bio *bio)
 {
-	generic_start_io_acct(bio_data_dir(bio), bio_sectors(bio),
+	generic_start_io_acct(card->queue, bio_data_dir(bio), bio_sectors(bio),
 			     &card->gendisk->part0);
 }
 
@@ -120,8 +120,8 @@ static void disk_stats_complete(struct rsxx_cardinfo *card,
 				struct bio *bio,
 				unsigned long start_time)
 {
-	generic_end_io_acct(bio_data_dir(bio), &card->gendisk->part0,
-			   start_time);
+	generic_end_io_acct(card->queue, bio_data_dir(bio),
+				&card->gendisk->part0, start_time);
 }
 
 static void bio_dma_done_cb(struct rsxx_cardinfo *card,
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 856d5dc02451..1c3383b4a0cf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -813,9 +813,10 @@ static int zram_bvec_rw(struct zram *zram, struct bio_vec *bvec, u32 index,
 {
 	unsigned long start_time = jiffies;
 	int rw_acct = is_write ? REQ_OP_WRITE : REQ_OP_READ;
+	struct request_queue *q = zram->disk->queue;
 	int ret;
 
-	generic_start_io_acct(rw_acct, bvec->bv_len >> SECTOR_SHIFT,
+	generic_start_io_acct(q, rw_acct, bvec->bv_len >> SECTOR_SHIFT,
 			&zram->disk->part0);
 
 	if (!is_write) {
@@ -827,7 +828,7 @@ static int zram_bvec_rw(struct zram *zram, struct bio_vec *bvec, u32 index,
 		ret = zram_bvec_write(zram, bvec, index, offset);
 	}
 
-	generic_end_io_acct(rw_acct, &zram->disk->part0, start_time);
+	generic_end_io_acct(q, rw_acct, &zram->disk->part0, start_time);
 
 	if (unlikely(ret)) {
 		if (!is_write)
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 019b3df9f1c6..72eb97176403 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -607,7 +607,8 @@ static void request_endio(struct bio *bio)
 static void bio_complete(struct search *s)
 {
 	if (s->orig_bio) {
-		generic_end_io_acct(bio_data_dir(s->orig_bio),
+		struct request_queue *q = bdev_get_queue(s->orig_bio->bi_bdev);
+		generic_end_io_acct(q, bio_data_dir(s->orig_bio),
 				    &s->d->disk->part0, s->start_time);
 
 		trace_bcache_request_end(s->d, s->orig_bio);
@@ -959,7 +960,7 @@ static blk_qc_t cached_dev_make_request(struct request_queue *q,
 	struct cached_dev *dc = container_of(d, struct cached_dev, disk);
 	int rw = bio_data_dir(bio);
 
-	generic_start_io_acct(rw, bio_sectors(bio), &d->disk->part0);
+	generic_start_io_acct(q, rw, bio_sectors(bio), &d->disk->part0);
 
 	bio->bi_bdev = dc->bdev;
 	bio->bi_iter.bi_sector += dc->sb.data_offset;
@@ -1074,7 +1075,7 @@ static blk_qc_t flash_dev_make_request(struct request_queue *q,
 	struct bcache_device *d = bio->bi_bdev->bd_disk->private_data;
 	int rw = bio_data_dir(bio);
 
-	generic_start_io_acct(rw, bio_sectors(bio), &d->disk->part0);
+	generic_start_io_acct(q, rw, bio_sectors(bio), &d->disk->part0);
 
 	s = search_alloc(bio, d);
 	cl = &s->cl;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 2edbcc2d7d3f..8612a2d1ccd9 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -520,7 +520,7 @@ static void start_io_acct(struct dm_io *io)
 	io->start_time = jiffies;
 
 	cpu = part_stat_lock();
-	part_round_stats(cpu, &dm_disk(md)->part0);
+	part_round_stats(md->queue, cpu, &dm_disk(md)->part0);
 	part_stat_unlock();
 	atomic_set(&dm_disk(md)->part0.in_flight[rw],
 		atomic_inc_return(&md->pending[rw]));
@@ -539,7 +539,7 @@ static void end_io_acct(struct dm_io *io)
 	int pending;
 	int rw = bio_data_dir(bio);
 
-	generic_end_io_acct(rw, &dm_disk(md)->part0, io->start_time);
+	generic_end_io_acct(md->queue, rw, &dm_disk(md)->part0, io->start_time);
 
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
@@ -1542,7 +1542,7 @@ static blk_qc_t dm_make_request(struct request_queue *q, struct bio *bio)
 
 	map = dm_get_live_table(md, &srcu_idx);
 
-	generic_start_io_acct(rw, bio_sectors(bio), &dm_disk(md)->part0);
+	generic_start_io_acct(q, rw, bio_sectors(bio), &dm_disk(md)->part0);
 
 	/* if we're suspended, we have to queue this io for later */
 	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags))) {
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index e1b5715bd91f..73062da3177f 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -396,7 +396,7 @@ static inline bool nd_iostat_start(struct bio *bio, unsigned long *start)
 		return false;
 
 	*start = jiffies;
-	generic_start_io_acct(bio_data_dir(bio),
+	generic_start_io_acct(disk->queue, bio_data_dir(bio),
 			      bio_sectors(bio), &disk->part0);
 	return true;
 }
@@ -404,7 +404,8 @@ static inline void nd_iostat_end(struct bio *bio, unsigned long start)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 
-	generic_end_io_acct(bio_data_dir(bio), &disk->part0, start);
+	generic_end_io_acct(disk->queue, bio_data_dir(bio), &disk->part0,
+				start);
 }
 static inline bool is_bad_pmem(struct badblocks *bb, sector_t sector,
 		unsigned int len)
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7b1cf4ba0902..9276788a9b24 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -463,10 +463,11 @@ extern struct bio *bio_copy_kern(struct request_queue *, void *, unsigned int,
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
 
-void generic_start_io_acct(int rw, unsigned long sectors,
-			   struct hd_struct *part);
-void generic_end_io_acct(int rw, struct hd_struct *part,
-			 unsigned long start_time);
+void generic_start_io_acct(struct request_queue *q, int rw,
+				unsigned long sectors, struct hd_struct *part);
+void generic_end_io_acct(struct request_queue *q, int rw,
+				struct hd_struct *part,
+				unsigned long start_time);
 
 #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
 # error	"You should define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE for your platform"
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index e619fae2f037..7f7427e00f9c 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -362,23 +362,27 @@ static inline void free_part_stats(struct hd_struct *part)
 #define part_stat_sub(cpu, gendiskp, field, subnd)			\
 	part_stat_add(cpu, gendiskp, field, -subnd)
 
-static inline void part_inc_in_flight(struct hd_struct *part, int rw)
+static inline void part_inc_in_flight(struct request_queue *q,
+				      struct hd_struct *part, int rw)
 {
 	atomic_inc(&part->in_flight[rw]);
 	if (part->partno)
 		atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
 }
 
-static inline void part_dec_in_flight(struct hd_struct *part, int rw)
+static inline void part_dec_in_flight(struct request_queue *q,
+				      struct hd_struct *part, int rw)
 {
 	atomic_dec(&part->in_flight[rw]);
 	if (part->partno)
 		atomic_dec(&part_to_disk(part)->part0.in_flight[rw]);
 }
 
-static inline int part_in_flight(struct hd_struct *part)
+static inline int part_in_flight(struct request_queue *q,
+				 struct hd_struct *part)
 {
-	return atomic_read(&part->in_flight[0]) + atomic_read(&part->in_flight[1]);
+	return atomic_read(&part->in_flight[0]) +
+			atomic_read(&part->in_flight[1]);
 }
 
 static inline struct partition_meta_info *alloc_part_info(struct gendisk *disk)
@@ -395,7 +399,7 @@ static inline void free_part_info(struct hd_struct *part)
 }
 
 /* block/blk-core.c */
-extern void part_round_stats(int cpu, struct hd_struct *part);
+extern void part_round_stats(struct request_queue *q, int cpu, struct hd_struct *part);
 
 /* block/genhd.c */
 extern void device_add_disk(struct device *parent, struct gendisk *disk);
-- 
2.7.4
