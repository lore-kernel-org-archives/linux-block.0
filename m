Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF68D20E6E3
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580571; cv=none; b=qk0u4WGqAzAC4niTRGnDx5f3FVPDfPzPR12p5QO+2mzOWgKZlL7h3KnvTfK5nri72dOs90DfdN10AnQOjP/ZL1TusSUnMoq5B36axt4RiXi4YR1oTjlGZGCAWHuW82TlCrcgQaphtPUu5EeMmZzGfJHEmH8ONJudO+FWrU+AQ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580571; c=relaxed/simple;
	bh=Ou788sx8A2FJ8/HN40a66FBRR0H5TxeBkoErVg9X6b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kESeMYARWkxj2PzV1lj3X2AO/VC0krgnkML7WTHi2fJiTPDUYjOGaNz9kYQJ/LF1axRQapi8UOyscIq8DNgvO8c85Aq8E1/RYBSny641tB3RrkJCs+9RmbNCmQtbveRICgFPVNOctoMu4wFWvwSGARicKoeMrnzQPHho/Nbj5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1bIcVXN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1bIcVXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743580568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cD4MFjDtRCW0qD573Lgja3Ag6OzkUK9cUOpFGWRN2vY=;
	b=I1bIcVXNVGZ14BV+eD25xK5ZO/zR+YOKzR3sZ6n72SbsTk6F94rfHNH+uE20X5xnzl1CY0
	iJDaZqVF+nQik/mUoc6XxCw+KWIUFj5kPnXfiU0/ypOp0wi8htB/VCJwF+k+PptikoCCSy
	5hnkdXDMdIvvCEGR2srqe9RaZGZPa2g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-P2iQS-ofMpiCrfJmsleAaw-1; Wed,
 02 Apr 2025 03:56:04 -0400
X-MC-Unique: P2iQS-ofMpiCrfJmsleAaw-1
X-Mimecast-MFC-AGG-ID: P2iQS-ofMpiCrfJmsleAaw_1743580563
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF9C91800A36;
	Wed,  2 Apr 2025 07:56:02 +0000 (UTC)
Received: from fedora (unknown [10.72.120.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6858D195609D;
	Wed,  2 Apr 2025 07:55:57 +0000 (UTC)
Date: Wed, 2 Apr 2025 15:55:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] block: add blk_mq_enter_no_io() and
 blk_mq_exit_no_io()
Message-ID: <Z-zthxEKJg_kZqgg@fedora>
References: <20250402043851.946498-1-ming.lei@redhat.com>
 <20250402043851.946498-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402043851.946498-2-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Apr 02, 2025 at 12:38:47PM +0800, Ming Lei wrote:
> Add blk_mq_enter_no_io() and blk_mq_exit_no_io() for preventing queue
> from handling any FS or passthrough IO, meantime the queue is kept in
> non-freeze state.
> 
> The added two APIs are for avoiding many potential lock risk related
> with freeze lock.
> 
> Also add two variants of memsave version.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c       |  6 ++++--
>  block/blk-mq.c         | 18 ++++++++++++++++--
>  block/blk-mq.h         | 19 +++++++++++++++++++
>  block/blk.h            |  5 +++--
>  include/linux/blkdev.h |  8 ++++++++
>  5 files changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 4623de79effa..a54a18fada8a 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -319,7 +319,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>  		smp_rmb();
>  		wait_event(q->mq_freeze_wq,
>  			   (!q->mq_freeze_depth &&
> -			    blk_pm_resume_queue(pm, q)) ||
> +			    (blk_pm_resume_queue(pm, q) ||
> +			     !blk_queue_no_io(q))) ||
>  			   blk_queue_dying(q));
>  		if (blk_queue_dying(q))
>  			return -ENODEV;
> @@ -352,7 +353,8 @@ int __bio_queue_enter(struct request_queue *q, struct bio *bio)
>  		smp_rmb();
>  		wait_event(q->mq_freeze_wq,
>  			   (!q->mq_freeze_depth &&
> -			    blk_pm_resume_queue(false, q)) ||
> +			    (blk_pm_resume_queue(false, q) ||

Here the above '||' should have been '&&'.

> +			     !blk_queue_no_io(q))) ||
>  			   test_bit(GD_DEAD, &disk->state));
>  		if (test_bit(GD_DEAD, &disk->state))
>  			goto dead;
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ae8494d88897..075ee51066b3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -222,8 +222,7 @@ bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
>  	bool unfreeze;
>  
>  	mutex_lock(&q->mq_freeze_lock);
> -	if (force_atomic)
> -		q->q_usage_counter.data->force_atomic = true;
> +	q->q_usage_counter.data->force_atomic = force_atomic;
>  	q->mq_freeze_depth--;
>  	WARN_ON_ONCE(q->mq_freeze_depth < 0);
>  	if (!q->mq_freeze_depth) {
> @@ -278,6 +277,21 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>  
> +void blk_mq_enter_no_io(struct request_queue *q)
> +{
> +	blk_mq_freeze_queue_nomemsave(q);
> +	q->no_io = true;
> +	if (__blk_mq_unfreeze_queue(q, true))
> +		blk_unfreeze_release_lock(q);
> +}
> +
> +void blk_mq_exit_no_io(struct request_queue *q)
> +{
> +	blk_mq_freeze_queue_nomemsave(q);
> +	q->no_io = false;
> +	blk_mq_unfreeze_queue_nomemrestore(q);
> +}
> +
>  /**
>   * blk_mq_wait_quiesce_done() - wait until in-progress quiesce is done
>   * @set: tag_set to wait on
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 3011a78cf16a..f49070c8c05f 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -452,4 +452,23 @@ static inline bool blk_mq_can_poll(struct request_queue *q)
>  		q->tag_set->map[HCTX_TYPE_POLL].nr_queues;
>  }
>  
> +void blk_mq_enter_no_io(struct request_queue *q);
> +void blk_mq_exit_no_io(struct request_queue *q);
> +
> +static inline unsigned int __must_check
> +blk_mq_enter_no_io_memsave(struct request_queue *q)
> +{
> +	unsigned int memflags = memalloc_noio_save();
> +
> +	blk_mq_enter_no_io(q);
> +	return memflags;
> +}
> +
> +static inline void
> +blk_mq_exit_no_io_memrestore(struct request_queue *q, unsigned int memflags)
> +{
> +	blk_mq_exit_no_io(q);
> +	memalloc_noio_restore(memflags);
> +}
> +
>  #endif
> diff --git a/block/blk.h b/block/blk.h
> index 006e3be433d2..7d0994c1d3ad 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -56,8 +56,9 @@ static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
>  	 * The code that increments the pm_only counter must ensure that the
>  	 * counter is globally visible before the queue is unfrozen.
>  	 */
> -	if (blk_queue_pm_only(q) &&
> -	    (!pm || queue_rpm_status(q) == RPM_SUSPENDED))
> +	if ((blk_queue_pm_only(q) &&
> +	    (!pm || queue_rpm_status(q) == RPM_SUSPENDED)) ||

Same with above.


Thanks, 
Ming

