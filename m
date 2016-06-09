Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57704 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbcFIOAr (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2016 10:00:47 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com, mchristi@redhat.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: add a separate operation type for secure erase
Date: Thu,  9 Jun 2016 16:00:36 +0200
Message-Id: <1465480836-32093-3-git-send-email-hch@lst.de>
In-Reply-To: <1465480836-32093-1-git-send-email-hch@lst.de>
References: <1465480836-32093-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Instead of overloading the discard support with the REQ_SECURE flag.
Use the opportunity to rename the queue flag as well, and remove the
dead checks for this flag in the RAID 1 and RAID 10 drivers that don't
claim support for secure erase.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c                   | 27 +++++++++++++++++----------
 block/blk-lib.c                    | 25 ++++++++++++++-----------
 block/blk-merge.c                  |  6 ++----
 drivers/block/xen-blkback/xenbus.c |  2 +-
 drivers/block/xen-blkfront.c       | 14 +++++++++-----
 drivers/md/raid1.c                 |  3 +--
 drivers/md/raid10.c                |  5 ++---
 drivers/mmc/card/block.c           | 10 ++++++----
 drivers/mmc/card/queue.c           |  2 +-
 include/linux/blk_types.h          |  5 ++---
 include/linux/blkdev.h             | 23 ++++-------------------
 kernel/trace/blktrace.c            |  6 ++++--
 12 files changed, 63 insertions(+), 65 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 32a283e..db31a29 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1977,16 +1977,21 @@ generic_make_request_checks(struct bio *bio)
 		}
 	}
 
-	if ((bio_op(bio) == REQ_OP_DISCARD) &&
-	    (!blk_queue_discard(q) ||
-	     ((bio->bi_rw & REQ_SECURE) && !blk_queue_secdiscard(q)))) {
-		err = -EOPNOTSUPP;
-		goto end_io;
-	}
-
-	if (bio_op(bio) == REQ_OP_WRITE_SAME && !bdev_write_same(bio->bi_bdev)) {
-		err = -EOPNOTSUPP;
-		goto end_io;
+	switch (bio_op(bio)) {
+	case REQ_OP_DISCARD:
+		if (!blk_queue_discard(q))
+			goto not_supported;
+		break;
+	case REQ_OP_SECURE_ERASE:
+		if (!blk_queue_secure_erase(q))
+			goto not_supported;
+		break;
+	case REQ_OP_WRITE_SAME:
+		if (!bdev_write_same(bio->bi_bdev))
+			goto not_supported;
+		break;
+	default:
+		break;
 	}
 
 	/*
@@ -2003,6 +2008,8 @@ generic_make_request_checks(struct bio *bio)
 	trace_block_bio_queue(q, bio);
 	return true;
 
+not_supported:
+	err = -EOPNOTSUPP;
 end_io:
 	bio->bi_error = err;
 	bio_endio(bio);
diff --git a/block/blk-lib.c b/block/blk-lib.c
index ff2a7f0..78626c2 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -23,20 +23,27 @@ static struct bio *next_bio(struct bio *bio, unsigned int nr_pages,
 }
 
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
-		sector_t nr_sects, gfp_t gfp_mask, int op_flags,
+		sector_t nr_sects, gfp_t gfp_mask, int flags,
 		struct bio **biop)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 	struct bio *bio = *biop;
 	unsigned int granularity;
+	enum req_op op;
 	int alignment;
 
 	if (!q)
 		return -ENXIO;
-	if (!blk_queue_discard(q))
-		return -EOPNOTSUPP;
-	if ((op_flags & REQ_SECURE) && !blk_queue_secdiscard(q))
-		return -EOPNOTSUPP;
+
+	if (flags & BLKDEV_DISCARD_SECURE) {
+		if (!blk_queue_secure_erase(q))
+			return -EOPNOTSUPP;
+		op = REQ_OP_SECURE_ERASE;
+	} else {
+		if (!blk_queue_discard(q))
+			return -EOPNOTSUPP;
+		op = REQ_OP_DISCARD;
+	}
 
 	/* Zero-sector (unknown) and one-sector granularities are the same.  */
 	granularity = max(q->limits.discard_granularity >> 9, 1U);
@@ -66,7 +73,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		bio = next_bio(bio, 1, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		bio->bi_bdev = bdev;
-		bio_set_op_attrs(bio, REQ_OP_DISCARD, op_flags);
+		bio_set_op_attrs(bio, op, 0);
 
 		bio->bi_iter.bi_size = req_sects << 9;
 		nr_sects -= req_sects;
@@ -100,16 +107,12 @@ EXPORT_SYMBOL(__blkdev_issue_discard);
 int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags)
 {
-	int op_flags = 0;
 	struct bio *bio = NULL;
 	struct blk_plug plug;
 	int ret;
 
-	if (flags & BLKDEV_DISCARD_SECURE)
-		op_flags |= REQ_SECURE;
-
 	blk_start_plug(&plug);
-	ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, op_flags,
+	ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, flags,
 			&bio);
 	if (!ret && bio) {
 		ret = submit_bio_wait(bio);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index c265348..9772308 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -649,8 +649,7 @@ static int attempt_merge(struct request_queue *q, struct request *req,
 	if (!rq_mergeable(req) || !rq_mergeable(next))
 		return 0;
 
-	if (!blk_check_merge_flags(req->cmd_flags, req_op(req), next->cmd_flags,
-				   req_op(next)))
+	if (req_op(req) != req_op(next))
 		return 0;
 
 	/*
@@ -752,8 +751,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (!rq_mergeable(rq) || !bio_mergeable(bio))
 		return false;
 
-	if (!blk_check_merge_flags(rq->cmd_flags, req_op(rq), bio->bi_rw,
-				   bio_op(bio)))
+	if (req_op(rq) != bio_op(bio))
 		return false;
 
 	/* different data direction or already started, don't merge */
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 3355f1c..2994cfa 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -480,7 +480,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 	if (q && test_bit(QUEUE_FLAG_WC, &q->queue_flags))
 		vbd->flush_support = true;
 
-	if (q && blk_queue_secdiscard(q))
+	if (q && blk_queue_secure_erase(q))
 		vbd->discard_secure = true;
 
 	pr_debug("Successful creation of handle=%04x (dom=%u)\n",
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 343ef7a..1071129 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -545,7 +545,7 @@ static int blkif_queue_discard_req(struct request *req, struct blkfront_ring_inf
 	ring_req->u.discard.nr_sectors = blk_rq_sectors(req);
 	ring_req->u.discard.id = id;
 	ring_req->u.discard.sector_number = (blkif_sector_t)blk_rq_pos(req);
-	if ((req->cmd_flags & REQ_SECURE) && info->feature_secdiscard)
+	if (req_op(req) == REQ_OP_SECURE_ERASE && info->feature_secdiscard)
 		ring_req->u.discard.flag = BLKIF_DISCARD_SECURE;
 	else
 		ring_req->u.discard.flag = 0;
@@ -841,7 +841,7 @@ static int blkif_queue_request(struct request *req, struct blkfront_ring_info *r
 		return 1;
 
 	if (unlikely(req_op(req) == REQ_OP_DISCARD ||
-		     req->cmd_flags & REQ_SECURE))
+		     req_op(req) == REQ_OP_SECURE_ERASE))
 		return blkif_queue_discard_req(req, rinfo);
 	else
 		return blkif_queue_rw_req(req, rinfo);
@@ -955,7 +955,7 @@ static int xlvbd_init_blk_queue(struct gendisk *gd, u16 sector_size,
 		rq->limits.discard_granularity = info->discard_granularity;
 		rq->limits.discard_alignment = info->discard_alignment;
 		if (info->feature_secdiscard)
-			queue_flag_set_unlocked(QUEUE_FLAG_SECDISCARD, rq);
+			queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, rq);
 	}
 
 	/* Hard sector size and max sectors impersonate the equiv. hardware. */
@@ -1595,7 +1595,7 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 				info->feature_discard = 0;
 				info->feature_secdiscard = 0;
 				queue_flag_clear(QUEUE_FLAG_DISCARD, rq);
-				queue_flag_clear(QUEUE_FLAG_SECDISCARD, rq);
+				queue_flag_clear(QUEUE_FLAG_SECERASE, rq);
 			}
 			blk_mq_complete_request(req, error);
 			break;
@@ -2052,10 +2052,14 @@ static int blkif_recover(struct blkfront_info *info)
 			 */
 			if (req_op(copy[i].request) == REQ_OP_FLUSH ||
 			    req_op(copy[i].request) == REQ_OP_DISCARD ||
-			    copy[i].request->cmd_flags & (REQ_FUA | REQ_SECURE)) {
+			    req_op(copy[i].request) == REQ_OP_SECURE_ERASE ||
+			    copy[i].request->cmd_flags & REQ_FUA) {
 				/*
 				 * Flush operations don't contain bios, so
 				 * we need to requeue the whole request
+				 *
+				 * XXX: but this doesn't make any sense for a
+				 * write with the FUA flag set..
 				 */
 				list_add(&copy[i].request->queuelist, &requests);
 				continue;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 10e53cd..41d9c31 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1058,7 +1058,6 @@ static void raid1_make_request(struct mddev *mddev, struct bio * bio)
 	const unsigned long do_sync = (bio->bi_rw & REQ_SYNC);
 	const unsigned long do_flush_fua = (bio->bi_rw &
 						(REQ_PREFLUSH | REQ_FUA));
-	const unsigned long do_sec = (bio->bi_rw & REQ_SECURE);
 	struct md_rdev *blocked_rdev;
 	struct blk_plug_cb *cb;
 	struct raid1_plug_cb *plug = NULL;
@@ -1376,7 +1375,7 @@ read_again:
 				   conf->mirrors[i].rdev->data_offset);
 		mbio->bi_bdev = conf->mirrors[i].rdev->bdev;
 		mbio->bi_end_io	= raid1_end_write_request;
-		bio_set_op_attrs(mbio, op, do_flush_fua | do_sync | do_sec);
+		bio_set_op_attrs(mbio, op, do_flush_fua | do_sync);
 		mbio->bi_private = r1_bio;
 
 		atomic_inc(&r1_bio->remaining);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 245640b..26ae74f 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1062,7 +1062,6 @@ static void __make_request(struct mddev *mddev, struct bio *bio)
 	const int rw = bio_data_dir(bio);
 	const unsigned long do_sync = (bio->bi_rw & REQ_SYNC);
 	const unsigned long do_fua = (bio->bi_rw & REQ_FUA);
-	const unsigned long do_sec = (bio->bi_rw & REQ_SECURE);
 	unsigned long flags;
 	struct md_rdev *blocked_rdev;
 	struct blk_plug_cb *cb;
@@ -1362,7 +1361,7 @@ retry_write:
 							      rdev));
 			mbio->bi_bdev = rdev->bdev;
 			mbio->bi_end_io	= raid10_end_write_request;
-			bio_set_op_attrs(mbio, op, do_sync | do_fua | do_sec);
+			bio_set_op_attrs(mbio, op, do_sync | do_fua);
 			mbio->bi_private = r10_bio;
 
 			atomic_inc(&r10_bio->remaining);
@@ -1404,7 +1403,7 @@ retry_write:
 						   r10_bio, rdev));
 			mbio->bi_bdev = rdev->bdev;
 			mbio->bi_end_io	= raid10_end_write_request;
-			bio_set_op_attrs(mbio, op, do_sync | do_fua | do_sec);
+			bio_set_op_attrs(mbio, op, do_sync | do_fua);
 			mbio->bi_private = r10_bio;
 
 			atomic_inc(&r10_bio->remaining);
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index bca20f8..3831847 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2167,10 +2167,12 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		/* complete ongoing async transfer before issuing discard */
 		if (card->host->areq)
 			mmc_blk_issue_rw_rq(mq, NULL);
-		if (req->cmd_flags & REQ_SECURE)
-			ret = mmc_blk_issue_secdiscard_rq(mq, req);
-		else
-			ret = mmc_blk_issue_discard_rq(mq, req);
+		ret = mmc_blk_issue_discard_rq(mq, req);
+	} else if (req && req_op(req) == REQ_OP_SECURE_ERASE) {
+		/* complete ongoing async transfer before issuing secure erase*/
+		if (card->host->areq)
+			mmc_blk_issue_rw_rq(mq, NULL);
+		ret = mmc_blk_issue_secdiscard_rq(mq, req);
 	} else if (req && req_op(req) == REQ_OP_FLUSH) {
 		/* complete ongoing async transfer before issuing flush */
 		if (card->host->areq)
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index c2d5f6f..bf14642 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -171,7 +171,7 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 	if (card->pref_erase > max_discard)
 		q->limits.discard_granularity = 0;
 	if (mmc_can_secure_erase_trim(card))
-		queue_flag_set_unlocked(QUEUE_FLAG_SECDISCARD, q);
+		queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, q);
 }
 
 /**
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 562ab83..efba1f2 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -163,7 +163,6 @@ enum rq_flag_bits {
 	__REQ_SYNC,		/* request is sync (sync write or read) */
 	__REQ_META,		/* metadata io request */
 	__REQ_PRIO,		/* boost priority in cfq */
-	__REQ_SECURE,		/* secure discard (used with REQ_OP_DISCARD) */
 
 	__REQ_NOIDLE,		/* don't anticipate more IO after this one */
 	__REQ_INTEGRITY,	/* I/O includes block integrity payload */
@@ -212,7 +211,7 @@ enum rq_flag_bits {
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
 #define REQ_COMMON_MASK \
 	(REQ_FAILFAST_MASK | REQ_SYNC | REQ_META | REQ_PRIO | REQ_NOIDLE | \
-	 REQ_PREFLUSH | REQ_FUA | REQ_SECURE | REQ_INTEGRITY | REQ_NOMERGE)
+	 REQ_PREFLUSH | REQ_FUA | REQ_INTEGRITY | REQ_NOMERGE)
 #define REQ_CLONE_MASK		REQ_COMMON_MASK
 
 /* This mask is used for both bio and request merge checking */
@@ -239,7 +238,6 @@ enum rq_flag_bits {
 #define REQ_FLUSH_SEQ		(1ULL << __REQ_FLUSH_SEQ)
 #define REQ_IO_STAT		(1ULL << __REQ_IO_STAT)
 #define REQ_MIXED_MERGE		(1ULL << __REQ_MIXED_MERGE)
-#define REQ_SECURE		(1ULL << __REQ_SECURE)
 #define REQ_PM			(1ULL << __REQ_PM)
 #define REQ_HASHED		(1ULL << __REQ_HASHED)
 #define REQ_MQ_INFLIGHT		(1ULL << __REQ_MQ_INFLIGHT)
@@ -248,6 +246,7 @@ enum req_op {
 	REQ_OP_READ,
 	REQ_OP_WRITE,
 	REQ_OP_DISCARD,		/* request to discard sectors */
+	REQ_OP_SECURE_ERASE,	/* request to securely erase sectors */
 	REQ_OP_WRITE_SAME,	/* write same block many times */
 	REQ_OP_FLUSH,		/* request for cache flush */
 };
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9746d22..9d1e0a4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -496,7 +496,7 @@ struct request_queue {
 #define QUEUE_FLAG_DISCARD     14	/* supports DISCARD */
 #define QUEUE_FLAG_NOXMERGES   15	/* No extended merges */
 #define QUEUE_FLAG_ADD_RANDOM  16	/* Contributes to random pool */
-#define QUEUE_FLAG_SECDISCARD  17	/* supports SECDISCARD */
+#define QUEUE_FLAG_SECERASE    17	/* supports secure erase */
 #define QUEUE_FLAG_SAME_FORCE  18	/* force complete on same CPU */
 #define QUEUE_FLAG_DEAD        19	/* queue tear-down finished */
 #define QUEUE_FLAG_INIT_DONE   20	/* queue is initialized */
@@ -592,8 +592,8 @@ static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
 #define blk_queue_stackable(q)	\
 	test_bit(QUEUE_FLAG_STACKABLE, &(q)->queue_flags)
 #define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_flags)
-#define blk_queue_secdiscard(q)	(blk_queue_discard(q) && \
-	test_bit(QUEUE_FLAG_SECDISCARD, &(q)->queue_flags))
+#define blk_queue_secure_erase(q) \
+	(test_bit(QUEUE_FLAG_SECERASE, &(q)->queue_flags))
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
@@ -674,21 +674,6 @@ static inline bool rq_mergeable(struct request *rq)
 	return true;
 }
 
-static inline bool blk_check_merge_flags(unsigned int flags1, unsigned int op1,
-					 unsigned int flags2, unsigned int op2)
-{
-	if ((op1 == REQ_OP_DISCARD) != (op2 == REQ_OP_DISCARD))
-		return false;
-
-	if ((flags1 & REQ_SECURE) != (flags2 & REQ_SECURE))
-		return false;
-
-	if ((op1 == REQ_OP_WRITE_SAME) != (op2 == REQ_OP_WRITE_SAME))
-		return false;
-
-	return true;
-}
-
 static inline bool blk_write_same_mergeable(struct bio *a, struct bio *b)
 {
 	if (bio_data(a) == bio_data(b))
@@ -1157,7 +1142,7 @@ extern int blkdev_issue_flush(struct block_device *, gfp_t, sector_t *);
 extern int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags);
 extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
-		sector_t nr_sects, gfp_t gfp_mask, int op_flags,
+		sector_t nr_sects, gfp_t gfp_mask, int flags,
 		struct bio **biop);
 extern int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct page *page);
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 03b0dd9..af49caf 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1791,6 +1791,10 @@ void blk_fill_rwbs(char *rwbs, int op, u32 rw, int bytes)
 	case REQ_OP_DISCARD:
 		rwbs[i++] = 'D';
 		break;
+	case REQ_OP_SECURE_ERASE:
+		rwbs[i++] = 'D';
+		rwbs[i++] = 'E';
+		break;
 	case REQ_OP_FLUSH:
 		rwbs[i++] = 'F';
 		break;
@@ -1809,8 +1813,6 @@ void blk_fill_rwbs(char *rwbs, int op, u32 rw, int bytes)
 		rwbs[i++] = 'S';
 	if (rw & REQ_META)
 		rwbs[i++] = 'M';
-	if (rw & REQ_SECURE)
-		rwbs[i++] = 'E';
 
 	rwbs[i] = '\0';
 }
-- 
2.1.4

