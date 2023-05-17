Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE39C77B75
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 01:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjEQBXM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 21:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjEQBXK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 21:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1C1193
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 18:22:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 425D461444
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 01:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59F7C433D2;
        Wed, 17 May 2023 01:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684286572;
        bh=buCYrSVRxOuCgi2b+IEZ9pZh4sZAQs+okt3fgTOt+YI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G9C6ZdoqqznwtjC6ZF0vkMNEXf3stHS8BI5+mMeGXxTwfbOzBBEGvfsauzOpd8EXB
         yueQjNVDrKNviH8Av8uJ0KH+dTL3kXKQ+wzUmkfomylYEPKt/7bPtV3FCYp+mfi2Zo
         NAUBUDvippuUipl13lYc7BfFVBl9xGTCfzEUQ6aOZECJqh8i8wFLJfSLHymlWeAOOn
         Qj9F6ddFC/K3oxHb0+I0Rn8zCsQ6q6GaYAVCDV2U5xLFga/JB9qFN9Qoob+2fdEWDZ
         rCj6WbAF7hi8msunY0KF8RGFzaT3rcJBoRKKlTn5LQI2RRwc2dO33GejOLB54v/DGB
         6JsgaX2N0vEhA==
Message-ID: <bdaa4854-7320-f5ec-ff13-489516149c2a@kernel.org>
Date:   Wed, 17 May 2023 10:22:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 10/11] block: mq-deadline: Handle requeued requests
 correctly
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-11-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230516223323.1383342-11-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 07:33, Bart Van Assche wrote:
> Start dispatching from the start of a zone instead of from the starting
> position of the most recently dispatched request.
> 
> If a zoned write is requeued with an LBA that is lower than already
> inserted zoned writes, make sure that it is submitted first.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 6d0b99042c96..059727fa4b98 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -156,13 +156,28 @@ deadline_latter_request(struct request *rq)
>  	return NULL;
>  }
>  
> -/* Return the first request for which blk_rq_pos() >= pos. */
> +/*
> + * Return the first request for which blk_rq_pos() >= @pos. For zoned devices,
> + * return the first request after the highest zone start <= @pos.

This comment is strange. What about:

For zoned devices, return the first request after the start of the zone
containing @pos.

> + */
>  static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
>  				enum dd_data_dir data_dir, sector_t pos)
>  {
>  	struct rb_node *node = per_prio->sort_list[data_dir].rb_node;
>  	struct request *rq, *res = NULL;
>  
> +	if (!node)
> +		return NULL;
> +
> +	rq = rb_entry_rq(node);
> +	/*
> +	 * A zoned write may have been requeued with a starting position that
> +	 * is below that of the most recently dispatched request. Hence, for
> +	 * zoned writes, start searching from the start of a zone.
> +	 */
> +	if (blk_rq_is_seq_zoned_write(rq))
> +		pos -= round_down(pos, rq->q->limits.chunk_sectors);
> +
>  	while (node) {
>  		rq = rb_entry_rq(node);
>  		if (blk_rq_pos(rq) >= pos) {
> @@ -806,6 +821,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  		list_add(&rq->queuelist, &per_prio->dispatch);
>  		rq->fifo_time = jiffies;
>  	} else {
> +		struct list_head *insert_before;
> +
>  		deadline_add_rq_rb(per_prio, rq);
>  
>  		if (rq_mergeable(rq)) {
> @@ -818,7 +835,20 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  		 * set expire time and add to fifo list
>  		 */
>  		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
> -		list_add_tail(&rq->queuelist, &per_prio->fifo_list[data_dir]);
> +		insert_before = &per_prio->fifo_list[data_dir];
> +#ifdef CONFIG_BLK_DEV_ZONED
> +		/*
> +		 * Insert zoned writes such that requests are sorted by
> +		 * position per zone.
> +		 */
> +		if (blk_rq_is_seq_zoned_write(rq)) {
> +			struct request *rq2 = deadline_latter_request(rq);
> +
> +			if (rq2 && blk_rq_zone_no(rq2) == blk_rq_zone_no(rq))
> +				insert_before = &rq2->queuelist;
> +		}
> +#endif
> +		list_add_tail(&rq->queuelist, insert_before);

Why not:

		insert_before = &per_prio->fifo_list[data_dir];
		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) 	
		    && blk_rq_is_seq_zoned_write(rq)) {
			/*
			 * Insert zoned writes such that requests are sorted by
			 * position per zone.
		 	*/
			struct request *rq2 = deadline_latter_request(rq);

			if (rq2 && blk_rq_zone_no(rq2) == blk_rq_zone_no(rq))
				insert_before = &rq2->queuelist;
		}
		list_add_tail(&rq->queuelist, insert_before);

to avoid the ugly #ifdef ?


-- 
Damien Le Moal
Western Digital Research

