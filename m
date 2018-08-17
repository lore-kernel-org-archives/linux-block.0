Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41456 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeHQVN6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 17:13:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id s15-v6so1153439pgv.8
        for <linux-block@vger.kernel.org>; Fri, 17 Aug 2018 11:09:37 -0700 (PDT)
Date: Fri, 17 Aug 2018 11:09:35 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH] block: remove duplicate initialization
Message-ID: <20180817180935.GC22101@vader>
References: <20180816224529.3401-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180816224529.3401-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 16, 2018 at 03:45:29PM -0700, Chaitanya Kulkarni wrote:
> This patch removes the duplicate initialization of q->queue_head
> in the blk_alloc_queue_node(). This removes the 2nd initialization
> so that we preserve the initialization order same as declaration
> present in struct request_queue.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  block/blk-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 21c7cb35d3b4..dee56c282efb 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1036,7 +1036,6 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
>  		    laptop_mode_timer_fn, 0);
>  	timer_setup(&q->timeout, blk_rq_timed_out_timer, 0);
>  	INIT_WORK(&q->timeout_work, NULL);
> -	INIT_LIST_HEAD(&q->queue_head);
>  	INIT_LIST_HEAD(&q->timeout_list);
>  	INIT_LIST_HEAD(&q->icq_list);
>  #ifdef CONFIG_BLK_CGROUP
> -- 
> 2.17.0
> 
