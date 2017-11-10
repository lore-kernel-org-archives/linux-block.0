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
Subject: [PATCH 04/12] mmc: core: do away with is_done_rcv
Date: Fri, 10 Nov 2017 11:01:35 +0100
Message-Id: <20171110100143.12256-5-linus.walleij@linaro.org>
In-Reply-To: <20171110100143.12256-1-linus.walleij@linaro.org>
References: <20171110100143.12256-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The "is_done_rcv" in the context info for the host is no longer
needed: it is clear from context (ha!) that as long as we are
waiting for the asynchronous request to come to completion,
we are not done receiving data, and when the finalization work
has run and completed the completion, we are indeed done.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v5:
- Rebasing on the "next" branch in the MMC tree.
---
 drivers/mmc/core/core.c  | 40 ++++++++++++++++------------------------
 include/linux/mmc/host.h |  2 --
 2 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7440daa2f559..15a664d3c199 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -370,10 +370,8 @@ EXPORT_SYMBOL(mmc_start_request);
 static void mmc_wait_data_done(struct mmc_request *mrq)
 {
 	struct mmc_host *host = mrq->host;
-	struct mmc_context_info *context_info = &host->context_info;
 	struct mmc_async_req *areq = mrq->areq;
 
-	context_info->is_done_rcv = true;
 	/* Schedule a work to deal with finalizing this request */
 	if (!areq)
 		pr_err("areq of the data mmc_request was NULL!\n");
@@ -656,7 +654,7 @@ EXPORT_SYMBOL(mmc_cqe_recovery);
 bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq)
 {
 	if (host->areq)
-		return host->context_info.is_done_rcv;
+		return completion_done(&host->areq->complete);
 	else
 		return completion_done(&mrq->completion);
 }
@@ -705,29 +703,24 @@ void mmc_finalize_areq(struct work_struct *work)
 	struct mmc_async_req *areq =
 		container_of(work, struct mmc_async_req, finalization_work);
 	struct mmc_host *host = areq->host;
-	struct mmc_context_info *context_info = &host->context_info;
 	enum mmc_blk_status status = MMC_BLK_SUCCESS;
+	struct mmc_command *cmd;
 
-	if (context_info->is_done_rcv) {
-		struct mmc_command *cmd;
-
-		context_info->is_done_rcv = false;
-		cmd = areq->mrq->cmd;
+	cmd = areq->mrq->cmd;
 
-		if (!cmd->error || !cmd->retries ||
-		    mmc_card_removed(host->card)) {
-			status = areq->err_check(host->card,
-						 areq);
-		} else {
-			mmc_retune_recheck(host);
-			pr_info("%s: req failed (CMD%u): %d, retrying...\n",
-				mmc_hostname(host),
-				cmd->opcode, cmd->error);
-			cmd->retries--;
-			cmd->error = 0;
-			__mmc_start_request(host, areq->mrq);
-			return; /* wait for done/new event again */
-		}
+	if (!cmd->error || !cmd->retries ||
+	    mmc_card_removed(host->card)) {
+		status = areq->err_check(host->card,
+					 areq);
+	} else {
+		mmc_retune_recheck(host);
+		pr_info("%s: req failed (CMD%u): %d, retrying...\n",
+			mmc_hostname(host),
+			cmd->opcode, cmd->error);
+		cmd->retries--;
+		cmd->error = 0;
+		__mmc_start_request(host, areq->mrq);
+		return; /* wait for done/new event again */
 	}
 
 	mmc_retune_release(host);
@@ -3015,7 +3008,6 @@ void mmc_unregister_pm_notifier(struct mmc_host *host)
 void mmc_init_context_info(struct mmc_host *host)
 {
 	host->context_info.is_new_req = false;
-	host->context_info.is_done_rcv = false;
 	host->context_info.is_waiting_last_req = false;
 }
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index d2ff79a16839..d43d26562fae 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -241,12 +241,10 @@ struct mmc_slot {
 
 /**
  * mmc_context_info - synchronization details for mmc context
- * @is_done_rcv		wake up reason was done request
  * @is_new_req		wake up reason was new request
  * @is_waiting_last_req	mmc context waiting for single running request
  */
 struct mmc_context_info {
-	bool			is_done_rcv;
 	bool			is_new_req;
 	bool			is_waiting_last_req;
 };
-- 
2.13.6
