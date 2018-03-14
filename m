Return-Path: <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v3] blk-throttle: fix race between blkcg_bio_issue_check()
 and cgroup_rmdir()
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, xuejiufei <jiufei.xue@linux.alibaba.com>,
 Caspar Zhang <caspar@linux.alibaba.com>,
 linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org
References: <b48c5c72-c2b4-ee89-58d9-dd017818689d@linux.alibaba.com>
 <20180313201957.GF2943022@devbig577.frc2.facebook.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <ba296c62-9c59-122f-359e-9fe03b693604@linux.alibaba.com>
Date: Wed, 14 Mar 2018 11:03:25 +0800
MIME-Version: 1.0
In-Reply-To: <20180313201957.GF2943022@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Fine, I will do the corresponding changes and post v5.

Thanks,
Joseph

On 18/3/14 04:19, Tejun Heo wrote:
> Hello, Joseph.
> 
> On Mon, Mar 05, 2018 at 11:03:16PM +0800, Joseph Qi wrote:
>> +static void blkg_pd_offline(struct blkcg_gq *blkg)
>> +{
>> +	int i;
>> +
>> +	lockdep_assert_held(blkg->q->queue_lock);
>> +	lockdep_assert_held(&blkg->blkcg->lock);
>> +
>> +	for (i = 0; i < BLKCG_MAX_POLS; i++) {
>> +		struct blkcg_policy *pol = blkcg_policy[i];
>> +
>> +		if (blkg->pd[i] && !blkg->pd_offline[i] && pol->pd_offline_fn) {
>> +			pol->pd_offline_fn(blkg->pd[i]);
>> +			blkg->pd_offline[i] = true;
> 
> Can we move this flag into blkg_policy_data?
> 
>> +	while (!hlist_empty(&blkcg->blkg_list)) {
>> +		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
>> +						    struct blkcg_gq,
>> +						    blkcg_node);
>> +		struct request_queue *q = blkg->q;
>> +
>> +		if (spin_trylock(q->queue_lock)) {
>> +			blkg_destroy(blkg);
>> +			spin_unlock(q->queue_lock);
>> +		} else {
>> +			spin_unlock_irq(&blkcg->lock);
>> +			cpu_relax();
>> +			spin_lock_irq(&blkcg->lock);
>> +		}
> 
> Can we factor out the above loop?  It's something subtle and painful
> and I think it'd be better to have it separated out and documented.
> 
> Other than that, looks great.
> 
> Thanks.
> 
