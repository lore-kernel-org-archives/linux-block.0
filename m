Return-Path: <rgoldwyn@suse.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: axboe@kernel.dk
Cc: viro@ZenIV.linux.org.uk,
	hch@lst.de,
	jack@suse.cz,
	akpm@linux-foundation.org,
	linux-block@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 07/10] block: return on congested block device
Date: Mon, 19 Jun 2017 11:33:45 -0500
Message-Id: <20170619163348.15542-8-rgoldwyn@suse.de>
In-Reply-To: <20170619163348.15542-1-rgoldwyn@suse.de>
References: <20170619163348.15542-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

A new bio operation flag REQ_NOWAIT is introduced to identify bio's
orignating from iocb with IOCB_NOWAIT. This flag indicates
to return immediately if a request cannot be made instead
of retrying.

Stacked devices such as md (the ones with make_request_fn hooks)
currently are not supported because it may block for housekeeping.
For example, an md can have a part of the device suspended.
For this reason, only request based devices are supported.
In the future, this feature will be expanded to stacked devices
by teaching them how to handle the REQ_NOWAIT flags.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 block/blk-core.c          | 22 ++++++++++++++++++++--
 block/blk-mq-sched.c      |  3 +++
 block/blk-mq.c            |  2 ++
 fs/direct-io.c            | 10 ++++++++--
 include/linux/bio.h       |  6 ++++++
 include/linux/blk_types.h |  4 ++++
 6 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8592409db272..3999e6ac288d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -143,6 +143,7 @@ static const struct {
 	[BLK_STS_MEDIUM]	= { -ENODATA,	"critical medium" },
 	[BLK_STS_PROTECTION]	= { -EILSEQ,	"protection" },
 	[BLK_STS_RESOURCE]	= { -ENOMEM,	"kernel resource" },
+	[BLK_STS_AGAIN]		= { -EAGAIN,	"nonblocking retry" },
 
 	/* device mapper special case, should not leak out: */
 	[BLK_STS_DM_REQUEUE]	= { -EREMCHG, "dm internal retry" },
@@ -1314,6 +1315,11 @@ static struct request *get_request(struct request_queue *q, unsigned int op,
 	if (!IS_ERR(rq))
 		return rq;
 
+	if (op & REQ_NOWAIT) {
+		blk_put_rl(rl);
+		return ERR_PTR(-EAGAIN);
+	}
+
 	if (!gfpflags_allow_blocking(gfp_mask) || unlikely(blk_queue_dying(q))) {
 		blk_put_rl(rl);
 		return rq;
@@ -1961,6 +1967,14 @@ generic_make_request_checks(struct bio *bio)
 		goto end_io;
 	}
 
+	/*
+	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
+	 * if queue is not a request based queue.
+	 */
+
+	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_rq_based(q))
+		goto not_supported;
+
 	part = bio->bi_bdev->bd_part;
 	if (should_fail_request(part, bio->bi_iter.bi_size) ||
 	    should_fail_request(&part_to_disk(part)->part0,
@@ -2118,7 +2132,7 @@ blk_qc_t generic_make_request(struct bio *bio)
 	do {
 		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 
-		if (likely(blk_queue_enter(q, false) == 0)) {
+		if (likely(blk_queue_enter(q, bio->bi_opf & REQ_NOWAIT) == 0)) {
 			struct bio_list lower, same;
 
 			/* Create a fresh bio_list for all subordinate requests */
@@ -2143,7 +2157,11 @@ blk_qc_t generic_make_request(struct bio *bio)
 			bio_list_merge(&bio_list_on_stack[0], &same);
 			bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
 		} else {
-			bio_io_error(bio);
+			if (unlikely(!blk_queue_dying(q) &&
+					(bio->bi_opf & REQ_NOWAIT)))
+				bio_wouldblock_error(bio);
+			else
+				bio_io_error(bio);
 		}
 		bio = bio_list_pop(&bio_list_on_stack[0]);
 	} while (bio);
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c4e2afb9d12d..ab14295d8468 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -83,6 +83,9 @@ struct request *blk_mq_sched_get_request(struct request_queue *q,
 	if (likely(!data->hctx))
 		data->hctx = blk_mq_map_queue(q, data->ctx->cpu);
 
+	if (op & REQ_NOWAIT)
+		data->flags |= BLK_MQ_REQ_NOWAIT;
+
 	if (e) {
 		data->flags |= BLK_MQ_REQ_INTERNAL;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 359d2dc0d414..387fc8e8a2ba 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1498,6 +1498,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	rq = blk_mq_sched_get_request(q, bio, bio->bi_opf, &data);
 	if (unlikely(!rq)) {
 		__wbt_done(q->rq_wb, wb_acct);
+		if (bio->bi_opf & REQ_NOWAIT)
+			bio_wouldblock_error(bio);
 		return BLK_QC_T_NONE;
 	}
 
diff --git a/fs/direct-io.c b/fs/direct-io.c
index e8baaabebf13..c87077d1dc33 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -479,8 +479,12 @@ static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
 	unsigned i;
 	blk_status_t err = bio->bi_status;
 
-	if (err)
-		dio->io_error = -EIO;
+	if (err) {
+		if (err == BLK_STS_AGAIN && (bio->bi_opf & REQ_NOWAIT))
+			dio->io_error = -EAGAIN;
+		else
+			dio->io_error = -EIO;
+	}
 
 	if (dio->is_async && dio->op == REQ_OP_READ && dio->should_dirty) {
 		bio_check_pages_dirty(bio);	/* transfers ownership */
@@ -1194,6 +1198,8 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	if (iov_iter_rw(iter) == WRITE) {
 		dio->op = REQ_OP_WRITE;
 		dio->op_flags = REQ_SYNC | REQ_IDLE;
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			dio->op_flags |= REQ_NOWAIT;
 	} else {
 		dio->op = REQ_OP_READ;
 	}
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 9455aada1399..1eb47e8c6965 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -418,6 +418,12 @@ static inline void bio_io_error(struct bio *bio)
 	bio_endio(bio);
 }
 
+static inline void bio_wouldblock_error(struct bio *bio)
+{
+	bio->bi_status = BLK_STS_AGAIN;
+	bio_endio(bio);
+}
+
 struct request_queue;
 extern int bio_phys_segments(struct request_queue *, struct bio *);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dcd45b15a3a5..e210da6d14b8 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -36,6 +36,8 @@ typedef u8 __bitwise blk_status_t;
 /* hack for device mapper, don't use elsewhere: */
 #define BLK_STS_DM_REQUEUE    ((__force blk_status_t)11)
 
+#define BLK_STS_AGAIN		((__force blk_status_t)12)
+
 struct blk_issue_stat {
 	u64 stat;
 };
@@ -224,6 +226,7 @@ enum req_flag_bits {
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
+	__REQ_NOWAIT,           /* Don't wait if request will block */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -242,6 +245,7 @@ enum req_flag_bits {
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
+#define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
-- 
2.12.0
