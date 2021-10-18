Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CB4C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 02:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B345660EBB
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 02:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhJRCMj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 22:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbhJRCMj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 22:12:39 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BA4C06161C
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 19:10:28 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id s17so14389157ioa.13
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 19:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bNwn35pIm+hO4R7H7HsIgIXxNx6HfF1h4A/ZG+70GEc=;
        b=B3hOv80W7sY/huO8A2vBbpntvzW7GdOkx+91HjgGxaKAR4B2OCUbOay/F0BG2Ro0S/
         OrnPduzWdHfivT4xfzlvUyhmhdhncFnynwD8DNz3KiCoQmKmhLcsBHR43d5u++6pRiC9
         j5LSBV5Aa/PnlJdkq/ujd73vFa7RbHcz6QcUYgRqdIGYEnL/csq+63f22Iw0Tqq2sD4v
         AsXryGy5EzgVw53pIM0qr3/jvkBLlZe2zt29onOeXYIL3D0FVA8cI3lYylz1tvcEp0Ri
         nz1XX6SaAIt2uDtG58XgXc6cS6AK3OUv1Qt7sUlZYoYGXN7YCrdArBfFqUKadyqSumzC
         2IUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bNwn35pIm+hO4R7H7HsIgIXxNx6HfF1h4A/ZG+70GEc=;
        b=BGpZGpyt4vVkTEI0782qa3QE+5nJijLTFPC8+WYNGwkyiqE4fotdsdMMG+I6bfCuiO
         KudxipwAALZHH4zUS55Ds8QH7wp+g2yGdLRWzfZNa/OwF8639xtWSh4yeB16q2ttF6BF
         8D2eHdhBU3HyaAW5BqUTf94vk5JuqWZgez8O2+aUUs624sxorsqNJCFwVXm/PzAS34zl
         NKYUKXdKWLv/aOwq1wB7jzYP6q+i67tNnDtSbyBMKbSM17Lv2dICA0HhylXwLQLkBB8d
         UTQTbH6yig6Wv3RorSF1m8iRtw6VqJQWoosJJ5wbMitWb7036bx7LTHH+lc6yNcc5qjC
         Ndpw==
X-Gm-Message-State: AOAM533EV/lMBX61KUfRjkY5YD+0TVjXmire7qieSxL8XCjfvovTvgMr
        9uTEYecMWZ9n2oErylleZlTspzWg0+RMgg==
X-Google-Smtp-Source: ABdhPJxOZ5A9NmrSNS2r5OjCwoa1MtKjUNPoP1SbvOIZx8zhAdlvq/+ZttKEdVJY9wvEbc/3I1/5NQ==
X-Received: by 2002:a02:a38e:: with SMTP id y14mr16685326jak.8.1634523027820;
        Sun, 17 Oct 2021 19:10:27 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id c5sm6300255ilq.71.2021.10.17.19.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 19:10:27 -0700 (PDT)
Subject: Re: [PATCH] block: don't dereference request after flush insertion
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <f2f17f46-ff3a-01c4-bfd4-8dec836ec343@kernel.dk>
 <YWzSqzsuDF8Fl9jB@T590> <17362528-4be4-1407-5a05-cfb0a7524910@kernel.dk>
 <YWzVuDdyTVvED1QA@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f603aff-62d5-637a-147d-3d4530acb232@kernel.dk>
Date:   Sun, 17 Oct 2021 20:10:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWzVuDdyTVvED1QA@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/17/21 8:02 PM, Ming Lei wrote:
> On Sun, Oct 17, 2021 at 07:50:24PM -0600, Jens Axboe wrote:
>> On 10/17/21 7:49 PM, Ming Lei wrote:
>>> On Sat, Oct 16, 2021 at 07:35:39PM -0600, Jens Axboe wrote:
>>>> We could have a race here, where the request gets freed before we call
>>>> into blk_mq_run_hw_queue(). If this happens, we cannot rely on the state
>>>> of the request.
>>>>
>>>> Grab the hardware context before inserting the flush.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>
>>>> ---
>>>>
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index 2197cfbf081f..22b30a89bf3a 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -2468,9 +2468,10 @@ void blk_mq_submit_bio(struct bio *bio)
>>>>  	}
>>>>  
>>>>  	if (unlikely(is_flush_fua)) {
>>>> +		struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>>>>  		/* Bypass scheduler for flush requests */
>>>>  		blk_insert_flush(rq);
>>>> -		blk_mq_run_hw_queue(rq->mq_hctx, true);
>>>> +		blk_mq_run_hw_queue(hctx, true);
>>>
>>> If the request is freed before running queue, the request queue could
>>> be released and the hctx may be freed.
>>
>> No, we still hold a queue enter ref.
> 
> But that one is released when rq is freed since ac7c5675fa45 ("blk-mq: allow
> blk_mq_make_request to consume the q_usage_counter reference"), isn't
> it?

Yes I think you're right, we need to grab an extra ref in the flush case as
we're using it after it may potentially have completed. We could probably
make it smarter, but little point for just handling a flush.

commit ea0f672e7cc66e7ec12468ff907de6064656b6e7
Author: Jens Axboe <axboe@kernel.dk>
Date:   Sat Oct 16 07:34:49 2021 -0600

    block: grab extra reference for flush insertion
    
    We could have a race here, where the request gets freed before we call
    into blk_mq_run_hw_queue(). If this happens, we cannot rely on the state
    of the request, nor can we rely on the queue still being alive.
    
    Grab an extra queue reference before inserting the flush and then running
    the queue, to ensure that it is still valid.
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 87dc2debedfb..d28423ccfe2b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2284,9 +2284,18 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	}
 
 	if (unlikely(is_flush_fua)) {
+		struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+
+		/*
+		 * Our queue ref may disappears as soon as the flush is
+		 * inserted, grab an extra one.
+		 */
+		percpu_ref_tryget_live(&q->q_usage_counter);
+
 		/* Bypass scheduler for flush requests */
 		blk_insert_flush(rq);
-		blk_mq_run_hw_queue(rq->mq_hctx, true);
+		blk_mq_run_hw_queue(hctx, true);
+		blk_queue_exit(q);
 	} else if (plug && (q->nr_hw_queues == 1 ||
 		   blk_mq_is_shared_tags(rq->mq_hctx->flags) ||
 		   q->mq_ops->commit_rqs || !blk_queue_nonrot(q))) {

-- 
Jens Axboe

