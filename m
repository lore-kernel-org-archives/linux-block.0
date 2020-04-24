Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9545C54FCB
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 13:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ADBE20736
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 13:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgDXN1t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:27:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:48904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgDXN1t (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 09:27:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E2C71AFA1;
        Fri, 24 Apr 2020 13:27:45 +0000 (UTC)
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-8-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <69554493-db0b-228c-94a1-0f6f50580675@suse.de>
Date:   Fri, 24 Apr 2020 15:27:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424102351.475641-8-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/20 12:23 PM, Ming Lei wrote:
> Before one CPU becomes offline, check if it is the last online CPU of hctx.
> If yes, mark this hctx as inactive, meantime wait for completion of all
> in-flight IOs originated from this hctx. Meantime check if this hctx has
> become inactive in blk_mq_get_driver_tag(), if yes, release the
> allocated tag.
> 
> This way guarantees that there isn't any inflight IO before shutdowning
> the managed IRQ line when all CPUs of this IRQ line is offline.
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-debugfs.c |   1 +
>   block/blk-mq.c         | 124 +++++++++++++++++++++++++++++++++++++----
>   include/linux/blk-mq.h |   3 +
>   3 files changed, 117 insertions(+), 11 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 8e745826eb86..b62390918ca5 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -213,6 +213,7 @@ static const char *const hctx_state_name[] = {
>   	HCTX_STATE_NAME(STOPPED),
>   	HCTX_STATE_NAME(TAG_ACTIVE),
>   	HCTX_STATE_NAME(SCHED_RESTART),
> +	HCTX_STATE_NAME(INACTIVE),
>   };
>   #undef HCTX_STATE_NAME
>   
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d432cc74ef78..4d0c271d9f6f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1050,11 +1050,31 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
>   	return true;
>   }
>   
> -static bool blk_mq_get_driver_tag(struct request *rq)
> +static bool blk_mq_get_driver_tag(struct request *rq, bool direct_issue)
>   {
>   	if (rq->tag != -1)
>   		return true;
> -	return __blk_mq_get_driver_tag(rq);
> +
> +	if (!__blk_mq_get_driver_tag(rq))
> +		return false;
> +	/*
> +	 * Add one memory barrier in case that direct issue IO process is
> +	 * migrated to other CPU which may not belong to this hctx, so we can
> +	 * order driver tag assignment and checking BLK_MQ_S_INACTIVE.
> +	 * Otherwise, barrier() is enough given both setting BLK_MQ_S_INACTIVE
> +	 * and driver tag assignment are run on the same CPU in case that
> +	 * BLK_MQ_S_INACTIVE is set.
> +	 */
> +	if (unlikely(direct_issue && rq->mq_ctx->cpu != raw_smp_processor_id()))
> +		smp_mb();
> +	else
> +		barrier();
> +
> +	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state))) {
> +		blk_mq_put_driver_tag(rq);
> +		return false;
> +	}
> +	return true;
>   }
>   
>   static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
> @@ -1103,7 +1123,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
>   		 * Don't clear RESTART here, someone else could have set it.
>   		 * At most this will cost an extra queue run.
>   		 */
> -		return blk_mq_get_driver_tag(rq);
> +		return blk_mq_get_driver_tag(rq, false);
>   	}
>   
>   	wait = &hctx->dispatch_wait;
> @@ -1129,7 +1149,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
>   	 * allocation failure and adding the hardware queue to the wait
>   	 * queue.
>   	 */
> -	ret = blk_mq_get_driver_tag(rq);
> +	ret = blk_mq_get_driver_tag(rq, false);
>   	if (!ret) {
>   		spin_unlock(&hctx->dispatch_wait_lock);
>   		spin_unlock_irq(&wq->lock);
> @@ -1228,7 +1248,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>   			break;
>   		}
>   
> -		if (!blk_mq_get_driver_tag(rq)) {
> +		if (!blk_mq_get_driver_tag(rq, false)) {
>   			/*
>   			 * The initial allocation attempt failed, so we need to
>   			 * rerun the hardware queue when a tag is freed. The
> @@ -1260,7 +1280,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>   			bd.last = true;
>   		else {
>   			nxt = list_first_entry(list, struct request, queuelist);
> -			bd.last = !blk_mq_get_driver_tag(nxt);
> +			bd.last = !blk_mq_get_driver_tag(nxt, false);
>   		}
>   
>   		ret = q->mq_ops->queue_rq(hctx, &bd);
> @@ -1853,7 +1873,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>   	if (!blk_mq_get_dispatch_budget(hctx))
>   		goto insert;
>   
> -	if (!blk_mq_get_driver_tag(rq)) {
> +	if (!blk_mq_get_driver_tag(rq, true)) {
>   		blk_mq_put_dispatch_budget(hctx);
>   		goto insert;
>   	}
> @@ -2261,13 +2281,92 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>   	return -ENOMEM;
>   }
>   
> -static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
> +struct count_inflight_data {
> +	unsigned count;
> +	struct blk_mq_hw_ctx *hctx;
> +};
> +
> +static bool blk_mq_count_inflight_rq(struct request *rq, void *data,
> +				     bool reserved)
>   {
> -	return 0;
> +	struct count_inflight_data *count_data = data;
> +
> +	/*
> +	 * Can't check rq's state because it is updated to MQ_RQ_IN_FLIGHT
> +	 * in blk_mq_start_request(), at that time we can't prevent this rq
> +	 * from being issued.
> +	 *
> +	 * So check if driver tag is assigned, if yes, count this rq as
> +	 * inflight.
> +	 */
> +	if (rq->tag >= 0 && rq->mq_hctx == count_data->hctx)
> +		count_data->count++;
> +
> +	return true;
> +}
> +
> +static bool blk_mq_inflight_rq(struct request *rq, void *data,
> +			       bool reserved)
> +{
> +	return rq->tag >= 0;
> +}
> +
> +static unsigned blk_mq_tags_inflight_rqs(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct count_inflight_data count_data = {
> +		.count	= 0,
> +		.hctx	= hctx,
> +	};
> +
> +	blk_mq_all_tag_busy_iter(hctx->tags, blk_mq_count_inflight_rq,
> +			blk_mq_inflight_rq, &count_data);
> +
> +	return count_data.count;
> +}
> +

Remind me again: Why do we need the 'filter' function here?
Can't we just move the filter function into the main iterator and
stay with the original implementation?

> +static void blk_mq_hctx_drain_inflight_rqs(struct blk_mq_hw_ctx *hctx)
> +{
> +	while (1) {
> +		if (!blk_mq_tags_inflight_rqs(hctx))
> +			break;
> +		msleep(5);
> +	}
>   }
>   
>   static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>   {
> +	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> +			struct blk_mq_hw_ctx, cpuhp_online);
> +
> +	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> +		return 0;
> +
> +	if ((cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu) ||
> +	    (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids))
> +		return 0;
> +
> +	/*
> +	 * The current CPU is the last one in this hctx, S_INACTIVE
> +	 * can be observed in dispatch path without any barrier needed,
> +	 * cause both are run on one same CPU.
> +	 */
> +	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
> +	/*
> +	 * Order setting BLK_MQ_S_INACTIVE and checking rq->tag & rqs[tag],
> +	 * and its pair is the smp_mb() in blk_mq_get_driver_tag
> +	 */
> +	smp_mb__after_atomic();
> +	blk_mq_hctx_drain_inflight_rqs(hctx);
> +	return 0;
> +}
> +
> +static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> +			struct blk_mq_hw_ctx, cpuhp_online);
> +
> +	if (cpumask_test_cpu(cpu, hctx->cpumask))
> +		clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
>   	return 0;
>   }
>   
> @@ -2278,12 +2377,15 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>    */
>   static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>   {
> -	struct blk_mq_hw_ctx *hctx;
> +	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> +			struct blk_mq_hw_ctx, cpuhp_dead);
>   	struct blk_mq_ctx *ctx;
>   	LIST_HEAD(tmp);
>   	enum hctx_type type;
>   
> -	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
> +	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> +		return 0;
> +
>   	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
>   	type = hctx->type;
>   
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index f550b5274b8b..b4812c455807 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -403,6 +403,9 @@ enum {
>   	BLK_MQ_S_TAG_ACTIVE	= 1,
>   	BLK_MQ_S_SCHED_RESTART	= 2,
>   
> +	/* hw queue is inactive after all its CPUs become offline */
> +	BLK_MQ_S_INACTIVE	= 3,
> +
>   	BLK_MQ_MAX_DEPTH	= 10240,
>   
>   	BLK_MQ_CPU_WORK_BATCH	= 8,
> 
Otherwise this looks good, and is exactly what we need.
Thanks for doing the work!

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
