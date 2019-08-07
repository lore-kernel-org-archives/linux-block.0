Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEF6C433FF
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7052821E71
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 17:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEB2e7wN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbfHGRrW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:47:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38680 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387998AbfHGRrW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Aug 2019 13:47:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id m12so3270160plt.5;
        Wed, 07 Aug 2019 10:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8fKIs5HmldqKJXOBQb9huSxRBPki3Qn9JZnOfAj/Rdk=;
        b=XEB2e7wNqB2m49hK4ftE+INqsgWoyudpIDYy5SlJuEbnr1Djf7Dl6LOtComCXarNE/
         b1ZxrzZjZG+dD17SwPQ/+u5fqKD9x1k5clbN/HPh1XsGacOtrAlvdI4KbUI27oqVNgit
         GoAoF1Q3iFfybHLkEL+JWz3f2g0Q0sxKiyxsjw5NzbG4hvPtpcA7icXpZr4wepqBdp47
         VeRGKgcstao9/Z6GkBk4r2zjzhF6AICxcAYYXlsO2K/kLTlH8iRNXXuaDTELujEEeIkC
         R4H/UfyFIzC9rovEkaTMvV4N+HHyueyaiZY1A/9XglbtlqicOFhil516sPpK9f2Dptx4
         zgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8fKIs5HmldqKJXOBQb9huSxRBPki3Qn9JZnOfAj/Rdk=;
        b=n/cFsvif8q1Gp8TXpjXmj+gF1jHcWY3H+9rZB9EDS0HQTtT+hMWAUj6ppz8JnYMmwD
         xBur6XT7SY7YfH5zwaQxo9sy0HbluaJY3pSByUH5bRTuDgkSzSeB6b5Qs+aMTjKGDD1B
         Jks/Tdo2683KbSTxVgxIhZ7rYfWxWHNeMNtQwS7rh3meh7oUsi+roLHFCKeO5NkQX9Pm
         51BpittdgP8FcqaCCQb5auS42j9Z7mKzN441g8wSRIZdjk31Z07Vl6g/8u6bhwOevIJb
         7gaXKYFFxCmJA7Yk+s9V1GBwJCzjzluHAqEeIq7qUPrxGnnTqzNUfbact9xfXHs5irCt
         +N6g==
X-Gm-Message-State: APjAAAUG76SotN6KVDGXsbsMY+mdYzvPlC4ijQQIubzlMp/KPbO3p1hQ
        Uqiuoi3OCbHcvEmzivvOn/Y=
X-Google-Smtp-Source: APXvYqxcecStrlYvq99eQBjStEF4krVCq/KjMpJcelSsCaTkILW/X8TgwG4lhY/4wFlR3GZDhjETzQ==
X-Received: by 2002:a17:902:e6:: with SMTP id a93mr9213340pla.175.1565200041736;
        Wed, 07 Aug 2019 10:47:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u16sm24436661pgm.83.2019.08.07.10.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 10:47:20 -0700 (PDT)
Subject: Re: [BUGFIX 1/1] block, bfq: handle NULL return value by
 bfq_init_rq()
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Hsin-Yi Wang <hsinyi@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Doug Anderson <dianders@chromium.org>
References: <20190807172111.4718-1-paolo.valente@linaro.org>
 <20190807172111.4718-2-paolo.valente@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c2833bf7-16a2-7eec-4497-69ba02779669@roeck-us.net>
Date:   Wed, 7 Aug 2019 10:47:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807172111.4718-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/7/19 10:21 AM, Paolo Valente wrote:
> As reported in [1], the call bfq_init_rq(rq) may return NULL in case
> of OOM (in particular, if rq->elv.icq is NULL because memory
> allocation failed in failed in ioc_create_icq()).
> 
> This commit handles this circumstance.
> 
> [1] https://lkml.org/lkml/2019/7/22/824
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Hsin-Yi Wang <hsinyi@google.com>
> Cc: Hsin-Yi Wang <hsinyi@google.com>
> Cc: Nicolas Boichat <drinkcat@chromium.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   block/bfq-iosched.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 586fcfe227ea..32686300d89b 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2250,9 +2250,14 @@ static void bfq_request_merged(struct request_queue *q, struct request *req,
>   	    blk_rq_pos(container_of(rb_prev(&req->rb_node),
>   				    struct request, rb_node))) {
>   		struct bfq_queue *bfqq = bfq_init_rq(req);
> -		struct bfq_data *bfqd = bfqq->bfqd;
> +		struct bfq_data *bfqd;
>   		struct request *prev, *next_rq;
>   
> +		if (!bfqq)
> +			return;
> +
> +		bfqd = bfqq->bfqd;
> +
>   		/* Reposition request in its sort_list */
>   		elv_rb_del(&bfqq->sort_list, req);
>   		elv_rb_add(&bfqq->sort_list, req);
> @@ -2299,6 +2304,9 @@ static void bfq_requests_merged(struct request_queue *q, struct request *rq,
>   	struct bfq_queue *bfqq = bfq_init_rq(rq),
>   		*next_bfqq = bfq_init_rq(next);
>   
> +	if (!bfqq)
> +		return;
> +
>   	/*
>   	 * If next and rq belong to the same bfq_queue and next is older
>   	 * than rq, then reposition rq in the fifo (by substituting next
> @@ -5436,12 +5444,12 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>   
>   	spin_lock_irq(&bfqd->lock);
>   	bfqq = bfq_init_rq(rq);
> -	if (at_head || blk_rq_is_passthrough(rq)) {
> +	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
>   		if (at_head)
>   			list_add(&rq->queuelist, &bfqd->dispatch);
>   		else
>   			list_add_tail(&rq->queuelist, &bfqd->dispatch);
> -	} else { /* bfqq is assumed to be non null here */
> +	} else {
>   		idle_timer_disabled = __bfq_insert_request(bfqd, rq);
>   		/*
>   		 * Update bfqq, because, if a queue merge has occurred
> 

