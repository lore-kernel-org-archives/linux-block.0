Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] block: Polling completion performance optimization
To: Scott Bauer <sbauer@eng.utah.edu>, Keith Busch <keith.busch@intel.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-4-keith.busch@intel.com>
 <40f03ddc-1f7e-8221-ccb0-d8d311d02870@eng.utah.edu>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ce880fba-0663-5b6a-5574-e59914a6af83@kernel.dk>
Date: Thu, 21 Dec 2017 14:00:04 -0700
MIME-Version: 1.0
In-Reply-To: <40f03ddc-1f7e-8221-ccb0-d8d311d02870@eng.utah.edu>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/21/17 1:56 PM, Scott Bauer wrote:
> 
> 
> On 12/21/2017 01:46 PM, Keith Busch wrote:
>> When a request completion is polled, the completion task wakes itself
>> up. This is unnecessary, as the task can just set itself back to
>> running.
>>
>> Signed-off-by: Keith Busch <keith.busch@intel.com>
>> ---
>>  fs/block_dev.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 4a181fcb5175..ce67ffe73430 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -181,7 +181,10 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
>>  	struct task_struct *waiter = bio->bi_private;
>>  
>>  	WRITE_ONCE(bio->bi_private, NULL);
>> -	wake_up_process(waiter);
>> +	if (current != waiter)
>> +		wake_up_process(waiter);
>> +	else
>> +		__set_current_state(TASK_RUNNING);
> 
> Do we actually need to set this to TASK_RUNNING? If we get here we're already running, right?
> 
> Everywhere I see uses of __set_current_state(TASK_RUNNING) it's after we've done a set_current_state(TASK_INTERRUPTIBLE).

We'd only be TASK_RUNNING if the IRQ got to it first. And that's something that
should be removed as well - I suspect that'd be a much bigger win, getting rid
of the IRQ trigger for polled IO, than most of the micro optimizations. For
Keith's testing, looks like he reduced the cost by turning on coalescing, but
it'd be cheaper (and better) to not have to rely on that.

In any case, the __set_current_state() is very cheap. Given that and the
above, I'd rather keep that.

-- 
Jens Axboe
