Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404571591E3
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918579; cv=none; b=Ez/y8IF6MQ0YgW309rvXisM28lPjT9RbpwO1wBs3PvnBZlCXhcQfxx7AOrgq/GP2ISt+vNSeys/2DGrHecexduDkVICoxBnVFJ+3yXWV3Q4PrBgXnU4BP1NDiQITBBypWUfCF9Fq3GX+b60oukwVM4YaIyCcQFjHMymuGvIZqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918579; c=relaxed/simple;
	bh=DbUNLek8zj18Y975k7dzgxrRivbLDM61IDMY3zhb8Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ap1uNsq3nSpEoqTzjShjrxdo0F4G4aH4q2zBccV2JjscQVpiTKVASq8hgSOqZ4hs/1GJMrvbCiLPdSR6DEK/gS0dL/nsD+g5OCD2HjQF3c+o3FWBSox0U1ftthURscWtYRcyfBa/mCe7zt+mLuzGJvLtYjKr1tSYJhslmSn+Q20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXfQb9SK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXfQb9SK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719918576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ujUbLs2RVkArm6dyFIELfSCgR0Pb1M78bLtNyoJl5TY=;
	b=dXfQb9SKqlI5ZJi2MUQDJZ3wBcy19Sgpt8Su1ouS1pclny7Eok0rESnUpuLczu+m4UYDuI
	kExofm6uxQJ3Rl+g9DdU3lU0M6ehQQ7BtTVifHOhfTjlT9HjW/ExlQxn4TzP2fPYfk2Jlz
	LGD34fBMd7p26mfNDBVnYEiaIFG0SeM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-yFh0GLlVOt-PIoSFwHJKUQ-1; Tue,
 02 Jul 2024 07:09:34 -0400
X-MC-Unique: yFh0GLlVOt-PIoSFwHJKUQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A46791977317;
	Tue,  2 Jul 2024 11:09:33 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C486019560A3;
	Tue,  2 Jul 2024 11:09:29 +0000 (UTC)
Date: Tue, 2 Jul 2024 19:09:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH 2/4] ublk: refactor recovery configuration flag helpers
Message-ID: <ZoPf5L4oihlZJ1rW@fedora>
References: <20240617194451.435445-1-ushankar@purestorage.com>
 <20240617194451.435445-3-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617194451.435445-3-ushankar@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Jun 17, 2024 at 01:44:49PM -0600, Uday Shankar wrote:
> ublk currently supports the following behaviors on ublk server exit:
> 
> A: outstanding I/Os get errors, subsequently issued I/Os get errors
> B: outstanding I/Os get errors, subsequently issued I/Os queue
> C: outstanding I/Os get reissued, subsequently issued I/Os queue
> 
> and the following behaviors for recovery of preexisting block devices by
> a future incarnation of the ublk server:
> 
> 1: ublk devices stopped on ublk server exit (no recovery possible)
> 2: ublk devices are recoverable using start/end_recovery commands
> 
> The userspace interface allows selection of combinations of these
> behaviors using flags specified at device creation time, namely:
> 
> default behavior: A + 1
> UBLK_F_USER_RECOVERY: B + 2
> UBLK_F_USER_RECOVERY|UBLK_F_USER_RECOVERY_REISSUE: C + 2
> 
> We can't easily change the userspace interface to allow independent
> selection of one of {A, B, C} and one of {1, 2}, but we can refactor the
> internal helpers which test for the flags. Replace the existing helpers
> with the following set:
> 
> ublk_nosrv_should_reissue_outstanding: tests for behavior C
> ublk_nosrv_should_queue_io: tests for behavior B
> ublk_nosrv_should_stop_dev: tests for behavior 1
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 55 +++++++++++++++++++++++++---------------
>  1 file changed, 34 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2752a9afe9d4..e8cca58a71bc 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -652,22 +652,35 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
>  			PAGE_SIZE);
>  }
>  
> -static inline bool ublk_queue_can_use_recovery_reissue(
> -		struct ublk_queue *ubq)
> +/*
> + * Should I/O outstanding to the ublk server when it exits be reissued?
> + * If not, outstanding I/O will get errors.
> + */
> +static inline bool ublk_nosrv_should_reissue_outstanding(struct ublk_device *ub)
>  {
> -	return (ubq->flags & UBLK_F_USER_RECOVERY) &&
> -			(ubq->flags & UBLK_F_USER_RECOVERY_REISSUE);
> +	return (ub->dev_info.flags & UBLK_F_USER_RECOVERY) &&
> +	       (ub->dev_info.flags & UBLK_F_USER_RECOVERY_REISSUE);
>  }
>  
> -static inline bool ublk_queue_can_use_recovery(
> -		struct ublk_queue *ubq)
> +/*
> + * Should I/O issued while there is no ublk server queue? If not, I/O
> + * issued while there is no ublk server will get errors.
> + */
> +static inline bool ublk_nosrv_should_queue_io(struct ublk_device *ub)
>  {
> -	return ubq->flags & UBLK_F_USER_RECOVERY;
> +	return ub->dev_info.flags & UBLK_F_USER_RECOVERY;
>  }
>  
> -static inline bool ublk_can_use_recovery(struct ublk_device *ub)
> +/*
> + * Should ublk devices be stopped (i.e. no recovery possible) when the
> + * ublk server exits? If not, devices can be used again by a future
> + * incarnation of a ublk server via the start_recovery/end_recovery
> + * commands.
> + */
> +static inline bool ublk_nosrv_should_stop_dev(struct ublk_device *ub)
>  {
> -	return ub->dev_info.flags & UBLK_F_USER_RECOVERY;
> +	return (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY)) &&
> +	       (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY_REISSUE));
>  }
>  
>  static void ublk_free_disk(struct gendisk *disk)
> @@ -1043,7 +1056,7 @@ static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
>  {
>  	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
>  
> -	if (ublk_queue_can_use_recovery_reissue(ubq))
> +	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
>  		blk_mq_requeue_request(req, false);
>  	else
>  		ublk_put_req_ref(ubq, req);
> @@ -1071,7 +1084,7 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
>  		struct request *rq)
>  {
>  	/* We cannot process this rq so just requeue it. */
> -	if (ublk_queue_can_use_recovery(ubq))
> +	if (ublk_nosrv_should_queue_io(ubq->dev))

I feel the name of ublk_nosrv_should_queue_io() is a bit misleading.

The difference between ublk_queue_can_use_recovery() and
ublk_queue_can_use_recovery_reissue() is clear, and
both two need to queue ios actually in case of nosrv most times
except for this one.

However, looks your patch just tries to replace
ublk_queue_can_use_recovery() with ublk_nosrv_should_queue_io().

>  		blk_mq_requeue_request(rq, false);
>  	else
>  		blk_mq_end_request(rq, BLK_STS_IOERR);
> @@ -1216,10 +1229,10 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  		struct ublk_device *ub = ubq->dev;
>  
>  		if (ublk_abort_requests(ub, ubq)) {
> -			if (ublk_can_use_recovery(ub))
> -				schedule_work(&ub->quiesce_work);
> -			else
> +			if (ublk_nosrv_should_stop_dev(ub))

The helper looks easy to follow, include the following conversions.

>  				schedule_work(&ub->stop_work);
> +			else
> +				schedule_work(&ub->quiesce_work);
>  		}
>  		return BLK_EH_DONE;
>  	}
> @@ -1248,7 +1261,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	 * Note: force_abort is guaranteed to be seen because it is set
>  	 * before request queue is unqiuesced.
>  	 */
> -	if (ublk_queue_can_use_recovery(ubq) && unlikely(ubq->force_abort))
> +	if (ublk_nosrv_should_queue_io(ubq->dev) && unlikely(ubq->force_abort))
>  		return BLK_STS_IOERR;

I'd rather to not fetch ublk_device in fast io path since ublk is MQ
device, and only the queue structure should be touched in fast io path,
but it is fine to check device in any slow path.


Thanks, 
Ming

