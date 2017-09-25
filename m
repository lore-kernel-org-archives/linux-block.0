Return-Path: <shli@kernel.org>
Date: Mon, 25 Sep 2017 10:22:28 -0700
From: Shaohua Li <shli@kernel.org>
To: Joseph Qi <jiangqi903@gmail.com>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Shaohua Li <shli@fb.com>, boyu.mt@taobao.com, wenqing.lz@taobao.com,
	qijiang.qj@alibaba-inc.com
Subject: Re: [PATCH] blk-throttle: fix possible io stall when doing upgrade
Message-ID: <20170925172228.n2soitn5vj53ln36@kernel.org>
References: <5b918e35-7072-ba9a-92cc-726d02777b4f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5b918e35-7072-ba9a-92cc-726d02777b4f@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 06:46:42PM +0800, Joseph Qi wrote:
> From: Joseph Qi <qijiang.qj@alibaba-inc.com>
> 
> Currently it will try to dispatch bio in throtl_upgrade_state. This may
> lead to io stall in the following case.
> Say the hierarchy is like:
> /-test1
>   |-subtest1
> and subtest1 has 32 queued bios now.
> 
> throtl_pending_timer_fn            throtl_upgrade_state
> ------------------------------------------------------------------------
>                                    upgrade to max
>                                    throtl_select_dispatch
>                                    throtl_schedule_next_dispatch
> throtl_select_dispatch
> throtl_schedule_next_dispatch
> 
> Since throtl_select_dispatch will move queued bios from subtest1 to
> test1 in throtl_upgrade_state, it will then just do nothing in
> throtl_pending_timer_fn. As a result, queued bios won't be dispatched
> any more if no proper timer scheduled.

Sorry, didn't get it. If throtl_pending_timer_fn does nothing (because
throtl_upgrade_state already moves bios to parent), there is no pending
blkcg/bio, not rearming the timer wouldn't lose anything. Am I missing
anything? could you please describe the failure in details?

Thanks,
Shaohua

> Fix this issue by just scheduling dispatch now and let the dispatch be
> done only in timer.
> 
> Signed-off-by: Joseph Qi <qijiang.qj@alibaba-inc.com>
> ---
>  block/blk-throttle.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 0fea76a..29d282f 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1909,13 +1909,11 @@ static void throtl_upgrade_state(struct throtl_data *td)
>  		struct throtl_grp *tg = blkg_to_tg(blkg);
>  		struct throtl_service_queue *sq = &tg->service_queue;
>  
> -		tg->disptime = jiffies - 1;
> -		throtl_select_dispatch(sq);
> -		throtl_schedule_next_dispatch(sq, false);
> +		tg->disptime = jiffies;
> +		throtl_schedule_next_dispatch(sq, true);
>  	}
>  	rcu_read_unlock();
> -	throtl_select_dispatch(&td->service_queue);
> -	throtl_schedule_next_dispatch(&td->service_queue, false);
> +	throtl_schedule_next_dispatch(&td->service_queue, true);
>  	queue_work(kthrotld_workqueue, &td->dispatch_work);
>  }
>  
> -- 
> 1.9.4
