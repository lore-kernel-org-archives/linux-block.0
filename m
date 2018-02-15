Return-Path: <jpittman@redhat.com>
From: John Pittman <jpittman@redhat.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Pittman <jpittman@redhat.com>
Subject: [PATCH] block: Change 'unsigned' to 'unsigned int' throughout block layer
Date: Wed, 14 Feb 2018 20:37:02 -0500
Message-Id: <1518658622-5931-1-git-send-email-jpittman@redhat.com>
List-ID: <linux-block@vger.kernel.org>

In quite a few files throughout the block layer, the bare 'unsigned' is
used rather than the preferred 'unsigned int'.  The issue was
exposed by checkpatch.pl.  Warnings encountered were:

    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
    WARNING: Prefer 'unsigned int *' to bare use of 'unsigned *'

Fixed 64 total warnings.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 block/badblocks.c            |  4 ++--
 block/bio-integrity.c        |  4 ++--
 block/bio.c                  |  8 ++++----
 block/blk-core.c             |  2 +-
 block/blk-lib.c              |  6 +++---
 block/blk-merge.c            | 24 ++++++++++++------------
 block/blk-mq-sched.c         |  2 +-
 block/blk-mq.c               |  6 +++---
 block/blk-tag.c              |  4 ++--
 block/bounce.c               |  2 +-
 block/cfq-iosched.c          | 22 +++++++++++-----------
 block/compat_ioctl.c         |  4 ++--
 block/genhd.c                |  2 +-
 block/ioctl.c                |  8 ++++----
 block/kyber-iosched.c        |  8 ++++----
 block/partitions/efi.c       |  8 ++++----
 block/partitions/mac.c       |  2 +-
 include/linux/blk_types.h    |  4 ++--
 include/linux/blkdev.h       | 10 +++++-----
 include/linux/blktrace_api.h |  2 +-
 20 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 91f7bcf..c7cd0fa 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -66,7 +66,7 @@ int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 	u64 *p = bb->page;
 	int rv;
 	sector_t target = s + sectors;
-	unsigned seq;
+	unsigned int seq;
 
 	if (bb->shift > 0) {
 		/* round the start down, and the end up */
@@ -477,7 +477,7 @@ ssize_t badblocks_show(struct badblocks *bb, char *page, int unack)
 	size_t len;
 	int i;
 	u64 *p = bb->page;
-	unsigned seq;
+	unsigned int seq;
 
 	if (bb->shift < 0)
 		return 0;
diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 9cfdd6c..dd128d3 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -54,7 +54,7 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 {
 	struct bio_integrity_payload *bip;
 	struct bio_set *bs = bio->bi_pool;
-	unsigned inline_vecs;
+	unsigned int inline_vecs;
 
 	if (!bs || !bs->bio_integrity_pool) {
 		bip = kmalloc(sizeof(struct bio_integrity_payload) +
@@ -411,7 +411,7 @@ void bio_integrity_advance(struct bio *bio, unsigned int bytes_done)
 {
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_disk);
-	unsigned bytes = bio_integrity_bytes(bi, bytes_done >> 9);
+	unsigned int bytes = bio_integrity_bytes(bi, bytes_done >> 9);
 
 	bip->bip_iter.bi_sector += bytes_done >> 9;
 	bvec_iter_advance(bip->bip_vec, &bip->bip_iter, bytes);
diff --git a/block/bio.c b/block/bio.c
index e1708db..543cc109 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -437,8 +437,8 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
 			     struct bio_set *bs)
 {
 	gfp_t saved_gfp = gfp_mask;
-	unsigned front_pad;
-	unsigned inline_vecs;
+	unsigned int front_pad;
+	unsigned int inline_vecs;
 	struct bio_vec *bvl = NULL;
 	struct bio *bio;
 	void *p;
@@ -961,7 +961,7 @@ EXPORT_SYMBOL(submit_bio_wait);
  *
  * @bio will then represent the remaining, uncompleted portion of the io.
  */
-void bio_advance(struct bio *bio, unsigned bytes)
+void bio_advance(struct bio *bio, unsigned int bytes)
 {
 	if (bio_integrity(bio))
 		bio_integrity_advance(bio, bytes);
@@ -987,7 +987,7 @@ void bio_copy_data(struct bio *dst, struct bio *src)
 	struct bvec_iter src_iter, dst_iter;
 	struct bio_vec src_bv, dst_bv;
 	void *src_p, *dst_p;
-	unsigned bytes;
+	unsigned int bytes;
 
 	src_iter = src->bi_iter;
 	dst_iter = dst->bi_iter;
diff --git a/block/blk-core.c b/block/blk-core.c
index 2d1a7bb..9f87f46 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2980,7 +2980,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
 	total_bytes = 0;
 	while (req->bio) {
 		struct bio *bio = req->bio;
-		unsigned bio_bytes = min(bio->bi_iter.bi_size, nr_bytes);
+		unsigned int bio_bytes = min(bio->bi_iter.bi_size, nr_bytes);
 
 		if (bio_bytes == bio->bi_iter.bi_size)
 			req->bio = bio->bi_next;
diff --git a/block/blk-lib.c b/block/blk-lib.c
index a676084..f92916f 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -230,7 +230,7 @@ EXPORT_SYMBOL(blkdev_issue_write_same);
 
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
-		struct bio **biop, unsigned flags)
+		struct bio **biop, unsigned int flags)
 {
 	struct bio *bio = *biop;
 	unsigned int max_write_zeroes_sectors;
@@ -342,7 +342,7 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
  */
 int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
-		unsigned flags)
+		unsigned int flags)
 {
 	int ret;
 	sector_t bs_mask;
@@ -375,7 +375,7 @@ EXPORT_SYMBOL(__blkdev_issue_zeroout);
  *  valid values for %flags.
  */
 int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
-		sector_t nr_sects, gfp_t gfp_mask, unsigned flags)
+		sector_t nr_sects, gfp_t gfp_mask, unsigned int flags)
 {
 	int ret = 0;
 	sector_t bs_mask;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 782940c..4233818 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -15,12 +15,12 @@
 static struct bio *blk_bio_discard_split(struct request_queue *q,
 					 struct bio *bio,
 					 struct bio_set *bs,
-					 unsigned *nsegs)
+					 unsigned int *nsegs)
 {
 	unsigned int max_discard_sectors, granularity;
 	int alignment;
 	sector_t tmp;
-	unsigned split_sectors;
+	unsigned int split_sectors;
 
 	*nsegs = 1;
 
@@ -56,7 +56,7 @@ static struct bio *blk_bio_discard_split(struct request_queue *q,
 }
 
 static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
-		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
+		struct bio *bio, struct bio_set *bs, unsigned int *nsegs)
 {
 	*nsegs = 1;
 
@@ -72,7 +72,7 @@ static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
 static struct bio *blk_bio_write_same_split(struct request_queue *q,
 					    struct bio *bio,
 					    struct bio_set *bs,
-					    unsigned *nsegs)
+					    unsigned int *nsegs)
 {
 	*nsegs = 1;
 
@@ -85,11 +85,11 @@ static struct bio *blk_bio_write_same_split(struct request_queue *q,
 	return bio_split(bio, q->limits.max_write_same_sectors, GFP_NOIO, bs);
 }
 
-static inline unsigned get_max_io_size(struct request_queue *q,
+static inline unsigned int get_max_io_size(struct request_queue *q,
 				       struct bio *bio)
 {
-	unsigned sectors = blk_max_size_offset(q, bio->bi_iter.bi_sector);
-	unsigned mask = queue_logical_block_size(q) - 1;
+	unsigned int sectors = blk_max_size_offset(q, bio->bi_iter.bi_sector);
+	unsigned int mask = queue_logical_block_size(q) - 1;
 
 	/* aligned to logical block size */
 	sectors &= ~(mask >> 9);
@@ -100,15 +100,15 @@ static inline unsigned get_max_io_size(struct request_queue *q,
 static struct bio *blk_bio_segment_split(struct request_queue *q,
 					 struct bio *bio,
 					 struct bio_set *bs,
-					 unsigned *segs)
+					 unsigned int *segs)
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	struct bvec_iter iter;
-	unsigned seg_size = 0, nsegs = 0, sectors = 0;
-	unsigned front_seg_size = bio->bi_seg_front_size;
+	unsigned int seg_size = 0, nsegs = 0, sectors = 0;
+	unsigned int front_seg_size = bio->bi_seg_front_size;
 	bool do_split = true;
 	struct bio *new = NULL;
-	const unsigned max_sectors = get_max_io_size(q, bio);
+	const unsigned int max_sectors = get_max_io_size(q, bio);
 
 	bio_for_each_segment(bv, bio, iter) {
 		/*
@@ -183,7 +183,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 void blk_queue_split(struct request_queue *q, struct bio **bio)
 {
 	struct bio *split, *res;
-	unsigned nsegs;
+	unsigned int nsegs;
 
 	switch (bio_op(*bio)) {
 	case REQ_OP_DISCARD:
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 25c14c5..66f911d 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -123,7 +123,7 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
 					  struct blk_mq_ctx *ctx)
 {
-	unsigned idx = ctx->index_hw;
+	unsigned int idx = ctx->index_hw;
 
 	if (++idx == hctx->nr_ctx)
 		idx = 0;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index df93102..8f315de 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1033,7 +1033,7 @@ static bool dispatch_rq_from_ctx(struct sbitmap *sb, unsigned int bitnr,
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start)
 {
-	unsigned off = start ? start->index_hw : 0;
+	unsigned int off = start ? start->index_hw : 0;
 	struct dispatch_rq_data data = {
 		.hctx = hctx,
 		.rq   = NULL,
@@ -1085,7 +1085,7 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 	return rq->tag != -1;
 }
 
-static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
+static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned int mode,
 				int flags, void *key)
 {
 	struct blk_mq_hw_ctx *hctx;
@@ -2234,7 +2234,7 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 
 static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
-		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
+		struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 {
 	int node;
 
diff --git a/block/blk-tag.c b/block/blk-tag.c
index 09f19c6..21e966fd 100644
--- a/block/blk-tag.c
+++ b/block/blk-tag.c
@@ -263,7 +263,7 @@ EXPORT_SYMBOL(blk_queue_resize_tags);
 void blk_queue_end_tag(struct request_queue *q, struct request *rq)
 {
 	struct blk_queue_tag *bqt = q->queue_tags;
-	unsigned tag = rq->tag; /* negative tags invalid */
+	unsigned int tag = rq->tag; /* negative tags invalid */
 
 	lockdep_assert_held(q->queue_lock);
 
@@ -310,7 +310,7 @@ void blk_queue_end_tag(struct request_queue *q, struct request *rq)
 int blk_queue_start_tag(struct request_queue *q, struct request *rq)
 {
 	struct blk_queue_tag *bqt = q->queue_tags;
-	unsigned max_depth;
+	unsigned int max_depth;
 	int tag;
 
 	lockdep_assert_held(q->queue_lock);
diff --git a/block/bounce.c b/block/bounce.c
index 6a3e682..72c1d08 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -202,7 +202,7 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 	int rw = bio_data_dir(*bio_orig);
 	struct bio_vec *to, from;
 	struct bvec_iter iter;
-	unsigned i = 0;
+	unsigned int i = 0;
 	bool bounce = false;
 	int sectors = 0;
 	bool passthrough = bio_is_passthrough(*bio_orig);
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 9f342ef..dbdb068 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -95,7 +95,7 @@ struct cfq_ttime {
 struct cfq_rb_root {
 	struct rb_root_cached rb;
 	struct rb_node *rb_rightmost;
-	unsigned count;
+	unsigned int count;
 	u64 min_vdisktime;
 	struct cfq_ttime ttime;
 };
@@ -996,13 +996,13 @@ static void update_min_vdisktime(struct cfq_rb_root *st)
  * to quickly follows sudden increases and decrease slowly
  */
 
-static inline unsigned cfq_group_get_avg_queues(struct cfq_data *cfqd,
+static inline unsigned int cfq_group_get_avg_queues(struct cfq_data *cfqd,
 					struct cfq_group *cfqg, bool rt)
 {
-	unsigned min_q, max_q;
-	unsigned mult  = cfq_hist_divisor - 1;
-	unsigned round = cfq_hist_divisor / 2;
-	unsigned busy = cfq_group_busy_queues_wl(rt, cfqd, cfqg);
+	unsigned int min_q, max_q;
+	unsigned int mult  = cfq_hist_divisor - 1;
+	unsigned int round = cfq_hist_divisor / 2;
+	unsigned int busy = cfq_group_busy_queues_wl(rt, cfqd, cfqg);
 
 	min_q = min(cfqg->busy_queues_avg[rt], busy);
 	max_q = max(cfqg->busy_queues_avg[rt], busy);
@@ -1026,7 +1026,7 @@ cfq_scaled_cfqq_slice(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 		 * interested queues (we consider only the ones with the same
 		 * priority class in the cfq group)
 		 */
-		unsigned iq = cfq_group_get_avg_queues(cfqd, cfqq->cfqg,
+		unsigned int iq = cfq_group_get_avg_queues(cfqd, cfqq->cfqg,
 						cfq_class_rt(cfqq));
 		u64 sync_slice = cfqd->cfq_slice[1];
 		u64 expect_latency = sync_slice * iq;
@@ -1088,7 +1088,7 @@ cfq_choose_req(struct cfq_data *cfqd, struct request *rq1, struct request *rq2,
 	unsigned long back_max;
 #define CFQ_RQ1_WRAP	0x01 /* request 1 wraps */
 #define CFQ_RQ2_WRAP	0x02 /* request 2 wraps */
-	unsigned wrap = 0; /* bit mask: requests behind the disk head? */
+	unsigned int wrap = 0; /* bit mask: requests behind the disk head? */
 
 	if (rq1 == NULL || rq1 == rq2)
 		return rq2;
@@ -1334,7 +1334,7 @@ cfq_group_service_tree_add(struct cfq_rb_root *st, struct cfq_group *cfqg)
 		pos = parent;
 	}
 
-	cfqg->vfraction = max_t(unsigned, vfr, 1);
+	cfqg->vfraction = max_t(unsigned int, vfr, 1);
 }
 
 static inline u64 cfq_get_cfqg_vdisktime_delay(struct cfq_data *cfqd)
@@ -3113,7 +3113,7 @@ static void
 choose_wl_class_and_type(struct cfq_data *cfqd, struct cfq_group *cfqg)
 {
 	u64 slice;
-	unsigned count;
+	unsigned int count;
 	struct cfq_rb_root *st;
 	u64 group_slice;
 	enum wl_class_t original_class = cfqd->serving_wl_class;
@@ -3162,7 +3162,7 @@ choose_wl_class_and_type(struct cfq_data *cfqd, struct cfq_group *cfqg)
 	group_slice = cfq_group_slice(cfqd, cfqg);
 
 	slice = div_u64(group_slice * count,
-		max_t(unsigned, cfqg->busy_queues_avg[cfqd->serving_wl_class],
+		max_t(unsigned int, cfqg->busy_queues_avg[cfqd->serving_wl_class],
 		      cfq_group_busy_queues_wl(cfqd->serving_wl_class, cfqd,
 					cfqg)));
 
diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index 6ca015f..f1f6987 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -207,7 +207,7 @@ static int compat_blkpg_ioctl(struct block_device *bdev, fmode_t mode,
 #define BLKGETSIZE64_32		_IOR(0x12, 114, int)
 
 static int compat_blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
-			unsigned cmd, unsigned long arg)
+			unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
 	case HDIO_GET_UNMASKINTR:
@@ -312,7 +312,7 @@ static int compat_blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
 /* Most of the generic ioctls are handled in the normal fallback path.
    This assumes the blkdev's low level compat_ioctl always returns
    ENOIOCTLCMD for unknown ioctls. */
-long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
+long compat_blkdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	int ret = -ENOIOCTLCMD;
 	struct inode *inode = file->f_mapping->host;
diff --git a/block/genhd.c b/block/genhd.c
index 88a53c1..68af457 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -287,7 +287,7 @@ static struct blk_major_name {
 } *major_names[BLKDEV_MAJOR_HASH_SIZE];
 
 /* index in the above - for now: assume no multimajor ranges */
-static inline int major_to_index(unsigned major)
+static inline int major_to_index(unsigned int major)
 {
 	return major % BLKDEV_MAJOR_HASH_SIZE;
 }
diff --git a/block/ioctl.c b/block/ioctl.c
index 1668506..b778b9d6 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -295,7 +295,7 @@ static int put_u64(unsigned long arg, u64 val)
 }
 
 int __blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
-			unsigned cmd, unsigned long arg)
+			unsigned int cmd, unsigned long arg)
 {
 	struct gendisk *disk = bdev->bd_disk;
 
@@ -422,7 +422,7 @@ static inline int is_unrecognized_ioctl(int ret)
 }
 
 static int blkdev_flushbuf(struct block_device *bdev, fmode_t mode,
-		unsigned cmd, unsigned long arg)
+		unsigned int cmd, unsigned long arg)
 {
 	int ret;
 
@@ -439,7 +439,7 @@ static int blkdev_flushbuf(struct block_device *bdev, fmode_t mode,
 }
 
 static int blkdev_roset(struct block_device *bdev, fmode_t mode,
-		unsigned cmd, unsigned long arg)
+		unsigned int cmd, unsigned long arg)
 {
 	int ret, n;
 
@@ -509,7 +509,7 @@ static int blkdev_bszset(struct block_device *bdev, fmode_t mode,
 /*
  * always keep this in sync with compat_blkdev_ioctl()
  */
-int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
+int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
 			unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index f95c607..0504f93 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -104,8 +104,8 @@ struct kyber_hctx_data {
 	atomic_t wait_index[KYBER_NUM_DOMAINS];
 };
 
-static int kyber_domain_wake(wait_queue_entry_t *wait, unsigned mode, int flags,
-			     void *key);
+static int kyber_domain_wake(wait_queue_entry_t *wait,
+			     unsigned int mode, int flags, void *key);
 
 static int rq_sched_domain(const struct request *rq)
 {
@@ -510,8 +510,8 @@ static void kyber_flush_busy_ctxs(struct kyber_hctx_data *khd,
 	}
 }
 
-static int kyber_domain_wake(wait_queue_entry_t *wait, unsigned mode, int flags,
-			     void *key)
+static int kyber_domain_wake(wait_queue_entry_t *wait,
+			     unsigned int mode, int flags, void *key)
 {
 	struct blk_mq_hw_ctx *hctx = READ_ONCE(wait->private);
 
diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 39f70d9..8aec2e3 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -323,7 +323,7 @@ static gpt_header *alloc_read_gpt_header(struct parsed_partitions *state,
 					 u64 lba)
 {
 	gpt_header *gpt;
-	unsigned ssz = bdev_logical_block_size(state->bdev);
+	unsigned int ssz = bdev_logical_block_size(state->bdev);
 
 	gpt = kmalloc(ssz, GFP_KERNEL);
 	if (!gpt)
@@ -694,7 +694,7 @@ int efi_partition(struct parsed_partitions *state)
 	gpt_header *gpt = NULL;
 	gpt_entry *ptes = NULL;
 	u32 i;
-	unsigned ssz = bdev_logical_block_size(state->bdev) / 512;
+	unsigned int ssz = bdev_logical_block_size(state->bdev) / 512;
 
 	if (!find_valid_gpt(state, &gpt, &ptes) || !gpt || !ptes) {
 		kfree(gpt);
@@ -706,8 +706,8 @@ int efi_partition(struct parsed_partitions *state)
 
 	for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1; i++) {
 		struct partition_meta_info *info;
-		unsigned label_count = 0;
-		unsigned label_max;
+		unsigned int label_count = 0;
+		unsigned int label_max;
 		u64 start = le64_to_cpu(ptes[i].starting_lba);
 		u64 size = le64_to_cpu(ptes[i].ending_lba) -
 			   le64_to_cpu(ptes[i].starting_lba) + 1ULL;
diff --git a/block/partitions/mac.c b/block/partitions/mac.c
index b609533..d21f990 100644
--- a/block/partitions/mac.c
+++ b/block/partitions/mac.c
@@ -33,7 +33,7 @@ int mac_partition(struct parsed_partitions *state)
 	Sector sect;
 	unsigned char *data;
 	int slot, blocks_in_map;
-	unsigned secsize, datasize, partoffset;
+	unsigned int secsize, datasize, partoffset;
 #ifdef CONFIG_PPC_PMAC
 	int found_root = 0;
 	int found_root_goodness = 0;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index bf18b95..bc65c69 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -314,8 +314,8 @@ enum req_flag_bits {
 	((req)->cmd_flags & REQ_OP_MASK)
 
 /* obsolete, don't use in new code */
-static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
-		unsigned op_flags)
+static inline void bio_set_op_attrs(struct bio *bio, unsigned int op,
+		unsigned int op_flags)
 {
 	bio->bi_opf = op | op_flags;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f3df80..3609191 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -299,7 +299,7 @@ static inline bool blk_rq_is_passthrough(struct request *rq)
 
 static inline bool bio_is_passthrough(struct bio *bio)
 {
-	unsigned op = bio_op(bio);
+	unsigned int op = bio_op(bio);
 
 	return blk_op_is_scsi(op) || blk_op_is_private(op);
 }
@@ -1445,9 +1445,9 @@ extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 
 extern int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
-		unsigned flags);
+		unsigned int flags);
 extern int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
-		sector_t nr_sects, gfp_t gfp_mask, unsigned flags);
+		sector_t nr_sects, gfp_t gfp_mask, unsigned int flags);
 
 static inline int sb_issue_discard(struct super_block *sb, sector_t block,
 		sector_t nr_blocks, gfp_t gfp_mask, unsigned long flags)
@@ -2035,8 +2035,8 @@ struct block_device_operations {
 	int (*open) (struct block_device *, fmode_t);
 	void (*release) (struct gendisk *, fmode_t);
 	int (*rw_page)(struct block_device *, sector_t, struct page *, bool);
-	int (*ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
-	int (*compat_ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
+	int (*ioctl) (struct block_device *, fmode_t, unsigned int, unsigned long);
+	int (*compat_ioctl) (struct block_device *, fmode_t, unsigned int, unsigned long);
 	unsigned int (*check_events) (struct gendisk *disk,
 				      unsigned int clearing);
 	/* ->media_changed() is DEPRECATED, use ->check_events() instead */
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 8804753..e08e860 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -31,7 +31,7 @@ struct blk_trace {
 
 struct blkcg;
 
-extern int blk_trace_ioctl(struct block_device *, unsigned, char __user *);
+extern int blk_trace_ioctl(struct block_device *, unsigned int, char __user *);
 extern void blk_trace_shutdown(struct request_queue *);
 extern __printf(3, 4)
 void __trace_note_message(struct blk_trace *, struct blkcg *blkcg, const char *fmt, ...);
-- 
2.7.5
