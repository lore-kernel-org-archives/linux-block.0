Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
	Baolin Wang <baolin.wang@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Paolo Valente <paolo.valente@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] RFD: switch MMC/SD to use blk-mq multiqueueing
Date: Tue, 20 Dec 2016 15:01:48 +0100
Message-Id: <1482242508-26131-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

HACK ALERT: DO NOT MERGE THIS! IT IS A FYI PATCH FOR DISCUSSION
ONLY.

This hack switches the MMC/SD subsystem from using the legacy blk
layer to using blk-mq. It does this by registering one single
hardware queue, since MMC/SD has only one command pipe. I kill
off the worker thread altogether and let the MQ core logic fire
sleepable requests directly into the MMC core.

We emulate the 2 elements deep pipeline by specifying queue depth
2, which is an elaborate lie that makes the block layer issue
another request while a previous request is in transit. It't not
neat but it works.

As the pipeline needs to be flushed by pushing in a NULL request
after the last block layer request I added a delayed work with a
timeout of zero. This will fire as soon as the block layer stops
pushing in requests: as long as there are new requests the MQ
block layer will just repeatedly cancel this pipeline flush work
and push new requests into the pipeline, but once the requests
stop coming the NULL request will be flushed into the pipeline.

It's not pretty but it works... Look at the following performance
statistics:

BEFORE this patch:

time dd if=/dev/mmcblk0 of=/dev/null bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.0GB) copied, 45.145874 seconds, 22.7MB/s
real    0m 45.15s
user    0m 0.02s
sys     0m 7.51s

mount /dev/mmcblk0p1 /mnt/
cd /mnt/
time find . > /dev/null
real    0m 3.70s
user    0m 0.29s
sys     0m 1.63s

AFTER this patch:

time dd if=/dev/mmcblk0 of=/dev/null bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.0GB) copied, 45.285431 seconds, 22.6MB/s
real    0m 45.29s
user    0m 0.02s
sys     0m 6.58s

mount /dev/mmcblk0p1 /mnt/
cd /mnt/
time find . > /dev/null
real    0m 4.37s
user    0m 0.27s
sys     0m 1.65s

The results are consistent.

As you can see, for a straight dd-like task, we get more or less the
same nice parallelism as for the old framework. I have confirmed
through debugprints that indeed this is because the two-stage pipeline
is full at all times.

However, for spurious reads in the find command, we already see a big
performance regression.

This is because there are many small operations requireing a flush of
the pipeline, which used to happen immediately with the old block
layer interface code that used to pull a few NULL requests off the
queue and feed them into the pipeline immediately after the last
request, but happens after the delayed work is executed in this
new framework. The delayed work is never quick enough to terminate
all these small operations even if we schedule it immediately after
the last request.

AFAICT the only way forward to provide proper performance with MQ
for MMC/SD is to get the requests to complete out-of-sync, i.e. when
the driver calls back to MMC/SD core to notify that a request is
complete, it should not notify any main thread with a completion
as is done right now, but instead directly call blk_end_request_all()
and only schedule some extra communication with the card if necessary
for example to handle an error condition.

This rework needs a bigger rewrite so we can get rid of the paradigm
of the block layer "driving" the requests throgh the pipeline.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c |  43 +++----
 drivers/mmc/core/queue.c | 308 ++++++++++++++++++++++++++---------------------
 drivers/mmc/core/queue.h |  13 +-
 3 files changed, 203 insertions(+), 161 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index bab3f07b1117..308ab7838f0d 100644
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
@@ -90,7 +91,6 @@ static DEFINE_SPINLOCK(mmc_blk_lock);
  * There is one mmc_blk_data per slot.
  */
 struct mmc_blk_data {
-	spinlock_t	lock;
 	struct device	*parent;
 	struct gendisk	*disk;
 	struct mmc_queue queue;
@@ -1181,7 +1181,8 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 		goto retry;
 	if (!err)
 		mmc_blk_reset_success(md, type);
-	blk_end_request(req, err, blk_rq_bytes(req));
+
+	blk_mq_complete_request(req, err);
 
 	return err ? 0 : 1;
 }
@@ -1248,7 +1249,7 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 	if (!err)
 		mmc_blk_reset_success(md, type);
 out:
-	blk_end_request(req, err, blk_rq_bytes(req));
+	blk_mq_complete_request(req, err);
 
 	return err ? 0 : 1;
 }
@@ -1263,7 +1264,8 @@ static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 	if (ret)
 		ret = -EIO;
 
-	blk_end_request_all(req, ret);
+	/* FIXME: was using blk_end_request_all() to flush */
+	blk_mq_complete_request(req, ret);
 
 	return ret ? 0 : 1;
 }
@@ -1585,10 +1587,12 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 
 		blocks = mmc_sd_num_wr_blocks(card);
 		if (blocks != (u32)-1) {
-			ret = blk_end_request(req, 0, blocks << 9);
+			blk_mq_complete_request(req, 0);
+			ret = 0;
 		}
 	} else {
-		ret = blk_end_request(req, 0, brq->data.bytes_xfered);
+		blk_mq_complete_request(req, 0);
+		ret = 0;
 	}
 	return ret;
 }
@@ -1648,9 +1652,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			 */
 			mmc_blk_reset_success(md, type);
 
-			ret = blk_end_request(req, 0,
-					brq->data.bytes_xfered);
-
+			blk_mq_complete_request(req, 0);
+			ret = 0;
 			/*
 			 * If the blk_end_request function returns non-zero even
 			 * though all data has been transferred and no errors
@@ -1703,8 +1706,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			 * time, so we only reach here after trying to
 			 * read a single sector.
 			 */
-			ret = blk_end_request(req, -EIO,
-						brq->data.blksz);
+			blk_mq_complete_request(req, -EIO);
 			if (!ret)
 				goto start_new_req;
 			break;
@@ -1733,16 +1735,16 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 
  cmd_abort:
 	if (mmc_card_removed(card))
-		req->rq_flags |= RQF_QUIET;
-	while (ret)
-		ret = blk_end_request(req, -EIO,
-				blk_rq_cur_bytes(req));
+		req->cmd_flags |= RQF_QUIET;
+	blk_mq_complete_request(req, -EIO);
+	ret = 0;
 
  start_new_req:
 	if (rqc) {
 		if (mmc_card_removed(card)) {
 			rqc->rq_flags |= RQF_QUIET;
-			blk_end_request_all(rqc, -EIO);
+			/* FIXME: was blk_end_request_all() */
+			blk_mq_complete_request(rqc, -EIO);
 		} else {
 			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
 			mmc_start_req(card->host,
@@ -1766,9 +1768,9 @@ int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
-		if (req) {
-			blk_end_request_all(req, -EIO);
-		}
+		if (req)
+			/* FIXME: was blk_end_request_all() to flush */
+			blk_mq_complete_request(req, -EIO);
 		ret = 0;
 		goto out;
 	}
@@ -1859,11 +1861,10 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 		goto err_kfree;
 	}
 
-	spin_lock_init(&md->lock);
 	INIT_LIST_HEAD(&md->part);
 	md->usage = 1;
 
-	ret = mmc_init_queue(&md->queue, card, &md->lock, subname);
+	ret = mmc_init_queue(&md->queue, card, subname);
 	if (ret)
 		goto err_putdisk;
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index a6496d8027bc..6914d0bff959 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -10,11 +10,12 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/freezer.h>
-#include <linux/kthread.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-mapping.h>
-
+#include <linux/workqueue.h>
+#include <linux/mutex.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 
@@ -23,6 +24,12 @@
 
 #define MMC_QUEUE_BOUNCESZ	65536
 
+/* Per-request struct */
+struct mmc_block_cmd {
+	struct request *rq;
+	struct device *dev;
+};
+
 /*
  * Prepare a MMC request. This just filters out odd stuff.
  */
@@ -47,107 +54,6 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 	return BLKPREP_OK;
 }
 
-static int mmc_queue_thread(void *d)
-{
-	struct mmc_queue *mq = d;
-	struct request_queue *q = mq->queue;
-	struct mmc_context_info *cntx = &mq->card->host->context_info;
-
-	current->flags |= PF_MEMALLOC;
-
-	down(&mq->thread_sem);
-	do {
-		struct request *req = NULL;
-
-		spin_lock_irq(q->queue_lock);
-		set_current_state(TASK_INTERRUPTIBLE);
-		req = blk_fetch_request(q);
-		mq->asleep = false;
-		cntx->is_waiting_last_req = false;
-		cntx->is_new_req = false;
-		if (!req) {
-			/*
-			 * Dispatch queue is empty so set flags for
-			 * mmc_request_fn() to wake us up.
-			 */
-			if (mq->mqrq_prev->req)
-				cntx->is_waiting_last_req = true;
-			else
-				mq->asleep = true;
-		}
-		mq->mqrq_cur->req = req;
-		spin_unlock_irq(q->queue_lock);
-
-		if (req || mq->mqrq_prev->req) {
-			bool req_is_special = mmc_req_is_special(req);
-
-			set_current_state(TASK_RUNNING);
-			mmc_blk_issue_rq(mq, req);
-			cond_resched();
-			if (mq->flags & MMC_QUEUE_NEW_REQUEST) {
-				mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
-				continue; /* fetch again */
-			}
-
-			/*
-			 * Current request becomes previous request
-			 * and vice versa.
-			 * In case of special requests, current request
-			 * has been finished. Do not assign it to previous
-			 * request.
-			 */
-			if (req_is_special)
-				mq->mqrq_cur->req = NULL;
-
-			mq->mqrq_prev->brq.mrq.data = NULL;
-			mq->mqrq_prev->req = NULL;
-			swap(mq->mqrq_prev, mq->mqrq_cur);
-		} else {
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
-	struct mmc_context_info *cntx;
-
-	if (!mq) {
-		while ((req = blk_fetch_request(q)) != NULL) {
-			req->rq_flags |= RQF_QUIET;
-			__blk_end_request_all(req, -EIO);
-		}
-		return;
-	}
-
-	cntx = &mq->card->host->context_info;
-
-	if (cntx->is_waiting_last_req) {
-		cntx->is_new_req = true;
-		wake_up_interruptible(&cntx->wait);
-	}
-
-	if (mq->asleep)
-		wake_up_process(mq->thread);
-}
-
 static struct scatterlist *mmc_alloc_sg(int sg_len, int *err)
 {
 	struct scatterlist *sg;
@@ -240,6 +146,127 @@ static int mmc_queue_alloc_sgs(struct mmc_queue *mq, int max_segs)
 	return 0;
 }
 
+static void mmc_queue_timeout(struct work_struct *work)
+{
+	struct mmc_queue *mq =
+		container_of(work, struct mmc_queue, work.work);
+
+	/*
+	 * After a timeout, if the block layer is not pushing
+	 * in more requests, flush the pipeline by issueing a
+	 * NULL request.
+	 */
+	mutex_lock(&mq->lock);
+
+	mq->mqrq_cur->req = NULL;
+	mmc_blk_issue_rq(mq, NULL);
+
+	mq->mqrq_prev->brq.mrq.data = NULL;
+	mq->mqrq_prev->req = NULL;
+	swap(mq->mqrq_prev, mq->mqrq_cur);
+
+	mutex_unlock(&mq->lock);
+}
+
+static int mmc_queue_rq(struct blk_mq_hw_ctx *hctx,
+		const struct blk_mq_queue_data *bd)
+{
+	struct mmc_block_cmd *cmd = blk_mq_rq_to_pdu(bd->rq);
+	struct mmc_queue *mq = cmd->rq->q->queuedata;
+	struct request *req = bd->rq;
+	struct mmc_context_info *cntx;
+	bool req_is_special = mmc_req_is_special(req);
+
+	/* start this request */
+	blk_mq_start_request(req);
+
+	/*
+	 * If we are waiting for a flush timeout: cancel it. This new request
+	 * will flush the async pipeline.
+	 */
+	cancel_delayed_work_sync(&mq->work);
+
+	mutex_lock(&mq->lock);
+
+	/* Submit the request */
+	mq->mqrq_cur->req = req;
+	mmc_blk_issue_rq(mq, req);
+
+	if (mq->flags & MMC_QUEUE_NEW_REQUEST)
+		mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
+
+	/*
+	 * Current request becomes previous request
+	 * and vice versa.
+	 *
+	 * In case of special requests, current request
+	 * has been finished. Do not assign it to previous
+	 * request.
+	 */
+	if (req_is_special)
+		mq->mqrq_cur->req = NULL;
+
+	mq->mqrq_prev->brq.mrq.data = NULL;
+	mq->mqrq_prev->req = NULL;
+	swap(mq->mqrq_prev, mq->mqrq_cur);
+
+	cntx = &mq->card->host->context_info;
+	if (cntx->is_waiting_last_req) {
+		cntx->is_new_req = true;
+		wake_up_interruptible(&cntx->wait);
+	}
+
+	mutex_unlock(&mq->lock);
+
+	/*
+	 * Bump the flush timer to expire per immediately.
+	 *
+	 * What happens is that if there is more work to be pushed in from
+	 * the block layer, then that happens before the delayed work has
+	 * a chance to run and this work gets cancelled quite immediately.
+	 * Else a short lapse passes and the work gets scheduled and will
+	 * then flush the async pipeline.
+	 */
+	schedule_delayed_work(&mq->work, 0);
+
+	return BLK_MQ_RQ_QUEUE_OK;
+}
+
+static int mmc_init_request(void *data, struct request *rq,
+		unsigned int hctx_idx, unsigned int request_idx,
+		unsigned int numa_node)
+{
+	struct mmc_block_cmd *cmd = blk_mq_rq_to_pdu(rq);
+	struct mmc_queue *mq = data;
+	struct mmc_card *card = mq->card;
+	struct mmc_host *host = card->host;
+
+	cmd->rq = rq;
+	cmd->dev = host->parent;
+
+	return 0;
+}
+
+static void mmc_exit_request(void *data, struct request *rq,
+			     unsigned int hctx_idx, unsigned int request_idx)
+{
+	struct mmc_block_cmd *cmd = blk_mq_rq_to_pdu(rq);
+
+	dev_info(cmd->dev, "%s: hctx_idx = %u, request_idx = %u\n",
+		 __func__, hctx_idx, request_idx);
+}
+
+static struct blk_mq_ops mmc_mq_ops = {
+	.queue_rq	= mmc_queue_rq,
+	.init_request	= mmc_init_request,
+	.exit_request	= mmc_exit_request,
+	/*
+	 * .exit_request() will only be invoked if we explcitly call
+	 * blk_mq_end_request() on all requests. Why would we do that,
+	 * we will just call blk_mq_complete_request().
+	 */
+};
+
 static void mmc_queue_req_free_bufs(struct mmc_queue_req *mqrq)
 {
 	kfree(mqrq->bounce_sg);
@@ -270,7 +297,7 @@ static void mmc_queue_reqs_free_bufs(struct mmc_queue *mq)
  * Initialise a MMC card request queue.
  */
 int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
-		   spinlock_t *lock, const char *subname)
+		   const char *subname)
 {
 	struct mmc_host *host = card->host;
 	u64 limit = BLK_BOUNCE_HIGH;
@@ -281,10 +308,38 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
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
+	mq->tag_set.cmd_size = sizeof(struct mmc_block_cmd);
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
+
+	mq->queue = blk_mq_init_queue(&mq->tag_set);
+	if (!mq->queue) {
+		dev_err(card->host->parent, "failed to initialize block MQ\n");
+		goto cleanup_free_tag_set;
+	}
+
+	blk_queue_max_segments(mq->queue, host->max_segs);
 
+	/* Set up the async request timeout timer */
+	mutex_init(&mq->lock);
+	INIT_DELAYED_WORK(&mq->work, mmc_queue_timeout);
 	mq->qdepth = 2;
 	mq->mqrq = kcalloc(mq->qdepth, sizeof(struct mmc_queue_req),
 			   GFP_KERNEL);
@@ -340,16 +395,6 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 			goto cleanup_queue;
 	}
 
-	sema_init(&mq->thread_sem, 1);
-
-	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d%s",
-		host->index, subname ? subname : "");
-
-	if (IS_ERR(mq->thread)) {
-		ret = PTR_ERR(mq->thread);
-		goto cleanup_queue;
-	}
-
 	return 0;
 
  cleanup_queue:
@@ -358,30 +403,34 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	mq->mqrq = NULL;
 blk_cleanup:
 	blk_cleanup_queue(mq->queue);
+
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
+
+	/* Sync and kill the timer */
+	cancel_delayed_work_sync(&mq->work);
 
 	mmc_queue_reqs_free_bufs(mq);
 	kfree(mq->mqrq);
 	mq->mqrq = NULL;
 
+	blk_cleanup_queue(mq->queue);
+	blk_mq_free_tag_set(&mq->tag_set);
+
 	mq->card = NULL;
 }
 EXPORT_SYMBOL(mmc_cleanup_queue);
@@ -390,23 +439,18 @@ EXPORT_SYMBOL(mmc_cleanup_queue);
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
 
+	/* FIXME: deal with worker queue */
 	if (!(mq->flags & MMC_QUEUE_SUSPENDED)) {
 		mq->flags |= MMC_QUEUE_SUSPENDED;
 
-		spin_lock_irqsave(q->queue_lock, flags);
 		blk_stop_queue(q);
-		spin_unlock_irqrestore(q->queue_lock, flags);
-
-		down(&mq->thread_sem);
 	}
 }
 
@@ -417,16 +461,12 @@ void mmc_queue_suspend(struct mmc_queue *mq)
 void mmc_queue_resume(struct mmc_queue *mq)
 {
 	struct request_queue *q = mq->queue;
-	unsigned long flags;
 
+	/* FIXME: deal with worker queue */
 	if (mq->flags & MMC_QUEUE_SUSPENDED) {
 		mq->flags &= ~MMC_QUEUE_SUSPENDED;
 
-		up(&mq->thread_sem);
-
-		spin_lock_irqsave(q->queue_lock, flags);
 		blk_start_queue(q);
-		spin_unlock_irqrestore(q->queue_lock, flags);
 	}
 }
 
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index dac8c3d010dd..b9b97bc16f8e 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -1,6 +1,9 @@
 #ifndef MMC_QUEUE_H
 #define MMC_QUEUE_H
 
+#include <linux/workqueue.h>
+#include <linux/mutex.h>
+
 static inline bool mmc_req_is_special(struct request *req)
 {
 	return req &&
@@ -10,7 +13,6 @@ static inline bool mmc_req_is_special(struct request *req)
 }
 
 struct request;
-struct task_struct;
 struct mmc_blk_data;
 
 struct mmc_blk_request {
@@ -34,22 +36,21 @@ struct mmc_queue_req {
 
 struct mmc_queue {
 	struct mmc_card		*card;
-	struct task_struct	*thread;
-	struct semaphore	thread_sem;
 	unsigned int		flags;
 #define MMC_QUEUE_SUSPENDED	(1 << 0)
 #define MMC_QUEUE_NEW_REQUEST	(1 << 1)
-	bool			asleep;
 	struct mmc_blk_data	*blkdata;
 	struct request_queue	*queue;
+	struct blk_mq_tag_set	tag_set;
 	struct mmc_queue_req	*mqrq;
 	struct mmc_queue_req	*mqrq_cur;
 	struct mmc_queue_req	*mqrq_prev;
 	int			qdepth;
+	struct mutex		lock;
+	struct delayed_work	work;
 };
 
-extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
-			  const char *);
+extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, const char *);
 extern void mmc_cleanup_queue(struct mmc_queue *);
 extern void mmc_queue_suspend(struct mmc_queue *);
 extern void mmc_queue_resume(struct mmc_queue *);
-- 
2.7.4
