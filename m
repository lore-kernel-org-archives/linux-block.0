Return-Path: <SRS0=UGhi=5B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994BEC18E5B
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7EF2073E
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 10:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PortRNUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbgCPKBs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:01:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40982 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbgCPKBq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 06:01:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so746858plr.8;
        Mon, 16 Mar 2020 03:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kgihqax6YeVrCLuO9o57/Db7OP77DO8IEq6SMDC5Qo8=;
        b=PortRNULQehrdmz+1FjlpE+FsZhu8X5GiKYISyqGV8WLLJR6gDJp+0LK1eSi3qTS/b
         DblqcKk1vVUDBY/g/5CSwFNEsRvG9SHOWDkeMbO31qwg0m7IcZpdYFFnTo7kXy7ajWad
         WkY5FPflcExVdKbLeB7ycKHqi7f41tF2TNbVtPQgpYRiUe94kd0P1DTajdn5gGHZrAOw
         U+ABDadCN0+WhuE/N7LQhDcL8uA9Mm/9Wgji6/XAyxupjV4N6uiraCaKXy/YyG6MgFSu
         gfebjTCjiznZ3lAEXUhPkSYQArVEsGQlxTxO7R19Jn3LYUyqeqg+NDukZAOduHQR5cUw
         Yesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kgihqax6YeVrCLuO9o57/Db7OP77DO8IEq6SMDC5Qo8=;
        b=kReQwzjxIcMUKF9Xjm9l8D7INPSjzKSa4PdPXsfsu/M5YUhJu7feEFlf4Wzu2Ddo3N
         n1ZWqGA1FVXg25hGETmHiwb7WYP26R7L7lEHMVGvtdKeW/BB6lT9SdRy4AltBTIayN/+
         Un57ld7IJzFR2l5iQBhbudQeq0cCvkR8vuVvQ6qsfzBn3W2F3O4YvG67iKLEAEem/YWj
         vYGF2L3ExsZLcDieIZg/EkCmTn+4GhqwBxgZn+J/vVhQO0Wv6C8KhCKeZ390OT6alAgF
         waYHNs9P0fK7yNC3UXY0tsaOEG+NDSitmHab340oXJlnZSBFOTx+seHVJh57ilQwdpju
         ygFA==
X-Gm-Message-State: ANhLgQ3TTVeL7s4aISdSD/iT2r5OSt3QrzdRGH5s66XPd/1OBZfPEs/c
        iHQcPlKBqKvEu803MSRLqDDduP1i
X-Google-Smtp-Source: ADFU+vvnsLXtTZlSGMbwwvTQ6Lw0KA0Xp8VXqWdE7tOLnB7L0w2mToRedqylW/p5JhGioHwpWJEJsQ==
X-Received: by 2002:a17:90b:1a8f:: with SMTP id ng15mr21129827pjb.55.1584352906128;
        Mon, 16 Mar 2020 03:01:46 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 136sm63970411pgh.26.2020.03.16.03.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 03:01:45 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk, paolo.valente@linaro.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     ming.lei@redhat.com, arnd@arndb.de, linus.walleij@linaro.org,
        baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH 2/8] block: Allow sending a batch of requests from the scheduler to hardware
Date:   Mon, 16 Mar 2020 18:01:19 +0800
Message-Id: <c2e62e5a9942fb833dfc0cdc8c967a12f3c34b03.1584350380.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584350380.git.baolin.wang7@gmail.com>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584350380.git.baolin.wang7@gmail.com>
References: <cover.1584350380.git.baolin.wang7@gmail.com>
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
 block/bfq-iosched.c    | 32 ++++++++++++++--------
 block/blk-mq.c         |  2 --
 block/blk-settings.c   | 13 +++++++++
 block/kyber-iosched.c  | 74 +++++++++++++++++++++++++++-----------------------
 block/mq-deadline.c    | 20 ++++++++++----
 include/linux/blkdev.h |  8 ++++++
 6 files changed, 95 insertions(+), 54 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d7a128e..9c1e3aa 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4793,29 +4793,37 @@ static int bfq_dispatch_requests(struct blk_mq_hw_ctx *hctx,
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
index a12b176..2588e7a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1193,8 +1193,6 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	if (list_empty(list))
 		return false;
 
-	WARN_ON(!list_is_singular(list) && got_budget);
-
 	/*
 	 * Now process all the entries, sending them to the driver.
 	 */
diff --git a/block/blk-settings.c b/block/blk-settings.c
index c8eda2e..8c0b325 100644
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
index 053ea4b..d7032a0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -338,6 +338,7 @@ struct queue_limits {
 	unsigned int		max_write_zeroes_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
+	unsigned int		max_batch_reqs;
 
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
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
 static inline unsigned queue_logical_block_size(const struct request_queue *q)
 {
 	int retval = 512;
-- 
1.9.1

