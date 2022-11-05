Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47318C4332F
	for <linux-block@archiver.kernel.org>; Sat,  5 Nov 2022 15:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKEPYU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Nov 2022 11:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKEPYU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Nov 2022 11:24:20 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACDD2251B
        for <linux-block@vger.kernel.org>; Sat,  5 Nov 2022 08:24:18 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k15so6961340pfg.2
        for <linux-block@vger.kernel.org>; Sat, 05 Nov 2022 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbqLaDRY9lB0RqlIRDjQwgDbcivP/PoNNM2aaTEHjXU=;
        b=nCfoTjYYvB/3kSZXPXqxsgJiAER19P7K8BnLEtj1l4+NSKwrv+8S+RD0G2u3NEAKYg
         i3QTCeK7OeWUKthGVotbySP5ugZwcsdD0Keq87zubeBPSuuQ2s4xMbYiF4eNKos398Kz
         Umftyz2ZUvC8kkZVaHC9xCzl++yY1xVAbeEJCIX1wRyKZfRDmYSCWTk4kJdX8WiAHh2s
         xbN7qV+39zlyb1M8NlxGimVfvdv53GT/mobsAIhhUFlGr4sDaYpXNhOn5kog2uCVyhn5
         8Ly4CgfpXczHG2H9YLmFX21WPrSQRjWan7XGl8VUwaMZhKmtvTVO9Md4L2H3lzCqErMd
         5bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbqLaDRY9lB0RqlIRDjQwgDbcivP/PoNNM2aaTEHjXU=;
        b=1D/SrB6tFoZvcjiqabSwmBQ7pyTF96clf2r0OmQFSU1IkefQsK2pfVh4BAK4tylwbP
         mAfgSmIYuhNMgvVUrE7/VpdJZTil+5qjqlJqRypz4w9hhJTCtFAL3fZbiDRdumoffCvb
         IhEz84uFcznbyToXVZlo9a5sRpcPNL+hWZj9LbUklQ8Cr9uLyKUji1W7xmdqojGotKoJ
         3hBDnKwSwIilhowcV+jzqumvHn20mE1CSoRqdo0ESPbBgM92ry99YJDLOuw2dxhP5Itl
         LdhbCvxjPg8d4gRltogHlprKEBV8ePwKvSsx+OJrHo7yHI/uCPtAQ3vEUA2DmO3WCTQm
         LTYg==
X-Gm-Message-State: ANoB5plXrwqJgxsl95gSArFosIJfMlZ5dNimtVDy3GJ6HcON0/R4Piw1
        wtSTdu+wODvVR/xV+aLgdXPilw==
X-Google-Smtp-Source: AA0mqf7fetKUjZM6UZKMxnLH24AhZcmEbWo08on1brRbSrrVkMDR9qwoTXOAInyZrU8s6kV3Uw/cGw==
X-Received: by 2002:a05:6a00:168b:b0:56e:d7f4:3aaf with SMTP id k11-20020a056a00168b00b0056ed7f43aafmr1568199pfc.81.1667661858394;
        Sat, 05 Nov 2022 08:24:18 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090a450f00b00212c27abcaesm3294412pjg.17.2022.11.05.08.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 08:24:17 -0700 (PDT)
Message-ID: <4299f618-af81-84e6-8815-f921a704696b@kernel.dk>
Date:   Sat, 5 Nov 2022 09:24:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
Content-Language: en-US
To:     Vincent Fu <vincent.fu@samsung.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20221006050514.5564-1-kch@nvidia.com>
 <CGME20221027200756uscas1p206196106ee2224a7653f1f2bc7ba31e9@uscas1p2.samsung.com>
 <20221027200654.147600-1-vincent.fu@samsung.com>
 <6270de4e-9f4a-fcfc-c4f1-d0ede32352bb@nvidia.com>
 <20221104185124.181754-1-vincent.fu@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221104185124.181754-1-vincent.fu@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/22 12:52 PM, Vincent Fu wrote:
> On Wed, Nov 02, 2022 at 12:52:06AM +0000, Chaitanya Kulkarni wrote:
>> On 10/27/22 13:07, Vincent Fu wrote:
>>> On Wed, Oct 05, 2022 at 10:05:13PM -0700, Chaitanya Kulkarni wrote:
>>>> For a Zoned Block Device zone reset all is emulated if underlaying
>>>> device doesn't support REQ_OP_ZONE_RESET_ALL operation. In null_blk
>>>> Zoned mode there is no way to test zone reset all emulation present in
>>>> the block layer since we enable it by default :-
>>>>
>>>> blkdev_zone_mgmt()
>>>> blkdev_zone_reset_all_emulation() <---
>>>> blkdev_zone_reset_all()
>>>>
>>>> Add a module parameter zone_reset_all to enable or disable
>>>> REQ_OP_ZONE_RESET_ALL, enable it by default to retain the existing
>>>> behaviour.
>>>>
>>>> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>>>
>>> For the sake of completeness would it be reasonable to also provide a
>>> means to set this option via configfs?
>>>
>>> Vincent
>>
>> I deliberately avoided that as I don't see any need for it as of now.
>> but if it is a hard requirement I Can certainly send V2 with configfs
>> param.
>>
>> -ck
> 
> I think the default should be to have features available as both module
> options and via configfs unless there are good reasons to make an
> exception.
> 
> https://lore.kernel.org/linux-block/f0dadb60-c02d-d569-3004-81eafeebb95f@kernel.dk/
> https://lore.kernel.org/linux-block/ca206223-112f-2d60-34a3-bb7e6295de7a@kernel.dk/

Yes agree, work was done to bring those closer, would be silly to add
something new and NOT have both available.

-- 
Jens Axboe


