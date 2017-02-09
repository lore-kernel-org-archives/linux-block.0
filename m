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
Subject: [PATCH 02/16] mmc: core: refactor asynchronous request finalization
Date: Thu,  9 Feb 2017 16:33:49 +0100
Message-Id: <20170209153403.9730-3-linus.walleij@linaro.org>
In-Reply-To: <20170209153403.9730-1-linus.walleij@linaro.org>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

mmc_wait_for_data_req_done() is called in exactly one place,
and having it spread out is making things hard to oversee.
Factor this function into mmc_finalize_areq().

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/core.c | 86 +++++++++++++++++++------------------------------
 1 file changed, 33 insertions(+), 53 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 53065d1cebf7..b2e7a6dfcbf0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -485,56 +485,6 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 	return err;
 }
 
-/*
- * mmc_wait_for_data_req_done() - wait for request completed
- * @host: MMC host to prepare the command.
- * @mrq: MMC request to wait for
- *
- * Blocks MMC context till host controller will ack end of data request
- * execution or new request notification arrives from the block layer.
- * Handles command retries.
- *
- * Returns enum mmc_blk_status after checking errors.
- */
-static enum mmc_blk_status mmc_wait_for_data_req_done(struct mmc_host *host,
-						      struct mmc_request *mrq)
-{
-	struct mmc_command *cmd;
-	struct mmc_context_info *context_info = &host->context_info;
-	enum mmc_blk_status status;
-
-	while (1) {
-		wait_event_interruptible(context_info->wait,
-				(context_info->is_done_rcv ||
-				 context_info->is_new_req));
-
-		if (context_info->is_done_rcv) {
-			context_info->is_done_rcv = false;
-			cmd = mrq->cmd;
-
-			if (!cmd->error || !cmd->retries ||
-			    mmc_card_removed(host->card)) {
-				status = host->areq->err_check(host->card,
-							       host->areq);
-				break; /* return status */
-			} else {
-				mmc_retune_recheck(host);
-				pr_info("%s: req failed (CMD%u): %d, retrying...\n",
-					mmc_hostname(host),
-					cmd->opcode, cmd->error);
-				cmd->retries--;
-				cmd->error = 0;
-				__mmc_start_request(host, mrq);
-				continue; /* wait for done/new event again */
-			}
-		}
-
-		return MMC_BLK_NEW_REQUEST;
-	}
-	mmc_retune_release(host);
-	return status;
-}
-
 void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 {
 	struct mmc_command *cmd;
@@ -639,14 +589,44 @@ static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
  */
 static enum mmc_blk_status mmc_finalize_areq(struct mmc_host *host)
 {
+	struct mmc_context_info *context_info = &host->context_info;
 	enum mmc_blk_status status;
 
 	if (!host->areq)
 		return MMC_BLK_SUCCESS;
 
-	status = mmc_wait_for_data_req_done(host, host->areq->mrq);
-	if (status == MMC_BLK_NEW_REQUEST)
-		return status;
+	while (1) {
+		wait_event_interruptible(context_info->wait,
+				(context_info->is_done_rcv ||
+				 context_info->is_new_req));
+
+		if (context_info->is_done_rcv) {
+			struct mmc_command *cmd;
+
+			context_info->is_done_rcv = false;
+			cmd = host->areq->mrq->cmd;
+
+			if (!cmd->error || !cmd->retries ||
+			    mmc_card_removed(host->card)) {
+				status = host->areq->err_check(host->card,
+							       host->areq);
+				break; /* return status */
+			} else {
+				mmc_retune_recheck(host);
+				pr_info("%s: req failed (CMD%u): %d, retrying...\n",
+					mmc_hostname(host),
+					cmd->opcode, cmd->error);
+				cmd->retries--;
+				cmd->error = 0;
+				__mmc_start_request(host, host->areq->mrq);
+				continue; /* wait for done/new event again */
+			}
+		}
+
+		return MMC_BLK_NEW_REQUEST;
+	}
+
+	mmc_retune_release(host);
 
 	/*
 	 * Check BKOPS urgency for each R1 response
-- 
2.9.3
