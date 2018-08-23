Return-Path: <prvs=76602444a=anchalag@kaos-source-ops-60001.pdx1.amazon.com>
Date: Thu, 23 Aug 2018 21:01:44 +0000
From: Anchal Agarwal <anchalag@amzn.com>
To: "van der Linden, Frank" <fllinden@amazon.com>, <axboe@kernel.dk>,
        <jianchao.w.wang@oracle.com>
CC: "mlinux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
Message-ID: <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 23, 2018 at 10:24:00AM -0600, van der Linden, Frank wrote:
> On 8/23/18 8:37 AM, Jens Axboe wrote:
> > On 8/23/18 7:08 AM, Jianchao Wang wrote:
> >> 2887e41 (blk-wbt: Avoid lock contention and thundering herd
> >> issue in wbt_wait) introduces two cases that could miss wakeup:
> >>  - __wbt_done only wakes up one waiter one time. There could be
> >>    multiple waiters and (limit - inflight) > 1 at the moment.
> >>
> >>  - When the waiter is waked up, it is still on wait queue and set
> >>    to TASK_UNINTERRUPTIBLE immediately, so this waiter could be
> >>    waked up one more time. If a __wbt_done comes and wakes up
> >>    again, the prevous waiter may waste a wakeup.
> >>
> >> To fix them and avoid to introduce too much lock contention, we
> >> introduce our own wake up func wbt_wake_function in __wbt_wait and
> >> use wake_up_all in __wbt_done. wbt_wake_function will try to get
> >> wbt budget firstly, if sucesses, wake up the process, otherwise,
> >> return -1 to interrupt the wake up loop.
> > I really like this approach, since it'll naturally wake up as many
> > as we can instead of either being single wakeups, or wake all.
> >
> > BTW, you added Anchal and Frank to the CC in the patch, but they 
> > are not actually CC'ed. Doing that now - can you guys give this
> > a whirl? Should still solve the thundering herd issue, but be
> > closer to the original logic in terms of wakeup. Actually better,
> > since we remain on list and remain ordered.
> >
> > Leaving the patch below for you guys.
> >
> >> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> >> Fixes: 2887e41 (blk-wbt: Avoid lock contention and thundering herd issue in wbt_wait)
> >> Cc: Anchal Agarwal <anchalag@amazon.com>
> >> Cc: Frank van der Linden <fllinden@amazon.com>
> >> ---
> >>  block/blk-wbt.c | 78 +++++++++++++++++++++++++++++++++++++++------------------
> >>  1 file changed, 54 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> >> index c9358f1..2667590 100644
> >> --- a/block/blk-wbt.c
> >> +++ b/block/blk-wbt.c
> >> @@ -166,7 +166,7 @@ static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
> >>  		int diff = limit - inflight;
> >>  
> >>  		if (!inflight || diff >= rwb->wb_background / 2)
> >> -			wake_up(&rqw->wait);
> >> +			wake_up_all(&rqw->wait);
> >>  	}
> >>  }
> >>  
> >> @@ -481,6 +481,40 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
> >>  	return limit;
> >>  }
> >>  
> >> +struct wbt_wait_data {
> >> +	struct task_struct *curr;
> >> +	struct rq_wb *rwb;
> >> +	struct rq_wait *rqw;
> >> +	unsigned long rw;
> >> +};
> >> +
> >> +static int wbt_wake_function(wait_queue_entry_t *curr, unsigned int mode,
> >> +		int wake_flags, void *key)
> >> +{
> >> +	struct wbt_wait_data *data = curr->private;
> >> +
> >> +	/*
> >> +	 * If fail to get budget, return -1 to interrupt the wake up
> >> +	 * loop in __wake_up_common.
> >> +	 */
> >> +	if (!rq_wait_inc_below(data->rqw, get_limit(data->rwb, data->rw)))
> >> +		return -1;
> >> +
> >> +	wake_up_process(data->curr);
> >> +
> >> +	list_del_init(&curr->entry);
> >> +	return 1;
> >> +}
> >> +
> >> +static inline void wbt_init_wait(struct wait_queue_entry *wait,
> >> +		struct wbt_wait_data *data)
> >> +{
> >> +	INIT_LIST_HEAD(&wait->entry);
> >> +	wait->flags = 0;
> >> +	wait->func = wbt_wake_function;
> >> +	wait->private = data;
> >> +}
> >> +
> >>  /*
> >>   * Block if we will exceed our limit, or if we are currently waiting for
> >>   * the timer to kick off queuing again.
> >> @@ -491,31 +525,27 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
> >>  	__acquires(lock)
> >>  {
> >>  	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
> >> -	DECLARE_WAITQUEUE(wait, current);
> >> -	bool has_sleeper;
> >> -
> >> -	has_sleeper = wq_has_sleeper(&rqw->wait);
> >> -	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
> >> +	struct wait_queue_entry wait;
> >> +	struct wbt_wait_data data = {
> >> +		.curr = current,
> >> +		.rwb = rwb,
> >> +		.rqw = rqw,
> >> +		.rw = rw,
> >> +	};
> >> +
> >> +	if (!wq_has_sleeper(&rqw->wait) &&
> >> +			rq_wait_inc_below(rqw, get_limit(rwb, rw)))
> >>  		return;
> >>  
> >> -	add_wait_queue_exclusive(&rqw->wait, &wait);
> >> -	do {
> >> -		set_current_state(TASK_UNINTERRUPTIBLE);
> >> -
> >> -		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
> >> -			break;
> >> -
> >> -		if (lock) {
> >> -			spin_unlock_irq(lock);
> >> -			io_schedule();
> >> -			spin_lock_irq(lock);
> >> -		} else
> >> -			io_schedule();
> >> -		has_sleeper = false;
> >> -	} while (1);
> >> -
> >> -	__set_current_state(TASK_RUNNING);
> >> -	remove_wait_queue(&rqw->wait, &wait);
> >> +	wbt_init_wait(&wait, &data);
> >> +	prepare_to_wait_exclusive(&rqw->wait, &wait,
> >> +			TASK_UNINTERRUPTIBLE);
> >> +	if (lock) {
> >> +		spin_unlock_irq(lock);
> >> +		io_schedule();
> >> +		spin_lock_irq(lock);
> >> +	} else
> >> +		io_schedule();
> >>  }
> >>  
> >>  static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
> >>
> >
> I like it, this combines some of the ideas outlined in our previous
> thread in to a good solution.
> 
> One comment, though: I think we need to set the task state back to
> TASK_RUNNING after being woken up, right?
> 
> Frank
> 
>

Hi Jens,
This patch looks much cleaner for sure as Frank pointed out too. Basically this looks similar
to wake_up_nr only making sure that those woken up requests won't get reordered. This does 
solves the thundering herd issue. However, I tested the patch against my application and 
lock contention numbers rose to around 10 times from what I had from your last 3 patches. 
Again this did add to drop in of total files read by 0.12% and rate at which they were read by
0.02% but this is not a very significant drop. Is lock contention worth the tradeoff?
I also added missing  __set_current_state(TASK_RUNNING) to the patch for testing.

Thanks,
Anchal
