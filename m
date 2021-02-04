Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D65CC433DB
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 19:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF1064F51
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 19:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbhBDTsj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237778AbhBDTsi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 14:48:38 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A099C0613D6
        for <linux-block@vger.kernel.org>; Thu,  4 Feb 2021 11:47:57 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o63so2853126pgo.6
        for <linux-block@vger.kernel.org>; Thu, 04 Feb 2021 11:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UNQeDaGTHeZ4hWpu6lPZygo8At4WogrdXFCBEzcrTPs=;
        b=l1k4XOlXlP73vZIvqQ3aRJQusCdVtS8Y+MD5ZYYmx0Qa1jZAkvLvZXujtdH6lLM4NF
         8XSq7tlLK0L2CcDnujybB8uMh2bFc/xDRD2xRYb5DJzAxTXhsYM4BWTP9vfyrbbxHU4k
         /kkk5saqgr0dLQ6cAZ8q/uLw7/jJZIO5b1qrqYMFS8fvbht0Qw3KndU/94gw544Yt3or
         AhClJiWTbHOEPzBXC4mMEubkiqTCKFT16AAi/5OFUusQtotMQCVEZ7H/nck7oFAK7cWV
         gSMZg0mLg5z4CdNXrL4HtM0UNyR07KH9yvy/gV86qADqG2YBT6OHkmKvA49eIOtLVZSf
         K60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UNQeDaGTHeZ4hWpu6lPZygo8At4WogrdXFCBEzcrTPs=;
        b=lZ0JLo7Lnci1soh2Rhxh2NzoVjGD2Z7oDW57EUvshjHSIH6veZdq/hz/OXFqXe7+Fg
         RHOytFOhD2yGFuyfb/ijbOYNvD4rHxuAULRMEqXluhaYkzwjG1lh4S2jfc9/5ezgSvqS
         h46Ah/hyHqNUQUSg1ULn0PUg1xVE3BMpnz/8kaGz7Kzwi7ngWqfrXTodq1xk3iPSi4pg
         OP+QA25cnN+vNy9uO/A4JsJO8oC11OM6CS6KQOy7vzAIrIS+Awnc68yZoKfPiZq61fj7
         Vdra3UyFE7y6mU/jMdilid9DnBOdRxRpoU0LtSTCoHlHDV8W8MH/eeKb2stvdWeIrese
         5gWQ==
X-Gm-Message-State: AOAM5309AvZcmZE0wSssgRfMaJ0xpGhzLbJjKhd23B3sSNBWGUHmERpH
        Fzgacy5Z3o8BytJWLe/1gi+gBpln4QrVwg==
X-Google-Smtp-Source: ABdhPJzFHG6hhCg1tOpnPwA0tXmN98Pg8FDpRCGuv4nZKkhcovV31gkSQIr5Bi9lcndSjHlQi+rnkA==
X-Received: by 2002:a63:c54c:: with SMTP id g12mr543130pgd.449.1612468075652;
        Thu, 04 Feb 2021 11:47:55 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:e217])
        by smtp.gmail.com with ESMTPSA id 7sm6573443pfh.142.2021.02.04.11.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:47:53 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:47:52 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Yang Yang <yang.yang@vivo.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        onlyfever@icloud.com
Subject: Re: [PATCH] kyber: introduce kyber_depth_updated()
Message-ID: <YBxPaEVcYuVC+FKD@relinquished.localdomain>
References: <20210122090636.55428-1-yang.yang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122090636.55428-1-yang.yang@vivo.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 22, 2021 at 01:06:36AM -0800, Yang Yang wrote:
> Hang occurs when user changes the scheduler queue depth, by writing to
> the 'nr_requests' sysfs file of that device.
> This patch introduces kyber_depth_updated(), so that kyber can update its
> internal state when queue depth changes.

Do you have a reproducer for this? It'd be useful to turn that into a
blktest.

I _think_ this fix is correct other than the comment below, but it'd be
helpful to have an explanation in the commit message of how exactly it
gets stuck without the fix.

> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> ---
>  block/kyber-iosched.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> index dc89199bc8c6..b64f80d3eaf3 100644
> --- a/block/kyber-iosched.c
> +++ b/block/kyber-iosched.c
> @@ -353,19 +353,9 @@ static void kyber_timer_fn(struct timer_list *t)
>  	}
>  }
>  
> -static unsigned int kyber_sched_tags_shift(struct request_queue *q)
> -{
> -	/*
> -	 * All of the hardware queues have the same depth, so we can just grab
> -	 * the shift of the first one.
> -	 */
> -	return q->queue_hw_ctx[0]->sched_tags->bitmap_tags->sb.shift;
> -}
> -
>  static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
>  {
>  	struct kyber_queue_data *kqd;
> -	unsigned int shift;
>  	int ret = -ENOMEM;
>  	int i;
>  
> @@ -400,9 +390,6 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
>  		kqd->latency_targets[i] = kyber_latency_targets[i];
>  	}
>  
> -	shift = kyber_sched_tags_shift(q);
> -	kqd->async_depth = (1U << shift) * KYBER_ASYNC_PERCENT / 100U;
> -
>  	return kqd;
>  
>  err_buckets:
> @@ -458,9 +445,18 @@ static void kyber_ctx_queue_init(struct kyber_ctx_queue *kcq)
>  		INIT_LIST_HEAD(&kcq->rq_list[i]);
>  }
>  
> -static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
> +static void kyber_depth_updated(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
> +	struct blk_mq_tags *tags = hctx->sched_tags;
> +
> +	kqd->async_depth = tags->bitmap_tags->sb.depth * KYBER_ASYNC_PERCENT / 100U;

This isn't equivalent to the old code. sbitmap::depth is the number of
bits in the whole sbitmap. 2^sbitmap::shift is the number of bits used
in a single word of the sbitmap. async_depth is the number of bits to
use from each word (via sbitmap_get_shallow()).

This is setting async_depth to a fraction of the entire size of the
sbitmap, which is probably greater than the size of a single word,
effectively disabling the async depth limiting.
