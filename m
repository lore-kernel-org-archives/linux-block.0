Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2180FECAA25
	for <linux-block@archiver.kernel.org>; Thu, 25 Aug 2022 17:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbiHYRSY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Aug 2022 13:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241976AbiHYRSN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Aug 2022 13:18:13 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247F7BCC25
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 10:18:12 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id s206so18463416pgs.3
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 10:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=sTNMlIHWUpF4OLthJ5DOfSgP+azXPkNFxPkkNsT2El0=;
        b=11AdyzGOEOiGyy4KyEA6cb5OzMmGDC0ogVY2N9GWp8RkafZlQrtEG1p7kwulSctmbO
         HVlLfsoS0OrFmHV9Pdjr0QvoiGAMxGGHyDa68vDIchjStbgN5OhZ9V4+rH/rtWxfHSlA
         4zUMMXWrtVndknz9cp07wQEN5KWpJ5Rpj0Ifzusk1wwTapsGNgKrejBhwNrYqxtaYhAf
         4AT/7ylF6ARjM1hf1GZy5XTo32L246n3PEEq3F2uGi63thzHVdnTQgwQOF+OpgiI/+vL
         Oev6ofdtq3Kllf4wDMSOLrVJW+F8pwXvC/pxPYa5DVb4apGMKzQWGpqQ10+Vvj8ojK9k
         b5KQ==
X-Gm-Message-State: ACgBeo1RXP2fSNkiQctfnKdMD48+ojrIf0ZJOdgXKcJarTFKSD+qYxV2
        po5o8q/jGoNUo0NGX4PrLUuQMOK8Jsg=
X-Google-Smtp-Source: AA6agR5eFaV2CNaRYVKrQTT7VCqVc3lU3uxNvfc8+/Ma01WZ4YaZJ/keEbE0wHzW/vyJoUpDvgUTyg==
X-Received: by 2002:a62:a512:0:b0:536:e2bd:e15e with SMTP id v18-20020a62a512000000b00536e2bde15emr109518pfm.1.1661447891354;
        Thu, 25 Aug 2022 10:18:11 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:349c:3078:d005:5a7e? ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id 188-20020a6204c5000000b005371c5859d6sm5111212pfe.60.2022.08.25.10.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 10:18:09 -0700 (PDT)
Message-ID: <a0adc078-c771-0925-f918-2c38fc308162@acm.org>
Date:   Thu, 25 Aug 2022 10:18:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] block: I/O error occurs during SATA disk stress test
Content-Language: en-US
To:     Gu Mi <gumi@linux.alibaba.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org
References: <1661411393-98514-1-git-send-email-gumi@linux.alibaba.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1661411393-98514-1-git-send-email-gumi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/25/22 00:09, Gu Mi wrote:
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
> v1->v2:
> 
> time_after_eq() can handle the overflow, so remove the change on 32-bit
> in blk_add_timer().
> 
>   block/blk-mq.c | 2 ++
>   1 file changed, 2 insertions(+)
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

rq->deadline == 0 can be a valid deadline value so the above patch 
doesn't look right to me.

Thanks,

Bart.
