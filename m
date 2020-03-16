Return-Path: <SRS0=UGhi=5B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24ECC0044D
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BCA20663
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMB8rNhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgCPKBv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:01:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41191 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbgCPKBv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 06:01:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id b1so9451739pgm.8;
        Mon, 16 Mar 2020 03:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lK1tu7FG6Gmt2PZsswSWIBP1KAU/0m3WCpgCgO+YW3s=;
        b=oMB8rNhbm657lnTOnnEUNQJK42/ljp3Z4Tj8wK0axvwwpOsR5DfkPKmQBH0tbpdOmc
         PiX/WAEM1MwOlGEZ0560IgtjdIkgsfI/1woidX1bB2VuoYPharxiOaWPwyW9zbdD1kSO
         oTgkYz7Jki/X6y+6Rq6EiRfjBPycVXQwfXptL4RlrjCfCe0XBfPPWUaVZ4iTAJma7guo
         bi9BAPuMlRKZ8TtO8qD2Ca/8ekYoYBCxhXf/HAd5anBdNcX1xThsAFS1IxSfl9ae6l95
         cWNJ7NX+WvmQcdmSFJI3lp/WCzoj/SBnYzhhy3ID4+PILcF1sJhWeVu7g09r/tBrjNnb
         WU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lK1tu7FG6Gmt2PZsswSWIBP1KAU/0m3WCpgCgO+YW3s=;
        b=mm2MTnodRQ/v5Db0un1HLJjmGYdMJe/4GVXPextqVvbbJVwoIeQ/6VaqJ3I2+kgvj8
         OM9vGJhJMtdvi6fWndyfhPmT4heZU86SkXob8JmKyZfZNf/vQKEq0n2YAjmgKQ1j65ZM
         4UG04QfX3dABswPRZz5gnRmuga2XYLxWel8V2jEtVNAB7SHCaq3wUQWipGCI8wGUVKY2
         a2eF9oUE9JZvftf30XwepHQxH8iMvhBgrYJmtsnPvlNHP15+KoivKCC0J5ocMVuVyLf5
         NmunPbYbMxScn7DIlU7/CIw+oGL3uQHLbhxLPm8qeDUfY8CZtrvinbYdFrT+vAFB7LRq
         t2fg==
X-Gm-Message-State: ANhLgQ2+SZ/8+2W8iAM18Q8xFrz4k5r64WDtnDlWfYWXly4Sqdu0f119
        WUDHuNoSzCd0nzb0NqVu8HM=
X-Google-Smtp-Source: ADFU+vt6uj7Xil435cwOJUT+4MIVGCtJODt9QyqmfX1533Xqg5EqeepP3zvOz2QvS5iivCNDk6d4/g==
X-Received: by 2002:a63:c550:: with SMTP id g16mr27146624pgd.9.1584352909830;
        Mon, 16 Mar 2020 03:01:49 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 136sm63970411pgh.26.2020.03.16.03.01.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 03:01:49 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     ming.lei@redhat.com, arnd@arndb.de, linus.walleij@linaro.org,
        baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH 3/8] mmc: Add MMC packed request support for MMC software queue
Date:   Mon, 16 Mar 2020 18:01:20 +0800
Message-Id: <e1404d3e93013ca67bf3afdb8a20f87d1773b2ef.1584350380.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584350380.git.baolin.wang7@gmail.com>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584350380.git.baolin.wang7@gmail.com>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some SD controllers can support packed command or packed request, that
means it can package several requests to host controller to be handled
at one time, which can reduce interrutps and improve the DMA transfer.
As a result, the I/O performence can be improved.

Thus this patch adds MMC packed function to support packed requests or
packed command based on the MMC software queue.

The basic concept of this function is that, we try to collect more
requests from block layer as much as possible to be linked into
MMC packed queue by mmc_blk_hsq_issue_rw_rq(). When the last
request of the hardware queue comes, or the collected request numbers
are larger than 16, or a larger request comes, then we can start to
pakage a packed request to host controller. The MMC packed function
also supplies packed algorithm operations to help to package qualified
requests. After finishing the packed request, the MMC packed function
will help to complete each request, at the same time, the MMC packed
queue will allow to collect more requests from block layer. After
completing each request, the MMC packed function can try to package
another packed request to host controller directly in the complete path,
if there are enough requests in MMC packed queue or the request pending
flag is not set. If the pending flag was set, we should let the
mmc_blk_hsq_issue_rw_rq() collect more request as much as possible.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/core/block.c      |  35 ++++--
 drivers/mmc/core/block.h      |   3 +-
 drivers/mmc/core/core.c       |  26 ++++
 drivers/mmc/core/core.h       |   2 +
 drivers/mmc/core/queue.c      |  22 +++-
 drivers/mmc/host/mmc_hsq.c    | 271 ++++++++++++++++++++++++++++++++++++------
 drivers/mmc/host/mmc_hsq.h    |  25 +++-
 drivers/mmc/host/sdhci-sprd.c |   2 +-
 include/linux/mmc/core.h      |   6 +
 include/linux/mmc/host.h      |   9 ++
 10 files changed, 351 insertions(+), 50 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 55d52fc..19c589e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1537,7 +1537,8 @@ static int mmc_blk_cqe_issue_flush(struct mmc_queue *mq, struct request *req)
 	return mmc_blk_cqe_start_req(mq->card->host, mrq);
 }
 
-static int mmc_blk_hsq_issue_rw_rq(struct mmc_queue *mq, struct request *req)
+static int mmc_blk_hsq_issue_rw_rq(struct mmc_queue *mq, struct request *req,
+				   bool last)
 {
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
 	struct mmc_host *host = mq->card->host;
@@ -1548,19 +1549,25 @@ static int mmc_blk_hsq_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 	mmc_pre_req(host, &mqrq->brq.mrq);
 
 	err = mmc_cqe_start_req(host, &mqrq->brq.mrq);
-	if (err)
+	if (err) {
 		mmc_post_req(host, &mqrq->brq.mrq, err);
+		return err;
+	}
 
-	return err;
+	if (last)
+		mmc_cqe_commit_rqs(host);
+
+	return 0;
 }
 
-static int mmc_blk_cqe_issue_rw_rq(struct mmc_queue *mq, struct request *req)
+static int mmc_blk_cqe_issue_rw_rq(struct mmc_queue *mq, struct request *req,
+				   bool last)
 {
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
 	struct mmc_host *host = mq->card->host;
 
 	if (host->hsq_enabled)
-		return mmc_blk_hsq_issue_rw_rq(mq, req);
+		return mmc_blk_hsq_issue_rw_rq(mq, req, last);
 
 	mmc_blk_data_prep(mq, mqrq, 0, NULL, NULL);
 
@@ -1959,6 +1966,18 @@ static void mmc_blk_hsq_req_done(struct mmc_request *mrq)
 	if (mmc_blk_rq_error(&mqrq->brq) ||
 	    mmc_blk_urgent_bkops_needed(mq, mqrq)) {
 		spin_lock_irqsave(&mq->lock, flags);
+		/*
+		 * The HSQ may complete more than one requests at one time
+		 * for the packed request mode. So if there is one recovery
+		 * request is pending, the following error requests just
+		 * should be completed directly, since we should not do
+		 * recovery continuously.
+		 */
+		if (mq->recovery_needed) {
+			spin_unlock_irqrestore(&mq->lock, flags);
+			goto out;
+		}
+
 		mq->recovery_needed = true;
 		mq->recovery_req = req;
 		spin_unlock_irqrestore(&mq->lock, flags);
@@ -1971,6 +1990,7 @@ static void mmc_blk_hsq_req_done(struct mmc_request *mrq)
 
 	mmc_blk_rw_reset_success(mq, req);
 
+out:
 	/*
 	 * Block layer timeouts race with completions which means the normal
 	 * completion path cannot be used during recovery.
@@ -2236,7 +2256,8 @@ static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host)
 	return mmc_blk_rw_wait(mq, NULL);
 }
 
-enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
+enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req,
+				    bool last)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
@@ -2280,7 +2301,7 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
 		case REQ_OP_READ:
 		case REQ_OP_WRITE:
 			if (mq->use_cqe)
-				ret = mmc_blk_cqe_issue_rw_rq(mq, req);
+				ret = mmc_blk_cqe_issue_rw_rq(mq, req, last);
 			else
 				ret = mmc_blk_mq_issue_rw_rq(mq, req);
 			break;
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 31153f6..8bfb89f 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -9,7 +9,8 @@
 
 enum mmc_issued;
 
-enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req);
+enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req,
+				    bool last);
 void mmc_blk_mq_complete(struct request *req);
 void mmc_blk_mq_recovery(struct mmc_queue *mq);
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index aa54d35..f96c0b1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -329,6 +329,7 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
 		}
 	}
 
+	INIT_LIST_HEAD(&mrq->list);
 	return 0;
 }
 
@@ -536,6 +537,31 @@ void mmc_cqe_post_req(struct mmc_host *host, struct mmc_request *mrq)
 }
 EXPORT_SYMBOL(mmc_cqe_post_req);
 
+/**
+ *	mmc_cqe_commit_rqs - Commit requests pending in CQE
+ *	@host: MMC host
+ *	@last: Indicate if the last request from block layer
+ */
+void mmc_cqe_commit_rqs(struct mmc_host *host)
+{
+	if (host->cqe_ops->cqe_commit_rqs)
+		host->cqe_ops->cqe_commit_rqs(host);
+}
+EXPORT_SYMBOL(mmc_cqe_commit_rqs);
+
+/**
+ *	mmc_cqe_is_busy - If CQE is busy or not
+ *	@host: MMC host
+ */
+bool mmc_cqe_is_busy(struct mmc_host *host)
+{
+	if (host->cqe_ops->cqe_is_busy)
+		return host->cqe_ops->cqe_is_busy(host);
+
+	return false;
+}
+EXPORT_SYMBOL(mmc_cqe_is_busy);
+
 /* Arbitrary 1 second timeout */
 #define MMC_CQE_RECOVERY_TIMEOUT	1000
 
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 575ac02..db81ba2 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -139,6 +139,8 @@ static inline void mmc_claim_host(struct mmc_host *host)
 int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq);
 void mmc_cqe_post_req(struct mmc_host *host, struct mmc_request *mrq);
 int mmc_cqe_recovery(struct mmc_host *host);
+void mmc_cqe_commit_rqs(struct mmc_host *host);
+bool mmc_cqe_is_busy(struct mmc_host *host);
 
 /**
  *	mmc_pre_req - Prepare for a new request
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 25bee3d..774ea82 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -285,11 +285,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 		}
 		break;
 	case MMC_ISSUE_ASYNC:
-		/*
-		 * For MMC host software queue, we only allow 2 requests in
-		 * flight to avoid a long latency.
-		 */
-		if (host->hsq_enabled && mq->in_flight[issue_type] > 2) {
+		if (mq->use_cqe && mmc_cqe_is_busy(host)) {
 			spin_unlock_irq(&mq->lock);
 			return BLK_STS_RESOURCE;
 		}
@@ -330,7 +326,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(req);
 
-	issued = mmc_blk_mq_issue_rq(mq, req);
+	issued = mmc_blk_mq_issue_rq(mq, req, bd->last);
 
 	switch (issued) {
 	case MMC_REQ_BUSY:
@@ -362,8 +358,19 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
+static void mmc_mq_commit_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	struct mmc_queue *mq = hctx->queue->queuedata;
+	struct mmc_card *card = mq->card;
+	struct mmc_host *host = card->host;
+
+	if (mq->use_cqe)
+		mmc_cqe_commit_rqs(host);
+}
+
 static const struct blk_mq_ops mmc_mq_ops = {
 	.queue_rq	= mmc_mq_queue_rq,
+	.commit_rqs	= mmc_mq_commit_rqs,
 	.init_request	= mmc_mq_init_request,
 	.exit_request	= mmc_mq_exit_request,
 	.complete	= mmc_blk_mq_complete,
@@ -390,6 +397,9 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 		     "merging was advertised but not possible");
 	blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
 
+	if (host->max_packed_reqs != 0)
+		blk_queue_max_batch_requests(mq->queue, host->max_packed_reqs);
+
 	if (mmc_card_mmc(card))
 		block_size = card->ext_csd.data_sector_size;
 
diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index aafc0d1..c0ba24e 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -9,6 +9,7 @@
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
 #include <linux/module.h>
 
 #include "mmc_hsq.h"
@@ -16,16 +17,46 @@
 #define HSQ_NUM_SLOTS	64
 #define HSQ_INVALID_TAG	HSQ_NUM_SLOTS
 
+#define HSQ_PACKED_FLUSH_BLOCKS	256
+
+/**
+ * mmc_hsq_packed_algo_rw - the algorithm to package read or write requests
+ * @mmc: the host controller
+ *
+ * TODO: we can add more condition to decide if we can package this
+ * request or not.
+ */
+void mmc_hsq_packed_algo_rw(struct mmc_host *mmc)
+{
+	struct mmc_hsq *hsq = mmc->cqe_private;
+	struct hsq_packed *packed = hsq->packed;
+	struct mmc_packed_request *prq = &packed->prq;
+	struct mmc_request *mrq, *t;
+	u32 i = 0;
+
+	list_for_each_entry_safe(mrq, t, &packed->list, list) {
+		if (++i > packed->max_entries)
+			break;
+
+		list_move_tail(&mrq->list, &prq->list);
+		prq->nr_reqs++;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_hsq_packed_algo_rw);
+
 static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 {
+	struct hsq_packed *packed = hsq->packed;
 	struct mmc_host *mmc = hsq->mmc;
 	struct hsq_slot *slot;
+	struct mmc_request *mrq;
 	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&hsq->lock, flags);
 
 	/* Make sure we are not already running a request now */
-	if (hsq->mrq) {
+	if (hsq->mrq || (packed && packed->prq.nr_reqs)) {
 		spin_unlock_irqrestore(&hsq->lock, flags);
 		return;
 	}
@@ -36,16 +67,58 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 		return;
 	}
 
-	slot = &hsq->slot[hsq->next_tag];
-	hsq->mrq = slot->mrq;
-	hsq->qcnt--;
+	if (packed) {
+		/* Try to package requests */
+		packed->ops->packed_algo(mmc);
+
+		packed->busy = true;
+		hsq->qcnt -= packed->prq.nr_reqs;
+	} else {
+		slot = &hsq->slot[hsq->next_tag];
+		hsq->mrq = slot->mrq;
+		hsq->qcnt--;
+	}
 
 	spin_unlock_irqrestore(&hsq->lock, flags);
 
-	if (mmc->ops->request_atomic)
-		mmc->ops->request_atomic(mmc, hsq->mrq);
-	else
-		mmc->ops->request(mmc, hsq->mrq);
+	if (!packed) {
+		if (mmc->ops->request_atomic)
+			mmc->ops->request_atomic(mmc, hsq->mrq);
+		else
+			mmc->ops->request(mmc, hsq->mrq);
+
+		return;
+	}
+
+	if (packed->ops->prepare_hardware) {
+		ret = packed->ops->prepare_hardware(mmc);
+		if (ret) {
+			pr_err("failed to prepare hardware\n");
+			goto error;
+		}
+	}
+
+	ret = packed->ops->packed_request(mmc, &packed->prq);
+	if (ret) {
+		pr_err("failed to packed requests\n");
+		goto error;
+	}
+
+	return;
+
+error:
+	spin_lock_irqsave(&hsq->lock, flags);
+
+	list_for_each_entry(mrq, &packed->prq.list, list) {
+		struct mmc_data *data = mrq->data;
+
+		data->error = ret;
+		data->bytes_xfered = 0;
+	}
+
+	spin_unlock_irqrestore(&hsq->lock, flags);
+
+	mmc_hsq_finalize_packed_request(mmc, &packed->prq);
 }
 
 static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
@@ -87,16 +160,21 @@ static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
 
 static void mmc_hsq_post_request(struct mmc_hsq *hsq)
 {
+	struct hsq_packed *packed = hsq->packed;
 	unsigned long flags;
 	int remains;
 
 	spin_lock_irqsave(&hsq->lock, flags);
 
 	remains = hsq->qcnt;
-	hsq->mrq = NULL;
+	if (packed) {
+		packed->prq.nr_reqs = 0;
+	} else {
+		hsq->mrq = NULL;
 
-	/* Update the next available tag to be queued. */
-	mmc_hsq_update_next_tag(hsq, remains);
+		/* Update the next available tag to be queued. */
+		mmc_hsq_update_next_tag(hsq, remains);
+	}
 
 	if (hsq->waiting_for_idle && !remains) {
 		hsq->waiting_for_idle = false;
@@ -111,10 +189,6 @@ static void mmc_hsq_post_request(struct mmc_hsq *hsq)
 
 	spin_unlock_irqrestore(&hsq->lock, flags);
 
-	 /*
-	  * Try to pump new request to host controller as fast as possible,
-	  * after completing previous request.
-	  */
 	if (remains > 0)
 		mmc_hsq_pump_requests(hsq);
 }
@@ -154,6 +228,91 @@ bool mmc_hsq_finalize_request(struct mmc_host *mmc, struct mmc_request *mrq)
 }
 EXPORT_SYMBOL_GPL(mmc_hsq_finalize_request);
 
+/**
+ * mmc_hsq_finalize_packed_request - finalize one packed request
+ * @mmc: the host controller
+ * @prq: the packed request need to be finalized
+ */
+void mmc_hsq_finalize_packed_request(struct mmc_host *mmc,
+				     struct mmc_packed_request *prq)
+{
+	struct mmc_hsq *hsq = mmc->cqe_private;
+	struct hsq_packed *packed = hsq->packed;
+	struct mmc_request *mrq, *t;
+	LIST_HEAD(head);
+	unsigned long flags;
+
+	if (!packed || !prq)
+		return;
+
+	if (packed->ops->unprepare_hardware &&
+	    packed->ops->unprepare_hardware(mmc))
+		pr_err("failed to unprepare hardware\n");
+
+	/*
+	 * Clear busy flag to allow collecting more requests into command
+	 * queue, but now we can not pump them to controller, we should wait
+	 * for all requests are completed. During the period of completing
+	 * requests, we should collect more requests from block layer as much
+	 * as possible.
+	 */
+	spin_lock_irqsave(&hsq->lock, flags);
+	list_splice_tail_init(&prq->list, &head);
+	packed->busy = false;
+	spin_unlock_irqrestore(&hsq->lock, flags);
+
+	list_for_each_entry_safe(mrq, t, &head, list) {
+		list_del(&mrq->list);
+
+		mmc_cqe_request_done(mmc, mrq);
+	}
+
+	mmc_hsq_post_request(hsq);
+}
+EXPORT_SYMBOL_GPL(mmc_hsq_finalize_packed_request);
+
+static void mmc_hsq_commit_rqs(struct mmc_host *mmc)
+{
+	struct mmc_hsq *hsq = mmc->cqe_private;
+	struct hsq_packed *packed = hsq->packed;
+
+	if (!packed)
+		return;
+
+	mmc_hsq_pump_requests(hsq);
+}
+
+static bool mmc_hsq_is_busy(struct mmc_host *mmc)
+{
+	struct mmc_hsq *hsq = mmc->cqe_private;
+	struct hsq_packed *packed = hsq->packed;
+	unsigned long flags;
+	bool busy;
+
+	spin_lock_irqsave(&hsq->lock, flags);
+
+	/*
+	 * For packed mode, when hardware is busy, we can only allow maximum
+	 * packed number requests to be ready in software queue to be queued
+	 * after previous packed request is completed, which avoiding long
+	 * latency.
+	 *
+	 * For non-packed mode, we can only allow 2 requests in flight to avoid
+	 * long latency.
+	 *
+	 * Otherwise return BLK_STS_RESOURCE to tell block layer to dispatch
+	 * requests later.
+	 */
+	if (packed)
+		busy = packed->busy && hsq->qcnt >= packed->max_entries;
+	else
+		busy = hsq->qcnt > 1;
+
+	spin_unlock_irqrestore(&hsq->lock, flags);
+
+	return busy;
+}
+
 static void mmc_hsq_recovery_start(struct mmc_host *mmc)
 {
 	struct mmc_hsq *hsq = mmc->cqe_private;
@@ -189,7 +348,8 @@ static void mmc_hsq_recovery_finish(struct mmc_host *mmc)
 static int mmc_hsq_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct mmc_hsq *hsq = mmc->cqe_private;
-	int tag = mrq->tag;
+	struct hsq_packed *packed = hsq->packed;
+	int nr_rqs = 0, tag = mrq->tag;
 
 	spin_lock_irq(&hsq->lock);
 
@@ -204,20 +364,37 @@ static int mmc_hsq_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return -EBUSY;
 	}
 
-	hsq->slot[tag].mrq = mrq;
+	hsq->qcnt++;
 
-	/*
-	 * Set the next tag as current request tag if no available
-	 * next tag.
-	 */
-	if (hsq->next_tag == HSQ_INVALID_TAG)
-		hsq->next_tag = tag;
+	if (packed) {
+		list_add_tail(&mrq->list, &packed->list);
 
-	hsq->qcnt++;
+		nr_rqs = hsq->qcnt;
+	} else {
+		hsq->slot[tag].mrq = mrq;
+
+		/*
+		 * Set the next tag as current request tag if no available
+		 * next tag.
+		 */
+		if (hsq->next_tag == HSQ_INVALID_TAG)
+			hsq->next_tag = tag;
+	}
 
 	spin_unlock_irq(&hsq->lock);
 
-	mmc_hsq_pump_requests(hsq);
+	/*
+	 * For non-packed request mode, we should pump requests as soon as
+	 * possible.
+	 *
+	 * For the packed request mode, if it is a larger request or the
+	 * request count is larger than the maximum packed number, we
+	 * should pump requests to controller. Otherwise we should try to
+	 * combine requests as much as we can.
+	 */
+	if (!packed || mrq->data->blocks > HSQ_PACKED_FLUSH_BLOCKS ||
+	    nr_rqs >= packed->max_entries)
+		mmc_hsq_pump_requests(hsq);
 
 	return 0;
 }
@@ -230,12 +407,17 @@ static void mmc_hsq_post_req(struct mmc_host *mmc, struct mmc_request *mrq)
 
 static bool mmc_hsq_queue_is_idle(struct mmc_hsq *hsq, int *ret)
 {
+	struct hsq_packed *packed = hsq->packed;
 	bool is_idle;
 
 	spin_lock_irq(&hsq->lock);
 
-	is_idle = (!hsq->mrq && !hsq->qcnt) ||
-		hsq->recovery_halt;
+	if (packed)
+		is_idle = (!packed->prq.nr_reqs && !hsq->qcnt) ||
+			hsq->recovery_halt;
+	else
+		is_idle = (!hsq->mrq && !hsq->qcnt) ||
+			hsq->recovery_halt;
 
 	*ret = hsq->recovery_halt ? -EBUSY : 0;
 	hsq->waiting_for_idle = !is_idle;
@@ -312,17 +494,38 @@ static int mmc_hsq_enable(struct mmc_host *mmc, struct mmc_card *card)
 	.cqe_wait_for_idle = mmc_hsq_wait_for_idle,
 	.cqe_recovery_start = mmc_hsq_recovery_start,
 	.cqe_recovery_finish = mmc_hsq_recovery_finish,
+	.cqe_is_busy = mmc_hsq_is_busy,
+	.cqe_commit_rqs = mmc_hsq_commit_rqs,
 };
 
-int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
+int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc,
+		 const struct hsq_packed_ops *ops, int max_packed)
 {
-	hsq->num_slots = HSQ_NUM_SLOTS;
-	hsq->next_tag = HSQ_INVALID_TAG;
+	if (ops && max_packed > 1) {
+		struct hsq_packed *packed;
+
+		packed = devm_kzalloc(mmc_dev(mmc), sizeof(struct hsq_packed),
+				      GFP_KERNEL);
+		if (!packed)
+			return -ENOMEM;
+
+		packed->ops = ops;
+		packed->max_entries = max_packed;
+		INIT_LIST_HEAD(&packed->list);
+		INIT_LIST_HEAD(&packed->prq.list);
+
+		hsq->packed = packed;
+		mmc->max_packed_reqs = max_packed;
+	} else {
+		hsq->num_slots = HSQ_NUM_SLOTS;
+		hsq->next_tag = HSQ_INVALID_TAG;
 
-	hsq->slot = devm_kcalloc(mmc_dev(mmc), hsq->num_slots,
-				 sizeof(struct hsq_slot), GFP_KERNEL);
-	if (!hsq->slot)
-		return -ENOMEM;
+		hsq->slot = devm_kcalloc(mmc_dev(mmc), hsq->num_slots,
+					 sizeof(struct hsq_slot),
+					 GFP_KERNEL);
+		if (!hsq->slot)
+			return -ENOMEM;
+	}
 
 	hsq->mmc = mmc;
 	hsq->mmc->cqe_private = hsq;
diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
index 18b9cf5..6fcc0dc 100644
--- a/drivers/mmc/host/mmc_hsq.h
+++ b/drivers/mmc/host/mmc_hsq.h
@@ -2,6 +2,23 @@
 #ifndef LINUX_MMC_HSQ_H
 #define LINUX_MMC_HSQ_H
 
+struct hsq_packed_ops {
+	void (*packed_algo)(struct mmc_host *mmc);
+	int (*prepare_hardware)(struct mmc_host *mmc);
+	int (*unprepare_hardware)(struct mmc_host *mmc);
+	int (*packed_request)(struct mmc_host *mmc,
+			      struct mmc_packed_request *prq);
+};
+
+struct hsq_packed {
+	bool busy;
+	int max_entries;
+
+	struct list_head list;
+	struct mmc_packed_request prq;
+	const struct hsq_packed_ops *ops;
+};
+
 struct hsq_slot {
 	struct mmc_request *mrq;
 };
@@ -20,11 +37,17 @@ struct mmc_hsq {
 	bool enabled;
 	bool waiting_for_idle;
 	bool recovery_halt;
+
+	struct hsq_packed *packed;
 };
 
-int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc);
+int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc,
+		 const struct hsq_packed_ops *ops, int max_packed);
 void mmc_hsq_suspend(struct mmc_host *mmc);
 int mmc_hsq_resume(struct mmc_host *mmc);
 bool mmc_hsq_finalize_request(struct mmc_host *mmc, struct mmc_request *mrq);
+void mmc_hsq_finalize_packed_request(struct mmc_host *mmc,
+				     struct mmc_packed_request *prq);
+void mmc_hsq_packed_algo_rw(struct mmc_host *mmc);
 
 #endif
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index ae9acb8..49afe1c 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -676,7 +676,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 		goto err_cleanup_host;
 	}
 
-	ret = mmc_hsq_init(hsq, host->mmc);
+	ret = mmc_hsq_init(hsq, host->mmc, NULL, 0);
 	if (ret)
 		goto err_cleanup_host;
 
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b7ba881..b1be983 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -165,6 +165,12 @@ struct mmc_request {
 	bool			cap_cmd_during_tfr;
 
 	int			tag;
+	struct list_head	list;
+};
+
+struct mmc_packed_request {
+	struct list_head list;
+	u32 nr_reqs;
 };
 
 struct mmc_card;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index db5e59c..04b45d0 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -216,6 +216,14 @@ struct mmc_cqe_ops {
 	 * will have zero data bytes transferred.
 	 */
 	void	(*cqe_recovery_finish)(struct mmc_host *host);
+
+	/* If CQE is busy or not. */
+	bool	(*cqe_is_busy)(struct mmc_host *host);
+	/*
+	 * Serve the purpose of kicking the hardware to handle pending
+	 * requests.
+	 */
+	void	(*cqe_commit_rqs)(struct mmc_host *host);
 };
 
 struct mmc_async_req {
@@ -385,6 +393,7 @@ struct mmc_host {
 	unsigned int		max_blk_size;	/* maximum size of one mmc block */
 	unsigned int		max_blk_count;	/* maximum number of blocks in one req */
 	unsigned int		max_busy_timeout; /* max busy timeout in ms */
+	unsigned int		max_packed_reqs;  /* max number of requests can be packed */
 
 	/* private data */
 	spinlock_t		lock;		/* lock for claim and bus ops */
-- 
1.9.1

