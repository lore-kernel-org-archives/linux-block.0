Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EF817741
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753014195; cv=none; b=fqSr/8+TCN+eYvtCnI+kzeyBo4Igpr1Eg6toYvgLF8Peiaq8UkRIrZtJd8tgukMd8WhcAhLH3d1sETvq/tDUafCwcf7gVtFJ0fZBddKsHWk+U/voR881Joeu2tFA8GhtywS3dUtOyH74b/HIrnrv3U5dsF9i/xLBUWSw2/xvWk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753014195; c=relaxed/simple;
	bh=j1OThs9UUwPk4MSG01yFWO8Y84gTAE/hpLmbc84nrq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnAXkNmpPPY+G9IFyeDQuS2oMDM04sRRN84U4Uw76Xs3hMzHoByo5VtQp9iVrwMyssLl0ijgvl9xNHzAD13x87uKjCxRQVxAF+kFYmd+9QxdXlu88SXqHWvIxxeLf4s19zTcBXUxUMO3ghRuOhqjMDe7IzbENgRfodAnde5dx6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EuGdNQ20; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuGdNQ20"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753014192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QBwA4uVA7lirGb8SvK8/0MRFYCUFHt7VyaOMUF2QLbc=;
	b=EuGdNQ20xUOJ4Eq0vSak4KKd/xSGHfN7mxFAtyhMn6uSC4gd5cSCxSJrcQrFha9JEBpdGx
	OOf14dnWU2e8b7kpssi1VIdvlrufh6y2nV90trSDpjZGDGWQqK5qH7SRazO6ftJFilrft8
	z8l8W6DjWTqm380IKhXLopvZwJ3Koso=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-POgMn-uHO9iISpcpNWm7dw-1; Sun,
 20 Jul 2025 08:23:10 -0400
X-MC-Unique: POgMn-uHO9iISpcpNWm7dw-1
X-Mimecast-MFC-AGG-ID: POgMn-uHO9iISpcpNWm7dw_1753014189
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40BB51956089;
	Sun, 20 Jul 2025 12:23:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.10])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B527318002B6;
	Sun, 20 Jul 2025 12:23:03 +0000 (UTC)
Date: Sun, 20 Jul 2025 20:22:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, hare@suse.de, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [PATCH] block: fix module reference leak in mq-deadline I/O
 scheduler
Message-ID: <aHzfoqDm2wB9tvGq@fedora>
References: <20250719132722.769536-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719132722.769536-1-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sat, Jul 19, 2025 at 06:56:47PM +0530, Nilay Shroff wrote:
> During probe, when the block layer registers a request queue, it
> defaults to the mq-deadline I/O scheduler if the device is single-queue
> and the mq-deadline module is available. To determine availability, the
> elevator_set_default() invokes elevator_find_get(), which increments the
> module's reference count. However, this reference is never released,
> resulting in a module reference leak that prevents the mq-deadline module
> from being unloaded.
> 
> This patch fixes the issue by ensuring the acquired module reference is
> properly released.
> 
> Fixes: 1e44bedbc921 ("block: unifying elevator change")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> Note: This patch is based on https://lore.kernel.org/all/20250718133232.626418-1-nilay@linux.ibm.com/
> So please apply this patch after the above is merged.
> ---
>  block/elevator.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 83d0bfb90a03..2bbf7ad7f4db 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -719,7 +719,8 @@ void elevator_set_default(struct request_queue *q)
>  		.name = "mq-deadline",
>  		.no_uevent = true,
>  	};
> -	int err = 0;
> +	int err;
> +	struct elevator_type *e;
>  
>  	/* now we allow to switch elevator */
>  	blk_queue_flag_clear(QUEUE_FLAG_NO_ELV_SWITCH, q);
> @@ -732,12 +733,18 @@ void elevator_set_default(struct request_queue *q)
>  	 * have multiple queues or mq-deadline is not available, default
>  	 * to "none".
>  	 */
> -	if (elevator_find_get(ctx.name) && (q->nr_hw_queues == 1 ||
> -			 blk_mq_is_shared_tags(q->tag_set->flags)))
> +	e = elevator_find_get(ctx.name);
> +	if (!e)
> +		return;
> +
> +	if ((q->nr_hw_queues == 1 ||
> +			blk_mq_is_shared_tags(q->tag_set->flags))) {
>  		err = elevator_change(q, &ctx);
> -	if (err < 0)
> -		pr_warn("\"%s\" elevator initialization, failed %d, "
> -			"falling back to \"none\"\n", ctx.name, err);
> +		if (err < 0)
> +			pr_warn("\"%s\" elevator initialization, failed %d, falling back to \"none\"\n",
> +					ctx.name, err);
> +	}
> +	elevator_put(e);

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

