Return-Path: <houtao1@huawei.com>
Subject: Re: [PATCH v2] cfq-iosched: fix the delay of cfq_group's vdisktime
 under iops mode
To: Jens Axboe <axboe@kernel.dk>
References: <1488975415-40417-1-git-send-email-houtao1@huawei.com>
 <20170308140518.GE19740@quack2.suse.cz>
 <dc6db873-1958-7812-bfea-5d9396c53818@huawei.com>
CC: <linux-block@vger.kernel.org>, Jan Kara <jack@suse.cz>
From: Hou Tao <houtao1@huawei.com>
Message-ID: <23092e51-2ee6-fc0d-988b-6c540e4f8661@huawei.com>
Date: Wed, 31 May 2017 11:09:36 +0800
MIME-Version: 1.0
In-Reply-To: <dc6db873-1958-7812-bfea-5d9396c53818@huawei.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

I didn't found the patch in your linux-block git tree and the vanilla git tree.
Maybe you have forgot this CFQ fix ?

Regards,
Tao

On 2017/3/9 19:22, Hou Tao wrote:
> On 2017/3/8 22:05, Jan Kara wrote:
>> On Wed 08-03-17 20:16:55, Hou Tao wrote:
>>> When adding a cfq_group into the cfq service tree, we use CFQ_IDLE_DELAY
>>> as the delay of cfq_group's vdisktime if there have been other cfq_groups
>>> already.
>>>
>>> When cfq is under iops mode, commit 9a7f38c42c2b ("cfq-iosched: Convert
>>> from jiffies to nanoseconds") could result in a large iops delay and
>>> lead to an abnormal io schedule delay for the added cfq_group. To fix
>>> it, we just need to revert to the old CFQ_IDLE_DELAY value: HZ / 5
>>> when iops mode is enabled.
>>>
>>> Despite having the same value, the delay of a cfq_queue in idle class
>>> and the delay of cfq_queue are different things, so I define two new
>>> macros for the delay of a cfq_group under time-slice mode and IOPs mode.
>>>
>>> Fixes: 9a7f38c42c2b92391d9dabaf9f51df7cfe5608e4
>>> Cc: <stable@vger.kernel.org> # 4.8+
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>
>> OK, the number 200 is somewhat arbitrary but so is HZ/5 so I guess we are
>> OK. You can add:
>>
>> Acked-by: Jan Kara <jack@suse.cz>
> Oops, sorry for the arbitrary 200. My intention was to use HZ / 5 instead of 200
> to keep consistent with the old CFQ_IDLE_DELAY. And I spot two typos in commit
> message: "the delay of cfq_queue" -> "the delay of cfq_group" and "IOPs" -> "iops".
> 
> Jan, could you please fix them ? And I also attach a revised patch to fix them.
> 
> 
> From: Hou Tao <houtao1@huawei.com>
> Date: Wed, 1 Mar 2017 09:02:33 +0800
> Subject: [PATCH] cfq-iosched: fix the delay of cfq_group's vdisktime under
>  iops mode
> 
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
> Despite having the same value, the delay of a cfq_queue in idle class
> and the delay of cfq_group are different things, so I define two new
> macros for the delay of a cfq_group under time-slice mode and iops mode.
> 
> Fixes: 9a7f38c42c2b92391d9dabaf9f51df7cfe5608e4
> Cc: <stable@vger.kernel.org> # 4.8+
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Acked-by: Jan Kara <jack@suse.cz>
> ---
>  block/cfq-iosched.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
> index 440b95e..2762505 100644
> --- a/block/cfq-iosched.c
> +++ b/block/cfq-iosched.c
> @@ -38,9 +38,13 @@ static const u64 cfq_target_latency = (u64)NSEC_PER_SEC * 3/10; /* 300 ms */
>  static const int cfq_hist_divisor = 4;
> 
>  /*
> - * offset from end of service tree
> + * offset from end of queue service tree for idle class
>   */
>  #define CFQ_IDLE_DELAY		(NSEC_PER_SEC / 5)
> +/* offset from end of group service tree under time slice mode */
> +#define CFQ_SLICE_MODE_GROUP_DELAY (NSEC_PER_SEC / 5)
> +/* offset from end of group service under IOPS mode */
> +#define CFQ_IOPS_MODE_GROUP_DELAY (HZ / 5)
> 
>  /*
>   * below this threshold, we consider thinktime immediate
> @@ -1362,6 +1366,14 @@ cfq_group_service_tree_add(struct cfq_rb_root *st, struct cfq_group *cfqg)
>  	cfqg->vfraction = max_t(unsigned, vfr, 1);
>  }
> 
> +static inline u64 cfq_get_cfqg_vdisktime_delay(struct cfq_data *cfqd)
> +{
> +	if (!iops_mode(cfqd))
> +		return CFQ_SLICE_MODE_GROUP_DELAY;
> +	else
> +		return CFQ_IOPS_MODE_GROUP_DELAY;
> +}
> +
>  static void
>  cfq_group_notify_queue_add(struct cfq_data *cfqd, struct cfq_group *cfqg)
>  {
> @@ -1381,7 +1393,8 @@ cfq_group_notify_queue_add(struct cfq_data *cfqd, struct cfq_group *cfqg)
>  	n = rb_last(&st->rb);
>  	if (n) {
>  		__cfqg = rb_entry_cfqg(n);
> -		cfqg->vdisktime = __cfqg->vdisktime + CFQ_IDLE_DELAY;
> +		cfqg->vdisktime = __cfqg->vdisktime +
> +			cfq_get_cfqg_vdisktime_delay(cfqd);
>  	} else
>  		cfqg->vdisktime = st->min_vdisktime;
>  	cfq_group_service_tree_add(st, cfqg);
> 
