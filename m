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
Subject: [RFC PATCH 3/3] mmc: core: Allow mmc block device to re-claim the host
Date: Thu, 11 May 2017 14:39:02 +0200
Message-Id: <1494506343-28572-4-git-send-email-ulf.hansson@linaro.org>
In-Reply-To: <1494506343-28572-1-git-send-email-ulf.hansson@linaro.org>
References: <1494506343-28572-1-git-send-email-ulf.hansson@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The current mmc block device implementation is tricky when it comes to
claim and release of the host, while processing I/O requests. In principle
we need to claim the host at the first request entering the queue and then
we need to release the host, as soon as the queue becomes empty. This
complexity relates to the asynchronous request mechanism that the mmc block
device driver implements.

For the legacy block interface that we currently implements, the above
issue can be addressed, as we can find out when the queue really becomes
empty.

However, to find out whether the queue is empty, isn't really an applicable
method when using the new blk-mq interface, as requests are instead pushed
to us via the struct struct blk_mq_ops and its function pointers.

Being able to support the asynchronous request method using the blk-mq
interface, means we have to allow the mmc block device driver to re-claim
the host from different tasks/contexts, as we may have > 1 request to
operate upon.

Therefore, let's extend the mmc_claim_host() API to support reference
counting for the mmc block device.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c  | 14 ++++++++++----
 drivers/mmc/core/core.h  |  7 ++++++-
 include/linux/mmc/host.h |  1 +
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0701e30..3633699 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1019,12 +1019,12 @@ unsigned int mmc_align_data_size(struct mmc_card *card, unsigned int sz)
 EXPORT_SYMBOL(mmc_align_data_size);
 
 /**
- *	mmc_claim_host - exclusively claim a host
+ *	__mmc_claim_host - exclusively claim a host
  *	@host: mmc host to claim
  *
  *	Claim a host for a set of operations.
  */
-void mmc_claim_host(struct mmc_host *host)
+void __mmc_claim_host(struct mmc_host *host, bool is_blkdev)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
@@ -1036,7 +1036,11 @@ void mmc_claim_host(struct mmc_host *host)
 	spin_lock_irqsave(&host->lock, flags);
 	while (1) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (!host->claimed || host->claimer == current)
+		if (!host->claimed)
+			break;
+		if (host->claimer_is_blkdev && is_blkdev)
+			break;
+		if (host->claimer == current)
 			break;
 		spin_unlock_irqrestore(&host->lock, flags);
 		schedule();
@@ -1045,6 +1049,7 @@ void mmc_claim_host(struct mmc_host *host)
 	set_current_state(TASK_RUNNING);
 	host->claimed = 1;
 	host->claimer = current;
+	host->claimer_is_blkdev = is_blkdev;
 	host->claim_cnt += 1;
 	if (host->claim_cnt == 1)
 		pm = true;
@@ -1054,7 +1059,7 @@ void mmc_claim_host(struct mmc_host *host)
 	if (pm)
 		pm_runtime_get_sync(mmc_dev(host));
 }
-EXPORT_SYMBOL(mmc_claim_host);
+EXPORT_SYMBOL(__mmc_claim_host);
 
 /**
  *	mmc_release_host - release a host
@@ -1076,6 +1081,7 @@ void mmc_release_host(struct mmc_host *host)
 	} else {
 		host->claimed = 0;
 		host->claimer = NULL;
+		host->claimer_is_blkdev = 0;
 		spin_unlock_irqrestore(&host->lock, flags);
 		wake_up(&host->wq);
 		pm_runtime_mark_last_busy(mmc_dev(host));
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index b247b1f..1598a37 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -122,9 +122,14 @@ int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
 int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
 			bool is_rel_write);
 
-void mmc_claim_host(struct mmc_host *host);
+void __mmc_claim_host(struct mmc_host *host, bool is_blkdev);
 void mmc_release_host(struct mmc_host *host);
 void mmc_get_card(struct mmc_card *card);
 void mmc_put_card(struct mmc_card *card);
 
+static inline void mmc_claim_host(struct mmc_host *host)
+{
+	__mmc_claim_host(host, 0);
+}
+
 #endif
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8a4131f..7199817 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -347,6 +347,7 @@ struct mmc_host {
 
 	wait_queue_head_t	wq;
 	struct task_struct	*claimer;	/* task that has host claimed */
+	bool			claimer_is_blkdev; /* claimer is blkdev */
 	int			claim_cnt;	/* "claim" nesting count */
 
 	struct delayed_work	detect;
-- 
2.7.4
