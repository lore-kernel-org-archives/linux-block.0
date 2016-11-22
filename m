Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35340 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755655AbcKVUCz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2016 15:02:55 -0500
Date: Tue, 22 Nov 2016 15:02:53 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V4 02/15] blk-throttle: add .high interface
Message-ID: <20161122200253.GA17534@htj.duckdns.org>
References: <cover.1479161136.git.shli@fb.com>
 <239e20c62e028b570f48403faea1419c4d84f2bd.1479161136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <239e20c62e028b570f48403faea1419c4d84f2bd.1479161136.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Shaohua.

Sorry about the delay.

On Mon, Nov 14, 2016 at 02:22:09PM -0800, Shaohua Li wrote:
> @@ -1376,11 +1414,37 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
>  			goto out_finish;
>  	}
>  
> -	tg->bps[READ][LIMIT_MAX] = v[0];
> -	tg->bps[WRITE][LIMIT_MAX] = v[1];
> -	tg->iops[READ][LIMIT_MAX] = v[2];
> -	tg->iops[WRITE][LIMIT_MAX] = v[3];
> -
> +	if (index == LIMIT_MAX) {
> +		if ((v[0] < tg->bps[READ][LIMIT_HIGH] &&
> +		       tg->bps[READ][LIMIT_HIGH] != -1) ||
> +		    (v[1] < tg->bps[WRITE][LIMIT_HIGH] &&
> +		       tg->bps[WRITE][LIMIT_HIGH] != -1) ||
> +		    (v[2] < tg->iops[READ][LIMIT_HIGH] &&
> +		       tg->iops[READ][LIMIT_HIGH] != -1) ||
> +		    (v[3] < tg->iops[WRITE][LIMIT_HIGH] &&
> +		       tg->iops[WRITE][LIMIT_HIGH] != -1)) {
> +			ret = -EINVAL;
> +			goto out_finish;

Is this necessary?  memcg doesn't put restrictions on input but just
enforces whatever is configured.  I think it'd be better to follow the
same model here too.  Hmm... is this because throtl will be able to
choose either all high or max limits per cgroup?

And this isn't from your patches but can we please switch to
UINT64_MAX instead of -1?

> +		}
> +	} else if (index == LIMIT_HIGH) {
> +		if ((v[0] > tg->bps[READ][LIMIT_MAX] && v[0] != -1) ||
> +		    (v[1] > tg->bps[WRITE][LIMIT_MAX] && v[1] != -1) ||
> +		    (v[2] > tg->iops[READ][LIMIT_MAX] && v[2] != -1) ||
> +		    (v[3] > tg->iops[WRITE][LIMIT_MAX] && v[3] != -1)) {

Ditto here.

> @@ -1412,6 +1484,7 @@ static struct blkcg_policy blkcg_policy_throtl = {
>  	.pd_alloc_fn		= throtl_pd_alloc,
>  	.pd_init_fn		= throtl_pd_init,
>  	.pd_online_fn		= throtl_pd_online,
> +	.pd_offline_fn		= throtl_pd_offline,
>  	.pd_free_fn		= throtl_pd_free,
>  };

I haven't read the whole thing yet but this looks a bit suspicious.  A
css going offline indicates that the destruction of the css started.
I don't get why that'd reset high limits.  There can be a lot of async
IOs after offline.

Thanks.

-- 
tejun
