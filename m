Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B06C0015E
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 00:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjG0AJj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 20:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjG0AJi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 20:09:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9EF1FDA
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 17:09:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CACE961CE0
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 00:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EB4C433C8;
        Thu, 27 Jul 2023 00:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690416576;
        bh=OICC/lanKluUb34VQFXLxFzHy02vEomtLzfQ+XVwV98=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G9SXUGWxZ5oqQB9kVttdfshWat5ZYgexNQ/uqcE74aqxpnx8xqwUFSru5qr8qB/S1
         5pBMzXxX5r8hHXaNG4Qx6n0hndvoXp1JI17uZAJ8rG1BPITtOkbTXRn8AUAty34igV
         S3VQGml9xDBbBcwSlJ0gmkTr9rxv/kNbyvCpkAuC481Pl7p2fux8znDeLaJdSbSDhI
         Aq8PK18xUFoU4b9oyz+MwxWGGRd25RzVn30dRMtQbF5fbB2vbh7s0UFOPxTD51AFyb
         dMQa+Yc1uJYagQjxpuEgE6WprZ6T1BnvaU5o7NTtc7kyQOSI6SoMvUARk48CqQhMf7
         nDbwlOsbABcew==
Message-ID: <53514e4d-e75f-3bf0-efa2-b162b6ac73a2@kernel.org>
Date:   Thu, 27 Jul 2023 09:09:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/7] block/mq-deadline: Only use zone locking if
 necessary
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20230726193440.1655149-1-bvanassche@acm.org>
 <20230726193440.1655149-4-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230726193440.1655149-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/23 04:34, Bart Van Assche wrote:
> Measurements have shown that limiting the queue depth to one for zoned

to one -> to one per zone

> writes has a significant negative performance impact on zoned UFS devices.
> Hence this patch that disables zone locking by the mq-deadline scheduler
> if zoned writes are submitted in order and if the storage controller

The "submitted in order" is actually never checked. So let's not use this in
this explanation.

> preserves the command order. This patch is based on the following
> assumptions:
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
> ---
>  block/mq-deadline.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 02a916ba62ee..9a64577fe942 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -338,6 +338,17 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
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

Nit: maybe rename this to dd_use_zone_write_locking() to be clear this is for
zoned devices only ?

> +{
> +	return blk_queue_is_zoned(rq->q) && !blk_no_zone_write_lock(rq);
> +}
> +
>  /*
>   * For the specified data direction, return the next request to
>   * dispatch using arrival ordered lists.
> @@ -353,7 +364,7 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  		return NULL;
>  
>  	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
> +	if (data_dir == DD_READ || !dd_use_write_locking(rq))
>  		return rq;
>  
>  	/*
> @@ -398,7 +409,7 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  	if (!rq)
>  		return NULL;
>  
> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
> +	if (data_dir == DD_READ || !dd_use_write_locking(rq))
>  		return rq;
>  
>  	/*
> @@ -526,8 +537,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
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
> @@ -552,7 +564,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>  	/*
>  	 * If the request needs its target zone locked, do it.
>  	 */
> -	blk_req_zone_write_lock(rq);
> +	if (dd_use_write_locking(rq))
> +		blk_req_zone_write_lock(rq);
>  	rq->rq_flags |= RQF_STARTED;
>  	return rq;
>  }
> @@ -933,7 +946,7 @@ static void dd_finish_request(struct request *rq)
>  
>  	atomic_inc(&per_prio->stats.completed);
>  
> -	if (blk_queue_is_zoned(q)) {
> +	if (dd_use_write_locking(rq)) {
>  		unsigned long flags;
>  
>  		spin_lock_irqsave(&dd->zone_lock, flags);

-- 
Damien Le Moal
Western Digital Research

