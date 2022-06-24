Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC409C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 06:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiFXGH7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 02:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXGH6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 02:07:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2F65585
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 23:07:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7F6F667373; Fri, 24 Jun 2022 08:07:53 +0200 (CEST)
Date:   Fri, 24 Jun 2022 08:07:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v2 2/6] block: Introduce the
 blk_rq_is_zoned_seq_write() function
Message-ID: <20220624060753.GB6494@lst.de>
References: <20220623232603.3751912-1-bvanassche@acm.org> <20220623232603.3751912-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623232603.3751912-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 23, 2022 at 04:25:59PM -0700, Bart Van Assche wrote:
> Introduce a function that makes it easy to verify whether a write
> request is for a sequential write required or sequential write preferred
> zone. Simplify blk_req_needs_zone_write_lock() by using the new function.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-zoned.c      | 14 +-------------
>  include/linux/blk-mq.h | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 38cd840d8838..cafcbc508dfb 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -57,19 +57,7 @@ EXPORT_SYMBOL_GPL(blk_zone_cond_str);
>   */
>  bool blk_req_needs_zone_write_lock(struct request *rq)
>  {
> -	if (!rq->q->seq_zones_wlock)
> -		return false;
> -
> -	if (blk_rq_is_passthrough(rq))
> -		return false;
> -
> -	switch (req_op(rq)) {
> -	case REQ_OP_WRITE_ZEROES:
> -	case REQ_OP_WRITE:
> -		return blk_rq_zone_is_seq(rq);
> -	default:
> -		return false;
> -	}
> +	return rq->q->seq_zones_wlock && blk_rq_is_zoned_seq_write(rq);
>  }
>  EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);
>  
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 909d47e34b7c..d5930797b84d 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -1136,6 +1136,24 @@ static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
>  	return blk_queue_zone_is_seq(rq->q, blk_rq_pos(rq));
>  }
>  
> +/**
> + * blk_rq_is_zoned_seq_write() - Whether @rq is a write request for a sequential zone.

This doesn't parse and is overly long at the same time.
