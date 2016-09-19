Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35917 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932652AbcISSi2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2016 14:38:28 -0400
Received: by mail-pf0-f174.google.com with SMTP id q2so33425226pfj.3
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2016 11:38:27 -0700 (PDT)
Date: Mon, 19 Sep 2016 11:38:25 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 05/14] blk-mq: Remove a redundant assignment
Message-ID: <20160919183825.GF21803@vader>
References: <cover.1474183901.git.agordeev@redhat.com>
 <d1f923c3217665d106d7a6cb52d267052f0254f6.1474183901.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d1f923c3217665d106d7a6cb52d267052f0254f6.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Sep 18, 2016 at 09:37:15AM +0200, Alexander Gordeev wrote:
> blk_mq_hw_ctx::queue_num is initialized in blk_mq_init_hctx()
> function.
> 
> CC: linux-block@vger.kernel.org
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

Reviewed-by: Omar Sandoval <osandov@fb.com>

> ---
>  block/blk-mq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2c77b68..a38fd2e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2013,7 +2013,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  
>  		atomic_set(&hctxs[i]->nr_active, 0);
>  		hctxs[i]->numa_node = node;
> -		hctxs[i]->queue_num = i;
>  
>  		if (blk_mq_init_hctx(q, set, hctxs[i], i)) {
>  			free_cpumask_var(hctxs[i]->cpumask);
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Omar
