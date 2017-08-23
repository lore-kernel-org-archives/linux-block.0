Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:18403 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754006AbdHWNnq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 09:43:46 -0400
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: [PATCH RFC 3/3] mmc: block: Add blk-mq support for CQE
Date: Wed, 23 Aug 2017 16:37:08 +0300
Message-Id: <1503495428-11999-4-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1503495428-11999-1-git-send-email-adrian.hunter@intel.com>
References: <1503495428-11999-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Implement blk-mq support for eMMC hosts using a Command Queue Engine (CQE).

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c |  88 ++++++++++--
 drivers/mmc/core/block.h |   2 +
 drivers/mmc/core/queue.c | 363 +++++++++++++++++++++++++++++++++++++++++------
 drivers/mmc/core/queue.h |   4 +
 4 files changed, 402 insertions(+), 55 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index e6a5b0c6ebe3..829bca5650ee 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1177,6 +1177,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 	struct mmc_queue_req *mq_rq;
 	struct mmc_card *card = mq->card;
 	struct mmc_blk_data *md = mq->blkdata;
+	blk_status_t status;
 	int ret;
 	int i;
 
@@ -1212,7 +1213,11 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 		break;
 	}
 	mq_rq->drv_op_result = ret;
-	blk_end_request_all(req, ret);
+	status = ret ? BLK_STS_IOERR : BLK_STS_OK;
+	if (req->mq_ctx)
+		blk_mq_end_request(req, status);
+	else
+		blk_end_request_all(req, status);
 }
 
 static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
@@ -1255,7 +1260,10 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	else
 		mmc_blk_reset_success(md, type);
 fail:
-	blk_end_request(req, status, blk_rq_bytes(req));
+	if (req->mq_ctx)
+		blk_mq_end_request(req, status);
+	else
+		blk_end_request(req, status, blk_rq_bytes(req));
 }
 
 static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
@@ -1325,7 +1333,10 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 	if (!err)
 		mmc_blk_reset_success(md, type);
 out:
-	blk_end_request(req, status, blk_rq_bytes(req));
+	if (req->mq_ctx)
+		blk_mq_end_request(req, status);
+	else
+		blk_end_request(req, status, blk_rq_bytes(req));
 }
 
 static void mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
@@ -1335,7 +1346,10 @@ static void mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 	int ret = 0;
 
 	ret = mmc_flush_cache(card);
-	blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
+	if (req->mq_ctx)
+		blk_mq_end_request(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
+	else
+		blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
 }
 
 /*
@@ -1650,6 +1664,57 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 
 #define MMC_CQE_RETRIES 2
 
+void mmc_blk_mq_cqe_complete_rq(struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_request *mrq = &mqrq->brq.mrq;
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+	struct mmc_host *host = mq->card->host;
+	unsigned long flags;
+	bool put_card;
+	int err;
+
+	mmc_cqe_post_req(host, mrq);
+
+	if (mrq->cmd && mrq->cmd->error)
+		err = mrq->cmd->error;
+	else if (mrq->data && mrq->data->error)
+		err = mrq->data->error;
+	else
+		err = 0;
+
+	if (err) {
+		if (mqrq->retries++ < MMC_CQE_RETRIES)
+			blk_mq_requeue_request(req, true);
+		else
+			blk_mq_end_request(req, BLK_STS_IOERR);
+	} else if (mrq->data) {
+		if (blk_update_request(req, BLK_STS_OK, mrq->data->bytes_xfered))
+			blk_mq_requeue_request(req, true);
+		else
+			__blk_mq_end_request(req, BLK_STS_OK);
+	} else {
+		blk_mq_end_request(req, BLK_STS_OK);
+	}
+
+	spin_lock_irqsave(q->queue_lock, flags);
+
+	mq->cqe_in_flight[mmc_cqe_issue_type(host, req)] -= 1;
+
+	put_card = mmc_cqe_tot_in_flight(mq) == 0;
+
+	mmc_cqe_check_busy(mq);
+
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	if (!mq->cqe_busy)
+		blk_mq_run_hw_queues(q, true);
+
+	if (put_card)
+		mmc_ctx_put_card(mq->card, &mq->ctx);
+}
+
 void mmc_blk_cqe_complete_rq(struct request *req)
 {
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
@@ -1733,10 +1798,17 @@ static void mmc_blk_cqe_req_done(struct mmc_request *mrq)
 	 * Block layer timeouts race with completions which means the normal
 	 * completion path cannot be used during recovery.
 	 */
-	if (mq->cqe_in_recovery)
-		mmc_blk_cqe_complete_rq(req);
-	else
-		blk_complete_request(req);
+	if (mq->cqe_in_recovery) {
+		if (q->mq_ops)
+			mmc_blk_mq_cqe_complete_rq(req);
+		else
+			mmc_blk_cqe_complete_rq(req);
+	} else {
+		if (q->mq_ops)
+			blk_mq_complete_request(req);
+		else
+			blk_complete_request(req);
+	}
 }
 
 static int mmc_blk_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index d7b3d7008b00..446e3b1704f4 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -13,4 +13,6 @@ enum mmc_issued mmc_blk_cqe_issue_rq(struct mmc_queue *mq,
 void mmc_blk_cqe_complete_rq(struct request *rq);
 void mmc_blk_cqe_recovery(struct mmc_queue *mq);
 
+void mmc_blk_mq_cqe_complete_rq(struct request *rq);
+
 #endif
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 0cb7b0e8ee58..be0ba0a00db3 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -22,6 +22,7 @@
 #include "block.h"
 #include "core.h"
 #include "card.h"
+#include "host.h"
 
 #define MMC_QUEUE_BOUNCESZ	65536
 
@@ -64,12 +65,17 @@ static inline bool mmc_cqe_dcmd_busy(struct mmc_queue *mq)
 	return mq->cqe_in_flight[MMC_ISSUE_DCMD];
 }
 
-void mmc_cqe_kick_queue(struct mmc_queue *mq)
+void mmc_cqe_check_busy(struct mmc_queue *mq)
 {
 	if ((mq->cqe_busy & MMC_CQE_DCMD_BUSY) && !mmc_cqe_dcmd_busy(mq))
 		mq->cqe_busy &= ~MMC_CQE_DCMD_BUSY;
 
 	mq->cqe_busy &= ~MMC_CQE_QUEUE_FULL;
+}
+
+void mmc_cqe_kick_queue(struct mmc_queue *mq)
+{
+	mmc_cqe_check_busy(mq);
 
 	if (mq->asleep && !mq->cqe_busy)
 		__blk_run_queue(mq->queue);
@@ -98,9 +104,14 @@ enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
 
 static void __mmc_cqe_recovery_notifier(struct mmc_queue *mq)
 {
+	struct request_queue *q = mq->queue;
+
 	if (!mq->cqe_recovery_needed) {
 		mq->cqe_recovery_needed = true;
-		wake_up_process(mq->thread);
+		if (q->mq_ops)
+			schedule_work(&mq->cqe_recovery_work);
+		else
+			wake_up_process(mq->thread);
 	}
 }
 
@@ -284,6 +295,39 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
 	return __mmc_cqe_timed_out(req);
 }
 
+static enum blk_eh_timer_return mmc_mq_cqe_timed_out(struct request *req,
+						     bool reserved)
+{
+	struct request_queue *q = req->q;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	ret = mmc_cqe_timed_out(req);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	return ret;
+}
+
+static void mmc_mq_cqe_recovery_handler(struct work_struct *work)
+{
+	struct mmc_queue *mq = container_of(work, struct mmc_queue,
+					    cqe_recovery_work);
+	struct request_queue *q = mq->queue;
+
+	mmc_ctx_task_claim_host(mq->card->host, &mq->ctx);
+
+	mmc_blk_cqe_recovery(mq);
+
+	spin_lock_irq(q->queue_lock);
+	mq->cqe_recovery_needed = false;
+	spin_unlock_irq(q->queue_lock);
+
+	mmc_ctx_task_release_host(mq->card->host, &mq->ctx);
+
+	blk_mq_run_hw_queues(q, true);
+}
+
 static int mmc_queue_thread(void *d)
 {
 	struct mmc_queue *mq = d;
@@ -420,11 +464,10 @@ static unsigned int mmc_queue_calc_bouncesz(struct mmc_host *host)
  * @req: the request
  * @gfp: memory allocation policy
  */
-static int mmc_init_request(struct request_queue *q, struct request *req,
-			    gfp_t gfp)
+static int __mmc_init_request(struct mmc_queue *mq, struct request *req,
+			      gfp_t gfp)
 {
 	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
-	struct mmc_queue *mq = q->queuedata;
 	struct mmc_card *card = mq->card;
 	struct mmc_host *host = card->host;
 
@@ -452,6 +495,12 @@ static int mmc_init_request(struct request_queue *q, struct request *req,
 	return 0;
 }
 
+static int mmc_init_request(struct request_queue *q, struct request *req,
+			    gfp_t gfp)
+{
+	return __mmc_init_request(q->queuedata, req, gfp);
+}
+
 static void mmc_exit_request(struct request_queue *q, struct request *req)
 {
 	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
@@ -467,6 +516,203 @@ static void mmc_exit_request(struct request_queue *q, struct request *req)
 	mq_rq->sg = NULL;
 }
 
+static int mmc_mq_init_request(struct blk_mq_tag_set *set, struct request *req,
+			       unsigned int hctx_idx, unsigned int numa_node)
+{
+	return __mmc_init_request(set->driver_data, req, GFP_KERNEL);
+}
+
+static void mmc_mq_exit_request(struct blk_mq_tag_set *set, struct request *req,
+				unsigned int hctx_idx)
+{
+	struct mmc_queue *mq = set->driver_data;
+
+	mmc_exit_request(mq->queue, req);
+}
+
+static blk_status_t mmc_cqe_queue_rq(struct blk_mq_hw_ctx *hctx,
+				     const struct blk_mq_queue_data *bd)
+{
+	struct request *req = bd->rq;
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+	struct mmc_card *card = mq->card;
+	struct mmc_host *host = card->host;
+	enum mmc_issue_type issue_type;
+	enum mmc_issued issued;
+	bool get_card, retune_ok;
+	int ret;
+
+	issue_type = mmc_cqe_issue_type(host, req);
+
+	spin_lock_irq(q->queue_lock);
+
+	switch (issue_type) {
+	case MMC_ISSUE_DCMD:
+		if (mmc_cqe_dcmd_busy(mq)) {
+			mq->cqe_busy |= MMC_CQE_DCMD_BUSY;
+			spin_unlock_irq(q->queue_lock);
+			return BLK_STS_RESOURCE;
+		}
+		break;
+	case MMC_ISSUE_ASYNC:
+		break;
+	default:
+		/*
+		 * Timeouts are handled by mmc core, so set a large value to
+		 * avoid races.
+		 */
+		req->timeout = 600 * HZ;
+		break;
+	}
+
+	mq->cqe_in_flight[issue_type] += 1;
+	get_card = mmc_cqe_tot_in_flight(mq) == 1;
+	retune_ok = mmc_cqe_qcnt(mq) == 1;
+
+	spin_unlock_irq(q->queue_lock);
+
+	if (!(req->rq_flags & RQF_DONTPREP)) {
+		req_to_mmc_queue_req(req)->retries = 0;
+		req->rq_flags |= RQF_DONTPREP;
+	}
+
+	if (get_card)
+		mmc_ctx_get_card(card, &mq->ctx);
+
+	if (host->need_retune && retune_ok && !host->hold_retune)
+		host->retune_now = true;
+	else
+		host->retune_now = false;
+
+	blk_mq_start_request(req);
+
+	issued = mmc_blk_cqe_issue_rq(mq, req);
+
+	switch (issued) {
+	case MMC_REQ_BUSY:
+		ret = BLK_STS_RESOURCE;
+		break;
+	case MMC_REQ_FAILED_TO_START:
+		ret = BLK_STS_IOERR;
+		break;
+	default:
+		ret = BLK_STS_OK;
+		break;
+	}
+
+	if (issued != MMC_REQ_STARTED) {
+		bool put_card = false;
+
+		spin_lock_irq(q->queue_lock);
+		mq->cqe_in_flight[issue_type] -= 1;
+		if (mmc_cqe_tot_in_flight(mq) == 0)
+			put_card = true;
+		spin_unlock_irq(q->queue_lock);
+		if (put_card)
+			mmc_ctx_put_card(card, &mq->ctx);
+	}
+
+	return ret;
+}
+
+static const struct blk_mq_ops mmc_mq_cqe_ops = {
+	.queue_rq	= mmc_cqe_queue_rq,
+	.init_request	= mmc_mq_init_request,
+	.exit_request	= mmc_mq_exit_request,
+	.complete	= mmc_blk_mq_cqe_complete_rq,
+	.timeout	= mmc_mq_cqe_timed_out,
+};
+
+static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
+{
+	struct mmc_host *host = card->host;
+	u64 limit = BLK_BOUNCE_HIGH;
+
+	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
+		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
+
+	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
+	queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, mq->queue);
+	if (mmc_can_erase(card))
+		mmc_queue_setup_discard(mq->queue, card);
+
+	card->bouncesz = mmc_queue_calc_bouncesz(host);
+	if (card->bouncesz) {
+		blk_queue_max_hw_sectors(mq->queue, card->bouncesz / 512);
+		blk_queue_max_segments(mq->queue, card->bouncesz / 512);
+		blk_queue_max_segment_size(mq->queue, card->bouncesz);
+	} else {
+		blk_queue_bounce_limit(mq->queue, limit);
+		blk_queue_max_hw_sectors(mq->queue,
+			min(host->max_blk_count, host->max_req_size / 512));
+		blk_queue_max_segments(mq->queue, host->max_segs);
+		blk_queue_max_segment_size(mq->queue, host->max_seg_size);
+	}
+
+	/* Initialize thread_sem even if it is not used */
+	sema_init(&mq->thread_sem, 1);
+
+	/* Initialize cqe_recovery_work even if it is not used */
+	INIT_WORK(&mq->cqe_recovery_work, mmc_mq_cqe_recovery_handler);
+}
+
+static int mmc_mq_init_queue(struct mmc_queue *mq, int q_depth,
+			     const struct blk_mq_ops *mq_ops, spinlock_t *lock)
+{
+	int ret;
+
+	memset(&mq->tag_set, 0, sizeof(mq->tag_set));
+	mq->tag_set.ops = mq_ops;
+	mq->tag_set.queue_depth = q_depth;
+	mq->tag_set.numa_node = NUMA_NO_NODE;
+	mq->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE |
+			    BLK_MQ_F_BLOCKING;
+	mq->tag_set.nr_hw_queues = 1;
+	mq->tag_set.cmd_size = sizeof(struct mmc_queue_req);
+	mq->tag_set.driver_data = mq;
+
+	ret = blk_mq_alloc_tag_set(&mq->tag_set);
+	if (ret)
+		return ret;
+
+	mq->queue = blk_mq_init_queue(&mq->tag_set);
+	if (IS_ERR(mq->queue)) {
+		ret = PTR_ERR(mq->queue);
+		goto free_tag_set;
+	}
+
+	mq->queue->queue_lock = lock;
+	mq->queue->queuedata = mq;
+
+	return 0;
+
+free_tag_set:
+	blk_mq_free_tag_set(&mq->tag_set);
+
+	return ret;
+}
+
+static int mmc_mq_cqe_init_queue(struct mmc_queue *mq, struct mmc_card *card,
+				 spinlock_t *lock)
+{
+	struct mmc_host *host = card->host;
+	int q_depth = min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
+	int ret;
+
+	ret = mmc_mq_init_queue(mq, q_depth, &mmc_mq_cqe_ops, lock);
+	if (ret)
+		return ret;
+
+	blk_queue_rq_timeout(mq->queue, 60 * HZ);
+
+	host->cqe_recovery_notifier = mmc_cqe_recovery_notifier;
+
+	mmc_setup_queue(mq, card);
+
+	return 0;
+}
+
 /**
  * mmc_init_queue - initialise a queue structure.
  * @mq: mmc queue
@@ -480,14 +726,14 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		   spinlock_t *lock, const char *subname, int area_type)
 {
 	struct mmc_host *host = card->host;
-	u64 limit = BLK_BOUNCE_HIGH;
 	int ret = -ENOMEM;
 	bool use_cqe = host->cqe_enabled && area_type != MMC_BLK_DATA_AREA_RPMB;
 
-	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
-		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
-
 	mq->card = card;
+
+	if (mmc_host_use_blk_mq(host) && use_cqe)
+		return mmc_mq_cqe_init_queue(mq, card, lock);
+
 	mq->queue = blk_alloc_queue(GFP_KERNEL);
 	if (!mq->queue)
 		return -ENOMEM;
@@ -523,25 +769,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	}
 
 	blk_queue_prep_rq(mq->queue, mmc_prep_request);
-	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
-	queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, mq->queue);
-	if (mmc_can_erase(card))
-		mmc_queue_setup_discard(mq->queue, card);
-
-	card->bouncesz = mmc_queue_calc_bouncesz(host);
-	if (card->bouncesz) {
-		blk_queue_max_hw_sectors(mq->queue, card->bouncesz / 512);
-		blk_queue_max_segments(mq->queue, card->bouncesz / 512);
-		blk_queue_max_segment_size(mq->queue, card->bouncesz);
-	} else {
-		blk_queue_bounce_limit(mq->queue, limit);
-		blk_queue_max_hw_sectors(mq->queue,
-			min(host->max_blk_count, host->max_req_size / 512));
-		blk_queue_max_segments(mq->queue, host->max_segs);
-		blk_queue_max_segment_size(mq->queue, host->max_seg_size);
-	}
 
-	sema_init(&mq->thread_sem, 1);
+	mmc_setup_queue(mq, card);
 
 	mq->thread = kthread_run(use_cqe ? mmc_cqe_thread : mmc_queue_thread,
 				 mq, "mmcqd/%d%s", host->index,
@@ -558,11 +787,63 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	return ret;
 }
 
+static void mmc_mq_queue_suspend(struct mmc_queue *mq)
+{
+	blk_mq_quiesce_queue(mq->queue);
+
+	/*
+	 * The host remains claimed while there are outstanding requests, so
+	 * simply claiming and releasing here ensures there are none.
+	 */
+	mmc_claim_host(mq->card->host);
+	mmc_release_host(mq->card->host);
+}
+
+static void mmc_mq_queue_resume(struct mmc_queue *mq)
+{
+	blk_mq_unquiesce_queue(mq->queue);
+}
+
+static void __mmc_queue_suspend(struct mmc_queue *mq)
+{
+	struct request_queue *q = mq->queue;
+	unsigned long flags;
+
+	if (!mq->suspended) {
+		mq->suspended |= true;
+
+		spin_lock_irqsave(q->queue_lock, flags);
+		blk_stop_queue(q);
+		spin_unlock_irqrestore(q->queue_lock, flags);
+
+		down(&mq->thread_sem);
+	}
+}
+
+static void __mmc_queue_resume(struct mmc_queue *mq)
+{
+	struct request_queue *q = mq->queue;
+	unsigned long flags;
+
+	if (mq->suspended) {
+		mq->suspended = false;
+
+		up(&mq->thread_sem);
+
+		spin_lock_irqsave(q->queue_lock, flags);
+		blk_start_queue(q);
+		spin_unlock_irqrestore(q->queue_lock, flags);
+	}
+}
+
 void mmc_cleanup_queue(struct mmc_queue *mq)
 {
 	struct request_queue *q = mq->queue;
 	unsigned long flags;
 
+	if (q->mq_ops)
+		return;
+
 	/* Make sure the queue isn't suspended, as that will deadlock */
 	mmc_queue_resume(mq);
 
@@ -590,17 +871,11 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 void mmc_queue_suspend(struct mmc_queue *mq)
 {
 	struct request_queue *q = mq->queue;
-	unsigned long flags;
-
-	if (!mq->suspended) {
-		mq->suspended |= true;
-
-		spin_lock_irqsave(q->queue_lock, flags);
-		blk_stop_queue(q);
-		spin_unlock_irqrestore(q->queue_lock, flags);
 
-		down(&mq->thread_sem);
-	}
+	if (q->mq_ops)
+		mmc_mq_queue_suspend(mq);
+	else
+		__mmc_queue_suspend(mq);
 }
 
 /**
@@ -610,17 +885,11 @@ void mmc_queue_suspend(struct mmc_queue *mq)
 void mmc_queue_resume(struct mmc_queue *mq)
 {
 	struct request_queue *q = mq->queue;
-	unsigned long flags;
-
-	if (mq->suspended) {
-		mq->suspended = false;
 
-		up(&mq->thread_sem);
-
-		spin_lock_irqsave(q->queue_lock, flags);
-		blk_start_queue(q);
-		spin_unlock_irqrestore(q->queue_lock, flags);
-	}
+	if (q->mq_ops)
+		mmc_mq_queue_resume(mq);
+	else
+		__mmc_queue_resume(mq);
 }
 
 /*
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 8e9273d977c0..ab27d1e03164 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -74,6 +74,8 @@ struct mmc_queue {
 	struct mmc_card		*card;
 	struct task_struct	*thread;
 	struct semaphore	thread_sem;
+	struct mmc_ctx		ctx;
+	struct blk_mq_tag_set	tag_set;
 	bool			suspended;
 	bool			asleep;
 	struct mmc_blk_data	*blkdata;
@@ -92,6 +94,7 @@ struct mmc_queue {
 	bool			cqe_in_recovery;
 #define MMC_CQE_DCMD_BUSY	BIT(0)
 #define MMC_CQE_QUEUE_FULL	BIT(1)
+	struct work_struct	cqe_recovery_work;
 };
 
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
@@ -107,6 +110,7 @@ extern unsigned int mmc_queue_map_sg(struct mmc_queue *,
 
 extern int mmc_access_rpmb(struct mmc_queue *);
 
+void mmc_cqe_check_busy(struct mmc_queue *mq);
 void mmc_cqe_kick_queue(struct mmc_queue *mq);
 
 enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
-- 
1.9.1
