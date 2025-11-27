Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13232BEC45
	for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764214422; cv=none; b=oHovmt5iXMlhMbhH+cKi4i94HHQVtAB3O1ixp8JmtFcgcdMBPefreHyhyDqgZ0+6tkCiTwWgKLecUNtT6yt6bJZos4kU+BY0HRBDxTS9W7TSq2DkHTu9ci64mvK5e4zsYdJ23uTcxuWFcjrM5gNBqKixt2DnI+lvNauNs/89png=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764214422; c=relaxed/simple;
	bh=JehkaamXQq1uGRHoGNBHqnz9ZBknOZc8SKSmb6hwLuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ay1QhbQECvh2Tr/d1n3pit37s6NlZ2dg+X8raJ2GVl9uA/OvBNqdf1Kf/q7jNA/ZtbnZ6wj3z53AhNpYtGF39Idqd3fOvSvp9La/5ONxlv8eJI1k7ND59Ww+3tBSkD1fCgLdHBo8EBcl3WtaK1IszArCuBeB5QiOCH7k6QTWFkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdqODsJ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdqODsJ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764214416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8xrQSBExx7cB3y8gIr9snAn0KtbtdScJqmjmZ7d+lLQ=;
	b=SdqODsJ0LWWSYF9cMlhNH9wFGfJJQSPpGFLZtsbIzz6YyhWf7/urO+tK2MvDo4Ra4DCEsP
	lrl3lHgEomeX13kQQjGbENlZp2H+CqGArSpSv2r6l0huWGpzPDUUuuoEMlFCM7Qp2pyHsx
	oTiP0XhZVWJthbF79HnjGYGnhnGz2Zg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-qDOCdd-KNkqSUDQvO4DacQ-1; Wed,
 26 Nov 2025 22:33:34 -0500
X-MC-Unique: qDOCdd-KNkqSUDQvO4DacQ-1
X-Mimecast-MFC-AGG-ID: qDOCdd-KNkqSUDQvO4DacQ_1764214412
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91D6C1800250;
	Thu, 27 Nov 2025 03:33:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.210])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A7B030044DB;
	Thu, 27 Nov 2025 03:33:27 +0000 (UTC)
Date: Thu, 27 Nov 2025 11:33:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Fengnan Chang <fengnanchang@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hare@suse.de, hch@lst.de,
	yukuai3@huawei.com, Fengnan Chang <changfengnan@bytedance.com>
Subject: Re: [PATCH v2 2/2] blk-mq: fix potential uaf for 'queue_hw_ctx'
Message-ID: <aSfGggOS8o_nOQPI@fedora>
References: <20251127013908.66118-1-fengnanchang@gmail.com>
 <20251127013908.66118-3-fengnanchang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127013908.66118-3-fengnanchang@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Nov 27, 2025 at 09:39:08AM +0800, Fengnan Chang wrote:
> From: Fengnan Chang <changfengnan@bytedance.com>
> 
> This is just apply Kuai's patch in [1] with mirror changes.
> 
> blk_mq_realloc_hw_ctxs() will free the 'queue_hw_ctx'(e.g. undate
> submit_queues through configfs for null_blk), while it might still be
> used from other context(e.g. switch elevator to none):
> 
> t1					t2
> elevator_switch
>  blk_mq_unquiesce_queue
>   blk_mq_run_hw_queues
>    queue_for_each_hw_ctx
>     // assembly code for hctx = (q)->queue_hw_ctx[i]
>     mov    0x48(%rbp),%rdx -> read old queue_hw_ctx
> 
> 					__blk_mq_update_nr_hw_queues
> 					 blk_mq_realloc_hw_ctxs
> 					  hctxs = q->queue_hw_ctx
> 					  q->queue_hw_ctx = new_hctxs
> 					  kfree(hctxs)
>     movslq %ebx,%rax
>     mov    (%rdx,%rax,8),%rdi ->uaf
> 
> This problem was found by code review, and I comfirmed that the concurrent
> scenario do exist(specifically 'q->queue_hw_ctx' can be changed during
> blk_mq_run_hw_queues()), however, the uaf problem hasn't been repoduced yet
> without hacking the kernel.
> 
> Sicne the queue is freezed in __blk_mq_update_nr_hw_queues(), fix the
> problem by protecting 'queue_hw_ctx' through rcu where it can be accessed
> without grabbing 'q_usage_counter'.
> 
> [1] https://lore.kernel.org/all/20220225072053.2472431-1-yukuai3@huawei.com/
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
> ---
>  block/blk-mq.c         |  7 ++++++-
>  block/blk-mq.h         | 11 +++++++++++
>  include/linux/blk-mq.h |  2 +-
>  include/linux/blkdev.h |  2 +-
>  4 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index eed12fab3484..0b8b72194003 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4524,7 +4524,12 @@ static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  		if (hctxs)
>  			memcpy(new_hctxs, hctxs, q->nr_hw_queues *
>  			       sizeof(*hctxs));
> -		q->queue_hw_ctx = new_hctxs;
> +		rcu_assign_pointer(q->queue_hw_ctx, new_hctxs);
> +		/*
> +		 * Make sure reading the old queue_hw_ctx from other
> +		 * context concurrently won't trigger uaf.
> +		 */
> +		synchronize_rcu_expedited();
>  		kfree(hctxs);
>  		hctxs = new_hctxs;
>  	}
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 80a3f0c2bce7..52852fab78f0 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -87,6 +87,17 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
>  	return q->queue_hw_ctx[q->tag_set->map[type].mq_map[cpu]];
>  }
>  
> +static inline struct blk_mq_hw_ctx *queue_hctx(struct request_queue *q, int id)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +
> +	rcu_read_lock();
> +	hctx = rcu_dereference(q->queue_hw_ctx)[id];
> +	rcu_read_unlock();
> +
> +	return hctx;
> +}


If `hctx` is retrieved from old table, uaf will be triggered on
`hctx` dereference after returning from queue_hctx().

So rcu read lock should be held anywhere for `hctx` deference.



Thanks, 
Ming

