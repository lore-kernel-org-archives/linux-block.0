Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbdD1EFO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 00:05:14 -0400
Date: Fri, 28 Apr 2017 12:04:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 4/6] blk-mq: don't bypass scheduler for reserved requests
Message-ID: <20170428040457.GE31518@ming.t460p>
References: <1493333494-600-1-git-send-email-axboe@fb.com>
 <1493333494-600-5-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493333494-600-5-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Apr 27, 2017 at 04:51:32PM -0600, Jens Axboe wrote:
> Instead of bypassing the scheduler for insertion of reserved requests,
> we ensure that the request is marked as RQF_RESERVED so they driver
> knows where it came from.
> 
> Usually we just use the tag to know if it's reserved or not,
> but that only works when the request has a driver tag assigned.
> Using RQF_RESERVED can be done independently of whether or not
> scheduling is used.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-mq-sched.c   | 8 +++-----
>  block/blk-mq.c         | 3 +++
>  include/linux/blkdev.h | 2 ++
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 8b361e192e8a..27c67465f856 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -82,11 +82,7 @@ struct request *blk_mq_sched_get_request(struct request_queue *q,
>  	if (likely(!data->hctx))
>  		data->hctx = blk_mq_map_queue(q, data->ctx->cpu);
>  
> -	/*
> -	 * For a reserved tag, allocate a normal request since we might
> -	 * have driver dependencies on the value of the internal tag.
> -	 */
> -	if (e && !(data->flags & BLK_MQ_REQ_RESERVED)) {
> +	if (e) {
>  		data->flags |= BLK_MQ_REQ_INTERNAL;
>  
>  		/*
> @@ -104,6 +100,8 @@ struct request *blk_mq_sched_get_request(struct request_queue *q,
>  	}
>  
>  	if (rq) {
> +		if (data->flags & BLK_MQ_REQ_RESERVED)
> +			rq->rq_flags |= RQF_RESERVED;

I think this flag may not be needed, becasue driver can
decide if one rq is from reversed pool just by the tag, for example
of mtip32xx, it can be done easily by checking if rq->tag is zero.

So I suggest to not introduce this flag until it is necessary.

Thanks,
Ming
