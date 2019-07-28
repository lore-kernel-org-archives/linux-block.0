Return-Path: <SRS0=mNKb=VZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860BFC7618B
	for <linux-block@archiver.kernel.org>; Sun, 28 Jul 2019 06:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1142077C
	for <linux-block@archiver.kernel.org>; Sun, 28 Jul 2019 06:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfG1GzW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Jul 2019 02:55:22 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:60559 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbfG1GzW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Jul 2019 02:55:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TXyBr55_1564296916;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TXyBr55_1564296916)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 28 Jul 2019 14:55:17 +0800
Subject: Re: [PATCH 1/3] blk-throttle: support io delay stats
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>
References: <1564023835-99554-1-git-send-email-joseph.qi@linux.alibaba.com>
Message-ID: <a4f4b665-cbcb-a833-1e13-b134cddac921@linux.alibaba.com>
Date:   Sun, 28 Jul 2019 14:55:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564023835-99554-1-git-send-email-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping...

Thanks,
Joseph

On 19/7/25 11:03, Joseph Qi wrote:
> Add blkio.throttle.io_service_time and blkio.throttle.io_wait_time to
> get per-cgroup io delay statistics in blk-throttle layer.
> io_service_time represents the time spent after io throttle to io
> completion, while io_wait_time represents the time spent on throttle
> queue.
> 
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  block/bio.c               |   4 ++
>  block/blk-throttle.c      | 130 +++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/blk_types.h |  34 ++++++++++++
>  3 files changed, 167 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 299a0e7..3206462 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1826,6 +1826,10 @@ void bio_endio(struct bio *bio)
>  	blk_throtl_bio_endio(bio);
>  	/* release cgroup info */
>  	bio_uninit(bio);
> +#ifdef CONFIG_BLK_DEV_THROTTLING
> +	if (bio->bi_tg_end_io)
> +		bio->bi_tg_end_io(bio);
> +#endif
>  	if (bio->bi_end_io)
>  		bio->bi_end_io(bio);
>  }
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 8ab6c81..a5880f0 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -176,6 +176,11 @@ struct throtl_grp {
>  	unsigned int bio_cnt; /* total bios */
>  	unsigned int bad_bio_cnt; /* bios exceeding latency threshold */
>  	unsigned long bio_cnt_reset_time;
> +
> +	/* total time spent on lower layer: scheduler, device and others */
> +	struct blkg_rwstat service_time;
> +	/* total time spent on block throttle */
> +	struct blkg_rwstat wait_time;
>  };
>  
>  /* We measure latency for request size from <= 4k to >= 1M */
> @@ -487,6 +492,10 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
>  	if (!tg)
>  		return NULL;
>  
> +	if (blkg_rwstat_init(&tg->service_time, gfp) ||
> +	    blkg_rwstat_init(&tg->wait_time, gfp))
> +		goto err;
> +
>  	throtl_service_queue_init(&tg->service_queue);
>  
>  	for (rw = READ; rw <= WRITE; rw++) {
> @@ -511,6 +520,12 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
>  	tg->idletime_threshold_conf = DFL_IDLE_THRESHOLD;
>  
>  	return &tg->pd;
> +
> +err:
> +	blkg_rwstat_exit(&tg->service_time);
> +	blkg_rwstat_exit(&tg->wait_time);
> +	kfree(tg);
> +	return NULL;
>  }
>  
>  static void throtl_pd_init(struct blkg_policy_data *pd)
> @@ -592,6 +607,8 @@ static void blk_throtl_update_limit_valid(struct throtl_data *td)
>  static void throtl_pd_offline(struct blkg_policy_data *pd)
>  {
>  	struct throtl_grp *tg = pd_to_tg(pd);
> +	struct blkcg_gq *blkg = pd_to_blkg(pd);
> +	struct blkcg_gq *parent = blkg->parent;
>  
>  	tg->bps[READ][LIMIT_LOW] = 0;
>  	tg->bps[WRITE][LIMIT_LOW] = 0;
> @@ -602,6 +619,12 @@ static void throtl_pd_offline(struct blkg_policy_data *pd)
>  
>  	if (!tg->td->limit_valid[tg->td->limit_index])
>  		throtl_upgrade_state(tg->td);
> +	if (parent) {
> +		blkg_rwstat_add_aux(&blkg_to_tg(parent)->service_time,
> +				    &tg->service_time);
> +		blkg_rwstat_add_aux(&blkg_to_tg(parent)->wait_time,
> +				    &tg->wait_time);
> +	}
>  }
>  
>  static void throtl_pd_free(struct blkg_policy_data *pd)
> @@ -609,9 +632,19 @@ static void throtl_pd_free(struct blkg_policy_data *pd)
>  	struct throtl_grp *tg = pd_to_tg(pd);
>  
>  	del_timer_sync(&tg->service_queue.pending_timer);
> +	blkg_rwstat_exit(&tg->service_time);
> +	blkg_rwstat_exit(&tg->wait_time);
>  	kfree(tg);
>  }
>  
> +static void throtl_pd_reset(struct blkg_policy_data *pd)
> +{
> +	struct throtl_grp *tg = pd_to_tg(pd);
> +
> +	blkg_rwstat_reset(&tg->service_time);
> +	blkg_rwstat_reset(&tg->wait_time);
> +}
> +
>  static struct throtl_grp *
>  throtl_rb_first(struct throtl_service_queue *parent_sq)
>  {
> @@ -1019,6 +1052,64 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>  	return false;
>  }
>  
> +static void throtl_stats_update_completion(struct throtl_grp *tg,
> +					   uint64_t start_time,
> +					   uint64_t io_start_time,
> +					   int op)
> +{
> +	unsigned long flags;
> +	uint64_t now = sched_clock();
> +
> +	local_irq_save(flags);
> +	if (time_after64(now, io_start_time))
> +		blkg_rwstat_add(&tg->service_time, op, now - io_start_time);
> +	if (time_after64(io_start_time, start_time))
> +		blkg_rwstat_add(&tg->wait_time, op, io_start_time - start_time);
> +	local_irq_restore(flags);
> +}
> +
> +static void throtl_bio_end_io(struct bio *bio)
> +{
> +	struct throtl_grp *tg;
> +
> +	rcu_read_lock();
> +	/* see comments in throtl_bio_stats_start() */
> +	if (bio_flagged(bio, BIO_THROTL_STATED))
> +		goto out;
> +
> +	tg = (struct throtl_grp *)bio->bi_tg_private;
> +	if (!tg)
> +		goto out;
> +
> +	throtl_stats_update_completion(tg, bio_start_time_ns(bio),
> +				       bio_io_start_time_ns(bio),
> +				       bio_op(bio));
> +	blkg_put(tg_to_blkg(tg));
> +	bio_clear_flag(bio, BIO_THROTL_STATED);
> +out:
> +	rcu_read_unlock();
> +}
> +
> +static inline void throtl_bio_stats_start(struct bio *bio, struct throtl_grp *tg)
> +{
> +	int op = bio_op(bio);
> +
> +	/*
> +	 * It may happen that end_io will be called twice like dm-thin,
> +	 * which will save origin end_io first, and call its overwrite
> +	 * end_io and then the saved end_io. We use bio flag
> +	 * BIO_THROTL_STATED to do only once statistics.
> +	 */
> +	if ((op == REQ_OP_READ || op == REQ_OP_WRITE) &&
> +	    !bio_flagged(bio, BIO_THROTL_STATED)) {
> +		blkg_get(tg_to_blkg(tg));
> +		bio_set_flag(bio, BIO_THROTL_STATED);
> +		bio->bi_tg_end_io = throtl_bio_end_io;
> +		bio->bi_tg_private = tg;
> +		bio_set_start_time_ns(bio);
> +	}
> +}
> +
>  static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
>  {
>  	bool rw = bio_data_dir(bio);
> @@ -1462,6 +1553,25 @@ static ssize_t tg_set_conf_uint(struct kernfs_open_file *of,
>  	return tg_set_conf(of, buf, nbytes, off, false);
>  }
>  
> +static u64 tg_prfill_rwstat_field(struct seq_file *sf,
> +				  struct blkg_policy_data *pd,
> +				  int off)
> +{
> +	struct throtl_grp *tg = pd_to_tg(pd);
> +	struct blkg_rwstat_sample rwstat = { };
> +
> +	blkg_rwstat_read((void *)tg + off, &rwstat);
> +	return __blkg_prfill_rwstat(sf, pd, &rwstat);
> +}
> +
> +static int tg_print_rwstat(struct seq_file *sf, void *v)
> +{
> +	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
> +			  tg_prfill_rwstat_field, &blkcg_policy_throtl,
> +			  seq_cft(sf)->private, true);
> +	return 0;
> +}
> +
>  static struct cftype throtl_legacy_files[] = {
>  	{
>  		.name = "throttle.read_bps_device",
> @@ -1507,6 +1617,16 @@ static ssize_t tg_set_conf_uint(struct kernfs_open_file *of,
>  		.private = (unsigned long)&blkcg_policy_throtl,
>  		.seq_show = blkg_print_stat_ios_recursive,
>  	},
> +	{
> +		.name = "throttle.io_service_time",
> +		.private = offsetof(struct throtl_grp, service_time),
> +		.seq_show = tg_print_rwstat,
> +	},
> +	{
> +		.name = "throttle.io_wait_time",
> +		.private = offsetof(struct throtl_grp, wait_time),
> +		.seq_show = tg_print_rwstat,
> +	},
>  	{ }	/* terminate */
>  };
>  
> @@ -1732,6 +1852,7 @@ static void throtl_shutdown_wq(struct request_queue *q)
>  	.pd_online_fn		= throtl_pd_online,
>  	.pd_offline_fn		= throtl_pd_offline,
>  	.pd_free_fn		= throtl_pd_free,
> +	.pd_reset_stats_fn	= throtl_pd_reset,
>  };
>  
>  static unsigned long __tg_last_low_overflow_time(struct throtl_grp *tg)
> @@ -2125,7 +2246,12 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
>  	WARN_ON_ONCE(!rcu_read_lock_held());
>  
>  	/* see throtl_charge_bio() */
> -	if (bio_flagged(bio, BIO_THROTTLED) || !tg->has_rules[rw])
> +	if (bio_flagged(bio, BIO_THROTTLED))
> +		goto out;
> +
> +	throtl_bio_stats_start(bio, tg);
> +
> +	if (!tg->has_rules[rw])
>  		goto out;
>  
>  	spin_lock_irq(&q->queue_lock);
> @@ -2212,6 +2338,8 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
>  out_unlock:
>  	spin_unlock_irq(&q->queue_lock);
>  out:
> +	if (!throttled)
> +		bio_set_io_start_time_ns(bio);
>  	bio_set_flag(bio, BIO_THROTTLED);
>  
>  #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index feff3fe..6906bc6 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -9,6 +9,7 @@
>  #include <linux/types.h>
>  #include <linux/bvec.h>
>  #include <linux/ktime.h>
> +#include <linux/sched/clock.h>
>  
>  struct bio_set;
>  struct bio;
> @@ -169,6 +170,12 @@ struct bio {
>  	 */
>  	struct blkcg_gq		*bi_blkg;
>  	struct bio_issue	bi_issue;
> +#ifdef CONFIG_BLK_DEV_THROTTLING
> +	unsigned long long	start_time_ns;	/* when passed to block throttle */
> +	unsigned long long	io_start_time_ns;	/* when no more throttle */
> +	bio_end_io_t		*bi_tg_end_io;
> +	void			*bi_tg_private;
> +#endif
>  #endif
>  	union {
>  #if defined(CONFIG_BLK_DEV_INTEGRITY)
> @@ -218,6 +225,7 @@ enum {
>  				 * of this bio. */
>  	BIO_QUEUE_ENTERED,	/* can use blk_queue_enter_live() */
>  	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
> +	BIO_THROTL_STATED,	/* bio already stated */
>  	BIO_FLAG_LAST
>  };
>  
> @@ -248,6 +256,32 @@ enum {
>   */
>  #define BIO_RESET_BITS	BVEC_POOL_OFFSET
>  
> +#ifdef CONFIG_BLK_DEV_THROTTLING
> +static inline void bio_set_start_time_ns(struct bio *bio)
> +{
> +	preempt_disable();
> +	bio->start_time_ns = sched_clock();
> +	preempt_enable();
> +}
> +
> +static inline void bio_set_io_start_time_ns(struct bio *bio)
> +{
> +	preempt_disable();
> +	bio->io_start_time_ns = sched_clock();
> +	preempt_enable();
> +}
> +
> +static inline uint64_t bio_start_time_ns(struct bio *bio)
> +{
> +	return bio->start_time_ns;
> +}
> +
> +static inline uint64_t bio_io_start_time_ns(struct bio *bio)
> +{
> +	return bio->io_start_time_ns;
> +}
> +#endif
> +
>  typedef __u32 __bitwise blk_mq_req_flags_t;
>  
>  /*
> 
