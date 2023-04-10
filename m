Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71563C77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 07:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjDJHxN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 03:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDJHxM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 03:53:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E273CCC
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 00:53:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DA3860DB6
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 07:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54DEC433EF;
        Mon, 10 Apr 2023 07:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681113190;
        bh=996gqPDVZ2/5j1aar+6iOJ0hRNiKL8JuD0O7W/fSiHE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pZmD35LIXIOqMmg+OejpmgLYKRwfz297hOGYgrE6fYOOXrBRLoaz6vyAUz1bkAcDW
         ADrcyrO5TMGXAz4n//0fAmjX7/hYep/UqXKwDCIgi5NJ7YGAjzxjoxEpE67YjzFnRo
         PlqLSz0pDN4xdsxoDTnjBgltVNsuXs/rEPLLTygWUzN6ixpEGUoFlZnvpBKmoEdOvG
         8vtWuuBtU+7LfXl51T1oJeYYgd2gc98US2mOmPj+I2VyPccmUy4+WyoH44r2PgM+s+
         Pj3D/aWfORJAy1cdX2cqChbt8AD5IYRk6GNYKpzYyNz4kYgwgVa7Cf977SUbbdshp0
         LyLo6tbKFDHuQ==
Message-ID: <61231e6f-81c2-a945-d8f2-8f1b2761b2f9@kernel.org>
Date:   Mon, 10 Apr 2023 16:53:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 03/12] block: Send requeued requests to the I/O
 scheduler
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-4-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230407235822.1672286-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/23 08:58, Bart Van Assche wrote:
> Let the I/O scheduler control which requests are dispatched.

Well, that is the main function of the IO scheduler already. So could you
develop the commit message here to explain in more details which case this is
changing ?

> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c         | 21 +++++++++------------
>  include/linux/blk-mq.h |  5 +++--
>  2 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 250556546bbf..57315395434b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1426,15 +1426,7 @@ static void blk_mq_requeue_work(struct work_struct *work)
>  
>  		rq->rq_flags &= ~RQF_SOFTBARRIER;
>  		list_del_init(&rq->queuelist);
> -		/*
> -		 * If RQF_DONTPREP, rq has contained some driver specific
> -		 * data, so insert it to hctx dispatch list to avoid any
> -		 * merge.
> -		 */
> -		if (rq->rq_flags & RQF_DONTPREP)
> -			blk_mq_request_bypass_insert(rq, false, false);
> -		else
> -			blk_mq_sched_insert_request(rq, true, false, false);
> +		blk_mq_sched_insert_request(rq, /*at_head=*/true, false, false);
>  	}
>  
>  	while (!list_empty(&rq_list)) {
> @@ -2065,9 +2057,14 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>  		if (nr_budgets)
>  			blk_mq_release_budgets(q, list);
>  
> -		spin_lock(&hctx->lock);
> -		list_splice_tail_init(list, &hctx->dispatch);
> -		spin_unlock(&hctx->lock);
> +		if (!q->elevator) {
> +			spin_lock(&hctx->lock);
> +			list_splice_tail_init(list, &hctx->dispatch);
> +			spin_unlock(&hctx->lock);
> +		} else {
> +			q->elevator->type->ops.insert_requests(hctx, list,
> +							/*at_head=*/true);

Dispatch at head = true ? Why ? This seems wrong. It may be valid for the
requeue case (even then, I am not convinced), but looks very wrong for the
regular dispatch case.

> +		}
>  
>  		/*
>  		 * Order adding requests to hctx->dispatch and checking
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 5e6c79ad83d2..3a3bee9085e3 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -64,8 +64,9 @@ typedef __u32 __bitwise req_flags_t;
>  #define RQF_RESV			((__force req_flags_t)(1 << 23))
>  
>  /* flags that prevent us from merging requests: */
> -#define RQF_NOMERGE_FLAGS \
> -	(RQF_STARTED | RQF_SOFTBARRIER | RQF_FLUSH_SEQ | RQF_SPECIAL_PAYLOAD)
> +#define RQF_NOMERGE_FLAGS                                               \
> +	(RQF_STARTED | RQF_SOFTBARRIER | RQF_FLUSH_SEQ | RQF_DONTPREP | \
> +	 RQF_SPECIAL_PAYLOAD)
>  
>  enum mq_rq_state {
>  	MQ_RQ_IDLE		= 0,

