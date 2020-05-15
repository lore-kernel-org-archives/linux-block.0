Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5292AC433E0
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 16:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356CA2070A
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 16:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgEOQKN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 12:10:13 -0400
Received: from verein.lst.de ([213.95.11.211]:57536 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgEOQKN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 12:10:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8A1B568C7B; Fri, 15 May 2020 18:10:07 +0200 (CEST)
Date:   Fri, 15 May 2020 18:10:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 5/6] blk-mq: disable preempt during allocating request
 tag
Message-ID: <20200515161006.GA32323@lst.de>
References: <20200515014153.2403464-1-ming.lei@redhat.com> <20200515014153.2403464-6-ming.lei@redhat.com> <20200515153847.GB29610@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515153847.GB29610@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 15, 2020 at 05:38:47PM +0200, Christoph Hellwig wrote:
> On Fri, May 15, 2020 at 09:41:52AM +0800, Ming Lei wrote:
> > Disable preempt for a little while during allocating request tag, so
> > request's tag(internal tag) is always allocated on the cpu of data->ctx,
> > prepare for improving to handle cpu hotplug during allocating request.
> > 
> > In the following patch, hctx->state will be checked to see if it becomes
> > inactive which is always set on the last CPU of hctx->cpumask.
> 
> I like the idea, but I hate the interface.  I really think we need
> to moving assigning the ctx and hctx entirely into blk_mq_get_tag,
> and then just unconditionally disable preemption in there.

Maybe something vaguely like this (on top of the previous patch):


diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index c8e34c1f547fe..f75be6c431ac6 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -111,7 +111,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	if (data->flags & BLK_MQ_REQ_RESERVED) {
 		if (unlikely(!tags->nr_reserved_tags)) {
 			WARN_ON_ONCE(1);
-			return BLK_MQ_TAG_FAIL;
+			goto fail;
 		}
 		bt = &tags->breserved_tags;
 		tag_offset = 0;
@@ -120,12 +120,22 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		tag_offset = tags->nr_reserved_tags;
 	}
 
+	if (!data->driver_tag) {
+		preempt_disable();
+		data->ctx = blk_mq_get_ctx(data->q);
+		data->hctx = blk_mq_map_queue(data->q, data->cmd_flags,
+				data->ctx);
+	}
+
+	if (!(data->flags & BLK_MQ_REQ_INTERNAL))
+		data->shared = blk_mq_tag_busy(data->hctx);
+
 	tag = __blk_mq_get_tag(data, bt);
 	if (tag != -1)
 		goto found_tag;
 
 	if (data->flags & BLK_MQ_REQ_NOWAIT)
-		return BLK_MQ_TAG_FAIL;
+		goto fail;
 
 	ws = bt_wait_ptr(bt, data->hctx);
 	do {
@@ -152,14 +162,14 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != -1)
 			break;
 
-		if (data->preempt_disabled)
+		if (!data->driver_tag)
 			preempt_enable();
 		bt_prev = bt;
 		io_schedule();
 
 		sbitmap_finish_wait(bt, ws, &wait);
 
-		if (data->preempt_disabled)
+		if (!data->driver_tag)
 			preempt_disable();
 		data->ctx = blk_mq_get_ctx(data->q);
 		data->hctx = blk_mq_map_queue(data->q, data->cmd_flags,
@@ -184,17 +194,20 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	sbitmap_finish_wait(bt, ws, &wait);
 
 found_tag:
-	/*
-	 * we are in request allocation, check if the current hctx is inactive.
-	 * If yes, give up this allocation. We will retry on another new online
-	 * CPU.
-	 */
-	if (data->preempt_disabled && unlikely(test_bit(BLK_MQ_S_INACTIVE,
-					&data->hctx->state))) {
-		blk_mq_put_tag(tags, data->ctx, tag + tag_offset);
-		return BLK_MQ_TAG_FAIL;
+	if (!data->driver_tag) {
+		/* fail allocations for inactive contexts. */
+		if (unlikely(!test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state)))
+			goto fail_free_tag;
+		preempt_enable();
 	}
 	return tag + tag_offset;
+
+fail_free_tag:
+	blk_mq_put_tag(tags, data->ctx, tag + tag_offset);
+fail:
+	data->ctx = NULL;
+	data->hctx = NULL;
+	return BLK_MQ_TAG_FAIL;
 }
 
 void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 52b8917ea7cb6..298557d00e081 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -347,10 +347,6 @@ static void __blk_mq_get_request(struct blk_mq_alloc_data *data)
 
 	WARN_ON_ONCE(data->ctx || data->hctx);
 
-	preempt_disable();
-	data->preempt_disabled = true;
-	data->ctx = blk_mq_get_ctx(q);
-	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
 
@@ -366,15 +362,10 @@ static void __blk_mq_get_request(struct blk_mq_alloc_data *data)
 		    e->type->ops.limit_depth &&
 		    !(data->flags & BLK_MQ_REQ_RESERVED))
 			e->type->ops.limit_depth(data->cmd_flags, data);
-	} else {
-		blk_mq_tag_busy(data->hctx);
 	}
 
 	tag = blk_mq_get_tag(data);
-	preempt_enable();
 	if (tag == BLK_MQ_TAG_FAIL) {
-		data->ctx = NULL;
-		data->hctx = NULL;
 		blk_queue_exit(q);
 		return;
 	}
@@ -1042,8 +1033,8 @@ bool blk_mq_get_driver_tag(struct request *rq)
 		.hctx = rq->mq_hctx,
 		.flags = BLK_MQ_REQ_NOWAIT,
 		.cmd_flags = rq->cmd_flags,
+		.driver_tag = true,
 	};
-	bool shared;
 
 	if (rq->tag != -1)
 		return true;
@@ -1051,10 +1042,9 @@ bool blk_mq_get_driver_tag(struct request *rq)
 	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
 		data.flags |= BLK_MQ_REQ_RESERVED;
 
-	shared = blk_mq_tag_busy(data.hctx);
 	rq->tag = blk_mq_get_tag(&data);
 	if (rq->tag >= 0) {
-		if (shared) {
+		if (data.shared) {
 			rq->rq_flags |= RQF_MQ_INFLIGHT;
 			atomic_inc(&data.hctx->nr_active);
 		}
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e07be009831e9..563d096ea0cf4 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -153,14 +153,15 @@ struct blk_mq_alloc_data {
 	blk_mq_req_flags_t flags;
 	unsigned int shallow_depth;
 	unsigned int cmd_flags;
-	bool preempt_disabled;
+	bool driver_tag;
 
 	/* input & output parameter */
 	struct blk_mq_ctx *ctx;
 	struct blk_mq_hw_ctx *hctx;
 
-	/* output parameter for __blk_mq_get_request */
+	/* output parameters */
 	struct request *rq;
+	bool shared;
 };
 
 static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
