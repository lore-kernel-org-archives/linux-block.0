Return-Path: <SRS0=otcQ=3E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEA4C33CB1
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 12:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435B62077B
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 12:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ji3A+DPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgAOMIO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:08:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42337 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726165AbgAOMIO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 07:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579090091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yci8QqmUG9eX0bqdhdqmXnydR/+o5Bc1jvXfsSImcjU=;
        b=Ji3A+DPjVzt9mltAV4TGPZwB9Ew1NsX++ur9I57/LfPt0Gu4pgJ7jt7sUNewLUI30qhbWo
        17WBRcBo+pLKd7jOfqCP51Xn7EYgLwlC8kRyfCrAjVOouDO0BGizO660SDp6ED+pAUcTlR
        cC9zkpWVUCOMh6/W8yBJYuVEzBg4yfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-fEGBndkcMICk-5N39HdhKw-1; Wed, 15 Jan 2020 07:08:08 -0500
X-MC-Unique: fEGBndkcMICk-5N39HdhKw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B452410054E3;
        Wed, 15 Jan 2020 12:08:07 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 103955D9C5;
        Wed, 15 Jan 2020 12:08:02 +0000 (UTC)
Date:   Wed, 15 Jan 2020 20:07:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 6/6] blk-mq: allocate tags in batches
Message-ID: <20200115120757.GA30398@ming.t460p>
References: <20200107163037.31745-1-axboe@kernel.dk>
 <20200107163037.31745-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107163037.31745-7-axboe@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 07, 2020 at 09:30:37AM -0700, Jens Axboe wrote:
> Instead of grabbing tags one by one, grab a batch and store the local
> cache in the software queue. Then subsequent tag allocations can just
> grab free tags from there, without having to hit the shared tag map.
> 
> We flush these batches out if we run out of tags on the hardware queue.
> The intent here is this should rarely happen.
> 
> This works very well in practice, with anywhere from 40-60 batch counts
> seen regularly in testing.

Could you describe your test a bit? I am just wondering if multi-task IO
can perform well as before.

> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq-debugfs.c |  18 +++++++
>  block/blk-mq-tag.c     | 104 ++++++++++++++++++++++++++++++++++++++++-
>  block/blk-mq-tag.h     |   3 ++
>  block/blk-mq.c         |  16 +++++--
>  block/blk-mq.h         |   5 ++
>  include/linux/blk-mq.h |   2 +
>  6 files changed, 144 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index e789f830ff59..914be72d080e 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -659,6 +659,23 @@ CTX_RQ_SEQ_OPS(default, HCTX_TYPE_DEFAULT);
>  CTX_RQ_SEQ_OPS(read, HCTX_TYPE_READ);
>  CTX_RQ_SEQ_OPS(poll, HCTX_TYPE_POLL);
>  
> +static ssize_t ctx_tag_hit_write(void *data, const char __user *buf,
> +				    size_t count, loff_t *ppos)
> +{
> +	struct blk_mq_ctx *ctx = data;
> +
> +	ctx->tag_hit = ctx->tag_refill = 0;
> +	return count;
> +}
> +
> +static int ctx_tag_hit_show(void *data, struct seq_file *m)
> +{
> +	struct blk_mq_ctx *ctx = data;
> +
> +	seq_printf(m, "hit=%lu refills=%lu\n", ctx->tag_hit, ctx->tag_refill);
> +	return 0;
> +}
> +
>  static int ctx_dispatched_show(void *data, struct seq_file *m)
>  {
>  	struct blk_mq_ctx *ctx = data;
> @@ -800,6 +817,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
>  	{"read_rq_list", 0400, .seq_ops = &ctx_read_rq_list_seq_ops},
>  	{"poll_rq_list", 0400, .seq_ops = &ctx_poll_rq_list_seq_ops},
>  	{"dispatched", 0600, ctx_dispatched_show, ctx_dispatched_write},
> +	{"tag_hit", 0600, ctx_tag_hit_show, ctx_tag_hit_write},
>  	{"merged", 0600, ctx_merged_show, ctx_merged_write},
>  	{"completed", 0600, ctx_completed_show, ctx_completed_write},
>  	{},
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index fbacde454718..94c1f16c6c71 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -99,6 +99,100 @@ static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
>  		return __sbitmap_queue_get(bt);
>  }
>  
> +static void ctx_flush_ipi(void *data)
> +{
> +	struct blk_mq_hw_ctx *hctx = data;
> +	struct sbitmap_queue *bt = &hctx->tags->bitmap_tags;
> +	struct blk_mq_ctx *ctx;
> +	unsigned int i;
> +
> +	ctx = __blk_mq_get_ctx(hctx->queue, smp_processor_id());
> +
> +	for (i = 0; i < hctx->queue->tag_set->nr_maps; i++) {
> +		struct blk_mq_ctx_type *type = &ctx->type[i];
> +
> +		if (!type->tags)
> +			continue;
> +
> +		__sbitmap_queue_clear_batch(bt, type->tag_offset, type->tags);
> +		type->tags = 0;
> +	}
> +	atomic_dec(&hctx->flush_pending);
> +}
> +
> +void blk_mq_tag_ctx_flush_batch(struct blk_mq_hw_ctx *hctx,
> +				struct blk_mq_ctx *ctx)
> +{
> +	atomic_inc(&hctx->flush_pending);
> +	smp_call_function_single(ctx->cpu, ctx_flush_ipi, hctx, false);
> +}
> +
> +static void blk_mq_tag_flush_batches(struct blk_mq_hw_ctx *hctx)
> +{
> +	if (atomic_cmpxchg(&hctx->flush_pending, 0, hctx->nr_ctx))
> +		return;
> +	preempt_disable();
> +	if (cpumask_test_cpu(smp_processor_id(), hctx->cpumask))
> +		ctx_flush_ipi(hctx);
> +	smp_call_function_many(hctx->cpumask, ctx_flush_ipi, hctx, false);
> +	preempt_enable();
> +}
> +
> +void blk_mq_tag_queue_flush_batches(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned int i;
> +
> +	queue_for_each_hw_ctx(q, hctx, i)
> +		blk_mq_tag_flush_batches(hctx);
> +}
> +
> +static int blk_mq_get_tag_batch(struct blk_mq_alloc_data *data)
> +{
> +	struct blk_mq_hw_ctx *hctx = data->hctx;
> +	struct blk_mq_ctx_type *type;
> +	struct blk_mq_ctx *ctx = data->ctx;
> +	struct blk_mq_tags *tags;
> +	struct sbitmap_queue *bt;
> +	int tag = -1;
> +
> +	if (!ctx || (data->flags & BLK_MQ_REQ_INTERNAL))
> +		return -1;
> +
> +	tags = hctx->tags;
> +	bt = &tags->bitmap_tags;
> +	/* don't do batches for round-robin or (very) sparse maps */
> +	if (bt->round_robin || bt->sb.shift < ilog2(BITS_PER_LONG) - 1)
> +		return -1;
> +
> +	/* we could make do with preempt disable, but we need to block flush */
> +	local_irq_disable();
> +	if (unlikely(ctx->cpu != smp_processor_id()))
> +		goto out;
> +
> +	type = &ctx->type[hctx->type];
> +
> +	if (type->tags) {
> +get_tag:
> +		ctx->tag_hit++;
> +
> +		tag = __ffs(type->tags);
> +		type->tags &= ~(1UL << tag);
> +		tag += type->tag_offset;
> +out:
> +		local_irq_enable();
> +		return tag;
> +	}
> +
> +	/* no current tag cache, attempt to refill a batch */
> +	if (!__sbitmap_queue_get_batch(bt, &type->tag_offset, &type->tags)) {
> +		ctx->tag_refill++;
> +		goto get_tag;
> +	}
> +
> +	goto out;
> +}
> +
>  unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  {
>  	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
> @@ -116,8 +210,13 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  		bt = &tags->breserved_tags;
>  		tag_offset = 0;
>  	} else {
> -		bt = &tags->bitmap_tags;
>  		tag_offset = tags->nr_reserved_tags;
> +
> +		tag = blk_mq_get_tag_batch(data);
> +		if (tag != -1)
> +			goto found_tag;
> +
> +		bt = &tags->bitmap_tags;
>  	}
>  
>  	tag = __blk_mq_get_tag(data, bt);
> @@ -152,6 +251,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  		if (tag != -1)
>  			break;
>  
> +		if (!(data->flags & BLK_MQ_REQ_RESERVED))
> +			blk_mq_tag_flush_batches(data->hctx);
> +
>  		bt_prev = bt;
>  		io_schedule();
>  
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 15bc74acb57e..b5964fff1630 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -34,6 +34,9 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>  extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
>  void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>  		void *priv);
> +void blk_mq_tag_queue_flush_batches(struct request_queue *q);
> +void blk_mq_tag_ctx_flush_batch(struct blk_mq_hw_ctx *hctx,
> +				struct blk_mq_ctx *ctx);
>  
>  static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
>  						 struct blk_mq_hw_ctx *hctx)
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index cc48a0ffa5ec..81140f61a7c9 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2255,6 +2255,8 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>  	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
>  	type = hctx->type;
>  
> +	blk_mq_tag_ctx_flush_batch(hctx, ctx);

When blk_mq_hctx_notify_dead() is called, the 'cpu' has been offline
already, so the flush via IPI may not work as expected.


Thanks,
Ming

