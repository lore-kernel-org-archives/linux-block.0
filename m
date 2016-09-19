Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32828 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932328AbcISSiA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2016 14:38:00 -0400
Received: by mail-pa0-f46.google.com with SMTP id hm5so18957665pac.0
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2016 11:38:00 -0700 (PDT)
Date: Mon, 19 Sep 2016 11:37:55 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 03/14] block: Get rid of unused request_queue::nr_queues
 member
Message-ID: <20160919183755.GE21803@vader>
References: <cover.1474183901.git.agordeev@redhat.com>
 <2ac9485f9af069fd674c717fc79e63322185da48.1474183901.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2ac9485f9af069fd674c717fc79e63322185da48.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Sep 18, 2016 at 09:37:13AM +0200, Alexander Gordeev wrote:
> CC: linux-block@vger.kernel.org
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

Reviewed-by: Omar Sandoval <osandov@fb.com>

> ---
>  block/blk-mq.c         | 2 --
>  include/linux/blkdev.h | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7fa58fe..276ec7b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2068,8 +2068,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
>  	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
>  
> -	q->nr_queues = nr_cpu_ids;
> -
>  	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
>  
>  	if (!(set->flags & BLK_MQ_F_SG_MERGE))
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index c47c358..0f1bf55 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -325,7 +325,6 @@ struct request_queue {
>  
>  	/* sw queues */
>  	struct blk_mq_ctx __percpu	*queue_ctx;
> -	unsigned int		nr_queues;
>  
>  	/* hw dispatch queues */
>  	struct blk_mq_hw_ctx	**queue_hw_ctx;
> -- 
> 1.8.3.1
> 

-- 
Omar
