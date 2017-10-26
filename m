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
Subject: [PATCH 07/12 v4] mmc: queue: simplify queue logic
Date: Thu, 26 Oct 2017 14:57:52 +0200
Message-Id: <20171026125757.10200-8-linus.walleij@linaro.org>
In-Reply-To: <20171026125757.10200-1-linus.walleij@linaro.org>
References: <20171026125757.10200-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The if() statment checking if there is no current or previous
request is now just looking ahead at something that will be
concluded a few lines below. Simplify the logic by moving the
assignment of .asleep.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/queue.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 2c232ba4e594..023bbddc1a0b 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -53,14 +53,6 @@ static int mmc_queue_thread(void *d)
 		set_current_state(TASK_INTERRUPTIBLE);
 		req = blk_fetch_request(q);
 		mq->asleep = false;
-		if (!req) {
-			/*
-			 * Dispatch queue is empty so set flags for
-			 * mmc_request_fn() to wake us up.
-			 */
-			if (!mq->qcnt)
-				mq->asleep = true;
-		}
 		spin_unlock_irq(q->queue_lock);
 
 		if (req || mq->qcnt) {
@@ -68,6 +60,7 @@ static int mmc_queue_thread(void *d)
 			mmc_blk_issue_rq(mq, req);
 			cond_resched();
 		} else {
+			mq->asleep = true;
 			if (kthread_should_stop()) {
 				set_current_state(TASK_RUNNING);
 				break;
-- 
2.13.6
