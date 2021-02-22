Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC78EC433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 19:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828E664E31
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 19:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhBVThF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhBVTgu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 14:36:50 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5A9C061574
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 11:36:09 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z7so8364627plk.7
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 11:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D0lCJGLUp+Sqpz3gm0fk4vpgl8TNXWJBopnuqP6zbHk=;
        b=Wo6HdEgQESOa5Ednyt/pLtwSjUYY1UlraKsD5d2Y/JwKwWFQJtsBlP2lYoN0DNV1OD
         5rpZIxl/CEnfSRuN6TUMGgVlDobF5WUY69ppN8n9DhT5c5eKeXKNqzKOTqtiqFjFMzOs
         laPF6ow7Xwh9Y1Vhcb71SGXV9dpCZc2RMVwzi2Zup642zZzhrWI4K6s8Ejt5NMil4bjV
         /ZnbX9gvsWeyHk4GKAhsojcK604DboMzaCLt55xU2lM+EvsjagzclHgyVbK6N6lnaDw/
         7FDDzNzITAak+DoTWrRuH6mE6w//UGlsjyR4b2sLD6lh8AaCiXAn9UspMgn93NI9VdcO
         7Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D0lCJGLUp+Sqpz3gm0fk4vpgl8TNXWJBopnuqP6zbHk=;
        b=fJ3PoLbxpjhmbSiWC5DOJid8JC8RTcU6cS0VIJJf6skgcLAdIBnvKv9aU1JV8bqI2q
         iYEvsHxBm0hm+MbX0Xfd4AdBc5oZTWu+kSQlVl3nMl454zAQOI+L5haPo48CiMMCWQ+Z
         dz/X3xTSy3aNeo6JEFE9l9exkgzRiINsYtSkq7+24Mfx3CtK6/4lIH+OCn9gfbRrIL2W
         AEHejeZG1DANVvbu0IUXkkwL22y+5zmHRHoi+2KYOxi4rQWZu9L3TzdIyqvOioZJTrTD
         ySa3iOKoZdBAl2GHOWBNV0VIz9XEo2L+9DIkTMZtHyCOL4OxuC0p+8hrd33koLXkU62x
         pljg==
X-Gm-Message-State: AOAM531a9qGebtxt7hnjGcGoSu1/u0CRirMnt8fYMXOABqLBNzMLIHSP
        Rl0FVDSDcvkmmAQ5SK69wCd13b0g8ohSrg==
X-Google-Smtp-Source: ABdhPJwcATYhzjYXnm/vSrCC0/rMa9r3w5vITzFBPX2hRtjG2kC15C1+f8gsjSep6WFZAAnlbtsmKA==
X-Received: by 2002:a17:90a:4a06:: with SMTP id e6mr9122594pjh.141.1614022569182;
        Mon, 22 Feb 2021 11:36:09 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:3d20])
        by smtp.gmail.com with ESMTPSA id n15sm18680088pgl.31.2021.02.22.11.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 11:36:07 -0800 (PST)
Date:   Mon, 22 Feb 2021 11:36:06 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Yang Yang <yang.yang@vivo.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, onlyfever@icloud.com
Subject: Re: [PATCH v2] kyber: introduce kyber_depth_updated()
Message-ID: <YDQHpiHgQr2kqbz6@relinquished.localdomain>
References: <20210205091311.129498-1-yang.yang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205091311.129498-1-yang.yang@vivo.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 05, 2021 at 01:13:10AM -0800, Yang Yang wrote:
> Hang occurs when user changes the scheduler queue depth, by writing to
> the 'nr_requests' sysfs file of that device.
> 
> The details of the environment that we found the problem are as follows:
>   an eMMC block device
>   total driver tags: 16
>   default queue_depth: 32
>   kqd->async_depth initialized in kyber_init_sched() with queue_depth=32
> 
> Then we change queue_depth to 256, by writing to the 'nr_requests' sysfs
> file. But kqd->async_depth don't be updated after queue_depth changes.
> Now the value of async depth is too small for queue_depth=256, this may
> cause hang.
> 
> This patch introduces kyber_depth_updated(), so that kyber can update
> async depth when queue depth changes.
> 
> Signed-off-by: Yang Yang <yang.yang@vivo.com>

I wasn't able to reproduce the hang, but this looks correct, and it
passed my tests.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> ---
> v2:
> - Change the commit message
> - Change from sbitmap::depth to 2^sbitmap::shift
> ---
>  block/kyber-iosched.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> index dc89199bc8c6..17215b6bf482 100644
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
> @@ -458,9 +445,19 @@ static void kyber_ctx_queue_init(struct kyber_ctx_queue *kcq)
>  		INIT_LIST_HEAD(&kcq->rq_list[i]);
>  }
>  
> -static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
> +static void kyber_depth_updated(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
> +	struct blk_mq_tags *tags = hctx->sched_tags;
> +	unsigned int shift = tags->bitmap_tags->sb.shift;
> +
> +	kqd->async_depth = (1U << shift) * KYBER_ASYNC_PERCENT / 100U;
> +
> +	sbitmap_queue_min_shallow_depth(tags->bitmap_tags, kqd->async_depth);
> +}
> +
> +static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
> +{
>  	struct kyber_hctx_data *khd;
>  	int i;
>  
> @@ -502,8 +499,7 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
>  	khd->batching = 0;
>  
>  	hctx->sched_data = khd;
> -	sbitmap_queue_min_shallow_depth(hctx->sched_tags->bitmap_tags,
> -					kqd->async_depth);
> +	kyber_depth_updated(hctx);
>  
>  	return 0;
>  
> @@ -1022,6 +1018,7 @@ static struct elevator_type kyber_sched = {
>  		.completed_request = kyber_completed_request,
>  		.dispatch_request = kyber_dispatch_request,
>  		.has_work = kyber_has_work,
> +		.depth_updated = kyber_depth_updated,
>  	},
>  #ifdef CONFIG_BLK_DEBUG_FS
>  	.queue_debugfs_attrs = kyber_queue_debugfs_attrs,
> -- 
> 2.17.1
> 
