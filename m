Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882DDC432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 00:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60960600CD
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 00:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhH0AGs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 20:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhH0AGr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 20:06:47 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B493C061757
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 17:06:00 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id b4so5154486ilr.11
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 17:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LFGroXY54D+83I5aVk+9vd4s8Uvr1280w5sgBUfaFvw=;
        b=wKPytfrM1ENLiXN2YvhouxxwOZCEoYtz8MNArf9tNTZhiFFDGTwH8yJ6Q0hUJFjztD
         mXGNfUx52TynTn2rzlK0N4vIa9WQVagerXRQ+q29oOXuHyyLCYjOsa+a83Yd6TMEFy4q
         mYe6FIdbeKY1/pmwG4s1BjMB5cMKKj6pHCYD5G8Oxe0lvzHEEMB5aWpN2vqkDg0G/r9M
         rrr2uIWyHEv5k6jJtHyIBa/0zcOJ/gnUDZlq+RNZ7UUsL3WvGQArJQ82/qSuITsVBFaL
         bnGNfWuA+9nZk/3Kf3P8vP6LVsbprmJJyiDqv1/4QrugGqyllu8CmmzxoBroFUBTX+MD
         Oxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LFGroXY54D+83I5aVk+9vd4s8Uvr1280w5sgBUfaFvw=;
        b=nMquiOxMco2V7VKiSiMEme7QIt2HEE2MVIw2Bjy0hVcaoi3BZ7thOAuYct4EJJBkKb
         lyXxDJeqgOwHmu1sUDuHlkG1AQX6iRPBeGgcthSvR615TFbxOMQZa9/0c1+vl8xypdZc
         3KJEdrmFhtP45Z+jF+2qlEBMZco2thOhrHJ28N4Bk5W71Iaa8aaVFUEzXNiC5+cbQ/hP
         4MgfjG+UmQWyJkGqf2DcfPwbQZ49WOYkIdP2pJAILVztrkPge0WER1V010Sj2qY0K6F6
         q6nM4B4aZt04n2/uffEe1+dGxYphQg9JeIcvYJiGvNVADuKFIq9ROaIzMD6e58Bkikpj
         csPA==
X-Gm-Message-State: AOAM531r0xalFO+UaydTEWFRANhCr1+HJRsftKpK6jDSzEtbJ1l2hrR2
        28xH9b1X8Gvd8adXqx3OvY0LwdYrhB1jnA==
X-Google-Smtp-Source: ABdhPJzEabHSBeWHfod+ZCdTB8XPqR2KuhEbPtePkEAvcxTypIgTEMAd5nhFlUfZql9lromcPc/ZmA==
X-Received: by 2002:a05:6e02:ee1:: with SMTP id j1mr4395168ilk.61.1630022759405;
        Thu, 26 Aug 2021 17:05:59 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o11sm2485608ilf.86.2021.08.26.17.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 17:05:59 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
To:     Bart Van Assche <bvanassche@acm.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
 <537620de-646d-e78e-ccb8-4105bac398b3@kernel.dk>
 <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
 <59c19a63-f321-94e8-cb31-87e88bd4e3d5@acm.org>
 <0ef7865d-a9ce-c5d9-ff7f-c0ef58de3d21@kernel.dk>
 <2332cba0-efe6-3b35-0587-ee6355a3567d@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dd1f2b01-abe5-4e6f-14cf-c3bef90eb6f9@kernel.dk>
Date:   Thu, 26 Aug 2021 18:05:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2332cba0-efe6-3b35-0587-ee6355a3567d@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/21 6:03 PM, Bart Van Assche wrote:
> On 8/26/21 4:51 PM, Jens Axboe wrote:
>> On 8/26/21 5:49 PM, Bart Van Assche wrote:
>>> On 8/26/21 11:45 AM, Jens Axboe wrote:
>>>> Just ran a quick test here, and I go from 3.55M IOPS to 1.23M switching
>>>> to deadline, of which 37% of the overhead is from dd_dispatch().
>>>>
>>>> With the posted patch applied, it runs at 2.3M IOPS with mq-deadline,
>>>> which is a lot better. This is on my 3970X test box, so 32 cores, 64
>>>> threads.
>>>
>>> Hi Jens,
>>>
>>> With the script below, queue depth >= 2 and an improved version of
>>> Zhen's patch I see 970 K IOPS with the mq-deadline scheduler in an
>>> 8 core VM (i7-4790 CPU). In other words, more IOPS than what Zhen
>>> reported with fewer CPU cores. Is that good enough?
>>
>> That depends, what kind of IOPS are you getting if you revert the
>> original change?
> 
> Hi Jens,
> 
> Here is an overview of the tests I ran so far, all on the same test
> setup:
> * No I/O scheduler:               about 5630 K IOPS.
> * Kernel v5.11 + mq-deadline:     about 1100 K IOPS.
> * block-for-next + mq-deadline:   about  760 K IOPS.
> * block-for-next with improved mq-deadline performance: about 970 K IOPS.

So we're still off by about 12%, I don't think that is good enough.
That's assuming that v5.11 + mq-deadline is the same as for-next with
the mq-deadline change reverted? Because that would be the key number to
compare it with.

-- 
Jens Axboe

