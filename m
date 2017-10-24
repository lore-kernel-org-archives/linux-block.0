Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:22351 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752100AbdJXIrk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Oct 2017 04:47:40 -0400
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V12 3/5] mmc: block: Add CQE support
Date: Tue, 24 Oct 2017 11:40:26 +0300
Message-Id: <1508834428-4360-4-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1508834428-4360-1-git-send-email-adrian.hunter@intel.com>
References: <1508834428-4360-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add CQE support to the block driver, including:
    - optionally using DCMD for flush requests
    - "manually" issuing discard requests
    - issuing read / write requests to the CQE
    - supporting block-layer timeouts
    - handling recovery
    - supporting re-tuning

CQE offers 25% - 50% better random multi-threaded I/O.  There is a slight
(e.g. 2%) drop in sequential read speed but no observable change to sequential
write.

CQE automatically sends the commands to complete requests.  However it only
supports reads / writes and so-called "direct commands" (DCMD).  Furthermore
DCMD is limited to one command at a time, but discards require 3 commands.
That makes issuing discards through CQE very awkward, but some CQE's don't
support DCMD anyway.  So for discards, the existing non-CQE approach is
taken, where the mmc core code issues the 3 commands one at a time i.e.
mmc_erase(). Where DCMD is used, is for issuing flushes.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/core/block.h |   2 +
 drivers/mmc/core/queue.c | 134 ++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/core/queue.h |  15 +++++
 4 files changed, 294 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 002446e8dc5d..5a1fa678667b 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -112,6 +112,7 @@ struct mmc_blk_data {
 #define MMC_BLK_WRITE		BIT(1)
 #define MMC_BLK_DISCARD		BIT(2)
 #define MMC_BLK_SECDISCARD	BIT(3)
+#define MMC_BLK_CQE_RECOVERY	BIT(4)
 
 	/*
 	 * Only set in main mmc_blk_data associated
@@ -1713,6 +1714,138 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 		*do_data_tag_p = do_data_tag;
 }
 
+#define MMC_CQE_RETRIES 2
+
+static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_request *mrq = &mqrq->brq.mrq;
+	struct request_queue *q = req->q;
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
+	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
+
+	put_card = mmc_tot_in_flight(mq) == 0;
+
+	mmc_cqe_check_busy(mq);
+
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	if (!mq->cqe_busy)
+		blk_mq_run_hw_queues(q, true);
+
+	if (put_card)
+		mmc_put_card(mq->card, &mq->ctx);
+}
+
+void mmc_blk_cqe_recovery(struct mmc_queue *mq)
+{
+	struct mmc_card *card = mq->card;
+	struct mmc_host *host = card->host;
+	int err;
+
+	pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
+
+	err = mmc_cqe_recovery(host);
+	if (err)
+		mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
+	else
+		mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
+
+	pr_debug("%s: CQE recovery done\n", mmc_hostname(host));
+}
+
+static void mmc_blk_cqe_req_done(struct mmc_request *mrq)
+{
+	struct mmc_queue_req *mqrq = container_of(mrq, struct mmc_queue_req,
+						  brq.mrq);
+	struct request *req = mmc_queue_req_to_req(mqrq);
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+
+	/*
+	 * Block layer timeouts race with completions which means the normal
+	 * completion path cannot be used during recovery.
+	 */
+	if (mq->in_recovery)
+		mmc_blk_cqe_complete_rq(mq, req);
+	else
+		blk_mq_complete_request(req);
+}
+
+static int mmc_blk_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
+{
+	mrq->done		= mmc_blk_cqe_req_done;
+	mrq->recovery_notifier	= mmc_cqe_recovery_notifier;
+
+	return mmc_cqe_start_req(host, mrq);
+}
+
+static struct mmc_request *mmc_blk_cqe_prep_dcmd(struct mmc_queue_req *mqrq,
+						 struct request *req)
+{
+	struct mmc_blk_request *brq = &mqrq->brq;
+
+	memset(brq, 0, sizeof(*brq));
+
+	brq->mrq.cmd = &brq->cmd;
+	brq->mrq.tag = req->tag;
+
+	return &brq->mrq;
+}
+
+static int mmc_blk_cqe_issue_flush(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_request *mrq = mmc_blk_cqe_prep_dcmd(mqrq, req);
+
+	mrq->cmd->opcode = MMC_SWITCH;
+	mrq->cmd->arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
+			(EXT_CSD_FLUSH_CACHE << 16) |
+			(1 << 8) |
+			EXT_CSD_CMD_SET_NORMAL;
+	mrq->cmd->flags = MMC_CMD_AC | MMC_RSP_R1B;
+
+	return mmc_blk_cqe_start_req(mq->card->host, mrq);
+}
+
+static int mmc_blk_cqe_issue_rw_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+
+	mmc_blk_data_prep(mq, mqrq, 0, NULL, NULL);
+
+	return mmc_blk_cqe_start_req(mq->card->host, &mqrq->brq.mrq);
+}
+
 static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			       struct mmc_card *card,
 			       int disable_multi,
@@ -2125,7 +2258,10 @@ void mmc_blk_mq_complete(struct request *req)
 {
 	struct mmc_queue *mq = req->q->queuedata;
 
-	mmc_blk_mq_complete_rq(mq, req);
+	if (mq->use_cqe)
+		mmc_blk_cqe_complete_rq(mq, req);
+	else
+		mmc_blk_mq_complete_rq(mq, req);
 }
 
 static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
@@ -2350,6 +2486,9 @@ static int mmc_blk_mq_issue_rw_rq(struct mmc_queue *mq,
 
 static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host)
 {
+	if (mq->use_cqe)
+		return host->cqe_ops->cqe_wait_for_idle(host);
+
 	return mmc_blk_rw_wait(mq, NULL);
 }
 
@@ -2388,11 +2527,18 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
 			return MMC_REQ_FAILED_TO_START;
 		}
 		return MMC_REQ_FINISHED;
+	case MMC_ISSUE_DCMD:
 	case MMC_ISSUE_ASYNC:
 		switch (req_op(req)) {
+		case REQ_OP_FLUSH:
+			ret = mmc_blk_cqe_issue_flush(mq, req);
+			break;
 		case REQ_OP_READ:
 		case REQ_OP_WRITE:
-			ret = mmc_blk_mq_issue_rw_rq(mq, req);
+			if (mq->use_cqe)
+				ret = mmc_blk_cqe_issue_rw_rq(mq, req);
+			else
+				ret = mmc_blk_mq_issue_rw_rq(mq, req);
 			break;
 		default:
 			WARN_ON_ONCE(1);
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index b145ed81402b..5ad22c1c0318 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -6,6 +6,8 @@
 
 void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
 
+void mmc_blk_cqe_recovery(struct mmc_queue *mq);
+
 enum mmc_issued;
 
 enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index d3b5881615f5..bcba2995c767 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -40,18 +40,119 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 	return BLKPREP_OK;
 }
 
+static inline bool mmc_cqe_dcmd_busy(struct mmc_queue *mq)
+{
+	/* Allow only 1 DCMD at a time */
+	return mq->in_flight[MMC_ISSUE_DCMD];
+}
+
+void mmc_cqe_check_busy(struct mmc_queue *mq)
+{
+	if ((mq->cqe_busy & MMC_CQE_DCMD_BUSY) && !mmc_cqe_dcmd_busy(mq))
+		mq->cqe_busy &= ~MMC_CQE_DCMD_BUSY;
+
+	mq->cqe_busy &= ~MMC_CQE_QUEUE_FULL;
+}
+
+static inline bool mmc_cqe_can_dcmd(struct mmc_host *host)
+{
+	return host->caps2 & MMC_CAP2_CQE_DCMD;
+}
+
+enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
+				       struct request *req)
+{
+	switch (req_op(req)) {
+	case REQ_OP_DRV_IN:
+	case REQ_OP_DRV_OUT:
+	case REQ_OP_DISCARD:
+	case REQ_OP_SECURE_ERASE:
+		return MMC_ISSUE_SYNC;
+	case REQ_OP_FLUSH:
+		return mmc_cqe_can_dcmd(host) ? MMC_ISSUE_DCMD : MMC_ISSUE_SYNC;
+	default:
+		return MMC_ISSUE_ASYNC;
+	}
+}
+
 enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req)
 {
+	struct mmc_host *host = mq->card->host;
+
+	if (mq->use_cqe)
+		return mmc_cqe_issue_type(host, req);
+
 	if (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_WRITE)
 		return MMC_ISSUE_ASYNC;
 
 	return MMC_ISSUE_SYNC;
 }
 
+static void __mmc_cqe_recovery_notifier(struct mmc_queue *mq)
+{
+	if (!mq->recovery_needed) {
+		mq->recovery_needed = true;
+		schedule_work(&mq->recovery_work);
+	}
+}
+
+void mmc_cqe_recovery_notifier(struct mmc_request *mrq)
+{
+	struct mmc_queue_req *mqrq = container_of(mrq, struct mmc_queue_req,
+						  brq.mrq);
+	struct request *req = mmc_queue_req_to_req(mqrq);
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	__mmc_cqe_recovery_notifier(mq);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+}
+
+static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_request *mrq = &mqrq->brq.mrq;
+	struct mmc_queue *mq = req->q->queuedata;
+	struct mmc_host *host = mq->card->host;
+	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
+	bool recovery_needed = false;
+
+	switch (issue_type) {
+	case MMC_ISSUE_ASYNC:
+	case MMC_ISSUE_DCMD:
+		if (host->cqe_ops->cqe_timeout(host, mrq, &recovery_needed)) {
+			if (recovery_needed)
+				__mmc_cqe_recovery_notifier(mq);
+			return BLK_EH_RESET_TIMER;
+		}
+		/* No timeout */
+		return BLK_EH_HANDLED;
+	default:
+		/* Timeout is handled by mmc core */
+		return BLK_EH_RESET_TIMER;
+	}
+}
+
 static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req,
 						 bool reserved)
 {
-	return BLK_EH_RESET_TIMER;
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+
+	if (mq->recovery_needed || !mq->use_cqe)
+		ret = BLK_EH_RESET_TIMER;
+	else
+		ret = mmc_cqe_timed_out(req);
+
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	return ret;
 }
 
 static void mmc_mq_recovery_handler(struct work_struct *work)
@@ -64,7 +165,10 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
 
 	mq->in_recovery = true;
 
-	mmc_blk_mq_recovery(mq);
+	if (mq->use_cqe)
+		mmc_blk_cqe_recovery(mq);
+	else
+		mmc_blk_mq_recovery(mq);
 
 	mq->in_recovery = false;
 
@@ -242,9 +346,10 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request_queue *q = req->q;
 	struct mmc_queue *mq = q->queuedata;
 	struct mmc_card *card = mq->card;
+	struct mmc_host *host = card->host;
 	enum mmc_issue_type issue_type;
 	enum mmc_issued issued;
-	bool get_card;
+	bool get_card, cqe_retune_ok;
 	int ret;
 
 	if (mmc_card_removed(mq->card)) {
@@ -262,6 +367,13 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	switch (issue_type) {
+	case MMC_ISSUE_DCMD:
+		if (mmc_cqe_dcmd_busy(mq)) {
+			mq->cqe_busy |= MMC_CQE_DCMD_BUSY;
+			spin_unlock_irq(q->queue_lock);
+			return BLK_STS_RESOURCE;
+		}
+		break;
 	case MMC_ISSUE_ASYNC:
 		break;
 	default:
@@ -275,6 +387,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	mq->in_flight[issue_type] += 1;
 	get_card = mmc_tot_in_flight(mq) == 1;
+	cqe_retune_ok = mmc_cqe_qcnt(mq) == 1;
 
 	spin_unlock_irq(q->queue_lock);
 
@@ -286,6 +399,11 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (get_card)
 		mmc_get_card(card, &mq->ctx);
 
+	if (mq->use_cqe) {
+		host->retune_now = host->need_retune && cqe_retune_ok &&
+				   !host->hold_retune;
+	}
+
 	blk_mq_start_request(req);
 
 	issued = mmc_blk_mq_issue_rq(mq, req);
@@ -396,10 +514,14 @@ static int mmc_mq_init_queue(struct mmc_queue *mq, int q_depth,
 static int mmc_mq_init(struct mmc_queue *mq, struct mmc_card *card,
 			 spinlock_t *lock)
 {
+	struct mmc_host *host = card->host;
 	int q_depth;
 	int ret;
 
-	q_depth = MMC_QUEUE_DEPTH;
+	if (mq->use_cqe)
+		q_depth = min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
+	else
+		q_depth = MMC_QUEUE_DEPTH;
 
 	ret = mmc_mq_init_queue(mq, q_depth, &mmc_mq_ops, lock);
 	if (ret)
@@ -429,7 +551,9 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 
 	mq->card = card;
 
-	if (mmc_host_use_blk_mq(host))
+	mq->use_cqe = host->cqe_enabled;
+
+	if (mq->use_cqe || mmc_host_use_blk_mq(host))
 		return mmc_mq_init(mq, card, lock);
 
 	mq->queue = blk_alloc_queue(GFP_KERNEL);
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 00b4ce2ce83c..9bbfbb1fad7b 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -16,6 +16,7 @@ enum mmc_issued {
 
 enum mmc_issue_type {
 	MMC_ISSUE_SYNC,
+	MMC_ISSUE_DCMD,
 	MMC_ISSUE_ASYNC,
 	MMC_ISSUE_MAX,
 };
@@ -91,6 +92,10 @@ struct mmc_queue {
 	int			qcnt;
 
 	int			in_flight[MMC_ISSUE_MAX];
+	unsigned int		cqe_busy;
+#define MMC_CQE_DCMD_BUSY	BIT(0)
+#define MMC_CQE_QUEUE_FULL	BIT(1)
+	bool			use_cqe;
 	bool			recovery_needed;
 	bool			in_recovery;
 	bool			rw_wait;
@@ -111,11 +116,21 @@ extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
 extern unsigned int mmc_queue_map_sg(struct mmc_queue *,
 				     struct mmc_queue_req *);
 
+void mmc_cqe_check_busy(struct mmc_queue *mq);
+void mmc_cqe_recovery_notifier(struct mmc_request *mrq);
+
 enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req);
 
 static inline int mmc_tot_in_flight(struct mmc_queue *mq)
 {
 	return mq->in_flight[MMC_ISSUE_SYNC] +
+	       mq->in_flight[MMC_ISSUE_DCMD] +
+	       mq->in_flight[MMC_ISSUE_ASYNC];
+}
+
+static inline int mmc_cqe_qcnt(struct mmc_queue *mq)
+{
+	return mq->in_flight[MMC_ISSUE_DCMD] +
 	       mq->in_flight[MMC_ISSUE_ASYNC];
 }
 
-- 
1.9.1
