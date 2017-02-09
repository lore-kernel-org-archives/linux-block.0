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
Subject: [PATCH 06/16] mmc: core: replace waitqueue with worker
Date: Thu,  9 Feb 2017 16:33:53 +0100
Message-Id: <20170209153403.9730-7-linus.walleij@linaro.org>
In-Reply-To: <20170209153403.9730-1-linus.walleij@linaro.org>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
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

This had the upside that we can remove the MMC_BLK_NEW_REQUEST
status code and the "new_request" state in the request queue
that is only there to make the state machine spin out
the first time we send a request.

Introduce a workqueue in the host for handling just this, and
then a work and completion in the asynchronous request to deal
with this mechanism.

This is a central change that let us do many other changes since
we have broken the submit and complete code paths in two, and we
can potentially remove the NULL flushing of the asynchronous
pipeline and report block requests as finished directly from
the worker.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c |  7 ++--
 drivers/mmc/core/core.c  | 84 +++++++++++++++++++++++-------------------------
 drivers/mmc/core/queue.c |  6 ----
 drivers/mmc/core/queue.h |  1 -
 include/linux/mmc/core.h |  3 +-
 include/linux/mmc/host.h |  7 ++--
 6 files changed, 51 insertions(+), 57 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index c49c90dba839..c459d80c66bf 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1562,6 +1562,8 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 
 	mqrq->areq.mrq = &brq->mrq;
 	mqrq->areq.err_check = mmc_blk_err_check;
+	mqrq->areq.host = card->host;
+	kthread_init_work(&mqrq->areq.finalization_work, mmc_finalize_areq);
 
 	mmc_queue_bounce_pre(mqrq);
 }
@@ -1672,8 +1674,6 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			 * and there is nothing more to do until it is
 			 * complete.
 			 */
-			if (status == MMC_BLK_NEW_REQUEST)
-				mq->new_request = true;
 			return;
 		}
 
@@ -1811,7 +1811,6 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		goto out;
 	}
 
-	mq->new_request = false;
 	if (req && req_op(req) == REQ_OP_DISCARD) {
 		/* complete ongoing async transfer before issuing discard */
 		if (card->host->areq)
@@ -1832,7 +1831,7 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	}
 
 out:
-	if ((!req && !mq->new_request) || req_is_special)
+	if (!req || req_is_special)
 		/*
 		 * Release host when there are no more requests
 		 * and after special request(discard, flush) is done.
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 663799240635..8ecf61e51662 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -415,10 +415,13 @@ EXPORT_SYMBOL(mmc_start_bkops);
  */
 static void mmc_wait_data_done(struct mmc_request *mrq)
 {
-	struct mmc_context_info *context_info = &mrq->host->context_info;
+	struct mmc_host *host = mrq->host;
+	struct mmc_context_info *context_info = &host->context_info;
+	struct mmc_async_req *areq = host->areq;
 
 	context_info->is_done_rcv = true;
-	wake_up_interruptible(&context_info->wait);
+	/* Schedule a work to deal with finalizing this request */
+	kthread_queue_work(&host->req_done_worker, &areq->finalization_work);
 }
 
 static void mmc_wait_done(struct mmc_request *mrq)
@@ -592,43 +595,34 @@ static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
  *	will return MMC_BLK_SUCCESS if no request was
  *	going on.
  */
-static enum mmc_blk_status mmc_finalize_areq(struct mmc_host *host)
+void mmc_finalize_areq(struct kthread_work *work)
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
@@ -644,10 +638,12 @@ static enum mmc_blk_status mmc_finalize_areq(struct mmc_host *host)
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
@@ -677,18 +673,21 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
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
 		start_err = __mmc_start_data_req(host, areq->mrq);
+	}
 
 	/* Cancel a prepared request if it was not started. */
 	if ((status != MMC_BLK_SUCCESS || start_err) && areq)
@@ -2996,7 +2995,6 @@ void mmc_init_context_info(struct mmc_host *host)
 	host->context_info.is_new_req = false;
 	host->context_info.is_done_rcv = false;
 	host->context_info.is_waiting_last_req = false;
-	init_waitqueue_head(&host->context_info.wait);
 }
 
 static int __init mmc_init(void)
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 5cb369c2664b..73250ed8f093 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -86,11 +86,6 @@ static int mmc_queue_thread(void *d)
 			set_current_state(TASK_RUNNING);
 			mmc_blk_issue_rq(mq, req);
 			cond_resched();
-			if (mq->new_request) {
-				mq->new_request = false;
-				continue; /* fetch again */
-			}
-
 			/*
 			 * Current request becomes previous request
 			 * and vice versa.
@@ -143,7 +138,6 @@ static void mmc_request_fn(struct request_queue *q)
 
 	if (cntx->is_waiting_last_req) {
 		cntx->is_new_req = true;
-		wake_up_interruptible(&cntx->wait);
 	}
 
 	if (mq->asleep)
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index e298f100101b..39d8e710287e 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -40,7 +40,6 @@ struct mmc_queue {
 	struct mmc_card		*card;
 	struct task_struct	*thread;
 	struct semaphore	thread_sem;
-	bool			new_request;
 	bool			suspended;
 	bool			asleep;
 	struct mmc_blk_data	*blkdata;
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index a0c63ea28796..5db0fb722c37 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -9,6 +9,7 @@
 #define LINUX_MMC_CORE_H
 
 #include <linux/completion.h>
+#include <linux/kthread.h>
 #include <linux/types.h>
 
 struct mmc_data;
@@ -23,7 +24,6 @@ enum mmc_blk_status {
 	MMC_BLK_DATA_ERR,
 	MMC_BLK_ECC_ERR,
 	MMC_BLK_NOMEDIUM,
-	MMC_BLK_NEW_REQUEST,
 };
 
 struct mmc_command {
@@ -158,6 +158,7 @@ struct mmc_request {
 struct mmc_card;
 struct mmc_async_req;
 
+void mmc_finalize_areq(struct kthread_work *work);
 struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 				struct mmc_async_req *areq,
 				enum mmc_blk_status *ret_stat);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index b04f8cd51c82..c5f61f2f2310 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/fault-inject.h>
 #include <linux/kthread.h>
+#include <linux/completion.h>
 
 #include <linux/mmc/core.h>
 #include <linux/mmc/card.h>
@@ -169,6 +170,10 @@ struct mmc_async_req {
 	 * Returns 0 if success otherwise non zero.
 	 */
 	enum mmc_blk_status (*err_check)(struct mmc_card *, struct mmc_async_req *);
+	struct kthread_work finalization_work;
+	enum mmc_blk_status finalization_status;
+	struct completion complete;
+	struct mmc_host *host;
 };
 
 /**
@@ -192,13 +197,11 @@ struct mmc_slot {
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
2.9.3
