Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE9828A1CC
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 04:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762142937; cv=none; b=iOMZqZWJy+rK/n570n6kUd66ROd2I7t99Y7wBw2pdBBPGTzPqYHv7swS5DI+J3VgztN76eJFXL2WILhTmeG7QhBW2Qv2rWPEbcE2PcdVs3lyRizm9EpeOy9IJar2p7ho1gfX3u8OuAvZxvJUzZr8aIhspugEvvPgRoBazDLkK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762142937; c=relaxed/simple;
	bh=MpccrSRXK91+QzCjLZg9+coaTH8qJgVYNx2eOcQm2OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giHhlaVUQZJzTXv2KzHiqL8wqEn706qCuaQK1O6RSjjxBbeED63If12lwpkmg4M09riwAsqkn1TeJmQN69/3qAPrFZfvx1iT14w2wRMRtJr4VbBzFhAau3WPIpCKpfNI9U2aqHkhYX4wdRokVnIzkCdbRtEG5/uYTmnw4kXI3JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxxynQm9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxxynQm9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762142933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12FNrOC5spRaQIJkFFhu8cvQ0gMqDdE0I6yBleacPU4=;
	b=fxxynQm9zb1cKEL75BtI1d9RWf4UKiSedw5oLEviF5qfMb4vUWJjJcVmwwXG75ZNVVZImZ
	cyigyB0mtLG3tFiHvgttMsTeXfM8ZVqp6nPMBqX10UfBKn95Txpr5TtXfy0Aroqp9obsFu
	GJ3xDvtqfkEZqHcdj+vT23SNuCE9bWQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-UssqZD07P8OnNy-kzzQxPw-1; Sun,
 02 Nov 2025 23:08:49 -0500
X-MC-Unique: UssqZD07P8OnNy-kzzQxPw-1
X-Mimecast-MFC-AGG-ID: UssqZD07P8OnNy-kzzQxPw_1762142927
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 308371800741;
	Mon,  3 Nov 2025 04:08:47 +0000 (UTC)
Received: from fedora (unknown [10.72.120.21])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDD9F180035A;
	Mon,  3 Nov 2025 04:08:41 +0000 (UTC)
Date: Mon, 3 Nov 2025 12:08:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	yi.zhang@redhat.com, czhong@redhat.com, gjoyce@ibm.com
Subject: Re: [PATCHv3 3/4] block: introduce alloc_sched_data and
 free_sched_data elevator methods
Message-ID: <aQgqw-DX1A3R3wuN@fedora>
References: <20251029103622.205607-1-nilay@linux.ibm.com>
 <20251029103622.205607-4-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029103622.205607-4-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Oct 29, 2025 at 04:06:16PM +0530, Nilay Shroff wrote:
> The recent lockdep splat [1] highlights a potential deadlock risk
> involving ->elevator_lock and ->freeze_lock dependencies on -pcpu_alloc_
> mutex. The trace shows that the issue occurs when the Kyber scheduler
> allocates dynamic memory for its elevator data during initialization.
> 
> To address this, introduce two new elevator operation callbacks:
> ->alloc_sched_data and ->free_sched_data.
> 
> When an elevator implements these methods, they are invoked during
> scheduler switch before acquiring ->freeze_lock and ->elevator_lock.
> This allows safe allocation and deallocation of per-elevator data
> without holding locks that could depend on pcpu_alloc_mutex, effectively
> breaking the lock dependency chain and avoiding the reported deadlock
> scenario.
> 
> [1] https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com/
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  block/blk-mq-sched.c | 30 +++++++++++++++++++++++-------
>  block/blk-mq-sched.h | 25 +++++++++++++++++++++++--
>  block/elevator.c     | 35 +++++++++++++++++++++++++----------
>  block/elevator.h     |  4 ++++
>  4 files changed, 75 insertions(+), 19 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 6db45b0819e6..4376d0ddbd1e 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -428,12 +428,17 @@ void blk_mq_free_sched_tags(struct elevator_tags *et,
>  }
>  
>  void blk_mq_free_sched_res(struct elevator_resources *res,
> +		struct elevator_type *type,
>  		struct blk_mq_tag_set *set)
>  {
>  	if (res->et) {
>  		blk_mq_free_sched_tags(res->et, set);
>  		res->et = NULL;
>  	}
> +	if (res->data) {
> +		blk_mq_free_sched_data(type, res->data);
> +		res->data = NULL;
> +	}
>  }
>  
>  void blk_mq_free_sched_res_batch(struct xarray *elv_tbl,
> @@ -458,7 +463,7 @@ void blk_mq_free_sched_res_batch(struct xarray *elv_tbl,
>  				WARN_ON_ONCE(1);
>  				continue;
>  			}
> -			blk_mq_free_sched_res(&ctx->res, set);
> +			blk_mq_free_sched_res(&ctx->res, ctx->type, set);
>  		}
>  	}
>  }
> @@ -540,15 +545,24 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>  	return NULL;
>  }
>  
> -int blk_mq_alloc_sched_res(struct elevator_resources *res,
> -		struct blk_mq_tag_set *set, unsigned int nr_hw_queues)
> +int blk_mq_alloc_sched_res(struct request_queue *q,
> +		struct elevator_type *type,
> +		struct elevator_resources *res,
> +		struct blk_mq_tag_set *set,
> +		unsigned int nr_hw_queues)
>  {
> +	int ret;
> +
>  	res->et = blk_mq_alloc_sched_tags(set, nr_hw_queues,
>  			blk_mq_default_nr_requests(set));
>  	if (!res->et)
>  		return -ENOMEM;
>  
> -	return 0;
> +	ret = blk_mq_alloc_sched_data(q, type, &res->data);
> +	if (ret)
> +		kfree(res->et);

use blk_mq_free_sched_res() instead of kfree() for avoiding memleak.

> +
> +	return ret;
>  }
>  
>  int blk_mq_alloc_sched_res_batch(struct xarray *elv_tbl,
> @@ -575,19 +589,21 @@ int blk_mq_alloc_sched_res_batch(struct xarray *elv_tbl,
>  				goto out_unwind;
>  			}
>  
> -			ret = blk_mq_alloc_sched_res(&ctx->res, set,
> -					nr_hw_queues);
> +			ret = blk_mq_alloc_sched_res(q, q->elevator->type,
> +					&ctx->res, set, nr_hw_queues);
>  			if (ret)
>  				goto out_unwind;
>  		}
>  	}
>  	return 0;
> +
>  out_unwind:
>  	list_for_each_entry_continue_reverse(q, &set->tag_list, tag_set_list) {
>  		if (q->elevator) {
>  			ctx = xa_load(elv_tbl, q->id);
>  			if (ctx)
> -				blk_mq_free_sched_res(&ctx->res, set);
> +				blk_mq_free_sched_res(&ctx->res,
> +						ctx->type, set);
>  		}
>  	}
>  	return ret;
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 97204df76def..acd4f1355be6 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -25,8 +25,11 @@ void blk_mq_sched_free_rqs(struct request_queue *q);
>  
>  struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>  		unsigned int nr_hw_queues, unsigned int nr_requests);
> -int blk_mq_alloc_sched_res(struct elevator_resources *res,
> -		struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
> +int blk_mq_alloc_sched_res(struct request_queue *q,
> +		struct elevator_type *type,
> +		struct elevator_resources *res,
> +		struct blk_mq_tag_set *set,
> +		unsigned int nr_hw_queues);
>  int blk_mq_alloc_sched_res_batch(struct xarray *elv_tbl,
>  		struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
>  int blk_mq_alloc_sched_ctx_batch(struct xarray *elv_tbl,
> @@ -35,10 +38,28 @@ void blk_mq_free_sched_ctx_batch(struct xarray *elv_tbl);
>  void blk_mq_free_sched_tags(struct elevator_tags *et,
>  		struct blk_mq_tag_set *set);
>  void blk_mq_free_sched_res(struct elevator_resources *res,
> +		struct elevator_type *type,
>  		struct blk_mq_tag_set *set);
>  void blk_mq_free_sched_res_batch(struct xarray *et_table,
>  		struct blk_mq_tag_set *set);
>  
> +static inline int blk_mq_alloc_sched_data(struct request_queue *q,
> +		struct elevator_type *e, void **data)
> +{
> +	if (e && e->ops.alloc_sched_data) {
> +		*data = e->ops.alloc_sched_data(q);
> +		if (!*data)
> +			return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +static inline void blk_mq_free_sched_data(struct elevator_type *e, void *data)
> +{
> +	if (e && e->ops.free_sched_data)
> +		e->ops.free_sched_data(data);
> +}
> +
>  static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
>  {
>  	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
> diff --git a/block/elevator.c b/block/elevator.c
> index d5d89b202fda..8696b2a741b7 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -135,6 +135,7 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
>  	mutex_init(&eq->sysfs_lock);
>  	hash_init(eq->hash);
>  	eq->et = res->et;
> +	eq->elevator_data = res->data;
>  
>  	return eq;
>  }
> @@ -617,7 +618,7 @@ static void elv_exit_and_release(struct elv_change_ctx *ctx,
>  	mutex_unlock(&q->elevator_lock);
>  	blk_mq_unfreeze_queue(q, memflags);
>  	if (e) {
> -		blk_mq_free_sched_res(&ctx->res, q->tag_set);
> +		blk_mq_free_sched_res(&ctx->res, ctx->type, q->tag_set);
>  		kobject_put(&e->kobj);
>  	}
>  }
> @@ -628,12 +629,15 @@ static int elevator_change_done(struct request_queue *q,
>  	int ret = 0;
>  
>  	if (ctx->old) {
> -		struct elevator_resources res = {.et = ctx->old->et};
> +		struct elevator_resources res = {
> +			.et = ctx->old->et,
> +			.data = ctx->old->elevator_data
> +		};
>  		bool enable_wbt = test_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT,
>  				&ctx->old->flags);
>  
>  		elv_unregister_queue(q, ctx->old);
> -		blk_mq_free_sched_res(&res, q->tag_set);
> +		blk_mq_free_sched_res(&res, ctx->old->type, q->tag_set);
>  		kobject_put(&ctx->old->kobj);
>  		if (enable_wbt)
>  			wbt_enable_default(q->disk);
> @@ -658,7 +662,8 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>  	lockdep_assert_held(&set->update_nr_hwq_lock);
>  
>  	if (strncmp(ctx->name, "none", 4)) {
> -		ret = blk_mq_alloc_sched_res(&ctx->res, set, set->nr_hw_queues);
> +		ret = blk_mq_alloc_sched_res(q, ctx->type, &ctx->res, set,
> +				set->nr_hw_queues);
>  		if (ret)
>  			return ret;
>  	}
> @@ -681,11 +686,15 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>  	blk_mq_unfreeze_queue(q, memflags);
>  	if (!ret)
>  		ret = elevator_change_done(q, ctx);
> +
> +	if (ctx->new) /* switching to new elevator is successful */
> +		return ret;
> +

Not necessary.


>  	/*
>  	 * Free sched resource if it's allocated but we couldn't switch elevator.
>  	 */
>  	if (!ctx->new)
> -		blk_mq_free_sched_res(&ctx->res, set);
> +		blk_mq_free_sched_res(&ctx->res, ctx->type, set);
>  
>  	return ret;
>  }
> @@ -711,11 +720,14 @@ void elv_update_nr_hw_queues(struct request_queue *q,
>  	blk_mq_unfreeze_queue_nomemrestore(q);
>  	if (!ret)
>  		WARN_ON_ONCE(elevator_change_done(q, ctx));
> +
> +	if (ctx->new) /* switching to new elevator is successful */
> +		return;

Not necessary.

>  	/*
>  	 * Free sched resource if it's allocated but we couldn't switch elevator.
>  	 */
>  	if (!ctx->new)
> -		blk_mq_free_sched_res(&ctx->res, set);
> +		blk_mq_free_sched_res(&ctx->res, ctx->type, set);
>  }
>  
>  /*
> @@ -729,7 +741,6 @@ void elevator_set_default(struct request_queue *q)
>  		.no_uevent = true,
>  	};
>  	int err;
> -	struct elevator_type *e;
>  
>  	/* now we allow to switch elevator */
>  	blk_queue_flag_clear(QUEUE_FLAG_NO_ELV_SWITCH, q);
> @@ -742,8 +753,8 @@ void elevator_set_default(struct request_queue *q)
>  	 * have multiple queues or mq-deadline is not available, default
>  	 * to "none".
>  	 */
> -	e = elevator_find_get(ctx.name);
> -	if (!e)
> +	ctx.type = elevator_find_get(ctx.name);
> +	if (!ctx.type)
>  		return;
>  
>  	if ((q->nr_hw_queues == 1 ||
> @@ -753,7 +764,7 @@ void elevator_set_default(struct request_queue *q)
>  			pr_warn("\"%s\" elevator initialization, failed %d, falling back to \"none\"\n",
>  					ctx.name, err);
>  	}
> -	elevator_put(e);
> +	elevator_put(ctx.type);
>  }
>  
>  void elevator_set_none(struct request_queue *q)
> @@ -802,6 +813,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>  	ctx.name = strstrip(elevator_name);
>  
>  	elv_iosched_load_module(ctx.name);
> +	ctx.type = elevator_find_get(ctx.name);
>  
>  	down_read(&set->update_nr_hwq_lock);
>  	if (!blk_queue_no_elv_switch(q)) {
> @@ -812,6 +824,9 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>  		ret = -ENOENT;
>  	}
>  	up_read(&set->update_nr_hwq_lock);
> +
> +	if (ctx.type)
> +		elevator_put(ctx.type);
>  	return ret;

The above change can be unified into elevator_change() by one standalone
patch, so elv_iosched_store() can be covered too.


Thanks, 
Ming

