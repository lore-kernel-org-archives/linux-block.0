Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35193 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751237AbdHaMEK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 08:04:10 -0400
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
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
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH V7 08/10] mmc: block: Add CQE support
Date: Thu, 31 Aug 2017 14:56:54 +0300
Message-Id: <1504180616-14514-9-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1504180616-14514-1-git-send-email-adrian.hunter@intel.com>
References: <1504180616-14514-1-git-send-email-adrian.hunter@intel.com>
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
 drivers/mmc/core/block.c | 217 +++++++++++++++++++++++++-
 drivers/mmc/core/block.h |   7 +
 drivers/mmc/core/queue.c | 385 ++++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/core/queue.h |  46 +++++-
 4 files changed, 626 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2424c7360687..fd867b6c1f77 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -109,6 +109,7 @@ struct mmc_blk_data {
 #define MMC_BLK_WRITE		BIT(1)
 #define MMC_BLK_DISCARD		BIT(2)
 #define MMC_BLK_SECDISCARD	BIT(3)
+#define MMC_BLK_CQE_RECOVERY	BIT(4)
 
 	/*
 	 * Only set in main mmc_blk_data associated
@@ -1266,7 +1267,10 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
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
@@ -1336,7 +1340,10 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
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
@@ -1346,7 +1353,10 @@ static void mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 	int ret = 0;
 
 	ret = mmc_flush_cache(card);
-	blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
+	if (req->mq_ctx)
+		blk_mq_end_request(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
+	else
+		blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
 }
 
 /*
@@ -1659,6 +1669,205 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 		*do_data_tag_p = do_data_tag;
 }
 
+#define MMC_CQE_RETRIES 2
+
+void mmc_blk_cqe_complete_rq(struct request *req)
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
+void mmc_blk_cqe_recovery(struct mmc_queue *mq)
+{
+	struct mmc_card *card = mq->card;
+	struct mmc_host *host = card->host;
+	int err;
+
+	mmc_get_card(card);
+
+	pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
+
+	mq->cqe_in_recovery = true;
+
+	err = mmc_cqe_recovery(host);
+	if (err)
+		mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
+	else
+		mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
+
+	mq->cqe_in_recovery = false;
+
+	pr_debug("%s: CQE recovery done\n", mmc_hostname(host));
+
+	mmc_put_card(card);
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
+	if (mq->cqe_in_recovery)
+		mmc_blk_cqe_complete_rq(req);
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
+enum mmc_issued mmc_blk_cqe_issue_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_blk_data *md = mq->blkdata;
+	struct mmc_card *card = md->queue.card;
+	struct mmc_host *host = card->host;
+	int ret;
+
+	ret = mmc_blk_part_switch(card, md->part_type);
+	if (ret)
+		return MMC_REQ_FAILED_TO_START;
+
+	switch (mmc_cqe_issue_type(host, req)) {
+	case MMC_ISSUE_SYNC:
+		ret = host->cqe_ops->cqe_wait_for_idle(host);
+		if (ret)
+			return MMC_REQ_BUSY;
+		switch (req_op(req)) {
+		case REQ_OP_DRV_IN:
+		case REQ_OP_DRV_OUT:
+			mmc_blk_issue_drv_op(mq, req);
+			break;
+		case REQ_OP_DISCARD:
+			mmc_blk_issue_discard_rq(mq, req);
+			break;
+		case REQ_OP_SECURE_ERASE:
+			mmc_blk_issue_secdiscard_rq(mq, req);
+			break;
+		case REQ_OP_FLUSH:
+			mmc_blk_issue_flush(mq, req);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			return MMC_REQ_FAILED_TO_START;
+		}
+		return MMC_REQ_FINISHED;
+	case MMC_ISSUE_DCMD:
+	case MMC_ISSUE_ASYNC:
+		switch (req_op(req)) {
+		case REQ_OP_FLUSH:
+			ret = mmc_blk_cqe_issue_flush(mq, req);
+			break;
+		case REQ_OP_READ:
+		case REQ_OP_WRITE:
+			ret = mmc_blk_cqe_issue_rw_rq(mq, req);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			ret = -EINVAL;
+		}
+		if (!ret)
+			return MMC_REQ_STARTED;
+		return ret == -EBUSY ? MMC_REQ_BUSY : MMC_REQ_FAILED_TO_START;
+	default:
+		WARN_ON_ONCE(1);
+		return MMC_REQ_FAILED_TO_START;
+	}
+}
+
 static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			       struct mmc_card *card,
 			       int disable_multi,
@@ -2094,7 +2303,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	INIT_LIST_HEAD(&md->part);
 	md->usage = 1;
 
-	ret = mmc_init_queue(&md->queue, card, &md->lock, subname);
+	ret = mmc_init_queue(&md->queue, card, &md->lock, subname, area_type);
 	if (ret)
 		goto err_putdisk;
 
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 860ca7c8df86..d7b3d7008b00 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -6,4 +6,11 @@
 
 void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
 
+enum mmc_issued;
+
+enum mmc_issued mmc_blk_cqe_issue_rq(struct mmc_queue *mq,
+				     struct request *req);
+void mmc_blk_cqe_complete_rq(struct request *rq);
+void mmc_blk_cqe_recovery(struct mmc_queue *mq);
+
 #endif
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 14e9de9c783c..51233324dc45 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -22,6 +22,7 @@
 #include "block.h"
 #include "core.h"
 #include "card.h"
+#include "host.h"
 
 #define MMC_QUEUE_BOUNCESZ	65536
 
@@ -36,10 +37,132 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 		return BLKPREP_KILL;
 
 	req->rq_flags |= RQF_DONTPREP;
+	req_to_mmc_queue_req(req)->retries = 0;
 
 	return BLKPREP_OK;
 }
 
+static inline bool mmc_cqe_dcmd_busy(struct mmc_queue *mq)
+{
+	/* Allow only 1 DCMD at a time */
+	return mq->cqe_in_flight[MMC_ISSUE_DCMD];
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
+static void __mmc_cqe_recovery_notifier(struct mmc_queue *mq)
+{
+	if (!mq->cqe_recovery_needed) {
+		mq->cqe_recovery_needed = true;
+		schedule_work(&mq->cqe_recovery_work);
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
+static enum blk_eh_timer_return __mmc_cqe_timed_out(struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_request *mrq = &mqrq->brq.mrq;
+	struct mmc_queue *mq = req->q->queuedata;
+	struct mmc_host *host = mq->card->host;
+	enum mmc_issue_type issue_type = mmc_cqe_issue_type(host, req);
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
+static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req,
+						  bool reserved)
+{
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+
+	if (mq->cqe_recovery_needed)
+		ret = BLK_EH_RESET_TIMER;
+	else
+		ret = __mmc_cqe_timed_out(req);
+
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
@@ -176,11 +299,10 @@ static unsigned int mmc_queue_calc_bouncesz(struct mmc_host *host)
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
 
@@ -208,6 +330,12 @@ static int mmc_init_request(struct request_queue *q, struct request *req,
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
@@ -223,6 +351,114 @@ static void mmc_exit_request(struct request_queue *q, struct request *req)
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
+	.complete	= mmc_blk_cqe_complete_rq,
+	.timeout	= mmc_cqe_timed_out,
+};
+
 static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
@@ -251,6 +487,63 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 
 	/* Initialize thread_sem even if it is not used */
 	sema_init(&mq->thread_sem, 1);
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
+static int mmc_cqe_init_queue(struct mmc_queue *mq, struct mmc_card *card,
+			      spinlock_t *lock)
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
+	mmc_setup_queue(mq, card);
+
+	return 0;
 }
 
 /**
@@ -263,12 +556,16 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
  * Initialise a MMC card request queue.
  */
 int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
-		   spinlock_t *lock, const char *subname)
+		   spinlock_t *lock, const char *subname, int area_type)
 {
 	struct mmc_host *host = card->host;
 	int ret = -ENOMEM;
 
 	mq->card = card;
+
+	if (host->cqe_enabled && area_type != MMC_BLK_DATA_AREA_RPMB)
+		return mmc_cqe_init_queue(mq, card, lock);
+
 	mq->queue = blk_alloc_queue(GFP_KERNEL);
 	if (!mq->queue)
 		return -ENOMEM;
@@ -304,11 +601,63 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
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
 
@@ -336,17 +685,11 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 void mmc_queue_suspend(struct mmc_queue *mq)
 {
 	struct request_queue *q = mq->queue;
-	unsigned long flags;
-
-	if (!mq->suspended) {
-		mq->suspended |= true;
 
-		spin_lock_irqsave(q->queue_lock, flags);
-		blk_stop_queue(q);
-		spin_unlock_irqrestore(q->queue_lock, flags);
-
-		down(&mq->thread_sem);
-	}
+	if (q->mq_ops)
+		mmc_mq_queue_suspend(mq);
+	else
+		__mmc_queue_suspend(mq);
 }
 
 /**
@@ -356,17 +699,11 @@ void mmc_queue_suspend(struct mmc_queue *mq)
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
index 04fc89360a7a..eb474fb7ffb2 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -7,6 +7,20 @@
 #include <linux/mmc/core.h>
 #include <linux/mmc/host.h>
 
+enum mmc_issued {
+	MMC_REQ_STARTED,
+	MMC_REQ_BUSY,
+	MMC_REQ_FAILED_TO_START,
+	MMC_REQ_FINISHED,
+};
+
+enum mmc_issue_type {
+	MMC_ISSUE_SYNC,
+	MMC_ISSUE_DCMD,
+	MMC_ISSUE_ASYNC,
+	MMC_ISSUE_MAX,
+};
+
 static inline struct mmc_queue_req *req_to_mmc_queue_req(struct request *rq)
 {
 	return blk_mq_rq_to_pdu(rq);
@@ -57,12 +71,15 @@ struct mmc_queue_req {
 	int			drv_op_result;
 	void			*drv_op_data;
 	unsigned int		ioc_count;
+	int			retries;
 };
 
 struct mmc_queue {
 	struct mmc_card		*card;
 	struct task_struct	*thread;
 	struct semaphore	thread_sem;
+	struct mmc_ctx		ctx;
+	struct blk_mq_tag_set	tag_set;
 	bool			suspended;
 	bool			asleep;
 	struct mmc_blk_data	*blkdata;
@@ -74,10 +91,18 @@ struct mmc_queue {
 	 * associated mmc_queue_req data.
 	 */
 	int			qcnt;
+	/* Following are defined for a Command Queue Engine */
+	int			cqe_in_flight[MMC_ISSUE_MAX];
+	unsigned int		cqe_busy;
+	bool			cqe_recovery_needed;
+	bool			cqe_in_recovery;
+#define MMC_CQE_DCMD_BUSY	BIT(0)
+#define MMC_CQE_QUEUE_FULL	BIT(1)
+	struct work_struct	cqe_recovery_work;
 };
 
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
-			  const char *);
+			  const char *, int);
 extern void mmc_cleanup_queue(struct mmc_queue *);
 extern void mmc_queue_suspend(struct mmc_queue *);
 extern void mmc_queue_resume(struct mmc_queue *);
@@ -89,4 +114,23 @@ extern unsigned int mmc_queue_map_sg(struct mmc_queue *,
 
 extern int mmc_access_rpmb(struct mmc_queue *);
 
+void mmc_cqe_check_busy(struct mmc_queue *mq);
+void mmc_cqe_recovery_notifier(struct mmc_request *mrq);
+
+enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
+				       struct request *req);
+
+static inline int mmc_cqe_tot_in_flight(struct mmc_queue *mq)
+{
+	return mq->cqe_in_flight[MMC_ISSUE_SYNC] +
+	       mq->cqe_in_flight[MMC_ISSUE_DCMD] +
+	       mq->cqe_in_flight[MMC_ISSUE_ASYNC];
+}
+
+static inline int mmc_cqe_qcnt(struct mmc_queue *mq)
+{
+	return mq->cqe_in_flight[MMC_ISSUE_DCMD] +
+	       mq->cqe_in_flight[MMC_ISSUE_ASYNC];
+}
+
 #endif
-- 
1.9.1
