Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E825C433EF
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 09:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiEPJ42 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 05:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242172AbiEPJ4Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 05:56:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF11CF3;
        Mon, 16 May 2022 02:56:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B93361F96E;
        Mon, 16 May 2022 09:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652694980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7+F73nyaWl4VHIELBoJanUWz3cOly/P+F7MNsQouHhM=;
        b=OzZsmCVMz+rfmc5hlAiynT52OxYFLSVO+Q/FEhHlA4gFxrBIffWnVOeyV/r6zlWsjKMwdF
        7wgs9fU+14feV1tXc967FKgUeLOSSJfSB1AYAi7FqG1L825Uym0TZUefZhTsbtDttrdhdE
        ReNjTHZPFi4LWIzXq2oKfxAc8wUmNNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652694980;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7+F73nyaWl4VHIELBoJanUWz3cOly/P+F7MNsQouHhM=;
        b=qlo8FVR7HQsAeslzqmoB4vcJSlVp9o6iljEIqcj27xg8rgabGNzG+CuZgIYyWehFndFT+a
        l8W7WejgFVroujAg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A85952C141;
        Mon, 16 May 2022 09:56:20 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2F1ABA062F; Mon, 16 May 2022 11:56:20 +0200 (CEST)
Date:   Mon, 16 May 2022 11:56:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 2/2] block, bfq: make bfq_has_work() more
 accurate
Message-ID: <20220516095620.ge5gxmwrnbanfqea@quack3.lan>
References: <20220513023507.2625717-1-yukuai3@huawei.com>
 <20220513023507.2625717-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513023507.2625717-3-yukuai3@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 13-05-22 10:35:07, Yu Kuai wrote:
> bfq_has_work() is using busy_queues currently, which is not accurate
> because bfq_queue is busy doesn't represent that it has requests. Since
> bfqd aready has a counter 'queued' to record how many requests are in
> bfq, use it instead of busy_queues.
> 
> Noted that bfq_has_work() can be called with 'bfqd->lock' held, thus the
> lock can't be held in bfq_has_work() to protect 'bfqd->queued'.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 61750696e87f..740dd83853a6 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2210,7 +2210,11 @@ static void bfq_add_request(struct request *rq)
>  
>  	bfq_log_bfqq(bfqd, bfqq, "add_request %d", rq_is_sync(rq));
>  	bfqq->queued[rq_is_sync(rq)]++;
> -	bfqd->queued++;
> +	/*
> +	 * Updating of 'bfqd->queued' is protected by 'bfqd->lock', however, it
> +	 * may be read without holding the lock in bfq_has_work().
> +	 */
> +	WRITE_ONCE(bfqd->queued, bfqd->queued + 1);
>  
>  	if (RB_EMPTY_ROOT(&bfqq->sort_list) && bfq_bfqq_sync(bfqq)) {
>  		bfq_check_waker(bfqd, bfqq, now_ns);
> @@ -2402,7 +2406,11 @@ static void bfq_remove_request(struct request_queue *q,
>  	if (rq->queuelist.prev != &rq->queuelist)
>  		list_del_init(&rq->queuelist);
>  	bfqq->queued[sync]--;
> -	bfqd->queued--;
> +	/*
> +	 * Updating of 'bfqd->queued' is protected by 'bfqd->lock', however, it
> +	 * may be read without holding the lock in bfq_has_work().
> +	 */
> +	WRITE_ONCE(bfqd->queued, bfqd->queued - 1);
>  	elv_rb_del(&bfqq->sort_list, rq);
>  
>  	elv_rqhash_del(q, rq);
> @@ -5063,11 +5071,11 @@ static bool bfq_has_work(struct blk_mq_hw_ctx *hctx)
>  	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
>  
>  	/*
> -	 * Avoiding lock: a race on bfqd->busy_queues should cause at
> +	 * Avoiding lock: a race on bfqd->queued should cause at
>  	 * most a call to dispatch for nothing
>  	 */
>  	return !list_empty_careful(&bfqd->dispatch) ||
> -		bfq_tot_busy_queues(bfqd) > 0;
> +		READ_ONCE(bfqd->queued);
>  }
>  
>  static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
