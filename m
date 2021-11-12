Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09058C433F5
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 16:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70BF60F5B
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 16:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhKLQLd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Nov 2021 11:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbhKLQLc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 11:11:32 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E188C061766
        for <linux-block@vger.kernel.org>; Fri, 12 Nov 2021 08:08:41 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y16so11755390ioc.8
        for <linux-block@vger.kernel.org>; Fri, 12 Nov 2021 08:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hfnzO9UBGhIRvUdHZf6ZiO5w4XsBjxHmjcXisdyBUOc=;
        b=2HpbHppprW9rRyXJ5MT/RTlHHHhL4Ymo93pip52lhzwa7lu9QgTp227F3ZRh543E5r
         KjulSYQ+7vBYr3Zr3+8IyGUAPKufn0b00f6Fb/g94hsGo3ZheaPheab2coIWwc53vgeY
         qU/FpZZNP75jSSMOSrLb0BCF6VQ0qkEZxjxEcAKAQ8PxybJsrXx/YOssACKLXLQux+g8
         68TPB/oEgyObNaoaSztd0A378Mqj5QubCAWRn53XwG1grPXJXdYfArzUHgRhF1DeNldx
         RTqFRdSK07C+grkiIg3V9GHP9e6Qxx6myVBRYB0d0/5TzghHdSVikP7yvAvowU3+CpLZ
         of9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hfnzO9UBGhIRvUdHZf6ZiO5w4XsBjxHmjcXisdyBUOc=;
        b=V34k4+IWc855vv+fCSTPhYL2B833Xm7DfZ7JfBGdxyUAifHfMtqh57spMaOod4VkLA
         eHE+xv8UpU7cHesDjaz+Y3zKl54WnPiBpT84yIMcT3OH+A/TA0kqRMFMXCjl0Qr6ZZhX
         kQ77aEzNUMI3rX57FIRdjXwwYVlAA+pB+ZrVHxXpFQG6mF3kq8hBY5Rztb6M17bWbb1x
         qGMESpYssdvjrthqsYWqMeRRtyoCRUdjQ65FJnQ3gZNd3K9UQezkdCDkafVhTWpTlIpi
         Vga8GWwP9K0xgvf8k9pvEFa60yrUbTER3qw0HI4PO5kH3KSLL2Hu1UYMkdv9hgFjNKBf
         VyKQ==
X-Gm-Message-State: AOAM53207oGukTadu3cF+W9Jsi0dTwWRMmaGtFrC8j0eveUQQaiT2T/L
        SNUFtXNvYDCFBzULM7E3E2fUtVW7Nz/+X/pY
X-Google-Smtp-Source: ABdhPJzDj3JlG4KxBYG2AOCdPDIWDjt6bFiHFHV3D+D/SJ9ytEacwf1tuq4PL4iffI2ie3UoEgW6bg==
X-Received: by 2002:a05:6602:3ca:: with SMTP id g10mr11085248iov.194.1636733321055;
        Fri, 12 Nov 2021 08:08:41 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j23sm3354690iog.53.2021.11.12.08.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 08:08:40 -0800 (PST)
Subject: Re: [PATCH] blk-mq: setup blk_mq_alloc_data.cmd_flags after
 submit_bio_checks() is done
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20211112081137.406930-1-ming.lei@redhat.com>
 <20211112082140.GA30681@lst.de> <YY4nv5eQUTOF5Wfv@T590>
 <20211112084441.GA32120@lst.de> <YY5iUwZ2TVtfqfXN@T590>
 <8c04076d-6264-07c2-aa97-948211d5bc7f@kernel.dk> <YY6Qux6ZIIjNyc4b@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2b3a62dc-2f7d-0517-eaf5-2b1f60a60c9d@kernel.dk>
Date:   Fri, 12 Nov 2021 09:08:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YY6Qux6ZIIjNyc4b@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/12/21 9:05 AM, Ming Lei wrote:
> On Fri, Nov 12, 2021 at 08:47:01AM -0700, Jens Axboe wrote:
>> On 11/12/21 5:47 AM, Ming Lei wrote:
>>> On Fri, Nov 12, 2021 at 09:44:41AM +0100, Christoph Hellwig wrote:
>>>> On Fri, Nov 12, 2021 at 04:37:19PM +0800, Ming Lei wrote:
>>>>>> can only be used for reads, and no fua can be set if the preallocating
>>>>>> I/O didn't use fua, etc.
>>>>>>
>>>>>> What are the pitfalls of just chanigng cmd_flags?
>>>>>
>>>>> Then we need to check cmd_flags carefully, such as hctx->type has to
>>>>> be same, flush & passthrough flags has to be same, that said all
>>>>> ->cmd_flags used for allocating rqs have to be same with the following
>>>>> bio->bi_opf.
>>>>>
>>>>> In usual cases, I guess all IOs submitted from same plug batch should be
>>>>> same type. If not, we can switch to change cmd_flags.
>>>>
>>>> Jens: is this a limit fitting into your use cases?
>>>>
>>>> I guess as a quick fix this rejecting different flags is probably the
>>>> best we can do for now, but I suspect we'll want to eventually relax
>>>> them.
>>>
>>> rw mixed workload will be affected, so I think we need to switch to
>>> change cmd_flags, how about the following patch?
>>>
>>> From 9ab77b7adee768272944c20b7cffc8abdb85a35b Mon Sep 17 00:00:00 2001
>>> From: Ming Lei <ming.lei@redhat.com>
>>> Date: Fri, 12 Nov 2021 08:14:38 +0800
>>> Subject: [PATCH] blk-mq: fix filesystem I/O request allocation
>>>
>>> submit_bio_checks() may update bio->bi_opf, so we have to initialize
>>> blk_mq_alloc_data.cmd_flags with bio->bi_opf after submit_bio_checks()
>>> returns when allocating new request.
>>>
>>> In case of using cached request, fallback to allocate new request if
>>> cached rq isn't compatible with the incoming bio, otherwise change
>>> rq->cmd_flags with incoming bio->bi_opf.
>>>
>>> Fixes: 900e080752025f00 ("block: move queue enter logic into blk_mq_submit_bio()")
>>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>  block/blk-mq.c | 39 ++++++++++++++++++++++++++++++---------
>>>  block/blk-mq.h | 26 +++++++++++++++-----------
>>>  2 files changed, 45 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index f511db395c7f..3ab34c4f20da 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -2521,12 +2521,8 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>>>  	};
>>>  	struct request *rq;
>>>  
>>> -	if (unlikely(bio_queue_enter(bio)))
>>> -		return NULL;
>>> -	if (unlikely(!submit_bio_checks(bio)))
>>> -		goto put_exit;
>>>  	if (blk_mq_attempt_bio_merge(q, bio, nsegs, same_queue_rq))
>>> -		goto put_exit;
>>> +		return NULL;
>>>  
>>>  	rq_qos_throttle(q, bio);
>>>  
>>> @@ -2543,19 +2539,32 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>>>  	rq_qos_cleanup(q, bio);
>>>  	if (bio->bi_opf & REQ_NOWAIT)
>>>  		bio_wouldblock_error(bio);
>>> -put_exit:
>>> -	blk_queue_exit(q);
>>> +
>>>  	return NULL;
>>>  }
>>>  
>>> +static inline bool blk_mq_can_use_cached_rq(struct request *rq,
>>> +		struct bio *bio)
>>> +{
>>> +	if (blk_mq_get_hctx_type(bio->bi_opf) != rq->mq_hctx->type)
>>> +		return false;
>>> +
>>> +	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
>>> +		return false;
>>> +
>>> +	return true;
>>
>> I think we should just check if hctx is the same, that should be enough.
>> We don't need to match the type, just disallow if hw queue has changed.
> 
> But bio doesn't have hw queue. Figuring out exact hw queue seems
> necessary and needs more cpu cycles than getting hctx type.

Thinking about it, if opf and request_queue matches, that should be
enough.

-- 
Jens Axboe

