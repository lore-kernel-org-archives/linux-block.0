Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA08C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 16:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33C320735
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 16:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391938AbhAZQTq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392857AbhAZQTc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 11:19:32 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2257EC061756
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 08:18:52 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id m6so10719031pfk.1
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 08:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ybJ6gWpX+rDIXWsdEFq3tLyTPHDHLv+rGou+AlbGZr4=;
        b=T7UBQE+QoKfMUXb7lbuCLF1k/4H0RpYaZ44AyRtJODjcn+hEXpMlr3rYfze2ZyrslN
         quH1BlOU+DjpdpZ550TaN8aZG3Z9UPEsn7UhZw7ecZvxCOyAdGirIOZw1+XvvHHLJ1Iw
         jxvexoBZpzwew2iXzlXRLE8bUUdAK2SN/B8uzvg4JOEifWfJ5+HpKdKzqV6zkdpVbQVa
         2Fx9RMoAQR9j0TryM7hnHTRJvXRcZQR/draHPl0s07fhauJ7L2a6VNXKatsyHulGr8nG
         WqezY2fpjKr+VWH+k2G2elzJossp7S+verV68XpMCs8VRC7zwwy0+XuBz3dpz3e8WoOI
         OHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ybJ6gWpX+rDIXWsdEFq3tLyTPHDHLv+rGou+AlbGZr4=;
        b=qM8HgPsem1dOBgH0g/d6QLaoTYj+NiagVSLHxhJuHL+9/XHXXemcYw0AP+wR6EigVs
         kk4lYO5t+CE4I5CMnPX0POGGuI9XWxB2kDrqAv0oH/RAEigEMPPHoGAe3FD8We1p02CA
         BMWXRMkrrFyXTSrq/WqkZSk5WK0ZvsSIKFjjvxWwKt4dw3icdCvu6utouVV2L3RZMXKg
         dJQNIc2e1XwZfh7F2rVsh/TYDIKghAOwkeg861GIjibwrHYmcTG6DNn0GpFuqKlSMx0t
         OIx04oFYvjQIsuwhX2K1WyMkjkNENlmTE60KeKpyRaY7oUcTHpg9TX1e+LyYytfGgtIo
         v7QQ==
X-Gm-Message-State: AOAM530IlapsmJUjAMfmnV4KKDFbnfr3XnVgY05qc2yHjoE3WuZ3ZsRe
        PwFNbGCtNPOmTvZwg8TspwxIsQ==
X-Google-Smtp-Source: ABdhPJwWUOxDGJp1Oeck5SAUv/5UJTfX23gWRQNidk6SixCZiKPg9WScKL5fOsYeh/uzEDxHOCFicg==
X-Received: by 2002:a62:ac18:0:b029:1c0:4398:33b5 with SMTP id v24-20020a62ac180000b02901c0439833b5mr6237439pfe.10.1611677931672;
        Tue, 26 Jan 2021 08:18:51 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id z16sm19355561pgj.51.2021.01.26.08.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 08:18:51 -0800 (PST)
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 2/6] block, bfq: put reqs of waker and
 woken in dispatch list
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
 <20210126105102.53102-3-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <36ecc71d-ef51-c667-74f8-d8f289e2f7db@kernel.dk>
Date:   Tue, 26 Jan 2021 09:18:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126105102.53102-3-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/21 3:50 AM, Paolo Valente wrote:
> Consider a new I/O request that arrives for a bfq_queue bfqq. If, when
> this happens, the only active bfq_queues are bfqq and either its waker
> bfq_queue or one of its woken bfq_queues, then there is no point in
> queueing this new I/O request in bfqq for service. In fact, the
> in-service queue and bfqq agree on serving this new I/O request as
> soon as possible. So this commit puts this new I/O request directly
> into the dispatch list.
> 
> Tested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-iosched.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index a83149407336..e5b83910fbe0 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5640,7 +5640,22 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	spin_lock_irq(&bfqd->lock);
>  	bfqq = bfq_init_rq(rq);
> -	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
> +
> +	/*
> +	 * Additional case for putting rq directly into the dispatch
> +	 * queue: the only active bfq_queues are bfqq and either its
> +	 * waker bfq_queue or one of its woken bfq_queues. In this
> +	 * case, there is no point in queueing rq in bfqq for
> +	 * service. In fact, the in-service queue and bfqq agree on
> +	 * serving this new I/O request as soon as possible.
> +	 */
> +	if (!bfqq ||
> +	    (bfqq != bfqd->in_service_queue &&
> +	     bfqd->in_service_queue != NULL &&
> +	     bfq_tot_busy_queues(bfqd) == 1 + bfq_bfqq_busy(bfqq) &&
> +	     (bfqq->waker_bfqq == bfqd->in_service_queue ||
> +	      bfqd->in_service_queue->waker_bfqq == bfqq)) ||
> +	    at_head || blk_rq_is_passthrough(rq)) {
>  		if (at_head)
>  			list_add(&rq->queuelist, &bfqd->dispatch);
>  		else
> 

This is unreadable... Just seems like you are piling heuristics in to
catch some case, and it's neither readable nor clean.

-- 
Jens Axboe

