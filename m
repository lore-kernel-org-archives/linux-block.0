Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7DDC76196
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 07:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDJH66 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 03:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJH65 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 03:58:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79BD3593
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 00:58:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63C0560C89
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 07:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E85C433D2;
        Mon, 10 Apr 2023 07:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681113534;
        bh=RJZOa/UXp+yuDs9pMcrdweLyQuot9euaJKfMtCcazjU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VxXMjGTuHkTC9zKSDWcYW4j5NNAi5pzhnCKTA8w1K2hcB16zRjx4vX+DryGXjOT/B
         MI19c62G8mUOnM6RXysc+2D0GN1FskFqjEzsNCavI3g94tkMawFMOxJL0vn7bJQSGF
         NjF3tkoWH+BAhsXNjkShZd8quRYS0UQxUg9zKnmMzF9AajPv9+xQofE4v8+PV4sc+1
         1xBbSDDUvKy9HbokM4Z4eHnnSM4iKpglb2cyeFd/xc6lbJIAHK6i4VLgOlUR7wf7BX
         UOR9yP07SWxpsO6Py/XfzaMdDNLadvk8neqyd7GprHzig1MxJwf7bHGHNspXhcsX5n
         IM7Z93NpcBESw==
Message-ID: <ea4d2bd5-573e-7ef5-45e4-d1bdf717fb69@kernel.org>
Date:   Mon, 10 Apr 2023 16:58:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 05/12] block: One requeue list per hctx
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-6-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230407235822.1672286-6-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/23 08:58, Bart Van Assche wrote:
> Prepare for processing the requeue list from inside __blk_mq_run_hw_queue().

With such short comment, it is hard to see exactly what this patch is trying to
do. The first part seems to be adding debugfs stuff, which I think is fine, but
should be its own patch. The second part move the requeue work from per qeue to
per hctx as I understand it. Why ? Can you explain that here ?

> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq-debugfs.c | 66 +++++++++++++++++++++---------------------
>  block/blk-mq.c         | 58 +++++++++++++++++++++++--------------
>  include/linux/blk-mq.h |  4 +++
>  include/linux/blkdev.h |  4 ---
>  4 files changed, 73 insertions(+), 59 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 212a7f301e73..5eb930754347 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -20,37 +20,6 @@ static int queue_poll_stat_show(void *data, struct seq_file *m)
>  	return 0;
>  }
>  
> -static void *queue_requeue_list_start(struct seq_file *m, loff_t *pos)
> -	__acquires(&q->requeue_lock)
> -{
> -	struct request_queue *q = m->private;
> -
> -	spin_lock_irq(&q->requeue_lock);
> -	return seq_list_start(&q->requeue_list, *pos);
> -}
> -
> -static void *queue_requeue_list_next(struct seq_file *m, void *v, loff_t *pos)
> -{
> -	struct request_queue *q = m->private;
> -
> -	return seq_list_next(v, &q->requeue_list, pos);
> -}
> -
> -static void queue_requeue_list_stop(struct seq_file *m, void *v)
> -	__releases(&q->requeue_lock)
> -{
> -	struct request_queue *q = m->private;
> -
> -	spin_unlock_irq(&q->requeue_lock);
> -}
> -
> -static const struct seq_operations queue_requeue_list_seq_ops = {
> -	.start	= queue_requeue_list_start,
> -	.next	= queue_requeue_list_next,
> -	.stop	= queue_requeue_list_stop,
> -	.show	= blk_mq_debugfs_rq_show,
> -};
> -
>  static int blk_flags_show(struct seq_file *m, const unsigned long flags,
>  			  const char *const *flag_name, int flag_name_count)
>  {
> @@ -156,11 +125,10 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
>  
>  static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
>  	{ "poll_stat", 0400, queue_poll_stat_show },
> -	{ "requeue_list", 0400, .seq_ops = &queue_requeue_list_seq_ops },
>  	{ "pm_only", 0600, queue_pm_only_show, NULL },
>  	{ "state", 0600, queue_state_show, queue_state_write },
>  	{ "zone_wlock", 0400, queue_zone_wlock_show, NULL },
> -	{ },
> +	{},
>  };
>  
>  #define HCTX_STATE_NAME(name) [BLK_MQ_S_##name] = #name
> @@ -513,6 +481,37 @@ static int hctx_dispatch_busy_show(void *data, struct seq_file *m)
>  	return 0;
>  }
>  
> +static void *hctx_requeue_list_start(struct seq_file *m, loff_t *pos)
> +	__acquires(&hctx->requeue_lock)
> +{
> +	struct blk_mq_hw_ctx *hctx = m->private;
> +
> +	spin_lock_irq(&hctx->requeue_lock);
> +	return seq_list_start(&hctx->requeue_list, *pos);
> +}
> +
> +static void *hctx_requeue_list_next(struct seq_file *m, void *v, loff_t *pos)
> +{
> +	struct blk_mq_hw_ctx *hctx = m->private;
> +
> +	return seq_list_next(v, &hctx->requeue_list, pos);
> +}
> +
> +static void hctx_requeue_list_stop(struct seq_file *m, void *v)
> +	__releases(&hctx->requeue_lock)
> +{
> +	struct blk_mq_hw_ctx *hctx = m->private;
> +
> +	spin_unlock_irq(&hctx->requeue_lock);
> +}
> +
> +static const struct seq_operations hctx_requeue_list_seq_ops = {
> +	.start = hctx_requeue_list_start,
> +	.next = hctx_requeue_list_next,
> +	.stop = hctx_requeue_list_stop,
> +	.show = blk_mq_debugfs_rq_show,
> +};
> +
>  #define CTX_RQ_SEQ_OPS(name, type)					\
>  static void *ctx_##name##_rq_list_start(struct seq_file *m, loff_t *pos) \
>  	__acquires(&ctx->lock)						\
> @@ -628,6 +627,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
>  	{"run", 0600, hctx_run_show, hctx_run_write},
>  	{"active", 0400, hctx_active_show},
>  	{"dispatch_busy", 0400, hctx_dispatch_busy_show},
> +	{"requeue_list", 0400, .seq_ops = &hctx_requeue_list_seq_ops},
>  	{"type", 0400, hctx_type_show},
>  	{},
>  };
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 77fdaed4e074..deb3d08a6b26 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1411,14 +1411,17 @@ EXPORT_SYMBOL(blk_mq_requeue_request);
>  
>  static void blk_mq_requeue_work(struct work_struct *work)
>  {
> -	struct request_queue *q =
> -		container_of(work, struct request_queue, requeue_work.work);
> +	struct blk_mq_hw_ctx *hctx =
> +		container_of(work, struct blk_mq_hw_ctx, requeue_work.work);
>  	LIST_HEAD(rq_list);
>  	struct request *rq, *next;
>  
> -	spin_lock_irq(&q->requeue_lock);
> -	list_splice_init(&q->requeue_list, &rq_list);
> -	spin_unlock_irq(&q->requeue_lock);
> +	if (list_empty_careful(&hctx->requeue_list))
> +		return;
> +
> +	spin_lock_irq(&hctx->requeue_lock);
> +	list_splice_init(&hctx->requeue_list, &rq_list);
> +	spin_unlock_irq(&hctx->requeue_lock);
>  
>  	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
>  		if (!(rq->rq_flags & (RQF_SOFTBARRIER | RQF_DONTPREP)))
> @@ -1435,13 +1438,13 @@ static void blk_mq_requeue_work(struct work_struct *work)
>  		blk_mq_sched_insert_request(rq, false, false, false);
>  	}
>  
> -	blk_mq_run_hw_queues(q, false);
> +	blk_mq_run_hw_queue(hctx, false);
>  }
>  
>  void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
>  				bool kick_requeue_list)
>  {
> -	struct request_queue *q = rq->q;
> +	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>  	unsigned long flags;
>  
>  	/*
> @@ -1449,31 +1452,42 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
>  	 * request head insertion from the workqueue.
>  	 */
>  	BUG_ON(rq->rq_flags & RQF_SOFTBARRIER);
> +	WARN_ON_ONCE(!rq->mq_hctx);
>  
> -	spin_lock_irqsave(&q->requeue_lock, flags);
> +	spin_lock_irqsave(&hctx->requeue_lock, flags);
>  	if (at_head) {
>  		rq->rq_flags |= RQF_SOFTBARRIER;
> -		list_add(&rq->queuelist, &q->requeue_list);
> +		list_add(&rq->queuelist, &hctx->requeue_list);
>  	} else {
> -		list_add_tail(&rq->queuelist, &q->requeue_list);
> +		list_add_tail(&rq->queuelist, &hctx->requeue_list);
>  	}
> -	spin_unlock_irqrestore(&q->requeue_lock, flags);
> +	spin_unlock_irqrestore(&hctx->requeue_lock, flags);
>  
>  	if (kick_requeue_list)
> -		blk_mq_kick_requeue_list(q);
> +		blk_mq_kick_requeue_list(rq->q);
>  }
>  
>  void blk_mq_kick_requeue_list(struct request_queue *q)
>  {
> -	kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &q->requeue_work, 0);
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned long i;
> +
> +	queue_for_each_hw_ctx(q, hctx, i)
> +		kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND,
> +					    &hctx->requeue_work, 0);
>  }
>  EXPORT_SYMBOL(blk_mq_kick_requeue_list);
>  
>  void blk_mq_delay_kick_requeue_list(struct request_queue *q,
>  				    unsigned long msecs)
>  {
> -	kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &q->requeue_work,
> -				    msecs_to_jiffies(msecs));
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned long i;
> +
> +	queue_for_each_hw_ctx(q, hctx, i)
> +		kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND,
> +					    &hctx->requeue_work,
> +					    msecs_to_jiffies(msecs));
>  }
>  EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
>  
> @@ -3594,6 +3608,10 @@ static int blk_mq_init_hctx(struct request_queue *q,
>  		struct blk_mq_tag_set *set,
>  		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
>  {
> +	INIT_DELAYED_WORK(&hctx->requeue_work, blk_mq_requeue_work);
> +	INIT_LIST_HEAD(&hctx->requeue_list);
> +	spin_lock_init(&hctx->requeue_lock);
> +
>  	hctx->queue_num = hctx_idx;
>  
>  	if (!(hctx->flags & BLK_MQ_F_STACKING))
> @@ -4209,10 +4227,6 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
>  	blk_mq_update_poll_flag(q);
>  
> -	INIT_DELAYED_WORK(&q->requeue_work, blk_mq_requeue_work);
> -	INIT_LIST_HEAD(&q->requeue_list);
> -	spin_lock_init(&q->requeue_lock);
> -
>  	q->nr_requests = set->queue_depth;
>  
>  	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
> @@ -4757,10 +4771,10 @@ void blk_mq_cancel_work_sync(struct request_queue *q)
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned long i;
>  
> -	cancel_delayed_work_sync(&q->requeue_work);
> -
> -	queue_for_each_hw_ctx(q, hctx, i)
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		cancel_delayed_work_sync(&hctx->requeue_work);
>  		cancel_delayed_work_sync(&hctx->run_work);
> +	}
>  }
>  
>  static int __init blk_mq_init(void)
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 3a3bee9085e3..0157f1569980 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -311,6 +311,10 @@ struct blk_mq_hw_ctx {
>  		unsigned long		state;
>  	} ____cacheline_aligned_in_smp;
>  
> +	struct list_head	requeue_list;
> +	spinlock_t		requeue_lock;
> +	struct delayed_work	requeue_work;
> +
>  	/**
>  	 * @run_work: Used for scheduling a hardware queue run at a later time.
>  	 */
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index e3242e67a8e3..f5fa53cd13bd 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -491,10 +491,6 @@ struct request_queue {
>  	 */
>  	struct blk_flush_queue	*fq;
>  
> -	struct list_head	requeue_list;
> -	spinlock_t		requeue_lock;
> -	struct delayed_work	requeue_work;
> -
>  	struct mutex		sysfs_lock;
>  	struct mutex		sysfs_dir_lock;
>  

