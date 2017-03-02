Return-Path: <jack@suse.cz>
Date: Thu, 2 Mar 2017 11:29:45 +0100
From: Jan Kara <jack@suse.cz>
To: Hou Tao <houtao1@huawei.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, jmoyer@redhat.com,
	jack@suse.cz, stable@vger.kernel.org
Subject: Re: [PATCH] cfq-iosched: fix the delay of cfq_group's vdisktime
 under iops mode
Message-ID: <20170302102945.GA31792@quack2.suse.cz>
References: <1488334064-34883-1-git-send-email-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1488334064-34883-1-git-send-email-houtao1@huawei.com>
List-ID: <linux-block@vger.kernel.org>

On Wed 01-03-17 10:07:44, Hou Tao wrote:
> When adding a cfq_group into the cfq service tree, we use CFQ_IDLE_DELAY
> as the delay of cfq_group's vdisktime if there have been other cfq_groups
> already.
> 
> When cfq is under iops mode, commit 9a7f38c42c2b ("cfq-iosched: Convert
> from jiffies to nanoseconds") could result in a large iops delay and
> lead to an abnormal io schedule delay for the added cfq_group. To fix
> it, we just need to revert to the old CFQ_IDLE_DELAY value: HZ / 5
> when iops mode is enabled.
> 
> Cc: <stable@vger.kernel.org> # 4.8+
> Signed-off-by: Hou Tao <houtao1@huawei.com>

OK, I agree my commit broke the logic in this case. Thanks for the fix.
Please add also tag:

Fixes: 9a7f38c42c2b92391d9dabaf9f51df7cfe5608e4

I somewhat disagree with the fix though. See below:

> +static inline u64 cfq_get_cfqg_vdisktime_delay(struct cfq_data *cfqd)
> +{
> +	if (!iops_mode(cfqd))
> +		return CFQ_IDLE_DELAY;
> +	else
> +		return nsecs_to_jiffies64(CFQ_IDLE_DELAY);
> +}
> +

So using nsecs_to_jiffies64(CFQ_IDLE_DELAY) when in iops mode just does not
make any sense. AFAIU the code in cfq_group_notify_queue_add() we just want
to add the cfqg as the last one in the tree. So returning 1 from
cfq_get_cfqg_vdisktime_delay() in iops mode should be fine as well.

Frankly, vdisktime is in fixed-point precision shifted by
CFQ_SERVICE_SHIFT so using CFQ_IDLE_DELAY does not make much sense in any
case and just adding 1 to maximum vdisktime should be fine in all the
cases. But that would require more testing whether I did not miss anything
subtle.

								Honza

>  static void
>  cfq_group_notify_queue_add(struct cfq_data *cfqd, struct cfq_group *cfqg)
>  {
> @@ -1380,7 +1388,8 @@ cfq_group_notify_queue_add(struct cfq_data *cfqd, struct cfq_group *cfqg)
>  	n = rb_last(&st->rb);
>  	if (n) {
>  		__cfqg = rb_entry_cfqg(n);
> -		cfqg->vdisktime = __cfqg->vdisktime + CFQ_IDLE_DELAY;
> +		cfqg->vdisktime = __cfqg->vdisktime +
> +			cfq_get_cfqg_vdisktime_delay(cfqd);
>  	} else
>  		cfqg->vdisktime = st->min_vdisktime;
>  	cfq_group_service_tree_add(st, cfqg);
> -- 
> 2.5.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
