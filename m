Return-Path: <ming.lei@redhat.com>
Date: Sat, 23 Jun 2018 06:43:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-wbt: fix indefinite background writeback sleep
Message-ID: <20180622224301.GD2949@ming.t460p>
References: <0fa9cc9f-7d34-2490-cdaf-fe7a761e4790@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0fa9cc9f-7d34-2490-cdaf-fe7a761e4790@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 22, 2018 at 01:26:10PM -0600, Jens Axboe wrote:
> blk-wbt adds waiters to the tail of the waitqueue, and factors in the
> task placement in its decision making on whether or not the current task
> can proceed. This can cause issues for the lowest class of writers,
> since they can get woken up, denied access, and then put back to sleep
> at the end of the waitqueue.
> 
> Fix this so that we only utilize the tail add for the initial sleep, and
> we don't factor in the wait queue placement after we've slept (and are
> now using the head addition).
> 
> Fixes: e34cbd307477 ("blk-wbt: add general throttling mechanism")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 4f89b28fa652..7beeabd05f4a 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -550,7 +550,7 @@ static inline bool may_queue(struct rq_wb *rwb, struct rq_wait *rqw,
>  	 * If the waitqueue is already active and we are not the next
>  	 * in line to be woken up, wait for our turn.
>  	 */
> -	if (waitqueue_active(&rqw->wait) &&
> +	if (wait && waitqueue_active(&rqw->wait) &&
>  	    rqw->wait.head.next != &wait->entry)
>  		return false;
>  
> @@ -567,16 +567,27 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
>  	__acquires(lock)
>  {
>  	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
> +	struct wait_queue_entry *waitptr = NULL;
>  	DEFINE_WAIT(wait);
>  
> -	if (may_queue(rwb, rqw, &wait, rw))
> +	if (may_queue(rwb, rqw, waitptr, rw))
>  		return;
>  
> +	waitptr = &wait;
>  	do {
> -		prepare_to_wait_exclusive(&rqw->wait, &wait,
> +		/*
> +		 * Don't add ourselves to the wq tail if we've already
> +		 * slept. Otherwise we can penalize background writes
> +		 * indefinitely.
> +		 */

I saw this indefinite wbt_wait() in systemd-journal when running
aio-stress read test, but just once, not figured out one approach
to reproduce it yet, just wondering if you have quick test case for
reproducing and verifying this issue.

> +		if (waitptr)
> +			prepare_to_wait_exclusive(&rqw->wait, &wait,
> +							TASK_UNINTERRUPTIBLE);
> +		else
> +			prepare_to_wait(&rqw->wait, &wait,
>  						TASK_UNINTERRUPTIBLE);

Could you explain a bit why the 'wait_entry' order matters wrt. this
issue? Since other 'wait_entry' still may come at the head meantime to
the same wq before checking in may_queue().

Can we remove 'rqw->wait.head.next != &wait->entry' from may_queue()?
I guess that should be one optimization, but seems quite dangerous since
'rqw->wait.head.next' may point to one freed stack variable.


Thanks,
Ming
