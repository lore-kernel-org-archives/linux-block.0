Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:32958 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753104AbdAZPFD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 10:05:03 -0500
Received: by mail-lf0-f46.google.com with SMTP id x1so60238489lff.0
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2017 07:05:02 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6/6] mmc: queue: turn queue flags into bools
Date: Thu, 26 Jan 2017 16:04:33 +0100
Message-Id: <20170126150433.14038-6-linus.walleij@linaro.org>
In-Reply-To: <20170126150433.14038-1-linus.walleij@linaro.org>
References: <20170126150433.14038-1-linus.walleij@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Instead of masking and setting two bits in the "flags" field
for the mmc_queue, just use two bools named "suspended" and
"new_request".

The masking and setting would likely have race conditions
anyways, it is better to use a simple member like this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c |  6 +++---
 drivers/mmc/core/queue.c | 12 ++++++------
 drivers/mmc/core/queue.h |  5 ++---
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 04c7162f444e..7be50ebf300f 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1665,7 +1665,7 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 			 * complete.
 			 */
 			if (status == MMC_BLK_NEW_REQUEST)
-				mq->flags |= MMC_QUEUE_NEW_REQUEST;
+				mq->new_request = true;
 			return;
 		}
 
@@ -1804,7 +1804,7 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		goto out;
 	}
 
-	mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
+	mq->new_request = false;
 	if (req && req_op(req) == REQ_OP_DISCARD) {
 		/* complete ongoing async transfer before issuing discard */
 		if (card->host->areq)
@@ -1825,7 +1825,7 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	}
 
 out:
-	if ((!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST)) || req_is_special)
+	if ((!req && !mq->new_request) || req_is_special)
 		/*
 		 * Release host when there are no more requests
 		 * and after special request(discard, flush) is done.
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 611f5c6d1950..5cb369c2664b 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -86,8 +86,8 @@ static int mmc_queue_thread(void *d)
 			set_current_state(TASK_RUNNING);
 			mmc_blk_issue_rq(mq, req);
 			cond_resched();
-			if (mq->flags & MMC_QUEUE_NEW_REQUEST) {
-				mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
+			if (mq->new_request) {
+				mq->new_request = false;
 				continue; /* fetch again */
 			}
 
@@ -401,8 +401,8 @@ void mmc_queue_suspend(struct mmc_queue *mq)
 	struct request_queue *q = mq->queue;
 	unsigned long flags;
 
-	if (!(mq->flags & MMC_QUEUE_SUSPENDED)) {
-		mq->flags |= MMC_QUEUE_SUSPENDED;
+	if (!mq->suspended) {
+		mq->suspended |= true;
 
 		spin_lock_irqsave(q->queue_lock, flags);
 		blk_stop_queue(q);
@@ -421,8 +421,8 @@ void mmc_queue_resume(struct mmc_queue *mq)
 	struct request_queue *q = mq->queue;
 	unsigned long flags;
 
-	if (mq->flags & MMC_QUEUE_SUSPENDED) {
-		mq->flags &= ~MMC_QUEUE_SUSPENDED;
+	if (mq->suspended) {
+		mq->suspended = false;
 
 		up(&mq->thread_sem);
 
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index e0cd5b1f40ee..e298f100101b 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -40,9 +40,8 @@ struct mmc_queue {
 	struct mmc_card		*card;
 	struct task_struct	*thread;
 	struct semaphore	thread_sem;
-	unsigned int		flags;
-#define MMC_QUEUE_SUSPENDED	(1 << 0)
-#define MMC_QUEUE_NEW_REQUEST	(1 << 1)
+	bool			new_request;
+	bool			suspended;
 	bool			asleep;
 	struct mmc_blk_data	*blkdata;
 	struct request_queue	*queue;
-- 
2.9.3

