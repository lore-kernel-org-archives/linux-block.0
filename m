Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34001 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965923AbdAIQfS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 11:35:18 -0500
Date: Mon, 9 Jan 2017 11:35:10 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V5 03/17] blk-throttle: add .low interface
Message-ID: <20170109163510.GC12827@mtj.duckdns.org>
References: <cover.1481833017.git.shli@fb.com>
 <c4179e0d7e8f2e36455db1a639911ab9aca374b1.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c4179e0d7e8f2e36455db1a639911ab9aca374b1.1481833017.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Happy new year, Shaohua.

Sorry about the long delay.

On Thu, Dec 15, 2016 at 12:32:54PM -0800, Shaohua Li wrote:
> Add low limit for cgroup and corresponding cgroup interface.

It'd be nice to explain why we're adding separate _conf fields.

> +static void blk_throtl_update_valid_limit(struct throtl_data *td)

I think blk_throtl_update_limit_valid() would be more consistent.

> +{
> +	struct cgroup_subsys_state *pos_css;
> +	struct blkcg_gq *blkg;
> +	bool low_valid = false;
> +
> +	rcu_read_lock();
> +	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
> +		struct throtl_grp *tg = blkg_to_tg(blkg);
> +
> +		if (tg->bps[READ][LIMIT_LOW] != U64_MAX ||
> +		    tg->bps[WRITE][LIMIT_LOW] != U64_MAX ||
> +		    tg->iops[READ][LIMIT_LOW] != UINT_MAX ||
> +		    tg->iops[WRITE][LIMIT_LOW] != UINT_MAX)
> +			low_valid = true;

It's weird that it's defaulting to MAX.  Shouldn't it default to 0?
When we enable these limits on a cgroup, we want it to not affect the
operation without further configuration.  For max limit, MAX does that
as being over the limit is what changes the behavior.  For low, it's
the other way around.  We enforce latency target if cgroups are under
the low limit, and thus 0 should be the noop default value, which is
the same in memcg.

> +	}
> +	rcu_read_unlock();
> +
> +	if (low_valid)
> +		td->limit_valid[LIMIT_LOW] = true;
> +	else
> +		td->limit_valid[LIMIT_LOW] = false;

Maybe
	td->limit_valid[LIMIT_LOW] = low_valid;

Thanks.

-- 
tejun
