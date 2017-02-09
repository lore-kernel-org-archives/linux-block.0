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
Subject: [PATCH 14/16] mmc: queue: get/put struct mmc_queue_req
Date: Thu,  9 Feb 2017 16:34:01 +0100
Message-Id: <20170209153403.9730-15-linus.walleij@linaro.org>
In-Reply-To: <20170209153403.9730-1-linus.walleij@linaro.org>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The per-hardware-transaction struct mmc_queue_req is assigned
from a pool of 2 requests using a current/previous scheme and
then swapped around.

This is confusing, especially if we need more than two to make
our work efficient and parallel.

Rewrite the mechanism to have a pool of struct mmc_queue_req
and take one when we need one and put it back when we don't
need it anymore.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c |  3 +++
 drivers/mmc/core/core.c  |  4 ++++
 drivers/mmc/core/queue.c | 57 ++++++++++++++++++++++++++++++++++++++----------
 drivers/mmc/core/queue.h |  8 ++++---
 4 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 628a22b9bf41..acca15cc1807 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1797,6 +1797,7 @@ void mmc_blk_issue_rq(struct mmc_queue_req *mq_rq)
 			card->host->areq = NULL;
 		}
 		mmc_blk_issue_discard_rq(mq_rq);
+		mmc_queue_req_put(mq_rq);
 	} else if (req_op(mq_rq->req) == REQ_OP_SECURE_ERASE) {
 		/* complete ongoing async transfer before issuing secure erase*/
 		if (card->host->areq) {
@@ -1804,6 +1805,7 @@ void mmc_blk_issue_rq(struct mmc_queue_req *mq_rq)
 			card->host->areq = NULL;
 		}
 		mmc_blk_issue_secdiscard_rq(mq_rq);
+		mmc_queue_req_put(mq_rq);
 	} else if (req_op(mq_rq->req) == REQ_OP_FLUSH) {
 		/* complete ongoing async transfer before issuing flush */
 		if (card->host->areq) {
@@ -1811,6 +1813,7 @@ void mmc_blk_issue_rq(struct mmc_queue_req *mq_rq)
 			card->host->areq = NULL;
 		}
 		mmc_blk_issue_flush(mq_rq);
+		mmc_queue_req_put(mq_rq);
 	} else {
 		mmc_blk_issue_rw_rq(mq_rq);
 	}
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 03c290e5e2c9..50a8942b98c2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -39,6 +39,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/mmc.h>
 
+#include "queue.h"
 #include "block.h"
 #include "core.h"
 #include "card.h"
@@ -598,6 +599,8 @@ void mmc_finalize_areq(struct kthread_work *work)
 {
 	struct mmc_async_req *areq =
 		container_of(work, struct mmc_async_req, finalization_work);
+	struct mmc_queue_req *mq_rq = container_of(areq, struct mmc_queue_req,
+						   areq);
 	struct mmc_host *host = areq->host;
 	enum mmc_blk_status status = MMC_BLK_SUCCESS;
 	struct mmc_command *cmd;
@@ -636,6 +639,7 @@ void mmc_finalize_areq(struct kthread_work *work)
 	mmc_blk_rw_done(areq, status);
 
 	complete(&areq->complete);
+	mmc_queue_req_put(mq_rq);
 }
 EXPORT_SYMBOL(mmc_finalize_areq);
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index c4e1ced55796..cab0f51dbb4d 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -49,6 +49,42 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 	return BLKPREP_OK;
 }
 
+/**
+ * Get an available queue item from the pool.
+ */
+static struct mmc_queue_req *mmc_queue_req_get(struct mmc_queue *mq)
+{
+	int i;
+
+	/*
+	 * This simply cannot fail so we just spin here
+	 * until we get a queue request to work on.
+	 */
+	while (1) {
+		/* Just take the first unused queue request */
+		spin_lock_irq(&mq->mqrq_lock);
+		for (i = 0; i < mq->qdepth; i++) {
+			if (!mq->mqrq[i].in_use) {
+				mq->mqrq[i].in_use = true;
+				spin_unlock_irq(&mq->mqrq_lock);
+				return &mq->mqrq[i];
+			}
+		}
+		spin_unlock_irq(&mq->mqrq_lock);
+
+		pr_warn_once("%s: out of queue items, spinning\n", __func__);
+	}
+}
+
+void mmc_queue_req_put(struct mmc_queue_req *mq_rq)
+{
+	mq_rq->brq.mrq.data = NULL;
+	mq_rq->req = NULL;
+	spin_lock_irq(&mq_rq->mq->mqrq_lock);
+	mq_rq->in_use = false;
+	spin_unlock_irq(&mq_rq->mq->mqrq_lock);
+}
+
 static int mmc_queue_thread(void *d)
 {
 	struct mmc_queue *mq = d;
@@ -62,17 +98,17 @@ static int mmc_queue_thread(void *d)
 	do {
 		struct request *req = NULL;
 
-		spin_lock_irq(q->queue_lock);
 		set_current_state(TASK_INTERRUPTIBLE);
+		spin_lock_irq(q->queue_lock);
 		req = blk_fetch_request(q);
-		mq->asleep = false;
-		mq_rq = mq->mqrq_cur;
-		mq_rq->req = req;
 		spin_unlock_irq(q->queue_lock);
+		mq->asleep = false;
 
 		if (req) {
 			bool req_is_special = mmc_req_is_special(req);
 
+			mq_rq = mmc_queue_req_get(mq);
+			mq_rq->req = req;
 			if (!claimed_host)
 				mmc_get_card(mq->card);
 			set_current_state(TASK_RUNNING);
@@ -87,13 +123,9 @@ static int mmc_queue_thread(void *d)
 			 * commands.
 			 */
 			if (req_is_special) {
-				mq->mqrq_cur->req = NULL;
 				mmc_put_card(mq->card);
 				claimed_host = false;
 			}
-			mq->mqrq_prev->brq.mrq.data = NULL;
-			mq->mqrq_prev->req = NULL;
-			swap(mq->mqrq_prev, mq->mqrq_cur);
 		} else {
 			mq->asleep = true;
 			if (kthread_should_stop()) {
@@ -265,6 +297,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	u64 limit = BLK_BOUNCE_HIGH;
 	bool bounce = false;
 	int ret = -ENOMEM;
+	int i;
 
 	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
 		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
@@ -275,14 +308,14 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		return -ENOMEM;
 
 	mq->qdepth = 2;
+	spin_lock_init(&mq->mqrq_lock);
 	mq->mqrq = kcalloc(mq->qdepth, sizeof(struct mmc_queue_req),
 			   GFP_KERNEL);
 	if (!mq->mqrq)
 		goto blk_cleanup;
-	mq->mqrq_cur = &mq->mqrq[0];
-	mq->mqrq_cur->mq = mq;
-	mq->mqrq_prev = &mq->mqrq[1];
-	mq->mqrq_prev->mq = mq;
+	for (i = 0; i < mq->qdepth; i++)
+		mq->mqrq[i].mq = mq;
+
 	mq->queue->queuedata = mq;
 
 	blk_queue_prep_rq(mq->queue, mmc_prep_request);
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index c18d3f908433..886a05482b74 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -2,6 +2,7 @@
 #define MMC_QUEUE_H
 
 #include <linux/types.h>
+#include <linux/spinlock.h>
 #include <linux/blkdev.h>
 #include <linux/mmc/core.h>
 #include <linux/mmc/host.h>
@@ -27,6 +28,7 @@ struct mmc_blk_request {
 };
 
 struct mmc_queue_req {
+	bool			in_use;
 	struct request		*req;
 	struct mmc_blk_request	brq;
 	struct scatterlist	*sg;
@@ -45,12 +47,12 @@ struct mmc_queue {
 	bool			asleep;
 	struct mmc_blk_data	*blkdata;
 	struct request_queue	*queue;
+	spinlock_t		mqrq_lock;
 	struct mmc_queue_req	*mqrq;
-	struct mmc_queue_req	*mqrq_cur;
-	struct mmc_queue_req	*mqrq_prev;
-	int			qdepth;
+	unsigned int		qdepth;
 };
 
+extern void mmc_queue_req_put(struct mmc_queue_req *mq_rq);
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
 			  const char *);
 extern void mmc_cleanup_queue(struct mmc_queue *);
-- 
2.9.3
