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
Subject: [PATCH 05/12] mmc: core: do away with is_new_req
Date: Fri, 10 Nov 2017 11:01:36 +0100
Message-Id: <20171110100143.12256-6-linus.walleij@linaro.org>
In-Reply-To: <20171110100143.12256-1-linus.walleij@linaro.org>
References: <20171110100143.12256-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The host context member "is_new_req" is only assigned values,
never checked. Delete it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v5:
- Rebasing on the "next" branch in the MMC tree.
---
 drivers/mmc/core/core.c  | 1 -
 drivers/mmc/core/queue.c | 5 -----
 include/linux/mmc/host.h | 2 --
 3 files changed, 8 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 15a664d3c199..b1a5059f6cd1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -3007,7 +3007,6 @@ void mmc_unregister_pm_notifier(struct mmc_host *host)
  */
 void mmc_init_context_info(struct mmc_host *host)
 {
-	host->context_info.is_new_req = false;
 	host->context_info.is_waiting_last_req = false;
 }
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index c46be4402803..4a0752ef6154 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -55,7 +55,6 @@ static int mmc_queue_thread(void *d)
 		req = blk_fetch_request(q);
 		mq->asleep = false;
 		cntx->is_waiting_last_req = false;
-		cntx->is_new_req = false;
 		if (!req) {
 			/*
 			 * Dispatch queue is empty so set flags for
@@ -109,10 +108,6 @@ static void mmc_request_fn(struct request_queue *q)
 
 	cntx = &mq->card->host->context_info;
 
-	if (cntx->is_waiting_last_req) {
-		cntx->is_new_req = true;
-	}
-
 	if (mq->asleep)
 		wake_up_process(mq->thread);
 }
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index d43d26562fae..36af19990683 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -241,11 +241,9 @@ struct mmc_slot {
 
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
2.13.6
