Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C908DC433DF
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD90A20890
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbgE0S0N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 14:26:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:47618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387581AbgE0S0N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:26:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6CD07AF0C;
        Wed, 27 May 2020 18:26:13 +0000 (UTC)
Subject: Re: [PATCH 8/8] blk-mq: drain I/O when all CPUs in a hctx are offline
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-9-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ada95db5-8b48-4a75-6a82-349e3f99b145@suse.de>
Date:   Wed, 27 May 2020 20:26:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527180644.514302-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/20 8:06 PM, Christoph Hellwig wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> Most of blk-mq drivers depend on managed IRQ's auto-affinity to setup
> up queue mapping. Thomas mentioned the following point[1]:
> 
> "That was the constraint of managed interrupts from the very beginning:
> 
>   The driver/subsystem has to quiesce the interrupt line and the associated
>   queue _before_ it gets shutdown in CPU unplug and not fiddle with it
>   until it's restarted by the core when the CPU is plugged in again."
> 
> However, current blk-mq implementation doesn't quiesce hw queue before
> the last CPU in the hctx is shutdown.  Even worse, CPUHP_BLK_MQ_DEAD is a
> cpuhp state handled after the CPU is down, so there isn't any chance to
> quiesce the hctx before shutting down the CPU.
> 
> Add new CPUHP_AP_BLK_MQ_ONLINE state to stop allocating from blk-mq hctxs
> where the last CPU goes away, and wait for completion of in-flight
> requests.  This guarantees that there is no inflight I/O before shutting
> down the managed IRQ.
> 
> Add a BLK_MQ_F_STACKING and set it for dm-rq and loop, so we don't need
> to wait for completion of in-flight requests from these drivers to avoid
> a potential dead-lock. It is safe to do this for stacking drivers as those
> do not use interrupts at all and their I/O completions are triggered by
> underlying devices I/O completion.
> 
> [1] https://lore.kernel.org/linux-block/alpine.DEB.2.21.1904051331270.1802@nanos.tec.linutronix.de/
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> [hch: different retry mechanism, merged two patches, minor cleanups]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq-debugfs.c     |   2 +
>   block/blk-mq-tag.c         |   8 +++
>   block/blk-mq.c             | 121 ++++++++++++++++++++++++++++++++++++-
>   drivers/block/loop.c       |   2 +-
>   drivers/md/dm-rq.c         |   2 +-
>   include/linux/blk-mq.h     |  10 +++
>   include/linux/cpuhotplug.h |   1 +
>   7 files changed, 142 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 96b7a35c898a7..15df3a36e9fa4 100644
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
> @@ -239,6 +240,7 @@ static const char *const hctx_flag_name[] = {
>   	HCTX_FLAG_NAME(TAG_SHARED),
>   	HCTX_FLAG_NAME(BLOCKING),
>   	HCTX_FLAG_NAME(NO_SCHED),
> +	HCTX_FLAG_NAME(STACKING),
>   };
>   #undef HCTX_FLAG_NAME
>   
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 9f74064768423..1c548d9f67ee7 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -180,6 +180,14 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>   	sbitmap_finish_wait(bt, ws, &wait);
>   
>   found_tag:
> +	/*
> +	 * Give up this allocation if the hctx is inactive.  The caller will
> +	 * retry on an active hctx.
> +	 */
> +	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state))) {
> +		blk_mq_put_tag(tags, data->ctx, tag + tag_offset);
> +		return -1;

BLK_MQ_NO_TAG, please, to be consistent with the caller checks later on.

> +	}
>   	return tag + tag_offset;
>   }
>   
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 898400452b1cf..e4580cd6c6f49 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -375,14 +375,39 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
>   			e->type->ops.limit_depth(data->cmd_flags, data);
>   	}
>   
> +retry:
>   	data->ctx = blk_mq_get_ctx(q);
>   	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
>   	if (!(data->flags & BLK_MQ_REQ_INTERNAL))
>   		blk_mq_tag_busy(data->hctx);
>   
> +	/*
> +	 * Waiting allocations only fail because of an inactive hctx.  In that
> +	 * case just retry the hctx assignment and tag allocation as CPU hotplug
> +	 * should have migrated us to an online CPU by now.
> +	 */
>   	tag = blk_mq_get_tag(data);
> -	if (tag == BLK_MQ_NO_TAG)
> -		return NULL;
> +	if (tag == BLK_MQ_NO_TAG) {
> +		if (data->flags & BLK_MQ_REQ_NOWAIT)
> +			return NULL;
> +
> +		/*
> +		 * All kthreads that can perform I/O should have been moved off
> +		 * this CPU by the time the the CPU hotplug statemachine has
> +		 * shut down a hctx.  But better be sure with an extra sanity
> +		 * check.
> +		 */
> +		if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
> +			return NULL;
> +
> +		/*
> +		 * Give up the CPU and sleep for a random short time to ensure
> +		 * that thread using a realtime scheduling class are migrated
> +		 * off the the CPU.
> +		 */
> +		msleep(3);
> +		goto retry;
> +	}
>   	return blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
>   }
>   
> @@ -2324,6 +2349,86 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>   	return -ENOMEM;
>   }
>   
> +struct rq_iter_data {
> +	struct blk_mq_hw_ctx *hctx;
> +	bool has_rq;
> +};
> +
> +static bool blk_mq_has_request(struct request *rq, void *data, bool reserved)
> +{
> +	struct rq_iter_data *iter_data = data;
> +
> +	if (rq->mq_hctx != iter_data->hctx)
> +		return true;
> +	iter_data->has_rq = true;
> +	return false;
> +}
> +
> +static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct blk_mq_tags *tags = hctx->sched_tags ?
> +			hctx->sched_tags : hctx->tags;
> +	struct rq_iter_data data = {
> +		.hctx	= hctx,
> +	};
> +
> +	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
> +	return data.has_rq;
> +}
> +
> +static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
> +		struct blk_mq_hw_ctx *hctx)
> +{
> +	if (cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu)
> +		return false;
> +	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
> +		return false;
> +	return true;
> +}
> +
> +static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> +			struct blk_mq_hw_ctx, cpuhp_online);
> +
> +	if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
> +	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
> +		return 0;
> +
> +	/*
> +	 * Prevent new request from being allocated on the current hctx.
> +	 *
> +	 * The smp_mb__after_atomic() Pairs with the implied barrier in
> +	 * test_and_set_bit_lock in sbitmap_get().  Ensures the inactive flag is
> +	 * seen once we return from the tag allocator.
> +	 */
> +	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
> +	smp_mb__after_atomic();
> +
> +	/*
> +	 * Try to grab a reference to the queue and wait for any outstanding
> +	 * requests.  If we could not grab a reference the queue has been
> +	 * frozen and there are no requests.
> +	 */
> +	if (percpu_ref_tryget(&hctx->queue->q_usage_counter)) {
> +		while (blk_mq_hctx_has_requests(hctx))
> +			msleep(5);
> +		percpu_ref_put(&hctx->queue->q_usage_counter);
> +	}
> +
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
> +	return 0;
> +}
> +
>   /*
>    * 'cpu' is going away. splice any existing rq_list entries from this
>    * software queue to the hw queue dispatch list, and ensure that it
> @@ -2337,6 +2442,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>   	enum hctx_type type;
>   
>   	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
> +	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> +		return 0;
> +
>   	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
>   	type = hctx->type;
>   
> @@ -2360,6 +2468,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>   
>   static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
>   {
> +	if (!(hctx->flags & BLK_MQ_F_STACKING))
> +		cpuhp_state_remove_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
> +						    &hctx->cpuhp_online);
>   	cpuhp_state_remove_instance_nocalls(CPUHP_BLK_MQ_DEAD,
>   					    &hctx->cpuhp_dead);
>   }
> @@ -2419,6 +2530,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
>   {
>   	hctx->queue_num = hctx_idx;
>   
> +	if (!(hctx->flags & BLK_MQ_F_STACKING))
> +		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
> +				&hctx->cpuhp_online);
>   	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
>   
>   	hctx->tags = set->tags[hctx_idx];
> @@ -3673,6 +3787,9 @@ static int __init blk_mq_init(void)
>   {
>   	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
>   				blk_mq_hctx_notify_dead);
> +	cpuhp_setup_state_multi(CPUHP_AP_BLK_MQ_ONLINE, "block/mq:online",
> +				blk_mq_hctx_notify_online,
> +				blk_mq_hctx_notify_offline);
>   	return 0;
>   }
>   subsys_initcall(blk_mq_init);
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index da693e6a834e5..d7904b4d8d126 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2037,7 +2037,7 @@ static int loop_add(struct loop_device **l, int i)
>   	lo->tag_set.queue_depth = 128;
>   	lo->tag_set.numa_node = NUMA_NO_NODE;
>   	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
> -	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
> +	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;
>   	lo->tag_set.driver_data = lo;
>   
>   	err = blk_mq_alloc_tag_set(&lo->tag_set);
> diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
> index 3f8577e2c13be..f60c025121215 100644
> --- a/drivers/md/dm-rq.c
> +++ b/drivers/md/dm-rq.c
> @@ -547,7 +547,7 @@ int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
>   	md->tag_set->ops = &dm_mq_ops;
>   	md->tag_set->queue_depth = dm_get_blk_mq_queue_depth();
>   	md->tag_set->numa_node = md->numa_node_id;
> -	md->tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
> +	md->tag_set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;
>   	md->tag_set->nr_hw_queues = dm_get_blk_mq_nr_hw_queues();
>   	md->tag_set->driver_data = md;
>   
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index d7307795439a4..a20f8c241d665 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -140,6 +140,8 @@ struct blk_mq_hw_ctx {
>   	 */
>   	atomic_t		nr_active;
>   
> +	/** @cpuhp_online: List to store request if CPU is going to die */
> +	struct hlist_node	cpuhp_online;
>   	/** @cpuhp_dead: List to store request if some CPU die. */
>   	struct hlist_node	cpuhp_dead;
>   	/** @kobj: Kernel object for sysfs. */
> @@ -391,6 +393,11 @@ struct blk_mq_ops {
>   enum {
>   	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
>   	BLK_MQ_F_TAG_SHARED	= 1 << 1,
> +	/*
> +	 * Set when this device requires underlying blk-mq device for
> +	 * completing IO:
> +	 */
> +	BLK_MQ_F_STACKING	= 1 << 2,
>   	BLK_MQ_F_BLOCKING	= 1 << 5,
>   	BLK_MQ_F_NO_SCHED	= 1 << 6,
>   	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
> @@ -400,6 +407,9 @@ enum {
>   	BLK_MQ_S_TAG_ACTIVE	= 1,
>   	BLK_MQ_S_SCHED_RESTART	= 2,
>   
> +	/* hw queue is inactive after all its CPUs become offline */
> +	BLK_MQ_S_INACTIVE	= 3,
> +
>   	BLK_MQ_MAX_DEPTH	= 10240,
>   
>   	BLK_MQ_CPU_WORK_BATCH	= 8,
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 77d70b6335318..24b3a77810b6d 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -152,6 +152,7 @@ enum cpuhp_state {
>   	CPUHP_AP_SMPBOOT_THREADS,
>   	CPUHP_AP_X86_VDSO_VMA_ONLINE,
>   	CPUHP_AP_IRQ_AFFINITY_ONLINE,
> +	CPUHP_AP_BLK_MQ_ONLINE,
>   	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
>   	CPUHP_AP_X86_INTEL_EPB_ONLINE,
>   	CPUHP_AP_PERF_ONLINE,
> 
Otherwise looks okay.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
