Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v6] blk-throttle: fix race between blkcg_bio_issue_check()
 and cgroup_rmdir()
To: Joseph Qi <joseph.qi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>
Cc: Jiufei Xue <jiufei.xue@linux.alibaba.com>,
 Caspar Zhang <caspar@linux.alibaba.com>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org
References: <1521183087-24988-1-git-send-email-joseph.qi@linux.alibaba.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2e926f84-63a5-182d-16ce-6da3b5f7487b@kernel.dk>
Date: Fri, 16 Mar 2018 09:36:18 -0700
MIME-Version: 1.0
In-Reply-To: <1521183087-24988-1-git-send-email-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/15/18 11:51 PM, Joseph Qi wrote:
> We've triggered a WARNING in blk_throtl_bio() when throttling writeback
> io, which complains blkg->refcnt is already 0 when calling blkg_get(),
> and then kernel crashes with invalid page request.
> After investigating this issue, we've found it is caused by a race
> between blkcg_bio_issue_check() and cgroup_rmdir(), which is described
> below:
> 
> writeback kworker               cgroup_rmdir
>                                   cgroup_destroy_locked
>                                     kill_css
>                                       css_killed_ref_fn
>                                         css_killed_work_fn
>                                           offline_css
>                                             blkcg_css_offline
>   blkcg_bio_issue_check
>     rcu_read_lock
>     blkg_lookup
>                                               spin_trylock(q->queue_lock)
>                                               blkg_destroy
>                                               spin_unlock(q->queue_lock)
>     blk_throtl_bio
>     spin_lock_irq(q->queue_lock)
>     ...
>     spin_unlock_irq(q->queue_lock)
>   rcu_read_unlock
> 
> Since rcu can only prevent blkg from releasing when it is being used,
> the blkg->refcnt can be decreased to 0 during blkg_destroy() and schedule
> blkg release.
> Then trying to blkg_get() in blk_throtl_bio() will complains the WARNING.
> And then the corresponding blkg_put() will schedule blkg release again,
> which result in double free.
> This race is introduced by commit ae1188963611 ("blkcg: consolidate blkg
> creation in blkcg_bio_issue_check()"). Before this commit, it will
> lookup first and then try to lookup/create again with queue_lock. Since
> revive this logic is a bit drastic, so fix it by only offlining pd during
> blkcg_css_offline(), and move the rest destruction (especially
> blkg_put()) into blkcg_css_free(), which should be the right way as
> discussed.

Applied for 4.17, thanks.

-- 
Jens Axboe
