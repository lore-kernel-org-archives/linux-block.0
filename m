Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34070 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbcISR7t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2016 13:59:49 -0400
Received: by mail-pa0-f44.google.com with SMTP id wk8so50855899pab.1
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2016 10:59:48 -0700 (PDT)
Date: Mon, 19 Sep 2016 10:59:46 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 10/14] blk-mq: Uninit hardware context in order reverse
 to init
Message-ID: <20160919175946.GC21803@vader>
References: <cover.1474183901.git.agordeev@redhat.com>
 <cdf0bb66b4fa3bdcedb3bcd2df57ff38ed9fb02c.1474183901.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cdf0bb66b4fa3bdcedb3bcd2df57ff38ed9fb02c.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Sep 18, 2016 at 09:37:20AM +0200, Alexander Gordeev wrote:
> CC: linux-block@vger.kernel.org
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  block/blk-mq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index cd32a08..c589096 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2013,12 +2013,13 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  		struct blk_mq_hw_ctx *hctx = hctxs[j];
>  
>  		if (hctx) {
> +			kobject_put(&hctx->kobj);
> +
>  			if (hctx->tags) {
>  				blk_mq_free_rq_map(set, hctx->tags, j);
>  				set->tags[j] = NULL;
>  			}
>  			blk_mq_exit_hctx(q, set, hctx, j);
> -			kobject_put(&hctx->kobj);
>  			hctxs[j] = NULL;
>  		}
>  	}

Oh, this fixes my comment from the last one, but it should be folded in
to be bisect-safe.

-- 
Omar
