Return-Path: <jack@suse.cz>
Date: Thu, 31 May 2018 13:42:28 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jan Kara <jack@suse.cz>,
	syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	axboe@kernel.dk, tj@kernel.org, david@fromorbit.com,
	linux-block@vger.kernel.org
Subject: Re: general protection fault in wb_workfn (2)
Message-ID: <20180531114228.6zx27xxurmz27pke@quack2.suse.cz>
References: <000000000000cbd959056d1851ca@google.com>
 <0c7c5dea-7312-8a59-9d1b-5467f69719bf@I-love.SAKURA.ne.jp>
 <20180528133503.awomzj6djozbo5bv@quack2.suse.cz>
 <2dda7a11-3f6b-bdba-a68a-7c0694806cc4@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2dda7a11-3f6b-bdba-a68a-7c0694806cc4@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Thu 31-05-18 01:00:08, Tetsuo Handa wrote:
> So, we have no idea what is happening...
> Then, what about starting from temporary debug printk() patch shown below?
> 
> >From 4f70f72ad3c9ae6ce1678024ef740aca4958e5b0 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Wed, 30 May 2018 09:57:10 +0900
> Subject: [PATCH] bdi: Add temporary config for debugging wb_workfn() versus
>  bdi_unregister() race bug.
> 
> syzbot is hitting NULL pointer dereference at wb_workfn() [1]. But due to
> limitations that syzbot cannot find reproducer for this bug (frequency is
> once or twice per a day) nor we can't capture vmcore in the environment
> which syzbot is using, for now we need to rely on printk() debugging.
> 
> [1] https://syzkaller.appspot.com/bug?id=e0818ccb7e46190b3f1038b0c794299208ed4206
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Hum a bit ugly solution but if others are fine with this, I can live with
it for a while as well. Or would it be possible for syzkaller to just test
some git tree where this patch is included? Then we would not even have to
have the extra config option...

> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 471d863..b4dd078 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1934,6 +1934,37 @@ void wb_workfn(struct work_struct *work)
>  						struct bdi_writeback, dwork);
>  	long pages_written;
>  
> +#ifdef CONFIG_BLK_DEBUG_WB_WORKFN_RACE
> +	if (!wb->bdi->dev) {
> +		pr_warn("WARNING: %s: device is NULL\n", __func__);
> +		pr_warn("wb->state=%lx\n", wb->state);
> +		pr_warn("list_empty(&wb->work_list)=%u\n",
> +			list_empty(&wb->work_list));
> +		if (!wb->bdi)

This is not possible when we dereferences wb->bdi above...

> +			pr_warn("wb->bdi == NULL\n");
> +		else {
> +			pr_warn("list_empty(&wb->bdi->bdi_list)=%u\n",
> +				list_empty(&wb->bdi->bdi_list));
> +			pr_warn("wb->bdi->wb.state=%lx\n", wb->bdi->wb.state);
> +		}

It would be also good to print whether wb == wb->bdi->wb (i.e. it is the
default writeback structure or one for some cgroup) and also
wb->bdi->wb.state.

								Honza

> +		if (!wb->congested)
> +			pr_warn("wb->congested == NULL\n");
> +#ifdef CONFIG_CGROUP_WRITEBACK
> +		else if (!wb->congested->__bdi)
> +			pr_warn("wb->congested->__bdi == NULL\n");
> +		else {
> +			pr_warn("(wb->congested->__bdi == wb->bdi)=%u\n",
> +				wb->congested->__bdi == wb->bdi);
> +			pr_warn("list_empty(&wb->congested->__bdi->bdi_list)=%u\n",
> +				list_empty(&wb->congested->__bdi->bdi_list));
> +			pr_warn("wb->congested->__bdi->wb.state=%lx\n",
> +				wb->congested->__bdi->wb.state);
> +		}
> +#endif
> +		/* Will halt shortly due to NULL pointer dereference... */
> +	}
> +#endif
> +
>  	set_worker_desc("flush-%s", dev_name(wb->bdi->dev));
>  	current->flags |= PF_SWAPWRITE;
>  
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
