Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CD3C8300B
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 17:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4148F246AD
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 17:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTQeer8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgKSRy1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 12:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbgKSRyL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 12:54:11 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0C1C0613CF
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2020 09:54:11 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id a15so6781752edy.1
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2020 09:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GcQOW7G+k3VI5JIgZ7gdoipPz1jWk98cca0kNfxzJsA=;
        b=UTQeer8v6PlKLa4ylTP/E/X+5oObQQn0/IXQzmLz+CPdGTLSr33B4WJhJD52FTvjEv
         ckbdgC9JYMSramPYsS8sTkSV+7s1ngabOeACiS0QXwo2JCcn75xdne5DqoYqySB+NACK
         TFHpYnZAt7Y6DunaUvVuTHRXkJsJLCievaKon+8Ti//vUy2gURUEBMq28GqoYpfO/44b
         1H5w75AWNvntfzqmLSkOxrl9+58eJKDhAvDcibgx/Dq5SjJymtPhcgST47pPlGMs63hb
         U7F6mSU5oaeGByWWP+LAOVm8lD5GTXCjTsQc/+ETA9Gd0aprND+CmuarksE5FE43tuSH
         23bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GcQOW7G+k3VI5JIgZ7gdoipPz1jWk98cca0kNfxzJsA=;
        b=mfNOD631c4FldASkvDpwZ/sn/wANH7T3BaiX7NnI1RYPoBjeeUma2vcmbh9qGFwya2
         E7XAmtq0hqKxpEQHXgwjkHLCp7+8VnaoyN/aT6RhVRzf6xv3RYgS6PHoVAZ7FGCC02Su
         1+ATKrNIyS8H82//w8MNfWhEs9dmUX48g6bAwS/aBi9baZGih25Ks0Qm0Wov6mZsnwzl
         /ASbd7Cb2S7GCXWcJvc4h6UIYViU+4RDIY0NwSsQrNgUMBsJpz8ZdYD/P90j7bkzcDok
         Lv6PFZGr2BFZlTr2G+574jvjh9JrSCR5jcS8djDyZbVLl7LuOZft/qymGusGx7LKmh8c
         8yQA==
X-Gm-Message-State: AOAM531M5hutteW9IU/OKTx0gwTKNskQ/BZ0Sr4YSJaJhHYr0JYM1iTE
        DtrpS3nm45lQpE+6G/5DFqW6ugH4Vq5wOQ==
X-Google-Smtp-Source: ABdhPJwMgoA5GkZxOquim+7SqZVUxi/MaC5EVIlslG37p1f2CmhIi9cMyHqr7YLSmddSWlLaBQmzZg==
X-Received: by 2002:a50:ed14:: with SMTP id j20mr32384000eds.247.1605808449700;
        Thu, 19 Nov 2020 09:54:09 -0800 (PST)
Received: from [192.168.1.23] (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id k1sm177656ejr.53.2020.11.19.09.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 09:54:09 -0800 (PST)
To:     dongjoo seo <commisori28@gmail.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbates@raithlin.com" <sbates@raithlin.com>
References: <20201118004746.GA29180@dongjoo-desktop>
 <20201118070714.GA3786@infradead.org>
 <BL0PR04MB65144A3EE2C24C430347AEBCE7E10@BL0PR04MB6514.namprd04.prod.outlook.com>
 <310b9d38-1dde-b74e-f68f-32e8c7148336@gmail.com>
 <7F6FFFCB-3FD1-4A7B-8D30-FF4BBAD4AEA4@gmail.com>
 <dd1fa6ef-0730-37d6-d3a8-50a3b98e2e6a@gmail.com>
 <CABM9hu3FE6ZZL=oWznbJUw2i9i8qJ1AYKotg_uEeAe1Vu+8Ong@mail.gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] blk-mq: modify hybrid sleep time to aggressive
Message-ID: <e0e34258-4467-441c-a9c8-c8b73483344a@gmail.com>
Date:   Thu, 19 Nov 2020 17:51:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CABM9hu3FE6ZZL=oWznbJUw2i9i8qJ1AYKotg_uEeAe1Vu+8Ong@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/11/2020 15:12, dongjoo seo wrote:
> Actually I worked with a many-core machine with an NVMe devices.
> It have 120~192 cpu core and lots of memory and disk device.
> For that, I checked the scalability of block layer and NVMe device driver.

I'm rather mean not test setups but production servers or large
sets of user actually using it.

AFAIK "normal users" like laptops and so on don't even use iopoll,
that's too wasteful. Maybe someone here can correct me.

> During that process, I found the polling methodologies like io_uring, SPDK.

Just to notice, io_uring is not iopoll centric, and internally it
goes through similar code path as HIPRI reads/writes, i.e. using
mentioned NVMe driver polling.

> But, for applying that engines, we need to modify the application's code.
> Thats why I and we interest in the polling in NVMe device driver.
> 
> And, you are right, normal user can not recognize that
> difference btw previous one and polling based approach.
> However, I believe that ultra low-latency dissemination will make this
> active.

Ultra low-latency devices make hybrid polling not as useful as
before because a) it's harder to get right statistics with all
discrepancies in the host system, b) tighter gaps makes relative
overhead on that sleep higher + easier to oversleep.

> 
> Anyway, Thank you for your opinion.
> 
> 2020년 11월 18일 (수) 오후 11:20, Pavel Begunkov <asml.silence@gmail.com>님이 작성:
> 
>> On 18/11/2020 10:35, dongjoo seo wrote:
>>> I agree with your opinion. And your patch is also good approach.
>>> How about combine it? Adaptive solution with 3/4.
>>
>> I couldn't disclose numbers back then, but thanks to a steep skewed
>> latency distribution of NAND/SSDs, it actually was automatically
>> adjusting it to ~3/4 for QD1 and long enough requests (~75+ us).
>> Also, if "max(sleep_ns, half_mean)" is removed, it was keeping the
>> time below 1/2 for fast requests (less than ~30us), and that is a
>> good thing because it was constantly oversleeping them.
>> Though new ultra low-latency SSDs came since then.
>>
>> The real problem is to find anyone who actually uses it, otherwise
>> it's just a chunk of dead code. Do you? Anyone? I remember once it
>> was completely broken for months, but that was barely noticed.
>>
>>
>>> Because, if we get the intensive workloads then we need to
>>> decrease the whole cpu utilization even with [1].
>>>
>>> [1] https://lkml.org/lkml/2019/4/30/117 <
>> https://lkml.org/lkml/2019/4/30/117>
>>>
>>>> On Nov 18, 2020, at 6:26 PM, Pavel Begunkov <asml.silence@gmail.com>
>> wrote:
>>>>
>>>> On 18/11/2020 07:16, Damien Le Moal wrote:
>>>>> On 2020/11/18 16:07, Christoph Hellwig wrote:
>>>>>> Adding Damien who wrote this code.
>>>>>
>>>>> Nope. It wasn't me. I think it was Stephen Bates:
>>>>>
>>>>> commit 720b8ccc4500 ("blk-mq: Add a polling specific stats function")
>>>>>
>>>>> So +Stephen.
>>>>>>
>>>>>> On Wed, Nov 18, 2020 at 09:47:46AM +0900, Dongjoo Seo wrote:
>>>>>>> Current sleep time for hybrid polling is half of mean time.
>>>>>>> The 'half' sleep time is good for minimizing the cpu utilization.
>>>>>>> But, the problem is that its cpu utilization is still high.
>>>>>>> this patch can help to minimize the cpu utilization side.
>>>>
>>>> This won't work well. When I was experimenting I saw that half mean
>>>> is actually is too much for fast enough requests, like <20us 4K writes,
>>>> it's oversleeping them. Even more I'm afraid of getting in a vicious
>>>> cycle, when oversleeping increases statistical mean, that increases
>>>> sleep time, that again increases stat mean, and so on. That what
>>>> happened for me when the scheme was too aggressive.
>>>>
>>>> I actually sent once patches [1] for automatic dynamic sleep time
>>>> adjustment, but nobody cared.
>>>>
>>>> [1] https://lkml.org/lkml/2019/4/30/117 <
>> https://lkml.org/lkml/2019/4/30/117>
>>>>
>>>>>>>
>>>>>>> Below 1,2 is my test hardware sets.
>>>>>>>
>>>>>>> 1. Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz + Samsung 970 pro 1Tb
>>>>>>> 2. Intel(R) Core(TM) i7-5820K CPU @ 3.30GHz + INTEL SSDPED1D480GA
>> 480G
>>>>>>>
>>>>>>>        |  Classic Polling | Hybrid Polling  | this Patch
>>>>>>> -----------------------------------------------------------------
>>>>>>>        cpu util | IOPS(k) | cpu util | IOPS | cpu util | IOPS  |
>>>>>>> -----------------------------------------------------------------
>>>>>>> 1.       99.96   |   491   |  56.98   | 467  | 35.98    | 442   |
>>>>>>> -----------------------------------------------------------------
>>>>>>> 2.       99.94   |   582   |  56.3    | 582  | 35.28    | 582   |
>>>>>>>
>>>>>>> cpu util means that sum of sys and user util.
>>>>>>>
>>>>>>> I used 4k rand read for this test.
>>>>>>> because that case is worst case of I/O performance side.
>>>>>>> below one is my fio setup.
>>>>>>>
>>>>>>> name=pollTest
>>>>>>> ioengine=pvsync2
>>>>>>> hipri
>>>>>>> direct=1
>>>>>>> size=100%
>>>>>>> randrepeat=0
>>>>>>> time_based
>>>>>>> ramp_time=0
>>>>>>> norandommap
>>>>>>> refill_buffers
>>>>>>> log_avg_msec=1000
>>>>>>> log_max_value=1
>>>>>>> group_reporting
>>>>>>> filename=/dev/nvme0n1
>>>>>>> [rd_rnd_qd_1_4k_1w]
>>>>>>> bs=4k
>>>>>>> iodepth=32
>>>>>>> numjobs=[num of cpus]
>>>>>>> rw=randread
>>>>>>> runtime=60
>>>>>>> write_bw_log=bw_rd_rnd_qd_1_4k_1w
>>>>>>> write_iops_log=iops_rd_rnd_qd_1_4k_1w
>>>>>>> write_lat_log=lat_rd_rnd_qd_1_4k_1w
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>> Signed-off-by: Dongjoo Seo <commisori28@gmail.com>
>>>>>>> ---
>>>>>>> block/blk-mq.c | 3 +--
>>>>>>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>>>> index 1b25ec2fe9be..c3d578416899 100644
>>>>>>> --- a/block/blk-mq.c
>>>>>>> +++ b/block/blk-mq.c
>>>>>>> @@ -3749,8 +3749,7 @@ static unsigned long blk_mq_poll_nsecs(struct
>> request_queue *q,
>>>>>>>           return ret;
>>>>>>>
>>>>>>>   if (q->poll_stat[bucket].nr_samples)
>>>>>>> -         ret = (q->poll_stat[bucket].mean + 1) / 2;
>>>>>>> -
>>>>>>> +         ret = (q->poll_stat[bucket].mean + 1) * 3 / 4;
>>>>>>>   return ret;
>>>>>>> }
>>>>>>>
>>>>>>> --
>>>>>>> 2.17.1
>>>>>>>
>>>>>> ---end quoted text---
>>>>>>
>>>>>
>>>>>
>>>>
>>>> --
>>>> Pavel Begunkov
>>>
>>>
>>
>> --
>> Pavel Begunkov
>>
> 

-- 
Pavel Begunkov
