Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F41C433EF
	for <linux-block@archiver.kernel.org>; Sat, 28 May 2022 08:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349586AbiE1IRc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 May 2022 04:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245061AbiE1IRb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 May 2022 04:17:31 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF8133A1B
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 01:17:29 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c65so5668047pfb.1
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 01:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c5QAguI+Lbk8TT+nFUnJqGkRX4WjRMjAO2PU0fsdrJw=;
        b=XmykWlyGO4QL8IniYO0O2SHJlyl/JTaIT4C350CtDuUm/OwbOMuU5kBh85eoVWj9fR
         aZGhgL4yPDDJlcDDCPy3WIlUqTYlALqMZVeJCm+G7e/86DYfzge+ddVcdSvtZbDaXqti
         /JRJSwEwhGqlQMXIfsk8oTDUBxwDm8ZSKSKL57tMlQJAYdzgSKGy8kiL8YJg/YWH6uYN
         MfWfQFxyapzurtu7gRVqSUnkNLnfAOHdIQvh1YV1RANgxY5DtueqJpmU4omILZXaRqAq
         R3hzv/4Lgr42K9CKP/jZFq5owRReQyq5wa2kNZhwO73EHaXyTSQ83pmgraqkdBcfNEN/
         krCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c5QAguI+Lbk8TT+nFUnJqGkRX4WjRMjAO2PU0fsdrJw=;
        b=GdZd6nkAxveCps5+eR2iZjRWjwETcM8FhDMWytj4r3g3pvFmWDelL7ThPykPhJo5O4
         PNF511n2qpO+yvk6oscyBCv7RZZUSZQZ4KJkcieVHs+ORm/hGtAQ7JxRQncIA/4E2n2M
         eM4OOZnpDF9sKGU0amb9BFYG3GOcWlSLOCdMzSkE8g3OPAmFcXeCMbClEBb0QqPgYps3
         YzSosq/jSVOo5KL6+CeWJwkgnDULFMo163qHvWkiVEp+zKxwf9Twf87jAZ8Y7IElhIy/
         Nbm6uFG2NmH6V5yHooA0RGQA81if2NGoFg03CU4Ct6DvyQ5QAXVNkb2Yrl3yUFktXKul
         CGgw==
X-Gm-Message-State: AOAM532ECXET3Dx8ZrnKvkqBs3AkVbE/lkPbUi8MOi1grOGX3rQwwZhk
        14szGr3pmU+NFvQD6MfnwgzEJQ==
X-Google-Smtp-Source: ABdhPJywGMdzhJQWZhaASe7KCIjsGY399FeZY50UwZzFMVUa8CmoHZjRvFwqOnfP2aSM8og7PUqnLA==
X-Received: by 2002:a63:235b:0:b0:3fb:de4b:4de1 with SMTP id u27-20020a63235b000000b003fbde4b4de1mr979995pgm.198.1653725848963;
        Sat, 28 May 2022 01:17:28 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e62:c260:d4c7:b261:8d6:3a6b? ([2409:8a28:e62:c260:d4c7:b261:8d6:3a6b])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902ebca00b00161ac982b52sm5063978plg.95.2022.05.28.01.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 01:17:28 -0700 (PDT)
Message-ID: <c76ee7e2-3dfe-b645-c32f-4f061b22ebc9@bytedance.com>
Date:   Sat, 28 May 2022 16:17:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] blk-iocost: fix false positive lagging
Content-Language: en-US
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220526133554.21079-1-zhouchengming@bytedance.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220526133554.21079-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/5/26 21:35, Chengming Zhou wrote:
> I found many false positive lagging during iocost test.
> 
> Since iocg->vtime will be advanced to (vnow - margins.target)
> in hweight_after_donation(), which called throw away excess,
> the iocg->done_vtime will also be advanced that much.
> 
>        period_at_vtime  <--period_vtime-->  vnow
>               |                              |
>   --------------------------------------------------->
>         |<--->|
>      margins.target
>         |->
>   vtime, done_vtime
> 
> If that iocg has some inflight io when vnow, but its done_vtime
> is before period_at_vtime, ioc_timer_fn() will think it has
> lagging io, even these io maybe issued just before now.
> 
> This patch change the condition to check if vdone is before
> (period_at_vtime - margins.target) instead of period_at_vtime.
> 
> But there is another problem that this patch doesn't fix.
> Since vtime will be advanced, we can't check if vtime is
> after (vnow - MAX_LAGGING_PERIODS * period_vtime) to tell
> whether this iocg pin lagging for too long.
> 
> Maybe we can add lagging_periods in iocg to record how many
> periods this iocg pin lagging, but I don't know when to clean it.

Hello tejun, I add lagging_periods in iocg based on the original patch,
to record how many periods this iocg pin lagging. So we can use it to
avoid letting cmds which take a very long time pin lagging for too long.

Thanks.


diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 33a11ba971ea..998bb38ffb37 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -541,6 +541,8 @@ struct ioc_gq {
        u64                             indebt_since;
        u64                             indelay_since;

+       int                             lagging_periods;
+
        /* this iocg's depth in the hierarchy and ancestors including self */
        int                             level;
        struct ioc_gq                   *ancestors[];
@@ -2257,10 +2259,13 @@ static void ioc_timer_fn(struct timer_list *timer)
                if ((ppm_rthr != MILLION || ppm_wthr != MILLION) &&
                    !atomic_read(&iocg_to_blkg(iocg)->use_delay) &&
                    time_after64(vtime, vdone) &&
-                   time_after64(vtime, now.vnow -
-                                MAX_LAGGING_PERIODS * period_vtime) &&
-                   time_before64(vdone, now.vnow - period_vtime))
-                       nr_lagging++;
+                   time_before64(vdone, ioc->period_at_vtime - ioc->margins.target)) {
+                       if (iocg->lagging_periods < MAX_LAGGING_PERIODS) {
+                               nr_lagging++;
+                               iocg->lagging_periods++;
+                       }
+               } else if (iocg->lagging_periods)
+                       iocg->lagging_periods = 0;

                /*
                 * Determine absolute usage factoring in in-flight IOs to avoid


> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  block/blk-iocost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 33a11ba971ea..42e301b7527b 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2259,7 +2259,7 @@ static void ioc_timer_fn(struct timer_list *timer)
>  		    time_after64(vtime, vdone) &&
>  		    time_after64(vtime, now.vnow -
>  				 MAX_LAGGING_PERIODS * period_vtime) &&
> -		    time_before64(vdone, now.vnow - period_vtime))
> +		    time_before64(vdone, ioc->period_at_vtime - ioc->margins.target))
>  			nr_lagging++;
>  
>  		/*
