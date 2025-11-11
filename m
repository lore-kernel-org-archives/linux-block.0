Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508532FD689
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 02:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762829563; cv=none; b=Qxc027aQ91IyyA2dFedC5YSEZbSdEk8GCBoHeXxoHaplX94eCv1E1HsdXemdzVnyw9Via1olPmOqj5EyU7s3b7MgFjcukMRsiZqL7cO5gtHZ16TPtEYaAbQCndIwIQ6RNuH10SGp4BuFiHo2jS0LoYwaxKMZdRYhE1waXmUyCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762829563; c=relaxed/simple;
	bh=eCLkcFARaTiya5/pGoXl0gC7XVAYLeq3i67y3OWde+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpEu/f25XyXiJcfEjkt4VclE7vXqsMsx88T6cMOExG1YtGMuifNbb4l+bxvOyJDRtQ35owwlolfNs7RwcHV2XpTjnzmtusAv4ZynuZMNaYARPQSfSgkSwdt6s+DZH39Md1Anvuu+I3hxcE/YtWHtIZOfNGORXUWfHsilrGkQHvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fkiqxPEw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkiqxPEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762829560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m6S1AlD4F0wPf3GnBMod6VIquJjM5ju4CHs+ZxK1XL4=;
	b=fkiqxPEwxx38E6NI1/F+eNT2Qv40wO2i0Wk3/9FeF1G/9NqfBLK7PhGV6xjviHOHTgxe/c
	8Zfx0NpqkaVRDW+Fs5mqQRss3Ij99Tg7/m92xv2pshzYETVFpcapOHzPICo78bAT+nkR/V
	6FON0FtGqVzsdVP54P2FtZAtGFhqdiM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-sE1w_2QGP8iQDAKEQFuAFA-1; Mon,
 10 Nov 2025 21:52:36 -0500
X-MC-Unique: sE1w_2QGP8iQDAKEQFuAFA-1
X-Mimecast-MFC-AGG-ID: sE1w_2QGP8iQDAKEQFuAFA_1762829555
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EA051956089;
	Tue, 11 Nov 2025 02:52:35 +0000 (UTC)
Received: from fedora (unknown [10.72.116.124])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D25581800451;
	Tue, 11 Nov 2025 02:52:28 +0000 (UTC)
Date: Tue, 11 Nov 2025 10:52:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	yi.zhang@redhat.com, czhong@redhat.com, yukuai@fnnas.com,
	gjoyce@ibm.com
Subject: Re: [PATCHv4 2/5] block: move elevator tags into struct
 elevator_resources
Message-ID: <aRKk5uz5altdiEil@fedora>
References: <20251110081457.1006206-1-nilay@linux.ibm.com>
 <20251110081457.1006206-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110081457.1006206-3-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Nov 10, 2025 at 01:44:49PM +0530, Nilay Shroff wrote:
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
>  block/elevator.c     | 31 +++++++++++++------------
>  block/elevator.h     |  9 ++++++--
>  5 files changed, 66 insertions(+), 41 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 3d9386555a50..c7091ea4dccd 100644
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

In patch 4, `struct request_queue *` is added to parameter of
blk_mq_alloc_sched_res(), so why not add it from beginning?
Then ` struct blk_mq_tag_set *set` can be avoided.

Similar with blk_mq_free_sched_res().

This way is more readable, because scheduler is request_queue
wide.

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
> +	eq = elevator_alloc(q, e, res->et);
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

Adding one local variable of 'et' could kill all above changes, looks you like
big patch, but up to you.


Thanks, 
Ming

