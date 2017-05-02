Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Tue, 02 May 2017 13:42:24 +1000
Subject: [PATCH 01/13] blk: remove bio_set arg from blk_queue_split()
Cc: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>,
 linux-kernel@vger.kernel.org
Message-ID: <149369654384.5146.13347645646156684946.stgit@noble>
In-Reply-To: <149369628671.5146.4865312503373040039.stgit@noble>
References: <149369628671.5146.4865312503373040039.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

blk_queue_split() is always called with the last arg being q->bio_split,
where 'q' is the first arg.

Also blk_queue_split() sometimes uses the passed-in 'bs' and sometimes uses
q->bio_split.

This is inconsistent and unnecessary.  Remove the last arg and always use
q->bio_split inside blk_queue_split()

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Credit-to: Javier González <jg@lightnvm.io> (Noticed that lightnvm was missed)
Signed-off-by: NeilBrown <neilb@suse.com>
---
 block/blk-core.c              |    2 +-
 block/blk-merge.c             |    9 ++++-----
 block/blk-mq.c                |    2 +-
 drivers/block/drbd/drbd_req.c |    2 +-
 drivers/block/pktcdvd.c       |    2 +-
 drivers/block/ps3vram.c       |    2 +-
 drivers/block/rsxx/dev.c      |    2 +-
 drivers/block/umem.c          |    2 +-
 drivers/block/zram/zram_drv.c |    2 +-
 drivers/lightnvm/pblk-init.c  |    4 ++--
 drivers/lightnvm/rrpc.c       |    2 +-
 drivers/md/md.c               |    2 +-
 drivers/s390/block/dcssblk.c  |    2 +-
 drivers/s390/block/xpram.c    |    2 +-
 include/linux/blkdev.h        |    3 +--
 15 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 24886b69690f..1a05c505964d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1663,7 +1663,7 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 	 */
 	blk_queue_bounce(q, &bio);
 
-	blk_queue_split(q, &bio, q->bio_split);
+	blk_queue_split(q, &bio);
 
 	if (bio_integrity_enabled(bio) && bio_integrity_prep(bio)) {
 		bio->bi_error = -EIO;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3990ae406341..d59074556703 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -202,8 +202,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	return do_split ? new : NULL;
 }
 
-void blk_queue_split(struct request_queue *q, struct bio **bio,
-		     struct bio_set *bs)
+void blk_queue_split(struct request_queue *q, struct bio **bio)
 {
 	struct bio *split, *res;
 	unsigned nsegs;
@@ -211,13 +210,13 @@ void blk_queue_split(struct request_queue *q, struct bio **bio,
 	switch (bio_op(*bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
-		split = blk_bio_discard_split(q, *bio, bs, &nsegs);
+		split = blk_bio_discard_split(q, *bio, q->bio_split, &nsegs);
 		break;
 	case REQ_OP_WRITE_ZEROES:
-		split = blk_bio_write_zeroes_split(q, *bio, bs, &nsegs);
+		split = blk_bio_write_zeroes_split(q, *bio, q->bio_split, &nsegs);
 		break;
 	case REQ_OP_WRITE_SAME:
-		split = blk_bio_write_same_split(q, *bio, bs, &nsegs);
+		split = blk_bio_write_same_split(q, *bio, q->bio_split, &nsegs);
 		break;
 	default:
 		split = blk_bio_segment_split(q, *bio, q->bio_split, &nsegs);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index bf90684a007a..45f084fb2052 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1543,7 +1543,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
-	blk_queue_split(q, &bio, q->bio_split);
+	blk_queue_split(q, &bio);
 
 	if (!is_flush_fua && !blk_queue_nomerges(q) &&
 	    blk_attempt_plug_merge(q, bio, &request_count, &same_queue_rq))
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index b5730e17b455..fa62dd8a4d46 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1557,7 +1557,7 @@ blk_qc_t drbd_make_request(struct request_queue *q, struct bio *bio)
 	struct drbd_device *device = (struct drbd_device *) q->queuedata;
 	unsigned long start_jif;
 
-	blk_queue_split(q, &bio, q->bio_split);
+	blk_queue_split(q, &bio);
 
 	start_jif = jiffies;
 
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 205b865ebeb9..1457e65c50b1 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2414,7 +2414,7 @@ static blk_qc_t pkt_make_request(struct request_queue *q, struct bio *bio)
 
 	blk_queue_bounce(q, &bio);
 
-	blk_queue_split(q, &bio, q->bio_split);
+	blk_queue_split(q, &bio);
 
 	pd = q->queuedata;
 	if (!pd) {
diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 456b4fe21559..48072c0c1010 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -606,7 +606,7 @@ static blk_qc_t ps3vram_make_request(struct request_queue *q, struct bio *bio)
 
 	dev_dbg(&dev->core, "%s\n", __func__);
 
-	blk_queue_split(q, &bio, q->bio_split);
+	blk_queue_split(q, &bio);
 
 	spin_lock_irq(&priv->lock);
 	busy = !bio_list_empty(&priv->list);
diff --git a/drivers/block/rsxx/dev.c b/drivers/block/rsxx/dev.c
index 9c566364ac9c..01624eaefcba 100644
--- a/drivers/block/rsxx/dev.c
+++ b/drivers/block/rsxx/dev.c
@@ -151,7 +151,7 @@ static blk_qc_t rsxx_make_request(struct request_queue *q, struct bio *bio)
 	struct rsxx_bio_meta *bio_meta;
 	int st = -EINVAL;
 
-	blk_queue_split(q, &bio, q->bio_split);
+	blk_queue_split(q, &bio);
 
 	might_sleep();
 
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index c141cc3be22b..c8d8a2f16f8e 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -529,7 +529,7 @@ static blk_qc_t mm_make_request(struct request_queue *q, struct bio *bio)
 		 (unsigned long long)bio->bi_iter.bi_sector,
 		 bio->bi_iter.bi_size);
 
-	blk_queue_split(q, &bio, q->bio_split);
+	blk_queue_split(q, &bio);
 
 	spin_lock_irq(&card->lock);
 	*card->biotail = bio;
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6fac5fedd610..4297d19621bf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -884,7 +884,7 @@ static blk_qc_t zram_make_request(struct request_queue *queue, struct bio *bio)
 {
 	struct zram *zram = queue->queuedata;
 
-	blk_queue_split(queue, &bio, queue->bio_split);
+	blk_queue_split(queue, &bio);
 
 	if (!valid_io_request(zram, bio->bi_iter.bi_sector,
 					bio->bi_iter.bi_size)) {
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index ae8cd6d5af8b..b3fec8ec55b8 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -33,7 +33,7 @@ static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
 	 * constraint. Writes can be of arbitrary size.
 	 */
 	if (bio_data_dir(bio) == READ) {
-		blk_queue_split(q, &bio, q->bio_split);
+		blk_queue_split(q, &bio);
 		ret = pblk_submit_read(pblk, bio);
 		if (ret == NVM_IO_DONE && bio_flagged(bio, BIO_CLONED))
 			bio_put(bio);
@@ -46,7 +46,7 @@ static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
 	 * available for user I/O.
 	 */
 	if (unlikely(pblk_get_secs(bio) >= pblk_rl_sysfs_rate_show(&pblk->rl)))
-		blk_queue_split(q, &bio, q->bio_split);
+		blk_queue_split(q, &bio);
 
 	return pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
 }
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index cf0e28a0ff61..8e241056b141 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -994,7 +994,7 @@ static blk_qc_t rrpc_make_rq(struct request_queue *q, struct bio *bio)
 	struct nvm_rq *rqd;
 	int err;
 
-	blk_queue_split(q, &bio, q->bio_split);
+	blk_queue_split(q, &bio);
 
 	if (bio_op(bio) == REQ_OP_DISCARD) {
 		rrpc_discard(rrpc, bio);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 82f798be964f..de78e74c8e01 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -265,7 +265,7 @@ static blk_qc_t md_make_request(struct request_queue *q, struct bio *bio)
 	unsigned int sectors;
 	int cpu;
 
-	blk_queue_split(q, &bio, q->bio_split);
+	blk_queue_split(q, &bio);
 
 	if (mddev == NULL || mddev->pers == NULL) {
 		bio_io_error(bio);
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 415d10a67b7a..10ece6f3c7eb 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -829,7 +829,7 @@ dcssblk_make_request(struct request_queue *q, struct bio *bio)
 	unsigned long source_addr;
 	unsigned long bytes_done;
 
-	blk_queue_split(q, &bio, q->bio_split);
+	blk_queue_split(q, &bio);
 
 	bytes_done = 0;
 	dev_info = bio->bi_bdev->bd_disk->private_data;
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index b9d7e755c8a3..a48f0d40c1d2 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -190,7 +190,7 @@ static blk_qc_t xpram_make_request(struct request_queue *q, struct bio *bio)
 	unsigned long page_addr;
 	unsigned long bytes;
 
-	blk_queue_split(q, &bio, q->bio_split);
+	blk_queue_split(q, &bio);
 
 	if ((bio->bi_iter.bi_sector & 7) != 0 ||
 	    (bio->bi_iter.bi_size & 4095) != 0)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 83d28623645f..f380d8b86e7e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -941,8 +941,7 @@ extern int blk_insert_cloned_request(struct request_queue *q,
 				     struct request *rq);
 extern int blk_rq_append_bio(struct request *rq, struct bio *bio);
 extern void blk_delay_queue(struct request_queue *, unsigned long);
-extern void blk_queue_split(struct request_queue *, struct bio **,
-			    struct bio_set *);
+extern void blk_queue_split(struct request_queue *, struct bio **);
 extern void blk_recount_segments(struct request_queue *, struct bio *);
 extern int scsi_verify_blk_ioctl(struct block_device *, unsigned int);
 extern int scsi_cmd_blk_ioctl(struct block_device *, fmode_t,
