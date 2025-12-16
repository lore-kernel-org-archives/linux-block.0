Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5703B33FE15
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765883051; cv=none; b=Y7QCm/KRZbPrRmgHEg4dnLbMhUca9f8eW4dLnoEKlPg1tZwjJSyatenjmiL2UId3y6dUm7L8Kbj//q8FUwkf0z9fwR9gXKIDTfMdzTaG/PM227GTs5wOGUIxlfT7U1ariNnSA1AoCXVi140nwGgbjm4AjdzJXNqJ0vua7CvQBM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765883051; c=relaxed/simple;
	bh=NigjvlGfAaur1l5jjpd0dY+SGrsP5whtd61up0JLUCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtLuVnTCA26Uxmn/fDWvaEvLs4nWkYAjZ5yDHgEfp13Xb0YIZ1QdzUvGWqL4XxXaHo7Iu8wtAh7+Ajw+6ia1w4kO1+Dpc35QOLpnLFZOqEPufVFpoZxAVLIS0lnj68MUcspQW6AM0g0dcEtdkzQ9PdsO95Q2GvAolcZJf6ugSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GeyaeJ04; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeyaeJ04"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765883048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jleQgJ+tgDSsBxa34lU//k4QBqeaGJJ4X6iKD7iGBx8=;
	b=GeyaeJ04r5cLarMDZDO5tmdZEc5u9x3MpPXub4F4Jj5ci3sN0ybTse3SyRqnB+XqnNQYgw
	nCYfoJJFaguJ+nWzK2kd15JZYOZP6qcmdACi2JMZ/NeZudkE3a5r1n+bPANZg1ve1osZ/M
	GhLKp4lDoW0ijP3eyJdDgTkxtTP4JRY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-_4d8MEjjOeGpm6lXHNjxtg-1; Tue,
 16 Dec 2025 06:04:04 -0500
X-MC-Unique: _4d8MEjjOeGpm6lXHNjxtg-1
X-Mimecast-MFC-AGG-ID: _4d8MEjjOeGpm6lXHNjxtg_1765883043
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A43619560A1;
	Tue, 16 Dec 2025 11:04:03 +0000 (UTC)
Received: from fedora (unknown [10.72.116.190])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 041261800668;
	Tue, 16 Dec 2025 11:03:58 +0000 (UTC)
Date: Tue, 16 Dec 2025 19:03:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v5 02/13] blk-wbt: fix possible deadlock to nest
 pcpu_alloc_mutex under q_usage_counter
Message-ID: <aUE8lSlWa6DnCYMa@fedora>
References: <20251214101409.1723751-1-yukuai@fnnas.com>
 <20251214101409.1723751-3-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214101409.1723751-3-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sun, Dec 14, 2025 at 06:13:57PM +0800, Yu Kuai wrote:
> If wbt is disabled by default and user configures wbt by sysfs, queue
> will be frozen first and then pcpu_alloc_mutex will be held in
> blk_stat_alloc_callback().
> 
> Fix this problem by allocating memory first before queue frozen.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---
>  block/blk-wbt.c | 106 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 61 insertions(+), 45 deletions(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index ba807649b29a..696baa681717 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -93,7 +93,7 @@ struct rq_wb {
>  	struct rq_depth rq_depth;
>  };
>  
> -static int wbt_init(struct gendisk *disk);
> +static int wbt_init(struct gendisk *disk, struct rq_wb *rwb);
>  
>  static inline struct rq_wb *RQWB(struct rq_qos *rqos)
>  {
> @@ -698,6 +698,41 @@ static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
>  	}
>  }
>  
> +static int wbt_data_dir(const struct request *rq)
> +{
> +	const enum req_op op = req_op(rq);
> +
> +	if (op == REQ_OP_READ)
> +		return READ;
> +	else if (op_is_write(op))
> +		return WRITE;
> +
> +	/* don't account */
> +	return -1;
> +}
> +
> +static struct rq_wb *wbt_alloc(void)
> +{
> +	struct rq_wb *rwb = kzalloc(sizeof(*rwb), GFP_KERNEL);
> +
> +	if (!rwb)
> +		return NULL;
> +
> +	rwb->cb = blk_stat_alloc_callback(wb_timer_fn, wbt_data_dir, 2, rwb);
> +	if (!rwb->cb) {
> +		kfree(rwb);
> +		return NULL;
> +	}
> +
> +	return rwb;
> +}
> +
> +static void wbt_free(struct rq_wb *rwb)
> +{
> +	blk_stat_free_callback(rwb->cb);
> +	kfree(rwb);
> +}
> +
>  /*
>   * Enable wbt if defaults are configured that way
>   */
> @@ -726,8 +761,15 @@ void wbt_enable_default(struct gendisk *disk)
>  	if (!blk_queue_registered(q))
>  		return;
>  
> -	if (queue_is_mq(q) && enable)
> -		wbt_init(disk);
> +	if (queue_is_mq(q) && enable) {
> +		struct rq_wb *rwb = wbt_alloc();
> +
> +		if (WARN_ON_ONCE(!rwb))
> +			return;
> +
> +		if (WARN_ON_ONCE(wbt_init(disk, rwb)))
> +			wbt_free(rwb);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(wbt_enable_default);
>  
> @@ -743,19 +785,6 @@ static u64 wbt_default_latency_nsec(struct request_queue *q)
>  		return 75000000ULL;
>  }
>  
> -static int wbt_data_dir(const struct request *rq)
> -{
> -	const enum req_op op = req_op(rq);
> -
> -	if (op == REQ_OP_READ)
> -		return READ;
> -	else if (op_is_write(op))
> -		return WRITE;
> -
> -	/* don't account */
> -	return -1;
> -}
> -
>  static void wbt_queue_depth_changed(struct rq_qos *rqos)
>  {
>  	RQWB(rqos)->rq_depth.queue_depth = blk_queue_depth(rqos->disk->queue);
> @@ -767,8 +796,7 @@ static void wbt_exit(struct rq_qos *rqos)
>  	struct rq_wb *rwb = RQWB(rqos);
>  
>  	blk_stat_remove_callback(rqos->disk->queue, rwb->cb);
> -	blk_stat_free_callback(rwb->cb);
> -	kfree(rwb);
> +	wbt_free(rwb);
>  }
>  
>  /*
> @@ -892,22 +920,11 @@ static const struct rq_qos_ops wbt_rqos_ops = {
>  #endif
>  };
>  
> -static int wbt_init(struct gendisk *disk)
> +static int wbt_init(struct gendisk *disk, struct rq_wb *rwb)
>  {
>  	struct request_queue *q = disk->queue;
> -	struct rq_wb *rwb;
> -	int i;
>  	int ret;
> -
> -	rwb = kzalloc(sizeof(*rwb), GFP_KERNEL);
> -	if (!rwb)
> -		return -ENOMEM;
> -
> -	rwb->cb = blk_stat_alloc_callback(wb_timer_fn, wbt_data_dir, 2, rwb);
> -	if (!rwb->cb) {
> -		kfree(rwb);
> -		return -ENOMEM;
> -	}
> +	int i;
>  
>  	for (i = 0; i < WBT_NUM_RWQ; i++)
>  		rq_wait_init(&rwb->rq_wait[i]);
> @@ -927,38 +944,38 @@ static int wbt_init(struct gendisk *disk)
>  	ret = rq_qos_add(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
>  	mutex_unlock(&q->rq_qos_mutex);
>  	if (ret)
> -		goto err_free;
> +		return ret;
>  
>  	blk_stat_add_callback(q, rwb->cb);
> -
>  	return 0;
> -
> -err_free:
> -	blk_stat_free_callback(rwb->cb);
> -	kfree(rwb);
> -	return ret;
> -
>  }
>  
>  int wbt_set_lat(struct gendisk *disk, s64 val)
>  {
>  	struct request_queue *q = disk->queue;
> +	struct rq_qos *rqos = wbt_rq_qos(q);
> +	struct rq_wb *rwb = NULL;
>  	unsigned int memflags;
> -	struct rq_qos *rqos;
>  	int ret = 0;
>  
> +	if (!rqos) {
> +		rwb = wbt_alloc();
> +		if (!rwb)
> +			return -ENOMEM;
> +	}
> +
>  	/*
>  	 * Ensure that the queue is idled, in case the latency update
>  	 * ends up either enabling or disabling wbt completely. We can't
>  	 * have IO inflight if that happens.
>  	 */
>  	memflags = blk_mq_freeze_queue(q);
> -
> -	rqos = wbt_rq_qos(q);
>  	if (!rqos) {
> -		ret = wbt_init(disk);
> -		if (ret)
> +		ret = wbt_init(disk, rwb);
> +		if (ret) {
> +			wbt_free(rwb);
>  			goto out;
> +		}

Here it actually depends on patch "block: fix race between wbt_enable_default and IO submission"
which kills wbt_init() from bfq & iocost code path, otherwise you may have
to handle -EBUSY from wbt_init().

With the mentioned patch, this fix looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

