Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE0DEB64DA
	for <linux-block@archiver.kernel.org>; Tue, 18 Jul 2023 06:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGRGit (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jul 2023 02:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGRGis (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jul 2023 02:38:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE23189
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 23:38:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58B9961481
        for <linux-block@vger.kernel.org>; Tue, 18 Jul 2023 06:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365B6C433C7;
        Tue, 18 Jul 2023 06:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689662324;
        bh=cH1ayfez5m1KG2fIakFY9FmMLsRePDyfdmdy7cnrDLc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ctXS5WMOvEYMbekF3cSFYm5QOB+3qB0W+yIRIpDFc0snHgshT6osBlbDulsU2QVq1
         HV05Q//x2QeChBa8VIku25ac2ZV9ZDaJW9Ug8Z5F0xj7DKn4dvOqasDfW5CYmbOfzQ
         bRAEXuiMOyD+/BT6KwibLUyGf9Gywdo7IlzAPU+gftVRZeDcpJH3bYA5iZtE+V0hnG
         2hoq0hgaTC7X1VfyknL5LH24eBXyLEZ6yCyvd9TTTQptl97OHFFAP00bdfLF7iqmyJ
         yqcdASaJF06DGDorU961SgKtdPvXpy/+mgg8ORQTPM7n+wR2dW0w14yNVECxFX3Ipl
         O47bC3kXlu6VQ==
Message-ID: <98e2f100-76b0-c28f-bb02-4a41c1b71f5e@kernel.org>
Date:   Tue, 18 Jul 2023 15:38:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/5] block/mq-deadline: Only use zone locking if
 necessary
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230710180210.1582299-1-bvanassche@acm.org>
 <20230710180210.1582299-3-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230710180210.1582299-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/23 03:01, Bart Van Assche wrote:
> Measurements have shown that limiting the queue depth to one for zoned
> writes has a significant negative performance impact on zoned UFS devices.
> Hence this patch that disables zone locking from the mq-deadline scheduler
> for storage controllers that support pipelining zoned writes. This patch is
> based on the following assumptions:
> - Applications submit write requests to sequential write required zones
>   in order.
> - It happens infrequently that zoned write requests are reordered by the
>   block layer.
> - The storage controller does not reorder write requests that have been
>   submitted to the same hardware queue. This is the case for UFS: the
>   UFSHCI specification requires that UFS controllers process requests in
>   order per hardware queue.
> - The I/O priority of all pipelined write requests is the same per zone.
> - Either no I/O scheduler is used or an I/O scheduler is used that
>   submits write requests per zone in LBA order.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-zoned.c   |  3 ++-
>  block/mq-deadline.c | 14 +++++++++-----
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 0f9f97cdddd9..59560d1657e3 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -504,7 +504,8 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>  		break;
>  	case BLK_ZONE_TYPE_SEQWRITE_REQ:
>  	case BLK_ZONE_TYPE_SEQWRITE_PREF:
> -		if (!args->seq_zones_wlock) {
> +		if (!blk_queue_pipeline_zoned_writes(q) &&
> +		    !args->seq_zones_wlock) {

I think that this change should go into the first patch, no ?

>  			args->seq_zones_wlock =
>  				blk_alloc_zone_bitmap(q->node, args->nr_zones);
>  			if (!args->seq_zones_wlock)
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 6aa5daf7ae32..0bed2bdeed89 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -353,7 +353,8 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  		return NULL;
>  
>  	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
> +	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q) ||
> +	    blk_queue_pipeline_zoned_writes(rq->q))

What about using blk_req_needs_zone_write_lock() ?

>  		return rq;
>  
>  	/*
> @@ -398,7 +399,8 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  	if (!rq)
>  		return NULL;
>  
> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
> +	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q) ||
> +	    blk_queue_pipeline_zoned_writes(rq->q))

Same.

>  		return rq;
>  
>  	/*
> @@ -526,8 +528,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
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
> @@ -933,7 +936,8 @@ static void dd_finish_request(struct request *rq)
>  
>  	atomic_inc(&per_prio->stats.completed);
>  
> -	if (blk_queue_is_zoned(q)) {
> +	if (blk_queue_is_zoned(rq->q) &&
> +	    !blk_queue_pipeline_zoned_writes(q)) {

And again here.

>  		unsigned long flags;
>  
>  		spin_lock_irqsave(&dd->zone_lock, flags);

-- 
Damien Le Moal
Western Digital Research

