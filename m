Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BABC433EF
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 16:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B7AD61039
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 16:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhKLQdm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Nov 2021 11:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbhKLQdl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 11:33:41 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BCDC061766
        for <linux-block@vger.kernel.org>; Fri, 12 Nov 2021 08:30:51 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id i11so9474972ilv.13
        for <linux-block@vger.kernel.org>; Fri, 12 Nov 2021 08:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ikk3kQP4s+kTRyqrci+SLfAcVyMajOwV8gVK4UWPECo=;
        b=xD7T1jQepGnvvVdt7gu/CnXbT5Ek1PVSTtj5UpM8+ApmPc7g0/zG+8pmS9Yr4ej8VD
         gWhK0A6JbPJLbZxhinfj2AU6FGruDj1m7ltgZHJE6vjfuKIkKcMALKmireqoY2zUgqUS
         IpWw/8iAvr1KWpI7wHzxGJpnfK+9RdUmULflazPLsAmPiq1GZY/kABxkZ/g25u0Y546Y
         N6xfz+0ZYQrwKCBmUtlSqh+O/dvvc83ysicX4A6GrV2QSqqr0e+z2FyTWEa5K6WDuoxr
         HQsdhMO6nJ0XOQWVXsP7z44CeDp5vNhaNDoZRkmJZUsBr7cwRk5WZQ+wfYuitN7WnKCR
         pAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ikk3kQP4s+kTRyqrci+SLfAcVyMajOwV8gVK4UWPECo=;
        b=c0r7bEMmXnhSlatScRxi8xLlUzgSGZ3riWae+G5tMWpC801ty9tXXRgYgrt9kRsSp1
         wY/emZdlLV72mk6yWeEBOQI9lK1PfytdLuISZ/LDifNE1PXwCCK2K0SkMF9e1yov9iUv
         Ap/RZbE7ox6zepK3FFhUejMXts5X4WorGA4UD487JYX+zYhfheI0XxAxJgtLMVSdVLoL
         bDjk9876W2V9UULF9InIfaEqzhX1DWJtshiLu9clVKKgoHDcYsAHRmvN66Q8bMG7g9Rd
         wIA1z+yP4IGgCcO3ZzL+mR1izQeZicNtvYCgV2m4tabhS50wb7z17NqkT0OGISBl3+tv
         1rRw==
X-Gm-Message-State: AOAM5309VJ8qYXgpqJtNvai3XImUI1JegxDhozY+JcvlzQrZiPIPFIbb
        +BiBaSkDrYVeN46OSY101mBvi2zE3hJYjF5u
X-Google-Smtp-Source: ABdhPJwXXBVk6GfYvbZuip2c3fen5WnWtWq4/J43OvZV+QDhKFqWD2h5G2DPMRcY5h1lkU4M+Q+cTw==
X-Received: by 2002:a05:6e02:1048:: with SMTP id p8mr9452233ilj.174.1636734650353;
        Fri, 12 Nov 2021 08:30:50 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w21sm3670750iov.6.2021.11.12.08.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 08:30:48 -0800 (PST)
Subject: Re: [PATCH] blk-mq: setup blk_mq_alloc_data.cmd_flags after
 submit_bio_checks() is done
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20211112081137.406930-1-ming.lei@redhat.com>
 <20211112082140.GA30681@lst.de> <YY4nv5eQUTOF5Wfv@T590>
 <20211112084441.GA32120@lst.de> <YY5iUwZ2TVtfqfXN@T590>
 <8c04076d-6264-07c2-aa97-948211d5bc7f@kernel.dk> <YY6Qux6ZIIjNyc4b@T590>
 <2b3a62dc-2f7d-0517-eaf5-2b1f60a60c9d@kernel.dk> <YY6ThZtM7oBEunRe@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f5ff729b-d87c-b043-9c05-b50e5354c9eb@kernel.dk>
Date:   Fri, 12 Nov 2021 09:30:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YY6ThZtM7oBEunRe@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/12/21 9:17 AM, Ming Lei wrote:
> On Fri, Nov 12, 2021 at 09:08:39AM -0700, Jens Axboe wrote:
>> On 11/12/21 9:05 AM, Ming Lei wrote:
>>> On Fri, Nov 12, 2021 at 08:47:01AM -0700, Jens Axboe wrote:
>>>> On 11/12/21 5:47 AM, Ming Lei wrote:
>>>>> On Fri, Nov 12, 2021 at 09:44:41AM +0100, Christoph Hellwig wrote:
>>>>>> On Fri, Nov 12, 2021 at 04:37:19PM +0800, Ming Lei wrote:
>>>>>>>> can only be used for reads, and no fua can be set if the preallocating
>>>>>>>> I/O didn't use fua, etc.
>>>>>>>>
>>>>>>>> What are the pitfalls of just chanigng cmd_flags?
>>>>>>>
>>>>>>> Then we need to check cmd_flags carefully, such as hctx->type has to
>>>>>>> be same, flush & passthrough flags has to be same, that said all
>>>>>>> ->cmd_flags used for allocating rqs have to be same with the following
>>>>>>> bio->bi_opf.
>>>>>>>
>>>>>>> In usual cases, I guess all IOs submitted from same plug batch should be
>>>>>>> same type. If not, we can switch to change cmd_flags.
>>>>>>
>>>>>> Jens: is this a limit fitting into your use cases?
>>>>>>
>>>>>> I guess as a quick fix this rejecting different flags is probably the
>>>>>> best we can do for now, but I suspect we'll want to eventually relax
>>>>>> them.
>>>>>
>>>>> rw mixed workload will be affected, so I think we need to switch to
>>>>> change cmd_flags, how about the following patch?
>>>>>
>>>>> From 9ab77b7adee768272944c20b7cffc8abdb85a35b Mon Sep 17 00:00:00 2001
>>>>> From: Ming Lei <ming.lei@redhat.com>
>>>>> Date: Fri, 12 Nov 2021 08:14:38 +0800
>>>>> Subject: [PATCH] blk-mq: fix filesystem I/O request allocation
>>>>>
>>>>> submit_bio_checks() may update bio->bi_opf, so we have to initialize
>>>>> blk_mq_alloc_data.cmd_flags with bio->bi_opf after submit_bio_checks()
>>>>> returns when allocating new request.
>>>>>
>>>>> In case of using cached request, fallback to allocate new request if
>>>>> cached rq isn't compatible with the incoming bio, otherwise change
>>>>> rq->cmd_flags with incoming bio->bi_opf.
>>>>>
>>>>> Fixes: 900e080752025f00 ("block: move queue enter logic into blk_mq_submit_bio()")
>>>>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>> ---
>>>>>  block/blk-mq.c | 39 ++++++++++++++++++++++++++++++---------
>>>>>  block/blk-mq.h | 26 +++++++++++++++-----------
>>>>>  2 files changed, 45 insertions(+), 20 deletions(-)
>>>>>
>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>> index f511db395c7f..3ab34c4f20da 100644
>>>>> --- a/block/blk-mq.c
>>>>> +++ b/block/blk-mq.c
>>>>> @@ -2521,12 +2521,8 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>>>>>  	};
>>>>>  	struct request *rq;
>>>>>  
>>>>> -	if (unlikely(bio_queue_enter(bio)))
>>>>> -		return NULL;
>>>>> -	if (unlikely(!submit_bio_checks(bio)))
>>>>> -		goto put_exit;
>>>>>  	if (blk_mq_attempt_bio_merge(q, bio, nsegs, same_queue_rq))
>>>>> -		goto put_exit;
>>>>> +		return NULL;
>>>>>  
>>>>>  	rq_qos_throttle(q, bio);
>>>>>  
>>>>> @@ -2543,19 +2539,32 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>>>>>  	rq_qos_cleanup(q, bio);
>>>>>  	if (bio->bi_opf & REQ_NOWAIT)
>>>>>  		bio_wouldblock_error(bio);
>>>>> -put_exit:
>>>>> -	blk_queue_exit(q);
>>>>> +
>>>>>  	return NULL;
>>>>>  }
>>>>>  
>>>>> +static inline bool blk_mq_can_use_cached_rq(struct request *rq,
>>>>> +		struct bio *bio)
>>>>> +{
>>>>> +	if (blk_mq_get_hctx_type(bio->bi_opf) != rq->mq_hctx->type)
>>>>> +		return false;
>>>>> +
>>>>> +	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
>>>>> +		return false;
>>>>> +
>>>>> +	return true;
>>>>
>>>> I think we should just check if hctx is the same, that should be enough.
>>>> We don't need to match the type, just disallow if hw queue has changed.
>>>
>>> But bio doesn't have hw queue. Figuring out exact hw queue seems
>>> necessary and needs more cpu cycles than getting hctx type.
>>
>> Thinking about it, if opf and request_queue matches, that should be
>> enough.
> 
> I think that is same with hctx->type check: POLLED & OP needs to be
> same between the request and bio, and op_is_flush(), or could you
> explain how to run the exact check on opf?

I took a look at it, and I think your approach of checking the type is
indeed the best one.

-- 
Jens Axboe

