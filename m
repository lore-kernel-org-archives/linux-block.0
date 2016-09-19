Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36707 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbcISSCZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2016 14:02:25 -0400
Received: by mail-pa0-f54.google.com with SMTP id id6so50879842pad.3
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2016 11:02:25 -0700 (PDT)
Date: Mon, 19 Sep 2016 10:57:19 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 09/14] blk-mq: Move duplicating code to blk_mq_exit_hctx()
Message-ID: <20160919175719.GB21803@vader>
References: <cover.1474183901.git.agordeev@redhat.com>
 <08fde52dea32101ca7fffe1ff6e1a4786a7eab2c.1474183901.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <08fde52dea32101ca7fffe1ff6e1a4786a7eab2c.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Sep 18, 2016 at 09:37:19AM +0200, Alexander Gordeev wrote:
> CC: linux-block@vger.kernel.org
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  block/blk-mq.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3efb700..cd32a08 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1678,6 +1678,10 @@ static void blk_mq_exit_hctx(struct request_queue *q,
>  	blk_mq_unregister_cpu_notifier(&hctx->cpu_notifier);
>  	blk_free_flush_queue(hctx->fq);
>  	blk_mq_free_bitmap(&hctx->ctx_map);
> +
> +	free_cpumask_var(hctx->cpumask);
> +	kfree(hctx->ctxs);
> +	kfree(hctx);
>  }
>  
>  static void blk_mq_exit_hw_queues(struct request_queue *q,
> @@ -1686,12 +1690,8 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned int i;
>  
> -	queue_for_each_hw_ctx(q, hctx, i) {
> +	queue_for_each_hw_ctx(q, hctx, i)
>  		blk_mq_exit_hctx(q, set, hctx, i);
> -		free_cpumask_var(hctx->cpumask);
> -		kfree(hctx->ctxs);
> -		kfree(hctx);
> -	}
>  
>  	q->nr_hw_queues = 0;
>  }
> @@ -2018,12 +2018,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  				set->tags[j] = NULL;
>  			}
>  			blk_mq_exit_hctx(q, set, hctx, j);
> -			free_cpumask_var(hctx->cpumask);
>  			kobject_put(&hctx->kobj);

Now this hctx->kobj will be a use-after-free since we just kfreed hctx
in blk_mq_exit_hctx().

> -			kfree(hctx->ctxs);
> -			kfree(hctx);
>  			hctxs[j] = NULL;
> -
>  		}
>  	}
>  	q->nr_hw_queues = i;
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Omar
