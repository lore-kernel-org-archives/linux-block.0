Subject: Re: [PATCH] queue stall with blk-mq-sched
To: Hannes Reinecke <hare@suse.de>
References: <aa1c23e1-1beb-a26d-3e77-fe78aa281771@suse.de>
 <762cb508-1de0-93e2-5643-3fe946428eb5@fb.com>
 <8abc2430-e1fd-bece-ad52-c6d1d482c1e0@suse.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <1663de5d-cdf7-a6ed-7539-c7d1f5e98f6c@fb.com>
Date: Tue, 24 Jan 2017 12:55:59 -0700
MIME-Version: 1.0
In-Reply-To: <8abc2430-e1fd-bece-ad52-c6d1d482c1e0@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 01/24/2017 11:49 AM, Hannes Reinecke wrote:
> On 01/24/2017 05:09 PM, Jens Axboe wrote:
>> On 01/24/2017 08:54 AM, Hannes Reinecke wrote:
>>> Hi Jens,
>>>
>>> I'm trying to debug a queue stall with your blk-mq-sched branch; with my
>>> latest mpt3sas patches fio stops basically directly after starting a
>>> sequential read :-(
>>>
>>> I've debugged things and came up with the attached patch; we need to
>>> restart waiters with blk_mq_tag_idle() after completing a tag.
>>> We're already calling blk_mq_tag_busy() when fetching a tag, so I think
>>> calling blk_mq_tag_idle() is required when retiring a tag.
>>
>> The patch isn't correct, the whole point of the un-idling is that it
>> ISN'T happening for every request completion. Otherwise you throw
>> away scalability. So a queue will go into active mode on the first
>> request, and idle when it's been idle for a bit. The active count
>> is used to divide up the tags.
>>
>> So I'm assuming we're missing a queue run somewhere when we fail
>> getting a driver tag. The latter should only happen if the target
>> has IO in flight already, and the restart marking should take care
>> of it. Obviously there's a case where that is not true, since you
>> are seeing stalls.
>>
> But what is the point in the 'blk_mq_tag_busy()' thingie then?
> When will it be reset?
> The only instances I've seen is that it'll be getting reset during 
> resize and teardown ... hence my patch.

The point is to have some count of how many queues are busy "lately",
which helps in dividing up the tags fairly. Hence we bump it as soon as
the queue goes active, and drop it after some delay. That's working as
expected.

>>> However, even with the attached patch I'm seeing some queue stalls;
>>> looks like they're related to the 'stonewall' statement in fio.
>>
>> I think you are heading down the wrong path. Your patch will cause
>> the symptoms to be a bit different, but you'll still run into cases
>> where we fail giving out the tag and then stall.
>>
> Hehe.
> How did you know that?

My crystal ball :-)

> That's indeed what I'm seeing.
> 
> Oh well, back to the drawing board...

Try this patch. We only want to bump it for the driver tags, not the
scheduler side.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index ee69e5e..c905aa1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -230,15 +230,15 @@ struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
 
 		rq = tags->static_rqs[tag];
 
-		if (blk_mq_tag_busy(data->hctx)) {
-			rq->rq_flags = RQF_MQ_INFLIGHT;
-			atomic_inc(&data->hctx->nr_active);
-		}
-
 		if (data->flags & BLK_MQ_REQ_INTERNAL) {
 			rq->tag = -1;
 			rq->internal_tag = tag;
 		} else {
+			if (blk_mq_tag_busy(data->hctx)) {
+				rq->rq_flags = RQF_MQ_INFLIGHT;
+				atomic_inc(&data->hctx->nr_active);
+			}
+
 			rq->tag = tag;
 			rq->internal_tag = -1;
 		}
@@ -870,6 +870,10 @@ static bool blk_mq_get_driver_tag(struct request *rq,
 	rq->tag = blk_mq_get_tag(&data);
 	if (rq->tag >= 0) {
 		data.hctx->tags->rqs[rq->tag] = rq;
+		if (blk_mq_tag_busy(data.hctx)) {
+			rq->rq_flags |= RQF_MQ_INFLIGHT;
+			atomic_inc(&data.hctx->nr_active);
+		}
 		goto done;
 	}
 

-- 
Jens Axboe
