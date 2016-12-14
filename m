Subject: Re: [PATCH 5/7] blk-mq-sched: add framework for MQ capable IO
 schedulers
To: Bart Van Assche <bart.vanassche@sandisk.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-6-git-send-email-axboe@fb.com>
 <69c1261a-1a21-7347-c753-0bcb9a2ab65e@sandisk.com>
 <e4928ada-c1f5-32a0-bbc4-3a1f3c83dde9@fb.com>
 <cb5d74ae-6f27-a1c4-4e8b-93398f556b94@sandisk.com>
Cc: paolo.valente@linaro.org, osandov@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <decbb34b-1825-7fe8-4b02-446b364c2ccb@fb.com>
Date: Wed, 14 Dec 2016 08:05:12 -0700
MIME-Version: 1.0
In-Reply-To: <cb5d74ae-6f27-a1c4-4e8b-93398f556b94@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/14/2016 03:31 AM, Bart Van Assche wrote:
> On 12/13/2016 04:14 PM, Jens Axboe wrote:
>> On 12/13/2016 06:56 AM, Bart Van Assche wrote:
>>> On 12/08/2016 09:13 PM, Jens Axboe wrote:
>>>> +struct request *blk_mq_sched_alloc_shadow_request(struct request_queue *q,
>>>> +						  struct blk_mq_alloc_data *data,
>>>> +						  struct blk_mq_tags *tags,
>>>> +						  atomic_t *wait_index)
>>>> +{
>>>
>>> Using the word "shadow" in the function name suggests to me that there 
>>> is a shadow request for every request and a request for every shadow 
>>> request. However, my understanding from the code is that there can be 
>>> requests without shadow requests (for e.g. a flush) and shadow requests 
>>> without requests. Shouldn't the name of this function reflect that, e.g. 
>>> by using "sched" or "elv" in the function name instead of "shadow"?
>>
>> Shadow might not be the best name. Most do have shadows though, it's
>> only the rare exception like the flush, that you mention. I'll see if I
>> can come up with a better name.
> 
> Hello Jens,
> 
> One aspect of this patch series that might turn out to be a maintenance
> burden is the copying between original and shadow requests. It is easy
> to overlook that rq_copy() has to be updated if a field would ever be
> added to struct request. Additionally, having to allocate two requests
> structures per I/O instead of one will have a runtime overhead. Do you
> think the following approach would work?
> - Instead of using two request structures per I/O, only use a single
>   request structure.
> - Instead of storing one tag in the request structure, store two tags
>   in that structure. One tag comes from the I/O scheduler tag set
>   (size: nr_requests) and the other from the tag set associated with
>   the block driver (size: HBA queue depth).
> - Only add a request to the hctx dispatch list after a block driver tag
>   has been assigned. This means that an I/O scheduler must keep a
>   request structure on a list it manages itself as long as no block
>   driver tag has been assigned.
> - sysfs_list_show() is modified such that it shows both tags.

I have considered doing exactly that, decided to go down the other path.
I may still revisit, it's not that I'm a huge fan of the shadow requests
and the necessary copying. We don't update the request that often, so I
don't think it's going to be a big maintenance burden. But it'd be hard
to claim that it's super pretty...

I'll play with the idea.

-- 
Jens Axboe
