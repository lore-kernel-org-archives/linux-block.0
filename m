Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37190 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeI1B3O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Sep 2018 21:29:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so2639135pgq.4
        for <linux-block@vger.kernel.org>; Thu, 27 Sep 2018 12:09:30 -0700 (PDT)
Date: Thu, 27 Sep 2018 12:09:28 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] blk-mq: I/O and timer unplugs are inverted in blktrace
Message-ID: <20180927190928.GB29754@vader>
References: <20180926123550.16311-1-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180926123550.16311-1-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 26, 2018 at 02:35:50PM +0200, Ilya Dryomov wrote:
> trace_block_unplug() takes true for explicit unplugs and false for
> implicit unplugs.  schedule() unplugs are implicit and should be
> reported as timer unplugs.  While correct in the legacy code, this has
> been inverted in blk-mq since 4.11.
> 
> Cc: stable@vger.kernel.org
> Fixes: bd166ef183c2 ("blk-mq-sched: add framework for MQ capable IO schedulers")

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  block/blk-mq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 85a1c1a59c72..e3c39ea8e17b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1628,7 +1628,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>  		BUG_ON(!rq->q);
>  		if (rq->mq_ctx != this_ctx) {
>  			if (this_ctx) {
> -				trace_block_unplug(this_q, depth, from_schedule);
> +				trace_block_unplug(this_q, depth, !from_schedule);
>  				blk_mq_sched_insert_requests(this_q, this_ctx,
>  								&ctx_list,
>  								from_schedule);
> @@ -1648,7 +1648,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>  	 * on 'ctx_list'. Do those.
>  	 */
>  	if (this_ctx) {
> -		trace_block_unplug(this_q, depth, from_schedule);
> +		trace_block_unplug(this_q, depth, !from_schedule);
>  		blk_mq_sched_insert_requests(this_q, this_ctx, &ctx_list,
>  						from_schedule);
>  	}
> -- 
> 2.14.4
> 
