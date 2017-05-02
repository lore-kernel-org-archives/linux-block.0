Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43767 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751008AbdEBGPL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 May 2017 02:15:11 -0400
Subject: Re: [PATCH 6/7] blk-mq-sched: remove hack that bypasses scheduler for
 reserved requests
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
References: <1493391340-24629-1-git-send-email-axboe@fb.com>
 <1493391340-24629-7-git-send-email-axboe@fb.com>
Cc: ming.lei@redhat.com, hch@lst.de
From: Hannes Reinecke <hare@suse.de>
Message-ID: <513a18bb-4958-a8e7-e9f0-d6fc2276b28f@suse.de>
Date: Tue, 2 May 2017 08:15:05 +0200
MIME-Version: 1.0
In-Reply-To: <1493391340-24629-7-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/28/2017 04:55 PM, Jens Axboe wrote:
> We have update the troublesome driver (mtip32xx) to deal with this
> appropriately. So kill the hack that bypassed scheduler allocation
> and insertion for reserved requests.
> 
updated?

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
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
