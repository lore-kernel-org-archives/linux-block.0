Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:18403 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754006AbdHWNnn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 09:43:43 -0400
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: [PATCH RFC 2/3] mmc: core: Introduce host claiming by context
Date: Wed, 23 Aug 2017 16:37:07 +0300
Message-Id: <1503495428-11999-3-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1503495428-11999-1-git-send-email-adrian.hunter@intel.com>
References: <1503495428-11999-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently the host can be claimed by a task.  Change this so that the host
can be claimed by a context that may or may not be a task.  This provides
for the host to be claimed by a block driver queue to support blk-mq, while
maintaining compatibility with the existing use of mmc_claim_host().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c  | 109 ++++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/core/core.h  |   8 ++++
 include/linux/mmc/host.h |   7 ++-
 3 files changed, 116 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f59c976cc96c..256d3663712a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -998,9 +998,38 @@ unsigned int mmc_align_data_size(struct mmc_card *card, unsigned int sz)
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
- *	__mmc_claim_host - exclusively claim a host
+ *	__mmc_ctx_task_claim_host - exclusively claim a host
  *	@host: mmc host to claim
+ *	@ctx: context that claims the host or NULL in which case the default
+ *	context will be used
+ *	@task: task that claims the host or NULL in which case @ctx must be
+ *	provided
  *	@abort: whether or not the operation should be aborted
  *
  *	Claim a host for a set of operations.  If @abort is non null and
@@ -1008,7 +1037,8 @@ unsigned int mmc_align_data_size(struct mmc_card *card, unsigned int sz)
  *	that non-zero value without acquiring the lock.  Returns zero
  *	with the lock held otherwise.
  */
-int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
+static int __mmc_ctx_task_claim_host(struct mmc_host *host, struct mmc_ctx *ctx,
+				     struct task_struct *task, atomic_t *abort)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
@@ -1022,7 +1052,7 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 	while (1) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		stop = abort ? atomic_read(abort) : 0;
-		if (stop || !host->claimed || host->claimer == current)
+		if (stop || !host->claimed || mmc_ctx_matches(host, ctx, task))
 			break;
 		spin_unlock_irqrestore(&host->lock, flags);
 		schedule();
@@ -1031,7 +1061,7 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 	set_current_state(TASK_RUNNING);
 	if (!stop) {
 		host->claimed = 1;
-		host->claimer = current;
+		mmc_ctx_set_claimer(host, ctx, task);
 		host->claim_cnt += 1;
 		if (host->claim_cnt == 1)
 			pm = true;
@@ -1045,8 +1075,25 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 
 	return stop;
 }
+
+int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
+{
+	return __mmc_ctx_task_claim_host(host, NULL, current, abort);
+}
 EXPORT_SYMBOL(__mmc_claim_host);
 
+void mmc_ctx_claim_host(struct mmc_host *host, struct mmc_ctx *ctx)
+{
+	__mmc_ctx_task_claim_host(host, ctx, NULL, NULL);
+}
+EXPORT_SYMBOL(mmc_ctx_claim_host);
+
+void mmc_ctx_task_claim_host(struct mmc_host *host, struct mmc_ctx *ctx)
+{
+	__mmc_ctx_task_claim_host(host, ctx, current, NULL);
+}
+EXPORT_SYMBOL(mmc_ctx_task_claim_host);
+
 /**
  *	mmc_release_host - release a host
  *	@host: mmc host to release
@@ -1054,18 +1101,19 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
  *	Release a MMC host, allowing others to claim the host
  *	for their operations.
  */
-void mmc_release_host(struct mmc_host *host)
+static void __mmc_release_host(struct mmc_host *host, bool task_release)
 {
 	unsigned long flags;
 
-	WARN_ON(!host->claimed);
-
 	spin_lock_irqsave(&host->lock, flags);
 	if (--host->claim_cnt) {
 		/* Release for nested claim */
+		if (task_release)
+			host->claimer->task = NULL;
 		spin_unlock_irqrestore(&host->lock, flags);
 	} else {
 		host->claimed = 0;
+		host->claimer->task = NULL;
 		host->claimer = NULL;
 		spin_unlock_irqrestore(&host->lock, flags);
 		wake_up(&host->wq);
@@ -1073,8 +1121,32 @@ void mmc_release_host(struct mmc_host *host)
 		pm_runtime_put_autosuspend(mmc_dev(host));
 	}
 }
+
+void mmc_release_host(struct mmc_host *host)
+{
+	WARN_ON(!host->claimed);
+
+	__mmc_release_host(host, false);
+}
 EXPORT_SYMBOL(mmc_release_host);
 
+void mmc_ctx_release_host(struct mmc_host *host, struct mmc_ctx *ctx)
+{
+	WARN_ON(!host->claimed || host->claimer != ctx);
+
+	__mmc_release_host(host, false);
+}
+EXPORT_SYMBOL(mmc_ctx_release_host);
+
+void mmc_ctx_task_release_host(struct mmc_host *host, struct mmc_ctx *ctx)
+{
+	WARN_ON(!host->claimed || host->claimer != ctx ||
+		host->claimer->task != current);
+
+	__mmc_release_host(host, true);
+}
+EXPORT_SYMBOL(mmc_ctx_task_release_host);
+
 /*
  * This is a helper function, which fetches a runtime pm reference for the
  * card device and also claims the host.
@@ -1087,6 +1159,17 @@ void mmc_get_card(struct mmc_card *card)
 EXPORT_SYMBOL(mmc_get_card);
 
 /*
+ * This is a helper function, which fetches a runtime pm reference for the
+ * card device and also claims the host for the mmc context.
+ */
+void mmc_ctx_get_card(struct mmc_card *card, struct mmc_ctx *ctx)
+{
+	pm_runtime_get_sync(&card->dev);
+	mmc_ctx_claim_host(card->host, ctx);
+}
+EXPORT_SYMBOL(mmc_ctx_get_card);
+
+/*
  * This is a helper function, which releases the host and drops the runtime
  * pm reference for the card device.
  */
@@ -1099,6 +1182,18 @@ void mmc_put_card(struct mmc_card *card)
 EXPORT_SYMBOL(mmc_put_card);
 
 /*
+ * This is a helper function, which releases the host and drops the runtime
+ * pm reference for the card device.
+ */
+void mmc_ctx_put_card(struct mmc_card *card, struct mmc_ctx *ctx)
+{
+	mmc_ctx_release_host(card->host, ctx);
+	pm_runtime_mark_last_busy(&card->dev);
+	pm_runtime_put_autosuspend(&card->dev);
+}
+EXPORT_SYMBOL(mmc_ctx_put_card);
+
+/*
  * Internal function that does the actual ios call to the host driver,
  * optionally printing some debug output.
  */
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index c30da856b4d4..acad3920d3ee 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -140,4 +140,12 @@ static inline void mmc_claim_host(struct mmc_host *host)
 	__mmc_claim_host(host, NULL);
 }
 
+void mmc_ctx_claim_host(struct mmc_host *host, struct mmc_ctx *ctx);
+void mmc_ctx_release_host(struct mmc_host *host, struct mmc_ctx *ctx);
+void mmc_ctx_task_claim_host(struct mmc_host *host, struct mmc_ctx *ctx);
+void mmc_ctx_task_release_host(struct mmc_host *host, struct mmc_ctx *ctx);
+
+void mmc_ctx_get_card(struct mmc_card *card, struct mmc_ctx *ctx);
+void mmc_ctx_put_card(struct mmc_card *card, struct mmc_ctx *ctx);
+
 #endif
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index b7f5a66e0652..8d1db661b713 100644
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
@@ -389,8 +393,9 @@ struct mmc_host {
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
