Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: put the driver tag of nxt rq before first one is
 requeued
To: "jianchao.wang" <jianchao.w.wang@oracle.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1505236475-9209-1-git-send-email-jianchao.w.wang@oracle.com>
 <20170912102302.GC15792@ming.t460p>
 <23b700aa-ed37-1081-d980-4073804f293b@oracle.com>
 <20170913012452.GA24642@ming.t460p>
 <4b7dcb10-9ec5-9a00-8d16-009e83ef7b5b@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ccda7d87-a0b9-8292-3cb7-8edcca9c7f69@kernel.dk>
Date: Tue, 12 Sep 2017 20:23:02 -0600
MIME-Version: 1.0
In-Reply-To: <4b7dcb10-9ec5-9a00-8d16-009e83ef7b5b@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/12/2017 07:39 PM, jianchao.wang wrote:
> 
> 
> On 09/13/2017 09:24 AM, Ming Lei wrote:
>> On Wed, Sep 13, 2017 at 09:01:25AM +0800, jianchao.wang wrote:
>>> Hi ming
>>>
>>> On 09/12/2017 06:23 PM, Ming Lei wrote:
>>>>> @@ -1029,14 +1029,20 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
>>>>>  		if (list_empty(list))
>>>>>  			bd.last = true;
>>>>>  		else {
>>>>> -			struct request *nxt;
>>>>> -
>>>>>  			nxt = list_first_entry(list, struct request, queuelist);
>>>>>  			bd.last = !blk_mq_get_driver_tag(nxt, NULL, false);
>>>>>  		}
>>>>>  
>>>>>  		ret = q->mq_ops->queue_rq(hctx, &bd);
>>>>>  		if (ret == BLK_STS_RESOURCE) {
>>>>> +			/*
>>>>> +			 * If an I/O scheduler has been configured and we got a
>>>>> +			 * driver tag for the next request already, free it again.
>>>>> +			 */
>>>>> +			if (!list_empty(list)) {
>>>>> +				nxt = list_first_entry(list, struct request, queuelist);
>>>>> +				blk_mq_put_driver_tag(nxt);
>>>>> +			}
>>>> The following way might be more simple and clean:
>>>>
>>>> 			if (nxt)
>>>> 				blk_mq_put_driver_tag(nxt);
>>>>
>>>> meantime 'nxt' need to be cleared inside the 'if (list_empty(list))'
>>>> before .queue_rq().
>>>
>>> I had ever thought about that, but to avoid add extra command in the 
>>> fast path, I made the patch above.
>>
>> Got it, so how about changing to the following way simply:
>>
>>  			if (nxt && !list_empty(list))
>>  				blk_mq_put_driver_tag(nxt);
>>
> It seems that we even could change it as following:
>                         if (!list_empty(list))
>   				blk_mq_put_driver_tag(nxt);

This is starting to get too clever for its own good, I generally don't
like to sacrifice readability for performance. In reality, the compiler
probably figures it out anyway...

So either make it explicit, or add a nice comment as to why it is the
way that it is.

-- 
Jens Axboe
