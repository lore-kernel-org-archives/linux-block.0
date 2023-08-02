Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A96C00528
	for <linux-block@archiver.kernel.org>; Wed,  2 Aug 2023 09:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjHBJM0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Aug 2023 05:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjHBJMY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Aug 2023 05:12:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1652D49
        for <linux-block@vger.kernel.org>; Wed,  2 Aug 2023 02:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0DAC618C1
        for <linux-block@vger.kernel.org>; Wed,  2 Aug 2023 09:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD9FC433D9;
        Wed,  2 Aug 2023 09:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690967542;
        bh=pVAyY1ySzAS+PG0JJtNfXD8KkxEQplMaB9ot2jF0iEE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qv1RNe+t1xACIgBzHXl48CThQCVmMN+p16VEx4tAmOWO2oPWQ6dgbGiAKV7dM7rRc
         VU1JPKzaM3jKtzGOu3uKecMDXTju6spnFrH8QujQUrdm2leL4Q3tODABIuDsNJAfRx
         ywU6meOGrvsLr+z0M8Mrw/PrGz2IZWtVUWMVZ1R3F0kSPp4UAowXvJbu1yoDrZYMz4
         StYx/T+7gTnywXlzw16R0fOE280Ng2NHhKNtYnP2+P0YHDf0qqKv9Rn7eGVo6G8SbV
         yEJjeMssoUFIMP+C2rSO9AgkAAu4UonzFI5zP+lXR6IxsdWM0lLrKr1fsTZdQSl7hU
         F/Pze9fbNBdaQ==
Message-ID: <252a5224-2f1b-cdcd-2c37-d49bce704099@kernel.org>
Date:   Wed, 2 Aug 2023 18:12:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 2/7] block/mq-deadline: Only use zone locking if
 necessary
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230731221458.437440-1-bvanassche@acm.org>
 <20230731221458.437440-3-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230731221458.437440-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/1/23 07:14, Bart Van Assche wrote:
> Measurements have shown that limiting the queue depth to one per zone for
> zoned writes has a significant negative performance impact on zoned UFS
> devices. Hence this patch that disables zone locking by the mq-deadline
> scheduler if the storage controller preserves the command order. This
> patch is based on the following assumptions:
> - It happens infrequently that zoned write requests are reordered by the
>   block layer.
> - The I/O priority of all write requests is the same per zone.
> - Either no I/O scheduler is used or an I/O scheduler is used that
>   submits write requests per zone in LBA order.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  block/mq-deadline.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 02a916ba62ee..1f4124dd4a0b 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -338,6 +338,16 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
>  	return rq;
>  }
>  
> +/*
> + * Use write locking if either QUEUE_FLAG_NO_ZONE_WRITE_LOCK has not been set.
> + * Not using zone write locking is only safe if the block driver preserves the
> + * request order.
> + */
> +static bool dd_use_zone_write_locking(struct request_queue *q)
> +{
> +	return blk_queue_is_zoned(q) && !blk_queue_no_zone_write_lock(q);
> +}
> +
>  /*
>   * For the specified data direction, return the next request to
>   * dispatch using arrival ordered lists.
> @@ -353,7 +363,7 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  		return NULL;
>  
>  	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
> +	if (data_dir == DD_READ || !dd_use_zone_write_locking(rq->q))
>  		return rq;
>  
>  	/*
> @@ -398,7 +408,7 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  	if (!rq)
>  		return NULL;
>  
> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
> +	if (data_dir == DD_READ || !dd_use_zone_write_locking(rq->q))
>  		return rq;
>  
>  	/*
> @@ -526,8 +536,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
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
> @@ -552,7 +563,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>  	/*
>  	 * If the request needs its target zone locked, do it.
>  	 */
> -	blk_req_zone_write_lock(rq);
> +	if (dd_use_zone_write_locking(rq->q))
> +		blk_req_zone_write_lock(rq);
>  	rq->rq_flags |= RQF_STARTED;
>  	return rq;
>  }
> @@ -933,7 +945,7 @@ static void dd_finish_request(struct request *rq)
>  
>  	atomic_inc(&per_prio->stats.completed);
>  
> -	if (blk_queue_is_zoned(q)) {
> +	if (dd_use_zone_write_locking(rq->q)) {
>  		unsigned long flags;
>  
>  		spin_lock_irqsave(&dd->zone_lock, flags);

-- 
Damien Le Moal
Western Digital Research

