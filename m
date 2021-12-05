Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B5DC433EF
	for <linux-block@archiver.kernel.org>; Sun,  5 Dec 2021 13:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhLENNH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Dec 2021 08:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbhLENNG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Dec 2021 08:13:06 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC65C061714
        for <linux-block@vger.kernel.org>; Sun,  5 Dec 2021 05:09:39 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id m9so9834400iop.0
        for <linux-block@vger.kernel.org>; Sun, 05 Dec 2021 05:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XUEdPGf2mgvEdnG+UktAqE22u9m43XekCDiBWsdJQWE=;
        b=MOB9LhVWpz+v1n6wvIdQvia9aC6cHJ5K77NB2b21S2jX25BatyDMHjFiLpYQXvjkIJ
         adbF4R/QciWgcbPHWlUSDvAXKz19/XVb4ALtuYtN7A7g7/p2b2DIVxr45znzlSAJTnxK
         3ZiDTS4wueYpcyDBfSGVcyG7fvA3chJHl10Xg+Ze05PsxxZt6vz09sP3jHfqmiwFrrJv
         6uUiWNXvoLmrZqS3nxGSeZdHwoXqcvjeq0AyqxqtLCcv480wEcn8MfuiuBTBZ6t7Ql3u
         n6XE9obb4RgzyziXi4oVghJEL3dGJX8EpLoI5kzCU66yYn702mp2zUuCaVtQWypKZjHE
         KMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XUEdPGf2mgvEdnG+UktAqE22u9m43XekCDiBWsdJQWE=;
        b=ULVMswJFcyD8Mr4okMGgsRdTZgjJIB3Ue0pZsYXLeHFSr3H2tX+Btwey2gdmBZdbtA
         Z+F+li/GZDfAV99LGJppeM7IF1wprZqSh7SoHq7qXv0Ch0t7evMBGGksSu0kGV5baU08
         gALg9NUDF+KosmF3dYYRM8dQN8VptdxkswoZP0Yg08uAWogOe1gr+CaGbzEv1rpzs4Bw
         Mr4gS31Ib/0AhmDJz6ambuzNB51atRTtMVfP3qVxlUizlnD6pep0bmwd/qXe3Xu+9gUC
         Ftk1fTMgh+p/b+sOEC6mYxJtbIj+P6rzrey4GLd3K+wpOewprPEVSaSRALiF2wN+bNgq
         rn6A==
X-Gm-Message-State: AOAM530Es2HO+nC8bVHsU3BtUfnech1GFxjHLP2HAYvj4F/+8/GBL2ry
        D/KowL+vDGP4qFLMqlaKNGRpkvy9fOcT3kiV
X-Google-Smtp-Source: ABdhPJwUMY9iFQ+FHodGAUyHB9h2MynD7EjFdDBgc8GemavIUyUmzEqQh1S/apnJjrJzo2mAqSVDvA==
X-Received: by 2002:a05:6602:2d8c:: with SMTP id k12mr28329208iow.49.1638709778937;
        Sun, 05 Dec 2021 05:09:38 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y4sm5316956ilv.21.2021.12.05.05.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Dec 2021 05:09:38 -0800 (PST)
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
To:     Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-2-axboe@kernel.dk>
 <2a3fb650-4b6e-9eb1-aa6b-318236717ccf@suse.de>
 <ad621fff-2338-fad8-48cb-dfdbd5ccc72a@kernel.dk>
 <39b861aa-fb2d-55fd-8581-28ce8e0f0c90@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <52e4e61e-ba7a-68cd-d29f-c68a5d6956cb@kernel.dk>
Date:   Sun, 5 Dec 2021 06:09:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <39b861aa-fb2d-55fd-8581-28ce8e0f0c90@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/21 2:07 AM, Hannes Reinecke wrote:
> On 12/4/21 9:13 PM, Jens Axboe wrote:
>> On 12/4/21 3:43 AM, Hannes Reinecke wrote:
>>> On 12/3/21 10:45 PM, Jens Axboe wrote:
>>>> If we have a list of requests in our plug list, send it to the driver in
>>>> one go, if possible. The driver must set mq_ops->queue_rqs() to support
>>>> this, if not the usual one-by-one path is used.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> ---
>>>>    block/blk-mq.c         | 24 +++++++++++++++++++++---
>>>>    include/linux/blk-mq.h |  8 ++++++++
>>>>    2 files changed, 29 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index 22ec21aa0c22..9ac9174a2ba4 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -2513,6 +2513,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>>>>    {
>>>>    	struct blk_mq_hw_ctx *this_hctx;
>>>>    	struct blk_mq_ctx *this_ctx;
>>>> +	struct request *rq;
>>>>    	unsigned int depth;
>>>>    	LIST_HEAD(list);
>>>>    
>>>> @@ -2521,7 +2522,26 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>>>>    	plug->rq_count = 0;
>>>>    
>>>>    	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
>>>> -		blk_mq_run_dispatch_ops(plug->mq_list->q,
>>>> +		struct request_queue *q;
>>>> +
>>>> +		rq = plug->mq_list;
>>>> +		q = rq->q;
>>>> +
>>>> +		/*
>>>> +		 * Peek first request and see if we have a ->queue_rqs() hook.
>>>> +		 * If we do, we can dispatch the whole plug list in one go. We
>>>> +		 * already know at this point that all requests belong to the
>>>> +		 * same queue, caller must ensure that's the case.
>>>> +		 */
>>>> +		if (q->mq_ops->queue_rqs &&
>>>> +		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
>>>
>>> What is the dependency on shared tags here?
>>>   From what I've seen it's just about submitting requests; the only
>>> difference to shared tags is the way the tags are allocated.
>>> Care to explain?
>>
>> For shared tags, we need to actively increment the use count per
>> request. This path doesn't do that, so it's disabled for now. It could
>> be done, but then it'd have to be in the caller, so I'd rather leave it
>> for a future optimization if anyone cares enough about this for shared
>> tags.
>>
>> I can add a comment about it if that helps.
>>
> Please do.
> It'll act as a reminder what needs to be done if and when one of the 
> drivers requiring shared tags is looking at implementing queue_rqs.

I added to the comment yesterday:

https://git.kernel.dk/cgit/linux-block/commit/?h=perf-wip&id=f9f526700607bf804fa8541c824ea54253f4241a

-- 
Jens Axboe

