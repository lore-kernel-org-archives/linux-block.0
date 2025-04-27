Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF94A21
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745759162; cv=none; b=KELQ/Cpkp+DWRfGukdD1Tx+snzdaCrXp6lxZP2POvFy8FdKzRzSOheDSqRF+73PVTr8f5U91u0Bm+V+PuaiUq7U+dD6VMV8ysXQO+WVJlC9AhFeT5fuqVAvAIMeodi4uQrERrlOL9cDMcI9DODftUrN5xQIFNNGsAXqBTaVhYqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745759162; c=relaxed/simple;
	bh=km39XhvjvGszlxi0xqBIgwXvlFJ25PMWqmeDa5M1+RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfYfCL7LLMdCZaD/ae99GphnxGyUflXYLf46GurqnDDRu+FUWbuKZRb5l/HEZ3aHt960pR7AMtMmU5CPIad0pZHMEjTCF/fO7T3tx9+6pfbGmZY7naAi9Al/wAQi5dL4osSAe2bLGv9FIyd38uv8aC8StvYI3HoFMoW2pXOMg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LH2cAUSK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LH2cAUSK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745759159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7WchR2FRTww6SQyzhTzdOmhFVuDdFJVQPa5vN7txbhA=;
	b=LH2cAUSKw7AThMVF5krKrLWozEhQ5uUkI2m+YBqCGUUsBYP88nytQFT8pU2kQNhPWfqurE
	aW/N6P+5KK964OYbn77a+Ro5YOCx6TVgD8LR2hSwoaN5BziisCnEpzcgWqiYAfFx1tNVJm
	3ixtlOVjOwtPKTNx77P4iiIlK5dXrjo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-OZ3FV4ooOmeudsE78NYDoA-1; Sun,
 27 Apr 2025 09:05:55 -0400
X-MC-Unique: OZ3FV4ooOmeudsE78NYDoA-1
X-Mimecast-MFC-AGG-ID: OZ3FV4ooOmeudsE78NYDoA_1745759154
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80EAC19560AE;
	Sun, 27 Apr 2025 13:05:54 +0000 (UTC)
Received: from fedora (unknown [10.72.116.119])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA5BD19560A3;
	Sun, 27 Apr 2025 13:05:50 +0000 (UTC)
Date: Sun, 27 Apr 2025 21:05:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] ublk: factor out ublk_start_io() helper
Message-ID: <aA4rqcpC01SzUn_g@fedora>
References: <20250427045803.772972-1-csander@purestorage.com>
 <20250427045803.772972-6-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427045803.772972-6-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Apr 26, 2025 at 10:58:00PM -0600, Caleb Sander Mateos wrote:
> In preparation for calling it from outside ublk_dispatch_req(), factor
> out the code responsible for setting up an incoming ublk I/O request.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 53 ++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 01fc92051754..90a38a82f8cc 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1151,17 +1151,44 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
>  		blk_mq_requeue_request(rq, false);
>  	else
>  		blk_mq_end_request(rq, BLK_STS_IOERR);
>  }
>  
> +static void ublk_start_io(struct ublk_queue *ubq, struct request *req,
> +			  struct ublk_io *io)
> +{
> +	unsigned mapped_bytes = ublk_map_io(ubq, req, io);
> +
> +	/* partially mapped, update io descriptor */
> +	if (unlikely(mapped_bytes != blk_rq_bytes(req))) {
> +		/*
> +		 * Nothing mapped, retry until we succeed.
> +		 *
> +		 * We may never succeed in mapping any bytes here because
> +		 * of OOM. TODO: reserve one buffer with single page pinned
> +		 * for providing forward progress guarantee.
> +		 */
> +		if (unlikely(!mapped_bytes)) {
> +			blk_mq_requeue_request(req, false);
> +			blk_mq_delay_kick_requeue_list(req->q,
> +					UBLK_REQUEUE_DELAY_MS);
> +			return;
> +		}
> +
> +		ublk_get_iod(ubq, req->tag)->nr_sectors =
> +			mapped_bytes >> 9;
> +	}
> +
> +	ublk_init_req_ref(ubq, req);
> +}
> +
>  static void ublk_dispatch_req(struct ublk_queue *ubq,
>  			      struct request *req,
>  			      unsigned int issue_flags)
>  {
>  	int tag = req->tag;
>  	struct ublk_io *io = &ubq->ios[tag];
> -	unsigned int mapped_bytes;
>  
>  	pr_devel("%s: complete: qid %d tag %d io_flags %x addr %llx\n",
>  			__func__, ubq->q_id, req->tag, io->flags,
>  			ublk_get_iod(ubq, req->tag)->addr);
>  
> @@ -1204,33 +1231,11 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
>  		pr_devel("%s: update iod->addr: qid %d tag %d io_flags %x addr %llx\n",
>  				__func__, ubq->q_id, req->tag, io->flags,
>  				ublk_get_iod(ubq, req->tag)->addr);
>  	}
>  
> -	mapped_bytes = ublk_map_io(ubq, req, io);
> -
> -	/* partially mapped, update io descriptor */
> -	if (unlikely(mapped_bytes != blk_rq_bytes(req))) {
> -		/*
> -		 * Nothing mapped, retry until we succeed.
> -		 *
> -		 * We may never succeed in mapping any bytes here because
> -		 * of OOM. TODO: reserve one buffer with single page pinned
> -		 * for providing forward progress guarantee.
> -		 */
> -		if (unlikely(!mapped_bytes)) {
> -			blk_mq_requeue_request(req, false);
> -			blk_mq_delay_kick_requeue_list(req->q,
> -					UBLK_REQUEUE_DELAY_MS);
> -			return;
> -		}

Here it needs to break ublk_dispatch_req() for not completing the
uring_cmd, however ublk_start_io() can't support it.


Thanks,
Ming

