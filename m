Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] block: Polling completion performance optimization
To: Keith Busch <keith.busch@intel.com>
Cc: Scott Bauer <sbauer@eng.utah.edu>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-4-keith.busch@intel.com>
 <40f03ddc-1f7e-8221-ccb0-d8d311d02870@eng.utah.edu>
 <ce880fba-0663-5b6a-5574-e59914a6af83@kernel.dk>
 <20171221213400.GB2975@localhost.localdomain>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5d3f06bf-8cb8-048d-30c5-9af611ad9ee7@kernel.dk>
Date: Thu, 21 Dec 2017 15:17:41 -0700
MIME-Version: 1.0
In-Reply-To: <20171221213400.GB2975@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/21/17 2:34 PM, Keith Busch wrote:
> On Thu, Dec 21, 2017 at 02:00:04PM -0700, Jens Axboe wrote:
>> On 12/21/17 1:56 PM, Scott Bauer wrote:
>>> On 12/21/2017 01:46 PM, Keith Busch wrote:
>>>> @@ -181,7 +181,10 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
>>>>  	struct task_struct *waiter = bio->bi_private;
>>>>  
>>>>  	WRITE_ONCE(bio->bi_private, NULL);
>>>> -	wake_up_process(waiter);
>>>> +	if (current != waiter)
>>>> +		wake_up_process(waiter);
>>>> +	else
>>>> +		__set_current_state(TASK_RUNNING);
>>>
>>> Do we actually need to set this to TASK_RUNNING? If we get here we're already running, right?
>>>
>>> Everywhere I see uses of __set_current_state(TASK_RUNNING) it's after we've done a set_current_state(TASK_INTERRUPTIBLE).
>>
>> We'd only be TASK_RUNNING if the IRQ got to it first. And that's something that
>> should be removed as well - I suspect that'd be a much bigger win, getting rid
>> of the IRQ trigger for polled IO, than most of the micro optimizations. For
>> Keith's testing, looks like he reduced the cost by turning on coalescing, but
>> it'd be cheaper (and better) to not have to rely on that.
> 
> It would be nice, but the driver doesn't know a request's completion
> is going to be a polled. 

That's trivially solvable though, since the information is available
at submission time.

> Even if it did, we don't have a spec defined
> way to tell the controller not to send an interrupt with this command's
> compeletion, which would be negated anyway if any interrupt driven IO
> is mixed in the same queue. We could possibly create a special queue
> with interrupts disabled for this purpose if we can pass the HIPRI hint
> through the request.

There's on way to do it per IO, right. But you can create a sq/cq pair
without interrupts enabled. This would also allow you to scale better
with multiple users of polling, a case where we currently don't
perform as well spdk, for instance.

-- 
Jens Axboe
