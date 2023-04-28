Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C359C77B60
	for <linux-block@archiver.kernel.org>; Fri, 28 Apr 2023 05:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjD1Fyt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Apr 2023 01:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjD1Fys (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2023 01:54:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE85213A
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 22:54:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D770C68D0A; Fri, 28 Apr 2023 07:54:43 +0200 (CEST)
Date:   Fri, 28 Apr 2023 07:54:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 8/9] block: mq-deadline: Handle requeued requests
 correctly
Message-ID: <20230428055443.GI8549@lst.de>
References: <20230424203329.2369688-1-bvanassche@acm.org> <20230424203329.2369688-9-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424203329.2369688-9-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 24, 2023 at 01:33:28PM -0700, Bart Van Assche wrote:
> Start dispatching from the start of a zone instead of from the starting
> position of the most recently dispatched request.
> 
> If a zoned write is requeued with an LBA that is lower than already
> inserted zoned writes, make sure that it is submitted first.
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index bf1dfe9fe9c9..2de6c63190d8 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -156,13 +156,23 @@ deadline_latter_request(struct request *rq)
>  	return NULL;
>  }
>  
> -/* Return the first request for which blk_rq_pos() >= pos. */
> +/*
> + * Return the first request for which blk_rq_pos() >= @pos. For zoned devices,
> + * return the first request after the highest zone start <= @pos.
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
> +	if (blk_rq_is_seq_zoned_write(rq))
> +		pos -= bdev_offset_from_zone_start(rq->q->disk->part0, pos);

This looks a bit odd.  I'd write this as:

	if (blk_rq_is_seq_zoned_write(rq))
		pos = round_down(pos, rq->q->limits.chunk_sectors);

> @@ -821,7 +833,16 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  		 * set expire time and add to fifo list
>  		 */
>  		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
> -		list_add_tail(&rq->queuelist, &per_prio->fifo_list[data_dir]);
> +		insert_before = &per_prio->fifo_list[data_dir];
> +#ifdef CONFIG_BLK_DEV_ZONED
> +		if (blk_rq_is_seq_zoned_write(rq)) {
> +			struct request *rq2 = deadline_latter_request(rq);
> +
> +			if (rq2 && blk_rq_zone_no(rq2) == blk_rq_zone_no(rq))
> +				insert_before = &rq2->queuelist;
> +		}
> +#endif

Why does this need an ifdef?

Also can you please always add comments for these special cases?
Same for the one above.

> +		list_add_tail(&rq->queuelist, insert_before);
>  	}
>  }
>  
---end quoted text---
