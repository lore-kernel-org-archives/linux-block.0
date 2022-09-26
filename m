Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14F4C07E9D
	for <linux-block@archiver.kernel.org>; Mon, 26 Sep 2022 19:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiIZTZg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiIZTZf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 15:25:35 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5365A146
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 12:25:34 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id g8so6130095iob.0
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 12:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=cq4fym7SbIi4h07NLYvuOL5NDD+3jET2rQK50zxu6ak=;
        b=IP+n8t+aUoAcu90sWT+/PqB1yn61zspacEanO6+pi0dxztNxm2LCZ8mC+IZFpP47tQ
         LP6Xxu1mVvrukfpMvIRRBne1xlE6xJeh07DcGSVuoMe00RIS/Wv1EGibOpYk/QqUpmA3
         b0QNjcCSLARqRmjaaGqxhWzT7aoGl38m2hEpxX5N6CEsA+IhKdrPs8PgsfPj1kFbSyLL
         XVnVTCow30JcJNDGavYGGcmyjfzOnZ4hXhATe7ILZ2QYATukOn+zX4UqlyPMGL93eqWl
         YHplKEvJEasW3o/Nsiew/ZjJVQWdvF8mx3pmzashBgNLCXA74uil0p9FE9YfQuMjmt9R
         IDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cq4fym7SbIi4h07NLYvuOL5NDD+3jET2rQK50zxu6ak=;
        b=8ACniPO0aY0f9qOeq6dcKDjF7jr0NVGGmlBBYNVBxL1iNkyudpswGUPS/LevdBam7N
         /KvbfaL1D79URxzcJp5bWML88zcKIP0ZaxIqMoUQNpKUuzQF3jqehM/NEfQo33vuj61n
         tQoiq+g8v5St1718UglADdp3PI+xY9u7k0rDp/8TtGKjrvIMLeSIaqgcHufXfCNISCkf
         GgGKOFDiBaReoUPJAq1v2AlHYkAzv6q36/TeQSKrvLjo8u69cAnVkSoFDhH/bjhB1u6g
         jnPjtdoqDLHmByVZtB9caiYkFiT1iTAKwnoLVYfex+0TgpHGTCHmQ/2ZL7auax40dumx
         RU0g==
X-Gm-Message-State: ACrzQf2ZtgYBuJkDvYqrkWsZ/NmaZAYLruFvajuQxYIkGHCMC0PFBU9Q
        nHUj7VhghI6/CghJh41CJN5dj9OD0s1OXQ==
X-Google-Smtp-Source: AMsMyM5Px9FmlTzBT3d9NxDl/YhntTCDNhd2Pc8HRaKq41bjNAudfCC9MZfLTj90S3CQWEhCcSTqfw==
X-Received: by 2002:a02:c518:0:b0:35b:2fc4:44f0 with SMTP id s24-20020a02c518000000b0035b2fc444f0mr11288330jam.177.1664220333981;
        Mon, 26 Sep 2022 12:25:33 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y4-20020a056602048400b006a129b10229sm7917952iov.31.2022.09.26.12.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 12:25:33 -0700 (PDT)
Message-ID: <350366c3-1014-ac32-149f-689134631d73@kernel.dk>
Date:   Mon, 26 Sep 2022 13:25:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        gost.dev@samsung.com
References: <20220925185348.120964-1-p.raghav@samsung.com>
 <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
 <20220925185348.120964-2-p.raghav@samsung.com>
 <YzG5RgmWSsH6rX08@infradead.org>
 <d5975b62-f2e9-dcde-e332-a73cca1f7fbf@kernel.dk>
 <YzG6fZdz6XBDbrVB@infradead.org>
 <2ee6a897-87e7-0592-2482-9928a9a63ff6@kernel.dk>
 <a943acf8-f367-a1ba-0d57-2948a3ade6f4@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a943acf8-f367-a1ba-0d57-2948a3ade6f4@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/26/22 1:20 PM, Pankaj Raghav wrote:
> On 2022-09-26 18:32, Jens Axboe wrote:
>> On 9/26/22 8:43 AM, Christoph Hellwig wrote:
>>> On Mon, Sep 26, 2022 at 08:40:54AM -0600, Jens Axboe wrote:
>>>> On 9/26/22 8:37 AM, Christoph Hellwig wrote:
>>>>> On Sun, Sep 25, 2022 at 08:53:46PM +0200, Pankaj Raghav wrote:
>>>>>> Modify blk_mq_plug() to allow plugging only for read operations in zoned
>>>>>> block devices as there are alternative IO paths in the linux block
>>>>>> layer which can end up doing a write via driver private requests in
>>>>>> sequential write zones.
>>>>>
>>>>> We should be able to plug for all operations that are not
>>>>> REQ_OP_ZONE_APPEND just fine.
>>>>
>>>> Agree, I think we just want to make this about someone doing a series
>>>> of appends. If you mix-and-match with passthrough you will have a bad
>>>> time anyway.
>>>
>>> Err, sorry - what I wrote about is compelte garbage.  I initially
>>> wanted to say you can plug for REQ_OP_ZONE_APPEND just fine, and then
>>> realized that we also want various other ones that have the write bit
>>> set batched.  So I suspect we really want to explicitly check for
>>> REQ_OP_WRITE here.
>>
>> My memory was a bit hazy, since we have separate ops for the driver
>> in/out, I think just checking for REQ_OP_WRITE is indeed the right
>> choice. That's the single case we need to care about.
>>
> Ah. You are right. I missed it as well. There is even a comment from
> Christoph:
> 
>  *   - if the least significant bit is set transfers are TO the device
>  *   - if the least significant bit is not set transfers are FROM the device
> 
> I guess the second patch should be enough to apply plugging when
> applicable for uring_cmd based nvme passthrough requests.

Do we even need the 2nd patch? If we're just doing passthrough for the
blk_execute_nowait() API, then the condition should never trigger? If
so, then it would be a cleanup just to ensure we're using a consistent
API for getting the plug, which may be worthwhile to do separately for
sure.

-- 
Jens Axboe
