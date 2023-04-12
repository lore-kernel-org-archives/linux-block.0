Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C98C77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjDLHQl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDLHQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:16:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5202708
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B45B62EB6
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA494C433D2;
        Wed, 12 Apr 2023 07:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681283798;
        bh=nemYaOHPhQab48YmRMLlz8JvN6729km5XswNyZV+wCk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hjYxKCvECrdSOg0eTGI4PETQoCKe0gmW0MRjfXNT6Qy8wVFog51epr/nMlTC/yKVy
         R3C3q5dvPG0Efom+TLCkbUVm8sHSOJ4YtBu9zpjSGdYTonDx1EM6EGUwhaPfuVgLXx
         j4Q1BjraFBXSLK+tdDdH8WWRJPnlQf1nvfco7s7NYSRf1kOA/GYGiXPY11gJH5fNpc
         p/Wx1SyIlwBYMAmqDc0nQq+DQh9JWP2qST3ph9LDjPvQust3vwIKaNFOAXkvoNGb90
         Dzk39ah40Cs0GqI6Seuf49erihtlXS2zSeLYUUSmErOIczrbG9fFuRA1ZB+idXcIUR
         u5fWc2C6yF30g==
Message-ID: <fd0e02c6-8fbb-cb7b-4925-331c132aeb7a@kernel.org>
Date:   Wed, 12 Apr 2023 16:16:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 08/18] blk-mq: fold __blk_mq_insert_req_list into
 blk_mq_insert_request
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-9-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412053248.601961-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 14:32, Christoph Hellwig wrote:
> Remove this very small helper and fold it into the only caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 103caf1bae2769..7e9f7d00452f11 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2446,23 +2446,6 @@ static void blk_mq_run_work_fn(struct work_struct *work)
>  	__blk_mq_run_hw_queue(hctx);
>  }
>  
> -static inline void __blk_mq_insert_req_list(struct blk_mq_hw_ctx *hctx,
> -					    struct request *rq,
> -					    bool at_head)
> -{
> -	struct blk_mq_ctx *ctx = rq->mq_ctx;
> -	enum hctx_type type = hctx->type;
> -
> -	lockdep_assert_held(&ctx->lock);
> -
> -	trace_block_rq_insert(rq);
> -
> -	if (at_head)
> -		list_add(&rq->queuelist, &ctx->rq_lists[type]);
> -	else
> -		list_add_tail(&rq->queuelist, &ctx->rq_lists[type]);
> -}
> -
>  /**
>   * blk_mq_request_bypass_insert - Insert a request at dispatch list.
>   * @rq: Pointer to request to be inserted.
> @@ -2586,8 +2569,14 @@ static void blk_mq_insert_request(struct request *rq, bool at_head,
>  		list_add(&rq->queuelist, &list);
>  		e->type->ops.insert_requests(hctx, &list, at_head);
>  	} else {
> +		trace_block_rq_insert(rq);

Shouldn't we keep the trace call under ctx->lock to preserve precise tracing ?

> +
>  		spin_lock(&ctx->lock);
> -		__blk_mq_insert_req_list(hctx, rq, at_head);
> +		if (at_head)
> +			list_add(&rq->queuelist, &ctx->rq_lists[hctx->type]);
> +		else
> +			list_add_tail(&rq->queuelist,
> +				      &ctx->rq_lists[hctx->type]);
>  		blk_mq_hctx_mark_pending(hctx, ctx);
>  		spin_unlock(&ctx->lock);
>  	}

