Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751281AbdKPQ5d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Nov 2017 11:57:33 -0500
Date: Thu, 16 Nov 2017 08:50:33 -0800
From: Shaohua Li <shli@kernel.org>
To: Khazhismel Kumykov <khazhy@google.com>
Cc: axobe@kernel.dk, shli@fb.com, vgoyal@redhat.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH] blk-throttle: add burst allowance.
Message-ID: <20171116165033.4noofd6gkaj6x3yl@kernel.org>
References: <20171114231022.42961-1-khazhy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171114231022.42961-1-khazhy@google.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 14, 2017 at 03:10:22PM -0800, Khazhismel Kumykov wrote:
> Allows configuration additional bytes or ios before a throttle is
> triggered.
> 
> This allows implementation of a bucket style rate-limit/throttle on a
> block device. Previously, bursting to a device was limited to allowance
> granted in a single throtl_slice (similar to a bucket with limit N and
> refill rate N/slice).
> 
> Additional parameters bytes/io_burst_conf defined for tg, which define a
> number of bytes/ios that must be depleted before throttling happens. A
> tg that does not deplete this allowance functions as though it has no
> configured limits. tgs earn additional allowance at rate defined by
> bps/iops for the tg. Once a tg has *_disp > *_burst_conf, throttling
> kicks in. If a tg is idle for a while, it will again have some burst
> allowance before it gets throttled again.
> 
> slice_end for a tg is extended until io_disp/byte_disp would fall to 0,
> when all "used" burst allowance would be earned back. trim_slice still
> does progress slice_start as before and decrements *_disp as before, and
> tgs continue to get bytes/ios in throtl_slice intervals.

Can you describe why we need this? It would be great if you can describe the
usage model and an example. Does this work for io.low/io.max or both?

Thanks,
Shaohua
 
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
>  block/Kconfig        |  11 +++
>  block/blk-throttle.c | 192 +++++++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 189 insertions(+), 14 deletions(-)
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index 28ec55752b68..fbd05b419f93 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -128,6 +128,17 @@ config BLK_DEV_THROTTLING_LOW
>  
>  	Note, this is an experimental interface and could be changed someday.
>  
> +config BLK_DEV_THROTTLING_BURST
> +    bool "Block throttling .burst allowance interface"
> +    depends on BLK_DEV_THROTTLING
> +    default n
> +    ---help---
> +    Add .burst allowance for block throttling. Burst allowance allows for
> +    additional unthrottled usage, while still limiting speed for sustained
> +    usage.
> +
> +    If in doubt, say N.
> +
>  config BLK_CMDLINE_PARSER
>  	bool "Block device command line partition parser"
>  	default n
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 96ad32623427..27c084312772 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -157,6 +157,11 @@ struct throtl_grp {
>  	/* Number of bio's dispatched in current slice */
>  	unsigned int io_disp[2];
>  
> +#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
> +	uint64_t bytes_burst_conf[2];
> +	unsigned int io_burst_conf[2];
> +#endif
> +
>  	unsigned long last_low_overflow_time[2];
>  
>  	uint64_t last_bytes_disp[2];
> @@ -507,6 +512,12 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
>  	tg->bps_conf[WRITE][LIMIT_MAX] = U64_MAX;
>  	tg->iops_conf[READ][LIMIT_MAX] = UINT_MAX;
>  	tg->iops_conf[WRITE][LIMIT_MAX] = UINT_MAX;
> +#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
> +	tg->bytes_burst_conf[READ] = 0;
> +	tg->bytes_burst_conf[WRITE] = 0;
> +	tg->io_burst_conf[READ] = 0;
> +	tg->io_burst_conf[WRITE] = 0;
> +#endif
>  	/* LIMIT_LOW will have default value 0 */
>  
>  	tg->latency_target = DFL_LATENCY_TARGET;
> @@ -800,6 +811,26 @@ static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw)
>  		   tg->slice_end[rw], jiffies);
>  }
>  
> +/*
> + * When current slice should end.
> + *
> + * With CONFIG_BLK_DEV_THROTTLING_BURST, we will wait longer than min_wait
> + * for slice to recover used burst allowance. (*_disp -> 0). Setting slice_end
> + * before this would result in tg receiving additional burst allowance.
> + */
> +static inline unsigned long throtl_slice_wait(struct throtl_grp *tg, bool rw,
> +						unsigned long min_wait)
> +{
> +	unsigned long bytes_wait = 0, io_wait = 0;
> +#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
> +	if (tg->bytes_burst_conf[rw])
> +		bytes_wait = (tg->bytes_disp[rw] * HZ) / tg_bps_limit(tg, rw);
> +	if (tg->io_burst_conf[rw])
> +		io_wait = (tg->io_disp[rw] * HZ) / tg_iops_limit(tg, rw);
> +#endif
> +	return max(min_wait, max(bytes_wait, io_wait));
> +}
> +
>  static inline void throtl_set_slice_end(struct throtl_grp *tg, bool rw,
>  					unsigned long jiffy_end)
>  {
> @@ -849,7 +880,8 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>  	 * is bad because it does not allow new slice to start.
>  	 */
>  
> -	throtl_set_slice_end(tg, rw, jiffies + tg->td->throtl_slice);
> +	throtl_set_slice_end(tg, rw,
> +		jiffies + throtl_slice_wait(tg, rw, tg->td->throtl_slice));
>  
>  	time_elapsed = jiffies - tg->slice_start[rw];
>  
> @@ -889,7 +921,7 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
>  				  unsigned long *wait)
>  {
>  	bool rw = bio_data_dir(bio);
> -	unsigned int io_allowed;
> +	unsigned int io_allowed, io_disp;
>  	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
>  	u64 tmp;
>  
> @@ -908,6 +940,17 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
>  	 * have been trimmed.
>  	 */
>  
> +	io_disp = tg->io_disp[rw];
> +
> +#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
> +	if (tg->io_disp[rw] < tg->io_burst_conf[rw]) {
> +		if (wait)
> +			*wait = 0;
> +		return true;
> +	}
> +	io_disp -= tg->io_burst_conf[rw];
> +#endif
> +
>  	tmp = (u64)tg_iops_limit(tg, rw) * jiffy_elapsed_rnd;
>  	do_div(tmp, HZ);
>  
> @@ -916,14 +959,14 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
>  	else
>  		io_allowed = tmp;
>  
> -	if (tg->io_disp[rw] + 1 <= io_allowed) {
> +	if (io_disp + 1 <= io_allowed) {
>  		if (wait)
>  			*wait = 0;
>  		return true;
>  	}
>  
>  	/* Calc approx time to dispatch */
> -	jiffy_wait = ((tg->io_disp[rw] + 1) * HZ) / tg_iops_limit(tg, rw) + 1;
> +	jiffy_wait = ((io_disp + 1) * HZ) / tg_iops_limit(tg, rw) + 1;
>  
>  	if (jiffy_wait > jiffy_elapsed)
>  		jiffy_wait = jiffy_wait - jiffy_elapsed;
> @@ -939,7 +982,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
>  				 unsigned long *wait)
>  {
>  	bool rw = bio_data_dir(bio);
> -	u64 bytes_allowed, extra_bytes, tmp;
> +	u64 bytes_allowed, extra_bytes, bytes_disp, tmp;
>  	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
>  	unsigned int bio_size = throtl_bio_data_size(bio);
>  
> @@ -951,18 +994,28 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
>  
>  	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
>  
> +	bytes_disp = tg->bytes_disp[rw];
> +#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
> +	if (tg->bytes_disp[rw] < tg->bytes_burst_conf[rw]) {
> +		if (wait)
> +			*wait = 0;
> +		return true;
> +	}
> +	bytes_disp -= tg->bytes_burst_conf[rw];
> +#endif
> +
>  	tmp = tg_bps_limit(tg, rw) * jiffy_elapsed_rnd;
>  	do_div(tmp, HZ);
>  	bytes_allowed = tmp;
>  
> -	if (tg->bytes_disp[rw] + bio_size <= bytes_allowed) {
> +	if (bytes_disp + bio_size <= bytes_allowed) {
>  		if (wait)
>  			*wait = 0;
>  		return true;
>  	}
>  
>  	/* Calc approx time to dispatch */
> -	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
> +	extra_bytes = bytes_disp + bio_size - bytes_allowed;
>  	jiffy_wait = div64_u64(extra_bytes * HZ, tg_bps_limit(tg, rw));
>  
>  	if (!jiffy_wait)
> @@ -986,7 +1039,7 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>  			    unsigned long *wait)
>  {
>  	bool rw = bio_data_dir(bio);
> -	unsigned long bps_wait = 0, iops_wait = 0, max_wait = 0;
> +	unsigned long bps_wait = 0, iops_wait = 0, max_wait = 0, disp_time;
>  
>  	/*
>   	 * Currently whole state machine of group depends on first bio
> @@ -1015,10 +1068,10 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>  	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
>  		throtl_start_new_slice(tg, rw);
>  	else {
> -		if (time_before(tg->slice_end[rw],
> -		    jiffies + tg->td->throtl_slice))
> -			throtl_extend_slice(tg, rw,
> -				jiffies + tg->td->throtl_slice);
> +		disp_time = jiffies + throtl_slice_wait(
> +				tg, rw, tg->td->throtl_slice);
> +		if (time_before(tg->slice_end[rw], disp_time))
> +			throtl_extend_slice(tg, rw, disp_time);
>  	}
>  
>  	if (tg_with_in_bps_limit(tg, bio, &bps_wait) &&
> @@ -1033,8 +1086,9 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>  	if (wait)
>  		*wait = max_wait;
>  
> -	if (time_before(tg->slice_end[rw], jiffies + max_wait))
> -		throtl_extend_slice(tg, rw, jiffies + max_wait);
> +	disp_time = jiffies + throtl_slice_wait(tg, rw, max_wait);
> +	if (time_before(tg->slice_end[rw], disp_time))
> +		throtl_extend_slice(tg, rw, disp_time);
>  
>  	return 0;
>  }
> @@ -1705,6 +1759,108 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
>  	return ret ?: nbytes;
>  }
>  
> +#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
> +static u64 tg_prfill_burst(struct seq_file *sf, struct blkg_policy_data *pd,
> +			   int data)
> +{
> +	struct throtl_grp *tg = pd_to_tg(pd);
> +	const char *dname = blkg_dev_name(pd->blkg);
> +	char bufs[4][21];
> +
> +	if (!dname)
> +		return 0;
> +
> +	if (tg->bytes_burst_conf[READ] == 0 &&
> +	    tg->bytes_burst_conf[WRITE] == 0 &&
> +	    tg->io_burst_conf[READ] == 0 &&
> +	    tg->io_burst_conf[WRITE] == 0)
> +		return 0;
> +
> +	snprintf(bufs[0], sizeof(bufs[0]), "%llu",
> +		tg->bytes_burst_conf[READ]);
> +	snprintf(bufs[1], sizeof(bufs[1]), "%llu",
> +		tg->bytes_burst_conf[WRITE]);
> +	snprintf(bufs[2], sizeof(bufs[2]), "%u",
> +		tg->io_burst_conf[READ]);
> +	snprintf(bufs[3], sizeof(bufs[3]), "%u",
> +		tg->io_burst_conf[WRITE]);
> +
> +	seq_printf(sf, "%s brbyte=%s bwbyte=%s brio=%s bwio=%s\n",
> +		   dname, bufs[0], bufs[1], bufs[2], bufs[3]);
> +	return 0;
> +}
> +
> +static int tg_print_burst(struct seq_file *sf, void *v)
> +{
> +	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), tg_prfill_burst,
> +			  &blkcg_policy_throtl, 0, false);
> +	return 0;
> +}
> +
> +static ssize_t tg_set_burst(struct kernfs_open_file *of,
> +			  char *buf, size_t nbytes, loff_t off)
> +{
> +	struct blkcg *blkcg = css_to_blkcg(of_css(of));
> +	struct blkg_conf_ctx ctx;
> +	struct throtl_grp *tg;
> +	u64 v[4];
> +	int ret;
> +
> +	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, buf, &ctx);
> +	if (ret)
> +		return ret;
> +
> +	tg = blkg_to_tg(ctx.blkg);
> +
> +	v[0] = tg->bytes_burst_conf[READ];
> +	v[1] = tg->bytes_burst_conf[WRITE];
> +	v[2] = tg->io_burst_conf[READ];
> +	v[3] = tg->io_burst_conf[WRITE];
> +
> +	while (true) {
> +		char tok[28];	/* bwbyte=18446744073709551616 */
> +		char *p;
> +		u64 val = U64_MAX;
> +		int len;
> +
> +		if (sscanf(ctx.body, "%27s%n", tok, &len) != 1)
> +			break;
> +		if (tok[0] == '\0')
> +			break;
> +		ctx.body += len;
> +
> +		ret = -EINVAL;
> +		p = tok;
> +		strsep(&p, "=");
> +		if (!p || (kstrtoull(p, 0, &val) != 0 && strcmp(p, "max")))
> +			goto out_finish;
> +
> +		ret = -EINVAL;
> +		if (!strcmp(tok, "brbyte"))
> +			v[0] = val;
> +		else if (!strcmp(tok, "bwbyte"))
> +			v[1] = val;
> +		else if (!strcmp(tok, "brio"))
> +			v[2] = min_t(u64, val, UINT_MAX);
> +		else if (!strcmp(tok, "bwio"))
> +			v[3] = min_t(u64, val, UINT_MAX);
> +		else
> +			goto out_finish;
> +	}
> +
> +	tg->bytes_burst_conf[READ] = v[0];
> +	tg->bytes_burst_conf[WRITE] = v[1];
> +	tg->io_burst_conf[READ] = v[2];
> +	tg->io_burst_conf[WRITE] = v[3];
> +
> +	tg_conf_updated(tg, false);
> +	ret = 0;
> +out_finish:
> +	blkg_conf_finish(&ctx);
> +	return ret ?: nbytes;
> +}
> +#endif
> +
>  static struct cftype throtl_files[] = {
>  #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
>  	{
> @@ -1714,6 +1870,14 @@ static struct cftype throtl_files[] = {
>  		.write = tg_set_limit,
>  		.private = LIMIT_LOW,
>  	},
> +#endif
> +#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
> +	{
> +		.name = "burst",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = tg_print_burst,
> +		.write = tg_set_burst,
> +	},
>  #endif
>  	{
>  		.name = "max",
> -- 
> 2.15.0.448.gf294e3d99a-goog
> 
