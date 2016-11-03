Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH 3/4] blk-mq: implement hybrid poll mode for sync O_DIRECT
To: Jens Axboe <axboe@fb.com>, <axboe@kernel.dk>,
	<linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
References: <1478034325-28232-1-git-send-email-axboe@fb.com>
 <1478034325-28232-4-git-send-email-axboe@fb.com>
CC: <hch@lst.de>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <1be37430-c75a-308b-04b7-9779a9fe3f56@sandisk.com>
Date: Thu, 3 Nov 2016 08:01:41 -0600
MIME-Version: 1.0
In-Reply-To: <1478034325-28232-4-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Return-Path: bart.vanassche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 11/01/2016 03:05 PM, Jens Axboe wrote:
> +static void blk_mq_poll_hybrid_sleep(struct request_queue *q,
> +				     struct request *rq)
> +{
> +	struct hrtimer_sleeper hs;
> +	ktime_t kt;
> +
> +	if (!q->poll_nsec || test_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags))
> +		return;
> +
> +	set_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
> +
> +	/*
> +	 * This will be replaced with the stats tracking code, using
> +	 * 'avg_completion_time / 2' as the pre-sleep target.
> +	 */
> +	kt = ktime_set(0, q->poll_nsec);
> +
> +	hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer_set_expires(&hs.timer, kt);
> +
> +	hrtimer_init_sleeper(&hs, current);
> +	do {
> +		if (test_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags))
> +			break;
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		hrtimer_start_expires(&hs.timer, HRTIMER_MODE_REL);
> +		if (hs.task)
> +			io_schedule();
> +		hrtimer_cancel(&hs.timer);
> +	} while (hs.task && !signal_pending(current));
> +
> +	__set_current_state(TASK_RUNNING);
> +	destroy_hrtimer_on_stack(&hs.timer);
> +}

Hello Jens,

Will avg_completion_time/2 be a good choice for a polling interval if an 
application submits requests of varying sizes, e.g. 4 KB and 64 KB?

Can avg_completion_time be smaller than the context switch time? If so, 
do you think any other thread will be able to do any useful work after 
the timer has been started and before the timer has expired?

Thanks,

Bart.
