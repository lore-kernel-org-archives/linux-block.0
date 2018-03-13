Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 13 Mar 2018 13:19:57 -0700
From: Tejun Heo <tj@kernel.org>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, xuejiufei <jiufei.xue@linux.alibaba.com>,
	Caspar Zhang <caspar@linux.alibaba.com>,
	linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v3] blk-throttle: fix race between
 blkcg_bio_issue_check() and cgroup_rmdir()
Message-ID: <20180313201957.GF2943022@devbig577.frc2.facebook.com>
References: <b48c5c72-c2b4-ee89-58d9-dd017818689d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b48c5c72-c2b4-ee89-58d9-dd017818689d@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Joseph.

On Mon, Mar 05, 2018 at 11:03:16PM +0800, Joseph Qi wrote:
> +static void blkg_pd_offline(struct blkcg_gq *blkg)
> +{
> +	int i;
> +
> +	lockdep_assert_held(blkg->q->queue_lock);
> +	lockdep_assert_held(&blkg->blkcg->lock);
> +
> +	for (i = 0; i < BLKCG_MAX_POLS; i++) {
> +		struct blkcg_policy *pol = blkcg_policy[i];
> +
> +		if (blkg->pd[i] && !blkg->pd_offline[i] && pol->pd_offline_fn) {
> +			pol->pd_offline_fn(blkg->pd[i]);
> +			blkg->pd_offline[i] = true;

Can we move this flag into blkg_policy_data?

> +	while (!hlist_empty(&blkcg->blkg_list)) {
> +		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
> +						    struct blkcg_gq,
> +						    blkcg_node);
> +		struct request_queue *q = blkg->q;
> +
> +		if (spin_trylock(q->queue_lock)) {
> +			blkg_destroy(blkg);
> +			spin_unlock(q->queue_lock);
> +		} else {
> +			spin_unlock_irq(&blkcg->lock);
> +			cpu_relax();
> +			spin_lock_irq(&blkcg->lock);
> +		}

Can we factor out the above loop?  It's something subtle and painful
and I think it'd be better to have it separated out and documented.

Other than that, looks great.

Thanks.

-- 
tejun
