Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756742AbdD1PXO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 11:23:14 -0400
Date: Fri, 28 Apr 2017 23:22:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 6/7] blk-mq-sched: remove hack that bypasses scheduler
 for reserved requests
Message-ID: <20170428152258.GB25592@ming.t460p>
References: <1493391340-24629-1-git-send-email-axboe@fb.com>
 <1493391340-24629-7-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493391340-24629-7-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 28, 2017 at 08:55:39AM -0600, Jens Axboe wrote:
> We have update the troublesome driver (mtip32xx) to deal with this
> appropriately. So kill the hack that bypassed scheduler allocation
> and insertion for reserved requests.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-mq-sched.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 8b361e192e8a..e79e9f18d7c2 100644
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

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
