Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E011FC433E6
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 14:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D0564E9C
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 14:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbhBBO10 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 09:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbhBBO0b (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 09:26:31 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E31EC0613D6
        for <linux-block@vger.kernel.org>; Tue,  2 Feb 2021 06:25:35 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id u17so21487406iow.1
        for <linux-block@vger.kernel.org>; Tue, 02 Feb 2021 06:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lZI6+KasWbG49+NKbb/hZXhdmrjrRJMyXzKpN/HIzkI=;
        b=qMu4mgWgSiH/ksGAFdHwZfzIx/clkth9QqGqBpRCibCylEpocEVwUJzkp4AOBN4J9W
         54lRJWCzLJlfzvx1eaHudBLSatE7wL9mFKAX3FG20XtkwrSVByBPljz1jqoEvLWnZtuE
         JU81SYUovPkbzlW/+A6uAhf7q2GqYhZ3/jFj4jVHR9eHHwwKPG+bEXS4K8NRISSBy3/k
         0PmoJ26+Ytz6/9QRvHxmTfVA+bVzcHEnU+X35m0QzF64JlswOQ3J69K114xEU/yALu8Q
         9P7H6r+Qd6pfjkwXQB4DO2ocuDI2GWREI2wLRjXKcaU6bd4yRkqHGXrDBbWSrDUkafu5
         eqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lZI6+KasWbG49+NKbb/hZXhdmrjrRJMyXzKpN/HIzkI=;
        b=HlOl78cIyIMrPXPWMPMHBmgbPjc0rnKfR55zrpmIMR1D+4+bcPuisweEZmVXrBf4yh
         sOsgu3kWV4gRk6vXt37Lhs6atLW3CX3Ub4eP+oXughb3nwF1sNvXuXRQbf+/fOS++g+d
         Q3zwX7juyW93S+y4gbet8lmvO7EPLdYqtL3DtNW5ZP+ELQ0IjFadsdcI7kVBbgGCok7E
         8enGvVFqzR6qBf3r5H0rMLwBfQc8DpKd6izlbR2J3pniXDJfKXDB0W+0ohiYwV1ngD5B
         P5jhn0sxrZt6KsnMrijg9lmLXhAzwsDsS3eNUEFqCIjvFlet1t3jQYr8wq9L+ohKa2gG
         aFwA==
X-Gm-Message-State: AOAM533ZvP5H2i6dmHz8KTcPQpzUGYMALMRmm/4Cdzqkn3TLFq0MY03O
        YKvolBIOuMF6FsTbI5TtAJqMDHzJfcvRAwMu
X-Google-Smtp-Source: ABdhPJyLIwTFEONrlu0HaUsk9fb4RXoc1955zvRPp6RbbOxaQXmxFeFkbwBl4T79dCAkSIJ11I0xyg==
X-Received: by 2002:a02:c98b:: with SMTP id b11mr11209288jap.123.1612275934858;
        Tue, 02 Feb 2021 06:25:34 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a15sm10945253ilb.11.2021.02.02.06.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 06:25:34 -0800 (PST)
Subject: Re: [PATCH] kyber: introduce kyber_depth_updated()
To:     Yang Yang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Cc:     onlyfever@icloud.com, Omar Sandoval <osandov@osandov.com>
References: <20210122090636.55428-1-yang.yang@vivo.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0c50715d-b410-eb5c-b351-1b0ff5925dc3@kernel.dk>
Date:   Tue, 2 Feb 2021 07:25:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210122090636.55428-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/22/21 2:06 AM, Yang Yang wrote:
> Hang occurs when user changes the scheduler queue depth, by writing to
> the 'nr_requests' sysfs file of that device.
> This patch introduces kyber_depth_updated(), so that kyber can update its
> internal state when queue depth changes.

Adding Omar.

> 
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
> +
> +	sbitmap_queue_min_shallow_depth(tags->bitmap_tags, kqd->async_depth);
> +}
> +
> +static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
> +{
>  	struct kyber_hctx_data *khd;
>  	int i;
>  
> @@ -502,8 +498,7 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
>  	khd->batching = 0;
>  
>  	hctx->sched_data = khd;
> -	sbitmap_queue_min_shallow_depth(hctx->sched_tags->bitmap_tags,
> -					kqd->async_depth);
> +	kyber_depth_updated(hctx);
>  
>  	return 0;
>  
> @@ -1022,6 +1017,7 @@ static struct elevator_type kyber_sched = {
>  		.completed_request = kyber_completed_request,
>  		.dispatch_request = kyber_dispatch_request,
>  		.has_work = kyber_has_work,
> +		.depth_updated = kyber_depth_updated,
>  	},
>  #ifdef CONFIG_BLK_DEBUG_FS
>  	.queue_debugfs_attrs = kyber_queue_debugfs_attrs,
> 


-- 
Jens Axboe

