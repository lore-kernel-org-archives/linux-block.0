Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14501 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752340AbdIVMoA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 08:44:00 -0400
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
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V9 02/15] mmc: core: Introduce host claiming by context
Date: Fri, 22 Sep 2017 15:36:51 +0300
Message-Id: <1506083824-4024-3-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently the host can be claimed by a task.  Change this so that the host
can be claimed by a context that may or may not be a task.  This provides
for the host to be claimed by a block driver queue to support blk-mq, while
maintaining compatibility with the existing use of mmc_claim_host().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c    |  4 ++--
 drivers/mmc/core/core.c     | 48 ++++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/core/core.h     |  9 +++++----
 drivers/mmc/core/mmc.c      |  4 ++--
 drivers/mmc/core/sd.c       |  4 ++--
 drivers/mmc/core/sdio_irq.c |  3 ++-
 include/linux/mmc/host.h    |  7 ++++++-
 7 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ab9c780df750..41e7124b8679 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1989,7 +1989,7 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 
 	if (req && !mq->qcnt)
 		/* claim host only for the first request */
-		mmc_get_card(card);
+		mmc_get_card(card, NULL);
 
 	ret = mmc_blk_part_switch(card, md->part_type);
 	if (ret) {
@@ -2052,7 +2052,7 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 
 out:
 	if (!mq->qcnt)
-		mmc_put_card(card);
+		mmc_put_card(card, NULL);
 }
 
 static inline int mmc_blk_readonly(struct mmc_card *card)
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 66c9cf49ad2f..b997cf92ce6c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -832,9 +832,36 @@ unsigned int mmc_align_data_size(struct mmc_card *card, unsigned int sz)
 }
 EXPORT_SYMBOL(mmc_align_data_size);
 
+/*
+ * Allow claiming an already claimed host if the context is the same or there is
+ * no context but the task is the same.
+ */
+static inline bool mmc_ctx_matches(struct mmc_host *host, struct mmc_ctx *ctx,
+				   struct task_struct *task)
+{
+	return host->claimer == ctx ||
+	       (!ctx && task && host->claimer->task == task);
+}
+
+static inline void mmc_ctx_set_claimer(struct mmc_host *host,
+				       struct mmc_ctx *ctx,
+				       struct task_struct *task)
+{
+	if (!host->claimer) {
+		if (ctx)
+			host->claimer = ctx;
+		else
+			host->claimer = &host->default_ctx;
+	}
+	if (task)
+		host->claimer->task = task;
+}
+
 /**
  *	__mmc_claim_host - exclusively claim a host
  *	@host: mmc host to claim
+ *	@ctx: context that claims the host or NULL in which case the default
+ *	context will be used
  *	@abort: whether or not the operation should be aborted
  *
  *	Claim a host for a set of operations.  If @abort is non null and
@@ -842,8 +869,10 @@ unsigned int mmc_align_data_size(struct mmc_card *card, unsigned int sz)
  *	that non-zero value without acquiring the lock.  Returns zero
  *	with the lock held otherwise.
  */
-int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
+int __mmc_claim_host(struct mmc_host *host, struct mmc_ctx *ctx,
+		     atomic_t *abort)
 {
+	struct task_struct *task = ctx ? NULL : current;
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
 	int stop;
@@ -856,7 +885,7 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 	while (1) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		stop = abort ? atomic_read(abort) : 0;
-		if (stop || !host->claimed || host->claimer == current)
+		if (stop || !host->claimed || mmc_ctx_matches(host, ctx, task))
 			break;
 		spin_unlock_irqrestore(&host->lock, flags);
 		schedule();
@@ -865,7 +894,7 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 	set_current_state(TASK_RUNNING);
 	if (!stop) {
 		host->claimed = 1;
-		host->claimer = current;
+		mmc_ctx_set_claimer(host, ctx, task);
 		host->claim_cnt += 1;
 		if (host->claim_cnt == 1)
 			pm = true;
@@ -900,6 +929,7 @@ void mmc_release_host(struct mmc_host *host)
 		spin_unlock_irqrestore(&host->lock, flags);
 	} else {
 		host->claimed = 0;
+		host->claimer->task = NULL;
 		host->claimer = NULL;
 		spin_unlock_irqrestore(&host->lock, flags);
 		wake_up(&host->wq);
@@ -913,10 +943,10 @@ void mmc_release_host(struct mmc_host *host)
  * This is a helper function, which fetches a runtime pm reference for the
  * card device and also claims the host.
  */
-void mmc_get_card(struct mmc_card *card)
+void mmc_get_card(struct mmc_card *card, struct mmc_ctx *ctx)
 {
 	pm_runtime_get_sync(&card->dev);
-	mmc_claim_host(card->host);
+	__mmc_claim_host(card->host, ctx, NULL);
 }
 EXPORT_SYMBOL(mmc_get_card);
 
@@ -924,9 +954,13 @@ void mmc_get_card(struct mmc_card *card)
  * This is a helper function, which releases the host and drops the runtime
  * pm reference for the card device.
  */
-void mmc_put_card(struct mmc_card *card)
+void mmc_put_card(struct mmc_card *card, struct mmc_ctx *ctx)
 {
-	mmc_release_host(card->host);
+	struct mmc_host *host = card->host;
+
+	WARN_ON(ctx && host->claimer != ctx);
+
+	mmc_release_host(host);
 	pm_runtime_mark_last_busy(&card->dev);
 	pm_runtime_put_autosuspend(&card->dev);
 }
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index ca861091a776..94675f88f704 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -128,10 +128,11 @@ int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
 int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
 			bool is_rel_write);
 
-int __mmc_claim_host(struct mmc_host *host, atomic_t *abort);
+int __mmc_claim_host(struct mmc_host *host, struct mmc_ctx *ctx,
+		     atomic_t *abort);
 void mmc_release_host(struct mmc_host *host);
-void mmc_get_card(struct mmc_card *card);
-void mmc_put_card(struct mmc_card *card);
+void mmc_get_card(struct mmc_card *card, struct mmc_ctx *ctx);
+void mmc_put_card(struct mmc_card *card, struct mmc_ctx *ctx);
 
 /**
  *	mmc_claim_host - exclusively claim a host
@@ -141,7 +142,7 @@ int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
  */
 static inline void mmc_claim_host(struct mmc_host *host)
 {
-	__mmc_claim_host(host, NULL);
+	__mmc_claim_host(host, NULL, NULL);
 }
 
 #endif
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a7eb623f8daa..3927157207b9 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1909,14 +1909,14 @@ static void mmc_detect(struct mmc_host *host)
 {
 	int err;
 
-	mmc_get_card(host->card);
+	mmc_get_card(host->card, NULL);
 
 	/*
 	 * Just check if our card has been removed.
 	 */
 	err = _mmc_detect_card_removed(host);
 
-	mmc_put_card(host->card);
+	mmc_put_card(host->card, NULL);
 
 	if (err) {
 		mmc_remove(host);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 4fd1620b732d..2036b2b4835c 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1056,14 +1056,14 @@ static void mmc_sd_detect(struct mmc_host *host)
 {
 	int err;
 
-	mmc_get_card(host->card);
+	mmc_get_card(host->card, NULL);
 
 	/*
 	 * Just check if our card has been removed.
 	 */
 	err = _mmc_detect_card_removed(host);
 
-	mmc_put_card(host->card);
+	mmc_put_card(host->card, NULL);
 
 	if (err) {
 		mmc_sd_remove(host);
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index c771843e4c15..7a2eaf8410a3 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -155,7 +155,8 @@ static int sdio_irq_thread(void *_host)
 		 * holding of the host lock does not cover too much work
 		 * that doesn't require that lock to be held.
 		 */
-		ret = __mmc_claim_host(host, &host->sdio_irq_thread_abort);
+		ret = __mmc_claim_host(host, NULL,
+				       &host->sdio_irq_thread_abort);
 		if (ret)
 			break;
 		ret = process_sdio_pending_irqs(host);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 9a43763a68ad..443f7a8cdfe5 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -255,6 +255,10 @@ struct mmc_supply {
 	struct regulator *vqmmc;	/* Optional Vccq supply */
 };
 
+struct mmc_ctx {
+	struct task_struct *task;
+};
+
 struct mmc_host {
 	struct device		*parent;
 	struct device		class_dev;
@@ -388,8 +392,9 @@ struct mmc_host {
 	struct mmc_card		*card;		/* device attached to this host */
 
 	wait_queue_head_t	wq;
-	struct task_struct	*claimer;	/* task that has host claimed */
+	struct mmc_ctx		*claimer;	/* context that has host claimed */
 	int			claim_cnt;	/* "claim" nesting count */
+	struct mmc_ctx		default_ctx;	/* default context */
 
 	struct delayed_work	detect;
 	int			detect_change;	/* card detect flag */
-- 
1.9.1
