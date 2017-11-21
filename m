Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65339 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752454AbdKUNoj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Nov 2017 08:44:39 -0500
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V14 17/24] mmc: block: blk-mq: Add support for direct completion
Date: Tue, 21 Nov 2017 15:42:43 +0200
Message-Id: <1511271770-3444-18-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For blk-mq, add support for completing requests directly in the ->done
callback. That means that error handling and urgent background operations
must be handled by recovery_work in that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 102 +++++++++++++++++++++++++++++++++++++++++------
 drivers/mmc/core/block.h |   1 +
 drivers/mmc/core/queue.c |   5 ++-
 drivers/mmc/core/queue.h |   6 +++
 include/linux/mmc/host.h |   1 +
 5 files changed, 101 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2aacd3fa0d1a..b1857eee46fd 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2154,6 +2154,22 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
 	}
 }
 
+static inline bool mmc_blk_rq_error(struct mmc_blk_request *brq)
+{
+	mmc_blk_eval_resp_error(brq);
+
+	return brq->sbc.error || brq->cmd.error || brq->stop.error ||
+	       brq->data.error || brq->cmd.resp[0] & CMD_ERRORS;
+}
+
+static inline void mmc_blk_rw_reset_success(struct mmc_queue *mq,
+					    struct request *req)
+{
+	int type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
+
+	mmc_blk_reset_success(mq->blkdata, type);
+}
+
 static void mmc_blk_mq_complete_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
@@ -2234,14 +2250,43 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
 
 	mmc_post_req(host, mrq, 0);
 
-	blk_mq_complete_request(req);
+	/*
+	 * Block layer timeouts race with completions which means the normal
+	 * completion path cannot be used during recovery.
+	 */
+	if (mq->in_recovery)
+		mmc_blk_mq_complete_rq(mq, req);
+	else
+		blk_mq_complete_request(req);
 
 	mmc_blk_mq_acct_req_done(mq, req);
 }
 
+void mmc_blk_mq_recovery(struct mmc_queue *mq)
+{
+	struct request *req = mq->recovery_req;
+	struct mmc_host *host = mq->card->host;
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+
+	mq->recovery_req = NULL;
+	mq->rw_wait = false;
+
+	if (mmc_blk_rq_error(&mqrq->brq)) {
+		mmc_retune_hold_now(host);
+		mmc_blk_mq_rw_recovery(mq, req);
+	}
+
+	mmc_blk_urgent_bkops(mq, mqrq);
+
+	mmc_blk_mq_post_req(mq, req);
+}
+
 static void mmc_blk_mq_complete_prev_req(struct mmc_queue *mq,
 					 struct request **prev_req)
 {
+	if (mmc_queue_direct_complete(mq->card->host))
+		return;
+
 	mutex_lock(&mq->complete_lock);
 
 	if (!mq->complete_req)
@@ -2275,19 +2320,43 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
 	struct request *req = mmc_queue_req_to_req(mqrq);
 	struct request_queue *q = req->q;
 	struct mmc_queue *mq = q->queuedata;
+	struct mmc_host *host = mq->card->host;
 	unsigned long flags;
-	bool waiting;
 
-	spin_lock_irqsave(q->queue_lock, flags);
-	mq->complete_req = req;
-	mq->rw_wait = false;
-	waiting = mq->waiting;
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	if (!mmc_queue_direct_complete(host)) {
+		bool waiting;
+
+		spin_lock_irqsave(q->queue_lock, flags);
+		mq->complete_req = req;
+		mq->rw_wait = false;
+		waiting = mq->waiting;
+		spin_unlock_irqrestore(q->queue_lock, flags);
+
+		if (waiting)
+			wake_up(&mq->wait);
+		else
+			kblockd_schedule_work(&mq->complete_work);
+
+		return;
+	}
 
-	if (waiting)
+	if (mmc_blk_rq_error(&mqrq->brq) ||
+	    mmc_blk_urgent_bkops_needed(mq, mqrq)) {
+		spin_lock_irqsave(q->queue_lock, flags);
+		mq->recovery_needed = true;
+		mq->recovery_req = req;
+		spin_unlock_irqrestore(q->queue_lock, flags);
 		wake_up(&mq->wait);
-	else
-		kblockd_schedule_work(&mq->complete_work);
+		schedule_work(&mq->recovery_work);
+		return;
+	}
+
+	mmc_blk_rw_reset_success(mq, req);
+
+	mq->rw_wait = false;
+	wake_up(&mq->wait);
+
+	mmc_blk_mq_post_req(mq, req);
 }
 
 static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
@@ -2297,7 +2366,12 @@ static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
 	bool done;
 
 	spin_lock_irqsave(q->queue_lock, flags);
-	done = !mq->rw_wait;
+	if (mq->recovery_needed) {
+		*err = -EBUSY;
+		done = true;
+	} else {
+		done = !mq->rw_wait;
+	}
 	mq->waiting = !done;
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
@@ -2340,10 +2414,12 @@ static int mmc_blk_mq_issue_rw_rq(struct mmc_queue *mq,
 	if (prev_req)
 		mmc_blk_mq_post_req(mq, prev_req);
 
-	if (err) {
+	if (err)
 		mq->rw_wait = false;
+
+	/* Release re-tuning here where there is no synchronization required */
+	if (err || mmc_queue_direct_complete(host))
 		mmc_retune_release(host);
-	}
 
 out_post_req:
 	if (err)
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index f472ce5d5647..b126418fd163 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -13,6 +13,7 @@
 
 enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req);
 void mmc_blk_mq_complete(struct request *req);
+void mmc_blk_mq_recovery(struct mmc_queue *mq);
 
 struct work_struct;
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index d0eae15261d7..148a13d9adf0 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -165,7 +165,10 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
 
 	mq->in_recovery = true;
 
-	mmc_blk_cqe_recovery(mq);
+	if (mq->use_cqe)
+		mmc_blk_cqe_recovery(mq);
+	else
+		mmc_blk_mq_recovery(mq);
 
 	mq->in_recovery = false;
 
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 1d7d3b0afff8..c4271fa54f1a 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -103,6 +103,7 @@ struct mmc_queue {
 	bool			waiting;
 	struct work_struct	recovery_work;
 	wait_queue_head_t	wait;
+	struct request		*recovery_req;
 	struct request		*complete_req;
 	struct mutex		complete_lock;
 	struct work_struct	complete_work;
@@ -134,4 +135,9 @@ static inline int mmc_cqe_qcnt(struct mmc_queue *mq)
 	       mq->in_flight[MMC_ISSUE_ASYNC];
 }
 
+static inline bool mmc_queue_direct_complete(struct mmc_host *host)
+{
+	return host->caps & MMC_CAP_DIRECT_COMPLETE;
+}
+
 #endif
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ce2075d6f429..4b68a95a8818 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -324,6 +324,7 @@ struct mmc_host {
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
+#define MMC_CAP_DIRECT_COMPLETE	(1 << 27)	/* RW reqs can be completed within mmc_request_done() */
 #define MMC_CAP_CD_WAKE		(1 << 28)	/* Enable card detect wake */
 #define MMC_CAP_CMD_DURING_TFR	(1 << 29)	/* Commands during data transfer */
 #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
-- 
1.9.1
