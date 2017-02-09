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
Subject: [PATCH 10/16] mmc: queue: simplify queue logic
Date: Thu,  9 Feb 2017 16:33:57 +0100
Message-Id: <20170209153403.9730-11-linus.walleij@linaro.org>
In-Reply-To: <20170209153403.9730-1-linus.walleij@linaro.org>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
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
index a845fe8d4fd1..bc116709c806 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -64,14 +64,6 @@ static int mmc_queue_thread(void *d)
 		set_current_state(TASK_INTERRUPTIBLE);
 		req = blk_fetch_request(q);
 		mq->asleep = false;
-		if (!req) {
-			/*
-			 * Dispatch queue is empty so set flags for
-			 * mmc_request_fn() to wake us up.
-			 */
-			if (!mq->mqrq_prev->req)
-				mq->asleep = true;
-		}
 		mq->mqrq_cur->req = req;
 		spin_unlock_irq(q->queue_lock);
 
@@ -95,6 +87,7 @@ static int mmc_queue_thread(void *d)
 			mq->mqrq_prev->req = NULL;
 			swap(mq->mqrq_prev, mq->mqrq_cur);
 		} else {
+			mq->asleep = true;
 			if (kthread_should_stop()) {
 				set_current_state(TASK_RUNNING);
 				break;
-- 
2.9.3
