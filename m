Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E119DC33C8C
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 16:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E742146E
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 16:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wjlq1zjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgAGQap (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:30:45 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:39306 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgAGQap (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 11:30:45 -0500
Received: by mail-il1-f195.google.com with SMTP id x5so92819ila.6
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 08:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2BW/+gMpZdTdHWrn1WIdKhoFLPpDw2eRNjy+zYRAURM=;
        b=wjlq1zjBAeXCI8DhGRTwNyDmsQm8o08HsZgIzTO9g+2QTMQodzTXOw71S41tktKEke
         wV9lqfBX5OKIrd6CLIMsBmg1TlrSDSCbYbye05ttAS9X1Tcrsom+gyXz03easYTGayyH
         iZ7hrbFXty2oBZ1aUcMXwU9XEXbi/TTv7RBQ0DxoQiAEfRPJLgrbcLv52Rlm/6TWXXeh
         sJbOHA/jNDhSEZsCjByWScKCeOr82wMTz3scZDJzYktCN/NfcuCbYZevDttYoxmZ4MCG
         qxF6EXP8JhyOSvwtUJAcJ85Sz0Fscv0c85hzMf4TjHzjjPrHWP3BRYJUmBStEueUqzN9
         H6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2BW/+gMpZdTdHWrn1WIdKhoFLPpDw2eRNjy+zYRAURM=;
        b=GMShwJHFxsnV4VXzPjGwyR6JKh3I3HpBLLuMtx4RcP0LsxpglNSoghbm1LrQqAjcoX
         V318pHt1kA7vVRWaDTs1BGygWds6nSfIDXqcL4hrVDjr1fAkO28hR7PeoBzS2138O0UE
         DO0RGvsFdQ7jEAYY5BNRyI5zmAu+fn/mN/Le1iDgOxbWzKW1KRwNFOMIe96gnLcAIaEe
         hQirYAI30jr6tqlKUu1GoyMyYN4ThIWApf9Xus7jUvLzQDjNowBGfrk3pEROXFdwalWA
         OvhB5w0rvKZTBGBqOUzoCwskWWjjMSuV2UuOpNYCixz4ghJVvMfUbWklwyTye3adHvdZ
         QA9A==
X-Gm-Message-State: APjAAAVFjsQhBBSFxnIH+Mq9at0NnOle0ntewBiQA2DaKc4dGswqkG2n
        f5hKmVRApTLBKIp8fwUjyqyIb+MhNwk=
X-Google-Smtp-Source: APXvYqwH3sj+q6hKpGvjbTndIRuuXVv8zMG2IS0NAaDMbYx45aAeX4QZ6OO+WZBathFQjFvt9Aq1/A==
X-Received: by 2002:a92:405b:: with SMTP id n88mr56573490ila.95.1578414644111;
        Tue, 07 Jan 2020 08:30:44 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w11sm20639ilh.55.2020.01.07.08.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:30:43 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] blk-mq: add struct blk_mq_ctx_type
Date:   Tue,  7 Jan 2020 09:30:36 -0700
Message-Id: <20200107163037.31745-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107163037.31745-1-axboe@kernel.dk>
References: <20200107163037.31745-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This only holds the dispatch list for now, and there should be no
functional changes in this patch. This is in preparation for adding more
items to the per-ctx type structure.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-debugfs.c |  6 +++---
 block/blk-mq-sched.c   |  4 ++--
 block/blk-mq.c         | 22 +++++++++++-----------
 block/blk-mq.h         |  6 +++++-
 4 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b3f2ba483992..e789f830ff59 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -622,14 +622,14 @@ static int hctx_dispatch_busy_show(void *data, struct seq_file *m)
 	return 0;
 }
 
-#define CTX_RQ_SEQ_OPS(name, type)					\
+#define CTX_RQ_SEQ_OPS(name, __type)					\
 static void *ctx_##name##_rq_list_start(struct seq_file *m, loff_t *pos) \
 	__acquires(&ctx->lock)						\
 {									\
 	struct blk_mq_ctx *ctx = m->private;				\
 									\
 	spin_lock(&ctx->lock);						\
-	return seq_list_start(&ctx->rq_lists[type], *pos);		\
+	return seq_list_start(&ctx->type[__type].rq_list, *pos);		\
 }									\
 									\
 static void *ctx_##name##_rq_list_next(struct seq_file *m, void *v,	\
@@ -637,7 +637,7 @@ static void *ctx_##name##_rq_list_next(struct seq_file *m, void *v,	\
 {									\
 	struct blk_mq_ctx *ctx = m->private;				\
 									\
-	return seq_list_next(v, &ctx->rq_lists[type], pos);		\
+	return seq_list_next(v, &ctx->type[__type].rq_list, pos);	\
 }									\
 									\
 static void ctx_##name##_rq_list_stop(struct seq_file *m, void *v)	\
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ca22afd47b3d..52368c9005e5 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -313,7 +313,7 @@ static bool blk_mq_attempt_merge(struct request_queue *q,
 
 	lockdep_assert_held(&ctx->lock);
 
-	if (blk_mq_bio_list_merge(q, &ctx->rq_lists[type], bio, nr_segs)) {
+	if (blk_mq_bio_list_merge(q, &ctx->type[type].rq_list, bio, nr_segs)) {
 		ctx->rq_merged++;
 		return true;
 	}
@@ -335,7 +335,7 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 
 	type = hctx->type;
 	if ((hctx->flags & BLK_MQ_F_SHOULD_MERGE) &&
-			!list_empty_careful(&ctx->rq_lists[type])) {
+			!list_empty_careful(&ctx->type[type].rq_list)) {
 		/* default per sw-queue merge */
 		spin_lock(&ctx->lock);
 		ret = blk_mq_attempt_merge(q, hctx, ctx, bio, nr_segs);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a36764c38bfb..cc48a0ffa5ec 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -953,7 +953,7 @@ static bool flush_busy_ctx(struct sbitmap *sb, unsigned int bitnr, void *data)
 	enum hctx_type type = hctx->type;
 
 	spin_lock(&ctx->lock);
-	list_splice_tail_init(&ctx->rq_lists[type], flush_data->list);
+	list_splice_tail_init(&ctx->type[type].rq_list, flush_data->list);
 	sbitmap_clear_bit(sb, bitnr);
 	spin_unlock(&ctx->lock);
 	return true;
@@ -985,13 +985,13 @@ static bool dispatch_rq_from_ctx(struct sbitmap *sb, unsigned int bitnr,
 	struct dispatch_rq_data *dispatch_data = data;
 	struct blk_mq_hw_ctx *hctx = dispatch_data->hctx;
 	struct blk_mq_ctx *ctx = hctx->ctxs[bitnr];
-	enum hctx_type type = hctx->type;
+	struct blk_mq_ctx_type *type = &ctx->type[hctx->type];
 
 	spin_lock(&ctx->lock);
-	if (!list_empty(&ctx->rq_lists[type])) {
-		dispatch_data->rq = list_entry_rq(ctx->rq_lists[type].next);
+	if (!list_empty(&type->rq_list)) {
+		dispatch_data->rq = list_entry_rq(type->rq_list.next);
 		list_del_init(&dispatch_data->rq->queuelist);
-		if (list_empty(&ctx->rq_lists[type]))
+		if (list_empty(&type->rq_list))
 			sbitmap_clear_bit(sb, bitnr);
 	}
 	spin_unlock(&ctx->lock);
@@ -1648,9 +1648,9 @@ static inline void __blk_mq_insert_req_list(struct blk_mq_hw_ctx *hctx,
 	trace_block_rq_insert(hctx->queue, rq);
 
 	if (at_head)
-		list_add(&rq->queuelist, &ctx->rq_lists[type]);
+		list_add(&rq->queuelist, &ctx->type[type].rq_list);
 	else
-		list_add_tail(&rq->queuelist, &ctx->rq_lists[type]);
+		list_add_tail(&rq->queuelist, &ctx->type[type].rq_list);
 }
 
 void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
@@ -1701,7 +1701,7 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	}
 
 	spin_lock(&ctx->lock);
-	list_splice_tail_init(list, &ctx->rq_lists[type]);
+	list_splice_tail_init(list, &ctx->type[type].rq_list);
 	blk_mq_hctx_mark_pending(hctx, ctx);
 	spin_unlock(&ctx->lock);
 }
@@ -2256,8 +2256,8 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	type = hctx->type;
 
 	spin_lock(&ctx->lock);
-	if (!list_empty(&ctx->rq_lists[type])) {
-		list_splice_init(&ctx->rq_lists[type], &tmp);
+	if (!list_empty(&ctx->type[type].rq_list)) {
+		list_splice_init(&ctx->type[type].rq_list, &tmp);
 		blk_mq_hctx_clear_pending(hctx, ctx);
 	}
 	spin_unlock(&ctx->lock);
@@ -2437,7 +2437,7 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 		__ctx->cpu = i;
 		spin_lock_init(&__ctx->lock);
 		for (k = HCTX_TYPE_DEFAULT; k < HCTX_MAX_TYPES; k++)
-			INIT_LIST_HEAD(&__ctx->rq_lists[k]);
+			INIT_LIST_HEAD(&__ctx->type[k].rq_list);
 
 		/*
 		 * Set local node, IFF we have more than one hw queue. If
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d15ef0bafe29..271f16771499 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -12,13 +12,17 @@ struct blk_mq_ctxs {
 	struct blk_mq_ctx __percpu	*queue_ctx;
 };
 
+struct blk_mq_ctx_type {
+	struct list_head		rq_list;
+};
+
 /**
  * struct blk_mq_ctx - State for a software queue facing the submitting CPUs
  */
 struct blk_mq_ctx {
 	struct {
 		spinlock_t		lock;
-		struct list_head	rq_lists[HCTX_MAX_TYPES];
+		struct blk_mq_ctx_type	type[HCTX_MAX_TYPES];
 	} ____cacheline_aligned_in_smp;
 
 	unsigned int		cpu;
-- 
2.24.1

