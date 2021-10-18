Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1578BC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 02:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D2361260
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 02:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhJRCSn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 22:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhJRCSm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 22:18:42 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D15C06161C
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 19:16:32 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id i189so14498785ioa.1
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 19:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RFC83SSUMLY+yt9oUli55tUL2yTChA/O5VXGWhGOwGs=;
        b=23baX+zMjUksahp2D6+z8w7ZhtDWQJ/1hzIfgWDd81s41ItMKnWninfdq7/RQzJ0PU
         VvRGV38NAJpTp060FkHJQT+PPqMIZhzNusE6LIlZG2C+kNQoOiS2lKGUXwPMzSf00Xun
         60F+IgcNSBgco04T5NZ96dYbDnlCPetncsElq5NCI7Z2t9GJGJyHAh1i1f1/jhfx9fHb
         YfLD5/KVnBnjRs9scVoyFRUSmBAEJDQx3z8Eo3k6+qhYSSH4k/rcVMugQpijf9b0QZRU
         TTmzbbnqFXk5DhFHnoisdBnhYPYD6zuTEya0zIkyRyG09Qrnpl/LZIoo4L6cctWKBxvg
         eUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RFC83SSUMLY+yt9oUli55tUL2yTChA/O5VXGWhGOwGs=;
        b=l5yoksumD7vSnUxpXvex+wVd2i004gzQ6MnCvD29kYtYaFrxrp4edU3iU5JbHtp3uc
         Mo7GGQc5UXdW1EGAO22HVcN/PiidHVAF6rc/2cSTf8icvxVl7+XeF3rdP+5nDVhIHOHN
         lSkW1rZppfYOEE4NfsxhENQoK90J4T89pq0RmC/q8W2kJULC3rfp7YIOG4MjPcKZhXFH
         T7xx3WyKWvw+8pH1X1VzQDgrn75zXs0DwqqIsSKtC7X1X+qdFm2GJ/095ZlFUlQc4IVz
         lxqTlj7tdk1/eMeEg1BUmOx4c9w41FPSqTyouOPxeZuJ8Z+RPWfnd+QIcklVimZJxbaL
         LLZg==
X-Gm-Message-State: AOAM533az+u6aCI5HdNp2ju0JiCbmgXkSbgEsTd2psmV83+LCU53hqGm
        Z8aDmX0PUZ0BCBft9/R3qWA5SZXx5itejA==
X-Google-Smtp-Source: ABdhPJxiZa9xZk4av7+NqlbAJkor+cNXyyT7Ht0whmTMFOnBrVSvZCGN014QMXb9H/cnOXJLVAx8lQ==
X-Received: by 2002:a05:6638:f14:: with SMTP id h20mr16877436jas.59.1634523391601;
        Sun, 17 Oct 2021 19:16:31 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y6sm6512608ilv.57.2021.10.17.19.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 19:16:31 -0700 (PDT)
Subject: Re: [PATCH] block: don't dereference request after flush insertion
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <f2f17f46-ff3a-01c4-bfd4-8dec836ec343@kernel.dk>
 <YWzSqzsuDF8Fl9jB@T590> <17362528-4be4-1407-5a05-cfb0a7524910@kernel.dk>
 <YWzVuDdyTVvED1QA@T590> <YWzXzd/LQubjXnrY@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <65db3ed2-9cc5-b136-0a54-d477acec9a58@kernel.dk>
Date:   Sun, 17 Oct 2021 20:16:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWzXzd/LQubjXnrY@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/17/21 8:11 PM, Ming Lei wrote:
> On Mon, Oct 18, 2021 at 10:02:32AM +0800, Ming Lei wrote:
>> On Sun, Oct 17, 2021 at 07:50:24PM -0600, Jens Axboe wrote:
>>> On 10/17/21 7:49 PM, Ming Lei wrote:
>>>> On Sat, Oct 16, 2021 at 07:35:39PM -0600, Jens Axboe wrote:
>>>>> We could have a race here, where the request gets freed before we call
>>>>> into blk_mq_run_hw_queue(). If this happens, we cannot rely on the state
>>>>> of the request.
>>>>>
>>>>> Grab the hardware context before inserting the flush.
>>>>>
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>>
>>>>> ---
>>>>>
>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>> index 2197cfbf081f..22b30a89bf3a 100644
>>>>> --- a/block/blk-mq.c
>>>>> +++ b/block/blk-mq.c
>>>>> @@ -2468,9 +2468,10 @@ void blk_mq_submit_bio(struct bio *bio)
>>>>>  	}
>>>>>  
>>>>>  	if (unlikely(is_flush_fua)) {
>>>>> +		struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>>>>>  		/* Bypass scheduler for flush requests */
>>>>>  		blk_insert_flush(rq);
>>>>> -		blk_mq_run_hw_queue(rq->mq_hctx, true);
>>>>> +		blk_mq_run_hw_queue(hctx, true);
>>>>
>>>> If the request is freed before running queue, the request queue could
>>>> be released and the hctx may be freed.
>>>
>>> No, we still hold a queue enter ref.
>>
>> But that one is released when rq is freed since ac7c5675fa45 ("blk-mq: allow
>> blk_mq_make_request to consume the q_usage_counter reference"), isn't
>> it?
> 
> With commit ac7c5675fa45, any reference to hctx after queuing request could
> lead to UAF in the code path of blk_mq_submit_bio(). Maybe we need to grab
> two ref in queue enter, and release one after the bio is submitted.

I'd rather audit and see if there are any, because extra get+put isn't
exactly free.

-- 
Jens Axboe

