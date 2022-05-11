Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8870CC433F5
	for <linux-block@archiver.kernel.org>; Wed, 11 May 2022 14:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbiEKOIj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 May 2022 10:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244372AbiEKOIh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 May 2022 10:08:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4C369B70;
        Wed, 11 May 2022 07:08:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CCC921F8D3;
        Wed, 11 May 2022 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652278113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WVUpTvgXOgKAenIMWJDnUZ/L+5LYxOzIhtllMjUqpHc=;
        b=leJwEQiIeuTvNXIluf6x1uMRsdtq4dAR2VxJvQnOd/WfbCgVeBTQkiWoRHekZwHmdrCwyG
        U3AGggUAVetMQW8iv1znhnkkkjyRKuKh83noLkuulXPJpBMFZ4yEfOZFWnFgPUp+fmQGmZ
        u7hPDtBUBkJHeOHp0ESt/ZMH1iMSM2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652278113;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WVUpTvgXOgKAenIMWJDnUZ/L+5LYxOzIhtllMjUqpHc=;
        b=nmEbVOH7bQ22T6dr0HtvfA9dcZv0yJRJyyrGjK/+yJolCmsnUQp7dOwpVMiOoKfrNL7PQE
        QsBA+4DlgGRKfDBQ==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C0C3C2C141;
        Wed, 11 May 2022 14:08:32 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 81886A062A; Wed, 11 May 2022 16:08:32 +0200 (CEST)
Date:   Wed, 11 May 2022 16:08:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 2/2] block, bfq: make bfq_has_work() more accurate
Message-ID: <20220511140832.w6eqphw5uepre5ws@quack3.lan>
References: <20220510131629.1964415-1-yukuai3@huawei.com>
 <20220510131629.1964415-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510131629.1964415-3-yukuai3@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 10-05-22 21:16:29, Yu Kuai wrote:
> bfq_has_work() is using busy_queues currently, which is not accurate
> because bfq_queue is busy doesn't represent that it has requests. Since
> bfqd aready has a counter 'queued' to record how many requests are in
> bfq, use it instead of busy_queues.
> 
> Noted that bfq_has_work() can be called with 'bfqd->lock' held, thus the
> lock can't be held in bfq_has_work() to protect 'bfqd->queued'.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

So did you find this causing any real problem? Because bfq queue is
accounted among busy queues once bfq_add_bfqq_busy() is called. And that
happens once a new request is inserted into the queue so it should be very
similar to bfqd->queued.

								Honza

> ---
>  block/bfq-iosched.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 61750696e87f..1d2f8110c26b 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5063,11 +5063,11 @@ static bool bfq_has_work(struct blk_mq_hw_ctx *hctx)
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
