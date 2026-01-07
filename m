Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407BE2F90C4
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778914; cv=none; b=PGVxEhQrx4C2Fi6/WjyFg3lAgpfK1gQanwiryOqfMPqn873mgutRzV21FKYxqdgVctBK06n9u2BsjIXHFif2xXznkLKoN/DENSCA84mdmuaWBMNgOxGmMlEIh6u7U3k7UO+LTwkuOvb6nebAN7kmR2UizrrYAcohOgJqjXJUEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778914; c=relaxed/simple;
	bh=eO2vyfBF0twbwKRrOcJafvdco6gWhhisrlc5tssJPIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tX4gVUbI432wFsE3j39jIlSz/YOWm0Epfo7HffZ0ZNvjStxoWPL0OMeF8ONi5r3BJKmIO5gxCmaM8RWtVBfd/9dWlpTvH9lwNTssHWC9+ZHQDNiiXvqCv2nmruClMpES6JAQghqreR75KquNZtLN/6i9RNucnntk/E4u7ZdE0io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaK6e+P5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaK6e+P5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767778911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AtS8xtqAQudvcz1IwgL2LfH/FwGyY3A0rjaz8SEOTSQ=;
	b=LaK6e+P5FsQcsa0Pei5fZNfgrjfBafUIqm6bGNXzIy5vWuVSBzVXvsD5xCtzOXxWjE5/vH
	dlrX6YfsMduIQrPxW9VUtPn8tXEN/eZiI7sDkWX7WOjkdYy0lRNRQxmujFONGxhUIIwes+
	oIgDbXZ0cVY5kSBgJ4BRNq7u5dukWFY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-15aHJWQ8NI-7gyZwdttFvg-1; Wed,
 07 Jan 2026 04:41:49 -0500
X-MC-Unique: 15aHJWQ8NI-7gyZwdttFvg-1
X-Mimecast-MFC-AGG-ID: 15aHJWQ8NI-7gyZwdttFvg_1767778908
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C7D019560A3;
	Wed,  7 Jan 2026 09:41:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.199])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC00F18007D2;
	Wed,  7 Jan 2026 09:41:44 +0000 (UTC)
Date: Wed, 7 Jan 2026 17:41:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v7 04/16] blk-rq-qos: fix possible debugfs_mutex deadlock
Message-ID: <aV4qU9mRZFt_NHKK@fedora>
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-5-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231085126.205310-5-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Dec 31, 2025 at 04:51:14PM +0800, Yu Kuai wrote:
> Currently rq-qos debugfs entries are created from rq_qos_add(), while
> rq_qos_add() can be called while queue is still frozen. This can
> deadlock because creating new entries can trigger fs reclaim.
> 
> Fix this problem by delaying creating rq-qos debugfs entries after queue
> is unfrozen.
> 
> - For wbt, 1) it can be initialized by default, fix it by calling new
>   helper after wbt_init() from wbt_init_enable_default(); 2) it can be
>   initialized by sysfs, fix it by calling new helper after queue is
>   unfrozen from wbt_set_lat().
> - For iocost and iolatency, they can only be initialized by blkcg
>   configuration, however, they don't have debugfs entries for now, hence
>   they are not handled yet.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  block/blk-rq-qos.c |  7 -------
>  block/blk-wbt.c    | 13 ++++++++++++-
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index 654478dfbc20..d7ce99ce2e80 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -347,13 +347,6 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
>  	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
>  
>  	blk_mq_unfreeze_queue(q, memflags);
> -
> -	if (rqos->ops->debugfs_attrs) {
> -		mutex_lock(&q->debugfs_mutex);
> -		blk_mq_debugfs_register_rqos(rqos);
> -		mutex_unlock(&q->debugfs_mutex);
> -	}
> -
>  	return 0;
>  ebusy:
>  	blk_mq_unfreeze_queue(q, memflags);
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 9bef71ec645d..de3528236545 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -774,6 +774,7 @@ EXPORT_SYMBOL_GPL(wbt_enable_default);
>  
>  void wbt_init_enable_default(struct gendisk *disk)
>  {
> +	struct request_queue *q = disk->queue;
>  	struct rq_wb *rwb;
>  
>  	if (!__wbt_enable_default(disk))
> @@ -783,8 +784,14 @@ void wbt_init_enable_default(struct gendisk *disk)
>  	if (WARN_ON_ONCE(!rwb))
>  		return;
>  
> -	if (WARN_ON_ONCE(wbt_init(disk, rwb)))
> +	if (WARN_ON_ONCE(wbt_init(disk, rwb))) {
>  		wbt_free(rwb);
> +		return;
> +	}
> +
> +	mutex_lock(&q->debugfs_mutex);
> +	blk_mq_debugfs_register_rq_qos(q);
> +	mutex_unlock(&q->debugfs_mutex);
>  }
>  
>  static u64 wbt_default_latency_nsec(struct request_queue *q)
> @@ -1009,5 +1016,9 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
>  	blk_mq_unquiesce_queue(q);
>  out:
>  	blk_mq_unfreeze_queue(q, memflags);
> +	mutex_lock(&q->debugfs_mutex);
> +	blk_mq_debugfs_register_rq_qos(q);
> +	mutex_unlock(&q->debugfs_mutex);
> +

You may add one helper for avoiding the code duplication, but not a big
deal:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

