Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32994 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423044AbdAISlC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 13:41:02 -0500
Date: Mon, 9 Jan 2017 13:40:53 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V5 05/17] blk-throttle: add upgrade logic for LIMIT_LOW
 state
Message-ID: <20170109184053.GG12827@mtj.duckdns.org>
References: <cover.1481833017.git.shli@fb.com>
 <75685643afd126cbccefe894ca56fd5dd83fe8cf.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <75685643afd126cbccefe894ca56fd5dd83fe8cf.1481833017.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Shaohua.

On Thu, Dec 15, 2016 at 12:32:56PM -0800, Shaohua Li wrote:
> For a cgroup hierarchy, there are two cases. Children has lower low
> limit than parent. Parent's low limit is meaningless. If children's
> bps/iops cross low limit, we can upgrade queue state. The other case is
> children has higher low limit than parent. Children's low limit is
> meaningless. As long as parent's bps/iops cross low limit, we can
> upgrade queue state.

The above isn't completely accurate as the parent should consider the
sum of what's currently being used in the children.

> +static bool throtl_tg_can_upgrade(struct throtl_grp *tg)
> +{
> +	struct throtl_service_queue *sq = &tg->service_queue;
> +	bool read_limit, write_limit;
> +
> +	/*
> +	 * if cgroup reaches low/max limit (max >= low), it's ok to next
> +	 * limit
> +	 */
> +	read_limit = tg->bps[READ][LIMIT_LOW] != U64_MAX ||
> +		     tg->iops[READ][LIMIT_LOW] != UINT_MAX;
> +	write_limit = tg->bps[WRITE][LIMIT_LOW] != U64_MAX ||
> +		      tg->iops[WRITE][LIMIT_LOW] != UINT_MAX;
> +	if (read_limit && sq->nr_queued[READ] &&
> +	    (!write_limit || sq->nr_queued[WRITE]))
> +		return true;
> +	if (write_limit && sq->nr_queued[WRITE] &&
> +	    (!read_limit || sq->nr_queued[READ]))
> +		return true;

I think it'd be great to explain the above.  It was a bit difficult
for me to follow.  It's also interesting because we're tying state
transitions for both read and write together.  blk-throtl has been
handling reads and writes independently, now the mode switching from
low to max is shared across reads and writes.  I suppose it could be
fine but would it be complex to separate them out?  It's weird to make
this one state shared across reads and writes while not for others or
was this sharing intentional?

> +	return false;
> +}
> +
> +static bool throtl_hierarchy_can_upgrade(struct throtl_grp *tg)
> +{
> +	while (true) {
> +		if (throtl_tg_can_upgrade(tg))
> +			return true;
> +		tg = sq_to_tg(tg->service_queue.parent_sq);
> +		if (!tg || (cgroup_subsys_on_dfl(io_cgrp_subsys) &&
> +				!tg_to_blkg(tg)->parent))
> +			return false;

Isn't the low limit v2 only?  Do we need the on_dfl test this deep?

> +	}
> +	return false;
> +}
> +
> +static bool throtl_can_upgrade(struct throtl_data *td,
> +	struct throtl_grp *this_tg)
> +{
> +	struct cgroup_subsys_state *pos_css;
> +	struct blkcg_gq *blkg;
> +
> +	if (td->limit_index != LIMIT_LOW)
> +		return false;
> +
> +	rcu_read_lock();
> +	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
> +		struct throtl_grp *tg = blkg_to_tg(blkg);
> +
> +		if (tg == this_tg)
> +			continue;
> +		if (!list_empty(&tg_to_blkg(tg)->blkcg->css.children))
> +			continue;
> +		if (!throtl_hierarchy_can_upgrade(tg)) {
> +			rcu_read_unlock();
> +			return false;
> +		}
> +	}
> +	rcu_read_unlock();
> +	return true;
> +}

So, if all with low limit are over their limits (have commands queued
in the delay queue), the state can be upgraded, right?  Yeah, that
seems correct to me.  The patch description didn't seem to match it
tho.  Can you please update the description accordingly?

Thanks.

-- 
tejun
