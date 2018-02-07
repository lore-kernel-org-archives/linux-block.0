Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Feb 2018 13:38:11 -0800
From: Tejun Heo <tj@kernel.org>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, xuejiufei <jiufei.xue@linux.alibaba.com>,
	Caspar Zhang <caspar@linux.alibaba.com>,
	linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] blk-throttle: fix race between blkcg_bio_issue_check
 and cgroup_rmdir
Message-ID: <20180207213811.GF695913@devbig577.frc2.facebook.com>
References: <6f136c90-faa9-4bc0-b02f-3a112b4d8360@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6f136c90-faa9-4bc0-b02f-3a112b4d8360@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Joseph.

On Wed, Feb 07, 2018 at 04:40:02PM +0800, Joseph Qi wrote:
> writeback kworker
>   blkcg_bio_issue_check
>     rcu_read_lock
>     blkg_lookup
>     <<< *race window*
>     blk_throtl_bio
>       spin_lock_irq(q->queue_lock)
>       spin_unlock_irq(q->queue_lock)
>     rcu_read_unlock
> 
> cgroup_rmdir
>   cgroup_destroy_locked
>     kill_css
>       css_killed_ref_fn
>         css_killed_work_fn
>           offline_css
>             blkcg_css_offline
>               spin_trylock(q->queue_lock)
>               blkg_destroy
>               spin_unlock(q->queue_lock)

Ah, right.  Thanks for spotting the bug.

> Since rcu can only prevent blkg from releasing when it is being used,
> the blkg->refcnt can be decreased to 0 during blkg_destroy and schedule
> blkg release.
> Then trying to blkg_get in blk_throtl_bio will complains the WARNING.
> And then the corresponding blkg_put will schedule blkg release again,
> which result in double free.
> This race is introduced by commit ae1188963611 ("blkcg: consolidate blkg
> creation in blkcg_bio_issue_check()"). Before this commit, it will lookup
> first and then try to lookup/create again with queue_lock. So revive
> this logic to fix the race.

The change seems a bit drastic to me.  Can't we do something like the
following instead?

blk_throtl_bio()
{
	... non throttled cases ...

	/* out-of-limit, queue to @tg */

	/*
	 * We can look up and retry but the race window is tiny here.
	 * Just letting it through should be good enough.
	 */
	if (!css_tryget(blkcg->css))
		goto out;

	... actual queueing ...
	css_put(blkcg->css);
	...
}

Thanks.

-- 
tejun
