Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B1CC433DF
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 15:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4D7F2076A
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 15:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgEOPpJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 11:45:09 -0400
Received: from verein.lst.de ([213.95.11.211]:57396 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgEOPpJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 11:45:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0E35168C65; Fri, 15 May 2020 17:45:04 +0200 (CEST)
Date:   Fri, 15 May 2020 17:45:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/6] blk-mq: improvement CPU hotplug(simplified version)
Message-ID: <20200515154503.GA30414@lst.de>
References: <20200515014153.2403464-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515014153.2403464-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

FYI, I think this could be significantly simplified by stashing
the input bio and output rq into struct blk_mq_alloc_data instead of
creating another structure.  Something like this untested patch on
top of the whole series shows where I'd like to get to:


diff --git a/block/blk-mq.c b/block/blk-mq.c
index bcc894faf4e36..52b8917ea7cb6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -41,10 +41,6 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
-static struct request *__blk_mq_get_request(struct request_queue *q,
-					    struct bio *bio,
-					    struct blk_mq_alloc_data *data);
-
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
@@ -274,8 +270,8 @@ static inline bool blk_mq_need_time_stamp(struct request *rq)
 	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS)) || rq->q->elevator;
 }
 
-static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
-		unsigned int tag, unsigned int op, u64 alloc_time_ns)
+static void blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data, unsigned int tag,
+		unsigned int op, u64 alloc_time_ns)
 {
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct request *rq = tags->static_rqs[tag];
@@ -333,29 +329,13 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 
 	data->ctx->rq_dispatched[op_is_sync(op)]++;
 	refcount_set(&rq->ref, 1);
-	return rq;
-}
-
-struct blk_mq_smp_call_info {
-	struct request_queue *q;
-	struct blk_mq_alloc_data *data;
-	struct request *rq;
-	struct bio *bio;
-};
-
-static void __blk_mq_alloc_request(void *alloc_info)
-{
-	struct blk_mq_smp_call_info *info = alloc_info;
-
-	info->rq = __blk_mq_get_request(info->q, info->bio, info->data);
+	data->rq = rq;
 }
 
-static struct request *__blk_mq_get_request(struct request_queue *q,
-					    struct bio *bio,
-					    struct blk_mq_alloc_data *data)
+static void __blk_mq_get_request(struct blk_mq_alloc_data *data)
 {
+	struct request_queue *q = data->q;
 	struct elevator_queue *e = q->elevator;
-	struct request *rq;
 	unsigned int tag;
 	u64 alloc_time_ns = 0;
 
@@ -365,8 +345,6 @@ static struct request *__blk_mq_get_request(struct request_queue *q,
 	if (blk_queue_rq_alloc_time(q))
 		alloc_time_ns = ktime_get_ns();
 
-	data->q = q;
-
 	WARN_ON_ONCE(data->ctx || data->hctx);
 
 	preempt_disable();
@@ -398,64 +376,61 @@ static struct request *__blk_mq_get_request(struct request_queue *q,
 		data->ctx = NULL;
 		data->hctx = NULL;
 		blk_queue_exit(q);
-		return NULL;
+		return;
 	}
 
-	rq = blk_mq_rq_ctx_init(data, tag, data->cmd_flags, alloc_time_ns);
+	blk_mq_rq_ctx_init(data, tag, data->cmd_flags, alloc_time_ns);
 	if (!op_is_flush(data->cmd_flags)) {
-		rq->elv.icq = NULL;
+		data->rq->elv.icq = NULL;
 		if (e && e->type->ops.prepare_request) {
 			if (e->type->icq_cache)
-				blk_mq_sched_assign_ioc(rq);
+				blk_mq_sched_assign_ioc(data->rq);
 
-			e->type->ops.prepare_request(rq, bio);
-			rq->rq_flags |= RQF_ELVPRIV;
+			e->type->ops.prepare_request(data->rq, data->bio);
+			data->rq->rq_flags |= RQF_ELVPRIV;
 		}
 	}
 	data->hctx->queued++;
-	return rq;
 }
 
-static struct request *blk_mq_get_request(struct request_queue *q,
-					  struct bio *bio,
-					  struct blk_mq_alloc_data *data)
+static void blk_mq_get_request_cb(void *data)
 {
-	int ret;
-	struct blk_mq_smp_call_info info;
-	struct request *rq = __blk_mq_get_request(q, bio, data);
-
-	if (rq)
-		return rq;
+	__blk_mq_get_request(data);
+}
 
-	if (data->flags & BLK_MQ_REQ_NOWAIT)
-		return NULL;
+static int blk_mq_get_request_cpumask(struct blk_mq_alloc_data *data,
+		const cpumask_t *mask)
+{
+	return smp_call_function_any(mask, blk_mq_get_request_cb, data, 1);
+}
 
+static struct request *blk_mq_get_request(struct blk_mq_alloc_data *data)
+{
 	/*
-	 * The allocation fails because of inactive hctx, so retry from
-	 * online cpus.
+	 * For !BLK_MQ_REQ_NOWAIT the allocation only fails due to an inactive
+	 * hctx, so retry from an online CPU.
 	 */
-	info.q = q;
-	info.bio = bio;
-	info.data = data;
-
-	ret = smp_call_function_any(cpu_online_mask, __blk_mq_alloc_request, &info, 1);
-	if (ret)
-		return ERR_PTR(ret);
-	return info.rq;
+	__blk_mq_get_request(data);
+	if (!data->rq && !(data->flags & BLK_MQ_REQ_NOWAIT))
+		blk_mq_get_request_cpumask(data, cpu_online_mask);
+	return data->rq;
 }
 
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 		blk_mq_req_flags_t flags)
 {
-	struct blk_mq_alloc_data alloc_data = { .flags = flags, .cmd_flags = op };
+	struct blk_mq_alloc_data alloc_data = {
+		.q		= q,
+		.flags		= flags,
+		.cmd_flags	= op,
+	};
 	struct request *rq;
 	int ret;
 
 	ret = blk_queue_enter(q, flags);
 	if (ret)
 		return ERR_PTR(ret);
-
-	rq = blk_mq_get_request(q, NULL, &alloc_data);
+	rq = blk_mq_get_request(&alloc_data);
 	blk_queue_exit(q);
 
 	if (!rq)
@@ -469,10 +444,14 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 EXPORT_SYMBOL(blk_mq_alloc_request);
 
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
-	unsigned int op, blk_mq_req_flags_t flags, unsigned int hctx_idx)
+		unsigned int op, blk_mq_req_flags_t flags,
+		unsigned int hctx_idx)
 {
-	struct blk_mq_alloc_data alloc_data = { .flags = flags, .cmd_flags = op };
-	struct blk_mq_smp_call_info info = {.q = q, .data = &alloc_data};
+	struct blk_mq_alloc_data alloc_data = {
+		.q		= q,
+		.flags		= flags,
+		.cmd_flags	= op,
+	};
 	int ret;
 
 	/*
@@ -500,17 +479,9 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		return ERR_PTR(-EXDEV);
 	}
 
-	ret = smp_call_function_any(alloc_data.hctx->cpumask,
-			__blk_mq_alloc_request, &info, 1);
+	blk_mq_get_request_cpumask(&alloc_data, alloc_data.hctx->cpumask);
 	blk_queue_exit(q);
-
-	if (ret)
-		return ERR_PTR(ret);
-
-	if (!info.rq)
-		return ERR_PTR(-EWOULDBLOCK);
-
-	return info.rq;
+	return alloc_data.rq;
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
@@ -2065,7 +2036,9 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int is_sync = op_is_sync(bio->bi_opf);
 	const int is_flush_fua = op_is_flush(bio->bi_opf);
-	struct blk_mq_alloc_data data = { .flags = 0};
+	struct blk_mq_alloc_data data = {
+		.q		= q,
+	};
 	struct request *rq;
 	struct blk_plug *plug;
 	struct request *same_queue_rq = NULL;
@@ -2088,8 +2061,9 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	rq_qos_throttle(q, bio);
 
+	data.bio = bio;
 	data.cmd_flags = bio->bi_opf;
-	rq = blk_mq_get_request(q, bio, &data);
+	rq = blk_mq_get_request(&data);
 	if (unlikely(!rq)) {
 		rq_qos_cleanup(q, bio);
 		if (bio->bi_opf & REQ_NOWAIT)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 5ebc8d8d5a540..e07be009831e9 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -149,6 +149,7 @@ static inline struct blk_mq_ctx *blk_mq_get_ctx(struct request_queue *q)
 struct blk_mq_alloc_data {
 	/* input parameter */
 	struct request_queue *q;
+	struct bio *bio;
 	blk_mq_req_flags_t flags;
 	unsigned int shallow_depth;
 	unsigned int cmd_flags;
@@ -157,6 +158,9 @@ struct blk_mq_alloc_data {
 	/* input & output parameter */
 	struct blk_mq_ctx *ctx;
 	struct blk_mq_hw_ctx *hctx;
+
+	/* output parameter for __blk_mq_get_request */
+	struct request *rq;
 };
 
 static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
