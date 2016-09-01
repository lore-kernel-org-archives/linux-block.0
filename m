Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33542 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbcIABTR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2016 21:19:17 -0400
Received: by mail-pa0-f50.google.com with SMTP id cy9so23897701pac.0
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2016 18:18:52 -0700 (PDT)
Date: Wed, 31 Aug 2016 18:18:49 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: Use non-atomic operations to manipulate the
 sw-ctx busy bits
Message-ID: <20160901011849.GA8276@vader>
References: <aa1d8314-3c5e-4554-61e1-95c61aa11624@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aa1d8314-3c5e-4554-61e1-95c61aa11624@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 31, 2016 at 03:03:24PM -0700, Bart Van Assche wrote:
> Protect sw-ctx busy bit manipulations via the sw queue lock.
> This allows to convert the atomic bit operations into slightly
> faster non-atomic operations. Document that blk_mq_run_hw_queues()
> tests these bits without holding the sw queue lock.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> ---
>  block/blk-mq.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 13f5a6c..0dcafa6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -66,8 +66,9 @@ static void blk_mq_hctx_mark_pending(struct blk_mq_hw_ctx *hctx,
>  {
>  	struct blk_align_bitmap *bm = get_bm(hctx, ctx);
>  
> +	lockdep_assert_held(&ctx->lock);
>  	if (!test_bit(CTX_TO_BIT(hctx, ctx), &bm->word))
> -		set_bit(CTX_TO_BIT(hctx, ctx), &bm->word);
> +		__set_bit(CTX_TO_BIT(hctx, ctx), &bm->word);
>  }
>  
>  static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
> @@ -75,7 +76,8 @@ static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
>  {
>  	struct blk_align_bitmap *bm = get_bm(hctx, ctx);
>  
> -	clear_bit(CTX_TO_BIT(hctx, ctx), &bm->word);
> +	lockdep_assert_held(&ctx->lock);
> +	__clear_bit(CTX_TO_BIT(hctx, ctx), &bm->word);
>  }

NAK, we can't protect each bit with a separate lock, multiple software
queues share the bitmap. There's a race if we do non-atomic bit
operations on two software queues with bits in the same word.

-- 
Omar
