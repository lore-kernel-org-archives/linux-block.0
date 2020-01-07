Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A439C33C9E
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 16:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6AB2087F
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 16:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="StTWK5U+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgAGQaq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:30:46 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33426 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgAGQaq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 11:30:46 -0500
Received: by mail-io1-f65.google.com with SMTP id z8so53227185ioh.0
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 08:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=808gT1Y36I+X7TMZYPU45C+Csxwz1EcBkhYsh3Skylk=;
        b=StTWK5U+ZGQ75LHJE4RH6XoqfqgcsYnjhD1TzhIOcpU1mmGQ1rGZQVsPSdzwhliZoZ
         9K91Aald6wXDbq08cVBr246D0mIs52iirxhpu8S0UxjtmVUcj+DyMnHUIXzP5oCeSjHu
         AwEB56Uab2iVRy29XJSML+XqIrTRbTMzuT+uPPIlCK+t6wIxO79wD3cPpMd92joRbB0i
         Fl1s1gQmLqQqxfAN7w+eIwxabMGVnloR6HS+zW5HX3njSKl3FSoeA6ANZRxZb9Upkdoc
         cLln7Jfp2epf5etFQDg7gGRqAkqSzb/G+NJsGPv1AGCqFG8kfokNrf07A/YsSeFVVjU5
         1bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=808gT1Y36I+X7TMZYPU45C+Csxwz1EcBkhYsh3Skylk=;
        b=W9di0Ioanm+VZgCSMKjygwAO8PhSErFLD2IFaoLmown4xzJ6O6CK6S0vVNZ3pqCB7E
         nVTJ93AYI8vwE/22imhaGbgPQpPpDyrEWfe+zIohbsSI/HUPNe8nEi1nyAs+UKvbnrHs
         DHysMgAXAA+ikNUDMyBRgFB+EplewFaO96GOQa16gLvbnMTdbi7cfh3mMTb0iDoqrnhd
         4E4wks63AZrZrkPrceDQfPjbUE88sq9NlXdXhYdqkiVjzLwlP+0aed5XojItLcJqYTGZ
         wBaQ8rJALm1XCIKPxxCNByQgTf68YieyaaafOJUxV21awXt5G8bRYxsX9I0bZ/ZuKn4+
         ULvQ==
X-Gm-Message-State: APjAAAXmT6j8ivWQ/rRPvmwJ0lhxdv3bx/z6gkrkBvehgmEVz1/lXHcd
        RXpuSzWbVsERWI3HU1SA8izOztyXQvc=
X-Google-Smtp-Source: APXvYqwo30c7CbCIlI7Zaq+uTanp84LdWXc8wSuPdWZ53O0AiXTLC25EMzBpuHC5Bx2JUOvzRuZsfQ==
X-Received: by 2002:a05:6602:153:: with SMTP id v19mr73047222iot.290.1578414645128;
        Tue, 07 Jan 2020 08:30:45 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w11sm20639ilh.55.2020.01.07.08.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:30:44 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] blk-mq: allocate tags in batches
Date:   Tue,  7 Jan 2020 09:30:37 -0700
Message-Id: <20200107163037.31745-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107163037.31745-1-axboe@kernel.dk>
References: <20200107163037.31745-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of grabbing tags one by one, grab a batch and store the local
cache in the software queue. Then subsequent tag allocations can just
grab free tags from there, without having to hit the shared tag map.

We flush these batches out if we run out of tags on the hardware queue.
The intent here is this should rarely happen.

This works very well in practice, with anywhere from 40-60 batch counts
seen regularly in testing.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-debugfs.c |  18 +++++++
 block/blk-mq-tag.c     | 104 ++++++++++++++++++++++++++++++++++++++++-
 block/blk-mq-tag.h     |   3 ++
 block/blk-mq.c         |  16 +++++--
 block/blk-mq.h         |   5 ++
 include/linux/blk-mq.h |   2 +
 6 files changed, 144 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index e789f830ff59..914be72d080e 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -659,6 +659,23 @@ CTX_RQ_SEQ_OPS(default, HCTX_TYPE_DEFAULT);
 CTX_RQ_SEQ_OPS(read, HCTX_TYPE_READ);
 CTX_RQ_SEQ_OPS(poll, HCTX_TYPE_POLL);
 
+static ssize_t ctx_tag_hit_write(void *data, const char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	struct blk_mq_ctx *ctx = data;
+
+	ctx->tag_hit = ctx->tag_refill = 0;
+	return count;
+}
+
+static int ctx_tag_hit_show(void *data, struct seq_file *m)
+{
+	struct blk_mq_ctx *ctx = data;
+
+	seq_printf(m, "hit=%lu refills=%lu\n", ctx->tag_hit, ctx->tag_refill);
+	return 0;
+}
+
 static int ctx_dispatched_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_ctx *ctx = data;
@@ -800,6 +817,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 	{"read_rq_list", 0400, .seq_ops = &ctx_read_rq_list_seq_ops},
 	{"poll_rq_list", 0400, .seq_ops = &ctx_poll_rq_list_seq_ops},
 	{"dispatched", 0600, ctx_dispatched_show, ctx_dispatched_write},
+	{"tag_hit", 0600, ctx_tag_hit_show, ctx_tag_hit_write},
 	{"merged", 0600, ctx_merged_show, ctx_merged_write},
 	{"completed", 0600, ctx_completed_show, ctx_completed_write},
 	{},
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index fbacde454718..94c1f16c6c71 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -99,6 +99,100 @@ static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 		return __sbitmap_queue_get(bt);
 }
 
+static void ctx_flush_ipi(void *data)
+{
+	struct blk_mq_hw_ctx *hctx = data;
+	struct sbitmap_queue *bt = &hctx->tags->bitmap_tags;
+	struct blk_mq_ctx *ctx;
+	unsigned int i;
+
+	ctx = __blk_mq_get_ctx(hctx->queue, smp_processor_id());
+
+	for (i = 0; i < hctx->queue->tag_set->nr_maps; i++) {
+		struct blk_mq_ctx_type *type = &ctx->type[i];
+
+		if (!type->tags)
+			continue;
+
+		__sbitmap_queue_clear_batch(bt, type->tag_offset, type->tags);
+		type->tags = 0;
+	}
+	atomic_dec(&hctx->flush_pending);
+}
+
+void blk_mq_tag_ctx_flush_batch(struct blk_mq_hw_ctx *hctx,
+				struct blk_mq_ctx *ctx)
+{
+	atomic_inc(&hctx->flush_pending);
+	smp_call_function_single(ctx->cpu, ctx_flush_ipi, hctx, false);
+}
+
+static void blk_mq_tag_flush_batches(struct blk_mq_hw_ctx *hctx)
+{
+	if (atomic_cmpxchg(&hctx->flush_pending, 0, hctx->nr_ctx))
+		return;
+	preempt_disable();
+	if (cpumask_test_cpu(smp_processor_id(), hctx->cpumask))
+		ctx_flush_ipi(hctx);
+	smp_call_function_many(hctx->cpumask, ctx_flush_ipi, hctx, false);
+	preempt_enable();
+}
+
+void blk_mq_tag_queue_flush_batches(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		blk_mq_tag_flush_batches(hctx);
+}
+
+static int blk_mq_get_tag_batch(struct blk_mq_alloc_data *data)
+{
+	struct blk_mq_hw_ctx *hctx = data->hctx;
+	struct blk_mq_ctx_type *type;
+	struct blk_mq_ctx *ctx = data->ctx;
+	struct blk_mq_tags *tags;
+	struct sbitmap_queue *bt;
+	int tag = -1;
+
+	if (!ctx || (data->flags & BLK_MQ_REQ_INTERNAL))
+		return -1;
+
+	tags = hctx->tags;
+	bt = &tags->bitmap_tags;
+	/* don't do batches for round-robin or (very) sparse maps */
+	if (bt->round_robin || bt->sb.shift < ilog2(BITS_PER_LONG) - 1)
+		return -1;
+
+	/* we could make do with preempt disable, but we need to block flush */
+	local_irq_disable();
+	if (unlikely(ctx->cpu != smp_processor_id()))
+		goto out;
+
+	type = &ctx->type[hctx->type];
+
+	if (type->tags) {
+get_tag:
+		ctx->tag_hit++;
+
+		tag = __ffs(type->tags);
+		type->tags &= ~(1UL << tag);
+		tag += type->tag_offset;
+out:
+		local_irq_enable();
+		return tag;
+	}
+
+	/* no current tag cache, attempt to refill a batch */
+	if (!__sbitmap_queue_get_batch(bt, &type->tag_offset, &type->tags)) {
+		ctx->tag_refill++;
+		goto get_tag;
+	}
+
+	goto out;
+}
+
 unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 {
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
@@ -116,8 +210,13 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		bt = &tags->breserved_tags;
 		tag_offset = 0;
 	} else {
-		bt = &tags->bitmap_tags;
 		tag_offset = tags->nr_reserved_tags;
+
+		tag = blk_mq_get_tag_batch(data);
+		if (tag != -1)
+			goto found_tag;
+
+		bt = &tags->bitmap_tags;
 	}
 
 	tag = __blk_mq_get_tag(data, bt);
@@ -152,6 +251,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != -1)
 			break;
 
+		if (!(data->flags & BLK_MQ_REQ_RESERVED))
+			blk_mq_tag_flush_batches(data->hctx);
+
 		bt_prev = bt;
 		io_schedule();
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 15bc74acb57e..b5964fff1630 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -34,6 +34,9 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
+void blk_mq_tag_queue_flush_batches(struct request_queue *q);
+void blk_mq_tag_ctx_flush_batch(struct blk_mq_hw_ctx *hctx,
+				struct blk_mq_ctx *ctx);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 						 struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cc48a0ffa5ec..81140f61a7c9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2255,6 +2255,8 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
 	type = hctx->type;
 
+	blk_mq_tag_ctx_flush_batch(hctx, ctx);
+
 	spin_lock(&ctx->lock);
 	if (!list_empty(&ctx->type[type].rq_list)) {
 		list_splice_init(&ctx->type[type].rq_list, &tmp);
@@ -2436,8 +2438,10 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 
 		__ctx->cpu = i;
 		spin_lock_init(&__ctx->lock);
-		for (k = HCTX_TYPE_DEFAULT; k < HCTX_MAX_TYPES; k++)
+		for (k = HCTX_TYPE_DEFAULT; k < HCTX_MAX_TYPES; k++) {
 			INIT_LIST_HEAD(&__ctx->type[k].rq_list);
+			__ctx->type[k].tags = 0;
+		}
 
 		/*
 		 * Set local node, IFF we have more than one hw queue. If
@@ -2521,6 +2525,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 			}
 
 			hctx = blk_mq_map_queue_type(q, j, i);
+			ctx->type[j].tags = 0;
 			ctx->hctxs[j] = hctx;
 			/*
 			 * If the CPU is already set in the mask, then we've
@@ -2542,9 +2547,11 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 			BUG_ON(!hctx->nr_ctx);
 		}
 
-		for (; j < HCTX_MAX_TYPES; j++)
+		for (; j < HCTX_MAX_TYPES; j++) {
 			ctx->hctxs[j] = blk_mq_map_queue_type(q,
 					HCTX_TYPE_DEFAULT, i);
+			ctx->type[j].tags = 0;
+		}
 	}
 
 	queue_for_each_hw_ctx(q, hctx, i) {
@@ -3298,8 +3305,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	if (nr_hw_queues < 1 || nr_hw_queues == set->nr_hw_queues)
 		return;
 
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		blk_mq_tag_queue_flush_batches(q);
 		blk_mq_freeze_queue(q);
+	}
+
 	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
 	 * with the previous scheduler. We will switch back once we are done
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 271f16771499..b6095cc50921 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -14,6 +14,10 @@ struct blk_mq_ctxs {
 
 struct blk_mq_ctx_type {
 	struct list_head		rq_list;
+
+	/* tag batch cache */
+	unsigned long			tags;
+	unsigned int			tag_offset;
 };
 
 /**
@@ -23,6 +27,7 @@ struct blk_mq_ctx {
 	struct {
 		spinlock_t		lock;
 		struct blk_mq_ctx_type	type[HCTX_MAX_TYPES];
+		unsigned long		tag_hit, tag_refill;
 	} ____cacheline_aligned_in_smp;
 
 	unsigned int		cpu;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 11cfd6470b1a..2c6a8657a72c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -140,6 +140,8 @@ struct blk_mq_hw_ctx {
 	 */
 	atomic_t		nr_active;
 
+	atomic_t		flush_pending;
+
 	/** @cpuhp_dead: List to store request if some CPU die. */
 	struct hlist_node	cpuhp_dead;
 	/** @kobj: Kernel object for sysfs. */
-- 
2.24.1

