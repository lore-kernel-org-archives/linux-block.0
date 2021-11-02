Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703DBC433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 14:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C3C60F02
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 14:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhKBPAq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbhKBPAl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 11:00:41 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BBCC061767
        for <linux-block@vger.kernel.org>; Tue,  2 Nov 2021 07:57:43 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id y11so2076098oih.7
        for <linux-block@vger.kernel.org>; Tue, 02 Nov 2021 07:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b86LoqP3mj8sq0aqHiMmlLOqMZ686wPnib/3+RPLK5w=;
        b=j9MegoVe32X6LWLGXFH6KfrHNKBwPIE6A4DwFjAmkZY4b5dyW+9avw7T/HdjNCWk1V
         7dKVp6/duBCNlFZwsMJg/g/qDKukTvrr5hAiNkHfgsMG+FmNVtA3HtgmLn/wOAdIXUZZ
         qcH7ENmPQ0Xu7MAn3EFWVn2uc1ajDQP81Oh8EFwh77e3rWrW8yOYgPZPOKHJuVPil+qq
         OxxUJ6e6neqyIKElQGMyGSrEOgdfWphy/hK0PX68j6DE+OqsJJ4R1dBoTe2uI/zeHchf
         ljP32z5u24QdZyDQ2Sjo4wh/9YxjnBRENF876u2qur7UPLMdvJEkUh5Wv+kDLdl3VFaZ
         AOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b86LoqP3mj8sq0aqHiMmlLOqMZ686wPnib/3+RPLK5w=;
        b=h+wSi5cXE0IbxmPaUXCjpB5Hz8dykivjXmYCLvtW5tDpCrO7s/xrtD+kTy2kT3kpJF
         aUY5u7fBabFdpMF1AsjL9CLzhMdVGePaa4RW/yt1ZXajyO+h3LMj6jyciKFSS/L26JMc
         MbFJALXlN0/7o4iU4PCOTIqPrUa1ZXWiFWB6XjzLRYYJ04x2UA9UfDEBxhG7+/pljW/A
         FzEYie7pQdKHHTXXk/0tLVar/k2b4cZpsDOrs7kugPM4suabxceReOfO0CeHWE5zpUTt
         HI/wcTFtQ4VkquhnBxrqK7vImDbwTIoj8UX4yrV9e7lCfqn55/Xw1JFx/BM9ANJ6vdEA
         nmJg==
X-Gm-Message-State: AOAM533ftzOGuDbQo6njXlsMMiDOA7whri83ZNE4K6p1605PPY/dJ+IX
        zEXbsTADWYBO/8HKT7AXCBh7UYsLJLy4Bg==
X-Google-Smtp-Source: ABdhPJycZUc09qnSZuRnNvOQViBsvZRd4FPrvBe//oJxuSisQQ6tE38ALRKsIqtgE+ilGCvqQ64wmA==
X-Received: by 2002:aca:ba55:: with SMTP id k82mr1860586oif.167.1635865062481;
        Tue, 02 Nov 2021 07:57:42 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p133sm4902111oia.11.2021.11.02.07.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 07:57:42 -0700 (PDT)
Subject: Re: [PATCH 3/3] blk-mq: update hctx->nr_active in
 blk_mq_end_request_batch()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20211102133502.3619184-1-ming.lei@redhat.com>
 <20211102133502.3619184-4-ming.lei@redhat.com>
 <922449db-73a7-efaf-52ef-d386edf77953@kernel.dk> <YYFDz1AQqDoglgyu@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dda27cef-a3fc-03e7-0c28-c4b24600438e@kernel.dk>
Date:   Tue, 2 Nov 2021 08:57:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYFDz1AQqDoglgyu@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/21 7:57 AM, Ming Lei wrote:
> On Tue, Nov 02, 2021 at 07:47:44AM -0600, Jens Axboe wrote:
>> On 11/2/21 7:35 AM, Ming Lei wrote:
>>> In case of shared tags and none io sched, batched completion still may
>>> be run into, and hctx->nr_active is accounted when getting driver tag,
>>> so it has to be updated in blk_mq_end_request_batch().
>>>
>>> Otherwise, hctx->nr_active may become same with queue depth, then
>>> hctx_may_queue() always return false, then io hang is caused.
>>>
>>> Fixes the issue by updating the counter in batched way.
>>>
>>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>> Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>  block/blk-mq.c | 15 +++++++++++++--
>>>  block/blk-mq.h | 12 +++++++++---
>>>  2 files changed, 22 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 07eb1412760b..0dbe75034f61 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -825,6 +825,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
>>>  	struct blk_mq_hw_ctx *cur_hctx = NULL;
>>>  	struct request *rq;
>>>  	u64 now = 0;
>>> +	int active = 0;
>>>  
>>>  	if (iob->need_ts)
>>>  		now = ktime_get_ns();
>>> @@ -846,16 +847,26 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
>>>  		rq_qos_done(rq->q, rq);
>>>  
>>>  		if (nr_tags == TAG_COMP_BATCH || cur_hctx != rq->mq_hctx) {
>>> -			if (cur_hctx)
>>> +			if (cur_hctx) {
>>> +				if (active)
>>> +					__blk_mq_sub_active_requests(cur_hctx,
>>> +							active);
>>>  				blk_mq_flush_tag_batch(cur_hctx, tags, nr_tags);
>>> +			}
>>>  			nr_tags = 0;
>>> +			active = 0;
>>>  			cur_hctx = rq->mq_hctx;
>>>  		}
>>>  		tags[nr_tags++] = rq->tag;
>>> +		if (rq->rq_flags & RQF_MQ_INFLIGHT)
>>> +			active++;
>>
>> Are there any cases where either none or all of requests have the
>> flag set, and hence active == nr_tags?
> 
> none and BLK_MQ_F_TAG_QUEUE_SHARED, and Shinichiro only observed the
> issue on two NSs.

Maybe I wasn't clear enough. What I'm saying is that either all of the
requests will have RQF_MQ_INFLIGHT set, or none of them. Hence active
should be either 0, or == nr_tags.

That's the hypothesis that I wanted to check, because if that's true,
then we can do this in a better way.

-- 
Jens Axboe

