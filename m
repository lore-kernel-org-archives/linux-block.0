Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FE536404D;
	Tue, 17 Mar 2026 23:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773790709; cv=none; b=fqpS2jxci0+b/dbCiaSTKTAUvojwERWNSkjbZRZhCKK6v38eDenazSqDmPES9KQSa6Al+2EB/t0oveWY8KIDbJZ/rJzF7k+XMpBtU96gQwAqZSWkyyfmgdccv/QLQYEPz5Kjh4QaHarmJPSRbq/MFfae3BIzy1RHOiUEZKbD3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773790709; c=relaxed/simple;
	bh=WwVLPe0QCCCeyvdW/GwssSdLhCdmfc4bf4h4H8OYCjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZixjn8D3NxC+nO2IhaSRo9+fQ1G7+gDLfJLRiGP7LPNIIIENqLRageMuchHfXXlkGWb3Rm6iCTjPUs/psqxx1Z0T+zLuBsjjMyycWfVMuaFukWrn+hHrnbVMgSeaW3cVWUmLnnhtHotdo59mkg0LMFq8LBZanRJtWBU1p9Zth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpUb6IGm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpUb6IGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3757BC4CEF7;
	Tue, 17 Mar 2026 23:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773790708;
	bh=WwVLPe0QCCCeyvdW/GwssSdLhCdmfc4bf4h4H8OYCjQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EpUb6IGmzdS9nIi3iyY7CFvEwaHdupo7T24orgXuhkw+jsb98rstE/3pQUe7soAUZ
	 G5bCcVQm5gklDMzd+ZoHRUuYLWQcj9YquYPxBiq5RUcNycUG7bvPz1qXcwG1fnqQmU
	 /iC6WNaed+tRNdUWE080qSAukDM9GHJwWo7sz9ojyFhtgvuGnGf0r2ZgXbXtbFzujx
	 BOulwgYW/MBP33I5j6cbYbUGYFHSMXrqMWTcBzeL1G8BQLps7UNgqYNMjf8t0N/Eig
	 VkQq25mQRrSW0c7B5WB91JYFkqsKxwZwsfA0YGfpG5OyMjWF2DdsFuqhRkm8HKU4Ml
	 vILfhWG4l/6sg==
Message-ID: <e7db667e-2662-4ad9-89cd-309c457ce17e@kernel.org>
Date: Wed, 18 Mar 2026 08:38:20 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: add tracepoint block_rq_tag_wait
To: Aaron Tomlin <atomlin@atomlin.com>, axboe@kernel.dk, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: johannes.thumshirn@wdc.com, kch@nvidia.com, bvanassche@acm.org,
 ritesh.list@gmail.com, neelx@suse.com, sean@ashe.io, mproche@gmail.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260317182835.258183-1-atomlin@atomlin.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260317182835.258183-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/03/18 3:28, Aaron Tomlin wrote:
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
> This patch introduces the block_rq_tag_wait static tracepoint in
> the tag allocation slow-path. It triggers immediately before the
> thread yields the CPU, exposing the exact hardware context (hctx)
> that is starved, the total pool size, and the current active request
> count.
> 
> This provides storage engineers and performance monitoring agents
> with a zero-configuration, low-overhead mechanism to definitively
> identify shared-tag bottlenecks and tune I/O schedulers or cgroup
> throttling accordingly.
> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Looks OK to me, but I have some suggestions below.

> ---
>  block/blk-mq-tag.c           |  3 +++
>  include/trace/events/block.h | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 33946cdb5716..f50993e86ca5 100644
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
> @@ -187,6 +188,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  		if (tag != BLK_MQ_NO_TAG)
>  			break;
>  
> +		trace_block_rq_tag_wait(data->q, data->hctx);
> +
>  		bt_prev = bt;
>  		io_schedule();
>  
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 6aa79e2d799c..48e2ba433c87 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -226,6 +226,42 @@ DECLARE_EVENT_CLASS(block_rq,
>  		  IOPRIO_PRIO_LEVEL(__entry->ioprio), __entry->comm)
>  );
>  
> +/**
> + * block_rq_tag_wait - triggered when an I/O request is starved of a tag

when an I/O request -> when a request

> + * @q: queue containing the request

request queue of the target device

("containing" is odd here)

> + * @hctx: hardware context (queue) experiencing starvation

hardware context of the request

> + *
> + * Called immediately before the submitting thread is forced to block due

the submitting thread -> the submitting context

> + * to the exhaustion of available hardware tags. This tracepoint indicates

s/tracepoint/trace point

> + * that the thread will be placed into an uninterruptible state via

s/thread/context

> + * io_schedule() until an active block I/O operation completes and
> + * relinquishes its assigned tag.

until an active request completes

(BIOs do not have tags).

> + */
> +TRACE_EVENT(block_rq_tag_wait,
> +
> +	TP_PROTO(struct request_queue *q, struct blk_mq_hw_ctx *hctx),
> +
> +	TP_ARGS(q, hctx),
> +
> +	TP_STRUCT__entry(
> +		__field( dev_t,		dev			)
> +		__field( u32,		hctx_id			)
> +		__field( u32,		nr_tags			)
> +		__field( u32,		active_requests		)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		  = q->disk ? disk_devt(q->disk) : 0;

I do not think that q->disk can ever be NULL when there is a request being
submitted.

> +		__entry->hctx_id	  = hctx ? hctx->queue_num : 0;
> +		__entry->nr_tags	  = hctx && hctx->tags ? hctx->tags->nr_tags : 0;
> +		__entry->active_requests  = hctx ? atomic_read(&hctx->nr_active) : 0;
> +	),
> +
> +	TP_printk("%d,%d hctx=%u starved (active=%u/%u)",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->hctx_id, __entry->active_requests, __entry->nr_tags)
> +);
> +
>  /**
>   * block_rq_insert - insert block operation request into queue
>   * @rq: block IO operation request


-- 
Damien Le Moal
Western Digital Research
