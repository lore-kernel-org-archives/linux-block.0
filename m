Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paolo Valente <paolo.valente@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
	Baolin Wang <baolin.wang@linaro.org>,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 16/16] RFC: mmc: switch MMC/SD to use blk-mq multiqueueing v3
Date: Thu,  9 Feb 2017 16:34:03 +0100
Message-Id: <20170209153403.9730-17-linus.walleij@linaro.org>
In-Reply-To: <20170209153403.9730-1-linus.walleij@linaro.org>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

HACK ALERT: DO NOT MERGE THIS! IT IS A FYI PATCH FOR DISCUSSION
ONLY.

This is a totally new implementation of how to do multiqueue
in the MMC/SD stack. It is based on top of my refactorings in the
series which ends with this patch, and now makes proper use of
.init_request() and .exit_request() to initialize the per-request
hardware context, reusing good old struct mmc_queue_req which is
what is actually intended by these functions.

We kill off the kthread that was just calling blk_fetch_request()
and let blk-mq drive all traffic, nice, that is how it should work.

Due to having switched the submission mechanics around so that
the completion of requests is now triggered from the host
callbacks, we manage to keep the same performance for linear
reads/writes as we have for the old block layer.

Some open questions:

- We used to issue mmc_get_card() when the first request comes
  in and mmc_put_card() when we get NULL from blk_fetch_request().
  Well as we are not pushed any NULL requests anymore we need
  another way for the queue to tell us it is idle, or we should
  just set up a delayed work and release the card if no new
  requests appear for some time.

- The flush was handled by issueing blk_end_request_all() in
  the old scheduler. Is blk_mq_complete_request() really doing
  the same job, or is there some extra magic needed here?

- We can sometime get a partial read from a MMC command, meaning
  some of the request has been handled. We know how many bytes
  were read/written. We used to report this to the block layer
  using blk_end_request(old_req, 0, bytes_xfered) but the MQ
  scheduler seems to be missing a command that reports
  partial completion. How do we handle this?

Apart from that my only remaining worries are about the
block scheduler, but I hear Jens and Paolo are working to fix
this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c |  66 ++++-----
 drivers/mmc/core/core.c  |   4 -
 drivers/mmc/core/queue.c | 355 ++++++++++++++++-------------------------------
 drivers/mmc/core/queue.h |  15 +-
 4 files changed, 159 insertions(+), 281 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f1008ce5376b..f977117f7435 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -28,6 +28,7 @@
 #include <linux/hdreg.h>
 #include <linux/kdev_t.h>
 #include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/mutex.h>
 #include <linux/scatterlist.h>
 #include <linux/string_helpers.h>
@@ -96,7 +97,6 @@ static DEFINE_SPINLOCK(mmc_blk_lock);
  * There is one mmc_blk_data per slot.
  */
 struct mmc_blk_data {
-	spinlock_t	lock;
 	struct device	*parent;
 	struct gendisk	*disk;
 	struct mmc_queue queue;
@@ -1188,7 +1188,7 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue_req *mq_rq)
 	if (!err)
 		mmc_blk_reset_success(md, type);
 fail:
-	blk_end_request(mq_rq->req, err, blk_rq_bytes(mq_rq->req));
+	blk_mq_complete_request(mq_rq->req, err);
 }
 
 static void mmc_blk_issue_secdiscard_rq(struct mmc_queue_req *mq_rq)
@@ -1265,7 +1265,8 @@ static void mmc_blk_issue_flush(struct mmc_queue_req *mq_rq)
 	if (ret)
 		ret = -EIO;
 
-	blk_end_request_all(mq_rq->req, ret);
+	/* FIXME: was using blk_end_request_all() to flush */
+	blk_mq_complete_request(mq_rq->req, ret);
 }
 
 /*
@@ -1589,12 +1590,15 @@ static bool mmc_blk_rw_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 		int err;
 
 		err = mmc_sd_num_wr_blocks(card, &blocks);
-		if (err)
+		if (err) {
 			req_pending = old_req_pending;
-		else
-			req_pending = blk_end_request(req, 0, blocks << 9);
+		} else {
+			blk_mq_complete_request(req, 0);
+			req_pending = false;
+		}
 	} else {
-		req_pending = blk_end_request(req, 0, brq->data.bytes_xfered);
+		blk_mq_complete_request(req, 0);
+		req_pending = false;
 	}
 	return req_pending;
 }
@@ -1630,33 +1634,18 @@ static void mmc_blk_rw_try_restart(struct mmc_queue_req *mq_rq)
 void mmc_blk_rw_done_success(struct mmc_async_req *areq)
 {
 	struct mmc_queue_req *mq_rq;
-	struct mmc_blk_request *brq;
 	struct mmc_blk_data *md;
 	struct request *old_req;
-	bool req_pending;
 	int type;
 
 	mq_rq =	container_of(areq, struct mmc_queue_req, areq);
 	md = mq_rq->mq->blkdata;
-	brq = &mq_rq->brq;
 	old_req = mq_rq->req;
 	type = rq_data_dir(old_req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
 
 	mmc_queue_bounce_post(mq_rq);
 	mmc_blk_reset_success(md, type);
-	req_pending = blk_end_request(old_req, 0,
-				      brq->data.bytes_xfered);
-	/*
-	 * If the blk_end_request function returns non-zero even
-	 * though all data has been transferred and no errors
-	 * were returned by the host controller, it's a bug.
-	 */
-	if (req_pending) {
-		pr_err("%s BUG rq_tot %d d_xfer %d\n",
-		       __func__, blk_rq_bytes(old_req),
-		       brq->data.bytes_xfered);
-		return;
-	}
+	blk_mq_complete_request(old_req, 0);
 }
 
 /**
@@ -1702,9 +1691,16 @@ void mmc_blk_rw_done_error(struct mmc_async_req *areq,
 		 * A block was successfully transferred.
 		 */
 		mmc_blk_reset_success(md, type);
-
-		req_pending = blk_end_request(old_req, 0,
-					      brq->data.bytes_xfered);
+		/*
+		 * FIXME:
+		 * How do we handle a partial request?
+		 * brq->data.bytes_xfered contains the number of
+		 * successfully transfered bytes, how to report
+		 * this to the MQ block layer and get a new, smaller
+		 * request back? Currently just requeueing.
+		 */
+		blk_mq_requeue_request(old_req, false);
+		req_pending = false;
 		break;
 	case MMC_BLK_CMD_ERR:
 		req_pending = mmc_blk_rw_cmd_err(md, card, brq, old_req, req_pending);
@@ -1754,12 +1750,9 @@ void mmc_blk_rw_done_error(struct mmc_async_req *areq,
 		 * time, so we only reach here after trying to
 		 * read a single sector.
 		 */
-		req_pending = blk_end_request(old_req, -EIO,
-					      brq->data.blksz);
-		if (!req_pending) {
-			mmc_blk_rw_try_restart(mq_rq);
-			return;
-		}
+		blk_mq_complete_request(mq_rq->req, -EIO);
+		req_pending = false;
+		mmc_blk_rw_try_restart(mq_rq);
 		break;
 	case MMC_BLK_NOMEDIUM:
 		mmc_blk_rw_cmd_abort(card, old_req);
@@ -1819,7 +1812,8 @@ void mmc_blk_issue_rq(struct mmc_queue_req *mq_rq)
 
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
-		blk_end_request_all(mq_rq->req, -EIO);
+		/* FIXME: was blk_end_request_all() to flush */
+		blk_mq_complete_request(mq_rq->req, -EIO);
 		return;
 	}
 
@@ -1830,7 +1824,6 @@ void mmc_blk_issue_rq(struct mmc_queue_req *mq_rq)
 			card->host->areq = NULL;
 		}
 		mmc_blk_issue_discard_rq(mq_rq);
-		mmc_queue_req_put(mq_rq);
 	} else if (req_op(mq_rq->req) == REQ_OP_SECURE_ERASE) {
 		/* complete ongoing async transfer before issuing secure erase*/
 		if (card->host->areq) {
@@ -1838,7 +1831,6 @@ void mmc_blk_issue_rq(struct mmc_queue_req *mq_rq)
 			card->host->areq = NULL;
 		}
 		mmc_blk_issue_secdiscard_rq(mq_rq);
-		mmc_queue_req_put(mq_rq);
 	} else if (req_op(mq_rq->req) == REQ_OP_FLUSH) {
 		/* complete ongoing async transfer before issuing flush */
 		if (card->host->areq) {
@@ -1846,7 +1838,6 @@ void mmc_blk_issue_rq(struct mmc_queue_req *mq_rq)
 			card->host->areq = NULL;
 		}
 		mmc_blk_issue_flush(mq_rq);
-		mmc_queue_req_put(mq_rq);
 	} else {
 		mmc_blk_issue_rw_rq(mq_rq);
 	}
@@ -1906,11 +1897,10 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 		goto err_kfree;
 	}
 
-	spin_lock_init(&md->lock);
 	INIT_LIST_HEAD(&md->part);
 	md->usage = 1;
 
-	ret = mmc_init_queue(&md->queue, card, &md->lock, subname);
+	ret = mmc_init_queue(&md->queue, card, subname);
 	if (ret)
 		goto err_putdisk;
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 04666ad91df0..a81b6baa3bee 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -599,8 +599,6 @@ void mmc_finalize_areq(struct kthread_work *work)
 {
 	struct mmc_async_req *areq =
 		container_of(work, struct mmc_async_req, finalization_work);
-	struct mmc_queue_req *mq_rq = container_of(areq, struct mmc_queue_req,
-						   areq);
 	struct mmc_host *host = areq->host;
 	enum mmc_blk_status status = MMC_BLK_SUCCESS;
 	struct mmc_command *cmd;
@@ -648,7 +646,6 @@ void mmc_finalize_areq(struct kthread_work *work)
 		 */
 		mmc_blk_rw_done_error(areq, status);
 		complete(&areq->complete);
-		mmc_queue_req_put(mq_rq);
 		return;
 	}
 
@@ -660,7 +657,6 @@ void mmc_finalize_areq(struct kthread_work *work)
 	complete(&areq->complete);
 	mmc_post_req(host, areq->mrq, 0);
 	mmc_blk_rw_done_success(areq);
-	mmc_queue_req_put(mq_rq);
 }
 EXPORT_SYMBOL(mmc_finalize_areq);
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index e7ba5bef2df3..9850d7342763 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -14,6 +14,7 @@
 #include <linux/kthread.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-mapping.h>
+#include <linux/blk-mq.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -49,126 +50,6 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 	return BLKPREP_OK;
 }
 
-/**
- * Get an available queue item from the pool.
- */
-static struct mmc_queue_req *mmc_queue_req_get(struct mmc_queue *mq)
-{
-	int i;
-
-	/*
-	 * This simply cannot fail so we just spin here
-	 * until we get a queue request to work on.
-	 */
-	while (1) {
-		/* Just take the first unused queue request */
-		spin_lock_irq(&mq->mqrq_lock);
-		for (i = 0; i < mq->qdepth; i++) {
-			if (!mq->mqrq[i].in_use) {
-				mq->mqrq[i].in_use = true;
-				spin_unlock_irq(&mq->mqrq_lock);
-				return &mq->mqrq[i];
-			}
-		}
-		spin_unlock_irq(&mq->mqrq_lock);
-
-		pr_warn_once("%s: out of queue items, spinning\n", __func__);
-	}
-}
-
-void mmc_queue_req_put(struct mmc_queue_req *mq_rq)
-{
-	mq_rq->brq.mrq.data = NULL;
-	mq_rq->req = NULL;
-	spin_lock_irq(&mq_rq->mq->mqrq_lock);
-	mq_rq->in_use = false;
-	spin_unlock_irq(&mq_rq->mq->mqrq_lock);
-}
-
-static int mmc_queue_thread(void *d)
-{
-	struct mmc_queue *mq = d;
-	struct request_queue *q = mq->queue;
-	bool claimed_host = false;
-	struct mmc_queue_req *mq_rq;
-
-	current->flags |= PF_MEMALLOC;
-
-	down(&mq->thread_sem);
-	do {
-		struct request *req = NULL;
-
-		set_current_state(TASK_INTERRUPTIBLE);
-		spin_lock_irq(q->queue_lock);
-		req = blk_fetch_request(q);
-		spin_unlock_irq(q->queue_lock);
-		mq->asleep = false;
-
-		if (req) {
-			bool req_is_special = mmc_req_is_special(req);
-
-			mq_rq = mmc_queue_req_get(mq);
-			mq_rq->req = req;
-			if (!claimed_host)
-				mmc_get_card(mq->card);
-			set_current_state(TASK_RUNNING);
-			mmc_blk_issue_rq(mq_rq);
-			cond_resched();
-			/*
-			 * Current request becomes previous request
-			 * and vice versa.
-			 * In case of special requests, current request
-			 * has been finished. Do not assign it to previous
-			 * request. Always unclaim the host after special
-			 * commands.
-			 */
-			if (req_is_special) {
-				mmc_put_card(mq->card);
-				claimed_host = false;
-			}
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
-
-	if (claimed_host)
-		mmc_put_card(mq->card);
-
-	up(&mq->thread_sem);
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
-			__blk_end_request_all(req, -EIO);
-		}
-		return;
-	}
-
-	if (mq->asleep)
-		wake_up_process(mq->thread);
-}
-
 static struct scatterlist *mmc_alloc_sg(int sg_len, int *err)
 {
 	struct scatterlist *sg;
@@ -205,55 +86,80 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 		queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, q);
 }
 
-#ifdef CONFIG_MMC_BLOCK_BOUNCE
-static bool mmc_queue_alloc_bounce_bufs(struct mmc_queue *mq,
-					unsigned int bouncesz)
+static int mmc_queue_rq(struct blk_mq_hw_ctx *hctx,
+               const struct blk_mq_queue_data *bd)
 {
-	int i;
+	struct mmc_queue_req *mq_rq = blk_mq_rq_to_pdu(bd->rq);
+	struct mmc_queue *mq = mq_rq->mq;
+	bool req_is_special = mmc_req_is_special(bd->rq);
 
-	for (i = 0; i < mq->qdepth; i++) {
-		mq->mqrq[i].bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
-		if (!mq->mqrq[i].bounce_buf)
-			goto out_err;
+	/* start this request */
+	mq_rq->req = bd->rq;
+	mq_rq->brq.mrq.data = NULL;
+	blk_mq_start_request(mq_rq->req);
+
+	if (!mq->claimed_host) {
+		mmc_get_card(mq->card);
+		mq->claimed_host = true;
+	}
+	set_current_state(TASK_RUNNING);
+	mmc_blk_issue_rq(mq_rq);
+	cond_resched();
+	/*
+	 * In case of special requests, current request
+	 * has been finished. Always unclaim the host after special
+	 * commands.
+	 */
+	if (req_is_special) {
+		mmc_put_card(mq->card);
+		mq->claimed_host = false;
 	}
 
-	return true;
+	/*
+	 * FIXME: unclaim host after timeout?
+	 * Can blk-mq notify us that there are no requests coming
+	 * for a while so we can relax the host?
+	 */
+	// if (claimed_host)
+	//	mmc_put_card(mq->card);
 
-out_err:
-	while (--i >= 0) {
-		kfree(mq->mqrq[i].bounce_buf);
-		mq->mqrq[i].bounce_buf = NULL;
-	}
-	pr_warn("%s: unable to allocate bounce buffers\n",
-		mmc_card_name(mq->card));
-	return false;
+	return BLK_MQ_RQ_QUEUE_OK;
 }
 
-static int mmc_queue_alloc_bounce_sgs(struct mmc_queue *mq,
-				      unsigned int bouncesz)
+static int mmc_init_request(void *data, struct request *rq,
+			    unsigned int hctx_idx, unsigned int request_idx,
+			    unsigned int numa_node)
 {
-	int i, ret;
+	struct mmc_queue_req *mq_rq = blk_mq_rq_to_pdu(rq);
+	struct mmc_queue *mq = data;
+	struct mmc_card *card = mq->card;
+	struct mmc_host *host = card->host;
+	int ret;
 
-	for (i = 0; i < mq->qdepth; i++) {
-		mq->mqrq[i].sg = mmc_alloc_sg(1, &ret);
-		if (ret)
-			return ret;
+	mq_rq->dev = host->parent;
+	mq_rq->mq = mq;
+	/* Set up bounces etc */
+	dev_info(mq_rq->dev, "%s\n", __func__);
 
-		mq->mqrq[i].bounce_sg = mmc_alloc_sg(bouncesz / 512, &ret);
-		if (ret)
-			return ret;
-	}
+#ifdef CONFIG_MMC_BLOCK_BOUNCE
+	if (mq->bouncesz) {
+		mq_rq->bounce_buf = kmalloc(mq->bouncesz, GFP_KERNEL);
+		if (!mq_rq->bounce_buf)
+			return -ENOMEM;
+		if (mq->bouncesz > 512) {
+			mq_rq->sg = mmc_alloc_sg(1, &ret);
+			if (ret)
+				return ret;
 
-	return 0;
-}
+			mq_rq->bounce_sg = mmc_alloc_sg(mq->bouncesz / 512,
+							&ret);
+			if (ret)
+				return ret;
+		}
+	} else
 #endif
-
-static int mmc_queue_alloc_sgs(struct mmc_queue *mq, int max_segs)
-{
-	int i, ret;
-
-	for (i = 0; i < mq->qdepth; i++) {
-		mq->mqrq[i].sg = mmc_alloc_sg(max_segs, &ret);
+	{
+		mq_rq->sg = mmc_alloc_sg(host->max_segs, &ret);
 		if (ret)
 			return ret;
 	}
@@ -261,26 +167,35 @@ static int mmc_queue_alloc_sgs(struct mmc_queue *mq, int max_segs)
 	return 0;
 }
 
-static void mmc_queue_req_free_bufs(struct mmc_queue_req *mqrq)
+static void mmc_exit_request(void *data, struct request *rq,
+			     unsigned int hctx_idx, unsigned int request_idx)
 {
-	kfree(mqrq->bounce_sg);
-	mqrq->bounce_sg = NULL;
+	struct mmc_queue_req *mq_rq = blk_mq_rq_to_pdu(rq);
 
-	kfree(mqrq->sg);
-	mqrq->sg = NULL;
+	dev_info(mq_rq->dev, "%s: hctx_idx = %u, request_idx = %u\n",
+		 __func__, hctx_idx, request_idx);
 
-	kfree(mqrq->bounce_buf);
-	mqrq->bounce_buf = NULL;
-}
+	kfree(mq_rq->bounce_sg);
+	mq_rq->bounce_sg = NULL;
 
-static void mmc_queue_reqs_free_bufs(struct mmc_queue *mq)
-{
-	int i;
+	kfree(mq_rq->sg);
+	mq_rq->sg = NULL;
 
-	for (i = 0; i < mq->qdepth; i++)
-		mmc_queue_req_free_bufs(&mq->mqrq[i]);
+	kfree(mq_rq->bounce_buf);
+	mq_rq->bounce_buf = NULL;
 }
 
+static struct blk_mq_ops mmc_mq_ops = {
+	.queue_rq       = mmc_queue_rq,
+	.init_request   = mmc_init_request,
+	.exit_request   = mmc_exit_request,
+	/*
+	 * .exit_request() will only be invoked if we explcitly call
+	 * blk_mq_end_request() on all requests. Why would we do that,
+	 * we will just call blk_mq_complete_request().
+	 */
+};
+
 /**
  * mmc_init_queue - initialise a queue structure.
  * @mq: mmc queue
@@ -291,31 +206,47 @@ static void mmc_queue_reqs_free_bufs(struct mmc_queue *mq)
  * Initialise a MMC card request queue.
  */
 int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
-		   spinlock_t *lock, const char *subname)
+		   const char *subname)
 {
 	struct mmc_host *host = card->host;
 	u64 limit = BLK_BOUNCE_HIGH;
 	bool bounce = false;
 	int ret = -ENOMEM;
-	int i;
 
 	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
 		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
 
 	mq->card = card;
-	mq->queue = blk_init_queue(mmc_request_fn, lock);
-	if (!mq->queue)
+	mq->tag_set.ops = &mmc_mq_ops;
+	/* The MMC/SD protocols have only one command pipe */
+	mq->tag_set.nr_hw_queues = 1;
+	/* Set this to 2 to simulate async requests */
+	mq->tag_set.queue_depth = 2;
+	/*
+	 * The extra data allocated per block request.
+	 */
+	mq->tag_set.cmd_size = sizeof(struct mmc_queue_req);
+	mq->tag_set.numa_node = NUMA_NO_NODE;
+	/* We use blocking requests */
+	mq->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
+	// BLK_MQ_F_SG_MERGE?
+	mq->tag_set.driver_data = mq;
+
+	ret = blk_mq_alloc_tag_set(&mq->tag_set);
+	if (ret) {
+		dev_err(card->host->parent, "failed to allocate MQ tag set\n");
 		return -ENOMEM;
+	}
 
-	mq->qdepth = 4;
-	spin_lock_init(&mq->mqrq_lock);
-	mq->mqrq = kcalloc(mq->qdepth, sizeof(struct mmc_queue_req),
-			   GFP_KERNEL);
-	if (!mq->mqrq)
-		goto blk_cleanup;
-	for (i = 0; i < mq->qdepth; i++)
-		mq->mqrq[i].mq = mq;
+	mq->queue = blk_mq_init_queue(&mq->tag_set);
+	if (!mq->queue) {
+		dev_err(card->host->parent, "failed to initialize block MQ\n");
+		goto cleanup_free_tag_set;
+	}
+
+	blk_queue_max_segments(mq->queue, host->max_segs);
 
+	mq->qdepth = 4;
 	mq->queue->queuedata = mq;
 
 	blk_queue_prep_rq(mq->queue, mmc_prep_request);
@@ -337,18 +268,15 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		if (bouncesz > (host->max_blk_count * 512))
 			bouncesz = host->max_blk_count * 512;
 
-		if (bouncesz > 512 &&
-		    mmc_queue_alloc_bounce_bufs(mq, bouncesz)) {
+		if (bouncesz > 512) {
 			blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_ANY);
 			blk_queue_max_hw_sectors(mq->queue, bouncesz / 512);
 			blk_queue_max_segments(mq->queue, bouncesz / 512);
 			blk_queue_max_segment_size(mq->queue, bouncesz);
-
-			ret = mmc_queue_alloc_bounce_sgs(mq, bouncesz);
-			if (ret)
-				goto cleanup_queue;
 			bounce = true;
 		}
+
+		mq->bouncesz = bouncesz;
 	}
 #endif
 
@@ -358,53 +286,29 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 			min(host->max_blk_count, host->max_req_size / 512));
 		blk_queue_max_segments(mq->queue, host->max_segs);
 		blk_queue_max_segment_size(mq->queue, host->max_seg_size);
-
-		ret = mmc_queue_alloc_sgs(mq, host->max_segs);
-		if (ret)
-			goto cleanup_queue;
-	}
-
-	sema_init(&mq->thread_sem, 1);
-
-	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d%s",
-		host->index, subname ? subname : "");
-
-	if (IS_ERR(mq->thread)) {
-		ret = PTR_ERR(mq->thread);
-		goto cleanup_queue;
 	}
 
 	return 0;
 
- cleanup_queue:
-	mmc_queue_reqs_free_bufs(mq);
-	kfree(mq->mqrq);
-	mq->mqrq = NULL;
-blk_cleanup:
-	blk_cleanup_queue(mq->queue);
+cleanup_free_tag_set:
+	blk_mq_free_tag_set(&mq->tag_set);
+
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
 
-	mmc_queue_reqs_free_bufs(mq);
-	kfree(mq->mqrq);
-	mq->mqrq = NULL;
+	blk_cleanup_queue(mq->queue);
+	blk_mq_free_tag_set(&mq->tag_set);
 
 	mq->card = NULL;
 }
@@ -414,23 +318,16 @@ EXPORT_SYMBOL(mmc_cleanup_queue);
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
 
@@ -441,16 +338,10 @@ void mmc_queue_suspend(struct mmc_queue *mq)
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
index 886a05482b74..0a30fcc115ee 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -4,6 +4,7 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/mmc/core.h>
 #include <linux/mmc/host.h>
 
@@ -28,7 +29,7 @@ struct mmc_blk_request {
 };
 
 struct mmc_queue_req {
-	bool			in_use;
+	struct device		*dev;
 	struct request		*req;
 	struct mmc_blk_request	brq;
 	struct scatterlist	*sg;
@@ -41,20 +42,20 @@ struct mmc_queue_req {
 
 struct mmc_queue {
 	struct mmc_card		*card;
-	struct task_struct	*thread;
-	struct semaphore	thread_sem;
 	bool			suspended;
-	bool			asleep;
+	bool			claimed_host;
 	struct mmc_blk_data	*blkdata;
 	struct request_queue	*queue;
+	struct blk_mq_tag_set	tag_set;
 	spinlock_t		mqrq_lock;
 	struct mmc_queue_req	*mqrq;
 	unsigned int		qdepth;
+#ifdef CONFIG_MMC_BLOCK_BOUNCE
+	unsigned int		bouncesz;
+#endif
 };
 
-extern void mmc_queue_req_put(struct mmc_queue_req *mq_rq);
-extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
-			  const char *);
+extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, const char *);
 extern void mmc_cleanup_queue(struct mmc_queue *);
 extern void mmc_queue_suspend(struct mmc_queue *);
 extern void mmc_queue_resume(struct mmc_queue *);
-- 
2.9.3
