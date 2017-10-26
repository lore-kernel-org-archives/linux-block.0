Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 12/12 v4] mmc: switch MMC/SD to use blk-mq multiqueueing
Date: Thu, 26 Oct 2017 14:57:57 +0200
Message-Id: <20171026125757.10200-13-linus.walleij@linaro.org>
In-Reply-To: <20171026125757.10200-1-linus.walleij@linaro.org>
References: <20171026125757.10200-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This switches the MMC/SD stack to use the multiqueue block
layer interface.

We kill off the kthread that was just calling blk_fetch_request()
and let blk-mq drive all traffic, nice, that is how it should work.

Due to having switched the submission mechanics around so that
the completion of requests is now triggered from the host
callbacks, we manage to keep the same performance for linear
reads/writes as we have for the old block layer.

The open questions from earlier patch series v1 thru v3 have
been addressed:

- mmc_[get|put]_card() is now issued across requests from
  .queue_rq() to .complete() using Adrians nifty context lock.
  This means that the block layer does not compete with itself
  on getting access to the host, and we can let other users of
  the host come in. (For SDIO and mixed-mode cards.)

- Partial reads are handled by open coding calls to
  blk_update_request() as advised by Christoph.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c |  87 ++++++++++--------
 drivers/mmc/core/queue.c | 223 ++++++++++++++++++-----------------------------
 drivers/mmc/core/queue.h |   8 +-
 3 files changed, 139 insertions(+), 179 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f06f381146a5..9e0fe07e098a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -28,6 +28,7 @@
 #include <linux/hdreg.h>
 #include <linux/kdev_t.h>
 #include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/cdev.h>
 #include <linux/mutex.h>
 #include <linux/scatterlist.h>
@@ -93,7 +94,6 @@ static DEFINE_IDA(mmc_rpmb_ida);
  * There is one mmc_blk_data per slot.
  */
 struct mmc_blk_data {
-	spinlock_t	lock;
 	struct device	*parent;
 	struct gendisk	*disk;
 	struct mmc_queue queue;
@@ -1204,6 +1204,18 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
 }
 
 /*
+ * This reports status back to the block layer for a finished request.
+ */
+static void mmc_blk_complete(struct mmc_queue_req *mq_rq,
+			     blk_status_t status)
+{
+	struct request *req = mmc_queue_req_to_req(mq_rq);
+
+	blk_mq_end_request(req, status);
+	blk_mq_complete_request(req);
+}
+
+/*
  * The non-block commands come back from the block layer after it queued it and
  * processed it with all other requests and then they get issued in this
  * function.
@@ -1262,9 +1274,9 @@ static void mmc_blk_issue_drv_op(struct mmc_queue_req *mq_rq)
 		ret = -EINVAL;
 		break;
 	}
+
 	mq_rq->drv_op_result = ret;
-	blk_end_request_all(mmc_queue_req_to_req(mq_rq),
-			    ret ? BLK_STS_IOERR : BLK_STS_OK);
+	mmc_blk_complete(mq_rq, ret ? BLK_STS_IOERR : BLK_STS_OK);
 }
 
 static void mmc_blk_issue_discard_rq(struct mmc_queue_req *mq_rq)
@@ -1308,7 +1320,7 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue_req *mq_rq)
 	else
 		mmc_blk_reset_success(md, type);
 fail:
-	blk_end_request(req, status, blk_rq_bytes(req));
+	mmc_blk_complete(mq_rq, status);
 }
 
 static void mmc_blk_issue_secdiscard_rq(struct mmc_queue_req *mq_rq)
@@ -1378,7 +1390,7 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue_req *mq_rq)
 	if (!err)
 		mmc_blk_reset_success(md, type);
 out:
-	blk_end_request(req, status, blk_rq_bytes(req));
+	mmc_blk_complete(mq_rq, status);
 }
 
 static void mmc_blk_issue_flush(struct mmc_queue_req *mq_rq)
@@ -1388,8 +1400,13 @@ static void mmc_blk_issue_flush(struct mmc_queue_req *mq_rq)
 	int ret = 0;
 
 	ret = mmc_flush_cache(card);
-	blk_end_request_all(mmc_queue_req_to_req(mq_rq),
-			    ret ? BLK_STS_IOERR : BLK_STS_OK);
+	/*
+	 * NOTE: this used to call blk_end_request_all() for both
+	 * cases in the old block layer to flush all queued
+	 * transactions. I am not sure it was even correct to
+	 * do that for the success case.
+	 */
+	mmc_blk_complete(mq_rq, ret ? BLK_STS_IOERR : BLK_STS_OK);
 }
 
 /*
@@ -1768,7 +1785,6 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mq_rq,
 
 	mq_rq->areq.err_check = mmc_blk_err_check;
 	mq_rq->areq.host = card->host;
-	INIT_WORK(&mq_rq->areq.finalization_work, mmc_finalize_areq);
 }
 
 static bool mmc_blk_rw_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
@@ -1792,10 +1808,13 @@ static bool mmc_blk_rw_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 		err = mmc_sd_num_wr_blocks(card, &blocks);
 		if (err)
 			req_pending = old_req_pending;
-		else
-			req_pending = blk_end_request(req, BLK_STS_OK, blocks << 9);
+		else {
+			req_pending = blk_update_request(req, BLK_STS_OK,
+							 blocks << 9);
+		}
 	} else {
-		req_pending = blk_end_request(req, BLK_STS_OK, brq->data.bytes_xfered);
+		req_pending = blk_update_request(req, BLK_STS_OK,
+						 brq->data.bytes_xfered);
 	}
 	return req_pending;
 }
@@ -1808,7 +1827,7 @@ static void mmc_blk_rw_cmd_abort(struct mmc_queue_req *mq_rq)
 
 	if (mmc_card_removed(card))
 		req->rq_flags |= RQF_QUIET;
-	while (blk_end_request(req, BLK_STS_IOERR, blk_rq_cur_bytes(req)));
+	mmc_blk_complete(mq_rq, BLK_STS_IOERR);
 }
 
 /**
@@ -1854,8 +1873,8 @@ static void mmc_blk_rw_done_error(struct mmc_async_req *areq,
 	case MMC_BLK_PARTIAL:
 		/* This should trigger a retransmit */
 		mmc_blk_reset_success(md, type);
-		req_pending = blk_end_request(req, BLK_STS_OK,
-					      brq->data.bytes_xfered);
+		req_pending = blk_update_request(req, BLK_STS_OK,
+						 brq->data.bytes_xfered);
 		break;
 	case MMC_BLK_CMD_ERR:
 		req_pending = mmc_blk_rw_cmd_err(md, card, brq, req, req_pending);
@@ -1906,11 +1925,13 @@ static void mmc_blk_rw_done_error(struct mmc_async_req *areq,
 		 * time, so we only reach here after trying to
 		 * read a single sector.
 		 */
-		req_pending = blk_end_request(req, BLK_STS_IOERR,
-					      brq->data.blksz);
+		req_pending = blk_update_request(req, BLK_STS_IOERR,
+						 brq->data.blksz);
 		if (!req_pending) {
 			mmc_blk_rw_try_restart(mq_rq);
 			return;
+		} else {
+			mmc_blk_complete(mq_rq, BLK_STS_IOERR);
 		}
 		break;
 	case MMC_BLK_NOMEDIUM:
@@ -1941,10 +1962,8 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq,
 {
 	struct mmc_queue_req *mq_rq;
 	struct request *req;
-	struct mmc_blk_request *brq;
 	struct mmc_queue *mq;
 	struct mmc_blk_data *md;
-	bool req_pending;
 	int type;
 
 	/*
@@ -1957,26 +1976,13 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq,
 
 	/* The quick path if the request was successful */
 	mq_rq =	container_of(areq, struct mmc_queue_req, areq);
-	brq = &mq_rq->brq;
 	mq = mq_rq->mq;
 	md = mq->blkdata;
 	req = mmc_queue_req_to_req(mq_rq);
 	type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
 
 	mmc_blk_reset_success(md, type);
-	req_pending = blk_end_request(req, BLK_STS_OK,
-				      brq->data.bytes_xfered);
-	/*
-	 * If the blk_end_request function returns non-zero even
-	 * though all data has been transferred and no errors
-	 * were returned by the host controller, it's a bug.
-	 */
-	if (req_pending) {
-		pr_err("%s BUG rq_tot %d d_xfer %d\n",
-		       __func__, blk_rq_bytes(req),
-		       brq->data.bytes_xfered);
-		mmc_blk_rw_cmd_abort(mq_rq);
-	}
+	mmc_blk_complete(mq_rq, BLK_STS_OK);
 }
 
 static void mmc_blk_issue_rw_rq(struct mmc_queue_req *mq_rq)
@@ -1991,7 +1997,12 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue_req *mq_rq)
 	 */
 	if (mmc_card_removed(card)) {
 		req->rq_flags |= RQF_QUIET;
-		blk_end_request_all(req, BLK_STS_IOERR);
+		/*
+		 * NOTE: this used to call blk_end_request_all()
+		 * to flush out all queued transactions to the now
+		 * non-present card.
+		 */
+		mmc_blk_complete(mq_rq, BLK_STS_IOERR);
 		return;
 	}
 
@@ -2017,8 +2028,9 @@ void mmc_blk_issue_rq(struct mmc_queue_req *mq_rq)
 {
 	int ret;
 	struct request *req = mmc_queue_req_to_req(mq_rq);
-	struct mmc_blk_data *md = mq_rq->mq->blkdata;
-	struct mmc_card *card = md->queue.card;
+	struct mmc_queue *mq = mq_rq->mq;
+	struct mmc_blk_data *md = mq->blkdata;
+	struct mmc_card *card = mq->card;
 
 	if (!req) {
 		pr_err("%s: tried to issue NULL request\n", __func__);
@@ -2027,7 +2039,7 @@ void mmc_blk_issue_rq(struct mmc_queue_req *mq_rq)
 
 	ret = mmc_blk_part_switch(card, md->part_type);
 	if (ret) {
-		blk_end_request_all(req, BLK_STS_IOERR);
+		mmc_blk_complete(mq_rq, BLK_STS_IOERR);
 		return;
 	}
 
@@ -2124,12 +2136,11 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 		goto err_kfree;
 	}
 
-	spin_lock_init(&md->lock);
 	INIT_LIST_HEAD(&md->part);
 	INIT_LIST_HEAD(&md->rpmbs);
 	md->usage = 1;
 
-	ret = mmc_init_queue(&md->queue, card, &md->lock, subname);
+	ret = mmc_init_queue(&md->queue, card, subname);
 	if (ret)
 		goto err_putdisk;
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 5511e323db31..dea6b4e3f828 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/freezer.h>
 #include <linux/kthread.h>
 #include <linux/scatterlist.h>
@@ -38,74 +39,6 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 	return BLKPREP_OK;
 }
 
-static int mmc_queue_thread(void *d)
-{
-	struct mmc_queue *mq = d;
-	struct request_queue *q = mq->queue;
-	bool claimed_card = false;
-
-	current->flags |= PF_MEMALLOC;
-
-	down(&mq->thread_sem);
-	do {
-		struct request *req;
-
-		spin_lock_irq(q->queue_lock);
-		set_current_state(TASK_INTERRUPTIBLE);
-		req = blk_fetch_request(q);
-		mq->asleep = false;
-		spin_unlock_irq(q->queue_lock);
-
-		if (req) {
-			if (!claimed_card) {
-				mmc_get_card(mq->card, NULL);
-				claimed_card = true;
-			}
-			set_current_state(TASK_RUNNING);
-			mmc_blk_issue_rq(req_to_mmc_queue_req(req));
-			cond_resched();
-		} else {
-			mq->asleep = true;
-			if (kthread_should_stop()) {
-				set_current_state(TASK_RUNNING);
-				break;
-			}
-			up(&mq->thread_sem);
-			schedule();
-			down(&mq->thread_sem);
-		}
-	} while (1);
-	up(&mq->thread_sem);
-
-	if (claimed_card)
-		mmc_put_card(mq->card, NULL);
-
-	return 0;
-}
-
-/*
- * Generic MMC request handler.  This is called for any queue on a
- * particular host.  When the host is not busy, we look for a request
- * on any queue on this host, and attempt to issue it.  This may
- * not be the queue we were asked to process.
- */
-static void mmc_request_fn(struct request_queue *q)
-{
-	struct mmc_queue *mq = q->queuedata;
-	struct request *req;
-
-	if (!mq) {
-		while ((req = blk_fetch_request(q)) != NULL) {
-			req->rq_flags |= RQF_QUIET;
-			__blk_end_request_all(req, BLK_STS_IOERR);
-		}
-		return;
-	}
-
-	if (mq->asleep)
-		wake_up_process(mq->thread);
-}
-
 static struct scatterlist *mmc_alloc_sg(int sg_len, gfp_t gfp)
 {
 	struct scatterlist *sg;
@@ -136,127 +69,158 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 		queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, q);
 }
 
+static blk_status_t mmc_queue_request(struct blk_mq_hw_ctx *hctx,
+				      const struct blk_mq_queue_data *bd)
+{
+	struct mmc_queue_req *mq_rq = blk_mq_rq_to_pdu(bd->rq);
+	struct mmc_queue *mq = mq_rq->mq;
+
+	/* Claim card for block queue context */
+	mmc_get_card(mq->card, &mq->blkctx);
+	mmc_blk_issue_rq(mq_rq);
+
+	return BLK_STS_OK;
+}
+
+static void mmc_complete_request(struct request *req)
+{
+	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
+	struct mmc_queue *mq = mq_rq->mq;
+
+	/* Release card for block queue context */
+	mmc_put_card(mq->card, &mq->blkctx);
+}
+
 /**
  * mmc_init_request() - initialize the MMC-specific per-request data
- * @q: the request queue
+ * @set: tag set for the request
  * @req: the request
- * @gfp: memory allocation policy
+ * @hctx_idx: hardware context index
+ * @numa_node: NUMA node
  */
-static int mmc_init_request(struct request_queue *q, struct request *req,
-			    gfp_t gfp)
+static int mmc_init_request(struct blk_mq_tag_set *set, struct request *req,
+			    unsigned int hctx_idx, unsigned int numa_node)
 {
 	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
-	struct mmc_queue *mq = q->queuedata;
+	struct mmc_queue *mq = set->driver_data;
 	struct mmc_card *card = mq->card;
 	struct mmc_host *host = card->host;
 
-	mq_rq->sg = mmc_alloc_sg(host->max_segs, gfp);
+	mq_rq->sg = mmc_alloc_sg(host->max_segs, GFP_KERNEL);
 	if (!mq_rq->sg)
 		return -ENOMEM;
 	mq_rq->mq = mq;
+	INIT_WORK(&mq_rq->areq.finalization_work, mmc_finalize_areq);
 
 	return 0;
 }
 
-static void mmc_exit_request(struct request_queue *q, struct request *req)
+/**
+ * mmc_exit_request() - tear down the MMC-specific per-request data
+ * @set: tag set for the request
+ * @req: the request
+ * @hctx_idx: hardware context index
+ */
+static void mmc_exit_request(struct blk_mq_tag_set *set, struct request *req,
+			     unsigned int hctx_idx)
 {
 	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
 
+	flush_work(&mq_rq->areq.finalization_work);
 	kfree(mq_rq->sg);
 	mq_rq->sg = NULL;
 	mq_rq->mq = NULL;
 }
 
-static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
+static void mmc_setup_queue(struct mmc_queue *mq)
 {
+	struct request_queue *q = mq->queue;
+	struct mmc_card *card = mq->card;
 	struct mmc_host *host = card->host;
 	u64 limit = BLK_BOUNCE_HIGH;
 
 	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
 		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
 
-	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
-	queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, mq->queue);
+	blk_queue_max_segments(q, host->max_segs);
+	blk_queue_prep_rq(q, mmc_prep_request);
+	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, q);
+	queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, q);
 	if (mmc_can_erase(card))
-		mmc_queue_setup_discard(mq->queue, card);
-
-	blk_queue_bounce_limit(mq->queue, limit);
-	blk_queue_max_hw_sectors(mq->queue,
+		mmc_queue_setup_discard(q, card);
+	blk_queue_bounce_limit(q, limit);
+	blk_queue_max_hw_sectors(q,
 		min(host->max_blk_count, host->max_req_size / 512));
-	blk_queue_max_segments(mq->queue, host->max_segs);
-	blk_queue_max_segment_size(mq->queue, host->max_seg_size);
-
-	/* Initialize thread_sem even if it is not used */
-	sema_init(&mq->thread_sem, 1);
+	blk_queue_max_segments(q, host->max_segs);
+	blk_queue_max_segment_size(q, host->max_seg_size);
 }
 
+static const struct blk_mq_ops mmc_mq_ops = {
+	.queue_rq       = mmc_queue_request,
+	.init_request   = mmc_init_request,
+	.exit_request   = mmc_exit_request,
+	.complete	= mmc_complete_request,
+};
+
 /**
  * mmc_init_queue - initialise a queue structure.
  * @mq: mmc queue
  * @card: mmc card to attach this queue
- * @lock: queue lock
  * @subname: partition subname
  *
  * Initialise a MMC card request queue.
  */
 int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
-		   spinlock_t *lock, const char *subname)
+		   const char *subname)
 {
 	struct mmc_host *host = card->host;
-	int ret = -ENOMEM;
+	int ret;
 
 	mq->card = card;
-	mq->queue = blk_alloc_queue(GFP_KERNEL);
-	if (!mq->queue)
-		return -ENOMEM;
-	mq->queue->queue_lock = lock;
-	mq->queue->request_fn = mmc_request_fn;
-	mq->queue->init_rq_fn = mmc_init_request;
-	mq->queue->exit_rq_fn = mmc_exit_request;
-	mq->queue->cmd_size = sizeof(struct mmc_queue_req);
-	mq->queue->queuedata = mq;
-	ret = blk_init_allocated_queue(mq->queue);
+	mq->tag_set.ops = &mmc_mq_ops;
+	/* The MMC/SD protocols have only one command pipe */
+	mq->tag_set.nr_hw_queues = 1;
+	/* Set this to 2 to simulate async requests, should we use 3? */
+	mq->tag_set.queue_depth = 2;
+	mq->tag_set.cmd_size = sizeof(struct mmc_queue_req);
+	mq->tag_set.numa_node = NUMA_NO_NODE;
+	/* We use blocking requests */
+	mq->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
+	/* Should we use BLK_MQ_F_SG_MERGE? */
+	mq->tag_set.driver_data = mq;
+
+	ret = blk_mq_alloc_tag_set(&mq->tag_set);
 	if (ret) {
-		blk_cleanup_queue(mq->queue);
+		dev_err(host->parent, "failed to allocate MQ tag set\n");
 		return ret;
 	}
-
-	blk_queue_prep_rq(mq->queue, mmc_prep_request);
-
-	mmc_setup_queue(mq, card);
-
-	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d%s",
-		host->index, subname ? subname : "");
-
-	if (IS_ERR(mq->thread)) {
-		ret = PTR_ERR(mq->thread);
-		goto cleanup_queue;
+	mq->queue = blk_mq_init_queue(&mq->tag_set);
+	if (!mq->queue) {
+		dev_err(host->parent, "failed to initialize block MQ\n");
+		goto cleanup_free_tag_set;
 	}
+	mq->queue->queuedata = mq;
+	mmc_setup_queue(mq);
 
 	return 0;
 
-cleanup_queue:
-	blk_cleanup_queue(mq->queue);
+cleanup_free_tag_set:
+	blk_mq_free_tag_set(&mq->tag_set);
 	return ret;
 }
 
 void mmc_cleanup_queue(struct mmc_queue *mq)
 {
 	struct request_queue *q = mq->queue;
-	unsigned long flags;
 
 	/* Make sure the queue isn't suspended, as that will deadlock */
 	mmc_queue_resume(mq);
 
-	/* Then terminate our worker thread */
-	kthread_stop(mq->thread);
-
 	/* Empty the queue */
-	spin_lock_irqsave(q->queue_lock, flags);
 	q->queuedata = NULL;
 	blk_start_queue(q);
-	spin_unlock_irqrestore(q->queue_lock, flags);
-
+	blk_cleanup_queue(q);
+	blk_mq_free_tag_set(&mq->tag_set);
 	mq->card = NULL;
 }
 EXPORT_SYMBOL(mmc_cleanup_queue);
@@ -265,23 +229,16 @@ EXPORT_SYMBOL(mmc_cleanup_queue);
  * mmc_queue_suspend - suspend a MMC request queue
  * @mq: MMC queue to suspend
  *
- * Stop the block request queue, and wait for our thread to
- * complete any outstanding requests.  This ensures that we
+ * Stop the block request queue. This ensures that we
  * won't suspend while a request is being processed.
  */
 void mmc_queue_suspend(struct mmc_queue *mq)
 {
 	struct request_queue *q = mq->queue;
-	unsigned long flags;
 
 	if (!mq->suspended) {
-		mq->suspended |= true;
-
-		spin_lock_irqsave(q->queue_lock, flags);
+		mq->suspended = true;
 		blk_stop_queue(q);
-		spin_unlock_irqrestore(q->queue_lock, flags);
-
-		down(&mq->thread_sem);
 	}
 }
 
@@ -292,16 +249,10 @@ void mmc_queue_suspend(struct mmc_queue *mq)
 void mmc_queue_resume(struct mmc_queue *mq)
 {
 	struct request_queue *q = mq->queue;
-	unsigned long flags;
 
 	if (mq->suspended) {
 		mq->suspended = false;
-
-		up(&mq->thread_sem);
-
-		spin_lock_irqsave(q->queue_lock, flags);
 		blk_start_queue(q);
-		spin_unlock_irqrestore(q->queue_lock, flags);
 	}
 }
 
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 67ae311b107f..c78fbb226a90 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -61,16 +61,14 @@ struct mmc_queue_req {
 
 struct mmc_queue {
 	struct mmc_card		*card;
-	struct task_struct	*thread;
-	struct semaphore	thread_sem;
 	bool			suspended;
-	bool			asleep;
 	struct mmc_blk_data	*blkdata;
 	struct request_queue	*queue;
+	struct mmc_ctx		blkctx;
+	struct blk_mq_tag_set	tag_set;
 };
 
-extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
-			  const char *);
+extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, const char *);
 extern void mmc_cleanup_queue(struct mmc_queue *);
 extern void mmc_queue_suspend(struct mmc_queue *);
 extern void mmc_queue_resume(struct mmc_queue *);
-- 
2.13.6
