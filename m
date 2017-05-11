Return-Path: <ulf.hansson@linaro.org>
Return-Path: <ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Paolo Valente <paolo.valente@linaro.org>,
	linux-block@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: [RFC PATCH 2/3] mmc: core: Remove redundant abort-able claim host API
Date: Thu, 11 May 2017 14:39:01 +0200
Message-Id: <1494506343-28572-3-git-send-email-ulf.hansson@linaro.org>
In-Reply-To: <1494506343-28572-1-git-send-email-ulf.hansson@linaro.org>
References: <1494506343-28572-1-git-send-email-ulf.hansson@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The only user of the abort-able claim host API was the SDIO IRQ thread, but
as that use has now been removed, let's simplify the code and remove the
API.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 31 ++++++++++---------------------
 drivers/mmc/core/core.h | 13 +------------
 2 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 82c45dd..0701e30 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1019,20 +1019,15 @@ unsigned int mmc_align_data_size(struct mmc_card *card, unsigned int sz)
 EXPORT_SYMBOL(mmc_align_data_size);
 
 /**
- *	__mmc_claim_host - exclusively claim a host
+ *	mmc_claim_host - exclusively claim a host
  *	@host: mmc host to claim
- *	@abort: whether or not the operation should be aborted
  *
- *	Claim a host for a set of operations.  If @abort is non null and
- *	dereference a non-zero value then this will return prematurely with
- *	that non-zero value without acquiring the lock.  Returns zero
- *	with the lock held otherwise.
+ *	Claim a host for a set of operations.
  */
-int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
+void mmc_claim_host(struct mmc_host *host)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
-	int stop;
 	bool pm = false;
 
 	might_sleep();
@@ -1041,31 +1036,25 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 	spin_lock_irqsave(&host->lock, flags);
 	while (1) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		stop = abort ? atomic_read(abort) : 0;
-		if (stop || !host->claimed || host->claimer == current)
+		if (!host->claimed || host->claimer == current)
 			break;
 		spin_unlock_irqrestore(&host->lock, flags);
 		schedule();
 		spin_lock_irqsave(&host->lock, flags);
 	}
 	set_current_state(TASK_RUNNING);
-	if (!stop) {
-		host->claimed = 1;
-		host->claimer = current;
-		host->claim_cnt += 1;
-		if (host->claim_cnt == 1)
-			pm = true;
-	} else
-		wake_up(&host->wq);
+	host->claimed = 1;
+	host->claimer = current;
+	host->claim_cnt += 1;
+	if (host->claim_cnt == 1)
+		pm = true;
 	spin_unlock_irqrestore(&host->lock, flags);
 	remove_wait_queue(&host->wq, &wait);
 
 	if (pm)
 		pm_runtime_get_sync(mmc_dev(host));
-
-	return stop;
 }
-EXPORT_SYMBOL(__mmc_claim_host);
+EXPORT_SYMBOL(mmc_claim_host);
 
 /**
  *	mmc_release_host - release a host
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 55f543f..b247b1f 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -122,20 +122,9 @@ int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
 int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
 			bool is_rel_write);
 
-int __mmc_claim_host(struct mmc_host *host, atomic_t *abort);
+void mmc_claim_host(struct mmc_host *host);
 void mmc_release_host(struct mmc_host *host);
 void mmc_get_card(struct mmc_card *card);
 void mmc_put_card(struct mmc_card *card);
 
-/**
- *	mmc_claim_host - exclusively claim a host
- *	@host: mmc host to claim
- *
- *	Claim a host for a set of operations.
- */
-static inline void mmc_claim_host(struct mmc_host *host)
-{
-	__mmc_claim_host(host, NULL);
-}
-
 #endif
-- 
2.7.4
