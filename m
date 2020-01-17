Return-Path: <SRS0=x5xE=3G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C76C33CB6
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 05:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914DA2083E
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 05:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3t8MkNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgAQFZU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jan 2020 00:25:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36397 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgAQFZU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jan 2020 00:25:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id a6so9385315plm.3;
        Thu, 16 Jan 2020 21:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LfrHsITNetIG3yUN3C/KhW6rZCIlb0Sw6Ji9i3uK3jU=;
        b=F3t8MkNk6YcOgEJWldTT7jbQONZI2hjPkKmsEAaoz972BOf7bc0xmQQIw2rA9uuG3J
         DL+honUv8J0wb6462sUozJRUorq9LYSId06jD3ripzwL+kzmOdMj4fF8LCd/L3r8xpYI
         ybRcV17d04iy94x0v+VGLcJ/7WBfB8FJKJeD3it5ryUwQXDl7rMAHZGEiifwzNrVUF3I
         IsS2pSmgqnLYSWPYIostnlZNnbVMtOPIEp9nVxcvnllHwQ7nw0c+moBSqeXXi65HubCE
         uw6C7omdX2NNDA35gOewQ6SomUwxy5xlTM3HpwHbpusfAPq3tkyaaT7XPHry9lItbCXP
         evDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LfrHsITNetIG3yUN3C/KhW6rZCIlb0Sw6Ji9i3uK3jU=;
        b=cSbeYloOB9ZmqyS/x4PCUI0Yl6CNa0yCOiaJdeDuoRciLrOAUZMfdIguyTqsacF6qS
         dulwbD2oqpya0NDTTRRfM5tlGPvROfwbwMqXfVi5cJsI5krVLCAYboQXxOws8eQTOKho
         Hz3z3SNDY7t3GmKL+lBKbuCkn35Nu64Iy9aVytZws1afOClQXSPc5+Rh0SsUH8DDjchb
         89GI57Tg5J3cx9tbBSCZ1kaEyTwuxEHVrIJv6JcJBdIFcav/U5pSqgJaVO9qGWRZZ2F3
         9Nqj/N3NE2AehIo7naAyJ7bopGGhcqtAqM/DKu4f3vpoQetTEV+iNpxPJNKcS7h+dySa
         NgCw==
X-Gm-Message-State: APjAAAXPobvXfaGGFk1wi9ba8gDMLM/6e+MyNlJ5KO7hsdkwmOee4eDE
        2CBp3r+xdXkYmSh3TSlP6dM=
X-Google-Smtp-Source: APXvYqxx8ImgmsBnmA4gbG8YSgdEYtM8H6KZ4V7H7LLxAXwANvjv1BTy8DSEsS6VEIwu9/KgbqGqZQ==
X-Received: by 2002:a17:902:968c:: with SMTP id n12mr43059077plp.144.1579238718895;
        Thu, 16 Jan 2020 21:25:18 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c26sm28844756pfj.101.2020.01.16.21.25.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jan 2020 21:25:18 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [RFC PATCH 2/8] block: Allow sending a batch of requests from the scheduler to hardware
Date:   Fri, 17 Jan 2020 13:24:21 +0800
Message-Id: <b0c8278946f8501f184e45fecb70a862e9c9b7b2.1579164455.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1579164455.git.baolin.wang7@gmail.com>
References: <cover.1579164455.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1579164455.git.baolin.wang7@gmail.com>
References: <cover.1579164455.git.baolin.wang7@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As we know, some SD/MMC host controllers can support packed request,
that means we can package several requests to host controller at one
time to improve performence. So the hardware driver expects the blk-mq
can dispatch a batch of requests at one time, and driver can use bd.last
to indicate if it is the last request in the batch to help to combine
requests as much as possible.

Thus we should add batch requests setting from the block driver to tell
the scheduler how many requests can be dispatched in a batch, as well
as changing the scheduler to dispatch more than one request if setting
the maximum batch requests number.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 block/bfq-iosched.c    |   32 +++++++++++++--------
 block/blk-mq.c         |    2 --
 block/blk-settings.c   |   13 +++++++++
 block/kyber-iosched.c  |   74 ++++++++++++++++++++++++++----------------------
 block/mq-deadline.c    |   20 +++++++++----
 include/linux/blkdev.h |    8 ++++++
 6 files changed, 95 insertions(+), 54 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index decabc4..bef1187 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4778,29 +4778,37 @@ static int bfq_dispatch_requests(struct blk_mq_hw_ctx *hctx,
 				 struct list_head *list)
 {
 	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
+	unsigned int batch_reqs = queue_max_batch_requests(hctx->queue) ? : 1;
 	struct request *rq;
 	struct bfq_queue *in_serv_queue;
 	bool waiting_rq, idle_timer_disabled;
+	int i;
 
-	spin_lock_irq(&bfqd->lock);
+	for (i = 0; i < batch_reqs; i++) {
+		spin_lock_irq(&bfqd->lock);
 
-	in_serv_queue = bfqd->in_service_queue;
-	waiting_rq = in_serv_queue && bfq_bfqq_wait_request(in_serv_queue);
+		in_serv_queue = bfqd->in_service_queue;
+		waiting_rq = in_serv_queue && bfq_bfqq_wait_request(in_serv_queue);
 
-	rq = __bfq_dispatch_request(hctx);
+		rq = __bfq_dispatch_request(hctx);
 
-	idle_timer_disabled =
-		waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
+		idle_timer_disabled =
+			waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
 
-	spin_unlock_irq(&bfqd->lock);
+		spin_unlock_irq(&bfqd->lock);
 
-	bfq_update_dispatch_stats(hctx->queue, rq, in_serv_queue,
-				  idle_timer_disabled);
+		bfq_update_dispatch_stats(hctx->queue, rq, in_serv_queue,
+					  idle_timer_disabled);
 
-	if (!rq)
-		return 0;
+		if (!rq) {
+			if (list_empty(list))
+				return 0;
 
-	list_add(&rq->queuelist, list);
+			return 1;
+		}
+
+		list_add(&rq->queuelist, list);
+	}
 
 	return 1;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 323c9cb..e9a6677 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1185,8 +1185,6 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	if (list_empty(list))
 		return false;
 
-	WARN_ON(!list_is_singular(list) && got_budget);
-
 	/*
 	 * Now process all the entries, sending them to the driver.
 	 */
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 5f6dcc7..29e3a3c 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -59,6 +59,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->io_opt = 0;
 	lim->misaligned = 0;
 	lim->zoned = BLK_ZONED_NONE;
+	lim->max_batch_reqs = 1;
 }
 EXPORT_SYMBOL(blk_set_default_limits);
 
@@ -871,6 +872,18 @@ bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_queue_can_use_dma_map_merging);
 
+/**
+ * blk_queue_max_batch_requests - set max requests for batch processing
+ * @q:	the request queue for the device
+ * @max_batch_requests: maximum number of requests in a batch
+ **/
+void blk_queue_max_batch_requests(struct request_queue *q,
+				  unsigned int max_batch_requests)
+{
+	q->limits.max_batch_reqs = max_batch_requests;
+}
+EXPORT_SYMBOL(blk_queue_max_batch_requests);
+
 static int __init blk_settings_init(void)
 {
 	blk_max_low_pfn = max_low_pfn - 1;
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 8f58434..3a84a5f 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -801,50 +801,56 @@ static int kyber_dispatch_requests(struct blk_mq_hw_ctx *hctx,
 {
 	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
 	struct kyber_hctx_data *khd = hctx->sched_data;
+	unsigned int batch_reqs = queue_max_batch_requests(hctx->queue) ? : 1;
 	struct request *rq;
-	int i, ret = 0;
+	int i, j, ret = 0;
 
 	spin_lock(&khd->lock);
 
-	/*
-	 * First, if we are still entitled to batch, try to dispatch a request
-	 * from the batch.
-	 */
-	if (khd->batching < kyber_batch_size[khd->cur_domain]) {
-		rq = kyber_dispatch_cur_domain(kqd, khd, hctx);
-		if (rq) {
-			list_add(&rq->queuelist, list);
-			ret = 1;
-			goto out;
+	for (j = 0; j < batch_reqs; j++) {
+		/*
+		 * First, if we are still entitled to batch, try to dispatch a
+		 * request from the batch.
+		 */
+		if (khd->batching < kyber_batch_size[khd->cur_domain]) {
+			rq = kyber_dispatch_cur_domain(kqd, khd, hctx);
+			if (rq) {
+				list_add(&rq->queuelist, list);
+				ret = 1;
+				continue;
+			}
 		}
-	}
-
-	/*
-	 * Either,
-	 * 1. We were no longer entitled to a batch.
-	 * 2. The domain we were batching didn't have any requests.
-	 * 3. The domain we were batching was out of tokens.
-	 *
-	 * Start another batch. Note that this wraps back around to the original
-	 * domain if no other domains have requests or tokens.
-	 */
-	khd->batching = 0;
-	for (i = 0; i < KYBER_NUM_DOMAINS; i++) {
-		if (khd->cur_domain == KYBER_NUM_DOMAINS - 1)
-			khd->cur_domain = 0;
-		else
-			khd->cur_domain++;
 
-		rq = kyber_dispatch_cur_domain(kqd, khd, hctx);
-		if (rq) {
-			list_add(&rq->queuelist, list);
-			ret = 1;
-			goto out;
+		/*
+		 * Either,
+		 * 1. We were no longer entitled to a batch.
+		 * 2. The domain we were batching didn't have any requests.
+		 * 3. The domain we were batching was out of tokens.
+		 *
+		 * Start another batch. Note that this wraps back around to the
+		 * original domain if no other domains have requests or tokens.
+		 */
+		khd->batching = 0;
+		for (i = 0; i < KYBER_NUM_DOMAINS; i++) {
+			if (khd->cur_domain == KYBER_NUM_DOMAINS - 1)
+				khd->cur_domain = 0;
+			else
+				khd->cur_domain++;
+
+			rq = kyber_dispatch_cur_domain(kqd, khd, hctx);
+			if (rq) {
+				list_add(&rq->queuelist, list);
+				ret = 1;
+				break;
+			}
 		}
 	}
 
-out:
 	spin_unlock(&khd->lock);
+
+	if (list_empty(list))
+		ret = 0;
+
 	return ret;
 }
 
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 9fbffba..4e3d58a 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -382,16 +382,24 @@ static int dd_dispatch_requests(struct blk_mq_hw_ctx *hctx,
 				struct list_head *list)
 {
 	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
+	unsigned int batch_reqs = queue_max_batch_requests(hctx->queue) ? : 1;
 	struct request *rq;
+	int i;
 
-	spin_lock(&dd->lock);
-	rq = __dd_dispatch_request(dd);
-	spin_unlock(&dd->lock);
+	for (i = 0; i < batch_reqs; i++) {
+		spin_lock(&dd->lock);
+		rq = __dd_dispatch_request(dd);
+		spin_unlock(&dd->lock);
 
-	if (!rq)
-		return 0;
+		if (!rq) {
+			if (list_empty(list))
+				return 0;
 
-	list_add(&rq->queuelist, list);
+			return 1;
+		}
+
+		list_add(&rq->queuelist, list);
+	}
 
 	return 1;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 47eb22a..9043fdb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -337,6 +337,7 @@ struct queue_limits {
 	unsigned int		max_write_zeroes_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
+	unsigned int		max_batch_reqs;
 
 	unsigned short		logical_block_size;
 	unsigned short		max_segments;
@@ -1109,6 +1110,8 @@ extern void blk_queue_required_elevator_features(struct request_queue *q,
 						 unsigned int features);
 extern bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
 					      struct device *dev);
+extern void blk_queue_max_batch_requests(struct request_queue *q,
+					 unsigned int max_batch_requests);
 
 /*
  * Number of physical segments as sent to the device.
@@ -1291,6 +1294,11 @@ static inline unsigned int queue_max_segment_size(const struct request_queue *q)
 	return q->limits.max_segment_size;
 }
 
+static inline unsigned int queue_max_batch_requests(const struct request_queue *q)
+{
+	return q->limits.max_batch_reqs;
+}
+
 static inline unsigned short queue_logical_block_size(const struct request_queue *q)
 {
 	int retval = 512;
-- 
1.7.9.5

