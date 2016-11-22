Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33782 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756344AbcKVVVg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2016 16:21:36 -0500
Date: Tue, 22 Nov 2016 16:21:21 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V4 05/15] blk-throttle: add downgrade logic
Message-ID: <20161122212121.GC17534@htj.duckdns.org>
References: <cover.1479161136.git.shli@fb.com>
 <d5670c98a3e4239202c4dad8f16add803a629f15.1479161136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d5670c98a3e4239202c4dad8f16add803a629f15.1479161136.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Mon, Nov 14, 2016 at 02:22:12PM -0800, Shaohua Li wrote:
> +static unsigned long tg_last_high_overflow_time(struct throtl_grp *tg)
> +{
> +	struct throtl_service_queue *parent_sq;
> +	struct throtl_grp *parent = tg;
> +	unsigned long ret = __tg_last_high_overflow_time(tg);
> +
> +	while (true) {
> +		parent_sq = parent->service_queue.parent_sq;
> +		parent = sq_to_tg(parent_sq);
> +		if (!parent)
> +			break;
> +		if (((parent->bps[READ][LIMIT_HIGH] != -1 &&
> +		      parent->bps[READ][LIMIT_HIGH] >=
> +		       tg->bps[READ][LIMIT_HIGH]) ||
> +		     (parent->bps[READ][LIMIT_HIGH] == -1 &&
> +		      parent->bps[READ][LIMIT_MAX] >=
> +		       tg->bps[READ][LIMIT_HIGH])) &&
> +		    ((parent->bps[WRITE][LIMIT_HIGH] != -1 &&
> +		      parent->bps[WRITE][LIMIT_HIGH] >=
> +		       tg->bps[WRITE][LIMIT_HIGH]) ||
> +		     (parent->bps[WRITE][LIMIT_HIGH] == -1 &&
> +		      parent->bps[WRITE][LIMIT_MAX] >=
> +		       tg->bps[WRITE][LIMIT_HIGH])) &&
> +		    ((parent->iops[READ][LIMIT_HIGH] != -1 &&
> +		      parent->iops[READ][LIMIT_HIGH] >=
> +		       tg->iops[READ][LIMIT_HIGH]) ||
> +		     (parent->iops[READ][LIMIT_HIGH] == -1 &&
> +		      parent->iops[READ][LIMIT_MAX] >=
> +		       tg->iops[READ][LIMIT_HIGH])) &&
> +		    ((parent->iops[WRITE][LIMIT_HIGH] != -1 &&
> +		      parent->iops[WRITE][LIMIT_HIGH] >=
> +		       tg->iops[WRITE][LIMIT_HIGH]) ||
> +		     (parent->iops[WRITE][LIMIT_HIGH] == -1 &&
> +		      parent->iops[WRITE][LIMIT_MAX] >=
> +		       tg->iops[WRITE][LIMIT_HIGH])))
> +			break;
> +		if (time_after(__tg_last_high_overflow_time(parent), ret))
> +			ret = __tg_last_high_overflow_time(parent);
> +	}
> +	return ret;
> +}

Heh, I'm not really following the upgrade/downgrade logic.  I'm having
trouble understanding two things.

1. A cgroup and its high and max limits don't have much to do with
   other cgroups and their limits.  I don't get how the choice between
   high and max limits can be a td-wide state.

2. Comparing parent's and child's limits and saying that either can be
   ignored because one is higher than the other isn't correct.  A
   parent's limit doesn't apply to each child separately.  It has to
   be aggregated.  e.g. you can ignore a parent's setting if the sum
   of all children's limits is smaller than the parent's but then
   again there could still be a lower limit higher up the tree, so
   they would still have to be examined.

Thanks.

-- 
tejun
