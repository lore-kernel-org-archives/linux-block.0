Return-Path: <SRS0=zlmp=6K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9501C5519A
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 09:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51CC2087E
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 09:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S58GWRer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgDZJjf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Apr 2020 05:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgDZJje (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 05:39:34 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380F3C061A0C;
        Sun, 26 Apr 2020 02:39:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o10so7116509pgb.6;
        Sun, 26 Apr 2020 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=O68jjGyRboDt3RpjelWxMIOKc5rND+7nYtC2JtEbYhI=;
        b=S58GWRerYTMUqdixE/7LuoEHCmYd9zHWQ2q1MkOQdCY+/Wm5lk+hQ3SbPEH0vax7GQ
         WOikA6wkcbz9GJYTCc1/0qwvJ/TPhjfKTAqZ4+Uea+QXJ4ZaqTC9S1GDs2OeXuiWei7Y
         UmCLxI8H3wqnFnJRAgyEWWOyRlu/dQanpguKPgslSeR1JNbJcHaNMIsMs4oWvWL8obCg
         4J2R9hJQjNvX7/X1h6XgnoRIACx5eQVL4cVeNIkuITAKyqI3Qy7eIPUz31a50jf+l4CB
         6TFU7pKaWfhqpSVKhSBWOFjGyZfyOANsePqF8kQ7A1y8FJ8CuNQz/mpjbEUkUzFPXv4g
         piPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=O68jjGyRboDt3RpjelWxMIOKc5rND+7nYtC2JtEbYhI=;
        b=nJT1aKn+ExAZX9GPSXZ/oyDp2IMaa8ZleWt/wRy1RdZKab0Xui2kdG5f/2cuf3Iw+Y
         OKfVADk99IBr7VyX11C4Q903D9SBH4iT7Mzohu9uN4f6Wy1zVY+E8U4jVQHAXHT3+H4i
         vs+YHuOx+BGotaU5RYgB4oiO0ZKzbREtDStj8zJ8VrLKxyfBH6ffz5sdLPITeLbBc5va
         T/OSeSY4+nw5p0uyHwIzBmu7nweuos87K4Oh3kbcfyNYLY1H/8+zLI9ZZy+NBEcT1xOb
         PsZQJf2+DeA1uhyGJG40vbFt4jRYB003kGAlfnUsOYGMrAEFEAVF46i5pp0Wth3oF0Hp
         rjPw==
X-Gm-Message-State: AGi0Pubbyv0YAuX8EdgzwXPSJXW4lF94aSs7rQ8/DZwuuiSqYi01hz6x
        FxTayXpB1+/uzSGvKVWUn6o=
X-Google-Smtp-Source: APiQypLM/PgmRxNSCYiRJ5BdMB2PmOjj6DNJDTZN5D40LVvm9JqzbjywdySGPFcEVmwYY4/tv+bq3w==
X-Received: by 2002:a63:2b52:: with SMTP id r79mr17091993pgr.261.1587893971525;
        Sun, 26 Apr 2020 02:39:31 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id m129sm1835245pga.47.2020.04.26.02.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 02:39:30 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     arnd@arndb.de, linus.walleij@linaro.org, paolo.valente@linaro.org,
        ming.lei@redhat.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/7] mmc: Add MMC packed request support for MMC software queue
Date:   Sun, 26 Apr 2020 17:38:55 +0800
Message-Id: <bfc499b319abfcfcdb7a76e7825e0290e1d35287.1587888520.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587888520.git.baolin.wang7@gmail.com>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1587888520.git.baolin.wang7@gmail.com>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
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
 drivers/mmc/core/block.c      |  14 ++
 drivers/mmc/core/core.c       |  26 +++
 drivers/mmc/core/core.h       |   2 +
 drivers/mmc/core/queue.c      |  19 ++-
 drivers/mmc/host/mmc_hsq.c    | 292 +++++++++++++++++++++++++++++-----
 drivers/mmc/host/mmc_hsq.h    |  25 ++-
 drivers/mmc/host/sdhci-sprd.c |   2 +-
 include/linux/mmc/core.h      |   6 +
 include/linux/mmc/host.h      |   9 ++
 9 files changed, 345 insertions(+), 50 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8499b56a15a8..528db34c60b0 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1907,6 +1907,19 @@ static void mmc_blk_hsq_req_done(struct mmc_request *mrq)
 	if (mmc_blk_rq_error(&mqrq->brq) ||
 	    mmc_blk_urgent_bkops_needed(mq, mqrq)) {
 		spin_lock_irqsave(&mq->lock, flags);
+
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
@@ -1919,6 +1932,7 @@ static void mmc_blk_hsq_req_done(struct mmc_request *mrq)
 
 	mmc_blk_rw_reset_success(mq, req);
 
+out:
 	/*
 	 * Block layer timeouts race with completions which means the normal
 	 * completion path cannot be used during recovery.
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4c5de6d37ac7..85d40dbc204e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -329,6 +329,7 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
 		}
 	}
 
+	INIT_LIST_HEAD(&mrq->list);
 	return 0;
 }
 
@@ -519,6 +520,31 @@ void mmc_cqe_post_req(struct mmc_host *host, struct mmc_request *mrq)
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
index 575ac0257af2..db81ba27bcf4 100644
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
index 25bee3daf9e2..8e63e3d1c8d1 100644
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
@@ -451,6 +458,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 		mq->tag_set.queue_depth = MMC_QUEUE_DEPTH;
 	mq->tag_set.numa_node = NUMA_NO_NODE;
 	mq->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
+	if (host->max_packed_reqs > 0)
+		mq->tag_set.flags |= BLK_MQ_F_FORCE_COMMIT_RQS;
 	mq->tag_set.nr_hw_queues = 1;
 	mq->tag_set.cmd_size = sizeof(struct mmc_queue_req);
 	mq->tag_set.driver_data = mq;
diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index a5e05ed0fda3..d1e871bf4fc2 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -9,6 +9,7 @@
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
 #include <linux/module.h>
 
 #include "mmc_hsq.h"
@@ -16,6 +17,33 @@
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
 static void mmc_hsq_retry_handler(struct work_struct *work)
 {
 	struct mmc_hsq *hsq = container_of(work, struct mmc_hsq, retry_work);
@@ -26,15 +54,17 @@ static void mmc_hsq_retry_handler(struct work_struct *work)
 
 static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 {
+	struct hsq_packed *packed = hsq->packed;
 	struct mmc_host *mmc = hsq->mmc;
 	struct hsq_slot *slot;
+	struct mmc_request *mrq;
 	unsigned long flags;
 	int ret = 0;
 
 	spin_lock_irqsave(&hsq->lock, flags);
 
 	/* Make sure we are not already running a request now */
-	if (hsq->mrq) {
+	if (hsq->mrq || (packed && packed->prq.nr_reqs)) {
 		spin_unlock_irqrestore(&hsq->lock, flags);
 		return;
 	}
@@ -45,30 +75,72 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
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
-		ret = mmc->ops->request_atomic(mmc, hsq->mrq);
-	else
-		mmc->ops->request(mmc, hsq->mrq);
+	if (!packed) {
+		if (mmc->ops->request_atomic)
+			ret = mmc->ops->request_atomic(mmc, hsq->mrq);
+		else
+			mmc->ops->request(mmc, hsq->mrq);
+
+		/*
+		 * If returning BUSY from request_atomic(), which means the card
+		 * may be busy now, and we should change to non-atomic context to
+		 * try again for this unusual case, to avoid time-consuming operations
+		 * in the atomic context.
+		 *
+		 * Note: we just give a warning for other error cases, since the host
+		 * driver will handle them.
+		 */
+		if (ret == -EBUSY)
+			schedule_work(&hsq->retry_work);
+		else
+			WARN_ON_ONCE(ret);
 
-	/*
-	 * If returning BUSY from request_atomic(), which means the card
-	 * may be busy now, and we should change to non-atomic context to
-	 * try again for this unusual case, to avoid time-consuming operations
-	 * in the atomic context.
-	 *
-	 * Note: we just give a warning for other error cases, since the host
-	 * driver will handle them.
-	 */
-	if (ret == -EBUSY)
-		schedule_work(&hsq->retry_work);
-	else
-		WARN_ON_ONCE(ret);
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
@@ -110,16 +182,21 @@ static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
 
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
@@ -177,6 +254,91 @@ bool mmc_hsq_finalize_request(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -212,7 +374,8 @@ static void mmc_hsq_recovery_finish(struct mmc_host *mmc)
 static int mmc_hsq_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct mmc_hsq *hsq = mmc->cqe_private;
-	int tag = mrq->tag;
+	struct hsq_packed *packed = hsq->packed;
+	int nr_rqs = 0, tag = mrq->tag;
 
 	spin_lock_irq(&hsq->lock);
 
@@ -227,20 +390,37 @@ static int mmc_hsq_request(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -253,12 +433,17 @@ static void mmc_hsq_post_req(struct mmc_host *mmc, struct mmc_request *mrq)
 
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
@@ -335,17 +520,38 @@ static const struct mmc_cqe_ops mmc_hsq_ops = {
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
index ffdd9cd172c3..8b416ec796a9 100644
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
@@ -21,11 +38,17 @@ struct mmc_hsq {
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
index bc7a8cb84862..ad0981e19571 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -669,7 +669,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 		goto err_cleanup_host;
 	}
 
-	ret = mmc_hsq_init(hsq, host->mmc);
+	ret = mmc_hsq_init(hsq, host->mmc, NULL, 0);
 	if (ret)
 		goto err_cleanup_host;
 
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 29aa50711626..4267e90905f2 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -162,6 +162,12 @@ struct mmc_request {
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
index d4a50e5dc111..bb8bcc4b0687 100644
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
@@ -388,6 +396,7 @@ struct mmc_host {
 	unsigned int		max_blk_size;	/* maximum size of one mmc block */
 	unsigned int		max_blk_count;	/* maximum number of blocks in one req */
 	unsigned int		max_busy_timeout; /* max busy timeout in ms */
+	unsigned int		max_packed_reqs;  /* max number of requests can be packed */
 
 	/* private data */
 	spinlock_t		lock;		/* lock for claim and bus ops */
-- 
2.17.1

