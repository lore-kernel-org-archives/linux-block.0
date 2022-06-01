Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FE8C433EF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 12:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbiFAMcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 08:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345496AbiFAMci (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 08:32:38 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE2C3ED2D
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 05:32:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e24so1939096pjt.0
        for <linux-block@vger.kernel.org>; Wed, 01 Jun 2022 05:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=aNiEaNz3PE8EusgnD+3ibkIGrbwL5BaMxt0546m/AT0=;
        b=7LFoWcKWkG9OxI3/dLi7p9o3QifvcD7DXsD+OPVitSZbZ+T2UyHOHk5v3bBfRhyRZo
         hXpFPnPNnifxYROZmf3HvRaSmMING8uX8pqc3yvviDrLbqj5V6FlhErC7FjfPZapbhde
         6ggTFVVuFNQZTWcWhPU01mptOwUELhAqHQGdUM7hRUyhoqdDu/gjAUymuJrqDrQRSjPP
         ej1GZRJm5JIMAHm39fCbQzPs4+F5GJjYIDd2agQlmkoXBjv/ibFeJw9rYjMUmO5Q/VD8
         Pyck5Ea9JibWRUnR3Ndo5h7x2xcGg0PQ+3On5OKwCanHoRq+R6xZwdOOsWq+zfya1VaW
         Nwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=aNiEaNz3PE8EusgnD+3ibkIGrbwL5BaMxt0546m/AT0=;
        b=BW9xSxaJWeA7XKV6sjJGDOpn1yPKiL5ef+d7t5vwCR/EGNJKEL1PydfHMImD5JVxlV
         KU2813JeS1GHVeu0WonEYDQGuy+A7yAutD7ESdOMk2KnYUovht/BW4ut3U7rCh2RRc8j
         u4yICK8Uf2SbGObW+Ex43vddk2OUEgKk2m/eLZUbs7Z2ZN7e1U8RwgI5CM4Dnb07fM8B
         rdLWQu8TjmPL8373kK+gbtO08GGPhgN5Fj0kYtGBgrsGpCiXweL+x6R8tWX7jZUCdJ9M
         qz7+aG+a/tDpGwHq1Z6T5PNfR1ogh6bJY1BrlaHwSV40lVeD/DMxjX3GbtZUJJhDx3Oi
         20MQ==
X-Gm-Message-State: AOAM530ZHlg7Rb2Ndskm6LpSGXs55RVcm4pZ0wdJR6dCUZeSRVrfsEmf
        CLX5TPz0wDEGLLWnJbl8PzL6cS/PRCI9Ng==
X-Google-Smtp-Source: ABdhPJwUKBFlsa9ecDKitfTCWR3Frt6/fJqwij4Dl0w7nYOx8kQQEFrF1dIIZ7O90+SsdC/CYwQa3g==
X-Received: by 2002:a17:90a:d58d:b0:1e0:adde:a7f8 with SMTP id v13-20020a17090ad58d00b001e0addea7f8mr34225334pju.74.1654086757120;
        Wed, 01 Jun 2022 05:32:37 -0700 (PDT)
Received: from [10.4.211.178] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id e13-20020aa798cd000000b0050dc76281b8sm1438328pfm.146.2022.06.01.05.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 05:32:36 -0700 (PDT)
Message-ID: <08dac681-6877-1323-9394-ffe812c07934@bytedance.com>
Date:   Wed, 1 Jun 2022 20:32:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] blk-iocost: fix false positive lagging
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220526133554.21079-1-zhouchengming@bytedance.com>
 <c76ee7e2-3dfe-b645-c32f-4f061b22ebc9@bytedance.com>
In-Reply-To: <c76ee7e2-3dfe-b645-c32f-4f061b22ebc9@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/5/28 16:17, Chengming Zhou wrote:
> On 2022/5/26 21:35, Chengming Zhou wrote:
>> I found many false positive lagging during iocost test.
>>
>> Since iocg->vtime will be advanced to (vnow - margins.target)
>> in hweight_after_donation(), which called throw away excess,
>> the iocg->done_vtime will also be advanced that much.
>>
>>        period_at_vtime  <--period_vtime-->  vnow
>>               |                              |
>>   --------------------------------------------------->
>>         |<--->|
>>      margins.target
>>         |->
>>   vtime, done_vtime
>>
>> If that iocg has some inflight io when vnow, but its done_vtime
>> is before period_at_vtime, ioc_timer_fn() will think it has
>> lagging io, even these io maybe issued just before now.
>>
>> This patch change the condition to check if vdone is before
>> (period_at_vtime - margins.target) instead of period_at_vtime.
>>
>> But there is another problem that this patch doesn't fix.
>> Since vtime will be advanced, we can't check if vtime is
>> after (vnow - MAX_LAGGING_PERIODS * period_vtime) to tell
>> whether this iocg pin lagging for too long.
>>
>> Maybe we can add lagging_periods in iocg to record how many
>> periods this iocg pin lagging, but I don't know when to clean it.
> 
> Hello tejun, I add lagging_periods in iocg based on the original patch,
> to record how many periods this iocg pin lagging. So we can use it to
> avoid letting cmds which take a very long time pin lagging for too long.
> 
> Thanks.
> 
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 33a11ba971ea..998bb38ffb37 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -541,6 +541,8 @@ struct ioc_gq {
>         u64                             indebt_since;
>         u64                             indelay_since;
> 
> +       int                             lagging_periods;
> +
>         /* this iocg's depth in the hierarchy and ancestors including self */
>         int                             level;
>         struct ioc_gq                   *ancestors[];
> @@ -2257,10 +2259,13 @@ static void ioc_timer_fn(struct timer_list *timer)
>                 if ((ppm_rthr != MILLION || ppm_wthr != MILLION) &&
>                     !atomic_read(&iocg_to_blkg(iocg)->use_delay) &&
>                     time_after64(vtime, vdone) &&
> -                   time_after64(vtime, now.vnow -
> -                                MAX_LAGGING_PERIODS * period_vtime) &&
> -                   time_before64(vdone, now.vnow - period_vtime))
> -                       nr_lagging++;
> +                   time_before64(vdone, ioc->period_at_vtime - ioc->margins.target)) {
> +                       if (iocg->lagging_periods < MAX_LAGGING_PERIODS) {
> +                               nr_lagging++;
> +                               iocg->lagging_periods++;
> +                       }
> +               } else if (iocg->lagging_periods)
> +                       iocg->lagging_periods = 0;
> 
>                 /*
>                  * Determine absolute usage factoring in in-flight IOs to avoid
> 

Hi, I tested with this version, previous false laggings are gone. So I wonder
if I should send v2 for review?

Thanks!

> 
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  block/blk-iocost.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index 33a11ba971ea..42e301b7527b 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
>> @@ -2259,7 +2259,7 @@ static void ioc_timer_fn(struct timer_list *timer)
>>  		    time_after64(vtime, vdone) &&
>>  		    time_after64(vtime, now.vnow -
>>  				 MAX_LAGGING_PERIODS * period_vtime) &&
>> -		    time_before64(vdone, now.vnow - period_vtime))
>> +		    time_before64(vdone, ioc->period_at_vtime - ioc->margins.target))
>>  			nr_lagging++;
>>  
>>  		/*
