Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF27C35295
	for <linux-block@archiver.kernel.org>; Wed, 15 Dec 2021 16:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244103AbhLOPrd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Dec 2021 10:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244121AbhLOPrd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Dec 2021 10:47:33 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C15C06173E
        for <linux-block@vger.kernel.org>; Wed, 15 Dec 2021 07:47:33 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q72so30819172iod.12
        for <linux-block@vger.kernel.org>; Wed, 15 Dec 2021 07:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Iu6lyOnaMTy7MemYvvi3Bxaw7AqLa3colqgUgMHXSmo=;
        b=VVcbjaBzvpEIbuIuHMMB8CxL39tmqtHZ5y1sCmA7AM8u79bXB8OKC5U0YSHSIa/5Zf
         F7BwTwWnSspgzJOr7K/x8HMpiHc4Y2ixwMDpyVH7hfCmg1chcjrmMfeaWjNUr7CwjqHl
         8nPizXmAC0uXsrfZijiDltTjhPWmsOyJlMCYfErkwSi5USvvpJJoyV6jDRbRNNo9aRTO
         c3zPgD94v/phyzb8h9VOskNpVV2n6eFebOnk8XncHFKTv2xM7J1T6hBcyu3pY0GjdkLi
         qmK1kahP5OXGHevWfLuEaW/ZHleVa2HkUtbZvDyys16ELxBMxzMruuh/dElkDQQhFX0d
         3jEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iu6lyOnaMTy7MemYvvi3Bxaw7AqLa3colqgUgMHXSmo=;
        b=j2YU//5nYSRbiIZhe7j1zuhY72ypJrbMMxHrEFZeS1BSdeKmXJ3algbDQg/QwLf/SD
         9kM8D/ZYG0OvaXnVmjE2l3oHRXL9LGlqtXsb8eE2fZX2Z4/5PCsX3L7BF+hEUCGPCef/
         mf2x9MjmPvJh3tA5GGzuOjYVHNKT0htUC89mP5YgydbsdO6mJ+03rR2fpl8G0AlsIQoV
         4WSbI+xdaDa7yoUea+dVRdQIi/6bV/btPsFMkRq9X0wyfcw38RpdQzBNHQX9RCf7GATU
         aI7rIt0nabdEtSFyCzIei61O3BvOoLUopi6VKPL4JDMrPveE0ZY4BJt9lCPWHIrbq0M5
         0oqw==
X-Gm-Message-State: AOAM532Hm/D00+CLbo0hMR1G6QTXHTqAZvTnwXvztXVzfIwAGJ7yz553
        yu9VvY77YIe3B8n/3rA1AatNxmKF3Oyquw==
X-Google-Smtp-Source: ABdhPJxEkda4a+fRD6FqC3vWZV6kZBEINTn2orzVqaojlzMVtuz0RUCT/4EzU417l/ru2vZEEA1Vsw==
X-Received: by 2002:a05:6638:168a:: with SMTP id f10mr6183956jat.279.1639583252426;
        Wed, 15 Dec 2021 07:47:32 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t6sm1155790ios.13.2021.12.15.07.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 07:47:31 -0800 (PST)
Subject: Re: [PATCH v2] block: reduce kblockd_mod_delayed_work_on() CPU
 consumption
To:     John Garry <john.garry@huawei.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>, Ming Lei <ming.lei@redhat.com>
References: <0eb94fa3-a1d0-f9b3-fb51-c22eaad225a7@kernel.dk>
 <926c2348-23a1-5b32-1369-3deb3d6d1671@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c283fb12-30f5-93bd-06fc-f65c547cc94f@kernel.dk>
Date:   Wed, 15 Dec 2021 08:47:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <926c2348-23a1-5b32-1369-3deb3d6d1671@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/15/21 3:25 AM, John Garry wrote:
> On 14/12/2021 20:49, Jens Axboe wrote:
>> Dexuan reports that he's seeing spikes of very heavy CPU utilization when
>> running 24 disks and using the 'none' scheduler. This happens off the
>> sched restart path, because SCSI requires the queue to be restarted async,
>> and hence we're hammering on mod_delayed_work_on() to ensure that the work
>> item gets run appropriately.
>>
>> Avoid hammering on the timer and just use queue_work_on() if no delay
>> has been specified.
>>
>> Reported-and-tested-by: Dexuan Cui <decui@microsoft.com>
>> Link: https://lore.kernel.org/linux-block/BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com/
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 1378d084c770..c1833f95cb97 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1484,6 +1484,8 @@ EXPORT_SYMBOL(kblockd_schedule_work);
>>   int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
>>   				unsigned long delay)
>>   {
>> +	if (!delay)
>> +		return queue_work_on(cpu, kblockd_workqueue, &dwork->work);
>>   	return mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
>>   }
>>   EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
>>
> 
> Hi Jens,
> 
> I have a related comment on the current code and interface it uses, if 
> you don't mind, as I did wonder if we are doing a msec_to_jiffies(0 [not 
> built-in const]) call somewhere.
> 
> So we pass msecs to blk-mq.c, and we do a msec_to_jiffies() call on it 
> before calling kblockd_mod_delayed_work_on(). Now most/all callsites 
> uses const value for the msec value, so if we did the msec_to_jiffies() 
> conversion at the callsites and passed a jiffies value, it should be 
> compiled out by gcc. This is my current __blk_mq_delay_run_hw_queue 
> assembler:
> 
> 0000000000001ef0 <__blk_mq_delay_run_hw_queue>:
>      [snip]
>      2024: a942dfb6 ldp x22, x23, [x29, #40]
>      2028: 2a1503e0 mov w0, w21
>      202c: 94000000 bl 0 <__msecs_to_jiffies>
> kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
>      2030: aa0003e2 mov x2, x0
>      2034: 91010261 add x1, x19, #0x40
>      2038: 2a1403e0 mov w0, w20
>      203c: 94000000 bl 0 <kblockd_mod_delayed_work_on>
> 
> I'm not sure if you would want to change so many APIs or if jiffies is 
> sensible to pass or even any performance gain. Additionally Function 
> blk_mq_delay_kick_requeue_list() would not see so much gain in such a 
> change as msec value is not const. Any thoughts? Maybe testing 
> performance would not do much harm.

In general I totally agree with you, it'd be smarter to flip the
conversion so it can be done in a more efficient manner. At the same
time, the queue delay running is not at all a fast path, so shouldn't
really matter in practice.

-- 
Jens Axboe

