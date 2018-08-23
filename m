Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <809b2243-7a76-3d8a-5d1b-b6b9d9712f41@kernel.dk>
Date: Thu, 23 Aug 2018 09:42:01 -0600
MIME-Version: 1.0
In-Reply-To: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/23/18 7:08 AM, Jianchao Wang wrote:
> @@ -491,31 +525,27 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
>  	__acquires(lock)
>  {
>  	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
> -	DECLARE_WAITQUEUE(wait, current);
> -	bool has_sleeper;
> -
> -	has_sleeper = wq_has_sleeper(&rqw->wait);
> -	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
> +	struct wait_queue_entry wait;
> +	struct wbt_wait_data data = {
> +		.curr = current,
> +		.rwb = rwb,
> +		.rqw = rqw,
> +		.rw = rw,
> +	};
> +
> +	if (!wq_has_sleeper(&rqw->wait) &&
> +			rq_wait_inc_below(rqw, get_limit(rwb, rw)))
>  		return;
>  
> -	add_wait_queue_exclusive(&rqw->wait, &wait);
> -	do {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> -
> -		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
> -			break;
> -
> -		if (lock) {
> -			spin_unlock_irq(lock);
> -			io_schedule();
> -			spin_lock_irq(lock);
> -		} else
> -			io_schedule();
> -		has_sleeper = false;
> -	} while (1);
> -
> -	__set_current_state(TASK_RUNNING);
> -	remove_wait_queue(&rqw->wait, &wait);
> +	wbt_init_wait(&wait, &data);
> +	prepare_to_wait_exclusive(&rqw->wait, &wait,
> +			TASK_UNINTERRUPTIBLE);
> +	if (lock) {
> +		spin_unlock_irq(lock);
> +		io_schedule();
> +		spin_lock_irq(lock);
> +	} else
> +		io_schedule();

Aren't we still missing a get-token attempt after adding to the
waitqueue? For the case where someone frees the token after your initial
check, but before you add yourself to the waitqueue.

-- 
Jens Axboe
