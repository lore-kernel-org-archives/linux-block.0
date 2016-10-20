Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933843AbcJTNMd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2016 09:12:33 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 5/7] block: split out request-only flags into a new namespace
Date: Thu, 20 Oct 2016 15:12:13 +0200
Message-Id: <1476969135-32732-6-git-send-email-hch@lst.de>
In-Reply-To: <1476969135-32732-1-git-send-email-hch@lst.de>
References: <1476969135-32732-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A lot of the REQ_* flags are only used on struct requests, and only of
use to the block layer and a few drivers that dig into struct request
internals.

This patch adds a new req_flags_t rq_flags field to struct request for
them, and thus dramatically shrinks the number of common requests.  It
also removes the unfortunate situation where we have to fit the fields
from the same enum into 32 bits for struct bio and 64 bits for
struct request.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/block/biodoc.txt              |  2 +-
 block/blk-core.c                            | 71 ++++++++++++++-------------
 block/blk-exec.c                            |  2 +-
 block/blk-flush.c                           |  9 ++--
 block/blk-map.c                             |  4 +-
 block/blk-merge.c                           |  8 +--
 block/blk-mq.c                              | 19 ++++----
 block/blk-tag.c                             |  6 +--
 block/blk.h                                 |  4 +-
 block/elevator.c                            | 32 ++++++------
 drivers/block/pktcdvd.c                     |  2 +-
 drivers/ide/ide-atapi.c                     |  6 +--
 drivers/ide/ide-cd.c                        | 46 +++++++++---------
 drivers/ide/ide-cd.h                        |  2 +-
 drivers/ide/ide-cd_ioctl.c                  |  6 +--
 drivers/ide/ide-io.c                        |  6 +--
 drivers/ide/ide-pm.c                        |  4 +-
 drivers/md/dm-rq.c                          | 12 ++---
 drivers/memstick/core/ms_block.c            |  2 +-
 drivers/memstick/core/mspro_block.c         |  2 +-
 drivers/mmc/card/block.c                    |  4 +-
 drivers/mmc/card/queue.c                    |  4 +-
 drivers/nvme/host/pci.c                     |  4 +-
 drivers/scsi/device_handler/scsi_dh_alua.c  |  8 +--
 drivers/scsi/device_handler/scsi_dh_emc.c   |  2 +-
 drivers/scsi/device_handler/scsi_dh_hp_sw.c |  2 +-
 drivers/scsi/device_handler/scsi_dh_rdac.c  |  2 +-
 drivers/scsi/osd/osd_initiator.c            |  2 +-
 drivers/scsi/osst.c                         |  2 +-
 drivers/scsi/scsi_error.c                   |  2 +-
 drivers/scsi/scsi_lib.c                     | 75 +++++++++++++++++------------
 drivers/scsi/sd.c                           |  6 +--
 drivers/scsi/sd_zbc.c                       |  2 +-
 drivers/scsi/st.c                           |  2 +-
 drivers/scsi/ufs/ufshcd.c                   |  6 +--
 include/linux/blk_types.h                   | 39 +--------------
 include/linux/blkdev.h                      | 49 ++++++++++++++++++-
 include/scsi/scsi_device.h                  |  4 +-
 38 files changed, 242 insertions(+), 218 deletions(-)

diff --git a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
index 918e1e0..6acea16 100644
--- a/Documentation/block/biodoc.txt
+++ b/Documentation/block/biodoc.txt
@@ -348,7 +348,7 @@ Drivers can now specify a request prepare function (q->prep_rq_fn) that the
 block layer would invoke to pre-build device commands for a given request,
 or perform other preparatory processing for the request. This is routine is
 called by elv_next_request(), i.e. typically just before servicing a request.
-(The prepare function would not be called for requests that have REQ_DONTPREP
+(The prepare function would not be called for requests that have RQF_DONTPREP
 enabled)
 
 Aside:
diff --git a/block/blk-core.c b/block/blk-core.c
index e4eda5d..fd41665 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -145,13 +145,13 @@ static void req_bio_endio(struct request *rq, struct bio *bio,
 	if (error)
 		bio->bi_error = error;
 
-	if (unlikely(rq->cmd_flags & REQ_QUIET))
+	if (unlikely(rq->rq_flags & RQF_QUIET))
 		bio_set_flag(bio, BIO_QUIET);
 
 	bio_advance(bio, nbytes);
 
 	/* don't actually finish bio if it's part of flush sequence */
-	if (bio->bi_iter.bi_size == 0 && !(rq->cmd_flags & REQ_FLUSH_SEQ))
+	if (bio->bi_iter.bi_size == 0 && !(rq->rq_flags & RQF_FLUSH_SEQ))
 		bio_endio(bio);
 }
 
@@ -899,7 +899,7 @@ EXPORT_SYMBOL(blk_get_queue);
 
 static inline void blk_free_request(struct request_list *rl, struct request *rq)
 {
-	if (rq->cmd_flags & REQ_ELVPRIV) {
+	if (rq->rq_flags & RQF_ELVPRIV) {
 		elv_put_request(rl->q, rq);
 		if (rq->elv.icq)
 			put_io_context(rq->elv.icq->ioc);
@@ -961,14 +961,14 @@ static void __freed_request(struct request_list *rl, int sync)
  * A request has just been released.  Account for it, update the full and
  * congestion status, wake up any waiters.   Called under q->queue_lock.
  */
-static void freed_request(struct request_list *rl, int op, unsigned int flags)
+static void freed_request(struct request_list *rl, bool sync,
+		req_flags_t rq_flags)
 {
 	struct request_queue *q = rl->q;
-	int sync = rw_is_sync(op, flags);
 
 	q->nr_rqs[sync]--;
 	rl->count[sync]--;
-	if (flags & REQ_ELVPRIV)
+	if (rq_flags & RQF_ELVPRIV)
 		q->nr_rqs_elvpriv--;
 
 	__freed_request(rl, sync);
@@ -1079,6 +1079,7 @@ static struct request *__get_request(struct request_list *rl, int op,
 	struct io_cq *icq = NULL;
 	const bool is_sync = rw_is_sync(op, op_flags) != 0;
 	int may_queue;
+	req_flags_t rq_flags = RQF_ALLOCED;
 
 	if (unlikely(blk_queue_dying(q)))
 		return ERR_PTR(-ENODEV);
@@ -1127,7 +1128,7 @@ static struct request *__get_request(struct request_list *rl, int op,
 
 	/*
 	 * Decide whether the new request will be managed by elevator.  If
-	 * so, mark @op_flags and increment elvpriv.  Non-zero elvpriv will
+	 * so, mark @rq_flags and increment elvpriv.  Non-zero elvpriv will
 	 * prevent the current elevator from being destroyed until the new
 	 * request is freed.  This guarantees icq's won't be destroyed and
 	 * makes creating new ones safe.
@@ -1136,14 +1137,14 @@ static struct request *__get_request(struct request_list *rl, int op,
 	 * it will be created after releasing queue_lock.
 	 */
 	if (blk_rq_should_init_elevator(bio) && !blk_queue_bypass(q)) {
-		op_flags |= REQ_ELVPRIV;
+		rq_flags |= RQF_ELVPRIV;
 		q->nr_rqs_elvpriv++;
 		if (et->icq_cache && ioc)
 			icq = ioc_lookup_icq(ioc, q);
 	}
 
 	if (blk_queue_io_stat(q))
-		op_flags |= REQ_IO_STAT;
+		rq_flags |= RQF_IO_STAT;
 	spin_unlock_irq(q->queue_lock);
 
 	/* allocate and init request */
@@ -1153,10 +1154,11 @@ static struct request *__get_request(struct request_list *rl, int op,
 
 	blk_rq_init(q, rq);
 	blk_rq_set_rl(rq, rl);
-	req_set_op_attrs(rq, op, op_flags | REQ_ALLOCED);
+	req_set_op_attrs(rq, op, op_flags);
+	rq->rq_flags = rq_flags;
 
 	/* init elvpriv */
-	if (op_flags & REQ_ELVPRIV) {
+	if (rq_flags & RQF_ELVPRIV) {
 		if (unlikely(et->icq_cache && !icq)) {
 			if (ioc)
 				icq = ioc_create_icq(ioc, q, gfp_mask);
@@ -1195,7 +1197,7 @@ static struct request *__get_request(struct request_list *rl, int op,
 	printk_ratelimited(KERN_WARNING "%s: dev %s: request aux data allocation failed, iosched may be disturbed\n",
 			   __func__, dev_name(q->backing_dev_info.dev));
 
-	rq->cmd_flags &= ~REQ_ELVPRIV;
+	rq->rq_flags &= ~RQF_ELVPRIV;
 	rq->elv.icq = NULL;
 
 	spin_lock_irq(q->queue_lock);
@@ -1212,7 +1214,7 @@ static struct request *__get_request(struct request_list *rl, int op,
 	 * queue, but this is pretty rare.
 	 */
 	spin_lock_irq(q->queue_lock);
-	freed_request(rl, op, op_flags);
+	freed_request(rl, is_sync, rq_flags);
 
 	/*
 	 * in the very unlikely event that allocation failed and no
@@ -1347,7 +1349,7 @@ void blk_requeue_request(struct request_queue *q, struct request *rq)
 	blk_clear_rq_complete(rq);
 	trace_block_rq_requeue(q, rq);
 
-	if (rq->cmd_flags & REQ_QUEUED)
+	if (rq->rq_flags & RQF_QUEUED)
 		blk_queue_end_tag(q, rq);
 
 	BUG_ON(blk_queued_rq(rq));
@@ -1409,7 +1411,7 @@ EXPORT_SYMBOL_GPL(part_round_stats);
 #ifdef CONFIG_PM
 static void blk_pm_put_request(struct request *rq)
 {
-	if (rq->q->dev && !(rq->cmd_flags & REQ_PM) && !--rq->q->nr_pending)
+	if (rq->q->dev && !(rq->rq_flags & RQF_PM) && !--rq->q->nr_pending)
 		pm_runtime_mark_last_busy(rq->q->dev);
 }
 #else
@@ -1421,6 +1423,8 @@ static inline void blk_pm_put_request(struct request *rq) {}
  */
 void __blk_put_request(struct request_queue *q, struct request *req)
 {
+	req_flags_t rq_flags = req->rq_flags;
+
 	if (unlikely(!q))
 		return;
 
@@ -1440,16 +1444,15 @@ void __blk_put_request(struct request_queue *q, struct request *req)
 	 * Request may not have originated from ll_rw_blk. if not,
 	 * it didn't come out of our reserved rq pools
 	 */
-	if (req->cmd_flags & REQ_ALLOCED) {
-		unsigned int flags = req->cmd_flags;
-		int op = req_op(req);
+	if (rq_flags & RQF_ALLOCED) {
 		struct request_list *rl = blk_rq_rl(req);
+		bool sync = rw_is_sync(req_op(req), req->cmd_flags);
 
 		BUG_ON(!list_empty(&req->queuelist));
 		BUG_ON(ELV_ON_HASH(req));
 
 		blk_free_request(rl, req);
-		freed_request(rl, op, flags);
+		freed_request(rl, sync, rq_flags);
 		blk_put_rl(rl);
 	}
 }
@@ -2214,7 +2217,7 @@ unsigned int blk_rq_err_bytes(const struct request *rq)
 	unsigned int bytes = 0;
 	struct bio *bio;
 
-	if (!(rq->cmd_flags & REQ_MIXED_MERGE))
+	if (!(rq->rq_flags & RQF_MIXED_MERGE))
 		return blk_rq_bytes(rq);
 
 	/*
@@ -2257,7 +2260,7 @@ void blk_account_io_done(struct request *req)
 	 * normal IO on queueing nor completion.  Accounting the
 	 * containing request is enough.
 	 */
-	if (blk_do_io_stat(req) && !(req->cmd_flags & REQ_FLUSH_SEQ)) {
+	if (blk_do_io_stat(req) && !(req->rq_flags & RQF_FLUSH_SEQ)) {
 		unsigned long duration = jiffies - req->start_time;
 		const int rw = rq_data_dir(req);
 		struct hd_struct *part;
@@ -2285,7 +2288,7 @@ static struct request *blk_pm_peek_request(struct request_queue *q,
 					   struct request *rq)
 {
 	if (q->dev && (q->rpm_status == RPM_SUSPENDED ||
-	    (q->rpm_status != RPM_ACTIVE && !(rq->cmd_flags & REQ_PM))))
+	    (q->rpm_status != RPM_ACTIVE && !(rq->rq_flags & RQF_PM))))
 		return NULL;
 	else
 		return rq;
@@ -2361,13 +2364,13 @@ struct request *blk_peek_request(struct request_queue *q)
 		if (!rq)
 			break;
 
-		if (!(rq->cmd_flags & REQ_STARTED)) {
+		if (!(rq->rq_flags & RQF_STARTED)) {
 			/*
 			 * This is the first time the device driver
 			 * sees this request (possibly after
 			 * requeueing).  Notify IO scheduler.
 			 */
-			if (rq->cmd_flags & REQ_SORTED)
+			if (rq->rq_flags & RQF_SORTED)
 				elv_activate_rq(q, rq);
 
 			/*
@@ -2375,7 +2378,7 @@ struct request *blk_peek_request(struct request_queue *q)
 			 * it, a request that has been delayed should
 			 * not be passed by new incoming requests
 			 */
-			rq->cmd_flags |= REQ_STARTED;
+			rq->rq_flags |= RQF_STARTED;
 			trace_block_rq_issue(q, rq);
 		}
 
@@ -2384,7 +2387,7 @@ struct request *blk_peek_request(struct request_queue *q)
 			q->boundary_rq = NULL;
 		}
 
-		if (rq->cmd_flags & REQ_DONTPREP)
+		if (rq->rq_flags & RQF_DONTPREP)
 			break;
 
 		if (q->dma_drain_size && blk_rq_bytes(rq)) {
@@ -2407,11 +2410,11 @@ struct request *blk_peek_request(struct request_queue *q)
 			/*
 			 * the request may have been (partially) prepped.
 			 * we need to keep this request in the front to
-			 * avoid resource deadlock.  REQ_STARTED will
+			 * avoid resource deadlock.  RQF_STARTED will
 			 * prevent other fs requests from passing this one.
 			 */
 			if (q->dma_drain_size && blk_rq_bytes(rq) &&
-			    !(rq->cmd_flags & REQ_DONTPREP)) {
+			    !(rq->rq_flags & RQF_DONTPREP)) {
 				/*
 				 * remove the space for the drain we added
 				 * so that we don't add it again
@@ -2424,7 +2427,7 @@ struct request *blk_peek_request(struct request_queue *q)
 		} else if (ret == BLKPREP_KILL || ret == BLKPREP_INVALID) {
 			int err = (ret == BLKPREP_INVALID) ? -EREMOTEIO : -EIO;
 
-			rq->cmd_flags |= REQ_QUIET;
+			rq->rq_flags |= RQF_QUIET;
 			/*
 			 * Mark this request as started so we don't trigger
 			 * any debug logic in the end I/O path.
@@ -2561,7 +2564,7 @@ bool blk_update_request(struct request *req, int error, unsigned int nr_bytes)
 		req->errors = 0;
 
 	if (error && req->cmd_type == REQ_TYPE_FS &&
-	    !(req->cmd_flags & REQ_QUIET)) {
+	    !(req->rq_flags & RQF_QUIET)) {
 		char *error_type;
 
 		switch (error) {
@@ -2634,7 +2637,7 @@ bool blk_update_request(struct request *req, int error, unsigned int nr_bytes)
 		req->__sector += total_bytes >> 9;
 
 	/* mixed attributes always follow the first bio */
-	if (req->cmd_flags & REQ_MIXED_MERGE) {
+	if (req->rq_flags & RQF_MIXED_MERGE) {
 		req->cmd_flags &= ~REQ_FAILFAST_MASK;
 		req->cmd_flags |= req->bio->bi_opf & REQ_FAILFAST_MASK;
 	}
@@ -2687,7 +2690,7 @@ void blk_unprep_request(struct request *req)
 {
 	struct request_queue *q = req->q;
 
-	req->cmd_flags &= ~REQ_DONTPREP;
+	req->rq_flags &= ~RQF_DONTPREP;
 	if (q->unprep_rq_fn)
 		q->unprep_rq_fn(q, req);
 }
@@ -2698,7 +2701,7 @@ EXPORT_SYMBOL_GPL(blk_unprep_request);
  */
 void blk_finish_request(struct request *req, int error)
 {
-	if (req->cmd_flags & REQ_QUEUED)
+	if (req->rq_flags & RQF_QUEUED)
 		blk_queue_end_tag(req->q, req);
 
 	BUG_ON(blk_queued_rq(req));
@@ -2708,7 +2711,7 @@ void blk_finish_request(struct request *req, int error)
 
 	blk_delete_timer(req);
 
-	if (req->cmd_flags & REQ_DONTPREP)
+	if (req->rq_flags & RQF_DONTPREP)
 		blk_unprep_request(req);
 
 	blk_account_io_done(req);
diff --git a/block/blk-exec.c b/block/blk-exec.c
index 7ea0432..e2d30ea 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -72,7 +72,7 @@ void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
 	spin_lock_irq(q->queue_lock);
 
 	if (unlikely(blk_queue_dying(q))) {
-		rq->cmd_flags |= REQ_QUIET; 
+		rq->rq_flags |= RQF_QUIET; 
 		rq->errors = -ENXIO;
 		__blk_end_request_all(rq, rq->errors);
 		spin_unlock_irq(q->queue_lock);
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 6a14b68..3990b9c 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -56,7 +56,7 @@
  * Once while executing DATA and again after the whole sequence is
  * complete.  The first completion updates the contained bio but doesn't
  * finish it so that the bio submitter is notified only after the whole
- * sequence is complete.  This is implemented by testing REQ_FLUSH_SEQ in
+ * sequence is complete.  This is implemented by testing RQF_FLUSH_SEQ in
  * req_bio_endio().
  *
  * The above peculiarity requires that each FLUSH/FUA request has only one
@@ -127,7 +127,7 @@ static void blk_flush_restore_request(struct request *rq)
 	rq->bio = rq->biotail;
 
 	/* make @rq a normal request */
-	rq->cmd_flags &= ~REQ_FLUSH_SEQ;
+	rq->rq_flags &= ~RQF_FLUSH_SEQ;
 	rq->end_io = rq->flush.saved_end_io;
 }
 
@@ -330,7 +330,8 @@ static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq)
 	}
 
 	flush_rq->cmd_type = REQ_TYPE_FS;
-	req_set_op_attrs(flush_rq, REQ_OP_FLUSH, WRITE_FLUSH | REQ_FLUSH_SEQ);
+	req_set_op_attrs(flush_rq, REQ_OP_FLUSH, WRITE_FLUSH);
+	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
 	flush_rq->rq_disk = first_rq->rq_disk;
 	flush_rq->end_io = flush_end_io;
 
@@ -433,7 +434,7 @@ void blk_insert_flush(struct request *rq)
 	 */
 	memset(&rq->flush, 0, sizeof(rq->flush));
 	INIT_LIST_HEAD(&rq->flush.list);
-	rq->cmd_flags |= REQ_FLUSH_SEQ;
+	rq->rq_flags |= RQF_FLUSH_SEQ;
 	rq->flush.saved_end_io = rq->end_io; /* Usually NULL */
 	if (q->mq_ops) {
 		rq->end_io = mq_flush_data_end_io;
diff --git a/block/blk-map.c b/block/blk-map.c
index b8657fa..2c5ae5f 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -135,7 +135,7 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 	} while (iov_iter_count(&i));
 
 	if (!bio_flagged(bio, BIO_USER_MAPPED))
-		rq->cmd_flags |= REQ_COPY_USER;
+		rq->rq_flags |= RQF_COPY_USER;
 	return 0;
 
 unmap_rq:
@@ -232,7 +232,7 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 	if (do_copy)
-		rq->cmd_flags |= REQ_COPY_USER;
+		rq->rq_flags |= RQF_COPY_USER;
 
 	ret = blk_rq_append_bio(rq, bio);
 	if (unlikely(ret)) {
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2642e5f..fda6a12 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -456,7 +456,7 @@ int blk_rq_map_sg(struct request_queue *q, struct request *rq,
 	if (rq->bio)
 		nsegs = __blk_bios_map_sg(q, rq->bio, sglist, &sg);
 
-	if (unlikely(rq->cmd_flags & REQ_COPY_USER) &&
+	if (unlikely(rq->rq_flags & RQF_COPY_USER) &&
 	    (blk_rq_bytes(rq) & q->dma_pad_mask)) {
 		unsigned int pad_len =
 			(q->dma_pad_mask & ~blk_rq_bytes(rq)) + 1;
@@ -634,7 +634,7 @@ void blk_rq_set_mixed_merge(struct request *rq)
 	unsigned int ff = rq->cmd_flags & REQ_FAILFAST_MASK;
 	struct bio *bio;
 
-	if (rq->cmd_flags & REQ_MIXED_MERGE)
+	if (rq->rq_flags & RQF_MIXED_MERGE)
 		return;
 
 	/*
@@ -647,7 +647,7 @@ void blk_rq_set_mixed_merge(struct request *rq)
 			     (bio->bi_opf & REQ_FAILFAST_MASK) != ff);
 		bio->bi_opf |= ff;
 	}
-	rq->cmd_flags |= REQ_MIXED_MERGE;
+	rq->rq_flags |= RQF_MIXED_MERGE;
 }
 
 static void blk_account_io_merge(struct request *req)
@@ -709,7 +709,7 @@ static int attempt_merge(struct request_queue *q, struct request *req,
 	 * makes sure that all involved bios have mixable attributes
 	 * set properly.
 	 */
-	if ((req->cmd_flags | next->cmd_flags) & REQ_MIXED_MERGE ||
+	if (((req->rq_flags | next->rq_flags) & RQF_MIXED_MERGE) ||
 	    (req->cmd_flags & REQ_FAILFAST_MASK) !=
 	    (next->cmd_flags & REQ_FAILFAST_MASK)) {
 		blk_rq_set_mixed_merge(req);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ddc2eed..297646d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -142,14 +142,13 @@ static void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
 			       struct request *rq, int op,
 			       unsigned int op_flags)
 {
-	if (blk_queue_io_stat(q))
-		op_flags |= REQ_IO_STAT;
-
 	INIT_LIST_HEAD(&rq->queuelist);
 	/* csd/requeue_work/fifo_time is initialized before use */
 	rq->q = q;
 	rq->mq_ctx = ctx;
 	req_set_op_attrs(rq, op, op_flags);
+	if (blk_queue_io_stat(q))
+		rq->rq_flags |= RQF_IO_STAT;
 	/* do not touch atomic flags, it needs atomic ops against the timer */
 	rq->cpu = -1;
 	INIT_HLIST_NODE(&rq->hash);
@@ -198,7 +197,7 @@ __blk_mq_alloc_request(struct blk_mq_alloc_data *data, int op, int op_flags)
 		rq = data->hctx->tags->rqs[tag];
 
 		if (blk_mq_tag_busy(data->hctx)) {
-			rq->cmd_flags = REQ_MQ_INFLIGHT;
+			rq->rq_flags = RQF_MQ_INFLIGHT;
 			atomic_inc(&data->hctx->nr_active);
 		}
 
@@ -298,9 +297,9 @@ static void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx,
 	const int tag = rq->tag;
 	struct request_queue *q = rq->q;
 
-	if (rq->cmd_flags & REQ_MQ_INFLIGHT)
+	if (rq->rq_flags & RQF_MQ_INFLIGHT)
 		atomic_dec(&hctx->nr_active);
-	rq->cmd_flags = 0;
+	rq->rq_flags = 0;
 
 	clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
 	blk_mq_put_tag(hctx, ctx, tag);
@@ -489,10 +488,10 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	spin_unlock_irqrestore(&q->requeue_lock, flags);
 
 	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
-		if (!(rq->cmd_flags & REQ_SOFTBARRIER))
+		if (!(rq->rq_flags & RQF_SOFTBARRIER))
 			continue;
 
-		rq->cmd_flags &= ~REQ_SOFTBARRIER;
+		rq->rq_flags &= ~RQF_SOFTBARRIER;
 		list_del_init(&rq->queuelist);
 		blk_mq_insert_request(rq, true, false, false);
 	}
@@ -519,11 +518,11 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head)
 	 * We abuse this flag that is otherwise used by the I/O scheduler to
 	 * request head insertation from the workqueue.
 	 */
-	BUG_ON(rq->cmd_flags & REQ_SOFTBARRIER);
+	BUG_ON(rq->rq_flags & RQF_SOFTBARRIER);
 
 	spin_lock_irqsave(&q->requeue_lock, flags);
 	if (at_head) {
-		rq->cmd_flags |= REQ_SOFTBARRIER;
+		rq->rq_flags |= RQF_SOFTBARRIER;
 		list_add(&rq->queuelist, &q->requeue_list);
 	} else {
 		list_add_tail(&rq->queuelist, &q->requeue_list);
diff --git a/block/blk-tag.c b/block/blk-tag.c
index f0344e6..bae1dec 100644
--- a/block/blk-tag.c
+++ b/block/blk-tag.c
@@ -270,7 +270,7 @@ void blk_queue_end_tag(struct request_queue *q, struct request *rq)
 	BUG_ON(tag >= bqt->real_max_depth);
 
 	list_del_init(&rq->queuelist);
-	rq->cmd_flags &= ~REQ_QUEUED;
+	rq->rq_flags &= ~RQF_QUEUED;
 	rq->tag = -1;
 
 	if (unlikely(bqt->tag_index[tag] == NULL))
@@ -316,7 +316,7 @@ int blk_queue_start_tag(struct request_queue *q, struct request *rq)
 	unsigned max_depth;
 	int tag;
 
-	if (unlikely((rq->cmd_flags & REQ_QUEUED))) {
+	if (unlikely((rq->rq_flags & RQF_QUEUED))) {
 		printk(KERN_ERR
 		       "%s: request %p for device [%s] already tagged %d",
 		       __func__, rq,
@@ -371,7 +371,7 @@ int blk_queue_start_tag(struct request_queue *q, struct request *rq)
 	 */
 
 	bqt->next_tag = (tag + 1) % bqt->max_depth;
-	rq->cmd_flags |= REQ_QUEUED;
+	rq->rq_flags |= RQF_QUEUED;
 	rq->tag = tag;
 	bqt->tag_index[tag] = rq;
 	blk_start_request(rq);
diff --git a/block/blk.h b/block/blk.h
index 74444c4..aa132de 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -130,7 +130,7 @@ static inline void blk_clear_rq_complete(struct request *rq)
 /*
  * Internal elevator interface
  */
-#define ELV_ON_HASH(rq) ((rq)->cmd_flags & REQ_HASHED)
+#define ELV_ON_HASH(rq) ((rq)->rq_flags & RQF_HASHED)
 
 void blk_insert_flush(struct request *rq);
 
@@ -247,7 +247,7 @@ extern int blk_update_nr_requests(struct request_queue *, unsigned int);
 static inline int blk_do_io_stat(struct request *rq)
 {
 	return rq->rq_disk &&
-	       (rq->cmd_flags & REQ_IO_STAT) &&
+	       (rq->rq_flags & RQF_IO_STAT) &&
 		(rq->cmd_type == REQ_TYPE_FS);
 }
 
diff --git a/block/elevator.c b/block/elevator.c
index f7d973a..ac80f89 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -245,7 +245,7 @@ EXPORT_SYMBOL(elevator_exit);
 static inline void __elv_rqhash_del(struct request *rq)
 {
 	hash_del(&rq->hash);
-	rq->cmd_flags &= ~REQ_HASHED;
+	rq->rq_flags &= ~RQF_HASHED;
 }
 
 static void elv_rqhash_del(struct request_queue *q, struct request *rq)
@@ -260,7 +260,7 @@ static void elv_rqhash_add(struct request_queue *q, struct request *rq)
 
 	BUG_ON(ELV_ON_HASH(rq));
 	hash_add(e->hash, &rq->hash, rq_hash_key(rq));
-	rq->cmd_flags |= REQ_HASHED;
+	rq->rq_flags |= RQF_HASHED;
 }
 
 static void elv_rqhash_reposition(struct request_queue *q, struct request *rq)
@@ -352,7 +352,6 @@ void elv_dispatch_sort(struct request_queue *q, struct request *rq)
 {
 	sector_t boundary;
 	struct list_head *entry;
-	int stop_flags;
 
 	if (q->last_merge == rq)
 		q->last_merge = NULL;
@@ -362,7 +361,6 @@ void elv_dispatch_sort(struct request_queue *q, struct request *rq)
 	q->nr_sorted--;
 
 	boundary = q->end_sector;
-	stop_flags = REQ_SOFTBARRIER | REQ_STARTED;
 	list_for_each_prev(entry, &q->queue_head) {
 		struct request *pos = list_entry_rq(entry);
 
@@ -370,7 +368,7 @@ void elv_dispatch_sort(struct request_queue *q, struct request *rq)
 			break;
 		if (rq_data_dir(rq) != rq_data_dir(pos))
 			break;
-		if (pos->cmd_flags & stop_flags)
+		if (pos->rq_flags & (RQF_STARTED | RQF_SOFTBARRIER))
 			break;
 		if (blk_rq_pos(rq) >= boundary) {
 			if (blk_rq_pos(pos) < boundary)
@@ -510,7 +508,7 @@ void elv_merge_requests(struct request_queue *q, struct request *rq,
 			     struct request *next)
 {
 	struct elevator_queue *e = q->elevator;
-	const int next_sorted = next->cmd_flags & REQ_SORTED;
+	const int next_sorted = next->rq_flags & RQF_SORTED;
 
 	if (next_sorted && e->type->ops.elevator_merge_req_fn)
 		e->type->ops.elevator_merge_req_fn(q, rq, next);
@@ -537,13 +535,13 @@ void elv_bio_merged(struct request_queue *q, struct request *rq,
 #ifdef CONFIG_PM
 static void blk_pm_requeue_request(struct request *rq)
 {
-	if (rq->q->dev && !(rq->cmd_flags & REQ_PM))
+	if (rq->q->dev && !(rq->rq_flags & RQF_PM))
 		rq->q->nr_pending--;
 }
 
 static void blk_pm_add_request(struct request_queue *q, struct request *rq)
 {
-	if (q->dev && !(rq->cmd_flags & REQ_PM) && q->nr_pending++ == 0 &&
+	if (q->dev && !(rq->rq_flags & RQF_PM) && q->nr_pending++ == 0 &&
 	    (q->rpm_status == RPM_SUSPENDED || q->rpm_status == RPM_SUSPENDING))
 		pm_request_resume(q->dev);
 }
@@ -563,11 +561,11 @@ void elv_requeue_request(struct request_queue *q, struct request *rq)
 	 */
 	if (blk_account_rq(rq)) {
 		q->in_flight[rq_is_sync(rq)]--;
-		if (rq->cmd_flags & REQ_SORTED)
+		if (rq->rq_flags & RQF_SORTED)
 			elv_deactivate_rq(q, rq);
 	}
 
-	rq->cmd_flags &= ~REQ_STARTED;
+	rq->rq_flags &= ~RQF_STARTED;
 
 	blk_pm_requeue_request(rq);
 
@@ -597,13 +595,13 @@ void __elv_add_request(struct request_queue *q, struct request *rq, int where)
 
 	rq->q = q;
 
-	if (rq->cmd_flags & REQ_SOFTBARRIER) {
+	if (rq->rq_flags & RQF_SOFTBARRIER) {
 		/* barriers are scheduling boundary, update end_sector */
 		if (rq->cmd_type == REQ_TYPE_FS) {
 			q->end_sector = rq_end_sector(rq);
 			q->boundary_rq = rq;
 		}
-	} else if (!(rq->cmd_flags & REQ_ELVPRIV) &&
+	} else if (!(rq->rq_flags & RQF_ELVPRIV) &&
 		    (where == ELEVATOR_INSERT_SORT ||
 		     where == ELEVATOR_INSERT_SORT_MERGE))
 		where = ELEVATOR_INSERT_BACK;
@@ -611,12 +609,12 @@ void __elv_add_request(struct request_queue *q, struct request *rq, int where)
 	switch (where) {
 	case ELEVATOR_INSERT_REQUEUE:
 	case ELEVATOR_INSERT_FRONT:
-		rq->cmd_flags |= REQ_SOFTBARRIER;
+		rq->rq_flags |= RQF_SOFTBARRIER;
 		list_add(&rq->queuelist, &q->queue_head);
 		break;
 
 	case ELEVATOR_INSERT_BACK:
-		rq->cmd_flags |= REQ_SOFTBARRIER;
+		rq->rq_flags |= RQF_SOFTBARRIER;
 		elv_drain_elevator(q);
 		list_add_tail(&rq->queuelist, &q->queue_head);
 		/*
@@ -642,7 +640,7 @@ void __elv_add_request(struct request_queue *q, struct request *rq, int where)
 			break;
 	case ELEVATOR_INSERT_SORT:
 		BUG_ON(rq->cmd_type != REQ_TYPE_FS);
-		rq->cmd_flags |= REQ_SORTED;
+		rq->rq_flags |= RQF_SORTED;
 		q->nr_sorted++;
 		if (rq_mergeable(rq)) {
 			elv_rqhash_add(q, rq);
@@ -659,7 +657,7 @@ void __elv_add_request(struct request_queue *q, struct request *rq, int where)
 		break;
 
 	case ELEVATOR_INSERT_FLUSH:
-		rq->cmd_flags |= REQ_SOFTBARRIER;
+		rq->rq_flags |= RQF_SOFTBARRIER;
 		blk_insert_flush(rq);
 		break;
 	default:
@@ -735,7 +733,7 @@ void elv_completed_request(struct request_queue *q, struct request *rq)
 	 */
 	if (blk_account_rq(rq)) {
 		q->in_flight[rq_is_sync(rq)]--;
-		if ((rq->cmd_flags & REQ_SORTED) &&
+		if ((rq->rq_flags & RQF_SORTED) &&
 		    e->type->ops.elevator_completed_req_fn)
 			e->type->ops.elevator_completed_req_fn(q, rq);
 	}
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 90fa4ac..7cf795e 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -721,7 +721,7 @@ static int pkt_generic_packet(struct pktcdvd_device *pd, struct packet_command *
 
 	rq->timeout = 60*HZ;
 	if (cgc->quiet)
-		rq->cmd_flags |= REQ_QUIET;
+		rq->rq_flags |= RQF_QUIET;
 
 	blk_execute_rq(rq->q, pd->bdev->bd_disk, rq, 0);
 	if (rq->errors)
diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 05352f4..f90ea22 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -211,7 +211,7 @@ void ide_prep_sense(ide_drive_t *drive, struct request *rq)
 	sense_rq->cmd[0] = GPCMD_REQUEST_SENSE;
 	sense_rq->cmd[4] = cmd_len;
 	sense_rq->cmd_type = REQ_TYPE_ATA_SENSE;
-	sense_rq->cmd_flags |= REQ_PREEMPT;
+	sense_rq->rq_flags |= RQF_PREEMPT;
 
 	if (drive->media == ide_tape)
 		sense_rq->cmd[13] = REQ_IDETAPE_PC1;
@@ -295,7 +295,7 @@ int ide_cd_expiry(ide_drive_t *drive)
 		wait = ATAPI_WAIT_PC;
 		break;
 	default:
-		if (!(rq->cmd_flags & REQ_QUIET))
+		if (!(rq->rq_flags & RQF_QUIET))
 			printk(KERN_INFO PFX "cmd 0x%x timed out\n",
 					 rq->cmd[0]);
 		wait = 0;
@@ -375,7 +375,7 @@ int ide_check_ireason(ide_drive_t *drive, struct request *rq, int len,
 	}
 
 	if (dev_is_idecd(drive) && rq->cmd_type == REQ_TYPE_ATA_PC)
-		rq->cmd_flags |= REQ_FAILED;
+		rq->rq_flags |= RQF_FAILED;
 
 	return 1;
 }
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index bf9a2ad..9cbd217 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -98,7 +98,7 @@ static int cdrom_log_sense(ide_drive_t *drive, struct request *rq)
 	struct request_sense *sense = &drive->sense_data;
 	int log = 0;
 
-	if (!sense || !rq || (rq->cmd_flags & REQ_QUIET))
+	if (!sense || !rq || (rq->rq_flags & RQF_QUIET))
 		return 0;
 
 	ide_debug_log(IDE_DBG_SENSE, "sense_key: 0x%x", sense->sense_key);
@@ -291,7 +291,7 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 		 * (probably while trying to recover from a former error).
 		 * Just give up.
 		 */
-		rq->cmd_flags |= REQ_FAILED;
+		rq->rq_flags |= RQF_FAILED;
 		return 2;
 	}
 
@@ -311,7 +311,7 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 			cdrom_saw_media_change(drive);
 
 			if (rq->cmd_type == REQ_TYPE_FS &&
-			    !(rq->cmd_flags & REQ_QUIET))
+			    !(rq->rq_flags & RQF_QUIET))
 				printk(KERN_ERR PFX "%s: tray open\n",
 					drive->name);
 		}
@@ -346,7 +346,7 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 		 * No point in retrying after an illegal request or data
 		 * protect error.
 		 */
-		if (!(rq->cmd_flags & REQ_QUIET))
+		if (!(rq->rq_flags & RQF_QUIET))
 			ide_dump_status(drive, "command error", stat);
 		do_end_request = 1;
 		break;
@@ -355,14 +355,14 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 		 * No point in re-trying a zillion times on a bad sector.
 		 * If we got here the error is not correctable.
 		 */
-		if (!(rq->cmd_flags & REQ_QUIET))
+		if (!(rq->rq_flags & RQF_QUIET))
 			ide_dump_status(drive, "media error "
 					"(bad sector)", stat);
 		do_end_request = 1;
 		break;
 	case BLANK_CHECK:
 		/* disk appears blank? */
-		if (!(rq->cmd_flags & REQ_QUIET))
+		if (!(rq->rq_flags & RQF_QUIET))
 			ide_dump_status(drive, "media error (blank)",
 					stat);
 		do_end_request = 1;
@@ -380,7 +380,7 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 	}
 
 	if (rq->cmd_type != REQ_TYPE_FS) {
-		rq->cmd_flags |= REQ_FAILED;
+		rq->rq_flags |= RQF_FAILED;
 		do_end_request = 1;
 	}
 
@@ -422,19 +422,19 @@ static void ide_cd_request_sense_fixup(ide_drive_t *drive, struct ide_cmd *cmd)
 int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 		    int write, void *buffer, unsigned *bufflen,
 		    struct request_sense *sense, int timeout,
-		    unsigned int cmd_flags)
+		    req_flags_t rq_flags)
 {
 	struct cdrom_info *info = drive->driver_data;
 	struct request_sense local_sense;
 	int retries = 10;
-	unsigned int flags = 0;
+	req_flags_t flags = 0;
 
 	if (!sense)
 		sense = &local_sense;
 
 	ide_debug_log(IDE_DBG_PC, "cmd[0]: 0x%x, write: 0x%x, timeout: %d, "
-				  "cmd_flags: 0x%x",
-				  cmd[0], write, timeout, cmd_flags);
+				  "rq_flags: 0x%x",
+				  cmd[0], write, timeout, rq_flags);
 
 	/* start of retry loop */
 	do {
@@ -446,7 +446,7 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 		memcpy(rq->cmd, cmd, BLK_MAX_CDB);
 		rq->cmd_type = REQ_TYPE_ATA_PC;
 		rq->sense = sense;
-		rq->cmd_flags |= cmd_flags;
+		rq->rq_flags |= rq_flags;
 		rq->timeout = timeout;
 		if (buffer) {
 			error = blk_rq_map_kern(drive->queue, rq, buffer,
@@ -462,14 +462,14 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 		if (buffer)
 			*bufflen = rq->resid_len;
 
-		flags = rq->cmd_flags;
+		flags = rq->rq_flags;
 		blk_put_request(rq);
 
 		/*
 		 * FIXME: we should probably abort/retry or something in case of
 		 * failure.
 		 */
-		if (flags & REQ_FAILED) {
+		if (flags & RQF_FAILED) {
 			/*
 			 * The request failed.  Retry if it was due to a unit
 			 * attention status (usually means media was changed).
@@ -494,10 +494,10 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 		}
 
 		/* end of retry loop */
-	} while ((flags & REQ_FAILED) && retries >= 0);
+	} while ((flags & RQF_FAILED) && retries >= 0);
 
 	/* return an error if the command failed */
-	return (flags & REQ_FAILED) ? -EIO : 0;
+	return (flags & RQF_FAILED) ? -EIO : 0;
 }
 
 /*
@@ -589,7 +589,7 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
 					"(%u bytes)\n", drive->name, __func__,
 					cmd->nleft);
 				if (!write)
-					rq->cmd_flags |= REQ_FAILED;
+					rq->rq_flags |= RQF_FAILED;
 				uptodate = 0;
 			}
 		} else if (rq->cmd_type != REQ_TYPE_BLOCK_PC) {
@@ -607,7 +607,7 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
 			}
 
 			if (!uptodate)
-				rq->cmd_flags |= REQ_FAILED;
+				rq->rq_flags |= RQF_FAILED;
 		}
 		goto out_end;
 	}
@@ -745,9 +745,9 @@ static void cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
 				  rq->cmd[0], rq->cmd_type);
 
 	if (rq->cmd_type == REQ_TYPE_BLOCK_PC)
-		rq->cmd_flags |= REQ_QUIET;
+		rq->rq_flags |= RQF_QUIET;
 	else
-		rq->cmd_flags &= ~REQ_FAILED;
+		rq->rq_flags &= ~RQF_FAILED;
 
 	drive->dma = 0;
 
@@ -867,7 +867,7 @@ int cdrom_check_status(ide_drive_t *drive, struct request_sense *sense)
 	 */
 	cmd[7] = cdi->sanyo_slot % 3;
 
-	return ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, sense, 0, REQ_QUIET);
+	return ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, sense, 0, RQF_QUIET);
 }
 
 static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
@@ -890,7 +890,7 @@ static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
 	cmd[0] = GPCMD_READ_CDVD_CAPACITY;
 
 	stat = ide_cd_queue_pc(drive, cmd, 0, &capbuf, &len, sense, 0,
-			       REQ_QUIET);
+			       RQF_QUIET);
 	if (stat)
 		return stat;
 
@@ -943,7 +943,7 @@ static int cdrom_read_tocentry(ide_drive_t *drive, int trackno, int msf_flag,
 	if (msf_flag)
 		cmd[1] = 2;
 
-	return ide_cd_queue_pc(drive, cmd, 0, buf, &buflen, sense, 0, REQ_QUIET);
+	return ide_cd_queue_pc(drive, cmd, 0, buf, &buflen, sense, 0, RQF_QUIET);
 }
 
 /* Try to read the entire TOC for the disk into our internal buffer. */
diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
index 1efc936..eea60c9 100644
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -101,7 +101,7 @@ void ide_cd_log_error(const char *, struct request *, struct request_sense *);
 
 /* ide-cd.c functions used by ide-cd_ioctl.c */
 int ide_cd_queue_pc(ide_drive_t *, const unsigned char *, int, void *,
-		    unsigned *, struct request_sense *, int, unsigned int);
+		    unsigned *, struct request_sense *, int, req_flags_t);
 int ide_cd_read_toc(ide_drive_t *, struct request_sense *);
 int ide_cdrom_get_capabilities(ide_drive_t *, u8 *);
 void ide_cdrom_update_speed(ide_drive_t *, u8 *);
diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 5887a7a..f085e3a 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -305,7 +305,7 @@ int ide_cdrom_reset(struct cdrom_device_info *cdi)
 
 	rq = blk_get_request(drive->queue, READ, __GFP_RECLAIM);
 	rq->cmd_type = REQ_TYPE_DRV_PRIV;
-	rq->cmd_flags = REQ_QUIET;
+	rq->rq_flags = RQF_QUIET;
 	ret = blk_execute_rq(drive->queue, cd->disk, rq, 0);
 	blk_put_request(rq);
 	/*
@@ -449,7 +449,7 @@ int ide_cdrom_packet(struct cdrom_device_info *cdi,
 			    struct packet_command *cgc)
 {
 	ide_drive_t *drive = cdi->handle;
-	unsigned int flags = 0;
+	req_flags_t flags = 0;
 	unsigned len = cgc->buflen;
 
 	if (cgc->timeout <= 0)
@@ -463,7 +463,7 @@ int ide_cdrom_packet(struct cdrom_device_info *cdi,
 		memset(cgc->sense, 0, sizeof(struct request_sense));
 
 	if (cgc->quiet)
-		flags |= REQ_QUIET;
+		flags |= RQF_QUIET;
 
 	cgc->stat = ide_cd_queue_pc(drive, cgc->cmd,
 				    cgc->data_direction == CGC_DATA_WRITE,
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 669ea1e..6360bbd 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -307,7 +307,7 @@ static ide_startstop_t start_request (ide_drive_t *drive, struct request *rq)
 {
 	ide_startstop_t startstop;
 
-	BUG_ON(!(rq->cmd_flags & REQ_STARTED));
+	BUG_ON(!(rq->rq_flags & RQF_STARTED));
 
 #ifdef DEBUG
 	printk("%s: start_request: current=0x%08lx\n",
@@ -316,7 +316,7 @@ static ide_startstop_t start_request (ide_drive_t *drive, struct request *rq)
 
 	/* bail early if we've exceeded max_failures */
 	if (drive->max_failures && (drive->failures > drive->max_failures)) {
-		rq->cmd_flags |= REQ_FAILED;
+		rq->rq_flags |= RQF_FAILED;
 		goto kill_rq;
 	}
 
@@ -539,7 +539,7 @@ void do_ide_request(struct request_queue *q)
 		 */
 		if ((drive->dev_flags & IDE_DFLAG_BLOCKED) &&
 		    ata_pm_request(rq) == 0 &&
-		    (rq->cmd_flags & REQ_PREEMPT) == 0) {
+		    (rq->rq_flags & RQF_PREEMPT) == 0) {
 			/* there should be no pending command at this point */
 			ide_unlock_port(hwif);
 			goto plug_device;
diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
index e34af48..a015acd 100644
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -53,7 +53,7 @@ static int ide_pm_execute_rq(struct request *rq)
 
 	spin_lock_irq(q->queue_lock);
 	if (unlikely(blk_queue_dying(q))) {
-		rq->cmd_flags |= REQ_QUIET;
+		rq->rq_flags |= RQF_QUIET;
 		rq->errors = -ENXIO;
 		__blk_end_request_all(rq, rq->errors);
 		spin_unlock_irq(q->queue_lock);
@@ -90,7 +90,7 @@ int generic_ide_resume(struct device *dev)
 	memset(&rqpm, 0, sizeof(rqpm));
 	rq = blk_get_request(drive->queue, READ, __GFP_RECLAIM);
 	rq->cmd_type = REQ_TYPE_ATA_PM_RESUME;
-	rq->cmd_flags |= REQ_PREEMPT;
+	rq->rq_flags |= RQF_PREEMPT;
 	rq->special = &rqpm;
 	rqpm.pm_step = IDE_PM_START_RESUME;
 	rqpm.pm_state = PM_EVENT_ON;
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index dc75bea..f76cc36 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -313,7 +313,7 @@ static void dm_unprep_request(struct request *rq)
 
 	if (!rq->q->mq_ops) {
 		rq->special = NULL;
-		rq->cmd_flags &= ~REQ_DONTPREP;
+		rq->rq_flags &= ~RQF_DONTPREP;
 	}
 
 	if (clone)
@@ -431,7 +431,7 @@ static void dm_softirq_done(struct request *rq)
 		return;
 	}
 
-	if (rq->cmd_flags & REQ_FAILED)
+	if (rq->rq_flags & RQF_FAILED)
 		mapped = false;
 
 	dm_done(clone, tio->error, mapped);
@@ -460,7 +460,7 @@ static void dm_complete_request(struct request *rq, int error)
  */
 static void dm_kill_unmapped_request(struct request *rq, int error)
 {
-	rq->cmd_flags |= REQ_FAILED;
+	rq->rq_flags |= RQF_FAILED;
 	dm_complete_request(rq, error);
 }
 
@@ -476,7 +476,7 @@ static void end_clone_request(struct request *clone, int error)
 		 * For just cleaning up the information of the queue in which
 		 * the clone was dispatched.
 		 * The clone is *NOT* freed actually here because it is alloced
-		 * from dm own mempool (REQ_ALLOCED isn't set).
+		 * from dm own mempool (RQF_ALLOCED isn't set).
 		 */
 		__blk_put_request(clone->q, clone);
 	}
@@ -497,7 +497,7 @@ static void dm_dispatch_clone_request(struct request *clone, struct request *rq)
 	int r;
 
 	if (blk_queue_io_stat(clone->q))
-		clone->cmd_flags |= REQ_IO_STAT;
+		clone->rq_flags |= RQF_IO_STAT;
 
 	clone->start_time = jiffies;
 	r = blk_insert_cloned_request(clone->q, clone);
@@ -633,7 +633,7 @@ static int dm_old_prep_fn(struct request_queue *q, struct request *rq)
 		return BLKPREP_DEFER;
 
 	rq->special = tio;
-	rq->cmd_flags |= REQ_DONTPREP;
+	rq->rq_flags |= RQF_DONTPREP;
 
 	return BLKPREP_OK;
 }
diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index aacf584..f3512404 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2006,7 +2006,7 @@ static int msb_prepare_req(struct request_queue *q, struct request *req)
 		blk_dump_rq_flags(req, "MS unsupported request");
 		return BLKPREP_KILL;
 	}
-	req->cmd_flags |= REQ_DONTPREP;
+	req->rq_flags |= RQF_DONTPREP;
 	return BLKPREP_OK;
 }
 
diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index c147227..fa0746d 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -834,7 +834,7 @@ static int mspro_block_prepare_req(struct request_queue *q, struct request *req)
 		return BLKPREP_KILL;
 	}
 
-	req->cmd_flags |= REQ_DONTPREP;
+	req->rq_flags |= RQF_DONTPREP;
 
 	return BLKPREP_OK;
 }
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c333511..f8190dd 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2117,7 +2117,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 		mmc_blk_abort_packed_req(mq_rq);
 	} else {
 		if (mmc_card_removed(card))
-			req->cmd_flags |= REQ_QUIET;
+			req->rq_flags |= RQF_QUIET;
 		while (ret)
 			ret = blk_end_request(req, -EIO,
 					blk_rq_cur_bytes(req));
@@ -2126,7 +2126,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
  start_new_req:
 	if (rqc) {
 		if (mmc_card_removed(card)) {
-			rqc->cmd_flags |= REQ_QUIET;
+			rqc->rq_flags |= RQF_QUIET;
 			blk_end_request_all(rqc, -EIO);
 		} else {
 			/*
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 8037f73..8a67f1c 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -44,7 +44,7 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 	if (mq && (mmc_card_removed(mq->card) || mmc_access_rpmb(mq)))
 		return BLKPREP_KILL;
 
-	req->cmd_flags |= REQ_DONTPREP;
+	req->rq_flags |= RQF_DONTPREP;
 
 	return BLKPREP_OK;
 }
@@ -120,7 +120,7 @@ static void mmc_request_fn(struct request_queue *q)
 
 	if (!mq) {
 		while ((req = blk_fetch_request(q)) != NULL) {
-			req->cmd_flags |= REQ_QUIET;
+			req->rq_flags |= RQF_QUIET;
 			__blk_end_request_all(req, -EIO);
 		}
 		return;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0fc99f0..0955e9d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -323,9 +323,9 @@ static int nvme_init_iod(struct request *rq, unsigned size,
 	iod->nents = 0;
 	iod->length = size;
 
-	if (!(rq->cmd_flags & REQ_DONTPREP)) {
+	if (!(rq->rq_flags & RQF_DONTPREP)) {
 		rq->retries = 0;
-		rq->cmd_flags |= REQ_DONTPREP;
+		rq->rq_flags |= RQF_DONTPREP;
 	}
 	return 0;
 }
diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index 241829e..05813a4 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -154,7 +154,8 @@ static int submit_rtpg(struct scsi_device *sdev, unsigned char *buff,
 	return scsi_execute_req_flags(sdev, cdb, DMA_FROM_DEVICE,
 				      buff, bufflen, sshdr,
 				      ALUA_FAILOVER_TIMEOUT * HZ,
-				      ALUA_FAILOVER_RETRIES, NULL, req_flags);
+				      ALUA_FAILOVER_RETRIES, NULL,
+				      req_flags, 0);
 }
 
 /*
@@ -187,7 +188,8 @@ static int submit_stpg(struct scsi_device *sdev, int group_id,
 	return scsi_execute_req_flags(sdev, cdb, DMA_TO_DEVICE,
 				      stpg_data, stpg_len,
 				      sshdr, ALUA_FAILOVER_TIMEOUT * HZ,
-				      ALUA_FAILOVER_RETRIES, NULL, req_flags);
+				      ALUA_FAILOVER_RETRIES, NULL,
+				      req_flags, 0);
 }
 
 static struct alua_port_group *alua_find_get_pg(char *id_str, size_t id_size,
@@ -1063,7 +1065,7 @@ static int alua_prep_fn(struct scsi_device *sdev, struct request *req)
 		 state != SCSI_ACCESS_STATE_ACTIVE &&
 		 state != SCSI_ACCESS_STATE_LBA) {
 		ret = BLKPREP_KILL;
-		req->cmd_flags |= REQ_QUIET;
+		req->rq_flags |= RQF_QUIET;
 	}
 	return ret;
 
diff --git a/drivers/scsi/device_handler/scsi_dh_emc.c b/drivers/scsi/device_handler/scsi_dh_emc.c
index 375d818..5b80746 100644
--- a/drivers/scsi/device_handler/scsi_dh_emc.c
+++ b/drivers/scsi/device_handler/scsi_dh_emc.c
@@ -452,7 +452,7 @@ static int clariion_prep_fn(struct scsi_device *sdev, struct request *req)
 
 	if (h->lun_state != CLARIION_LUN_OWNED) {
 		ret = BLKPREP_KILL;
-		req->cmd_flags |= REQ_QUIET;
+		req->rq_flags |= RQF_QUIET;
 	}
 	return ret;
 
diff --git a/drivers/scsi/device_handler/scsi_dh_hp_sw.c b/drivers/scsi/device_handler/scsi_dh_hp_sw.c
index 9406d5f..308e871 100644
--- a/drivers/scsi/device_handler/scsi_dh_hp_sw.c
+++ b/drivers/scsi/device_handler/scsi_dh_hp_sw.c
@@ -266,7 +266,7 @@ static int hp_sw_prep_fn(struct scsi_device *sdev, struct request *req)
 
 	if (h->path_state != HP_SW_PATH_ACTIVE) {
 		ret = BLKPREP_KILL;
-		req->cmd_flags |= REQ_QUIET;
+		req->rq_flags |= RQF_QUIET;
 	}
 	return ret;
 
diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c b/drivers/scsi/device_handler/scsi_dh_rdac.c
index 06fbd0b..00d9c32 100644
--- a/drivers/scsi/device_handler/scsi_dh_rdac.c
+++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
@@ -724,7 +724,7 @@ static int rdac_prep_fn(struct scsi_device *sdev, struct request *req)
 
 	if (h->state != RDAC_STATE_ACTIVE) {
 		ret = BLKPREP_KILL;
-		req->cmd_flags |= REQ_QUIET;
+		req->rq_flags |= RQF_QUIET;
 	}
 	return ret;
 
diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
index 2f2a991..ef99f62 100644
--- a/drivers/scsi/osd/osd_initiator.c
+++ b/drivers/scsi/osd/osd_initiator.c
@@ -1595,7 +1595,7 @@ static int _init_blk_request(struct osd_request *or,
 	}
 
 	or->request = req;
-	req->cmd_flags |= REQ_QUIET;
+	req->rq_flags |= RQF_QUIET;
 
 	req->timeout = or->timeout;
 	req->retries = or->retries;
diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
index 5033223..a2960f5 100644
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -368,7 +368,7 @@ static int osst_execute(struct osst_request *SRpnt, const unsigned char *cmd,
 		return DRIVER_ERROR << 24;
 
 	blk_rq_set_block_pc(req);
-	req->cmd_flags |= REQ_QUIET;
+	req->rq_flags |= RQF_QUIET;
 
 	SRpnt->bio = NULL;
 
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 106a6ad..996e134 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1988,7 +1988,7 @@ static void scsi_eh_lock_door(struct scsi_device *sdev)
 
 	req->cmd_len = COMMAND_SIZE(req->cmd[0]);
 
-	req->cmd_flags |= REQ_QUIET;
+	req->rq_flags |= RQF_QUIET;
 	req->timeout = 10 * HZ;
 	req->retries = 5;
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 2cca9cf..8c52622 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -163,26 +163,11 @@ void scsi_queue_insert(struct scsi_cmnd *cmd, int reason)
 {
 	__scsi_queue_insert(cmd, reason, 1);
 }
-/**
- * scsi_execute - insert request and wait for the result
- * @sdev:	scsi device
- * @cmd:	scsi command
- * @data_direction: data direction
- * @buffer:	data buffer
- * @bufflen:	len of buffer
- * @sense:	optional sense buffer
- * @timeout:	request timeout in seconds
- * @retries:	number of times to retry request
- * @flags:	or into request flags;
- * @resid:	optional residual length
- *
- * returns the req->errors value which is the scsi_cmnd result
- * field.
- */
-int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
+
+static int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 		 int data_direction, void *buffer, unsigned bufflen,
 		 unsigned char *sense, int timeout, int retries, u64 flags,
-		 int *resid)
+		 req_flags_t rq_flags, int *resid)
 {
 	struct request *req;
 	int write = (data_direction == DMA_TO_DEVICE);
@@ -203,7 +188,8 @@ int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	req->sense_len = 0;
 	req->retries = retries;
 	req->timeout = timeout;
-	req->cmd_flags |= flags | REQ_QUIET | REQ_PREEMPT;
+	req->cmd_flags |= flags;
+	req->rq_flags |= rq_flags | RQF_QUIET | RQF_PREEMPT;
 
 	/*
 	 * head injection *required* here otherwise quiesce won't work
@@ -227,12 +213,37 @@ int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 
 	return ret;
 }
+
+/**
+ * scsi_execute - insert request and wait for the result
+ * @sdev:	scsi device
+ * @cmd:	scsi command
+ * @data_direction: data direction
+ * @buffer:	data buffer
+ * @bufflen:	len of buffer
+ * @sense:	optional sense buffer
+ * @timeout:	request timeout in seconds
+ * @retries:	number of times to retry request
+ * @flags:	or into request flags;
+ * @resid:	optional residual length
+ *
+ * returns the req->errors value which is the scsi_cmnd result
+ * field.
+ */
+int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
+		 int data_direction, void *buffer, unsigned bufflen,
+		 unsigned char *sense, int timeout, int retries, u64 flags,
+		 int *resid)
+{
+	return __scsi_execute(sdev, cmd, data_direction, buffer, bufflen, sense,
+			timeout, retries, flags, 0, resid);
+}
 EXPORT_SYMBOL(scsi_execute);
 
 int scsi_execute_req_flags(struct scsi_device *sdev, const unsigned char *cmd,
 		     int data_direction, void *buffer, unsigned bufflen,
 		     struct scsi_sense_hdr *sshdr, int timeout, int retries,
-		     int *resid, u64 flags)
+		     int *resid, u64 flags, req_flags_t rq_flags)
 {
 	char *sense = NULL;
 	int result;
@@ -242,8 +253,8 @@ int scsi_execute_req_flags(struct scsi_device *sdev, const unsigned char *cmd,
 		if (!sense)
 			return DRIVER_ERROR << 24;
 	}
-	result = scsi_execute(sdev, cmd, data_direction, buffer, bufflen,
-			      sense, timeout, retries, flags, resid);
+	result = __scsi_execute(sdev, cmd, data_direction, buffer, bufflen,
+			      sense, timeout, retries, flags, rq_flags, resid);
 	if (sshdr)
 		scsi_normalize_sense(sense, SCSI_SENSE_BUFFERSIZE, sshdr);
 
@@ -813,7 +824,7 @@ void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes)
 		 */
 		if ((sshdr.asc == 0x0) && (sshdr.ascq == 0x1d))
 			;
-		else if (!(req->cmd_flags & REQ_QUIET))
+		else if (!(req->rq_flags & RQF_QUIET))
 			scsi_print_sense(cmd);
 		result = 0;
 		/* BLOCK_PC may have set error */
@@ -943,7 +954,7 @@ void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes)
 	switch (action) {
 	case ACTION_FAIL:
 		/* Give up and fail the remainder of the request */
-		if (!(req->cmd_flags & REQ_QUIET)) {
+		if (!(req->rq_flags & RQF_QUIET)) {
 			static DEFINE_RATELIMIT_STATE(_rs,
 					DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
@@ -972,7 +983,7 @@ void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes)
 		 * A new command will be prepared and issued.
 		 */
 		if (q->mq_ops) {
-			cmd->request->cmd_flags &= ~REQ_DONTPREP;
+			cmd->request->rq_flags &= ~RQF_DONTPREP;
 			scsi_mq_uninit_cmd(cmd);
 			scsi_mq_requeue_cmd(cmd);
 		} else {
@@ -1234,7 +1245,7 @@ scsi_prep_state_check(struct scsi_device *sdev, struct request *req)
 			/*
 			 * If the devices is blocked we defer normal commands.
 			 */
-			if (!(req->cmd_flags & REQ_PREEMPT))
+			if (!(req->rq_flags & RQF_PREEMPT))
 				ret = BLKPREP_DEFER;
 			break;
 		default:
@@ -1243,7 +1254,7 @@ scsi_prep_state_check(struct scsi_device *sdev, struct request *req)
 			 * special commands.  In particular any user initiated
 			 * command is not allowed.
 			 */
-			if (!(req->cmd_flags & REQ_PREEMPT))
+			if (!(req->rq_flags & RQF_PREEMPT))
 				ret = BLKPREP_KILL;
 			break;
 		}
@@ -1279,7 +1290,7 @@ scsi_prep_return(struct request_queue *q, struct request *req, int ret)
 			blk_delay_queue(q, SCSI_QUEUE_DELAY);
 		break;
 	default:
-		req->cmd_flags |= REQ_DONTPREP;
+		req->rq_flags |= RQF_DONTPREP;
 	}
 
 	return ret;
@@ -1736,7 +1747,7 @@ static void scsi_request_fn(struct request_queue *q)
 		 * we add the dev to the starved list so it eventually gets
 		 * a run when a tag is freed.
 		 */
-		if (blk_queue_tagged(q) && !(req->cmd_flags & REQ_QUEUED)) {
+		if (blk_queue_tagged(q) && !(req->rq_flags & RQF_QUEUED)) {
 			spin_lock_irq(shost->host_lock);
 			if (list_empty(&sdev->starved_entry))
 				list_add_tail(&sdev->starved_entry,
@@ -1903,11 +1914,11 @@ static int scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 		goto out_dec_target_busy;
 
 
-	if (!(req->cmd_flags & REQ_DONTPREP)) {
+	if (!(req->rq_flags & RQF_DONTPREP)) {
 		ret = prep_to_mq(scsi_mq_prep_fn(req));
 		if (ret)
 			goto out_dec_host_busy;
-		req->cmd_flags |= REQ_DONTPREP;
+		req->rq_flags |= RQF_DONTPREP;
 	} else {
 		blk_mq_start_request(req);
 	}
@@ -1952,7 +1963,7 @@ static int scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 		 * we hit an error, as we will never see this command
 		 * again.
 		 */
-		if (req->cmd_flags & REQ_DONTPREP)
+		if (req->rq_flags & RQF_DONTPREP)
 			scsi_mq_uninit_cmd(cmd);
 		break;
 	default:
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index b9618ff..cef1f78 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1520,7 +1520,7 @@ static int sd_sync_cache(struct scsi_disk *sdkp)
 		 */
 		res = scsi_execute_req_flags(sdp, cmd, DMA_NONE, NULL, 0,
 					     &sshdr, timeout, SD_MAX_RETRIES,
-					     NULL, REQ_PM);
+					     NULL, 0, RQF_PM);
 		if (res == 0)
 			break;
 	}
@@ -1879,7 +1879,7 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 
 					good_bytes = 0;
 					req->__data_len = blk_rq_bytes(req);
-					req->cmd_flags |= REQ_QUIET;
+					req->rq_flags |= RQF_QUIET;
 				}
 			}
 		}
@@ -3278,7 +3278,7 @@ static int sd_start_stop_device(struct scsi_disk *sdkp, int start)
 		return -ENODEV;
 
 	res = scsi_execute_req_flags(sdp, cmd, DMA_NONE, NULL, 0, &sshdr,
-			       SD_TIMEOUT, SD_MAX_RETRIES, NULL, REQ_PM);
+			       SD_TIMEOUT, SD_MAX_RETRIES, NULL, 0, RQF_PM);
 	if (res) {
 		sd_print_result(sdkp, "Start/Stop Unit failed", res);
 		if (driver_byte(res) & DRIVER_SENSE)
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 16d3fa6..b5d87d3 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -348,7 +348,7 @@ void sd_zbc_complete(struct scsi_cmnd *cmd,
 			 * this case, so be quiet about the error.
 			 */
 			if (req_op(rq) == REQ_OP_ZONE_RESET)
-				rq->cmd_flags |= REQ_QUIET;
+				rq->rq_flags |= RQF_QUIET;
 			break;
 		case 0x21:
 			/*
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 7af5226..3bc46a4 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -546,7 +546,7 @@ static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
 		return DRIVER_ERROR << 24;
 
 	blk_rq_set_block_pc(req);
-	req->cmd_flags |= REQ_QUIET;
+	req->rq_flags |= RQF_QUIET;
 
 	mdata->null_mapped = 1;
 
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 05c7456..cf54987 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5590,7 +5590,7 @@ ufshcd_send_request_sense(struct ufs_hba *hba, struct scsi_device *sdp)
 
 	ret = scsi_execute_req_flags(sdp, cmd, DMA_FROM_DEVICE, buffer,
 				SCSI_SENSE_BUFFERSIZE, NULL,
-				msecs_to_jiffies(1000), 3, NULL, REQ_PM);
+				msecs_to_jiffies(1000), 3, NULL, 0, RQF_PM);
 	if (ret)
 		pr_err("%s: failed with err %d\n", __func__, ret);
 
@@ -5652,11 +5652,11 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 
 	/*
 	 * Current function would be generally called from the power management
-	 * callbacks hence set the REQ_PM flag so that it doesn't resume the
+	 * callbacks hence set the RQF_PM flag so that it doesn't resume the
 	 * already suspended childs.
 	 */
 	ret = scsi_execute_req_flags(sdp, cmd, DMA_NONE, NULL, 0, &sshdr,
-				     START_STOP_TIMEOUT, 0, NULL, REQ_PM);
+				     START_STOP_TIMEOUT, 0, NULL, 0, RQF_PM);
 	if (ret) {
 		sdev_printk(KERN_WARNING, sdp,
 			    "START_STOP failed for power mode: %d, result %x\n",
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 6df722d..ec69a8f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -167,26 +167,6 @@ enum rq_flag_bits {
 	__REQ_PREFLUSH,		/* request for cache flush */
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 
-	/* request only flags */
-	__REQ_SORTED,		/* elevator knows about this request */
-	__REQ_SOFTBARRIER,	/* may not be passed by ioscheduler */
-	__REQ_STARTED,		/* drive already may have started this one */
-	__REQ_DONTPREP,		/* don't call prep for this one */
-	__REQ_QUEUED,		/* uses queueing */
-	__REQ_ELVPRIV,		/* elevator private data attached */
-	__REQ_FAILED,		/* set if the request failed */
-	__REQ_QUIET,		/* don't worry about errors */
-	__REQ_PREEMPT,		/* set for "ide_preempt" requests and also
-				   for requests for which the SCSI "quiesce"
-				   state must be ignored. */
-	__REQ_ALLOCED,		/* request came from our alloc pool */
-	__REQ_COPY_USER,	/* contains copies of user pages */
-	__REQ_FLUSH_SEQ,	/* request for flush sequence */
-	__REQ_IO_STAT,		/* account I/O stat */
-	__REQ_MIXED_MERGE,	/* merge of different types, fail separately */
-	__REQ_PM,		/* runtime pm request */
-	__REQ_HASHED,		/* on IO scheduler merge hash */
-	__REQ_MQ_INFLIGHT,	/* track inflight for MQ */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -208,29 +188,12 @@ enum rq_flag_bits {
 
 /* This mask is used for both bio and request merge checking */
 #define REQ_NOMERGE_FLAGS \
-	(REQ_NOMERGE | REQ_STARTED | REQ_SOFTBARRIER | REQ_PREFLUSH | REQ_FUA | REQ_FLUSH_SEQ)
+	(REQ_NOMERGE | REQ_PREFLUSH | REQ_FUA)
 
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
-#define REQ_SORTED		(1ULL << __REQ_SORTED)
-#define REQ_SOFTBARRIER		(1ULL << __REQ_SOFTBARRIER)
 #define REQ_FUA			(1ULL << __REQ_FUA)
 #define REQ_NOMERGE		(1ULL << __REQ_NOMERGE)
-#define REQ_STARTED		(1ULL << __REQ_STARTED)
-#define REQ_DONTPREP		(1ULL << __REQ_DONTPREP)
-#define REQ_QUEUED		(1ULL << __REQ_QUEUED)
-#define REQ_ELVPRIV		(1ULL << __REQ_ELVPRIV)
-#define REQ_FAILED		(1ULL << __REQ_FAILED)
-#define REQ_QUIET		(1ULL << __REQ_QUIET)
-#define REQ_PREEMPT		(1ULL << __REQ_PREEMPT)
-#define REQ_ALLOCED		(1ULL << __REQ_ALLOCED)
-#define REQ_COPY_USER		(1ULL << __REQ_COPY_USER)
 #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
-#define REQ_FLUSH_SEQ		(1ULL << __REQ_FLUSH_SEQ)
-#define REQ_IO_STAT		(1ULL << __REQ_IO_STAT)
-#define REQ_MIXED_MERGE		(1ULL << __REQ_MIXED_MERGE)
-#define REQ_PM			(1ULL << __REQ_PM)
-#define REQ_HASHED		(1ULL << __REQ_HASHED)
-#define REQ_MQ_INFLIGHT		(1ULL << __REQ_MQ_INFLIGHT)
 
 enum req_op {
 	REQ_OP_READ,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 90097dd..b4415fe 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -78,6 +78,50 @@ enum rq_cmd_type_bits {
 	REQ_TYPE_DRV_PRIV,		/* driver defined types from here */
 };
 
+/*
+ * request flags */
+typedef __u32 __bitwise req_flags_t;
+
+/* elevator knows about this request */
+#define RQF_SORTED		((__force req_flags_t)(1 << 0))
+/* drive already may have started this one */
+#define RQF_STARTED		((__force req_flags_t)(1 << 1))
+/* uses tagged queueing */
+#define RQF_QUEUED		((__force req_flags_t)(1 << 2))
+/* may not be passed by ioscheduler */
+#define RQF_SOFTBARRIER		((__force req_flags_t)(1 << 3))
+/* request for flush sequence */
+#define RQF_FLUSH_SEQ		((__force req_flags_t)(1 << 4))
+/* merge of different types, fail separately */
+#define RQF_MIXED_MERGE		((__force req_flags_t)(1 << 5))
+/* track inflight for MQ */
+#define RQF_MQ_INFLIGHT		((__force req_flags_t)(1 << 6))
+/* don't call prep for this one */
+#define RQF_DONTPREP		((__force req_flags_t)(1 << 7))
+/* set for "ide_preempt" requests and also for requests for which the SCSI
+   "quiesce" state must be ignored. */
+#define RQF_PREEMPT		((__force req_flags_t)(1 << 8))
+/* contains copies of user pages */
+#define RQF_COPY_USER		((__force req_flags_t)(1 << 9))
+/* vaguely specified driver internal error.  Ignored by the block layer */
+#define RQF_FAILED		((__force req_flags_t)(1 << 10))
+/* don't warn about errors */
+#define RQF_QUIET		((__force req_flags_t)(1 << 11))
+/* elevator private data attached */
+#define RQF_ELVPRIV		((__force req_flags_t)(1 << 12))
+/* account I/O stat */
+#define RQF_IO_STAT		((__force req_flags_t)(1 << 13))
+/* request came from our alloc pool */
+#define RQF_ALLOCED		((__force req_flags_t)(1 << 14))
+/* runtime pm request */
+#define RQF_PM			((__force req_flags_t)(1 << 15))
+/* on IO scheduler merge hash */
+#define RQF_HASHED		((__force req_flags_t)(1 << 16))
+
+/* flags that prevent us from merging requests: */
+#define RQF_NOMERGE_FLAGS \
+	(RQF_STARTED | RQF_SOFTBARRIER | RQF_FLUSH_SEQ)
+
 #define BLK_MAX_CDB	16
 
 /*
@@ -99,6 +143,7 @@ struct request {
 	int cpu;
 	unsigned cmd_type;
 	u64 cmd_flags;
+	req_flags_t rq_flags;
 	unsigned long atomic_flags;
 
 	/* the following two fields are internal, NEVER access directly */
@@ -648,7 +693,7 @@ static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
 			     REQ_FAILFAST_DRIVER))
 
 #define blk_account_rq(rq) \
-	(((rq)->cmd_flags & REQ_STARTED) && \
+	(((rq)->rq_flags & RQF_STARTED) && \
 	 ((rq)->cmd_type == REQ_TYPE_FS))
 
 #define blk_rq_cpu_valid(rq)	((rq)->cpu != -1)
@@ -740,6 +785,8 @@ static inline bool rq_mergeable(struct request *rq)
 
 	if (rq->cmd_flags & REQ_NOMERGE_FLAGS)
 		return false;
+	if (rq->rq_flags & RQF_NOMERGE_FLAGS)
+		return false;
 
 	return true;
 }
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 8a95631..8990e58 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -414,14 +414,14 @@ extern int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 extern int scsi_execute_req_flags(struct scsi_device *sdev,
 	const unsigned char *cmd, int data_direction, void *buffer,
 	unsigned bufflen, struct scsi_sense_hdr *sshdr, int timeout,
-	int retries, int *resid, u64 flags);
+	int retries, int *resid, u64 flags, req_flags_t rq_flags);
 static inline int scsi_execute_req(struct scsi_device *sdev,
 	const unsigned char *cmd, int data_direction, void *buffer,
 	unsigned bufflen, struct scsi_sense_hdr *sshdr, int timeout,
 	int retries, int *resid)
 {
 	return scsi_execute_req_flags(sdev, cmd, data_direction, buffer,
-		bufflen, sshdr, timeout, retries, resid, 0);
+		bufflen, sshdr, timeout, retries, resid, 0, 0);
 }
 extern void sdev_disable_disk_events(struct scsi_device *sdev);
 extern void sdev_enable_disk_events(struct scsi_device *sdev);
-- 
2.1.4

