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
Subject: [PATCH 06/12 v5] mmc: core: kill off the context info
Date: Fri, 10 Nov 2017 11:01:37 +0100
Message-Id: <20171110100143.12256-7-linus.walleij@linaro.org>
In-Reply-To: <20171110100143.12256-1-linus.walleij@linaro.org>
References: <20171110100143.12256-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The last member of the context info: is_waiting_last_req is
just assigned values, never checked. Delete that and the whole
context info as a result.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v5:
- Rebasing on the "next" branch in the MMC tree.
---
 drivers/mmc/core/block.c |  2 --
 drivers/mmc/core/bus.c   |  1 -
 drivers/mmc/core/core.c  | 13 -------------
 drivers/mmc/core/core.h  |  2 --
 drivers/mmc/core/queue.c |  9 +--------
 include/linux/mmc/host.h |  9 ---------
 6 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 5c84175e49be..86ec87c17e71 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2065,13 +2065,11 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		default:
 			/* Normal request, just issue it */
 			mmc_blk_issue_rw_rq(mq, req);
-			card->host->context_info.is_waiting_last_req = false;
 			break;
 		}
 	} else {
 		/* No request, flushing the pipeline with NULL */
 		mmc_blk_issue_rw_rq(mq, NULL);
-		card->host->context_info.is_waiting_last_req = false;
 	}
 
 out:
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index a4b49e25fe96..45904a7e87be 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -348,7 +348,6 @@ int mmc_add_card(struct mmc_card *card)
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_card_debugfs(card);
 #endif
-	mmc_init_context_info(card->host);
 
 	card->dev.of_node = mmc_of_find_child_device(card->host, 0);
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b1a5059f6cd1..fa86f9a15d29 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2997,19 +2997,6 @@ void mmc_unregister_pm_notifier(struct mmc_host *host)
 }
 #endif
 
-/**
- * mmc_init_context_info() - init synchronization context
- * @host: mmc host
- *
- * Init struct context_info needed to implement asynchronous
- * request mechanism, used by mmc core, host driver and mmc requests
- * supplier.
- */
-void mmc_init_context_info(struct mmc_host *host)
-{
-	host->context_info.is_waiting_last_req = false;
-}
-
 static int __init mmc_init(void)
 {
 	int ret;
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index e493d9d73fe2..88b852ac8f74 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -92,8 +92,6 @@ void mmc_remove_host_debugfs(struct mmc_host *host);
 void mmc_add_card_debugfs(struct mmc_card *card);
 void mmc_remove_card_debugfs(struct mmc_card *card);
 
-void mmc_init_context_info(struct mmc_host *host);
-
 int mmc_execute_tuning(struct mmc_card *card);
 int mmc_hs200_to_hs400(struct mmc_card *card);
 int mmc_hs400_to_hs200(struct mmc_card *card);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 4a0752ef6154..2c232ba4e594 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -42,7 +42,6 @@ static int mmc_queue_thread(void *d)
 {
 	struct mmc_queue *mq = d;
 	struct request_queue *q = mq->queue;
-	struct mmc_context_info *cntx = &mq->card->host->context_info;
 
 	current->flags |= PF_MEMALLOC;
 
@@ -54,15 +53,12 @@ static int mmc_queue_thread(void *d)
 		set_current_state(TASK_INTERRUPTIBLE);
 		req = blk_fetch_request(q);
 		mq->asleep = false;
-		cntx->is_waiting_last_req = false;
 		if (!req) {
 			/*
 			 * Dispatch queue is empty so set flags for
 			 * mmc_request_fn() to wake us up.
 			 */
-			if (mq->qcnt)
-				cntx->is_waiting_last_req = true;
-			else
+			if (!mq->qcnt)
 				mq->asleep = true;
 		}
 		spin_unlock_irq(q->queue_lock);
@@ -96,7 +92,6 @@ static void mmc_request_fn(struct request_queue *q)
 {
 	struct mmc_queue *mq = q->queuedata;
 	struct request *req;
-	struct mmc_context_info *cntx;
 
 	if (!mq) {
 		while ((req = blk_fetch_request(q)) != NULL) {
@@ -106,8 +101,6 @@ static void mmc_request_fn(struct request_queue *q)
 		return;
 	}
 
-	cntx = &mq->card->host->context_info;
-
 	if (mq->asleep)
 		wake_up_process(mq->thread);
 }
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 36af19990683..4b210e9283f6 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -239,14 +239,6 @@ struct mmc_slot {
 	void *handler_priv;
 };
 
-/**
- * mmc_context_info - synchronization details for mmc context
- * @is_waiting_last_req	mmc context waiting for single running request
- */
-struct mmc_context_info {
-	bool			is_waiting_last_req;
-};
-
 struct regulator;
 struct mmc_pwrseq;
 
@@ -423,7 +415,6 @@ struct mmc_host {
 	struct dentry		*debugfs_root;
 
 	struct mmc_async_req	*areq;		/* active async req */
-	struct mmc_context_info	context_info;	/* async synchronization info */
 
 	/* finalization workqueue, handles finalizing requests */
 	struct workqueue_struct	*req_done_wq;
-- 
2.13.6
