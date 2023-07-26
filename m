Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C485C001DC
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 08:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjGZItS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 04:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjGZIss (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 04:48:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACC91FC9
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 01:41:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5646E61874
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 08:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE04C433C7;
        Wed, 26 Jul 2023 08:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690360913;
        bh=FRKf4RtlONx7UGveRhom4k+ZV6266PlWAWyZi2gZTW4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Gl/Jp6KqfoeDufgiYYNvKU7NHanYfNNzFA5WKw69Gimda/FBidgWWHAb/ofP7FO/y
         5NgskxWzhlflN+TPtrxJ+aq8HUmQE0naW831yAy61TvqqX+gAqOC8+EHWbOJiyCjTs
         n0f8U7ATW7IKS6y1j+57YpdTsF+2pJUMC16x/V8SG6qyFVyRKIR7iycv7j4dLGKLfz
         WbddVITv+cfgDre6AhrcntDtlFeSZ2UUjFZ/5fErXoRUHA9Cotdii381bBYHOMfUBq
         zoygIP84WFc6Zo5QZ2sbxEAfFSbDRTIIY+XTQGVVWb10prdupb3lcJmRXIrwz3uy56
         eeRuDxpFYymUQ==
Message-ID: <bb1fb9ab-bb3f-ad4f-90fa-812d8a04e8c3@kernel.org>
Date:   Wed, 26 Jul 2023 17:41:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/6] block/mq-deadline: Only use zone locking if
 necessary
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20230726005742.303865-1-bvanassche@acm.org>
 <20230726005742.303865-3-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230726005742.303865-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/23 09:57, Bart Van Assche wrote:
> Measurements have shown that limiting the queue depth to one for zoned
> writes has a significant negative performance impact on zoned UFS devices.
> Hence this patch that disables zone locking by the mq-deadline scheduler
> if zoned writes are submitted in order and if the storage controller
> preserves the command order. This patch is based on the following
> assumptions:

if zoned writes are submitted in order and if the storage... -> if the storage
controller preserves...

> - It happens infrequently that zoned write requests are reordered by the
>   block layer.
> - The I/O priority of all write requests is the same per zone.
> - Either no I/O scheduler is used or an I/O scheduler is used that
>   submits write requests per zone in LBA order.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Please use dlemoal@kernel.org

> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 02a916ba62ee..ce5b5048935e 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -338,6 +338,18 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
>  	return rq;
>  }
>  
> +/*
> + * Use write locking if either QUEUE_FLAG_NO_ZONE_WRITE_LOCK or
> + * REQ_NO_ZONE_WRITE_LOCK has not been set. Not using zone write locking is
> + * only safe if the submitter allocates and submit requests in LBA order per
> + * zone and if the block driver preserves the request order.
> + */
> +static bool dd_use_write_locking(struct request *rq)
> +{
> +	return !blk_queue_no_zone_write_lock(rq->q) ||
> +		!(rq->cmd_flags & REQ_NO_ZONE_WRITE_LOCK);
> +}
> +
>  /*
>   * For the specified data direction, return the next request to
>   * dispatch using arrival ordered lists.
> @@ -353,7 +365,8 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  		return NULL;
>  
>  	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
> +	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q) ||
> +	    !dd_use_write_locking(rq))

The test for !blk_queue_is_zoned(rq->q) can be moved inside
dd_use_write_locking() I think. That will avoid repeating it again below.

>  		return rq;
>  
>  	/*
> @@ -398,7 +411,8 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  	if (!rq)
>  		return NULL;
>  
> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
> +	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q) ||
> +	    !dd_use_write_locking(rq))
>  		return rq;
>  
>  	/*
> @@ -526,8 +540,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>  	}
>  
>  	/*
> -	 * For a zoned block device, if we only have writes queued and none of
> -	 * them can be dispatched, rq will be NULL.
> +	 * For a zoned block device that requires write serialization, if we
> +	 * only have writes queued and none of them can be dispatched, rq will
> +	 * be NULL.
>  	 */
>  	if (!rq)
>  		return NULL;
> @@ -552,7 +567,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>  	/*
>  	 * If the request needs its target zone locked, do it.
>  	 */
> -	blk_req_zone_write_lock(rq);
> +	if (dd_use_write_locking(rq))
> +		blk_req_zone_write_lock(rq);
>  	rq->rq_flags |= RQF_STARTED;
>  	return rq;
>  }
> @@ -933,7 +949,7 @@ static void dd_finish_request(struct request *rq)
>  
>  	atomic_inc(&per_prio->stats.completed);
>  
> -	if (blk_queue_is_zoned(q)) {
> +	if (blk_queue_is_zoned(rq->q) && dd_use_write_locking(rq)) {
>  		unsigned long flags;
>  
>  		spin_lock_irqsave(&dd->zone_lock, flags);

-- 
Damien Le Moal
Western Digital Research

