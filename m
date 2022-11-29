Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BFAC4321E
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 14:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiK2Odc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 09:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiK2OdS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 09:33:18 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446E21C43C
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 06:33:17 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id h33so8205501pgm.9
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 06:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/jN8CDNxrDZag/wbLCJVmkiAlc7PInMojWyMS5FvR0=;
        b=rG+mjOKGZIuhcRRFhzc7kHJmTKJjWNlvt7Nt28EVz0Kxsk9y61xwE/KEbNqx+V/42i
         airBHJapeb49fJ0pSNFqO5BhkAv/aUPJaqsg9KOcKCbTJUX1CEucmPQ5nYIfifb4F5uA
         WX2SJOx8neXgabEli9IZyy+73GBbBStkog9NsKYn+o42JjxY5wJSAqSKt4/eOLb1YQM4
         PHpH+iKL5ejjDl2zl3WDMhewbfDY2m0HxyL/pk/LraH0vcvmN4DQt61aqx0RvRgTFG/2
         dwuy2LUy+JGTsuvA8kHbUPpPhp3ikthbKKrOZfYRE05J48UDQZZxlk4Lf4FaVD43L/Zj
         5kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/jN8CDNxrDZag/wbLCJVmkiAlc7PInMojWyMS5FvR0=;
        b=2pO008doYr20EQYyuXeCv0+OWEp32pXrD11k5qXpgwwqcDOFfp39lcXn24DXKkRTc6
         YPaXYNmJwIxqROuMUK6uUQJ6fFTE2n3/4nQx7ODDgEwAm8r8HrJGMCZ/5pd/+Qem5WKa
         PI+6p1/4CpvuY/xo75F1EGTV6A7aaBLaGP3yGBVc9Hs7QVgJ55tjdfk+exhlEfiNZdCF
         XWyAzpRLd9Vu68obWjFv4/gQEpEZ5xjO13i4fio4MwrSV/je80sIIomLMoNs5Yl2YJK1
         PmpEwBExNg1QXKOR0j1qj/gYjgchFi6ekCeA9FESU+nj5B5QzOSqSSEzc+76hyJpAHCZ
         IUIg==
X-Gm-Message-State: ANoB5pkPQ5Q2+UvkOtrS7ZDIc62U3CGnAuUSvjTLkYpieYvH7Q2bHO/b
        RyucXol3G4sgTCCKr4SobGiRZ/tSlfvomHet
X-Google-Smtp-Source: AA0mqf4NCD+CMqaRNtBqT0OTyODhHhUsIusitSWW7R/Q/B4WQ7RqxGE2SqQGEO5BH4L0xJBLMVHbng==
X-Received: by 2002:a63:2154:0:b0:477:b650:494b with SMTP id s20-20020a632154000000b00477b650494bmr29063622pgm.434.1669732396674;
        Tue, 29 Nov 2022 06:33:16 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d10-20020a17090abf8a00b00212e5068e17sm1431643pjs.40.2022.11.29.06.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:33:16 -0800 (PST)
Message-ID: <ac488153-9a3c-1758-e596-e6c7928e984e@kernel.dk>
Date:   Tue, 29 Nov 2022 07:33:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] nvme: support io stats on the mpath device
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221003094344.242593-3-sagi@grimberg.me>
 <9db5d7eb-bd84-85e6-c30a-da057f1b2b69@suse.de>
 <0733f642-8b97-b6ce-8a0e-14c3bb8e2a9a@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0733f642-8b97-b6ce-8a0e-14c3bb8e2a9a@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/4/22 2:19 AM, Sagi Grimberg wrote:
> 
> 
> On 10/4/22 09:11, Hannes Reinecke wrote:
>> On 10/3/22 11:43, Sagi Grimberg wrote:
>>> Our mpath stack device is just a shim that selects a bottom namespace
>>> and submits the bio to it without any fancy splitting. This also means
>>> that we don't clone the bio or have any context to the bio beyond
>>> submission. However it really sucks that we don't see the mpath device
>>> io stats.
>>>
>>> Given that the mpath device can't do that without adding some context
>>> to it, we let the bottom device do it on its behalf (somewhat similar
>>> to the approach taken in nvme_trace_bio_complete).
>>>
>>> When the IO starts, we account the request for multipath IO stats using
>>> REQ_NVME_MPATH_IO_STATS nvme_request flag to avoid queue io stats disable
>>> in the middle of the request.
>>>
>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>> ---
>>>   drivers/nvme/host/core.c      |  4 ++++
>>>   drivers/nvme/host/multipath.c | 25 +++++++++++++++++++++++++
>>>   drivers/nvme/host/nvme.h      | 12 ++++++++++++
>>>   3 files changed, 41 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 64fd772de817..d5a54ddf73f2 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -384,6 +384,8 @@ static inline void nvme_end_req(struct request *req)
>>>           nvme_log_error(req);
>>>       nvme_end_req_zoned(req);
>>>       nvme_trace_bio_complete(req);
>>> +    if (req->cmd_flags & REQ_NVME_MPATH)
>>> +        nvme_mpath_end_request(req);
>>>       blk_mq_end_request(req, status);
>>>   }
>>> @@ -421,6 +423,8 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
>>>   void nvme_start_request(struct request *rq)
>>>   {
>>> +    if (rq->cmd_flags & REQ_NVME_MPATH)
>>> +        nvme_mpath_start_request(rq);
>>>       blk_mq_start_request(rq);
>>>   }
>>>   EXPORT_SYMBOL_GPL(nvme_start_request);
>>
>> Why don't you move the check for REQ_NVME_MPATH into nvme_mpath_{start,end}_request?
> 
> I'm less fond of calling a function that may or may not
> do anything...
> 
> But it is a pattern that exists in the code, if people prefer
> it I can change it.

I prefer it the way that you have it, avoids a function call for
the hot path of not being multipath.

-- 
Jens Axboe


