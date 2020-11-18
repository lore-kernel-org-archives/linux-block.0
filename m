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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DCFC5519F
	for <linux-block@archiver.kernel.org>; Wed, 18 Nov 2020 09:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F22520857
	for <linux-block@archiver.kernel.org>; Wed, 18 Nov 2020 09:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxN1Alz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgKRJ3U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Nov 2020 04:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKRJ3T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Nov 2020 04:29:19 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84140C0613D4
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2020 01:29:19 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so1436901wrc.8
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2020 01:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sFIPhMdfZBs6iaxUsM4VSpvgzkIrkP0HDv5XIkh7Gho=;
        b=bxN1Alz5+ImXmb+soZvJSCmL+j+IKQVlZFofa7sveKbEd/FALI4DhWx7clZzUqJpOB
         CESVUFM0OcKNpLrtZx7ASOOXKI/lAGINW2/d8ltfvaMCJHFAEeij/oqmspsIfRl/GxPA
         WkefHU9f/qmbUxirSr7n1CU+kB7fVwVMgCzoqloag2rBkBTw1IQXdiqJnJMsUNUZlO5m
         5Rxrbf/qCV/TkzxmTylEIciwkv/0Tzl5ig+YjC00tquqADyiIVk7bJCvv1/RYo/JWYhx
         xL6NPc/prRZfXqk4J4pmhDmcK88ey+Eoq8r2sTvxOsSptkJyZM5hHud4VzFs367dNLCX
         93Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sFIPhMdfZBs6iaxUsM4VSpvgzkIrkP0HDv5XIkh7Gho=;
        b=qkptLBKngY54zwLv6R0HuYcJXKaUoSNmNE5d8CIrEUuWzr1IgeE+HLDueFIrqDV0wN
         aucO8zfl7lwH7VvFpFT1n2AO2V0siZT9pqt2tdacNafOmpfIsr1UyzN2QJ7oEwLSlzb/
         AXy4+Ib++JeT1jdl44JLsKOA40beUQGrLuBHAIMt9Q/LvE6kfyq7mFHU4rZAjOUtfxYg
         wKg38/+NN7/qGCuAHgVOHHvId6BT6I+3NvnkippUtz0z6x15TXkYnVnTd2Rgj6CTSUTC
         aeNo/1kgCJga7vuLhlhgDkjMzRtyBJ63WH5EWMIke3ZMjvPxNTYhweGdJqCND1X9WHpJ
         35xQ==
X-Gm-Message-State: AOAM533We6t2kKOLM9z4rrQPEooVjJU6awKVjw7TSs0hwpZKsU0tgh6U
        f8MFxZ669yRXrrZCcJQVvy8=
X-Google-Smtp-Source: ABdhPJyrMcig5D1yTeFtYo4ZYTNeWwYrH3wAER7mmHOdOIqfQNjRKxaw649WfwdvQdxV74L/uX5UrQ==
X-Received: by 2002:adf:f08a:: with SMTP id n10mr3850266wro.260.1605691758281;
        Wed, 18 Nov 2020 01:29:18 -0800 (PST)
Received: from [192.168.1.58] (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id 30sm25347558wrd.88.2020.11.18.01.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 01:29:17 -0800 (PST)
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Dongjoo Seo <commisori28@gmail.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbates@raithlin.com" <sbates@raithlin.com>
References: <20201118004746.GA29180@dongjoo-desktop>
 <20201118070714.GA3786@infradead.org>
 <BL0PR04MB65144A3EE2C24C430347AEBCE7E10@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] blk-mq: modify hybrid sleep time to aggressive
Message-ID: <310b9d38-1dde-b74e-f68f-32e8c7148336@gmail.com>
Date:   Wed, 18 Nov 2020 09:26:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <BL0PR04MB65144A3EE2C24C430347AEBCE7E10@BL0PR04MB6514.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/11/2020 07:16, Damien Le Moal wrote:
> On 2020/11/18 16:07, Christoph Hellwig wrote:
>> Adding Damien who wrote this code.
> 
> Nope. It wasn't me. I think it was Stephen Bates:
> 
> commit 720b8ccc4500 ("blk-mq: Add a polling specific stats function")
> 
> So +Stephen.
>>
>> On Wed, Nov 18, 2020 at 09:47:46AM +0900, Dongjoo Seo wrote:
>>> Current sleep time for hybrid polling is half of mean time.
>>> The 'half' sleep time is good for minimizing the cpu utilization.
>>> But, the problem is that its cpu utilization is still high.
>>> this patch can help to minimize the cpu utilization side.

This won't work well. When I was experimenting I saw that half mean
is actually is too much for fast enough requests, like <20us 4K writes,
it's oversleeping them. Even more I'm afraid of getting in a vicious
cycle, when oversleeping increases statistical mean, that increases
sleep time, that again increases stat mean, and so on. That what
happened for me when the scheme was too aggressive.

I actually sent once patches [1] for automatic dynamic sleep time
adjustment, but nobody cared.

[1] https://lkml.org/lkml/2019/4/30/117

>>>
>>> Below 1,2 is my test hardware sets.
>>>
>>> 1. Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz + Samsung 970 pro 1Tb
>>> 2. Intel(R) Core(TM) i7-5820K CPU @ 3.30GHz + INTEL SSDPED1D480GA 480G
>>>
>>>         |  Classic Polling | Hybrid Polling  | this Patch
>>> -----------------------------------------------------------------
>>>         cpu util | IOPS(k) | cpu util | IOPS | cpu util | IOPS  |
>>> -----------------------------------------------------------------
>>> 1.       99.96   |   491   |  56.98   | 467  | 35.98    | 442   |
>>> -----------------------------------------------------------------
>>> 2.       99.94   |   582   |  56.3    | 582  | 35.28    | 582   |
>>>
>>> cpu util means that sum of sys and user util.
>>>
>>> I used 4k rand read for this test.
>>> because that case is worst case of I/O performance side.
>>> below one is my fio setup.
>>>
>>> name=pollTest
>>> ioengine=pvsync2
>>> hipri
>>> direct=1
>>> size=100%
>>> randrepeat=0
>>> time_based
>>> ramp_time=0
>>> norandommap
>>> refill_buffers
>>> log_avg_msec=1000
>>> log_max_value=1
>>> group_reporting
>>> filename=/dev/nvme0n1
>>> [rd_rnd_qd_1_4k_1w]
>>> bs=4k
>>> iodepth=32
>>> numjobs=[num of cpus]
>>> rw=randread
>>> runtime=60
>>> write_bw_log=bw_rd_rnd_qd_1_4k_1w
>>> write_iops_log=iops_rd_rnd_qd_1_4k_1w
>>> write_lat_log=lat_rd_rnd_qd_1_4k_1w
>>>
>>> Thanks
>>>
>>> Signed-off-by: Dongjoo Seo <commisori28@gmail.com>
>>> ---
>>>  block/blk-mq.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 1b25ec2fe9be..c3d578416899 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -3749,8 +3749,7 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
>>>  		return ret;
>>>  
>>>  	if (q->poll_stat[bucket].nr_samples)
>>> -		ret = (q->poll_stat[bucket].mean + 1) / 2;
>>> -
>>> +		ret = (q->poll_stat[bucket].mean + 1) * 3 / 4;
>>>  	return ret;
>>>  }
>>>  
>>> -- 
>>> 2.17.1
>>>
>> ---end quoted text---
>>
> 
> 

-- 
Pavel Begunkov
