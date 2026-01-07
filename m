Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3936E3148D4
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788438; cv=none; b=Sbzh6ZI7UMr2VuQTb8eh1+l5fJtF9QLpjKwMSJbjLvTPYHY2p+Cpsq5KIxISWp9buxuEqUzlaDZRH2tkcreVVbSuE+VIOUnU9ov0x+EyTTDi9zqV/u9uRaaKyFFV48nIJWwBqLVDq0mBJ4aiDW0yvm4vCa2cgZIZRj0slOn+nTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788438; c=relaxed/simple;
	bh=zzB0IIlvgN92QotRG+jJM4ZYNJcFSMwC3XY47/h6MFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQHAQ1oYIp+nV90VuLgCSWruhYpqRPeKlYCSVTdO4adYE0D/l+Pj16bOupQ9u6gHDZEeI1iPMZ4kpOypIzJBfArHIeE1jZfHhGvSrjDpAvP36hB3batW7SR7wma8meNVbC7YlA9UEeTZedxH6jn/ugZtklGPalewXgfd66OveJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYhc3Dxe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYhc3Dxe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767788436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q7WS3kJGUBC8pfd6pXhrdBltDpZ3u9m7tJ5JoDGR38s=;
	b=aYhc3DxeKwcSJCbSN4w7MdGXCeOmusy3zfqVksUADIYOgCK/3oujbHUJ5UsGduTGCD6Zyz
	GjtfWDcoGe+dt1HC6FdQ2sVWwRUsnA+CXgOZxmgZUzWgqMjFYfl8rNRF4Q/CheDXm5gsJF
	ih04dLS9CxHTZtfzSp0nZq4bTRObDs0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-trEk9NIaOeSdyTb6d1gyvw-1; Wed,
 07 Jan 2026 07:20:32 -0500
X-MC-Unique: trEk9NIaOeSdyTb6d1gyvw-1
X-Mimecast-MFC-AGG-ID: trEk9NIaOeSdyTb6d1gyvw_1767788431
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42667195608D;
	Wed,  7 Jan 2026 12:20:31 +0000 (UTC)
Received: from fedora (unknown [10.72.116.199])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2CAA30002D1;
	Wed,  7 Jan 2026 12:20:27 +0000 (UTC)
Date: Wed, 7 Jan 2026 20:20:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v7 13/16] blk-iolatency: fix incorrect lock order for
 rq_qos_mutex and freeze queue
Message-ID: <aV5PgIP9arDtlIWi@fedora>
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-14-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231085126.205310-14-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Dec 31, 2025 at 04:51:23PM +0800, Yu Kuai wrote:
> Currently blk-iolatency will hold rq_qos_mutex first and then call
> rq_qos_add() to freeze queue.
> 
> Fix this problem by converting to use blkg_conf_open_bdev_frozen()
> from iolatency_set_limit(), and convert to use rq_qos_add_frozen().
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---
>  block/blk-iolatency.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index 45bd18f68541..1558afbf517b 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -764,8 +764,8 @@ static int blk_iolatency_init(struct gendisk *disk)
>  	if (!blkiolat)
>  		return -ENOMEM;
>  
> -	ret = rq_qos_add(&blkiolat->rqos, disk, RQ_QOS_LATENCY,
> -			 &blkcg_iolatency_ops);
> +	ret = rq_qos_add_frozen(&blkiolat->rqos, disk, RQ_QOS_LATENCY,
> +				&blkcg_iolatency_ops);
>  	if (ret)
>  		goto err_free;
>  	ret = blkcg_activate_policy(disk, &blkcg_policy_iolatency);
> @@ -831,16 +831,19 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
>  	struct blkcg_gq *blkg;
>  	struct blkg_conf_ctx ctx;
>  	struct iolatency_grp *iolat;
> +	unsigned long memflags;
>  	char *p, *tok;
>  	u64 lat_val = 0;
>  	u64 oldval;
> -	int ret;
> +	int ret = 0;
>  
>  	blkg_conf_init(&ctx, buf);
>  
> -	ret = blkg_conf_open_bdev(&ctx);
> -	if (ret)
> +	memflags = blkg_conf_open_bdev_frozen(&ctx);

Same as the previous one, percpu allocation will be covered the added queue freeze...


Thanks,
Ming

