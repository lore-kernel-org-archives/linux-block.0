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
Subject: [PATCH 03/12 v4] mmc: core: replace waitqueue with worker
Date: Thu, 26 Oct 2017 14:57:48 +0200
Message-Id: <20171026125757.10200-4-linus.walleij@linaro.org>
In-Reply-To: <20171026125757.10200-1-linus.walleij@linaro.org>
References: <20171026125757.10200-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The waitqueue in the host context is there to signal back from
mmc_request_done() through mmc_wait_data_done() that the hardware
is done with a command, and when the wait is over, the core
will typically submit the next asynchronous request that is pending
just waiting for the hardware to be available.

This is in the way for letting the mmc_request_done() trigger the
report up to the block layer that a block request is finished.

Re-jig this as a first step, remvoving the waitqueue and introducing
a work that will run after a completed asynchronous request,
finalizing that request, including retransmissions, and eventually
reporting back with a completion and a status code to the
asynchronous issue method.

This has the upside that we can remove the MMC_BLK_NEW_REQUEST
status code and the "new_request" state in the request queue
that is only there to make the state machine spin out
the first time we send a request.

Use the workqueue we introduced in the host for handling just
this, and then add a work and completion in the asynchronous
request to deal with this mechanism.

We introduce a pointer from mmc_request back to the asynchronous
request so these can be referenced from each other, and
augment mmc_wait_data_done() to use this pointer to get at the
areq and kick the worker since that function is only used by
asynchronous requests anyway.

This is a central change that let us do many other changes since
we have broken the submit and complete code paths in two, and we
can potentially remove the NULL flushing of the asynchronous
pipeline and report block requests as finished directly from
the worker.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c |  3 ++
 drivers/mmc/core/core.c  | 93 ++++++++++++++++++++++++------------------------
 drivers/mmc/core/core.h  |  2 ++
 drivers/mmc/core/queue.c |  1 -
 include/linux/mmc/core.h |  3 +-
 include/linux/mmc/host.h |  7 ++--
 6 files changed, 59 insertions(+), 50 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ea80ff4cd7f9..5c84175e49be 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1712,6 +1712,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	mmc_blk_data_prep(mq, mqrq, disable_multi, &do_rel_wr, &do_data_tag);
 
 	brq->mrq.cmd = &brq->cmd;
+	brq->mrq.areq = NULL;
 
 	brq->cmd.arg = blk_rq_pos(req);
 	if (!mmc_card_blockaddr(card))
@@ -1764,6 +1765,8 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	}
 
 	mqrq->areq.err_check = mmc_blk_err_check;
+	mqrq->areq.host = card->host;
+	INIT_WORK(&mqrq->areq.finalization_work, mmc_finalize_areq);
 }
 
 static bool mmc_blk_rw_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 9c3baaddb1bd..f6a51608ab0b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -369,10 +369,15 @@ EXPORT_SYMBOL(mmc_start_request);
  */
 static void mmc_wait_data_done(struct mmc_request *mrq)
 {
-	struct mmc_context_info *context_info = &mrq->host->context_info;
+	struct mmc_host *host = mrq->host;
+	struct mmc_context_info *context_info = &host->context_info;
+	struct mmc_async_req *areq = mrq->areq;
 
 	context_info->is_done_rcv = true;
-	wake_up_interruptible(&context_info->wait);
+	/* Schedule a work to deal with finalizing this request */
+	if (!areq)
+		pr_err("areq of the data mmc_request was NULL!\n");
+	queue_work(host->req_done_wq, &areq->finalization_work);
 }
 
 static void mmc_wait_done(struct mmc_request *mrq)
@@ -695,43 +700,34 @@ static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
  * Returns the status of the ongoing asynchronous request, but
  * MMC_BLK_SUCCESS if no request was going on.
  */
-static enum mmc_blk_status mmc_finalize_areq(struct mmc_host *host)
+void mmc_finalize_areq(struct work_struct *work)
 {
+	struct mmc_async_req *areq =
+		container_of(work, struct mmc_async_req, finalization_work);
+	struct mmc_host *host = areq->host;
 	struct mmc_context_info *context_info = &host->context_info;
-	enum mmc_blk_status status;
-
-	if (!host->areq)
-		return MMC_BLK_SUCCESS;
-
-	while (1) {
-		wait_event_interruptible(context_info->wait,
-				(context_info->is_done_rcv ||
-				 context_info->is_new_req));
+	enum mmc_blk_status status = MMC_BLK_SUCCESS;
 
-		if (context_info->is_done_rcv) {
-			struct mmc_command *cmd;
+	if (context_info->is_done_rcv) {
+		struct mmc_command *cmd;
 
-			context_info->is_done_rcv = false;
-			cmd = host->areq->mrq->cmd;
+		context_info->is_done_rcv = false;
+		cmd = areq->mrq->cmd;
 
-			if (!cmd->error || !cmd->retries ||
-			    mmc_card_removed(host->card)) {
-				status = host->areq->err_check(host->card,
-							       host->areq);
-				break; /* return status */
-			} else {
-				mmc_retune_recheck(host);
-				pr_info("%s: req failed (CMD%u): %d, retrying...\n",
-					mmc_hostname(host),
-					cmd->opcode, cmd->error);
-				cmd->retries--;
-				cmd->error = 0;
-				__mmc_start_request(host, host->areq->mrq);
-				continue; /* wait for done/new event again */
-			}
+		if (!cmd->error || !cmd->retries ||
+		    mmc_card_removed(host->card)) {
+			status = areq->err_check(host->card,
+						 areq);
+		} else {
+			mmc_retune_recheck(host);
+			pr_info("%s: req failed (CMD%u): %d, retrying...\n",
+				mmc_hostname(host),
+				cmd->opcode, cmd->error);
+			cmd->retries--;
+			cmd->error = 0;
+			__mmc_start_request(host, areq->mrq);
+			return; /* wait for done/new event again */
 		}
-
-		return MMC_BLK_NEW_REQUEST;
 	}
 
 	mmc_retune_release(host);
@@ -740,17 +736,19 @@ static enum mmc_blk_status mmc_finalize_areq(struct mmc_host *host)
 	 * Check BKOPS urgency for each R1 response
 	 */
 	if (host->card && mmc_card_mmc(host->card) &&
-	    ((mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1) ||
-	     (mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1B)) &&
-	    (host->areq->mrq->cmd->resp[0] & R1_EXCEPTION_EVENT)) {
+	    ((mmc_resp_type(areq->mrq->cmd) == MMC_RSP_R1) ||
+	     (mmc_resp_type(areq->mrq->cmd) == MMC_RSP_R1B)) &&
+	    (areq->mrq->cmd->resp[0] & R1_EXCEPTION_EVENT)) {
 		mmc_start_bkops(host->card, true);
 	}
 
 	/* Successfully postprocess the old request at this point */
-	mmc_post_req(host, host->areq->mrq, 0);
+	mmc_post_req(host, areq->mrq, 0);
 
-	return status;
+	areq->finalization_status = status;
+	complete(&areq->complete);
 }
+EXPORT_SYMBOL(mmc_finalize_areq);
 
 /**
  *	mmc_start_areq - start an asynchronous request
@@ -780,18 +778,22 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 	if (areq)
 		mmc_pre_req(host, areq->mrq);
 
-	/* Finalize previous request */
-	status = mmc_finalize_areq(host);
+	/* Finalize previous request, if there is one */
+	if (previous) {
+		wait_for_completion(&previous->complete);
+		status = previous->finalization_status;
+	} else {
+		status = MMC_BLK_SUCCESS;
+	}
 	if (ret_stat)
 		*ret_stat = status;
 
-	/* The previous request is still going on... */
-	if (status == MMC_BLK_NEW_REQUEST)
-		return NULL;
-
 	/* Fine so far, start the new request! */
-	if (status == MMC_BLK_SUCCESS && areq)
+	if (status == MMC_BLK_SUCCESS && areq) {
+		init_completion(&areq->complete);
+		areq->mrq->areq = areq;
 		start_err = __mmc_start_data_req(host, areq->mrq);
+	}
 
 	/* Cancel a prepared request if it was not started. */
 	if ((status != MMC_BLK_SUCCESS || start_err) && areq)
@@ -3005,7 +3007,6 @@ void mmc_init_context_info(struct mmc_host *host)
 	host->context_info.is_new_req = false;
 	host->context_info.is_done_rcv = false;
 	host->context_info.is_waiting_last_req = false;
-	init_waitqueue_head(&host->context_info.wait);
 }
 
 static int __init mmc_init(void)
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 71e6c6d7ceb7..e493d9d73fe2 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -13,6 +13,7 @@
 
 #include <linux/delay.h>
 #include <linux/sched.h>
+#include <linux/workqueue.h>
 
 struct mmc_host;
 struct mmc_card;
@@ -112,6 +113,7 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq);
 
 struct mmc_async_req;
 
+void mmc_finalize_areq(struct work_struct *work);
 struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 				     struct mmc_async_req *areq,
 				     enum mmc_blk_status *ret_stat);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 4f33d277b125..c46be4402803 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -111,7 +111,6 @@ static void mmc_request_fn(struct request_queue *q)
 
 	if (cntx->is_waiting_last_req) {
 		cntx->is_new_req = true;
-		wake_up_interruptible(&cntx->wait);
 	}
 
 	if (mq->asleep)
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 927519385482..d755ef8ea880 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -13,6 +13,7 @@
 
 struct mmc_data;
 struct mmc_request;
+struct mmc_async_req;
 
 enum mmc_blk_status {
 	MMC_BLK_SUCCESS = 0,
@@ -23,7 +24,6 @@ enum mmc_blk_status {
 	MMC_BLK_DATA_ERR,
 	MMC_BLK_ECC_ERR,
 	MMC_BLK_NOMEDIUM,
-	MMC_BLK_NEW_REQUEST,
 };
 
 struct mmc_command {
@@ -155,6 +155,7 @@ struct mmc_request {
 
 	struct completion	completion;
 	struct completion	cmd_completion;
+	struct mmc_async_req	*areq; /* pointer to areq if any */
 	void			(*done)(struct mmc_request *);/* completion function */
 	/*
 	 * Notify uppers layers (e.g. mmc block driver) that recovery is needed
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 94a646eebf05..65f23a9ea724 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/fault-inject.h>
 #include <linux/workqueue.h>
+#include <linux/completion.h>
 
 #include <linux/mmc/core.h>
 #include <linux/mmc/card.h>
@@ -215,6 +216,10 @@ struct mmc_async_req {
 	 * Returns 0 if success otherwise non zero.
 	 */
 	enum mmc_blk_status (*err_check)(struct mmc_card *, struct mmc_async_req *);
+	struct work_struct finalization_work;
+	enum mmc_blk_status finalization_status;
+	struct completion complete;
+	struct mmc_host *host;
 };
 
 /**
@@ -239,13 +244,11 @@ struct mmc_slot {
  * @is_done_rcv		wake up reason was done request
  * @is_new_req		wake up reason was new request
  * @is_waiting_last_req	mmc context waiting for single running request
- * @wait		wait queue
  */
 struct mmc_context_info {
 	bool			is_done_rcv;
 	bool			is_new_req;
 	bool			is_waiting_last_req;
-	wait_queue_head_t	wait;
 };
 
 struct regulator;
-- 
2.13.6
