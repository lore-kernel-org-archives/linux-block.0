Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE74C77B7D
	for <linux-block@archiver.kernel.org>; Sat, 13 May 2023 16:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjEMQuk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 May 2023 12:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEMQuj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 May 2023 12:50:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7842D74
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 09:50:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6439e53ed82so1842352b3a.1
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 09:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683996638; x=1686588638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wxAGGC0CXjrRtgK9Vd04Ig3pDpNjzIDQMWhUjOkb3Ss=;
        b=cV9/C7THh4MhyKI5jPjGCq8IIu4IPmXbLCbzOn59x8t4hVWAq/eHzQNriCvgyoNHtM
         ziHLSoUXVtMABJS8XrZB8ZweQjTEdKMexEBSRAtqCnmvSg6oV1OyE6U0z8RQEgZYka4H
         V7PG4sDj3n1Xk9lFNvbRxjnvTneGm6TCTNSEpfX0GfdsRTnEZhznsYSvOMZWjQ5AwKWx
         K3F66iOJv67Hcv+MzhMiCIBtuNW4UXMU7X5G/sxcP3TUHlu1UNRtATaTe+fxkYtyqI6R
         iR//Zf3fyM+xMX+w3mXqe5TIe34GY8vZBl4kBOGgR0dSwcFJmMX/m0Rb9tDHEYIr7F8w
         gDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683996638; x=1686588638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxAGGC0CXjrRtgK9Vd04Ig3pDpNjzIDQMWhUjOkb3Ss=;
        b=YH9m2SwZhkzz9Atnw/MD8IP+FM4U4mQ+ramHhD1KPeaEYh3G0T/mNvo5dlL2hfayKw
         ASITvq0tDa2URlt+oceBYGq6UTZood626OPCPWis5E7SCMRz+WMvsHFKqrUe0yDpb/CX
         ZuE88yeh8n737GZUmVM0ayL091GK4yHLee83IZAl2v+cUz8p7P+Zu9ICC+x0OmS4yRvJ
         ul8EojdDB3IYBcVFOhiK+jEY+LuVXB+iKd3UugUCkCwMITLfrNbZUYOMock26bZEmHH6
         fuV3vTvwnJD0WGh3XCq56BX9a2czJspeVNx1BYDC5XRxiLBTItUtALX6szeEP26m3flY
         cWWA==
X-Gm-Message-State: AC+VfDzz/p2IlNQU1ykZAFpkWiO8KX+1Q+nKNdvSNUEpjObklRkF5nrP
        vJVUapFuK2E+uPuICXCDPalEvTc2A6oeenJTIw0=
X-Google-Smtp-Source: ACHHUZ7LdcVoSVZ1V1WKNMAPsBBquFQoMXGQJhJyC1vvWNB5d6Tnxj7gwvNkP/QSkXKbwVRDz/FVug==
X-Received: by 2002:a05:6a20:12ce:b0:105:66d3:854d with SMTP id v14-20020a056a2012ce00b0010566d3854dmr1159775pzg.6.1683996638147;
        Sat, 13 May 2023 09:50:38 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c19-20020a62e813000000b0063b806b111csm8839035pfi.169.2023.05.13.09.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 09:50:37 -0700 (PDT)
Message-ID: <0f3a4400-a6ce-1127-34bc-9d1b9b0b766d@kernel.dk>
Date:   Sat, 13 May 2023 10:50:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
References: <20230512150328.192908-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230512150328.192908-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/23 9:03?AM, Ming Lei wrote:
> Passthrough(pt) request shouldn't be queued to scheduler, especially some
> schedulers(such as bfq) supposes that req->bio is always available and
> blk-cgroup can be retrieved via bio.
> 
> Sometimes pt request could be part of error handling, so it is better to always
> queue it into hctx->dispatch directly.
> 
> Fix this issue by queuing pt request from plug list to hctx->dispatch
> directly.
> 
> Reported-by: Guangwu Zhang <guazhang@redhat.com>
> Investigated-by: Yu Kuai <yukuai1@huaweicloud.com>
> Fixes: 1c2d2fff6dc0 ("block: wire-up support for passthrough plugging")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> Guang Wu, please test this patch and provide us the result.
> 
>  block/blk-mq.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f6dad0886a2f..11efaefa26c3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2711,6 +2711,7 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
>  	struct request *requeue_list = NULL;
>  	struct request **requeue_lastp = &requeue_list;
>  	unsigned int depth = 0;
> +	bool pt = false;
>  	LIST_HEAD(list);
>  
>  	do {
> @@ -2719,7 +2720,9 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
>  		if (!this_hctx) {
>  			this_hctx = rq->mq_hctx;
>  			this_ctx = rq->mq_ctx;
> -		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx) {
> +			pt = blk_rq_is_passthrough(rq);
> +		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx ||
> +				pt != blk_rq_is_passthrough(rq)) {
>  			rq_list_add_tail(&requeue_lastp, rq);
>  			continue;
>  		}
> @@ -2731,10 +2734,15 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
>  	trace_block_unplug(this_hctx->queue, depth, !from_sched);
>  
>  	percpu_ref_get(&this_hctx->queue->q_usage_counter);
> -	if (this_hctx->queue->elevator) {
> +	if (this_hctx->queue->elevator && !pt) {
>  		this_hctx->queue->elevator->type->ops.insert_requests(this_hctx,
>  				&list, 0);
>  		blk_mq_run_hw_queue(this_hctx, from_sched);
> +	} else if (pt) {
> +		spin_lock(&this_hctx->lock);
> +		list_splice_tail_init(&list, &this_hctx->dispatch);
> +		spin_unlock(&this_hctx->lock);
> +		blk_mq_run_hw_queue(this_hctx, from_sched);
>  	} else {
>  		blk_mq_insert_requests(this_hctx, this_ctx, &list, from_sched);
>  	}

I think this would look at lot better as:

	if (pt) {
		...
	} else if (this_hctx->queue->elevator) {
		...
	} else {
		...
	}

and add a comment above that first if condition on why this distinction
is being made.

-- 
Jens Axboe

