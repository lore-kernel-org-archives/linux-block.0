Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A011820E6
	for <linux-block@vger.kernel.org>; Wed, 25 Sep 2024 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727236476; cv=none; b=bpYUA3E07uAQh6D1qDYdaot+cFWYn8jqnsbqg9xDKQfaOnREdo9ZVRvP8W5hKkH0wHt0P6nOfq0Ihi3HZnKgtP8HkZYvyJBtGDHN8M99BwavEFcDk8i0ZVU4QTRLT8bAABgoxO040FwOc7gpsbuq8/mUQdIUhVJZBBLKTHTE73k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727236476; c=relaxed/simple;
	bh=mbujZ2hcXEVmonhX9ZRS8RxDw8N56c+x+pWLk14+nsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFsAYDD05tBG+VaoprBfSPVWyCdrws4pDht3SeBJV+sOWEFWBtWxOtWl6v/HiatZfCnpJw91kr0LnKsnwYuU1PiwsnkMROITZ9cM05L4BXJVU3yZeEoFxa+zf0X/39/1uAqSBXtBhgR2OxzNNXLgrbs5IcJ2pEbnScFNjclUCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBx2pwmr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBx2pwmr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727236472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCjtFvx5de+1ytQXKE7eZOrmci+ExWqmPxQRdeRnMeA=;
	b=VBx2pwmr7Z1DySmVaBz2KpTdigGod3HKM1I3MM0HnP3mthi/9Y6snwQ84WYKXEYENLCjTc
	g1X7akmpaU2OsB2traSOJlIX8lwTgmIh/WHdUdihyWir9bEBPCqWYvazZCs0EQB/qY5HlK
	wc2FQOCD3KxnxMg0TkYdeOx7W+0v3Cc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-6EToYZtqNNiGsY7q6vndNQ-1; Tue,
 24 Sep 2024 23:54:29 -0400
X-MC-Unique: 6EToYZtqNNiGsY7q6vndNQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D9D0195608C;
	Wed, 25 Sep 2024 03:54:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.51])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BB5A19560AA;
	Wed, 25 Sep 2024 03:54:25 +0000 (UTC)
Date: Wed, 25 Sep 2024 11:54:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ublk: refactor recovery configuration flag helpers
Message-ID: <ZvOJbJ0gxzJ9iNph@fedora>
References: <20240917002155.2044225-1-ushankar@purestorage.com>
 <20240917002155.2044225-3-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917002155.2044225-3-ushankar@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Sep 16, 2024 at 06:21:53PM -0600, Uday Shankar wrote:
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
> ublk_nosrv_[dev_]should_queue_io: tests for behavior B
> ublk_nosrv_should_stop_dev: tests for behavior 1
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
> Changes since v1 (https://lore.kernel.org/linux-block/20240617194451.435445-3-ushankar@purestorage.com/):
> - Make the fast-path test in ublk_queue_rq access the queue-local copy
>   of the device flags.
> 
>  drivers/block/ublk_drv.c | 63 +++++++++++++++++++++++++++-------------
>  1 file changed, 43 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 5e04a0fcd0b7..b069f4d2b9d2 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -675,22 +675,45 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
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
> +static inline bool ublk_nosrv_dev_should_queue_io(struct ublk_device *ub)
> +{
> +	return ub->dev_info.flags & UBLK_F_USER_RECOVERY;
> +}
> +
> +/*
> + * Same as ublk_nosrv_dev_should_queue_io, but uses a queue-local copy
> + * of the device flags for smaller cache footprint - better for fast
> + * paths.
> + */
> +static inline bool ublk_nosrv_should_queue_io(struct ublk_queue *ubq)
>  {
>  	return ubq->flags & UBLK_F_USER_RECOVERY;
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

It should be enough to check UBLK_F_USER_RECOVERY only since
UBLK_F_USER_RECOVERY_REISSUE implies UBLK_F_USER_RECOVERY.

Otherwise, this patch looks fine.


Thanks, 
Ming

