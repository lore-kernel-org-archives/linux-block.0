Subject: Re: [PATCH 3/4] blk-mq: implement hybrid poll mode for sync O_DIRECT
To: Bart Van Assche <bart.vanassche@sandisk.com>, axboe@kernel.dk,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <1478034325-28232-1-git-send-email-axboe@fb.com>
 <1478034325-28232-4-git-send-email-axboe@fb.com>
 <1be37430-c75a-308b-04b7-9779a9fe3f56@sandisk.com>
Cc: hch@lst.de
From: Jens Axboe <axboe@fb.com>
Message-ID: <1d9faee0-4de8-f10d-34fa-9022d24f7008@fb.com>
Date: Thu, 3 Nov 2016 08:15:46 -0600
MIME-Version: 1.0
In-Reply-To: <1be37430-c75a-308b-04b7-9779a9fe3f56@sandisk.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/03/2016 08:01 AM, Bart Van Assche wrote:
> On 11/01/2016 03:05 PM, Jens Axboe wrote:
>> +static void blk_mq_poll_hybrid_sleep(struct request_queue *q,
>> +                     struct request *rq)
>> +{
>> +    struct hrtimer_sleeper hs;
>> +    ktime_t kt;
>> +
>> +    if (!q->poll_nsec || test_bit(REQ_ATOM_POLL_SLEPT,
>> &rq->atomic_flags))
>> +        return;
>> +
>> +    set_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
>> +
>> +    /*
>> +     * This will be replaced with the stats tracking code, using
>> +     * 'avg_completion_time / 2' as the pre-sleep target.
>> +     */
>> +    kt = ktime_set(0, q->poll_nsec);
>> +
>> +    hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +    hrtimer_set_expires(&hs.timer, kt);
>> +
>> +    hrtimer_init_sleeper(&hs, current);
>> +    do {
>> +        if (test_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags))
>> +            break;
>> +        set_current_state(TASK_INTERRUPTIBLE);
>> +        hrtimer_start_expires(&hs.timer, HRTIMER_MODE_REL);
>> +        if (hs.task)
>> +            io_schedule();
>> +        hrtimer_cancel(&hs.timer);
>> +    } while (hs.task && !signal_pending(current));
>> +
>> +    __set_current_state(TASK_RUNNING);
>> +    destroy_hrtimer_on_stack(&hs.timer);
>> +}
>
> Hello Jens,
>
> Will avg_completion_time/2 be a good choice for a polling interval if an
> application submits requests of varying sizes, e.g. 4 KB and 64 KB?

Not necessarily. This is a first implementation to demonstrate what is
possible, we can definitely make it more clever. As mentioned in the
previous email, I believe most cases will be small(ish) IO of roughly
the same size, and it'll work fine for that.

One possible improvement could be to factor in the minimum times as
well. Since we're assuming some level of predictability here,
incorporating the 'min' time could help too. This is one of the devices
I used for testing:

# cat stats
read : samples=15199, mean=5185, min=5068, max=25616
write: samples=0, mean=0, min=-1, max=0

and when it looks like that, then using mean/2 works well. If I do a
512/64k 50/50 split, it looks like this:

cat stats
read : samples=4896, mean=20996, min=5250, max=49721
write: samples=0, mean=0, min=-1, max=0

Using the classic polling with this workload, I get 39900 IOPS at 100%
CPU load. With the hybrid poll enabled, I get 37700 IOPS at 68% CPU. For
the hybrid polling, with the default settings, we end up being a bit
slower than pure poll (not unexpected), but at a higher level of
efficiency. Even for this 512b/64k split case, that's still the case.

For comparison, without polling, we run at 25800 IOPS (at 39% CPU).

> Can avg_completion_time be smaller than the context switch time? If so,
> do you think any other thread will be able to do any useful work after
> the timer has been started and before the timer has expired?

There are definitely cases where we want to just keep busy polling. I
didn't add any minimum yet, but yes, you can imagine cases where we can
blow our budget by doing the sleep up front. We just want to do the busy
poll for that case.

-- 
Jens Axboe
