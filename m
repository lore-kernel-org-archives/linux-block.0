Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CFCC433E6
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 22:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3480F206EF
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 22:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nBkmNgU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIAWh5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgIAWh4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 18:37:56 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6EBC061244
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 15:37:56 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d19so1473839pgl.10
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2020 15:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7+RhGDOis5qVgatyvfIf/8jrjlolrZQ0Fj4LoQTIsR0=;
        b=nBkmNgU96MGgnTqugFamy7iuxj6KolztzJKlFisL4oi1J9DyrR97MF03GCdKd1DegC
         po+0ZwtA9SsYanEpLQlq0n5FC/3z8eL1ZM+aISSJZNchB19EKL3iBuDgDUvgibExSdOv
         S76sN81ZVIwZ2HcqpaWAgIl5H95wBelhemV7ddOhK/fFcCeFC6y7Ju1Rkoqc2cxxeB6q
         4semZCmh0F+trt18/jcjcqtX/Tr5LKxNcXWXej8Jfo+Inqe88tm+fTb8Zo/MRElGpnvF
         ZVv7m/Wa4eeFKoQUGvsAvoL2Zfwz5im05XvwV1Fqm0Ted9EDyqIpy2dEfVfKK2HQaKBB
         11bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7+RhGDOis5qVgatyvfIf/8jrjlolrZQ0Fj4LoQTIsR0=;
        b=rC1yeJhgDCHFUUTvZU8OhHpKJHyq0+wCCgeavh1FhegxWmLKQmnyQVq/BcqyUVdwYV
         AeR9mEaQ8K0BGHWtdOX6pbhVfNS87P002kJxYZvUOfenED/8n96j4WRYuAt+kwt5gf5o
         MpWyTxJw9sI7Ipu4ykr4LvGg4vk3rmkBPmBsRzlKBRQsRmsTzb7hbWToVZIddhRIe5N7
         jCFcloyFIHai+CRUbStUnXBwsUBkGuRHBg5LCRhqGVPzRJiPq8+NVPKUQ7cGfMU15W/G
         CUGK/3GfMTC/ytJnwfq/v1xEYmv2R33UUZAjzsoFS0xh1J9eT2gNkguPGZMowqAii5RI
         125g==
X-Gm-Message-State: AOAM532/t90L71aWVi5GPg2eV+/qgM1VfSs1nDde2FSXrL3ozy3wcd5G
        s/64WYQQ0HXT3oRhIfwipPxyhQ==
X-Google-Smtp-Source: ABdhPJywUXIGAVInXO2X5L76wH7wv07tQUIfVAtokBx7NsggcKa0iZ3qhC44p4iDDgn9buunHyyTfQ==
X-Received: by 2002:a63:4841:: with SMTP id x1mr3302836pgk.328.1598999875788;
        Tue, 01 Sep 2020 15:37:55 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 65sm3137343pfx.104.2020.09.01.15.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 15:37:54 -0700 (PDT)
Subject: Re: [PATCH] block: Fix inflight statistic for MQ submission with
 !elevator
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-block <linux-block@vger.kernel.org>, kernel@collabora.com
References: <20200831153127.3561733-1-krisman@collabora.com>
 <CACVXFVM21GWTrWs=6w3OXm7vQ-gmR_3PGss+9TE=swVN-Uzn7Q@mail.gmail.com>
 <1b0ad48b-bc94-269f-1899-e49f3d1802e2@kernel.dk>
 <20200901063611.GC289251@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ba4773e3-0ec1-82f1-d004-0a434586a9ba@kernel.dk>
Date:   Tue, 1 Sep 2020 16:37:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901063611.GC289251@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/1/20 12:36 AM, Ming Lei wrote:
> Hi Jens,
> 
> On Mon, Aug 31, 2020 at 09:42:05PM -0600, Jens Axboe wrote:
>> On 8/31/20 7:18 PM, Ming Lei wrote:
>>> On Mon, Aug 31, 2020 at 11:37 PM Gabriel Krisman Bertazi
>>> <krisman@collabora.com> wrote:
>>>>
>>>> According to Documentation/block/stat.rst, inflight should not include
>>>> I/O requests that are in the queue but not yet dispatched to the device,
>>>> but blk-mq identifies as inflight any request that has a tag allocated,
>>>> which, for queues without elevator, happens at request allocation time
>>>> and before it is queued in the ctx (default case in blk_mq_submit_bio).
>>>>
>>>> A more precise approach would be to only consider requests with state
>>>> MQ_RQ_IN_FLIGHT.
>>>>
>>>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>>>> ---
>>>>  block/blk-mq.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index 0015a1892153..997b3327eaa8 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -105,7 +105,7 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
>>>>  {
>>>>         struct mq_inflight *mi = priv;
>>>>
>>>> -       if (rq->part == mi->part)
>>>> +       if (rq->part == mi->part && rq->state == MQ_RQ_IN_FLIGHT)
>>>>                 mi->inflight[rq_data_dir(rq)]++;
>>>
>>> The fix looks fine. However, we have helper of
>>> blk_mq_request_started() for this purpose.
>>
>> Why does it look fine? Did you see the older commit I referenced? I'm
> 
> Looks my gmail inbox has problem, and I didn't see your referenced
> commit. but I can see your reply just now in my redhat email box,
> sorry for that.

Ah ok, that explains it, just felt like it was being ignored.

> BTW, commit 6131837b1de6 ("blk-mq: count allocated but not started requests
> in iostats inflight") didn't does what it claimed. blk_mq_queue_tag_busy_iter()
> iterates over driver tags, so for real io scheduler, blk_mq_check_inflight()
> basically returns count of inflight request, instead of allocated request.
> 
> Even worse, since commit 6131837b1de6 blk_mq_in_flight() behaves inconsistently
> between q->elevator and !q->elevator.

I agree, that is definitely a problem, and I've run into this internally
at FB in fact.

>> not saying the change is wrong per se, just that this is the behavior
>> we've always had, and making this change would deviate from that. As
>> Gabriel states in the follow up, it's either changing the documentation
>> or the patch.
> 
> Looks iostat doesn't use the 'inflight' count, so what is the
> userspace's expectation on this counter?
> 
> If it counts allocated request, it is easy for userspace to observe
> different statistics if someone updates nr_requests via sysfs.

I don't think there's necessarily an expectation, but if we change the
scope then that might cause problems for folks. All of a sudden the
iowait looks less, for example, and that can be hard to explain.

That said, I do think the patch makes sense, obviously, since that's how
I originally did the mq accounting. But it's hard to argue with history
and expectations, and that is my worry. I don't want to apply this
patch, then have to revert the behavior a few revisions later. And then
we end up with different kernels that have different metrics, and that's
somewhat of a mess.

-- 
Jens Axboe

