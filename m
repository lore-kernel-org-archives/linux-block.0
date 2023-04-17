Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1147AC77B79
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 06:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjDQGW1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 02:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjDQGW0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 02:22:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE2C35AD
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 23:22:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 071B161E55
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 06:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41E7C433D2;
        Mon, 17 Apr 2023 06:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681712543;
        bh=b0LVBEutUs9vujlXDCwD/tIOxnSfIOQM3+R5DLFF4Js=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c4DC7yUVxKEjwjXtzR8tb7nyvguLTPOqkNp4F21i6fXUyGPQ0QEdUiJ+12lYmJA/D
         fHf82RkWXEpydeuPcjmr3yVO0M/azIKawzFEudG0TsdIcCH5f2v+vCdcmliozx3+kE
         ghnxW7AJlXAENJ6bOasRhtiwWtImSIcs/NSqcuCmFYPNWHuB2raXjL1S+9eSQoIwWC
         uhm6AYIjV5kEXD4xBCWYzFpXdHxZrakVHNANaqQOZgTY8Ud0vcgqPJy14fQ68tljfK
         IM6EpIzRebC5ibK6DpnQ0i/BOeGPZ+4WP2YNnGGQybxContYZwAHmOJPbWwnSkckzo
         YLQqCcKNPqmGw==
Message-ID: <3947a26e-ceb6-4117-7b45-fd7578710120@kernel.org>
Date:   Mon, 17 Apr 2023 15:22:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/7] blk-mq: factor out a blk_rq_init_flush helper
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230416200930.29542-1-hch@lst.de>
 <20230416200930.29542-2-hch@lst.de>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230416200930.29542-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/23 05:09, Christoph Hellwig wrote:
> Factor out a helper from blk_insert_flush that initializes the flush
> machine related fields in struct request.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-flush.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 04698ed9bcd4a9..422a6d5446d1c5 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -376,6 +376,15 @@ static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
>  	return RQ_END_IO_NONE;
>  }
>  
> +static void blk_rq_init_flush(struct request *rq)
> +{
> +	memset(&rq->flush, 0, sizeof(rq->flush));
> +	INIT_LIST_HEAD(&rq->flush.list);
> +	rq->rq_flags |= RQF_FLUSH_SEQ;
> +	rq->flush.saved_end_io = rq->end_io; /* Usually NULL */
> +	rq->end_io = mq_flush_data_end_io;
> +}

struct flush is:

struct {
	unsigned int		seq;
	struct list_head	list;
	rq_end_io_fn		*saved_end_io;
} flush;

So given that list and saved_end_io are initialized here, we could remove the
memset() by initializing seq "manually":

+static void blk_rq_init_flush(struct request *rq)
+{
+	rq->flush.seq = 0;
+	INIT_LIST_HEAD(&rq->flush.list);
+	rq->flush.saved_end_io = rq->end_io; /* Usually NULL */
+	rq->rq_flags |= RQF_FLUSH_SEQ;
+	rq->end_io = mq_flush_data_end_io;
+}

No ?

Otherwise, look good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +
>  /**
>   * blk_insert_flush - insert a new PREFLUSH/FUA request
>   * @rq: request to insert
> @@ -437,13 +446,7 @@ void blk_insert_flush(struct request *rq)
>  	 * @rq should go through flush machinery.  Mark it part of flush
>  	 * sequence and submit for further processing.
>  	 */
> -	memset(&rq->flush, 0, sizeof(rq->flush));
> -	INIT_LIST_HEAD(&rq->flush.list);
> -	rq->rq_flags |= RQF_FLUSH_SEQ;
> -	rq->flush.saved_end_io = rq->end_io; /* Usually NULL */
> -
> -	rq->end_io = mq_flush_data_end_io;
> -
> +	blk_rq_init_flush(rq);
>  	spin_lock_irq(&fq->mq_flush_lock);
>  	blk_flush_complete_seq(rq, fq, REQ_FSEQ_ACTIONS & ~policy, 0);
>  	spin_unlock_irq(&fq->mq_flush_lock);

