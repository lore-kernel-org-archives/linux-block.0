Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B30C00140
	for <linux-block@archiver.kernel.org>; Wed, 24 Aug 2022 16:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiHXQvh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Aug 2022 12:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239116AbiHXQv1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Aug 2022 12:51:27 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7A75B066
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 09:51:26 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso2267802pjk.0
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 09:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=kzjUS9TKBM2GrfXmzu4yKVJ4/66/uFi4GKGMxJQcV6Q=;
        b=MQTXn7fxe7pLwWwc3A5QQTZi9uWKoBYoTITpWIpUZsCUpqyDGtuJf3CV49HFahas2e
         ZULkiBvMzewgN5AvnVxBVLUAfn28G9NKj7QwCukrE2zv0oOxzdR8rzWXIDCATmWDv9ND
         nb30IphjEnL+jGpm0Uc4NM4WhZ8j/Z4iEOPLVkOibr7KC79UqMW26SQuwzql/pOua4KC
         CvvGWggNf2JV90GfrrD43/yMi2XfSF33KbqJWLSewUgEKo8GWpF59GBEg8F/jGcjtyXB
         En12NdVjF/sK0T8Jrx0+Fs6Ncix6I6aOt4v7bUNz/FYqZbrcWbruRUXbZ5yFD01/nmVV
         DPmw==
X-Gm-Message-State: ACgBeo3ZZDb4f8YgCTXqpUiSVoxqhWl9VObAuMVPxxh1oWAZgKFLtEtt
        cRPItpAHS5PfxBU8HJ08tOOyf2MhkJs=
X-Google-Smtp-Source: AA6agR4w0zcfOmJUHLMCN355574tiJou5BlxWOQYFXKfoSb+sVIESSGhhCppNl1WcnINc5G5veut8w==
X-Received: by 2002:a17:903:2c5:b0:172:d1f2:401d with SMTP id s5-20020a17090302c500b00172d1f2401dmr20180431plk.56.1661359885506;
        Wed, 24 Aug 2022 09:51:25 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:222f:dc9c:99a3:dfb8? ([2620:15c:211:201:222f:dc9c:99a3:dfb8])
        by smtp.gmail.com with ESMTPSA id s19-20020a635253000000b0040d75537824sm7028740pgl.86.2022.08.24.09.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 09:51:24 -0700 (PDT)
Message-ID: <360b24b1-0f7f-4559-b39f-1c398349932f@acm.org>
Date:   Wed, 24 Aug 2022 09:51:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] block: I/O error occurs during SATA disk stress test
Content-Language: en-US
To:     Gu Mi <gumi@linux.alibaba.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <1661341010-80107-1-git-send-email-gumi@linux.alibaba.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1661341010-80107-1-git-send-email-gumi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/24/22 04:36, Gu Mi wrote:
> The problem occurs in two async processes, One is when a new IO
> calls the blk_mq_start_request() interface to start sending,The other
> is that the block layer timer process calls the blk_mq_req_expired
> interface to check whether there is an IO timeout.
> 
> When an instruction out of sequence occurs between blk_add_timer
> and WRITE_ONCE(rq->state,MQ_RQ_IN_FLIGHT) in the interface
> blk_mq_start_request,at this time, the block timer is checking the
> new IO timeout, Since the req status has been set to MQ_RQ_IN_FLIGHT
> and req->deadline is 0 at this time, the new IO will be misjudged as
> a timeout.
> 
> Our repair plan is for the deadline to be 0, and we do not think
> that a timeout occurs. At the same time, because the jiffies of the
> 32-bit system will be reversed shortly after the system is turned on,
> we will add 1 jiffies to the deadline at this time.
> 
> Signed-off-by: Gu Mi <gumi@linux.alibaba.com>
> ---
>   block/blk-mq.c      | 2 ++
>   block/blk-timeout.c | 4 ++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4b90d2d..6defaa1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1451,6 +1451,8 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
>   		return false;
>   
>   	deadline = READ_ONCE(rq->deadline);
> +	if (unlikely(deadline == 0))
> +		return false;
>   	if (time_after_eq(jiffies, deadline))
>   		return true;
>   
> diff --git a/block/blk-timeout.c b/block/blk-timeout.c
> index 1b8de041..6fc5088 100644
> --- a/block/blk-timeout.c
> +++ b/block/blk-timeout.c
> @@ -140,6 +140,10 @@ void blk_add_timer(struct request *req)
>   	req->rq_flags &= ~RQF_TIMED_OUT;
>   
>   	expiry = jiffies + req->timeout;
> +#ifndef CONFIG_64BIT
> +/* In case INITIAL_JIFFIES wraps on 32-bit */
> +	expiry |= 1UL;
> +#endif
>   	WRITE_ONCE(req->deadline, expiry);
>   
>   	/*

Shouldn't this be fixed by inserting a barrier inside 
blk_mq_start_request() instead of a patch like the above?

Thanks,

Bart.
