Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34048 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbcISTAb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2016 15:00:31 -0400
Received: by mail-pa0-f52.google.com with SMTP id wk8so51305019pab.1
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2016 12:00:30 -0700 (PDT)
Date: Mon, 19 Sep 2016 12:00:28 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 07/14] blk-mq: Cleanup a loop exit condition
Message-ID: <20160919190028.GH21803@vader>
References: <cover.1474183901.git.agordeev@redhat.com>
 <28367fd20927339e103d7e5afef31e2988e7ee78.1474183901.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <28367fd20927339e103d7e5afef31e2988e7ee78.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Sep 18, 2016 at 09:37:17AM +0200, Alexander Gordeev wrote:
> CC: linux-block@vger.kernel.org
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

So set->nr_hw_queues is always >= q->nr_hw_queues, right?

Reviewed-by: Omar Sandoval <osandov@fb.com>

> ---
>  block/blk-mq.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9fbfe31..b2ef8f5 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1681,16 +1681,13 @@ static void blk_mq_exit_hctx(struct request_queue *q,
>  }
>  
>  static void blk_mq_exit_hw_queues(struct request_queue *q,
> -		struct blk_mq_tag_set *set, int nr_queue)
> +		struct blk_mq_tag_set *set)
>  {
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned int i;
>  
> -	queue_for_each_hw_ctx(q, hctx, i) {
> -		if (i == nr_queue)
> -			break;
> +	queue_for_each_hw_ctx(q, hctx, i)
>  		blk_mq_exit_hctx(q, set, hctx, i);
> -	}
>  }
>  
>  static void blk_mq_free_hw_queues(struct request_queue *q,
> @@ -2124,7 +2121,7 @@ void blk_mq_free_queue(struct request_queue *q)
>  
>  	blk_mq_del_queue_tag_set(q);
>  
> -	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
> +	blk_mq_exit_hw_queues(q, set);
>  	blk_mq_free_hw_queues(q, set);
>  }
>  
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Omar
