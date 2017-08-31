Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35193 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751057AbdHaMDn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 08:03:43 -0400
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
Subject: [PATCH V7 02/10] mmc: core: Add support for handling CQE requests
Date: Thu, 31 Aug 2017 14:56:48 +0300
Message-Id: <1504180616-14514-3-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1504180616-14514-1-git-send-email-adrian.hunter@intel.com>
References: <1504180616-14514-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add core support for handling CQE requests, including starting, completing
and recovering.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c  | 163 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/core/core.h  |   4 ++
 include/linux/mmc/host.h |   2 +
 3 files changed, 164 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6a0ca128a520..8bf24cfc03f8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -266,7 +266,8 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	host->ops->request(host, mrq);
 }
 
-static void mmc_mrq_pr_debug(struct mmc_host *host, struct mmc_request *mrq)
+static void mmc_mrq_pr_debug(struct mmc_host *host, struct mmc_request *mrq,
+			     bool cqe)
 {
 	if (mrq->sbc) {
 		pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
@@ -275,9 +276,12 @@ static void mmc_mrq_pr_debug(struct mmc_host *host, struct mmc_request *mrq)
 	}
 
 	if (mrq->cmd) {
-		pr_debug("%s: starting CMD%u arg %08x flags %08x\n",
-			 mmc_hostname(host), mrq->cmd->opcode, mrq->cmd->arg,
-			 mrq->cmd->flags);
+		pr_debug("%s: starting %sCMD%u arg %08x flags %08x\n",
+			 mmc_hostname(host), cqe ? "CQE direct " : "",
+			 mrq->cmd->opcode, mrq->cmd->arg, mrq->cmd->flags);
+	} else if (cqe) {
+		pr_debug("%s: starting CQE transfer for tag %d blkaddr %u\n",
+			 mmc_hostname(host), mrq->tag, mrq->data->blk_addr);
 	}
 
 	if (mrq->data) {
@@ -342,7 +346,7 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	if (mmc_card_removed(host->card))
 		return -ENOMEDIUM;
 
-	mmc_mrq_pr_debug(host, mrq);
+	mmc_mrq_pr_debug(host, mrq, false);
 
 	WARN_ON(!host->claimed);
 
@@ -482,6 +486,155 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 }
 EXPORT_SYMBOL(mmc_wait_for_req_done);
 
+/*
+ * mmc_cqe_start_req - Start a CQE request.
+ * @host: MMC host to start the request
+ * @mrq: request to start
+ *
+ * Start the request, re-tuning if needed and it is possible. Returns an error
+ * code if the request fails to start or -EBUSY if CQE is busy.
+ */
+int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
+{
+	int err;
+
+	/*
+	 * CQE cannot process re-tuning commands. Caller must hold retuning
+	 * while CQE is in use.  Re-tuning can happen here only when CQE has no
+	 * active requests i.e. this is the first.  Note, re-tuning will call
+	 * ->cqe_off().
+	 */
+	err = mmc_retune(host);
+	if (err)
+		goto out_err;
+
+	mrq->host = host;
+
+	mmc_mrq_pr_debug(host, mrq, true);
+
+	err = mmc_mrq_prep(host, mrq);
+	if (err)
+		goto out_err;
+
+	err = host->cqe_ops->cqe_request(host, mrq);
+	if (err)
+		goto out_err;
+
+	trace_mmc_request_start(host, mrq);
+
+	return 0;
+
+out_err:
+	if (mrq->cmd) {
+		pr_debug("%s: failed to start CQE direct CMD%u, error %d\n",
+			 mmc_hostname(host), mrq->cmd->opcode, err);
+	} else {
+		pr_debug("%s: failed to start CQE transfer for tag %d, error %d\n",
+			 mmc_hostname(host), mrq->tag, err);
+	}
+	return err;
+}
+EXPORT_SYMBOL(mmc_cqe_start_req);
+
+/**
+ *	mmc_cqe_request_done - CQE has finished processing an MMC request
+ *	@host: MMC host which completed request
+ *	@mrq: MMC request which completed
+ *
+ *	CQE drivers should call this function when they have completed
+ *	their processing of a request.
+ */
+void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq)
+{
+	mmc_should_fail_request(host, mrq);
+
+	/* Flag re-tuning needed on CRC errors */
+	if ((mrq->cmd && mrq->cmd->error == -EILSEQ) ||
+	    (mrq->data && mrq->data->error == -EILSEQ))
+		mmc_retune_needed(host);
+
+	trace_mmc_request_done(host, mrq);
+
+	if (mrq->cmd) {
+		pr_debug("%s: CQE req done (direct CMD%u): %d\n",
+			 mmc_hostname(host), mrq->cmd->opcode, mrq->cmd->error);
+	} else {
+		pr_debug("%s: CQE transfer done tag %d\n",
+			 mmc_hostname(host), mrq->tag);
+	}
+
+	if (mrq->data) {
+		pr_debug("%s:     %d bytes transferred: %d\n",
+			 mmc_hostname(host),
+			 mrq->data->bytes_xfered, mrq->data->error);
+	}
+
+	mrq->done(mrq);
+}
+EXPORT_SYMBOL(mmc_cqe_request_done);
+
+/**
+ *	mmc_cqe_post_req - CQE post process of a completed MMC request
+ *	@host: MMC host
+ *	@mrq: MMC request to be processed
+ */
+void mmc_cqe_post_req(struct mmc_host *host, struct mmc_request *mrq)
+{
+	if (host->cqe_ops->cqe_post_req)
+		host->cqe_ops->cqe_post_req(host, mrq);
+}
+EXPORT_SYMBOL(mmc_cqe_post_req);
+
+/* Arbitrary 1 second timeout */
+#define MMC_CQE_RECOVERY_TIMEOUT	1000
+
+/*
+ * mmc_cqe_recovery - Recover from CQE errors.
+ * @host: MMC host to recover
+ *
+ * Recovery consists of stopping CQE, stopping eMMC, discarding the queue in
+ * in eMMC, and discarding the queue in CQE. CQE must call
+ * mmc_cqe_request_done() on all requests. An error is returned if the eMMC
+ * fails to discard its queue.
+ */
+int mmc_cqe_recovery(struct mmc_host *host)
+{
+	struct mmc_command cmd;
+	int err;
+
+	mmc_retune_hold_now(host);
+
+	/*
+	 * Recovery is expected seldom, if at all, but it reduces performance,
+	 * so make sure it is not completely silent.
+	 */
+	pr_warn("%s: running CQE recovery\n", mmc_hostname(host));
+
+	host->cqe_ops->cqe_recovery_start(host);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.opcode       = MMC_STOP_TRANSMISSION,
+	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC,
+	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
+	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT,
+	mmc_wait_for_cmd(host, &cmd, 0);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.opcode       = MMC_CMDQ_TASK_MGMT;
+	cmd.arg          = 1; /* Discard entire queue */
+	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
+	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
+	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT,
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+
+	host->cqe_ops->cqe_recovery_finish(host);
+
+	mmc_retune_release(host);
+
+	return err;
+}
+EXPORT_SYMBOL(mmc_cqe_recovery);
+
 /**
  *	mmc_is_req_done - Determine if a 'cap_cmd_during_tfr' request is done
  *	@host: MMC host
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index a79b6054a7b2..8a70da44d41f 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -152,4 +152,8 @@ static inline void mmc_claim_host(struct mmc_host *host)
 void mmc_ctx_get_card(struct mmc_card *card, struct mmc_ctx *ctx);
 void mmc_ctx_put_card(struct mmc_card *card, struct mmc_ctx *ctx);
 
+int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq);
+void mmc_cqe_post_req(struct mmc_host *host, struct mmc_request *mrq);
+int mmc_cqe_recovery(struct mmc_host *host);
+
 #endif
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 228a493c3b25..54b0463443bd 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -474,6 +474,8 @@ static inline void *mmc_priv(struct mmc_host *host)
 void mmc_request_done(struct mmc_host *, struct mmc_request *);
 void mmc_command_done(struct mmc_host *host, struct mmc_request *mrq);
 
+void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq);
+
 static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 {
 	host->ops->enable_sdio_irq(host, 0);
-- 
1.9.1
