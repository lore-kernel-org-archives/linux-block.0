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
Subject: [PATCH 08/16] mmc: core: do away with is_new_req
Date: Thu,  9 Feb 2017 16:33:55 +0100
Message-Id: <20170209153403.9730-9-linus.walleij@linaro.org>
In-Reply-To: <20170209153403.9730-1-linus.walleij@linaro.org>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The host context member "is_new_req" is only assigned values,
never checked. Delete it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/core.c  | 1 -
 drivers/mmc/core/queue.c | 5 -----
 include/linux/mmc/host.h | 2 --
 3 files changed, 8 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index fcb40ade9b82..933a4d1f20d5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2985,7 +2985,6 @@ void mmc_unregister_pm_notifier(struct mmc_host *host)
  */
 void mmc_init_context_info(struct mmc_host *host)
 {
-	host->context_info.is_new_req = false;
 	host->context_info.is_waiting_last_req = false;
 }
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 73250ed8f093..63927ffd6825 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -66,7 +66,6 @@ static int mmc_queue_thread(void *d)
 		req = blk_fetch_request(q);
 		mq->asleep = false;
 		cntx->is_waiting_last_req = false;
-		cntx->is_new_req = false;
 		if (!req) {
 			/*
 			 * Dispatch queue is empty so set flags for
@@ -136,10 +135,6 @@ static void mmc_request_fn(struct request_queue *q)
 
 	cntx = &mq->card->host->context_info;
 
-	if (cntx->is_waiting_last_req) {
-		cntx->is_new_req = true;
-	}
-
 	if (mq->asleep)
 		wake_up_process(mq->thread);
 }
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index cbb40682024a..970d7f9b1eba 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -194,11 +194,9 @@ struct mmc_slot {
 
 /**
  * mmc_context_info - synchronization details for mmc context
- * @is_new_req		wake up reason was new request
  * @is_waiting_last_req	mmc context waiting for single running request
  */
 struct mmc_context_info {
-	bool			is_new_req;
 	bool			is_waiting_last_req;
 };
 
-- 
2.9.3
