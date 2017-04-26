Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/4] blk-mq-sched: allow to use hw tag for sched
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@infradead.org>
References: <20170415123825.32716-1-ming.lei@redhat.com>
 <cafbd7d9-1027-5282-6f1a-48f7ccec3d45@fb.com>
 <20170420004410.GA16917@ming.t460p>
 <90e249d6-996c-a8d9-f54d-e8142082bfa5@fb.com>
 <20170420010346.GC16917@ming.t460p> <20170420045408.GB2235@infradead.org>
 <20170420083041.GA1637@ming.t460p> <20170426104842.GB28062@ming.t460p>
 <38bc590d-8ab4-5c88-d7e7-10cd2ec7d900@kernel.dk>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
 Jozef Mikovic <jmikovic@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <da795dd0-bba1-3a7a-5b24-696d51bcbc2e@kernel.dk>
Date: Wed, 26 Apr 2017 11:22:43 -0700
MIME-Version: 1.0
In-Reply-To: <38bc590d-8ab4-5c88-d7e7-10cd2ec7d900@kernel.dk>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/26/2017 11:15 AM, Jens Axboe wrote:
> On 04/26/2017 03:48 AM, Ming Lei wrote:
>> Hi Christoph,
>>
>> On Thu, Apr 20, 2017 at 04:30:42PM +0800, Ming Lei wrote:
>>> Hi Christoph,
>>>
>>> On Wed, Apr 19, 2017 at 09:54:08PM -0700, Christoph Hellwig wrote:
>>>> On Thu, Apr 20, 2017 at 09:03:47AM +0800, Ming Lei wrote:
>>>>> If we don't need to reserve tag for internal command, I am happy
>>>>> to fix it in the interim. However, the mtip32xx driver has to
>>>>> ask blk-mq to reserve the tag zero for internal command. Then
>>>>> if we can't allow the driver to use that reserved tag, it looks
>>>>> quite awkward, doesn't it?
>>>>
>>>> It doesn't.  Just offset the hardware tags by 1 from the blk-mq tags.
>>>>
>>>> But I'm pretty sure the hardware wouldn't require a specific tag
>>>> for the internal ops.
>>>
>>> From mtip32xx code, the tag 0 is used to send internal command only, and
>>> not used for submitting normal request.
>>>
>>> From code of mtip_issue_non_ncq_command() and mtip_issue_ncq_command(),
>>> even same hardware address is writen to when issuing non-ncq and ncq
>>> commands. So I think the internal ops and normal requests share one same
>>> tag space on mtip32xx.
>>>
>>> Could you explain it a bit why you think the hw doesn't need the tag
>>> for internal ops in this case?
>>
>> Gentle ping...
>>
>> Looks there are some choices for this issue:
>>
>> 1) if internal ops uses independent tag space
>> - we need to clean up the mtip32xx driver
>>
>> 2) if internal ops shares tag space with normal request
>> - export blk_mq_get_driver_tag() for mtip32xx
>>
>> or
>>
>> - use private way to send internal ops, and the drawback
>> is that we still need to reserve tag and the reserved tag
>> can't be used at all.
>>
>> From mtip32xx source code, I can see both share same tag space.
>> When I try to search hw manual via google, not succeed yet.
>>
>> Christoph, could you share us your findings about if internal ops
>> uses independent tag space or not?
> 
> Why aren't we just bypassing for RESERVED? If someone is asking
> for an reserved tag, ensure that we use the right tag pool (sched
> vs normal) and sub pool (reserved vs normal). Then insert just
> bypasses the scheduler, like it already does if we have a driver
> tag assigned already.
> 
> I've got a few of these cards, but traveling. I'll wire up something
> and test it end this week.

Something like this. Totally untested.

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c974a1bbf4cb..11109b5b64b6 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -119,7 +119,11 @@ struct request *blk_mq_sched_get_request(struct request_queue *q,
 	if (likely(!data->hctx))
 		data->hctx = blk_mq_map_queue(q, data->ctx->cpu);
 
-	if (e) {
+	/*
+	 * For a reserved tag, allocate a normal request since we might
+	 * have driver dependencies on the value of the internal tag.
+	 */
+	if (e && !(data->flags & BLK_MQ_REQ_RESERVED)) {
 		data->flags |= BLK_MQ_REQ_INTERNAL;
 
 		/*

-- 
Jens Axboe
