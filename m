Return-Path: <SRS0=HKcR=2U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5EFC2D0C2
	for <linux-block@archiver.kernel.org>; Mon, 30 Dec 2019 18:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE79206DB
	for <linux-block@archiver.kernel.org>; Mon, 30 Dec 2019 18:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xQk1OX6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfL3SPT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:15:19 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46096 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfL3SPT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Dec 2019 13:15:19 -0500
Received: by mail-yb1-f194.google.com with SMTP id k128so3409839ybc.13
        for <linux-block@vger.kernel.org>; Mon, 30 Dec 2019 10:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l+uhEeKKazCGxLFzF/yGc13aEcKSzORgIo7hoCqdM7E=;
        b=xQk1OX6p9AqBfvMSEGxAKQLMLWUl5xRKygKeJxK2rIS+PPZw7JoLKBXUD2Gotf7xak
         hYRdQgwhGqn7wZ/5ihV9GUH4nZW7P6bWudbxghNBY4/+vHBNWu0w7NkgC0unkujFDNkI
         C3ug+xqsHvGOsSmisqPOpGDyin+3Ff2aSnRMnOja+OKCq5e266FxzKJQ+uvJH4LJtI9I
         EybLUHzb+jqkzgOhgfyL9DvR5l6R11o8NSm66cZ2D8vDjPSrd2WY3LSJUMzMpnZt9Nnf
         lhgcaTbGiweFbEs/qYlBlhbUNIc6MIEi7AR37A1cldzL8aei5s7RPJGS3+6qOk/6fSnK
         /m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l+uhEeKKazCGxLFzF/yGc13aEcKSzORgIo7hoCqdM7E=;
        b=AE13YKpiwcRfsji2tXmOFDqlpHFks6TwSJTKZAlsyFjOrTexqY//9aGwakAHt3XNcx
         xUJP6YYpbahm0OV4diO1uWmWKQSmTyGWXlmWKnLqk93hVwahvY69kb2IUtxUh+/T8rH/
         4QtMT9sRjQ9GTqFsk2Jvf56Y+URAMudKXB+zYN+YhMG8dZAkZD0IjnpBJN+ALiV0RWJj
         OVkheGahC+nTGL71U2M9BefNPdrNjD9rz9oRimLK+uZ/z8Qm6ggi0SNRNNP+ntCct1We
         DSEHv1NtHhfy+zxfh0jQByrH4eQEhAJvSW0OVcPcrvGuie1TTi/8JGa3sZnWLm6nO+Xo
         irnQ==
X-Gm-Message-State: APjAAAVR1eF7cR3Hgr8RbECRxWgGwJB0IHQ6hrurFv2vApR+UJAjTL+g
        swcYeRR+YMmpDPNY2AlcF/Ug1VR4TFw=
X-Google-Smtp-Source: APXvYqxMLwV2dAuz02My2HwDs2mC0DS8LLpUFHMVcxYrYdZXwDZFQiJKR9y2/uiObE4a7Wj7XEXAdg==
X-Received: by 2002:a25:8186:: with SMTP id p6mr47485756ybk.489.1577729716681;
        Mon, 30 Dec 2019 10:15:16 -0800 (PST)
Received: from x1.localdomain ([8.46.73.113])
        by smtp.gmail.com with ESMTPSA id u136sm17879910ywf.101.2019.12.30.10.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:15:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] blk-mq: allocate tags in batches
Date:   Mon, 30 Dec 2019 11:14:43 -0700
Message-Id: <20191230181442.4460-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191230181442.4460-1-axboe@kernel.dk>
References: <20191230181442.4460-1-axboe@kernel.dk>
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
 block/blk-mq-tag.c     | 105 ++++++++++++++++++++++++++++++++++++++++-
 block/blk-mq.c         |  13 ++++-
 block/blk-mq.h         |   5 ++
 4 files changed, 139 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b3f2ba483992..fcd6f7ce80cc 100644
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
+	seq_printf(m, "hit=%lu refills=%lu, tags=%lx, tag_offset=%u\n", ctx->tag_hit, ctx->tag_refill, ctx->tags, ctx->tag_offset);
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
index fbacde454718..3b5269bc4e36 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -99,6 +99,101 @@ static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 		return __sbitmap_queue_get(bt);
 }
 
+static void blk_mq_tag_flush_batches(struct blk_mq_hw_ctx *hctx)
+{
+	struct sbitmap_queue *bt = &hctx->tags->bitmap_tags;
+	struct blk_mq_ctx *ctx;
+	unsigned int i;
+
+	/*
+	 * we could potentially add a ctx map for this, but probably not
+	 * worth it. better to ensure that we rarely (or never) get into
+	 * the need to flush ctx tag batches.
+	 */
+	hctx_for_each_ctx(hctx, ctx, i) {
+		unsigned long mask;
+		unsigned int offset;
+
+		if (!ctx->tags)
+			continue;
+
+		spin_lock(&ctx->lock);
+		mask = ctx->tags;
+		offset = ctx->tag_offset;
+		ctx->tags = 0;
+		ctx->tag_offset = -1;
+		spin_unlock(&ctx->lock);
+
+		if (mask)
+			__sbitmap_queue_clear_batch(bt, offset, mask);
+	}
+}
+
+void blk_mq_tag_queue_flush_batches(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		blk_mq_tag_flush_batches(hctx);
+}
+
+static int blk_mq_get_tag_batch(struct blk_mq_alloc_data *data)
+{
+	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
+	struct sbitmap_queue *bt = &tags->bitmap_tags;
+	struct blk_mq_ctx *ctx = data->ctx;
+	int tag, cpu;
+
+	if (!ctx)
+		return -1;
+
+	preempt_disable();
+
+	/* bad luck if we got preempted coming in here, should be rare */
+	cpu = smp_processor_id();
+	if (unlikely(ctx->cpu != cpu)) {
+		ctx = data->ctx = __blk_mq_get_ctx(data->q, cpu);
+		data->hctx = blk_mq_map_queue(data->q, data->cmd_flags, ctx);
+		tags = blk_mq_tags_from_data(data);
+		bt = &tags->bitmap_tags;
+	}
+
+	spin_lock(&ctx->lock);
+
+	if (WARN_ON_ONCE(ctx->tag_offset != -1 && !ctx->tags)) {
+		printk("hit=%lu, refill=%lun", ctx->tag_hit,  ctx->tag_refill);
+		ctx->tag_offset = -1;
+	}
+
+	/* if offset is != -1, we have a tag cache. grab first free one */
+	if (ctx->tag_offset != -1) {
+get_tag:
+		ctx->tag_hit++;
+
+		WARN_ON_ONCE(!ctx->tags);
+
+		tag = __ffs(ctx->tags);
+		__clear_bit(tag, &ctx->tags);
+		tag += ctx->tag_offset;
+		if (!ctx->tags)
+			ctx->tag_offset = -1;
+out:
+		spin_unlock(&ctx->lock);
+		preempt_enable();
+		return tag;
+	}
+
+	/* no current tag cache, attempt to refill a batch */
+	if (!__sbitmap_queue_get_batch(bt, &ctx->tag_offset, &ctx->tags)) {
+		ctx->tag_refill++;
+		goto get_tag;
+	}
+
+	tag = -1;
+	goto out;
+}
+
 unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 {
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
@@ -116,8 +211,13 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
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
@@ -146,6 +246,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != -1)
 			break;
 
+		if (!(data->flags & BLK_MQ_REQ_RESERVED))
+			blk_mq_tag_flush_batches(data->hctx);
+
 		sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIBLE);
 
 		tag = __blk_mq_get_tag(data, bt);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3c71d52b6401..9eeade7736eb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -276,6 +276,9 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	struct request *rq = tags->static_rqs[tag];
 	req_flags_t rq_flags = 0;
 
+	if (WARN_ON_ONCE(!rq))
+		printk("no rq for tag %u\n", tag);
+
 	if (data->flags & BLK_MQ_REQ_INTERNAL) {
 		rq->tag = -1;
 		rq->internal_tag = tag;
@@ -2358,6 +2361,9 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 		struct blk_mq_hw_ctx *hctx;
 		int k;
 
+		__ctx->tags = 0;
+		__ctx->tag_offset = -1;
+
 		__ctx->cpu = i;
 		spin_lock_init(&__ctx->lock);
 		for (k = HCTX_TYPE_DEFAULT; k < HCTX_MAX_TYPES; k++)
@@ -2447,6 +2453,8 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 			}
 
 			hctx = blk_mq_map_queue_type(q, j, i);
+			ctx->tags = 0;
+			ctx->tag_offset = -1;
 			ctx->hctxs[j] = hctx;
 			/*
 			 * If the CPU is already set in the mask, then we've
@@ -3224,8 +3232,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
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
index eaaca8fc1c28..7a3198f62f6e 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -18,7 +18,9 @@ struct blk_mq_ctxs {
 struct blk_mq_ctx {
 	struct {
 		spinlock_t		lock;
+		unsigned int		tag_offset;
 		struct list_head	rq_lists[HCTX_MAX_TYPES];
+		unsigned long		tags;
 	} ____cacheline_aligned_in_smp;
 
 	unsigned int		cpu;
@@ -32,6 +34,8 @@ struct blk_mq_ctx {
 	/* incremented at completion time */
 	unsigned long		____cacheline_aligned_in_smp rq_completed[2];
 
+	unsigned long		tag_hit, tag_refill;
+
 	struct request_queue	*queue;
 	struct blk_mq_ctxs      *ctxs;
 	struct kobject		kobj;
@@ -60,6 +64,7 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 					unsigned int reserved_tags);
 int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx, unsigned int depth);
+void blk_mq_tag_queue_flush_batches(struct request_queue *q);
 
 /*
  * Internal helpers for request insertion into sw queues
-- 
2.24.1

