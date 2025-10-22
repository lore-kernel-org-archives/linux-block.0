Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A052877C3
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 04:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761106282; cv=none; b=DAzfyonXLcw5jx1NUQLihA+3hzTDc25WPCG2Oc0MX8XbylpakV0cGOJiKRyxguhOq2NsOQqa24EqJCWjFzEh7AGoY868HVG0jxkM8mefs9jR3ThxXLzywWTYR1hhZ7xZG314GD/OypsF1rPjtKasl9CXnfjIUHlo7u3J1Wna3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761106282; c=relaxed/simple;
	bh=YS9PZI3ykjSM1pZHXvP8G7LQEI8u7CowbN9wCTLvvws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVD28Wx5mRjHSr0Y1KCpRXFh4dRnxGb0rR9bkkaYCK+sLucelYLLTxkN6I/QaMOlgIvHpVhF3EKBHFpZCuBLOMtxXqlUtRYBucaQIEEu/M51idh51mPwSgbQbGz6Bo4UXAhMyflRjAc0GeUZNiz15R/9WOrWGTttKhzL8AuWM8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZhuNFOa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZhuNFOa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761106278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+r/KN0xWMOzW9Npy3k3ExPoKUQgWkE/C1utM1G1emU=;
	b=WZhuNFOaG1lol6G8g7PT/+VSbRYAXISN9hhjKcI4q8LSu5+sAy09L8lW50Q2/MBV0p/OQt
	Fjc6Xov/IlbpcOUqo9oq2b5OkKnMjMrZqVW3pLDzsboc/PVPU6LgduCPnB5Xxj0P2QoUDH
	IRd7dddm+yJ8kfeU4G97Jk0B7dRHoyY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-zTchUSUyN-yskE8JuoG6iA-1; Wed,
 22 Oct 2025 00:11:15 -0400
X-MC-Unique: zTchUSUyN-yskE8JuoG6iA-1
X-Mimecast-MFC-AGG-ID: zTchUSUyN-yskE8JuoG6iA_1761106274
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22ED51956094;
	Wed, 22 Oct 2025 04:11:13 +0000 (UTC)
Received: from fedora (unknown [10.72.120.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F35C830001BF;
	Wed, 22 Oct 2025 04:11:06 +0000 (UTC)
Date: Wed, 22 Oct 2025 12:11:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, yukuai1@huaweicloud.com,
	axboe@kernel.dk, yi.zhang@redhat.com, czhong@redhat.com,
	gjoyce@ibm.com
Subject: Re: [PATCH 1/3] block: unify elevator tags and type xarrays into
 struct elv_change_ctx
Message-ID: <aPhZVS9H6mdTaDv_@fedora>
References: <20251016053057.3457663-1-nilay@linux.ibm.com>
 <20251016053057.3457663-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251016053057.3457663-2-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Oct 16, 2025 at 11:00:47AM +0530, Nilay Shroff wrote:
> Currently, the nr_hw_queues update path manages two disjoint xarrays —
> one for elevator tags and another for elevator type — both used during
> elevator switching. Maintaining these two parallel structures for the
> same purpose adds unnecessary complexity and potential for mismatched
> state.
> 
> This patch unifies both xarrays into a single structure, struct
> elv_change_ctx, which holds all per-queue elevator change context. A
> single xarray, named elv_tbl, now maps each queue (q->id) in a tagset
> to its corresponding elv_change_ctx entry, encapsulating the elevator
> tags, type and name references.
> 
> This unification simplifies the code, improves maintainability, and
> clarifies ownership of per-queue elevator state.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  block/blk-mq-sched.c | 47 ++++++++++++++++++++++++++++++++++------
>  block/blk-mq-sched.h | 13 +++++++++++
>  block/blk-mq.c       | 51 ++++++++++++++++++++++++++------------------
>  block/blk.h          |  7 +++---
>  block/elevator.c     | 31 ++++++---------------------
>  block/elevator.h     | 15 +++++++++++++
>  6 files changed, 108 insertions(+), 56 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index d06bb137a743..1c9571136a30 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -453,6 +453,33 @@ void blk_mq_free_sched_tags_batch(struct xarray *et_table,
>  	}
>  }
>  
> +int blk_mq_alloc_sched_ctx_batch(struct xarray *elv_tbl,
> +		struct blk_mq_tag_set *set)
> +{
> +	struct request_queue *q;
> +	struct elv_change_ctx *ctx;
> +
> +	lockdep_assert_held_write(&set->update_nr_hwq_lock);
> +
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		ctx = kzalloc(sizeof(struct elv_change_ctx), GFP_KERNEL);
> +		if (!ctx)
> +			goto out_unwind;
> +
> +		if (xa_insert(elv_tbl, q->id, ctx, GFP_KERNEL)) {
> +			kfree(ctx);
> +			goto out_unwind;
> +		}
> +	}
> +	return 0;
> +out_unwind:
> +	list_for_each_entry_continue_reverse(q, &set->tag_list, tag_set_list) {
> +		ctx = xa_load(elv_tbl, q->id);
> +		kfree(ctx);
> +	}

No need to unwind, you can let blk_mq_free_sched_ctx_batch cover cleanup from
callsite. Not mention you leave freed `ctx` into xarray, which is fragile.

> +	return -ENOMEM;
> +}
> +
>  struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>  		unsigned int nr_hw_queues, unsigned int nr_requests)
>  {
> @@ -498,12 +525,13 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>  	return NULL;
>  }
>  
> -int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
> +int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
>  		struct blk_mq_tag_set *set, unsigned int nr_hw_queues)
>  {
> +	struct elv_change_ctx *ctx;
>  	struct request_queue *q;
>  	struct elevator_tags *et;
> -	gfp_t gfp = GFP_NOIO | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
> +	int ret = -ENOMEM;
>  
>  	lockdep_assert_held_write(&set->update_nr_hwq_lock);
>  
> @@ -520,8 +548,13 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
>  					blk_mq_default_nr_requests(set));
>  			if (!et)
>  				goto out_unwind;
> -			if (xa_insert(et_table, q->id, et, gfp))
> +
> +			ctx = xa_load(elv_tbl, q->id);
> +			if (WARN_ON_ONCE(!ctx)) {
> +				ret = -ENOENT;
>  				goto out_free_tags;
> +			}
> +			ctx->et = et;
>  		}
>  	}
>  	return 0;
> @@ -530,12 +563,12 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
>  out_unwind:
>  	list_for_each_entry_continue_reverse(q, &set->tag_list, tag_set_list) {
>  		if (q->elevator) {
> -			et = xa_load(et_table, q->id);
> -			if (et)
> -				blk_mq_free_sched_tags(et, set);
> +			ctx = xa_load(elv_tbl, q->id);
> +			if (ctx && ctx->et)
> +				blk_mq_free_sched_tags(ctx->et, set);

please clear ctx->et when it is freed.

>  		}
>  	}
> -	return -ENOMEM;
> +	return ret;
>  }
>  
>  /* caller must have a reference to @e, will grab another one if successful */
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 8e21a6b1415d..ba67e4e2447b 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -27,11 +27,24 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>  		unsigned int nr_hw_queues, unsigned int nr_requests);
>  int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
>  		struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
> +int blk_mq_alloc_sched_ctx_batch(struct xarray *elv_tbl,
> +		struct blk_mq_tag_set *set);
>  void blk_mq_free_sched_tags(struct elevator_tags *et,
>  		struct blk_mq_tag_set *set);
>  void blk_mq_free_sched_tags_batch(struct xarray *et_table,
>  		struct blk_mq_tag_set *set);
>  
> +static inline void blk_mq_free_sched_ctx_batch(struct xarray *elv_tbl)
> +{
> +	unsigned long i;
> +	struct elv_change_ctx *ctx;
> +
> +	xa_for_each(elv_tbl, i, ctx) {
> +		xa_erase(elv_tbl, i);
> +		kfree(ctx);
> +	}
> +}
> +

It could be more readable to move blk_mq_free_sched_ctx_batch() with
blk_mq_alloc_sched_ctx_batch() together.



Thanks, 
Ming

