Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34903 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937169AbdAIVj1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2017 16:39:27 -0500
Date: Mon, 9 Jan 2017 16:39:19 -0500
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, axboe@fb.com, vgoyal@redhat.com
Subject: Re: [PATCH V5 16/17] blk-throttle: add a mechanism to estimate IO
 latency
Message-ID: <20170109213919.GU12827@mtj.duckdns.org>
References: <cover.1481833017.git.shli@fb.com>
 <53ba1d9ed13cf6d3fd5a51ad84ae3219571d6c2f.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53ba1d9ed13cf6d3fd5a51ad84ae3219571d6c2f.1481833017.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Thu, Dec 15, 2016 at 12:33:07PM -0800, Shaohua Li wrote:
> User configures latency target, but the latency threshold for each
> request size isn't fixed. For a SSD, the IO latency highly depends on
> request size. To calculate latency threshold, we sample some data, eg,
> average latency for request size 4k, 8k, 16k, 32k .. 1M. The latency
> threshold of each request size will be the sample latency (I'll call it
> base latency) plus latency target. For example, the base latency for
> request size 4k is 80us and user configures latency target 60us. The 4k
> latency threshold will be 80 + 60 = 140us.

Ah okay, the user configures the extra latency.  Yeah, this is way
better than treating what the user configures as the target latency
for 4k IOs.

> @@ -25,6 +25,8 @@ static int throtl_quantum = 32;
>  #define DFL_IDLE_THRESHOLD_HD (1000 * 1000) /* 1 ms */
>  #define MAX_IDLE_TIME (500L * 1000 * 1000) /* 500 ms */
>  
> +#define SKIP_TRACK (((u64)1) << BLK_STAT_RES_SHIFT)

SKIP_LATENCY?

> +static void throtl_update_latency_buckets(struct throtl_data *td)
> +{
> +	struct avg_latency_bucket avg_latency[LATENCY_BUCKET_SIZE];
> +	int i, cpu;
> +	u64 last_latency = 0;
> +	u64 latency;
> +
> +	if (!blk_queue_nonrot(td->queue))
> +		return;
> +	if (time_before(jiffies, td->last_calculate_time + HZ))
> +		return;
> +	td->last_calculate_time = jiffies;
> +
> +	memset(avg_latency, 0, sizeof(avg_latency));
> +	for (i = 0; i < LATENCY_BUCKET_SIZE; i++) {
> +		struct latency_bucket *tmp = &td->tmp_buckets[i];
> +
> +		for_each_possible_cpu(cpu) {
> +			struct latency_bucket *bucket;
> +
> +			/* this isn't race free, but ok in practice */
> +			bucket = per_cpu_ptr(td->latency_buckets, cpu);
> +			tmp->total_latency += bucket[i].total_latency;
> +			tmp->samples += bucket[i].samples;

Heh, this *can* lead to surprising results (like reading zero for a
value larger than 2^32) on 32bit machines due to split updates, and if
we're using nanosecs, those surprises have a chance, albeit low, of
happening every four secs, which is a bit unsettling.  If we have to
use nanosecs, let's please use u64_stats_sync.  If we're okay with
microsecs, ulongs should be fine.

>  void blk_throtl_bio_endio(struct bio *bio)
>  {
>  	struct throtl_grp *tg;
> +	u64 finish_time;
> +	u64 start_time;
> +	u64 lat;
>  
>  	tg = bio->bi_cg_private;
>  	if (!tg)
>  		return;
>  	bio->bi_cg_private = NULL;
>  
> -	tg->last_finish_time = ktime_get_ns();
> +	finish_time = ktime_get_ns();
> +	tg->last_finish_time = finish_time;
> +
> +	start_time = blk_stat_time(&bio->bi_issue_stat);
> +	finish_time = __blk_stat_time(finish_time);
> +	if (start_time && finish_time > start_time &&
> +	    tg->td->track_bio_latency == 1 &&
> +	    !(bio->bi_issue_stat.stat & SKIP_TRACK)) {

Heh, can't we collapse some of the conditions?  e.g. flip SKIP_TRACK
to TRACK_LATENCY and set it iff the td has track_bio_latency set and
also the bio has start time set?

> @@ -2106,6 +2251,12 @@ int blk_throtl_init(struct request_queue *q)
>  	td = kzalloc_node(sizeof(*td), GFP_KERNEL, q->node);
>  	if (!td)
>  		return -ENOMEM;
> +	td->latency_buckets = __alloc_percpu(sizeof(struct latency_bucket) *
> +		LATENCY_BUCKET_SIZE, __alignof__(u64));
> +	if (!td->latency_buckets) {
> +		kfree(td);
> +		return -ENOMEM;
> +	}
>  
>  	INIT_WORK(&td->dispatch_work, blk_throtl_dispatch_work_fn);
>  	throtl_service_queue_init(&td->service_queue);
> @@ -2119,10 +2270,13 @@ int blk_throtl_init(struct request_queue *q)
>  	td->low_upgrade_time = jiffies;
>  	td->low_downgrade_time = jiffies;
>  
> +	td->track_bio_latency = UINT_MAX;

I don't think using 0, 1, UINT_MAX as enums is good for readability.

Thanks.

-- 
tejun
