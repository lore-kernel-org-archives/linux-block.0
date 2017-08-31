Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35193 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751237AbdHaMEF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 08:04:05 -0400
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
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
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH V7 07/10] mmc: block: Factor out mmc_setup_queue()
Date: Thu, 31 Aug 2017 14:56:53 +0300
Message-Id: <1504180616-14514-8-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1504180616-14514-1-git-send-email-adrian.hunter@intel.com>
References: <1504180616-14514-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Factor out some common code that will also be used with blk-mq.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/queue.c | 53 ++++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index affa7370ba82..14e9de9c783c 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -223,6 +223,36 @@ static void mmc_exit_request(struct request_queue *q, struct request *req)
 	mq_rq->sg = NULL;
 }
 
+static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
+{
+	struct mmc_host *host = card->host;
+	u64 limit = BLK_BOUNCE_HIGH;
+
+	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
+		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
+
+	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
+	queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, mq->queue);
+	if (mmc_can_erase(card))
+		mmc_queue_setup_discard(mq->queue, card);
+
+	card->bouncesz = mmc_queue_calc_bouncesz(host);
+	if (card->bouncesz) {
+		blk_queue_max_hw_sectors(mq->queue, card->bouncesz / 512);
+		blk_queue_max_segments(mq->queue, card->bouncesz / 512);
+		blk_queue_max_segment_size(mq->queue, card->bouncesz);
+	} else {
+		blk_queue_bounce_limit(mq->queue, limit);
+		blk_queue_max_hw_sectors(mq->queue,
+			min(host->max_blk_count, host->max_req_size / 512));
+		blk_queue_max_segments(mq->queue, host->max_segs);
+		blk_queue_max_segment_size(mq->queue, host->max_seg_size);
+	}
+
+	/* Initialize thread_sem even if it is not used */
+	sema_init(&mq->thread_sem, 1);
+}
+
 /**
  * mmc_init_queue - initialise a queue structure.
  * @mq: mmc queue
@@ -236,12 +266,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		   spinlock_t *lock, const char *subname)
 {
 	struct mmc_host *host = card->host;
-	u64 limit = BLK_BOUNCE_HIGH;
 	int ret = -ENOMEM;
 
-	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
-		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
-
 	mq->card = card;
 	mq->queue = blk_alloc_queue(GFP_KERNEL);
 	if (!mq->queue)
@@ -260,25 +286,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	}
 
 	blk_queue_prep_rq(mq->queue, mmc_prep_request);
-	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
-	queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, mq->queue);
-	if (mmc_can_erase(card))
-		mmc_queue_setup_discard(mq->queue, card);
 
-	card->bouncesz = mmc_queue_calc_bouncesz(host);
-	if (card->bouncesz) {
-		blk_queue_max_hw_sectors(mq->queue, card->bouncesz / 512);
-		blk_queue_max_segments(mq->queue, card->bouncesz / 512);
-		blk_queue_max_segment_size(mq->queue, card->bouncesz);
-	} else {
-		blk_queue_bounce_limit(mq->queue, limit);
-		blk_queue_max_hw_sectors(mq->queue,
-			min(host->max_blk_count, host->max_req_size / 512));
-		blk_queue_max_segments(mq->queue, host->max_segs);
-		blk_queue_max_segment_size(mq->queue, host->max_seg_size);
-	}
-
-	sema_init(&mq->thread_sem, 1);
+	mmc_setup_queue(mq, card);
 
 	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d%s",
 		host->index, subname ? subname : "");
-- 
1.9.1
