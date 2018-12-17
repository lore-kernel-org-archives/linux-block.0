Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3E3C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 13:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A75320874
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 13:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jwe/fKpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbeLQN3l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:29:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45932 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732785AbeLQN3l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 08:29:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so6136996plm.12
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 05:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tt7Yv/+UH1CxzzDTcf4tvp/KSFVgC1h0OCOZStN6hH0=;
        b=jwe/fKpvQw4Q4XSQfZJNU3P8VwllHN1JaVD7/7UrG8IAeeiAjSa8pVI9jN3IW6s2PM
         1wT2pFr3qCE1lDXv8SqD1nSSmec6Prdn+WOaFV9irx2/vCM4HT2vjTF6s5pUJ9NUEcnr
         fjoW1/wD7V62316WNoGCbFNdiQx3J7ltNUibjWzI6Udd8pTRizRghZRgwF6Iu1dPODg8
         3NfLibIWhBGJCPGxWSjGySqRz99eTuOKDMHrYpe5lhqERmQVkrJ0hz6rQI0gbESTA4yC
         /V2FVcDTfNvEIYHiN/qE1uMp8O1FN+vQD4i1GrQ06YI5G0r7fm8k1nVK5M8p824hUOBn
         EJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tt7Yv/+UH1CxzzDTcf4tvp/KSFVgC1h0OCOZStN6hH0=;
        b=lphjOPIcb18dWdiHilazdSp7QvyRIS5+SBj0lGXN1sf6yNvqZefDiqbY4in6pwgrgZ
         TPanL/E9NMCpMSAXM068wlhf+jsR0OWoV6yO7OM+cAVIDWriLaPBHCrhy+YuQmP7pQ3q
         paUUQDrWDI7WBmMYfrGq+3mTiWnqnRfb6Yy8CLL4FfHI4kMZk9CPhgTrZMUGF/N9RFIt
         IRGNhEAhhffTPz3jt7y0YJRhwVR90xS1fXNF9jAGDQe9Kmh62rjIKf/faLGMPPmWmgs7
         GHM0ZfK04a4RH2KUwExTo1dT1VoFEslME8vQvKM8A3clLrc69c5CVdWtW2oTJGxmqoWB
         pPgA==
X-Gm-Message-State: AA+aEWZqhYnEy/1+lDpjuR0mHiE8EUM932kAkMBDeBd78pZvQsax6nk5
        m2dbDSk9fHg8D9IMn5EQR/vLvw==
X-Google-Smtp-Source: AFSGD/V0E5nacyielhbqhSscLCQ9EpjF9umnirqv8pq3+G7uF1tiS3pe+UXzYbixmzHZKsQ8S1K0lg==
X-Received: by 2002:a17:902:1008:: with SMTP id b8mr12235848pla.252.1545053380597;
        Mon, 17 Dec 2018 05:29:40 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s37sm15552728pgm.19.2018.12.17.05.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 05:29:39 -0800 (PST)
Subject: Re: [PATCH V3 3/3] blk-mq: fix dispatch from sw queue
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20181217120844.8131-1-ming.lei@redhat.com>
 <20181217120844.8131-4-ming.lei@redhat.com>
 <fe4133ec-7dfa-255c-9c24-af448446bf23@kernel.dk>
Message-ID: <65b5ae24-2c02-7f78-275e-3df5a860cad5@kernel.dk>
Date:   Mon, 17 Dec 2018 06:29:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <fe4133ec-7dfa-255c-9c24-af448446bf23@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/18 5:55 AM, Jens Axboe wrote:
> On 12/17/18 5:08 AM, Ming Lei wrote:
>> When requst is added to rq list of sw queue(ctx), the rq may be from
>> different type of hctx, especially after multi queue mapping is introduced.
>>
>> So when dispach request from sw queue via blk_mq_flush_busy_ctxs() or
>> blk_mq_dequeue_from_ctx(), one request belonging to other queue type of
>> hctx can be dispatch to current hctx in case that read queue or poll queue
>> is enabled.
>>
>> This patch fixes this issue by introducing per-queue-type list.
> 
> Looks good, just one comment:
> 
>> diff --git a/block/blk-mq.h b/block/blk-mq.h
>> index d1ed096723fb..0973a91eb1dd 100644
>> --- a/block/blk-mq.h
>> +++ b/block/blk-mq.h
>> @@ -12,14 +12,16 @@ struct blk_mq_ctxs {
>>  	struct blk_mq_ctx __percpu	*queue_ctx;
>>  };
>>  
>> +struct blk_mq_ctx_list {
>> +	spinlock_t		lock;
>> +	struct list_head	rq_list;
>> +}  ____cacheline_aligned_in_smp;
>> +
>>  /**
>>   * struct blk_mq_ctx - State for a software queue facing the submitting CPUs
>>   */
>>  struct blk_mq_ctx {
>> -	struct {
>> -		spinlock_t		lock;
>> -		struct list_head	rq_list;
>> -	}  ____cacheline_aligned_in_smp;
>> +	struct blk_mq_ctx_list  list[HCTX_MAX_TYPES];
> 
> Let's not make that use 3 cachelines. There is no good reason to split
> these across cachelines, if we have heavy traffic to multiple of these,
> then we're not going very fast anyway. So just make it:
> 
> 	struct {
> 		spinlock_t		lock;
> 		struct list_head	rq_list[HCTX_MAX_TYPES];
> 	}  ____cacheline_aligned_in_smp;

Did it just to check, turns out fine and is of course less changes.
Let me know.


diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 1e12033be9ea..90d68760af08 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -652,36 +652,43 @@ static int hctx_dispatch_busy_show(void *data, struct seq_file *m)
 	return 0;
 }
 
-static void *ctx_rq_list_start(struct seq_file *m, loff_t *pos)
-	__acquires(&ctx->lock)
-{
-	struct blk_mq_ctx *ctx = m->private;
-
-	spin_lock(&ctx->lock);
-	return seq_list_start(&ctx->rq_list, *pos);
-}
-
-static void *ctx_rq_list_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	struct blk_mq_ctx *ctx = m->private;
-
-	return seq_list_next(v, &ctx->rq_list, pos);
-}
+#define CTX_RQ_SEQ_OPS(name, type)					\
+static void *ctx_##name##_rq_list_start(struct seq_file *m, loff_t *pos) \
+	__acquires(&ctx->lock)						\
+{									\
+	struct blk_mq_ctx *ctx = m->private;				\
+									\
+	spin_lock(&ctx->lock);						\
+	return seq_list_start(&ctx->rq_lists[type], *pos);		\
+}									\
+									\
+static void *ctx_##name##_rq_list_next(struct seq_file *m, void *v,	\
+				     loff_t *pos)			\
+{									\
+	struct blk_mq_ctx *ctx = m->private;				\
+									\
+	return seq_list_next(v, &ctx->rq_lists[type], pos);		\
+}									\
+									\
+static void ctx_##name##_rq_list_stop(struct seq_file *m, void *v)	\
+	__releases(&ctx->lock)						\
+{									\
+	struct blk_mq_ctx *ctx = m->private;				\
+									\
+	spin_unlock(&ctx->lock);					\
+}									\
+									\
+static const struct seq_operations ctx_##name##_rq_list_seq_ops = {	\
+	.start	= ctx_##name##_rq_list_start,				\
+	.next	= ctx_##name##_rq_list_next,				\
+	.stop	= ctx_##name##_rq_list_stop,				\
+	.show	= blk_mq_debugfs_rq_show,				\
+}
+
+CTX_RQ_SEQ_OPS(default, HCTX_TYPE_DEFAULT);
+CTX_RQ_SEQ_OPS(read, HCTX_TYPE_READ);
+CTX_RQ_SEQ_OPS(poll, HCTX_TYPE_POLL);
 
-static void ctx_rq_list_stop(struct seq_file *m, void *v)
-	__releases(&ctx->lock)
-{
-	struct blk_mq_ctx *ctx = m->private;
-
-	spin_unlock(&ctx->lock);
-}
-
-static const struct seq_operations ctx_rq_list_seq_ops = {
-	.start	= ctx_rq_list_start,
-	.next	= ctx_rq_list_next,
-	.stop	= ctx_rq_list_stop,
-	.show	= blk_mq_debugfs_rq_show,
-};
 static int ctx_dispatched_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_ctx *ctx = data;
@@ -819,7 +826,9 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 };
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
-	{"rq_list", 0400, .seq_ops = &ctx_rq_list_seq_ops},
+	{"default_rq_list", 0400, .seq_ops = &ctx_default_rq_list_seq_ops},
+	{"read_rq_list", 0400, .seq_ops = &ctx_read_rq_list_seq_ops},
+	{"poll_rq_list", 0400, .seq_ops = &ctx_poll_rq_list_seq_ops},
 	{"dispatched", 0600, ctx_dispatched_show, ctx_dispatched_write},
 	{"merged", 0600, ctx_merged_show, ctx_merged_write},
 	{"completed", 0600, ctx_completed_show, ctx_completed_write},
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 1efd781fcdea..5af40bbf4fc6 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -301,11 +301,14 @@ EXPORT_SYMBOL_GPL(blk_mq_bio_list_merge);
  * too much time checking for merges.
  */
 static bool blk_mq_attempt_merge(struct request_queue *q,
+				 struct blk_mq_hw_ctx *hctx,
 				 struct blk_mq_ctx *ctx, struct bio *bio)
 {
+	enum hctx_type type = hctx->type;
+
 	lockdep_assert_held(&ctx->lock);
 
-	if (blk_mq_bio_list_merge(q, &ctx->rq_list, bio)) {
+	if (blk_mq_bio_list_merge(q, &ctx->rq_lists[type], bio)) {
 		ctx->rq_merged++;
 		return true;
 	}
@@ -319,17 +322,19 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, bio->bi_opf, ctx->cpu);
 	bool ret = false;
+	enum hctx_type type;
 
 	if (e && e->type->ops.bio_merge) {
 		blk_mq_put_ctx(ctx);
 		return e->type->ops.bio_merge(hctx, bio);
 	}
 
+	type = hctx->type;
 	if ((hctx->flags & BLK_MQ_F_SHOULD_MERGE) &&
-			!list_empty_careful(&ctx->rq_list)) {
+			!list_empty_careful(&ctx->rq_lists[type])) {
 		/* default per sw-queue merge */
 		spin_lock(&ctx->lock);
-		ret = blk_mq_attempt_merge(q, ctx, bio);
+		ret = blk_mq_attempt_merge(q, hctx, ctx, bio);
 		spin_unlock(&ctx->lock);
 	}
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 313f28b2d079..1546e88fe59c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -958,9 +958,10 @@ static bool flush_busy_ctx(struct sbitmap *sb, unsigned int bitnr, void *data)
 	struct flush_busy_ctx_data *flush_data = data;
 	struct blk_mq_hw_ctx *hctx = flush_data->hctx;
 	struct blk_mq_ctx *ctx = hctx->ctxs[bitnr];
+	enum hctx_type type = hctx->type;
 
 	spin_lock(&ctx->lock);
-	list_splice_tail_init(&ctx->rq_list, flush_data->list);
+	list_splice_tail_init(&ctx->rq_lists[type], flush_data->list);
 	sbitmap_clear_bit(sb, bitnr);
 	spin_unlock(&ctx->lock);
 	return true;
@@ -992,12 +993,13 @@ static bool dispatch_rq_from_ctx(struct sbitmap *sb, unsigned int bitnr,
 	struct dispatch_rq_data *dispatch_data = data;
 	struct blk_mq_hw_ctx *hctx = dispatch_data->hctx;
 	struct blk_mq_ctx *ctx = hctx->ctxs[bitnr];
+	enum hctx_type type = hctx->type;
 
 	spin_lock(&ctx->lock);
-	if (!list_empty(&ctx->rq_list)) {
-		dispatch_data->rq = list_entry_rq(ctx->rq_list.next);
+	if (!list_empty(&ctx->rq_lists[type])) {
+		dispatch_data->rq = list_entry_rq(ctx->rq_lists[type].next);
 		list_del_init(&dispatch_data->rq->queuelist);
-		if (list_empty(&ctx->rq_list))
+		if (list_empty(&ctx->rq_lists[type]))
 			sbitmap_clear_bit(sb, bitnr);
 	}
 	spin_unlock(&ctx->lock);
@@ -1608,15 +1610,16 @@ static inline void __blk_mq_insert_req_list(struct blk_mq_hw_ctx *hctx,
 					    bool at_head)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
+	enum hctx_type type = hctx->type;
 
 	lockdep_assert_held(&ctx->lock);
 
 	trace_block_rq_insert(hctx->queue, rq);
 
 	if (at_head)
-		list_add(&rq->queuelist, &ctx->rq_list);
+		list_add(&rq->queuelist, &ctx->rq_lists[type]);
 	else
-		list_add_tail(&rq->queuelist, &ctx->rq_list);
+		list_add_tail(&rq->queuelist, &ctx->rq_lists[type]);
 }
 
 void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
@@ -1651,6 +1654,7 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 
 {
 	struct request *rq;
+	enum hctx_type type = hctx->type;
 
 	/*
 	 * preemption doesn't flush plug list, so it's possible ctx->cpu is
@@ -1662,7 +1666,7 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	}
 
 	spin_lock(&ctx->lock);
-	list_splice_tail_init(list, &ctx->rq_list);
+	list_splice_tail_init(list, &ctx->rq_lists[type]);
 	blk_mq_hctx_mark_pending(hctx, ctx);
 	spin_unlock(&ctx->lock);
 }
@@ -2200,13 +2204,15 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	struct blk_mq_hw_ctx *hctx;
 	struct blk_mq_ctx *ctx;
 	LIST_HEAD(tmp);
+	enum hctx_type type;
 
 	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
 	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
+	type = hctx->type;
 
 	spin_lock(&ctx->lock);
-	if (!list_empty(&ctx->rq_list)) {
-		list_splice_init(&ctx->rq_list, &tmp);
+	if (!list_empty(&ctx->rq_lists[type])) {
+		list_splice_init(&ctx->rq_lists[type], &tmp);
 		blk_mq_hctx_clear_pending(hctx, ctx);
 	}
 	spin_unlock(&ctx->lock);
@@ -2343,10 +2349,14 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 	for_each_possible_cpu(i) {
 		struct blk_mq_ctx *__ctx = per_cpu_ptr(q->queue_ctx, i);
 		struct blk_mq_hw_ctx *hctx;
+		int k;
 
 		__ctx->cpu = i;
+
 		spin_lock_init(&__ctx->lock);
-		INIT_LIST_HEAD(&__ctx->rq_list);
+		for (k = HCTX_TYPE_DEFAULT; k < HCTX_MAX_TYPES; k++) {
+			INIT_LIST_HEAD(&__ctx->rq_lists[k]);
+		}
 		__ctx->queue = q;
 
 		/*
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d1ed096723fb..d943d46b0785 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -18,8 +18,8 @@ struct blk_mq_ctxs {
 struct blk_mq_ctx {
 	struct {
 		spinlock_t		lock;
-		struct list_head	rq_list;
-	}  ____cacheline_aligned_in_smp;
+		struct list_head	rq_lists[HCTX_MAX_TYPES];
+	} ____cacheline_aligned_in_smp;
 
 	unsigned int		cpu;
 	unsigned short		index_hw[HCTX_MAX_TYPES];

-- 
Jens Axboe

