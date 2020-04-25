Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32850C54FCB
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 18:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1025420714
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 18:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgDYS0c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 14:26:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:56834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgDYS0c (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 14:26:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1B307AC5F;
        Sat, 25 Apr 2020 18:26:29 +0000 (UTC)
Subject: Re: [PATCH V8 04/11] blk-mq: assign rq->tag in blk_mq_get_driver_tag
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-5-ming.lei@redhat.com>
 <ce0bfba3-41c0-db50-9705-2b1973a3f165@suse.de> <20200425025451.GA477579@T590>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <71edc498-f845-a14e-1dfe-575b6f609a57@suse.de>
Date:   Sat, 25 Apr 2020 20:26:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200425025451.GA477579@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/25/20 4:54 AM, Ming Lei wrote:
> On Fri, Apr 24, 2020 at 03:02:36PM +0200, Hannes Reinecke wrote:
>> On 4/24/20 12:23 PM, Ming Lei wrote:
>>> Especially for none elevator, rq->tag is assigned after the request is
>>> allocated, so there isn't any way to figure out if one request is in
>>> being dispatched. Also the code path wrt. driver tag becomes a bit
>>> difference between none and io scheduler.
>>>
>>> When one hctx becomes inactive, we have to prevent any request from
>>> being dispatched to LLD. And get driver tag provides one perfect chance
>>> to do that. Meantime we can drain any such requests by checking if
>>> rq->tag is assigned.
>>>
>>
>> Sorry for being a bit dense, but I'm having a hard time following the
>> description.
>> Maybe this would be a bit clearer:
>>
>> When one hctx becomes inactive, we do have to prevent any request from
>> being dispatched to the LLD. If we intercept them in blk_mq_get_tag() we can
>> also drain all those requests which have no rq->tag assigned.
> 
> No, actually what we need to drain is requests with rq->tag assigned, and
> if tag isn't assigned, we can simply prevent the request from being
> queued to LLD after the hctx becomes inactive.
> 
> Frankly speaking, the description in commit log should be more clear,
> and correct.
> 
Ah. Thanks for the explanation.


>>
>> (With the nice side effect that if above paragraph is correct I've also got
>> it right what the patch is trying to do :-)
>>
>>> So only assign rq->tag until blk_mq_get_driver_tag() is called.
>>>
>>> This way also simplifies code of dealing with driver tag a lot.
>>>
>>> Cc: Bart Van Assche <bvanassche@acm.org>
>>> Cc: Hannes Reinecke <hare@suse.com>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: John Garry <john.garry@huawei.com>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    block/blk-flush.c | 18 ++----------
>>>    block/blk-mq.c    | 75 ++++++++++++++++++++++++-----------------------
>>>    block/blk-mq.h    | 21 +++++++------
>>>    block/blk.h       |  5 ----
>>>    4 files changed, 51 insertions(+), 68 deletions(-)
>>>
>>> diff --git a/block/blk-flush.c b/block/blk-flush.c
>>> index c7f396e3d5e2..977edf95d711 100644
>>> --- a/block/blk-flush.c
>>> +++ b/block/blk-flush.c
>>> @@ -236,13 +236,8 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>>>    		error = fq->rq_status;
>>>    	hctx = flush_rq->mq_hctx;
>>> -	if (!q->elevator) {
>>> -		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
>>> -		flush_rq->tag = -1;
>>> -	} else {
>>> -		blk_mq_put_driver_tag(flush_rq);
>>> -		flush_rq->internal_tag = -1;
>>> -	}
>>> +	flush_rq->internal_tag = -1;
>>> +	blk_mq_put_driver_tag(flush_rq);
>>>    	running = &fq->flush_queue[fq->flush_running_idx];
>>>    	BUG_ON(fq->flush_pending_idx == fq->flush_running_idx);
>>> @@ -317,14 +312,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
>>>    	flush_rq->mq_ctx = first_rq->mq_ctx;
>>>    	flush_rq->mq_hctx = first_rq->mq_hctx;
>>> -	if (!q->elevator) {
>>> -		fq->orig_rq = first_rq;
>>> -		flush_rq->tag = first_rq->tag;
>>> -		blk_mq_tag_set_rq(flush_rq->mq_hctx, first_rq->tag, flush_rq);
>>> -	} else {
>>> -		flush_rq->internal_tag = first_rq->internal_tag;
>>> -	}
>>> -
>>> +	flush_rq->internal_tag = first_rq->internal_tag;
>>>    	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
>>>    	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
>>>    	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 79267f2e8960..65f0aaed55ff 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -276,18 +276,8 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>>>    	struct request *rq = tags->static_rqs[tag];
>>>    	req_flags_t rq_flags = 0;
>>> -	if (data->flags & BLK_MQ_REQ_INTERNAL) {
>>> -		rq->tag = -1;
>>> -		rq->internal_tag = tag;
>>> -	} else {
>>> -		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
>>> -			rq_flags = RQF_MQ_INFLIGHT;
>>> -			atomic_inc(&data->hctx->nr_active);
>>> -		}
>>> -		rq->tag = tag;
>>> -		rq->internal_tag = -1;
>>> -		data->hctx->tags->rqs[rq->tag] = rq;
>>> -	}
>>> +	rq->internal_tag = tag;
>>> +	rq->tag = -1;
>>>    	/* csd/requeue_work/fifo_time is initialized before use */
>>>    	rq->q = data->q;
>>> @@ -472,14 +462,18 @@ static void __blk_mq_free_request(struct request *rq)
>>>    	struct request_queue *q = rq->q;
>>>    	struct blk_mq_ctx *ctx = rq->mq_ctx;
>>>    	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>>> -	const int sched_tag = rq->internal_tag;
>>>    	blk_pm_mark_last_busy(rq);
>>>    	rq->mq_hctx = NULL;
>>> -	if (rq->tag != -1)
>>> -		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
>>> -	if (sched_tag != -1)
>>> -		blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
>>> +
>>> +	if (hctx->sched_tags) {
>>> +		if (rq->tag >= 0)
>>> +			blk_mq_put_tag(hctx->tags, ctx, rq->tag);
>>> +		blk_mq_put_tag(hctx->sched_tags, ctx, rq->internal_tag);
>>> +	} else {
>>> +		blk_mq_put_tag(hctx->tags, ctx, rq->internal_tag);
>>> +        }
>>> +
>>>    	blk_mq_sched_restart(hctx);
>>>    	blk_queue_exit(q);
>>>    }
>>> @@ -527,7 +521,7 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
>>>    		blk_stat_add(rq, now);
>>>    	}
>>> -	if (rq->internal_tag != -1)
>>> +	if (rq->q->elevator && rq->internal_tag != -1)
>>>    		blk_mq_sched_completed_request(rq, now);
>>>    	blk_account_io_done(rq, now);
>>
>> One really does wonder: under which circumstances can 'internal_tag' be -1
>> now ?
>> The hunk above seems to imply that 'internal_tag' is now always be set; and
>> this is also the impression I got from reading this patch.
>> Care to elaborate?
> 
> rq->internal_tag should always be assigned, and the only case is that it can
> become -1 for flush rq, however it is done in .end_io(), so we may avoid
> the above check on rq->internal_tag.
> 
Thought so.

>>
>>> @@ -1027,33 +1021,40 @@ static inline unsigned int queued_to_index(unsigned int queued)
>>>    	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
>>>    }
>>> -static bool blk_mq_get_driver_tag(struct request *rq)
>>> +static bool __blk_mq_get_driver_tag(struct request *rq)
>>>    {
>>>    	struct blk_mq_alloc_data data = {
>>> -		.q = rq->q,
>>> -		.hctx = rq->mq_hctx,
>>> -		.flags = BLK_MQ_REQ_NOWAIT,
>>> -		.cmd_flags = rq->cmd_flags,
>>> +		.q		= rq->q,
>>> +		.hctx		= rq->mq_hctx,
>>> +		.flags		= BLK_MQ_REQ_NOWAIT,
>>> +		.cmd_flags	= rq->cmd_flags,
>>>    	};
>>> -	bool shared;
>>> -	if (rq->tag != -1)
>>> -		return true;
>>> +	if (data.hctx->sched_tags) {
>>> +		if (blk_mq_tag_is_reserved(data.hctx->sched_tags,
>>> +				rq->internal_tag))
>>> +			data.flags |= BLK_MQ_REQ_RESERVED;
>>> +		rq->tag = blk_mq_get_tag(&data);
>>> +	} else {
>>> +		rq->tag = rq->internal_tag;
>>> +	}
>>> -	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
>>> -		data.flags |= BLK_MQ_REQ_RESERVED;
>>> +	if (rq->tag == -1)
>>> +		return false;
>>> -	shared = blk_mq_tag_busy(data.hctx);
>>> -	rq->tag = blk_mq_get_tag(&data);
>>> -	if (rq->tag >= 0) {
>>> -		if (shared) {
>>> -			rq->rq_flags |= RQF_MQ_INFLIGHT;
>>> -			atomic_inc(&data.hctx->nr_active);
>>> -		}
>>> -		data.hctx->tags->rqs[rq->tag] = rq;
>>> +	if (blk_mq_tag_busy(data.hctx)) {
>>> +		rq->rq_flags |= RQF_MQ_INFLIGHT;
>>> +		atomic_inc(&data.hctx->nr_active);
>>>    	}
>>> +	data.hctx->tags->rqs[rq->tag] = rq;
>>> +	return true;
>>> +}
>>> -	return rq->tag != -1;
>>> +static bool blk_mq_get_driver_tag(struct request *rq)
>>> +{
>>> +	if (rq->tag != -1)
>>> +		return true;
>>> +	return __blk_mq_get_driver_tag(rq);
>>>    }
>>>    static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
>>> diff --git a/block/blk-mq.h b/block/blk-mq.h
>>> index e7d1da4b1f73..d0c72d7d07c8 100644
>>> --- a/block/blk-mq.h
>>> +++ b/block/blk-mq.h
>>> @@ -196,26 +196,25 @@ static inline bool blk_mq_get_dispatch_budget(struct blk_mq_hw_ctx *hctx)
>>>    	return true;
>>>    }
>>> -static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
>>> -					   struct request *rq)
>>> +static inline void blk_mq_put_driver_tag(struct request *rq)
>>>    {
>>> -	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
>>> +	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>>> +	int tag = rq->tag;
>>> +
>>> +	if (tag < 0)
>>> +		return;
>>> +
>>>    	rq->tag = -1;
>>>     > +	if (hctx->sched_tags)
>>> +		blk_mq_put_tag(hctx->tags, rq->mq_ctx, tag);
>>> +
>> I wonder if you need the local variable 'tag' here; might it not be better
>> to set 'rq->tag' to '-1' after the call to put_tag?
> 
> No, we can't touch the request after blk_mq_put_tag() returns.
> 
> I remember we have fixed such kind of UAF several times.
> 
Ah, right, of course.

FWIW:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
