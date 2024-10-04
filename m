Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97281AA7B5
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056105; cv=none; b=kyHGUP+rjxr6tEl6HLqHbuf+O4gRs/wUR0eVf65ts+VPRZooihnTEiJrbplQXjKvs99AbQJfqi53CH8H4lMoEihSyPs0Oa34WmrTlodRsukDKAOQ9ZQRYhdXCIY5oX3sXqTY+9exdcjlLAdVwzZtNtoaVQMlAVrOICwF6Ig3QiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056105; c=relaxed/simple;
	bh=4R+bjkkANUZFElUR3AnO4g7qOY03zDWdvgsvEAgGO8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juJO5sk9x+MqaVB7czsREClH1kYzN7C4zV9S7Dz3IgNKXq2IH6N6KJa55naspNSuytLoVuQxITMCTqzslsQO5UF9lVg+RS7QiTB4q/tJ+xWQ3TOYt99JGi1as95kzXJ2xPbGwkpiDxMIBVpTiSnFCj2Tw4rPYmcy/JPshud+KOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KxMxkNej; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxMxkNej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728056102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tr59JQ1sfNf3b9KrmfGkricjfTXwGWXI04nwRJyi3R8=;
	b=KxMxkNejy2EGfYGVA+XjKmGorme8fNgNrZ3FK3Vzw6Dn+QD/Q3+R+CJw0A85+msO3Zo/wp
	HNRlgzQaqUvDRTSoq39MuodqGHi6VFLtgFfFyznuksWcn2EHBungF4vKVliJbSQMl4orou
	z5vE9Z8epz+B3pYl9Gd8Jfhh2Suvs28=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-ciDQ5J12PYKA4ho9q_L3_A-1; Fri,
 04 Oct 2024 11:34:58 -0400
X-MC-Unique: ciDQ5J12PYKA4ho9q_L3_A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E8F519560BF;
	Fri,  4 Oct 2024 15:34:57 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3141A19560A3;
	Fri,  4 Oct 2024 15:34:52 +0000 (UTC)
Date: Fri, 4 Oct 2024 23:34:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 4/5] ublk: support device recovery without I/O queueing
Message-ID: <ZwALFzPLAW1AbW-J@fedora>
References: <20241002220949.3087902-1-ushankar@purestorage.com>
 <20241002220949.3087902-5-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002220949.3087902-5-ushankar@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Oct 02, 2024 at 04:09:48PM -0600, Uday Shankar wrote:
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
> The behavior A + 2 is currently unsupported. Add support for this
> behavior under the new flag combination
> UBLK_F_USER_RECOVERY|UBLK_F_USER_RECOVERY_FAIL_IO.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
> Changes since v2 (https://lore.kernel.org/linux-block/20240917002155.2044225-5-ushankar@purestorage.com/):
> - Clean up logic in ublk_ctrl_end_recovery
> 
>  drivers/block/ublk_drv.c      | 78 ++++++++++++++++++++++++++++-------
>  include/uapi/linux/ublk_cmd.h | 18 ++++++++
>  2 files changed, 81 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index d5edef7bde43..f2a05dcbc58b 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -60,10 +60,12 @@
>  		| UBLK_F_UNPRIVILEGED_DEV \
>  		| UBLK_F_CMD_IOCTL_ENCODE \
>  		| UBLK_F_USER_COPY \
> -		| UBLK_F_ZONED)
> +		| UBLK_F_ZONED \
> +		| UBLK_F_USER_RECOVERY_FAIL_IO)
>  
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> -		| UBLK_F_USER_RECOVERY_REISSUE)
> +		| UBLK_F_USER_RECOVERY_REISSUE \
> +		| UBLK_F_USER_RECOVERY_FAIL_IO)
>  
>  /* All UBLK_PARAM_TYPE_* should be included here */
>  #define UBLK_PARAM_TYPE_ALL                                \
> @@ -146,6 +148,7 @@ struct ublk_queue {
>  	bool force_abort;
>  	bool timeout;
>  	bool canceling;
> +	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
>  	unsigned short nr_io_ready;	/* how many ios setup */
>  	spinlock_t		cancel_lock;
>  	struct ublk_device *dev;
> @@ -690,7 +693,8 @@ static inline bool ublk_nosrv_should_reissue_outstanding(struct ublk_device *ub)
>   */
>  static inline bool ublk_nosrv_dev_should_queue_io(struct ublk_device *ub)
>  {
> -	return ub->dev_info.flags & UBLK_F_USER_RECOVERY;
> +	return (ub->dev_info.flags & UBLK_F_USER_RECOVERY) &&
> +	       !(ub->dev_info.flags & UBLK_F_USER_RECOVERY_FAIL_IO);
>  }
>  
>  /*
> @@ -700,7 +704,8 @@ static inline bool ublk_nosrv_dev_should_queue_io(struct ublk_device *ub)
>   */
>  static inline bool ublk_nosrv_should_queue_io(struct ublk_queue *ubq)
>  {
> -	return ubq->flags & UBLK_F_USER_RECOVERY;
> +	return (ubq->flags & UBLK_F_USER_RECOVERY) &&
> +	       !(ubq->flags & UBLK_F_USER_RECOVERY_FAIL_IO);
>  }
>  
>  /*
> @@ -714,6 +719,12 @@ static inline bool ublk_nosrv_should_stop_dev(struct ublk_device *ub)
>  	return !(ub->dev_info.flags & UBLK_F_USER_RECOVERY);
>  }
>  
> +static inline bool ublk_dev_in_recoverable_state(struct ublk_device *ub)
> +{
> +	return ub->dev_info.state == UBLK_S_DEV_QUIESCED ||
> +	       ub->dev_info.state == UBLK_S_DEV_FAIL_IO;
> +}
> +
>  static void ublk_free_disk(struct gendisk *disk)
>  {
>  	struct ublk_device *ub = disk->private_data;
> @@ -1275,6 +1286,10 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	struct request *rq = bd->rq;
>  	blk_status_t res;
>  
> +	if (unlikely(ubq->fail_io)) {
> +		return BLK_STS_TARGET;
> +	}
> +
>  	/* fill iod to slot in io cmd buffer */
>  	res = ublk_setup_iod(ubq, rq);
>  	if (unlikely(res != BLK_STS_OK))
> @@ -1625,6 +1640,7 @@ static void ublk_nosrv_work(struct work_struct *work)
>  {
>  	struct ublk_device *ub =
>  		container_of(work, struct ublk_device, nosrv_work);
> +	int i;
>  
>  	if (ublk_nosrv_should_stop_dev(ub)) {
>  		ublk_stop_dev(ub);
> @@ -1634,7 +1650,18 @@ static void ublk_nosrv_work(struct work_struct *work)
>  	mutex_lock(&ub->mutex);
>  	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
>  		goto unlock;
> -	__ublk_quiesce_dev(ub);
> +
> +	if (ublk_nosrv_dev_should_queue_io(ub)) {
> +		__ublk_quiesce_dev(ub);
> +	} else {
> +		blk_mq_quiesce_queue(ub->ub_disk->queue);
> +		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> +			ublk_get_queue(ub, i)->fail_io = true;
> +		}
> +		blk_mq_unquiesce_queue(ub->ub_disk->queue);
> +		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;

The above state update should be moved before blk_mq_unquiesce_queue().

Otherwise, this patch is fine.

Thanks, 
Ming

