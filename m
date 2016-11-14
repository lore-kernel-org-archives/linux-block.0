Subject: Re: [PATCH 3/3] blk-mq: make the polling code adaptive
To: Omar Sandoval <osandov@osandov.com>
References: <1478927487-12998-1-git-send-email-axboe@fb.com>
 <1478927487-12998-4-git-send-email-axboe@fb.com>
 <20161114194305.GB31821@vader.DHCP.thefacebook.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, hch@infradead.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <270f0462-6e26-1a7f-9056-9ff4fdcaf031@fb.com>
Date: Mon, 14 Nov 2016 12:58:24 -0700
MIME-Version: 1.0
In-Reply-To: <20161114194305.GB31821@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/14/2016 12:43 PM, Omar Sandoval wrote:
,9 +2539,10 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
>>  	 * This will be replaced with the stats tracking code, using
>>  	 * 'avg_completion_time / 2' as the pre-sleep target.
>>  	 */
>> -	kt = ktime_set(0, q->poll_nsec);
>> +	kt = ktime_set(0, nsecs);
>>
>> -	hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +	mode = HRTIMER_MODE_REL;
>> +	hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, mode);
>>  	hrtimer_set_expires(&hs.timer, kt);
>>
>>  	hrtimer_init_sleeper(&hs, current);
>> @@ -2487,10 +2550,11 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
>>  		if (test_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags))
>>  			break;
>>  		set_current_state(TASK_UNINTERRUPTIBLE);
>> -		hrtimer_start_expires(&hs.timer, HRTIMER_MODE_REL);
>> +		hrtimer_start_expires(&hs.timer, mode);
>>  		if (hs.task)
>>  			io_schedule();
>>  		hrtimer_cancel(&hs.timer);
>> +		mode = HRTIMER_MODE_ABS;
>>  	} while (hs.task && !signal_pending(current));
>
> This fix should be folded into patch 2.

Good point, I'll do that.

-- 
Jens Axboe
