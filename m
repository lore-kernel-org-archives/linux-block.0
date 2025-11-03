Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ADAEEA8
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 03:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762141829; cv=none; b=bPyKydOQ6wA8CD9aoNBG+2ZPYrk7PDEawVLF9v4oy5WL6nv7K5DBmcwtlEiBhWSyEl45gybmO/k4KALpqrscc6V+5SO/9WtRV/o5DCbSggY4R08PIwdTHGEvLxBDFGf41PhIPCuFcTAxfySoNiG7XKZ8+0BRre3gXQFyghQneBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762141829; c=relaxed/simple;
	bh=OQ0WqOjiMHJXACokKchgH0Vz1D3SXlQNnqJZkLnCKvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPrdqCdkcAgQ2sQySqJAzAzSGQJQJMKI+cuJEeRUZ7Yaa45vGeKjHE4cDfq/vl5gPTOYMeFV4kkuUuoy2yYqTI/pPJttwGF/5dppLFRyJh/aYWJSR1+FshKHo5K+EN4OOVLOBndUN8Dsz3YRpbxwLpfUxmmo8KQAazWfKbVT7Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KuNg2c5r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuNg2c5r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762141826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zZBMmjOc3396QnbZOeC0waNjt+HkuhVErA3hM2iOIVw=;
	b=KuNg2c5rM+tfwsE9eBGe9ps36U2hIKrWYVvDKQ75CV+39/kWCSTOjzuaYfQsZCeZqembi2
	Wcm49R0zNe4uScevMXJ6F0nsxHzz7Y0/U/yz6jxePS+a45T5HQfARmc1t5gcvrtaKthwCs
	kkdglCDsLo8XqIPbHSg6rpGDRvxKTTo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-6hZ2FLhKPNaxdcd4Cl9KVQ-1; Sun,
 02 Nov 2025 22:50:23 -0500
X-MC-Unique: 6hZ2FLhKPNaxdcd4Cl9KVQ-1
X-Mimecast-MFC-AGG-ID: 6hZ2FLhKPNaxdcd4Cl9KVQ_1762141822
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1EF5195605A;
	Mon,  3 Nov 2025 03:50:21 +0000 (UTC)
Received: from fedora (unknown [10.72.120.21])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A18B1956056;
	Mon,  3 Nov 2025 03:50:15 +0000 (UTC)
Date: Mon, 3 Nov 2025 11:50:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	yi.zhang@redhat.com, czhong@redhat.com, gjoyce@ibm.com
Subject: Re: [PATCHv3 2/4] block: move elevator tags into struct
 elevator_resources
Message-ID: <aQgmckPkiAtr8LzM@fedora>
References: <20251029103622.205607-1-nilay@linux.ibm.com>
 <20251029103622.205607-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029103622.205607-3-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Oct 29, 2025 at 04:06:15PM +0530, Nilay Shroff wrote:
> This patch introduces a new structure, struct elevator_resources, to
> group together all elevator-related resources that share the same
> lifetime. As a first step, this change moves the elevator tag pointer
> from struct elv_change_ctx into the new struct elevator_resources.
> 
> Additionally, rename blk_mq_alloc_sched_tags_batch() and
> blk_mq_free_sched_tags_batch() to blk_mq_alloc_sched_res_batch() and
> blk_mq_free_sched_res_batch(), respectively. Introduce two new wrapper
> helpers, blk_mq_alloc_sched_res() and blk_mq_free_sched_res(), around
> blk_mq_alloc_sched_tags() and blk_mq_free_sched_tags().
> 
> These changes pave the way for consolidating the allocation and freeing
> of elevator-specific resources into common helper functions. This
> refactoring improves encapsulation and prepares the code for future
> extensions, allowing additional elevator-specific data to be added to
> struct elevator_resources without cluttering struct elv_change_ctx.
> 
> Subsequent patches will extend struct elevator_resources to include
> other elevator-related data.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  block/blk-mq-sched.c | 55 ++++++++++++++++++++++++++++----------------
>  block/blk-mq-sched.h | 10 +++++---
>  block/blk-mq.c       |  2 +-
>  block/elevator.c     | 35 ++++++++++++++--------------
>  block/elevator.h     | 11 ++++++---
>  5 files changed, 69 insertions(+), 44 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 3d9386555a50..6db45b0819e6 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -427,7 +427,16 @@ void blk_mq_free_sched_tags(struct elevator_tags *et,
>  	kfree(et);
>  }
>  
> -void blk_mq_free_sched_tags_batch(struct xarray *elv_tbl,
> +void blk_mq_free_sched_res(struct elevator_resources *res,
> +		struct blk_mq_tag_set *set)
> +{
> +	if (res->et) {
> +		blk_mq_free_sched_tags(res->et, set);
> +		res->et = NULL;
> +	}
> +}
> +
> +void blk_mq_free_sched_res_batch(struct xarray *elv_tbl,
>  		struct blk_mq_tag_set *set)
>  {
>  	struct request_queue *q;
> @@ -445,12 +454,11 @@ void blk_mq_free_sched_tags_batch(struct xarray *elv_tbl,
>  		 */
>  		if (q->elevator) {
>  			ctx = xa_load(elv_tbl, q->id);
> -			if (!ctx || !ctx->et) {
> +			if (!ctx) {
>  				WARN_ON_ONCE(1);
>  				continue;
>  			}
> -			blk_mq_free_sched_tags(ctx->et, set);
> -			ctx->et = NULL;
> +			blk_mq_free_sched_res(&ctx->res, set);
>  		}
>  	}
>  }
> @@ -532,12 +540,22 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>  	return NULL;
>  }
>  
> -int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
> +int blk_mq_alloc_sched_res(struct elevator_resources *res,
> +		struct blk_mq_tag_set *set, unsigned int nr_hw_queues)
> +{
> +	res->et = blk_mq_alloc_sched_tags(set, nr_hw_queues,
> +			blk_mq_default_nr_requests(set));
> +	if (!res->et)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +int blk_mq_alloc_sched_res_batch(struct xarray *elv_tbl,
>  		struct blk_mq_tag_set *set, unsigned int nr_hw_queues)
>  {
>  	struct elv_change_ctx *ctx;
>  	struct request_queue *q;
> -	struct elevator_tags *et;
>  	int ret = -ENOMEM;
>  
>  	lockdep_assert_held_write(&set->update_nr_hwq_lock);
> @@ -557,11 +575,10 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
>  				goto out_unwind;
>  			}
>  
> -			ctx->et = blk_mq_alloc_sched_tags(set, nr_hw_queues,
> -					blk_mq_default_nr_requests(set));
> -			if (!ctx->et)
> +			ret = blk_mq_alloc_sched_res(&ctx->res, set,
> +					nr_hw_queues);
> +			if (ret)
>  				goto out_unwind;
> -
>  		}
>  	}
>  	return 0;
> @@ -569,10 +586,8 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
>  	list_for_each_entry_continue_reverse(q, &set->tag_list, tag_set_list) {
>  		if (q->elevator) {
>  			ctx = xa_load(elv_tbl, q->id);
> -			if (ctx && ctx->et) {
> -				blk_mq_free_sched_tags(ctx->et, set);
> -				ctx->et = NULL;
> -			}
> +			if (ctx)
> +				blk_mq_free_sched_res(&ctx->res, set);
>  		}
>  	}
>  	return ret;
> @@ -580,7 +595,7 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
>  
>  /* caller must have a reference to @e, will grab another one if successful */
>  int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
> -		struct elevator_tags *et)
> +		struct elevator_resources *res)
>  {
>  	unsigned int flags = q->tag_set->flags;
>  	struct blk_mq_hw_ctx *hctx;
> @@ -588,23 +603,23 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
>  	unsigned long i;
>  	int ret;
>  
> -	eq = elevator_alloc(q, e, et);
> +	eq = elevator_alloc(q, e, res);
>  	if (!eq)
>  		return -ENOMEM;
>  
> -	q->nr_requests = et->nr_requests;
> +	q->nr_requests = res->et->nr_requests;
>  
>  	if (blk_mq_is_shared_tags(flags)) {
>  		/* Shared tags are stored at index 0 in @et->tags. */
> -		q->sched_shared_tags = et->tags[0];
> -		blk_mq_tag_update_sched_shared_tags(q, et->nr_requests);
> +		q->sched_shared_tags = res->et->tags[0];
> +		blk_mq_tag_update_sched_shared_tags(q, res->et->nr_requests);
>  	}
>  
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		if (blk_mq_is_shared_tags(flags))
>  			hctx->sched_tags = q->sched_shared_tags;
>  		else
> -			hctx->sched_tags = et->tags[i];
> +			hctx->sched_tags = res->et->tags[i];
>  	}

The above change(include elevator_alloc() signature change) can be avoided if
you add one local variable `et`.

Otherwise, this patch looks fine.


Thanks, 
Ming

