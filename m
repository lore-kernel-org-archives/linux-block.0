Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6F5C77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 07:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDJHrD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 03:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDJHrC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 03:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188D73C18
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 00:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A777161176
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 07:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04980C433EF;
        Mon, 10 Apr 2023 07:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681112820;
        bh=Xwl7g/ulELBgl0vGZV2eZXmUUiy5oq2HNrfFOvLymbo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KrrTOnmOGJaA8ZTJy4hetUFCN1JenLmZ6bAw0TizjMm2zL+UzgQjWgzflm43lpcoh
         xU7yAtuj65dKZrcb6QmVFUlfJBz6qS7kjJxgK44ttdZog62YRl8wjSJBVAhHAyjIL3
         FKnkUbFrkCPUFCQ3XRIZ/iGQGgLNulJU39yjoI2pb/usBBdBfre3MJ3r21tyWYxSOb
         92JOBrSXMkMvSLAoBLtmxGMBfJwTDvJKD0xkoMvIwiQni774Cjo3JbW9TmstHNcDpz
         es2mdQ+jioB1QFPRwE+H5z8INLrV7XKpIZKlQEBfJ2Cw34E1uc6L0xyqGLSgiNvm2I
         LaWQEmKrq3khg==
Message-ID: <af4aeeea-79b2-8b0d-df8b-63f5ae6752d7@kernel.org>
Date:   Mon, 10 Apr 2023 16:46:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 02/12] block: Send flush requests to the I/O scheduler
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-3-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230407235822.1672286-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/23 08:58, Bart Van Assche wrote:
> Prevent that zoned writes with the FUA flag set are reordered against each
> other or against other zoned writes. Separate the I/O scheduler members
> from the flush members in struct request since with this patch applied a
> request may pass through both an I/O scheduler and the flush machinery.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-flush.c      |  3 ++-
>  block/blk-mq.c         | 11 ++++-------
>  block/mq-deadline.c    |  2 +-
>  include/linux/blk-mq.h | 27 +++++++++++----------------
>  4 files changed, 18 insertions(+), 25 deletions(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 53202eff545e..e0cf153388d8 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -432,7 +432,8 @@ void blk_insert_flush(struct request *rq)
>  	 */
>  	if ((policy & REQ_FSEQ_DATA) &&
>  	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
> -		blk_mq_request_bypass_insert(rq, false, true);
> +		blk_mq_sched_insert_request(rq, /*at_head=*/false,
> +					    /*run_queue=*/true, /*async=*/true);
>  		return;
>  	}
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index fefc9a728e0e..250556546bbf 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -390,8 +390,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  		INIT_HLIST_NODE(&rq->hash);
>  		RB_CLEAR_NODE(&rq->rb_node);
>  
> -		if (!op_is_flush(data->cmd_flags) &&
> -		    e->type->ops.prepare_request) {
> +		if (e->type->ops.prepare_request) {
>  			e->type->ops.prepare_request(rq);
>  			rq->rq_flags |= RQF_ELVPRIV;
>  		}
> @@ -452,13 +451,11 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
>  		data->rq_flags |= RQF_ELV;
>  
>  		/*
> -		 * Flush/passthrough requests are special and go directly to the
> -		 * dispatch list. Don't include reserved tags in the
> -		 * limiting, as it isn't useful.
> +		 * Do not limit the depth for passthrough requests nor for
> +		 * requests with a reserved tag.
>  		 */
> -		if (!op_is_flush(data->cmd_flags) &&
> +		if (e->type->ops.limit_depth &&
>  		    !blk_op_is_passthrough(data->cmd_flags) &&
> -		    e->type->ops.limit_depth &&
>  		    !(data->flags & BLK_MQ_REQ_RESERVED))
>  			e->type->ops.limit_depth(data->cmd_flags, data);
>  	}
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index f10c2a0d18d4..d885ccf49170 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -789,7 +789,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	prio = ioprio_class_to_prio[ioprio_class];
>  	per_prio = &dd->per_prio[prio];
> -	if (!rq->elv.priv[0]) {
> +	if (!rq->elv.priv[0] && !(rq->rq_flags & RQF_FLUSH_SEQ)) {
>  		per_prio->stats.inserted++;
>  		rq->elv.priv[0] = (void *)(uintptr_t)1;
>  	}

Given that this change has nothing specific to zoned devices, you could rewrite
the commit message to mention that. And are bfq and kyber OK with this change as
well ?

Also, to be consistent with this change, shouldn't blk_mq_sched_bypass_insert()
be updated as well ? That function is called from blk_mq_sched_insert_request().

> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 06caacd77ed6..5e6c79ad83d2 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -169,25 +169,20 @@ struct request {
>  		void *completion_data;
>  	};
>  
> -
>  	/*
>  	 * Three pointers are available for the IO schedulers, if they need
> -	 * more they have to dynamically allocate it.  Flush requests are
> -	 * never put on the IO scheduler. So let the flush fields share
> -	 * space with the elevator data.
> +	 * more they have to dynamically allocate it.
>  	 */
> -	union {
> -		struct {
> -			struct io_cq		*icq;
> -			void			*priv[2];
> -		} elv;
> -
> -		struct {
> -			unsigned int		seq;
> -			struct list_head	list;
> -			rq_end_io_fn		*saved_end_io;
> -		} flush;
> -	};
> +	struct {
> +		struct io_cq		*icq;
> +		void			*priv[2];
> +	} elv;
> +
> +	struct {
> +		unsigned int		seq;
> +		struct list_head	list;
> +		rq_end_io_fn		*saved_end_io;
> +	} flush;
>  
>  	union {
>  		struct __call_single_data csd;

