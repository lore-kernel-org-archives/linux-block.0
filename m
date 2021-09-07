Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D241AC433F5
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F49610F8
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbhIGOzV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 10:55:21 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:37870 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhIGOzT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 10:55:19 -0400
Received: by mail-pg1-f177.google.com with SMTP id 17so10252261pgp.4;
        Tue, 07 Sep 2021 07:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=doC0bChKVgon7i4ZRt3+TPnbeJ72I5HQLlZ8D5aOmik=;
        b=DNInj884dEaTUsS9/+FFVNGe3eSoiTbdO3PqklLtsBkjpaKH2wkDMAySbyILA16UZK
         /KV/9CcbYohd1n5vc2tb9Tdsk/l6MLHo0audKAxUqvbj8Q50kaxG55Wr5gD9iVLras5h
         LMVBMX4yvZlFIp4H9B3JfZjMdFwQmx0O3xcU47AO0NL6kB+/4mmS8Cw8kW4iDYTquFmx
         IZ6nyV6sln15o5QgohENfnuOrJKK5hDLS3arK1saERfoqWhSjVuk1fuwoMfI2QwApMef
         ezX3GHINvBgLTpgvVmSiyMQsu2Gvn6/avcJhKf+JStTK3wMee4m672dEbTrOhcxuIoAA
         7Q6Q==
X-Gm-Message-State: AOAM532Buf55I9u25P5PL9ugGLsL9/wAZpuOtfCrxrkbIWS+2SO7GdD/
        3NH5+AFDLREl7yVQ/pCO/KV0EuFYaUM=
X-Google-Smtp-Source: ABdhPJw/61pCn3o3Bj+3yZcmZZd5o7qb9cP9Xe+8/ryMJv93EhKZzvVC+hl7yF2UQ5ZviC1U0qhEGQ==
X-Received: by 2002:a63:f913:: with SMTP id h19mr17589566pgi.351.1631026452118;
        Tue, 07 Sep 2021 07:54:12 -0700 (PDT)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id t3sm13765481pgo.51.2021.09.07.07.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 07:54:11 -0700 (PDT)
Subject: Re: [PATCH 2/2] Revert "mq-deadline: Fix request accounting"
To:     Niklas Cassel <Niklas.Cassel@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210907142145.112096-1-Niklas.Cassel@wdc.com>
 <20210907142145.112096-3-Niklas.Cassel@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d544384b-617f-b7a4-f895-72adc900f41b@acm.org>
Date:   Tue, 7 Sep 2021 07:54:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907142145.112096-3-Niklas.Cassel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/21 7:21 AM, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> This reverts commit b6d2b054e8baaee53fd2d4854c63cbf0f2c6262a.
> 
> blk-mq will no longer call the I/O scheduler .finish_request() callback
> for requests that were never inserted to the I/O scheduler.
> 
> Therefore, we can remove the logic inside mq-deadline that was added to
> workaround the (no longer existing) quirky behavior of blk-mq.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>   block/mq-deadline.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 7f3c3932b723..b2d1e3adcb39 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -678,7 +678,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>   
>   	prio = ioprio_class_to_prio[ioprio_class];
>   	dd_count(dd, inserted, prio);
> -	rq->elv.priv[0] = (void *)(uintptr_t)1;
>   
>   	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
>   		blk_mq_free_requests(&free);
> @@ -727,10 +726,12 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
>   	spin_unlock(&dd->lock);
>   }
>   
> -/* Callback from inside blk_mq_rq_ctx_init(). */
> +/*
> + * Nothing to do here. This is defined only to ensure that .finish_request
> + * method is called upon request completion.
> + */
>   static void dd_prepare_request(struct request *rq)
>   {
> -	rq->elv.priv[0] = NULL;
>   }

Please take a look at
https://lore.kernel.org/linux-block/18594aff-4a94-8a48-334c-f21ae32120c6@acm.org/
If dd_prepare_request() is removed I will have to reintroduce it.

Thanks,

Bart.
