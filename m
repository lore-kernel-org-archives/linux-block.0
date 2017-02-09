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
Subject: [PATCH 09/16] mmc: core: kill off the context info
Date: Thu,  9 Feb 2017 16:33:56 +0100
Message-Id: <20170209153403.9730-10-linus.walleij@linaro.org>
In-Reply-To: <20170209153403.9730-1-linus.walleij@linaro.org>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The last member of the context info: is_waiting_last_req is
just assigned values, never checked. Delete that and the whole
context info as a result.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/bus.c   |  1 -
 drivers/mmc/core/core.c  | 13 -------------
 drivers/mmc/core/core.h  |  2 --
 drivers/mmc/core/queue.c |  9 +--------
 include/linux/mmc/host.h |  9 ---------
 5 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 301246513a37..22ed11ac961b 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -348,7 +348,6 @@ int mmc_add_card(struct mmc_card *card)
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_card_debugfs(card);
 #endif
-	mmc_init_context_info(card->host);
 
 	card->dev.of_node = mmc_of_find_child_device(card->host, 0);
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 933a4d1f20d5..4b84f18518ac 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2975,19 +2975,6 @@ void mmc_unregister_pm_notifier(struct mmc_host *host)
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
index 8a95c82554be..620bea373c3a 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -90,8 +90,6 @@ void mmc_remove_host_debugfs(struct mmc_host *host);
 void mmc_add_card_debugfs(struct mmc_card *card);
 void mmc_remove_card_debugfs(struct mmc_card *card);
 
-void mmc_init_context_info(struct mmc_host *host);
-
 int mmc_execute_tuning(struct mmc_card *card);
 int mmc_hs200_to_hs400(struct mmc_card *card);
 int mmc_hs400_to_hs200(struct mmc_card *card);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 63927ffd6825..a845fe8d4fd1 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -53,7 +53,6 @@ static int mmc_queue_thread(void *d)
 {
 	struct mmc_queue *mq = d;
 	struct request_queue *q = mq->queue;
-	struct mmc_context_info *cntx = &mq->card->host->context_info;
 
 	current->flags |= PF_MEMALLOC;
 
@@ -65,15 +64,12 @@ static int mmc_queue_thread(void *d)
 		set_current_state(TASK_INTERRUPTIBLE);
 		req = blk_fetch_request(q);
 		mq->asleep = false;
-		cntx->is_waiting_last_req = false;
 		if (!req) {
 			/*
 			 * Dispatch queue is empty so set flags for
 			 * mmc_request_fn() to wake us up.
 			 */
-			if (mq->mqrq_prev->req)
-				cntx->is_waiting_last_req = true;
-			else
+			if (!mq->mqrq_prev->req)
 				mq->asleep = true;
 		}
 		mq->mqrq_cur->req = req;
@@ -123,7 +119,6 @@ static void mmc_request_fn(struct request_queue *q)
 {
 	struct mmc_queue *mq = q->queuedata;
 	struct request *req;
-	struct mmc_context_info *cntx;
 
 	if (!mq) {
 		while ((req = blk_fetch_request(q)) != NULL) {
@@ -133,8 +128,6 @@ static void mmc_request_fn(struct request_queue *q)
 		return;
 	}
 
-	cntx = &mq->card->host->context_info;
-
 	if (mq->asleep)
 		wake_up_process(mq->thread);
 }
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 970d7f9b1eba..a7c0ed887391 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -192,14 +192,6 @@ struct mmc_slot {
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
 
@@ -373,7 +365,6 @@ struct mmc_host {
 	struct dentry		*debugfs_root;
 
 	struct mmc_async_req	*areq;		/* active async req */
-	struct mmc_context_info	context_info;	/* async synchronization info */
 
 	/* finalization work thread, handles finalizing requests */
 	struct kthread_worker	req_done_worker;
-- 
2.9.3
