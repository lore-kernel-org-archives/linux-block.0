Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: put the driver tag of nxt rq before first one is
 requeued
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1505236475-9209-1-git-send-email-jianchao.w.wang@oracle.com>
 <20170912102302.GC15792@ming.t460p>
 <23b700aa-ed37-1081-d980-4073804f293b@oracle.com>
 <20170913012452.GA24642@ming.t460p>
 <4b7dcb10-9ec5-9a00-8d16-009e83ef7b5b@oracle.com>
 <ccda7d87-a0b9-8292-3cb7-8edcca9c7f69@kernel.dk>
 <96a21c69-cf79-58a2-2c71-2e440abf9b36@oracle.com>
 <6327de01-0bf4-7e79-59ad-f6489378bfd5@kernel.dk>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <aebfc622-6d7d-0d07-5a13-8dae06a49bb7@oracle.com>
Date: Wed, 13 Sep 2017 11:39:16 +0800
MIME-Version: 1.0
In-Reply-To: <6327de01-0bf4-7e79-59ad-f6489378bfd5@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 09/13/2017 10:45 AM, Jens Axboe wrote:
>>>>>>>> @@ -1029,14 +1029,20 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
>>>>>>>>  		if (list_empty(list))
>>>>>>>>  			bd.last = true;
>>>>>>>>  		else {
>>>>>>>> -			struct request *nxt;
>>>>>>>> -
>>>>>>>>  			nxt = list_first_entry(list, struct request, queuelist);
>>>>>>>>  			bd.last = !blk_mq_get_driver_tag(nxt, NULL, false);
>>>>>>>>  		}
>>>>>>>>  
>>>>>>>>  		ret = q->mq_ops->queue_rq(hctx, &bd);
>>>>>>>>  		if (ret == BLK_STS_RESOURCE) {
>>>>>>>> +			/*
>>>>>>>> +			 * If an I/O scheduler has been configured and we got a
>>>>>>>> +			 * driver tag for the next request already, free it again.
>>>>>>>> +			 */
>>>>>>>> +			if (!list_empty(list)) {
>>>>>>>> +				nxt = list_first_entry(list, struct request, queuelist);
>>>>>>>> +				blk_mq_put_driver_tag(nxt);
>>>>>>>> +			}
>>>>>>> The following way might be more simple and clean:
>>>>>>>
>>>>>>> 			if (nxt)
>>>>>>> 				blk_mq_put_driver_tag(nxt);
>>>>>>>
>>>>>>> meantime 'nxt' need to be cleared inside the 'if (list_empty(list))'
>>>>>>> before .queue_rq().
>>>>>> I had ever thought about that, but to avoid add extra command in the 
>>>>>> fast path, I made the patch above.
>>>>> Got it, so how about changing to the following way simply:
>>>>>
>>>>>  			if (nxt && !list_empty(list))
>>>>>  				blk_mq_put_driver_tag(nxt);
>>>>>
>>>> It seems that we even could change it as following:
>>>>                         if (!list_empty(list))
>>>>   				blk_mq_put_driver_tag(nxt);
>>> This is starting to get too clever for its own good, I generally don't
>>> like to sacrifice readability for performance. In reality, the compiler
>>> probably figures it out anyway...
>>>
>>> So either make it explicit, or add a nice comment as to why it is the
>>> way that it is.
>>>
>> yes, it indeed leads to compiler warning of "may be used uninitialized"
>> maybe the original one could be taken back.
>> 			if (!list_empty(list)) {
>> 				nxt = list_first_entry(list, struct request, queuelist);
>> 				blk_mq_put_driver_tag(nxt);
>> 			}
>> It is more readable and could avoid the warning.
> Exactly, and especially the readability is the key element here. It's
> just not worth it to try and be too clever, especially not for something
> like this. When you read the above, you immediately know what the code
> does without needing a comment. That's not true for the other construct.
> You both have to read other parts of the function to figure out what it
> does, AND read the entire function to ensure it always does the right
> thing. Fragile.

Thanks for your comments , jens and ming. I＇m really appreciative of that.
About the fragility, do you mean the possibility that may release the tag of the next rq
which has a driver tag itself (maybe a flush) ?

Thanks
jianchao
