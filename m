Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C89DC43217
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 111606120A
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244727AbhJQBkL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244806AbhJQBkK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:40:10 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE8CC061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:38:01 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h10so11255485ilq.3
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f+Z//YyA2T7lKHECVu1gnxRhxbGDl6uDF9mrhR8834U=;
        b=Y6F4c0s1qSoHNoPamz0m8izKn8Nzde+D7z0ktwLdE4Km1dBwP8ZK9df7rBhswl2W8f
         KG21G1lf0z/2SPY2/pcP0trb6g/u6jTFZ4/0y7TcWVCA3Q4yGvxkFjbJnAiU6TAC0svv
         73FPONfo0v7Gw14ZZPz4UEX817+hcZwy9r6oeyR5DWbtGxXwEkfxGvt3vljxQlLWSHFM
         lLbomVv7WsMa1Nd6165lycqe6Q6NNWZEz3FGrgReAYf8Gg/RsuiYo+T5sO+kj08Sw30X
         A+CLl4L2z14rzCsm7xgRlTN2Ax1QsQUKcpICZq2JzSqYYF7HEgLAOS9bIp7uoTAzOU2B
         WIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f+Z//YyA2T7lKHECVu1gnxRhxbGDl6uDF9mrhR8834U=;
        b=tcykQ5DCbXwDfQ6+nQCFXvCmWedo2hsdi1N5TPzNbpL232z1U7nVmCYB58Oikpq+6d
         d/VLxRqnk1lisv+3/xc6VStVLAs0KoTpq0aqAWI8JBbrm/eXNPKT99tdwsdBg3b3XsFE
         jAGriMw5hX3znMy5nATkM2aWEFv5FZnh7tbt9XpNGaCjnZCi+1cIYsPTfD1UeDSy6TGv
         tgES3GvEXDKRikmRRRMGxx9WMbptQ3yVMlQHTSrXyZkpRanrNf2tlo5ssq+WnaTly/vT
         SOV/IPRzU9C8V7w5wIIYoeXvhhpZbWAWqSJ4srcXFKBwKMZ2cmS/Qqf8WtavWIvaLhwU
         qjZA==
X-Gm-Message-State: AOAM533d2ZzEHkP5FeG0lGd63UH9Q85VaEnxiinEgsa0iNQWjS8nhxZT
        N5qT2kk1Aa3V6gL0vFAIznI1CbtFoXJ85w==
X-Google-Smtp-Source: ABdhPJypPCQWFSIQ7kYDz4YFjEP8UDfXNDTsrU/muDjwg3jOTfogja/eznwpXgCVaj527CjVr4Ogww==
X-Received: by 2002:a92:c7a1:: with SMTP id f1mr8599651ilk.263.1634434680622;
        Sat, 16 Oct 2021 18:38:00 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm4934383ilq.1.2021.10.16.18.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 18:38:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/14] block: remove debugfs blk_mq_ctx dispatched/merged/completed attributes
Date:   Sat, 16 Oct 2021 19:37:47 -0600
Message-Id: <20211017013748.76461-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017013748.76461-1-axboe@kernel.dk>
References: <20211017013748.76461-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These were added as part of early days debugging for blk-mq, and they
are not really useful anymore. Rather than spend cycles updating them,
just get rid of them.

As a bonus, this shrinks the per-cpu software queue size from 256b
to 192b. That's a whole cacheline less.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-debugfs.c | 54 ------------------------------------------
 block/blk-mq-sched.c   |  5 +---
 block/blk-mq.c         |  3 ---
 block/blk-mq.h         |  7 ------
 4 files changed, 1 insertion(+), 68 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 409a8256d9ff..928a16af9175 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -663,57 +663,6 @@ CTX_RQ_SEQ_OPS(default, HCTX_TYPE_DEFAULT);
 CTX_RQ_SEQ_OPS(read, HCTX_TYPE_READ);
 CTX_RQ_SEQ_OPS(poll, HCTX_TYPE_POLL);
 
-static int ctx_dispatched_show(void *data, struct seq_file *m)
-{
-	struct blk_mq_ctx *ctx = data;
-
-	seq_printf(m, "%lu %lu\n", ctx->rq_dispatched[1], ctx->rq_dispatched[0]);
-	return 0;
-}
-
-static ssize_t ctx_dispatched_write(void *data, const char __user *buf,
-				    size_t count, loff_t *ppos)
-{
-	struct blk_mq_ctx *ctx = data;
-
-	ctx->rq_dispatched[0] = ctx->rq_dispatched[1] = 0;
-	return count;
-}
-
-static int ctx_merged_show(void *data, struct seq_file *m)
-{
-	struct blk_mq_ctx *ctx = data;
-
-	seq_printf(m, "%lu\n", ctx->rq_merged);
-	return 0;
-}
-
-static ssize_t ctx_merged_write(void *data, const char __user *buf,
-				size_t count, loff_t *ppos)
-{
-	struct blk_mq_ctx *ctx = data;
-
-	ctx->rq_merged = 0;
-	return count;
-}
-
-static int ctx_completed_show(void *data, struct seq_file *m)
-{
-	struct blk_mq_ctx *ctx = data;
-
-	seq_printf(m, "%lu %lu\n", ctx->rq_completed[1], ctx->rq_completed[0]);
-	return 0;
-}
-
-static ssize_t ctx_completed_write(void *data, const char __user *buf,
-				   size_t count, loff_t *ppos)
-{
-	struct blk_mq_ctx *ctx = data;
-
-	ctx->rq_completed[0] = ctx->rq_completed[1] = 0;
-	return count;
-}
-
 static int blk_mq_debugfs_show(struct seq_file *m, void *v)
 {
 	const struct blk_mq_debugfs_attr *attr = m->private;
@@ -803,9 +752,6 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 	{"default_rq_list", 0400, .seq_ops = &ctx_default_rq_list_seq_ops},
 	{"read_rq_list", 0400, .seq_ops = &ctx_read_rq_list_seq_ops},
 	{"poll_rq_list", 0400, .seq_ops = &ctx_poll_rq_list_seq_ops},
-	{"dispatched", 0600, ctx_dispatched_show, ctx_dispatched_write},
-	{"merged", 0600, ctx_merged_show, ctx_merged_write},
-	{"completed", 0600, ctx_completed_show, ctx_completed_write},
 	{},
 };
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index efc1374b8831..e85b7556b096 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -387,13 +387,10 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 	 * potentially merge with. Currently includes a hand-wavy stop
 	 * count of 8, to not spend too much time checking for merges.
 	 */
-	if (blk_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs)) {
-		ctx->rq_merged++;
+	if (blk_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs))
 		ret = true;
-	}
 
 	spin_unlock(&ctx->lock);
-
 	return ret;
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0d05ac4a3b50..4d91b74ce67a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -316,7 +316,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->mq_ctx = ctx;
 	rq->mq_hctx = hctx;
 	rq->cmd_flags = cmd_flags;
-	data->ctx->rq_dispatched[op_is_sync(data->cmd_flags)]++;
 	data->hctx->queued++;
 	if (!q->elevator) {
 		rq->rq_flags = 0;
@@ -573,7 +572,6 @@ static void __blk_mq_free_request(struct request *rq)
 void blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	if (rq->rq_flags & (RQF_ELVPRIV | RQF_ELV)) {
@@ -587,7 +585,6 @@ void blk_mq_free_request(struct request *rq)
 		}
 	}
 
-	ctx->rq_completed[rq_is_sync(rq)]++;
 	if (rq->rq_flags & RQF_MQ_INFLIGHT)
 		__blk_mq_dec_active_requests(hctx);
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index ceed0a001c76..c12554c58abd 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -25,13 +25,6 @@ struct blk_mq_ctx {
 	unsigned short		index_hw[HCTX_MAX_TYPES];
 	struct blk_mq_hw_ctx 	*hctxs[HCTX_MAX_TYPES];
 
-	/* incremented at dispatch time */
-	unsigned long		rq_dispatched[2];
-	unsigned long		rq_merged;
-
-	/* incremented at completion time */
-	unsigned long		____cacheline_aligned_in_smp rq_completed[2];
-
 	struct request_queue	*queue;
 	struct blk_mq_ctxs      *ctxs;
 	struct kobject		kobj;
-- 
2.33.1

