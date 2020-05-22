Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38B7C433DF
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 09:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA782206C3
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 09:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgEVJZq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 05:25:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:56696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgEVJZp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 05:25:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8D3ABB211F;
        Fri, 22 May 2020 09:25:46 +0000 (UTC)
Subject: Re: [PATCH 6/6] blk-mq: drain I/O when all CPUs in a hctx are offline
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20200520170635.2094101-1-hch@lst.de>
 <20200520170635.2094101-7-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <98028672-be06-fb18-8cb3-b4ae1422caf9@suse.de>
Date:   Fri, 22 May 2020 11:25:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520170635.2094101-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/20 7:06 PM, Christoph Hellwig wrote:
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
>   block/blk-mq.c             | 114 ++++++++++++++++++++++++++++++++++++-
>   drivers/block/loop.c       |   2 +-
>   drivers/md/dm-rq.c         |   2 +-
>   include/linux/blk-mq.h     |  10 ++++
>   include/linux/cpuhotplug.h |   1 +
>   7 files changed, 135 insertions(+), 4 deletions(-)
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
> index c27c6dfc7d36e..3925d1e55bc8f 100644
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
> +	}
>   	return tag + tag_offset;
>   }
>   
I really wish we could have a dedicated NO_TAG value; returning
-1 for an unsigned int always feels dodgy.
And we could kill all the various internal definitions in drivers/scsi ...

Hmm?

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 42aee2978464b..672c7e3f61243 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -375,14 +375,32 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
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
> -	if (tag == BLK_MQ_TAG_FAIL)
> -		return NULL;
> +	if (tag == BLK_MQ_TAG_FAIL) {
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
> +		goto retry;
> +	}
>   	return blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
>   }
>   
> @@ -2324,6 +2342,86 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
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
To my reading this would only work reliably if we run the iteration on 
one of the cpus in the corresponding mask for the hctx.
Yet I fail to see any provision for this neither here nor in the 
previous patch
How do you guarantee that?
Or is there some implicit mechanism which I've missed?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
