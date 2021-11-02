Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2D9C433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 15:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5680760F24
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 15:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhKBPXD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbhKBPXB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 11:23:01 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BBBC061714
        for <linux-block@vger.kernel.org>; Tue,  2 Nov 2021 08:20:26 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id s14so4954671ilv.10
        for <linux-block@vger.kernel.org>; Tue, 02 Nov 2021 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uzG4nc94YKT6Azi07aL+bStkJt5xN9dplvqxukecCq8=;
        b=3F0+W9kSZ3jTdBR7cSzsvEt32h/J6555mITkp5caeU6LvhKUyxaCIt7nXSZr/lE/rc
         qzmU+F2CoxbOxRWtXHGGsbpPshtFQJrCIn+uF03jJWBPbPE5j8EMb8rBOrb6CtcHBNEv
         ELglnANl9MGUZRlCASVy5XR70g1O7beh/t6rNx339jE/dMEtu8Y2y7j8XXLsmrPwax90
         wLeDUTGfq+uLfMe4LgB51QXF+hZGhRsn1WPupC5ijX525g788rElfvYvqao6S1PMUyOZ
         LV4lq5UQqfR7F1mwbpiuPWm0c23haYtR57TecdKo8OrKo5ahyXyIyNnsGDizkE0IrAs8
         Qtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uzG4nc94YKT6Azi07aL+bStkJt5xN9dplvqxukecCq8=;
        b=TBnxNXIDvhVe2ymLNrr12FRcTHdn+y9JqlWsbIegRA+Joi+nLolU7t+ERNtcTiJjb0
         aU+vzN7yuxSO1broD+E1ICXLfm1Mh4MCSUl091vH8htIeO167P8upR+s07HNBIWnb7mt
         7QEJ/B+Gu6gWyW5zxKsKa7L0xIAUVAHvSHv8lT9wyRQSZkeknO8V5zhYC1K7lOegWxm0
         54YaQVIwoR4UVnn1+Va3OODN3zphJonN0LqtibRETeTd+Pzr2zr+sAHALv4A6G+Wu/jm
         R44yEeXvSHnJG84TOGZhFzT44mDjXoj2zjQuMwpiraXEn++Q6FqGx5mN3lT3NyXfRfKq
         a7oA==
X-Gm-Message-State: AOAM530kJBbR5qGQkA5lBMb16GJpav2f90Dwbb8w29sfpfknVOa+wDvm
        /mYbLcpaJSenwxKcVp1AYU91Hg==
X-Google-Smtp-Source: ABdhPJygcOIhDWAuh5AbgiVeOGV0rzprWgtg/Cy57oaEZyS7RnNIyCuIAD02lDf3pP13M7XXyGCbJQ==
X-Received: by 2002:a92:c241:: with SMTP id k1mr10389567ilo.207.1635866425834;
        Tue, 02 Nov 2021 08:20:25 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z6sm8900981ioq.35.2021.11.02.08.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 08:20:25 -0700 (PDT)
Subject: Re: [PATCH 3/3] blk-mq: update hctx->nr_active in
 blk_mq_end_request_batch()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20211102133502.3619184-1-ming.lei@redhat.com>
 <20211102133502.3619184-4-ming.lei@redhat.com>
 <922449db-73a7-efaf-52ef-d386edf77953@kernel.dk> <YYFDz1AQqDoglgyu@T590>
 <dda27cef-a3fc-03e7-0c28-c4b24600438e@kernel.dk> <YYFUaaLNOExwJ5P1@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e35c2b06-361c-9291-a922-62f10b5c4e00@kernel.dk>
Date:   Tue, 2 Nov 2021 09:20:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYFUaaLNOExwJ5P1@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/21 9:08 AM, Ming Lei wrote:
> On Tue, Nov 02, 2021 at 08:57:41AM -0600, Jens Axboe wrote:
>> On 11/2/21 7:57 AM, Ming Lei wrote:
>>> On Tue, Nov 02, 2021 at 07:47:44AM -0600, Jens Axboe wrote:
>>>> On 11/2/21 7:35 AM, Ming Lei wrote:
>>>>> In case of shared tags and none io sched, batched completion still may
>>>>> be run into, and hctx->nr_active is accounted when getting driver tag,
>>>>> so it has to be updated in blk_mq_end_request_batch().
>>>>>
>>>>> Otherwise, hctx->nr_active may become same with queue depth, then
>>>>> hctx_may_queue() always return false, then io hang is caused.
>>>>>
>>>>> Fixes the issue by updating the counter in batched way.
>>>>>
>>>>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>>> Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>> ---
>>>>>  block/blk-mq.c | 15 +++++++++++++--
>>>>>  block/blk-mq.h | 12 +++++++++---
>>>>>  2 files changed, 22 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>> index 07eb1412760b..0dbe75034f61 100644
>>>>> --- a/block/blk-mq.c
>>>>> +++ b/block/blk-mq.c
>>>>> @@ -825,6 +825,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
>>>>>  	struct blk_mq_hw_ctx *cur_hctx = NULL;
>>>>>  	struct request *rq;
>>>>>  	u64 now = 0;
>>>>> +	int active = 0;
>>>>>  
>>>>>  	if (iob->need_ts)
>>>>>  		now = ktime_get_ns();
>>>>> @@ -846,16 +847,26 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
>>>>>  		rq_qos_done(rq->q, rq);
>>>>>  
>>>>>  		if (nr_tags == TAG_COMP_BATCH || cur_hctx != rq->mq_hctx) {
>>>>> -			if (cur_hctx)
>>>>> +			if (cur_hctx) {
>>>>> +				if (active)
>>>>> +					__blk_mq_sub_active_requests(cur_hctx,
>>>>> +							active);
>>>>>  				blk_mq_flush_tag_batch(cur_hctx, tags, nr_tags);
>>>>> +			}
>>>>>  			nr_tags = 0;
>>>>> +			active = 0;
>>>>>  			cur_hctx = rq->mq_hctx;
>>>>>  		}
>>>>>  		tags[nr_tags++] = rq->tag;
>>>>> +		if (rq->rq_flags & RQF_MQ_INFLIGHT)
>>>>> +			active++;
>>>>
>>>> Are there any cases where either none or all of requests have the
>>>> flag set, and hence active == nr_tags?
>>>
>>> none and BLK_MQ_F_TAG_QUEUE_SHARED, and Shinichiro only observed the
>>> issue on two NSs.
>>
>> Maybe I wasn't clear enough. What I'm saying is that either all of the
>> requests will have RQF_MQ_INFLIGHT set, or none of them. Hence active
>> should be either 0, or == nr_tags.
> 
> Yeah, that is right since BLK_MQ_F_TAG_QUEUE_SHARED is updated after
> queue is frozen. Meantime blk_mq_end_request_batch() is only called
> for ending successfully completed requests.
> 
> Will do that in V2.

Thanks, then it just becomes a single check in blk_mq_flush_tag_batch(),
which is a lot better than per-request.

-- 
Jens Axboe

