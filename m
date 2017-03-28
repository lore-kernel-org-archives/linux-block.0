Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34488 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753757AbdC1CoA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2017 22:44:00 -0400
Received: by mail-pg0-f66.google.com with SMTP id o123so14833629pga.1
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2017 19:43:59 -0700 (PDT)
Date: Tue, 28 Mar 2017 10:43:54 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] blk-mq: fix leak of q->stats
Message-ID: <20170328024351.GA23217@ming.t460p>
References: <de751892a392533e8e26fffbf72ba7904cfda468.1490636543.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <de751892a392533e8e26fffbf72ba7904cfda468.1490636543.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Mar 27, 2017 at 10:43:58AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> blk_alloc_queue_node() already allocates q->stats, so
> blk_mq_init_allocated_queue() is overwriting it with a new allocation.
> 
> Fixes: a83b576c9c25 ("block: fix stacked driver stats init and free")
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c212b9644a9f..9c6b39bd8358 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2212,10 +2212,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  	/* mark the queue as mq asap */
>  	q->mq_ops = set->ops;
>  
> -	q->stats = blk_alloc_queue_stats();
> -	if (!q->stats)
> -		goto err_exit;
> -
>  	q->poll_cb = blk_stat_alloc_callback(blk_mq_poll_stats_fn,
>  					     blk_stat_rq_ddir, 2, q);
>  	if (!q->poll_cb)
> -- 
> 2.12.1
> 

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

-- 
Ming
