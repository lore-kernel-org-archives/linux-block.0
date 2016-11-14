Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 14 Nov 2016 11:43:05 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 3/3] blk-mq: make the polling code adaptive
Message-ID: <20161114194305.GB31821@vader.DHCP.thefacebook.com>
References: <1478927487-12998-1-git-send-email-axboe@fb.com>
 <1478927487-12998-4-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478927487-12998-4-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 11, 2016 at 10:11:27PM -0700, Jens Axboe wrote:
> The previous commit introduced the hybrid sleep/poll mode. Take
> that one step further, and use the completion latencies to
> automatically sleep for half the mean completion time. This is
> a good approximation.
> 
> This changes the 'io_poll_delay' sysfs file a bit to expose the
> various options. Depending on the value, the polling code will
> behave differently:
> 
> -1	Never enter hybrid sleep mode
>  0	Use half of the completion mean for the sleep delay
> >0	Use this specific value as the sleep delay
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-mq.c         | 74 ++++++++++++++++++++++++++++++++++++++++++++++----
>  block/blk-sysfs.c      | 26 ++++++++++++------
>  include/linux/blkdev.h |  2 +-
>  3 files changed, 88 insertions(+), 14 deletions(-)
> 

[snip]

>  static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
> +				     struct blk_mq_hw_ctx *hctx,
>  				     struct request *rq)
>  {
>  	struct hrtimer_sleeper hs;
> +	enum hrtimer_mode mode;
> +	unsigned int nsecs;
>  	ktime_t kt;
>  
> -	if (!q->poll_nsec || test_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags))
> +	if (test_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags))
> +		return false;
> +
> +	/*
> +	 * poll_nsec can be:
> +	 *
> +	 * -1:	don't ever hybrid sleep
> +	 *  0:	use half of prev avg
> +	 * >0:	use this specific value
> +	 */
> +	if (q->poll_nsec == -1)
> +		return false;
> +	else if (q->poll_nsec > 0)
> +		nsecs = q->poll_nsec;
> +	else
> +		nsecs = blk_mq_poll_nsecs(q, hctx, rq);
> +
> +	if (!nsecs)
>  		return false;
>  
>  	set_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
> @@ -2477,9 +2539,10 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
>  	 * This will be replaced with the stats tracking code, using
>  	 * 'avg_completion_time / 2' as the pre-sleep target.
>  	 */
> -	kt = ktime_set(0, q->poll_nsec);
> +	kt = ktime_set(0, nsecs);
>  
> -	hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	mode = HRTIMER_MODE_REL;
> +	hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, mode);
>  	hrtimer_set_expires(&hs.timer, kt);
>  
>  	hrtimer_init_sleeper(&hs, current);
> @@ -2487,10 +2550,11 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
>  		if (test_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags))
>  			break;
>  		set_current_state(TASK_UNINTERRUPTIBLE);
> -		hrtimer_start_expires(&hs.timer, HRTIMER_MODE_REL);
> +		hrtimer_start_expires(&hs.timer, mode);
>  		if (hs.task)
>  			io_schedule();
>  		hrtimer_cancel(&hs.timer);
> +		mode = HRTIMER_MODE_ABS;
>  	} while (hs.task && !signal_pending(current));

This fix should be folded into patch 2.

>  	__set_current_state(TASK_RUNNING);
> @@ -2510,7 +2574,7 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
>  	 * the IO isn't complete, we'll get called again and will go
>  	 * straight to the busy poll loop.
>  	 */
> -	if (blk_mq_poll_hybrid_sleep(q, rq))
> +	if (blk_mq_poll_hybrid_sleep(q, hctx, rq))
>  		return true;
>  
>  	hctx->poll_considered++;

[snip]

-- 
Omar
