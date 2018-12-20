Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE79DC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 18:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0E2218E2
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 18:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PFPWPzl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389126AbeLTSdf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:33:35 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:53496 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbeLTSdf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 13:33:35 -0500
Received: by mail-it1-f173.google.com with SMTP id g85so3454877ita.3
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 10:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4WMb9nvMIy3++lZ7LeQqPkjFuqgDyq3y5ex1HOmFMYM=;
        b=PFPWPzl0s9mH+5EjZ5Gw7wTga6NhF0M3Uwvx6kbcXh0UkXBuretKdxPk5E24MUUEON
         3u5UaU/ai39m4fXl/8XR2WMgJGizBy8AAGD5m7GxPSo1kkb3DVTxx/l4xqoaygVQ6iXD
         2q5mMDuXZC/Cp1gbS/d5W703G6AwfJf/dyewlPJDA1OM47vjbbWbGDn8w9cpRNIGVHFY
         AjiuNcexxJJmlbZdhaAp5M4XZcqdlOrAkqcPftrMvfaZd/uvwGQGXdpV+nxJZnpSiTdm
         ui1xh9tDaOMKIwegXzEA3VzqPBf8gHKvfxtjtMP1Ep8Go0365EdrVt2n4I+vSR2CXpVV
         Ienw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4WMb9nvMIy3++lZ7LeQqPkjFuqgDyq3y5ex1HOmFMYM=;
        b=UwZm5NCVVKhM5xizWe2zj41hy7Q6DT9MEBM649TpewGKxLL+HIBfGLq2ETJCIpAevN
         51xUlzUJtSXWFR0XPi2B+5q6DyM6HVBU8nJlb6r9aYNhYH0xrmJG8EBW8Uy27K2OQhg1
         duou/0drXJvBPzYX7qR+/OE/88g2sYWGql/+jgbt70nwbe4nmYRxTtxwF+B4yECs8aHb
         euXd4F+QiQItYSvBpY/Th90IqWR58QciW11VZBiq7gVtng4ewqoPTDL29ZWetjpW9KDQ
         y86fmsg/kUcmfq/MeiR9j/1uNfZkbQk1t4WSlBZssDG8vJeggdPi4cgiPtljIlFzqrud
         eAiA==
X-Gm-Message-State: AA+aEWYyDinuyEum40/ISbQED1qwdIEInmvOsIxWcBSH3vu7w5Uk70C3
        RbIIO1OmRMzMlrUbtxV7a/n+L+yVf0Xcog==
X-Google-Smtp-Source: AFSGD/WujdfVnKB3lBjHGqce1WkF5ps8QrwBIqlrI/jf6SisNoI2pU9yvhDTCGgxE+jhM3/ugrUmkw==
X-Received: by 2002:a24:5c90:: with SMTP id q138mr9933608itb.32.1545330813174;
        Thu, 20 Dec 2018 10:33:33 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id a16sm9760146ioh.48.2018.12.20.10.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 10:33:32 -0800 (PST)
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1545261885.185366.488.camel@acm.org>
 <74c0280c-e557-ad03-cd75-98dd6d868da3@kernel.dk>
 <1545265001.185366.496.camel@acm.org>
 <1ca5cd37-87ce-8cff-6cb4-1fdb29bd4da2@kernel.dk>
 <0560802f-efc0-e9ec-99f7-4bdbdbc234f8@oracle.com>
 <c078750c-ff6b-4939-281b-7556d31dc74d@kernel.dk>
 <fe9dfe60-3cfc-9cfa-56c3-1365cbe8ec53@oracle.com>
 <a45c9931-ce8b-0ac8-f304-412c6042eff9@kernel.dk>
 <372d2960-ff0c-1135-28f9-23eea8670463@oracle.com>
 <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
 <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk>
 <1545328865.185366.508.camel@acm.org>
 <bd78b521-d0d4-22ec-ff7f-2d70709ca742@kernel.dk>
Message-ID: <b9c3bd7c-9e82-7300-d525-0bd72ed66f66@kernel.dk>
Date:   Thu, 20 Dec 2018 11:33:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bd78b521-d0d4-22ec-ff7f-2d70709ca742@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/18 11:21 AM, Jens Axboe wrote:
> On 12/20/18 11:01 AM, Bart Van Assche wrote:
>> On Thu, 2018-12-20 at 06:07 -0700, Jens Axboe wrote:
>>> On 12/20/18 6:02 AM, Jens Axboe wrote:
>>>>> I'm afraid this cannot work.
>>>>>
>>>>> The 'tags' here could be the hctx->sched_tags, but what we need to
>>>>> clear is hctx->tags->rqs[].
>>>>
>>>> You are right, of course, a bit too quick on the trigger. This one
>>>> should work better, and also avoids that silly quadratic loop. I don't
>>>> think we need the tag == -1 check, but probably best to be safe.
>>>
>>> Sent out the wrong one, here it is. Bart, if you can reproduce, can you
>>> give it a whirl?
>>>
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 2de972857496..fc04bb648f18 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -2025,7 +2025,7 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>>>  {
>>>  	struct page *page;
>>>  
>>> -	if (tags->rqs && set->ops->exit_request) {
>>> +	if (tags->rqs) {
>>>  		int i;
>>>  
>>>  		for (i = 0; i < tags->nr_tags; i++) {
>>> @@ -2033,8 +2033,14 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>>>  
>>>  			if (!rq)
>>>  				continue;
>>> -			set->ops->exit_request(set, rq, hctx_idx);
>>> +			if (set->ops->exit_request)
>>> +				set->ops->exit_request(set, rq, hctx_idx);
>>>  			tags->static_rqs[i] = NULL;
>>> +
>>> +			if (rq->tag == -1)
>>> +				continue;
>>> +			if (set->tags[hctx_idx]->rqs[rq->tag] == rq)
>>> +				set->tags[hctx_idx]->rqs[rq->tag] = NULL;
>>>  		}
>>>  	}
>>>  
>>> @@ -2113,6 +2119,7 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
>>>  			return ret;
>>>  	}
>>>  
>>> +	rq->tag = -1;
>>>  	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
>>>  	return 0;
>>>  }
>>
>> Hi Jens,
>>
>> Are you sure this is sufficient?
> 
> No, I don't think it is.
> 
>> My understanding is that
>> blk_mq_queue_tag_busy_iter() iterates over all tags in the tag set. So if the
>> request queue on which part_in_flight() is called and the request queue for
>> which blk_mq_free_rqs() is called share their tag set then part_in_flight()
>> and blk_mq_free_rqs() can run concurrently. That can cause ugly race
>> conditions. Do you think it would be a good idea to modify the inflight
>> accounting code such that it only considers the requests of a single request
>> queue instead of all requests for a given tag set?
> 
> That would of course solve it, the question is how to do it. One option
> would be to have ->rqs[] be:
> 
> struct rq_entry {
> 	struct request_queue *q;
> 	struct request *rq;
> };
> 
> instead of just a request, since then you could check the queue without
> having to dereference the request. The current race is inherent in that
> we set ->rqs[] AFTER having acquired the tag, so there's a window where
> you could find a stale entry. That's not normally an issue since
> requests are persistent, but for shared tag maps and queues disappearing
> it can pose a problem.

Something like this, totally untested. If the queue matches, we know it's
safe to dereference it.

A safer API to export as well...


diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2089c6c62f44..78192b544fa2 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -228,13 +228,15 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
-	rq = tags->rqs[bitnr];
+	if (tags->rqs[bitnr].queue != hctx->queue)
+		return true;
 
 	/*
 	 * We can hit rq == NULL here, because the tagging functions
 	 * test and set the bit before assigning ->rqs[].
 	 */
-	if (rq && rq->q == hctx->queue)
+	rq = tags->rqs[bitnr].rq;
+	if (rq)
 		return iter_data->fn(hctx, rq, iter_data->data, reserved);
 	return true;
 }
@@ -268,6 +270,7 @@ static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
 
 struct bt_tags_iter_data {
 	struct blk_mq_tags *tags;
+	struct blk_mq_hw_ctx *hctx;
 	busy_tag_iter_fn *fn;
 	void *data;
 	bool reserved;
@@ -287,7 +290,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * We can hit rq == NULL here, because the tagging functions
 	 * test and set the bit before assining ->rqs[].
 	 */
-	rq = tags->rqs[bitnr];
+	rq = tags->rqs[bitnr].rq;
 	if (rq && blk_mq_request_started(rq))
 		return iter_data->fn(rq, iter_data->data, reserved);
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0b5a5a..bb84d1f099c7 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -4,6 +4,11 @@
 
 #include "blk-mq.h"
 
+struct rq_tag_entry {
+	struct request_queue *queue;
+	struct request *rq;
+};
+
 /*
  * Tag address space map.
  */
@@ -16,7 +21,7 @@ struct blk_mq_tags {
 	struct sbitmap_queue bitmap_tags;
 	struct sbitmap_queue breserved_tags;
 
-	struct request **rqs;
+	struct rq_tag_entry *rqs;
 	struct request **static_rqs;
 	struct list_head page_list;
 };
@@ -78,7 +83,8 @@ static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 static inline void blk_mq_tag_set_rq(struct blk_mq_hw_ctx *hctx,
 		unsigned int tag, struct request *rq)
 {
-	hctx->tags->rqs[tag] = rq;
+	hctx->tags->rqs[tag].queue = hctx->queue;
+	hctx->tags->rqs[tag].rq = rq;
 }
 
 static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ba37b9e15e9..4f194946dbd9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -298,13 +298,16 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		rq->tag = -1;
 		rq->internal_tag = tag;
 	} else {
-		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
+		struct blk_mq_hw_ctx *hctx = data->hctx;
+
+		if (hctx->flags & BLK_MQ_F_TAG_SHARED) {
 			rq_flags = RQF_MQ_INFLIGHT;
-			atomic_inc(&data->hctx->nr_active);
+			atomic_inc(&hctx->nr_active);
 		}
 		rq->tag = tag;
 		rq->internal_tag = -1;
-		data->hctx->tags->rqs[rq->tag] = rq;
+		hctx->tags->rqs[rq->tag].queue = hctx->queue;
+		hctx->tags->rqs[rq->tag].rq = rq;
 	}
 
 	/* csd/requeue_work/fifo_time is initialized before use */
@@ -797,8 +800,8 @@ EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 {
 	if (tag < tags->nr_tags) {
-		prefetch(tags->rqs[tag]);
-		return tags->rqs[tag];
+		prefetch(tags->rqs[tag].rq);
+		return tags->rqs[tag].rq;
 	}
 
 	return NULL;
@@ -809,10 +812,11 @@ static bool blk_mq_rq_inflight(struct blk_mq_hw_ctx *hctx, struct request *rq,
 			       void *priv, bool reserved)
 {
 	/*
-	 * If we find a request that is inflight and the queue matches,
-	 * we know the queue is busy. Return false to stop the iteration.
+	 * We're only called here if the queue matches. If the rq state is
+	 * inflight, we know the queue is busy. Return false to stop the
+	 * iteration.
 	 */
-	if (rq->state == MQ_RQ_IN_FLIGHT && rq->q == hctx->queue) {
+	if (rq->state == MQ_RQ_IN_FLIGHT) {
 		bool *busy = priv;
 
 		*busy = true;
@@ -1049,11 +1053,14 @@ bool blk_mq_get_driver_tag(struct request *rq)
 	shared = blk_mq_tag_busy(data.hctx);
 	rq->tag = blk_mq_get_tag(&data);
 	if (rq->tag >= 0) {
+		struct blk_mq_hw_ctx *hctx = data.hctx;
+
 		if (shared) {
 			rq->rq_flags |= RQF_MQ_INFLIGHT;
 			atomic_inc(&data.hctx->nr_active);
 		}
-		data.hctx->tags->rqs[rq->tag] = rq;
+		hctx->tags->rqs[rq->tag].queue = hctx->queue;
+		hctx->tags->rqs[rq->tag].rq = rq;
 	}
 
 done:
@@ -2069,7 +2076,7 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 	if (!tags)
 		return NULL;
 
-	tags->rqs = kcalloc_node(nr_tags, sizeof(struct request *),
+	tags->rqs = kcalloc_node(nr_tags, sizeof(struct rq_tag_entry),
 				 GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
 				 node);
 	if (!tags->rqs) {

-- 
Jens Axboe

