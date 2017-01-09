Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33729 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752600AbdAIU2r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 15:28:47 -0500
Date: Mon, 9 Jan 2017 15:28:44 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V5 10/17] blk-throttle: make bandwidth change smooth
Message-ID: <20170109202844.GN12827@mtj.duckdns.org>
References: <cover.1481833017.git.shli@fb.com>
 <390c68366acef5f3ce6ac6c5ce868826f07fd993.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <390c68366acef5f3ce6ac6c5ce868826f07fd993.1481833017.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Thu, Dec 15, 2016 at 12:33:01PM -0800, Shaohua Li wrote:
>  static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
>  {
>  	struct blkcg_gq *blkg = tg_to_blkg(tg);
> +	struct throtl_data *td;
>  	uint64_t ret;
>  
>  	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
>  		return U64_MAX;
> -	return tg->bps[rw][tg->td->limit_index];
> +
> +	td = tg->td;
> +	ret = tg->bps[rw][td->limit_index];
> +	if (td->limit_index == LIMIT_MAX && tg->bps[rw][LIMIT_LOW] !=
> +	    tg->bps[rw][LIMIT_MAX]) {
> +		uint64_t increase;
> +
> +		if (td->scale < 4096 && time_after_eq(jiffies,

Hmm... why do we need to limit scale to 4096?  As 4096 is a big
number, this is only theoretical but this means that if max is more
then 2048 times low, that will never be reached, right?

> +		    td->low_upgrade_time + td->scale * td->throtl_slice)) {
> +			unsigned int time = jiffies - td->low_upgrade_time;
> +
> +			td->scale = time / td->throtl_slice;
> +		}
> +		increase = (tg->bps[rw][LIMIT_LOW] >> 1) * td->scale;
> +		ret = min(tg->bps[rw][LIMIT_MAX],
> +			tg->bps[rw][LIMIT_LOW] + increase);
> +	}
> +	return ret;
>  }

I think the code can use some comments.

>  static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
>  {
>  	struct blkcg_gq *blkg = tg_to_blkg(tg);
> +	struct throtl_data *td;
>  	unsigned int ret;
>  
>  	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
>  		return UINT_MAX;
> -	return tg->iops[rw][tg->td->limit_index];
> +
> +	td = tg->td;
> +	ret = tg->iops[rw][td->limit_index];
> +	if (td->limit_index == LIMIT_MAX && tg->iops[rw][LIMIT_LOW] !=
> +	    tg->iops[rw][LIMIT_MAX]) {
> +		uint64_t increase;
> +
> +		if (td->scale < 4096 && time_after_eq(jiffies,
> +		    td->low_upgrade_time + td->scale * td->throtl_slice)) {
> +			unsigned int time = jiffies - td->low_upgrade_time;
> +
> +			td->scale = time / td->throtl_slice;
> +		}
> +
> +		increase = (tg->iops[rw][LIMIT_LOW] >> 1) * td->scale;
> +		ret = min(tg->iops[rw][LIMIT_MAX],
> +			tg->iops[rw][LIMIT_LOW] + (unsigned int)increase);

Would it be worthwhile to factor the common part into a helper?

> @@ -1662,6 +1702,13 @@ static void throtl_upgrade_state(struct throtl_data *td)
>  
>  static void throtl_downgrade_state(struct throtl_data *td, int new)
>  {
> +	td->scale /= 2;
> +
> +	if (td->scale) {
> +		td->low_upgrade_time = jiffies - td->scale * td->throtl_slice;
> +		return;
> +	}

Cool, so linear increase and exponential backdown.  Yeah, that makes
sense to me but let's please document it.

Thanks.

-- 
tejun
