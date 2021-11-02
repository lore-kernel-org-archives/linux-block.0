Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB367C433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 15:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF4660EB4
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 15:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhKBPZw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhKBPZw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 11:25:52 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD9CC061714
        for <linux-block@vger.kernel.org>; Tue,  2 Nov 2021 08:23:17 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l8so4437891ilv.3
        for <linux-block@vger.kernel.org>; Tue, 02 Nov 2021 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dq1+aKehJc03boWXeB1kqazmkNMh3AMMJ1l2GKENLAU=;
        b=aJCBLpO9cA7efmHEpW5s59wQ2/gmAAlcjpKlBJiD9vaPs5O5Cd23qhE3XMwRwYRorM
         kAozbOh5MfDGhWF3lRYIZNSEKt09zn1Iye5gw3RMi23NawzGBOr/jEwyri0G1bFuFLMV
         y1l20KB12aCRFOzmAAaCJDrx6ML3H4NdmyfUTkGAlgArnYipYtHQ5wbmS6zX5I72MXjr
         h3mxu/TDT1RaWbu2T3zSLhrj5/4Ub9uX1JmEAZ902Dxs+7Uo+E6fhKm9H9YNdiwHElkE
         nby1mz08p2UhJoQAafEIlGl7GxZlN3fgYdUj08Zv3K8PMjqPhshAsQi6GrQY6ZQjVrC2
         1+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dq1+aKehJc03boWXeB1kqazmkNMh3AMMJ1l2GKENLAU=;
        b=F11LQGLo4WyO+fY1Lvqst5krq2NdlhCOlPJWTHtxp9XW9LBvEOGpYXxcqnEx98SEAc
         yNIrhuunElme4AFDHC/0FITGugVK3LByBakC2BVlEYUT9foIt+E/cn7IggoasjsKPokI
         w2eX6hJTGr7uC7au5yTkc8pIk/ew2qdByBCU+07G3IOu3OeU165pK+Ke7zPvEwTGAXFn
         1ubJJIiT5Kxgkjr5yUkp/ADe/Ai8kvfpjloIM8mRd2IphY6/ACfsV/s4RQwhuxhWGJWb
         kMng4+xUX3Br+kpk2HpefJZigk1mTLJVeRg5we5PV4VmwDy5pMDPolyexDw/khXfb6zg
         lqGg==
X-Gm-Message-State: AOAM5308OqY789Ev1uCaeZZPlgu1Zf0/3BtN4fIGsqaz56y1hK7rEW0P
        dBbfopd9YMb0pHsDmP5kudQFoNtpxRZ4gA==
X-Google-Smtp-Source: ABdhPJxv2k3pQVyoW8GqH8u7msuRG3Ydo+Gq6ZcmQREjkUs8YA10UxRT5JpCbwM9y6KEqAqRgGQ6xg==
X-Received: by 2002:a92:520f:: with SMTP id g15mr16484783ilb.217.1635866596900;
        Tue, 02 Nov 2021 08:23:16 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o1sm9653839ilj.41.2021.11.02.08.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 08:23:16 -0700 (PDT)
Subject: Re: [PATCH 3/3] blk-mq: update hctx->nr_active in
 blk_mq_end_request_batch()
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20211102133502.3619184-1-ming.lei@redhat.com>
 <20211102133502.3619184-4-ming.lei@redhat.com>
 <922449db-73a7-efaf-52ef-d386edf77953@kernel.dk> <YYFDz1AQqDoglgyu@T590>
 <dda27cef-a3fc-03e7-0c28-c4b24600438e@kernel.dk> <YYFUaaLNOExwJ5P1@T590>
 <e35c2b06-361c-9291-a922-62f10b5c4e00@kernel.dk>
Message-ID: <5ef789a1-5e85-5400-e82d-4a200a780759@kernel.dk>
Date:   Tue, 2 Nov 2021 09:23:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e35c2b06-361c-9291-a922-62f10b5c4e00@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/21 9:20 AM, Jens Axboe wrote:
> On 11/2/21 9:08 AM, Ming Lei wrote:
>> On Tue, Nov 02, 2021 at 08:57:41AM -0600, Jens Axboe wrote:
>>> On 11/2/21 7:57 AM, Ming Lei wrote:
>>>> On Tue, Nov 02, 2021 at 07:47:44AM -0600, Jens Axboe wrote:
>>>>> On 11/2/21 7:35 AM, Ming Lei wrote:
>>>>>> In case of shared tags and none io sched, batched completion still may
>>>>>> be run into, and hctx->nr_active is accounted when getting driver tag,
>>>>>> so it has to be updated in blk_mq_end_request_batch().
>>>>>>
>>>>>> Otherwise, hctx->nr_active may become same with queue depth, then
>>>>>> hctx_may_queue() always return false, then io hang is caused.
>>>>>>
>>>>>> Fixes the issue by updating the counter in batched way.
>>>>>>
>>>>>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>>>> Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")
>>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>>> ---
>>>>>>  block/blk-mq.c | 15 +++++++++++++--
>>>>>>  block/blk-mq.h | 12 +++++++++---
>>>>>>  2 files changed, 22 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>>> index 07eb1412760b..0dbe75034f61 100644
>>>>>> --- a/block/blk-mq.c
>>>>>> +++ b/block/blk-mq.c
>>>>>> @@ -825,6 +825,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
>>>>>>  	struct blk_mq_hw_ctx *cur_hctx = NULL;
>>>>>>  	struct request *rq;
>>>>>>  	u64 now = 0;
>>>>>> +	int active = 0;
>>>>>>  
>>>>>>  	if (iob->need_ts)
>>>>>>  		now = ktime_get_ns();
>>>>>> @@ -846,16 +847,26 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
>>>>>>  		rq_qos_done(rq->q, rq);
>>>>>>  
>>>>>>  		if (nr_tags == TAG_COMP_BATCH || cur_hctx != rq->mq_hctx) {
>>>>>> -			if (cur_hctx)
>>>>>> +			if (cur_hctx) {
>>>>>> +				if (active)
>>>>>> +					__blk_mq_sub_active_requests(cur_hctx,
>>>>>> +							active);
>>>>>>  				blk_mq_flush_tag_batch(cur_hctx, tags, nr_tags);
>>>>>> +			}
>>>>>>  			nr_tags = 0;
>>>>>> +			active = 0;
>>>>>>  			cur_hctx = rq->mq_hctx;
>>>>>>  		}
>>>>>>  		tags[nr_tags++] = rq->tag;
>>>>>> +		if (rq->rq_flags & RQF_MQ_INFLIGHT)
>>>>>> +			active++;
>>>>>
>>>>> Are there any cases where either none or all of requests have the
>>>>> flag set, and hence active == nr_tags?
>>>>
>>>> none and BLK_MQ_F_TAG_QUEUE_SHARED, and Shinichiro only observed the
>>>> issue on two NSs.
>>>
>>> Maybe I wasn't clear enough. What I'm saying is that either all of the
>>> requests will have RQF_MQ_INFLIGHT set, or none of them. Hence active
>>> should be either 0, or == nr_tags.
>>
>> Yeah, that is right since BLK_MQ_F_TAG_QUEUE_SHARED is updated after
>> queue is frozen. Meantime blk_mq_end_request_batch() is only called
>> for ending successfully completed requests.
>>
>> Will do that in V2.
> 
> Thanks, then it just becomes a single check in blk_mq_flush_tag_batch(),
> which is a lot better than per-request.

Something like this, untested. FWIW, I did apply 1-2 from this series,
so just do a v2 of 3/3 and that should do it.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 02f70dc06ced..18dee9af4487 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -817,6 +817,8 @@ static inline void blk_mq_flush_tag_batch(struct blk_mq_hw_ctx *hctx,
 	struct request_queue *q = hctx->queue;
 
 	blk_mq_put_tags(hctx->tags, tag_array, nr_tags);
+	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+		__blk_mq_sub_active_requests(hctx, nr_tags);
 	percpu_ref_put_many(&q->q_usage_counter, nr_tags);
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 28859fc5faee..cb0b5482ca5e 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -225,12 +225,18 @@ static inline void __blk_mq_inc_active_requests(struct blk_mq_hw_ctx *hctx)
 		atomic_inc(&hctx->nr_active);
 }
 
-static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
+static inline void __blk_mq_sub_active_requests(struct blk_mq_hw_ctx *hctx,
+		int val)
 {
 	if (blk_mq_is_shared_tags(hctx->flags))
-		atomic_dec(&hctx->queue->nr_active_requests_shared_tags);
+		atomic_sub(val, &hctx->queue->nr_active_requests_shared_tags);
 	else
-		atomic_dec(&hctx->nr_active);
+		atomic_sub(val, &hctx->nr_active);
+}
+
+static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
+{
+	__blk_mq_sub_active_requests(hctx, 1);
 }
 
 static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)


-- 
Jens Axboe

