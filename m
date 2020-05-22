Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CEAC433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 09:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3515F207CB
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 09:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgEVJRS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 05:17:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:50558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgEVJRR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 05:17:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9E09BB204D;
        Fri, 22 May 2020 09:17:18 +0000 (UTC)
Subject: Re: [PATCH 4/6] blk-mq: open code __blk_mq_alloc_request in
 blk_mq_alloc_request_hctx
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200520170635.2094101-1-hch@lst.de>
 <20200520170635.2094101-5-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <737b4159-7059-2b85-e870-d2c9a763d452@suse.de>
Date:   Fri, 22 May 2020 11:17:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520170635.2094101-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/20 7:06 PM, Christoph Hellwig wrote:
> blk_mq_alloc_request_hctx is only used for NVMeoF connect commands, so
> tailor it to the specific requirements, and don't both the general

bother?

> fast path code with its special twinkles.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq.c | 44 +++++++++++++++++++++++---------------------
>   1 file changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1ffbc5d9e7cfe..42aee2978464b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -351,21 +351,13 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
>   {
>   	struct request_queue *q = data->q;
>   	struct elevator_queue *e = q->elevator;
> -	unsigned int tag;
> -	bool clear_ctx_on_error = false;
>   	u64 alloc_time_ns = 0;
> +	unsigned int tag;
>   
>   	/* alloc_time includes depth and tag waits */
>   	if (blk_queue_rq_alloc_time(q))
>   		alloc_time_ns = ktime_get_ns();
>   
> -	if (likely(!data->ctx)) {
> -		data->ctx = blk_mq_get_ctx(q);
> -		clear_ctx_on_error = true;
> -	}
> -	if (likely(!data->hctx))
> -		data->hctx = blk_mq_map_queue(q, data->cmd_flags,
> -						data->ctx);
>   	if (data->cmd_flags & REQ_NOWAIT)
>   		data->flags |= BLK_MQ_REQ_NOWAIT;
>   
> @@ -381,17 +373,16 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
>   		    e->type->ops.limit_depth &&
>   		    !(data->flags & BLK_MQ_REQ_RESERVED))
>   			e->type->ops.limit_depth(data->cmd_flags, data);
> -	} else {
> -		blk_mq_tag_busy(data->hctx);
>   	}
>   
> +	data->ctx = blk_mq_get_ctx(q);
> +	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
> +	if (!(data->flags & BLK_MQ_REQ_INTERNAL))
> +		blk_mq_tag_busy(data->hctx);
> +
>   	tag = blk_mq_get_tag(data);
> -	if (tag == BLK_MQ_TAG_FAIL) {
> -		if (clear_ctx_on_error)
> -			data->ctx = NULL;
> +	if (tag == BLK_MQ_TAG_FAIL)
>   		return NULL;
> -	}
> -
>   	return blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
>   }
>   
> @@ -431,17 +422,22 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   		.flags		= flags,
>   		.cmd_flags	= op,
>   	};
> -	struct request *rq;
> +	u64 alloc_time_ns = 0;
>   	unsigned int cpu;
> +	unsigned int tag;
>   	int ret;
>   
> +	/* alloc_time includes depth and tag waits */
> +	if (blk_queue_rq_alloc_time(q))
> +		alloc_time_ns = ktime_get_ns();
> +
>   	/*
>   	 * If the tag allocator sleeps we could get an allocation for a
>   	 * different hardware context.  No need to complicate the low level
>   	 * allocator for this for the rare use case of a command tied to
>   	 * a specific queue.
>   	 */
> -	if (WARN_ON_ONCE(!(flags & BLK_MQ_REQ_NOWAIT)))
> +	if (WARN_ON_ONCE(!(flags & (BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED))))
>   		return ERR_PTR(-EINVAL);
>   
>   	if (hctx_idx >= q->nr_hw_queues)
> @@ -462,11 +458,17 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
>   	data.ctx = __blk_mq_get_ctx(q, cpu);
>   
> +	if (q->elevator)
> +		data.flags |= BLK_MQ_REQ_INTERNAL;
> +	else
> +		blk_mq_tag_busy(data.hctx);
> +
>   	ret = -EWOULDBLOCK;
> -	rq = __blk_mq_alloc_request(&data);
> -	if (!rq)
> +	tag = blk_mq_get_tag(&data);
> +	if (tag == BLK_MQ_TAG_FAIL)
>   		goto out_queue_exit;
> -	return rq;
> +	return blk_mq_rq_ctx_init(&data, tag, alloc_time_ns);
> +
>   out_queue_exit:
>   	blk_queue_exit(q);
>   	return ERR_PTR(ret);
> 
Other than that:

Reviewed-by: Hannes Reinecke <hare@suse.de

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
