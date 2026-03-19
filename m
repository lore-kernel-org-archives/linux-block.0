Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B1286400;
	Thu, 19 Mar 2026 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773891095; cv=none; b=RBxR3E/pg2xjUQXHDkzxcIaZXwb/sF3mqe6e00RuqtmVDJo7smGDa+t/xc48uKAIK4YAkbm9+8GwOf32+RI/vbdxwz1WvgnsVJuAS/wQ47NfI/IFG4hjFj908KlZTyZXS0onR64YzD9nb6rctoQdroNN47eGQIY+SKQ+c7EfrEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773891095; c=relaxed/simple;
	bh=Y7D/zR0h0PKW4o/GAMjW6oQ8++Rn5ivsCNZWVotZqAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6hd3/xW04K82mrlrzKwl6ZNy3V/UaY0Si2SWNCuAE2u6Trw3pL5MbZsuBqsOS/SWYO0Df2vbdxoyN4UB+EDGPQBNpHPYDWVhHlre+W0qKCSqs1RF1SarrMpfAqSy3ai5zXdPRoT9LgA4iLTvx20OQfnZoRIRsKLfHjSHHOqsuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGTf47f7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGTf47f7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17809C2BC9E;
	Thu, 19 Mar 2026 03:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773891095;
	bh=Y7D/zR0h0PKW4o/GAMjW6oQ8++Rn5ivsCNZWVotZqAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KGTf47f7y3Oro0PdotkyCUt4yB6LwFWlffIFUiZpF3qFDx0VgEvAB+QEw160R9U8e
	 PYi5Fc78DbBVJHOFnKKkL/Pzl3loQ5HkDXRibTSGjjYi4XSsqLUI0lgN+mebTeX7Jd
	 RzbfbVGOc4z06oRx6OKK8KF8jTZtIgluaK3VlS6IrIThwj8xVzzmRqqqh7QtKCKwJI
	 dohKk15BuThWvv9R3aSC2YJRVIPwAX0pBe2B8693cMJb4G0tedELHaiSUL3+3zkf3C
	 Vlz7jZR4jQd1XV2UmbwAj1oCZ5PIEye3wgIUQr8n8jCipk3MVQjJ7vvuc93h7e7ut6
	 ImerETUDhWpOw==
Message-ID: <3b7cf895-cee3-4c13-8272-8529cceed040@kernel.org>
Date: Thu, 19 Mar 2026 12:31:31 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-mq: add tracepoint block_rq_tag_wait
To: Aaron Tomlin <atomlin@atomlin.com>, axboe@kernel.dk, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: johannes.thumshirn@wdc.com, kch@nvidia.com, bvanassche@acm.org,
 ritesh.list@gmail.com, neelx@suse.com, sean@ashe.io, mproche@gmail.com,
 chjohnst@gmail.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260319015300.287653-1-atomlin@atomlin.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260319015300.287653-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/26 10:53, Aaron Tomlin wrote:
> In high-performance storage environments, particularly when utilising
> RAID controllers with shared tag sets (BLK_MQ_F_TAG_HCTX_SHARED), severe
> latency spikes can occur when fast devices (SSDs) are starved of hardware
> tags when sharing the same blk_mq_tag_set.
> 
> Currently, diagnosing this specific hardware queue contention is
> difficult. When a CPU thread exhausts the tag pool, blk_mq_get_tag()
> forces the current thread to block uninterruptible via io_schedule().
> While this can be inferred via sched:sched_switch or dynamically
> traced by attaching a kprobe to blk_mq_mark_tag_wait(), there is no
> dedicated, out-of-the-box observability for this event.
> 
> This patch introduces the block_rq_tag_wait static trace point in the
> tag allocation slow-path. It triggers immediately before the thread
> yields the CPU, exposing the exact hardware context (hctx) that is
> starved, the specific pool experiencing starvation (hardware or software
> scheduler), and the total pool depth.
> 
> This provides storage engineers and performance monitoring agents
> with a zero-configuration, low-overhead mechanism to definitively
> identify shared-tag bottlenecks and tune I/O schedulers or cgroup
> throttling accordingly.
> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
> Changes in v1 [1]:
>  - Improved the description of the trace point (Damien Le Moal)
>  - Removed the redundant "active requests" (Laurence Oberman)
>  - Introduced pool-specific starvation tracking
> 
> [1]: https://lore.kernel.org/lkml/20260317182835.258183-1-atomlin@atomlin.com/
> 
>  block/blk-mq-tag.c           |  4 ++++
>  include/trace/events/block.h | 43 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 33946cdb5716..a6691a4fe7a7 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -13,6 +13,7 @@
>  #include <linux/kmemleak.h>
>  
>  #include <linux/delay.h>
> +#include <trace/events/block.h>
>  #include "blk.h"
>  #include "blk-mq.h"
>  #include "blk-mq-sched.h"
> @@ -187,6 +188,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  		if (tag != BLK_MQ_NO_TAG)
>  			break;
>  
> +		trace_block_rq_tag_wait(data->q, data->hctx,
> +					!!(data->rq_flags & RQF_SCHED_TAGS));

I do not think that the "!!" is needed here.

Other than this, this looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +
>  		bt_prev = bt;
>  		io_schedule();
>  
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 6aa79e2d799c..f7708d0d7a0c 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -226,6 +226,49 @@ DECLARE_EVENT_CLASS(block_rq,
>  		  IOPRIO_PRIO_LEVEL(__entry->ioprio), __entry->comm)
>  );
>  
> +/**
> + * block_rq_tag_wait - triggered when a request is starved of a tag
> + * @q: request queue of the target device
> + * @hctx: hardware context of the request experiencing starvation
> + * @is_sched_tag: indicates whether the starved pool is the software scheduler
> + *
> + * Called immediately before the submitting context is forced to block due
> + * to the exhaustion of available tags (i.e., physical hardware driver tags
> + * or software scheduler tags). This trace point indicates that the context
> + * will be placed into an uninterruptible state via io_schedule() until an
> + * active request completes and relinquishes its assigned tag.
> + */
> +TRACE_EVENT(block_rq_tag_wait,
> +
> +	TP_PROTO(struct request_queue *q, struct blk_mq_hw_ctx *hctx, bool is_sched_tag),
> +
> +	TP_ARGS(q, hctx, is_sched_tag),
> +
> +	TP_STRUCT__entry(
> +		__field( dev_t,		dev			)
> +		__field( u32,		hctx_id			)
> +		__field( u32,		nr_tags			)
> +		__field( bool,		is_sched_tag		)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= disk_devt(q->disk);
> +		__entry->hctx_id	= hctx->queue_num;
> +		__entry->is_sched_tag	= is_sched_tag;
> +
> +		if (__entry->is_sched_tag)
> +			__entry->nr_tags = hctx->sched_tags->nr_tags;
> +		else
> +			__entry->nr_tags = hctx->tags->nr_tags;
> +	),
> +
> +	TP_printk("%d,%d hctx=%u starved on %s tags (depth=%u)",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->hctx_id,
> +		  __entry->is_sched_tag ? "scheduler" : "hardware",
> +		  __entry->nr_tags)
> +);
> +
>  /**
>   * block_rq_insert - insert block operation request into queue
>   * @rq: block IO operation request


-- 
Damien Le Moal
Western Digital Research
