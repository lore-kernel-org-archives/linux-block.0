Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33164 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbcISSyW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2016 14:54:22 -0400
Received: by mail-pa0-f52.google.com with SMTP id hm5so19075126pac.0
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2016 11:54:22 -0700 (PDT)
Date: Mon, 19 Sep 2016 11:54:20 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/14] blk-mq: Fix hardware context data node selection
Message-ID: <20160919185420.GG21803@vader>
References: <cover.1474183901.git.agordeev@redhat.com>
 <2ca00b95f42aefc5423ab09db0c50fcd3e5ee578.1474183901.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2ca00b95f42aefc5423ab09db0c50fcd3e5ee578.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Sep 18, 2016 at 09:37:16AM +0200, Alexander Gordeev wrote:
> CC: linux-block@vger.kernel.org
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

Makes sense.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> ---
>  block/blk-mq.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a38fd2e..9fbfe31 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1712,13 +1712,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
>  		struct blk_mq_tag_set *set,
>  		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
>  {
> -	int node;
> +	int node = hctx->numa_node;
>  	unsigned flush_start_tag = set->queue_depth;
>  
> -	node = hctx->numa_node;
> -	if (node == NUMA_NO_NODE)
> -		node = hctx->numa_node = set->numa_node;
> -
>  	INIT_WORK(&hctx->run_work, blk_mq_run_work_fn);
>  	INIT_DELAYED_WORK(&hctx->delay_work, blk_mq_delay_work_fn);
>  	spin_lock_init(&hctx->lock);
> @@ -1999,6 +1995,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  			break;
>  
>  		node = blk_mq_hw_queue_to_node(q->mq_map, i);
> +		if (node == NUMA_NO_NODE)
> +			node = set->numa_node;
> +
>  		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
>  					GFP_KERNEL, node);
>  		if (!hctxs[i])
> -- 
> 1.8.3.1
> 

-- 
Omar
