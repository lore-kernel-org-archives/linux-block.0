Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC470805
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 03:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751341704; cv=none; b=Gq9hXdQ1YfIJJCX5U+ZNLsQeRr/5g+vegayjh8Jqq9uKHUjtFcI9lmVk2ZwlvvNRETsgutCRDtn3yweaW64KGzMw7fIGy4PxRiOBlXtnUuz1WhqTPq7Lu/TUEzUPZUiRVdDf1NmCqE5Ax9mZIe+rpUdqquUmxZvzS9R49OFLVBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751341704; c=relaxed/simple;
	bh=7oc0ul6OkDOpQV0Bs8bUVaWQqTS4yp6EzXhwc10Y6cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWM2Xbmi9C1JhzY0ToalQKjyijggt5L/SbRt1QkRLouPzmH8UVzEeoWyqa0wZp1ycOvu3iSFelpkFJ5fv5FncwNr3VcegzV40r4nXFPn1M31dqRLEZPuhduv4xktVJF0U0LadQ7p1Yw7OjAgsuRbINHgZ3XtMMvZ5QzRTfX3p5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LyGXdalw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyGXdalw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751341700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PMnjM6IVFPiEaVZ2k5ueKyaDHn04XUZYGSThMgESO4Y=;
	b=LyGXdalwFVPFpbH5puM/C99IpvQJyre7uzbNUEwuN3W9ZcoUTRXhq61qsI1pZy3BNLqcPa
	73vOBGNZlga7sAhX5jRsLD9LV/kQVzqn4Yi27WygPVecwAN1c3FvuZkV8JCxCiKc0ETXar
	LQvwzvIbP5dJkDJgBF6nygiWhtjde50=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-d_xHjPJ8PZ-sfBBRO2D6aA-1; Mon,
 30 Jun 2025 23:48:17 -0400
X-MC-Unique: d_xHjPJ8PZ-sfBBRO2D6aA-1
X-Mimecast-MFC-AGG-ID: d_xHjPJ8PZ-sfBBRO2D6aA_1751341696
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46EB2180028D;
	Tue,  1 Jul 2025 03:48:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.88])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64612180045B;
	Tue,  1 Jul 2025 03:48:11 +0000 (UTC)
Date: Tue, 1 Jul 2025 11:48:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: speed up ublk server exit handling
Message-ID: <aGNady-IPjtpuaT5@fedora>
References: <20250627-ublk_too_many_quiesce-v1-1-55ef9d80a6af@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-ublk_too_many_quiesce-v1-1-55ef9d80a6af@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Jun 27, 2025 at 12:59:47AM -0600, Uday Shankar wrote:
> Recently, we've observed a few cases where a ublk server is able to
> complete restart more quickly than the driver can process the exit of
> the previous ublk server. The new ublk server comes up, attempts
> recovery of the preexisting ublk devices, and observes them still in
> state UBLK_S_DEV_LIVE. While this is possible due to the asynchronous
> nature of io_uring cleanup and should therefore be handled properly in
> the ublk server, it is still preferable to make ublk server exit
> handling faster if possible, as we should strive for it to not be a
> limiting factor in how fast a ublk server can restart and provide
> service again.
> 
> Analysis of the issue showed that the vast majority of the time spent in
> handling the ublk server exit was in calls to blk_mq_quiesce_queue,
> which is essentially just a (relatively expensive) call to
> synchronize_rcu.

Yeah, it is true.

> The ublk server exit path currently issues an
> unnecessarily large number of calls to blk_mq_quiesce_queue, for two
> reasons:
> 
> 1. It tries to call blk_mq_quiesce_queue once per ublk_queue. However,
>    blk_mq_quiesce_queue targets the request_queue of the underlying ublk
>    device, of which there is only one. So the number of calls is larger
>    than necessary by a factor of nr_hw_queues.
> 2. In practice, it calls blk_mq_quiesce_queue _more_ than once per
>    ublk_queue. This is because of a data race where we read
>    ubq->canceling without any locking when deciding if we should call
>    ublk_start_cancel. It is thus possible for two calls to
>    ublk_uring_cmd_cancel_fn against the same ublk_queue to both call
>    ublk_start_cancel against the same ublk_queue.
> 
> Fix this by making the "canceling" flag a per-device state. This
> actually matches the existing code better, as there are several places
> where the flag is set or cleared for all queues simultaneously, and
> there is the general expectation that cancellation corresponds with ublk
> server exit. This also has negligible performance impact since the flag
> is readonly and always false in the hot path. This per-device canceling
> flag is then checked under a (new) lock (addressing the data race (2)
> above), and the queue is only quiesced if it is cleared (addressing (1)
> above). The result is just one call to blk_mq_quiesce_queue per ublk
> device.
> 
> In our setup, where one ublk server handles I/O for 128 ublk devices,
> each having 24 hardware queues of depth 4096, here are the results
> before and after this patch, where teardown time is measured from the
> first call to io_ring_ctx_wait_and_kill to the return from the last
> ublk_ch_release:
> 
> 						before		after
> number of calls to blk_mq_quiesce_queue:	6469		256
> teardown time:					11.14s		2.44s
> 
> There are still some potential optimizations here, but this takes care
> of a big chunk of the ublk server exit handling delay.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 54 +++++++++++++++++++++---------------------------
>  1 file changed, 23 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 740141c63a93797c45ee8514ef779ab3ff06939f..f6635553d9a3fb309f4c1fb64503736c292f2f3e 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -198,7 +198,6 @@ struct ublk_queue {
>  	struct ublksrv_io_desc *io_cmd_buf;
>  
>  	bool force_abort;
> -	bool canceling;
>  	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
>  	unsigned short nr_io_ready;	/* how many ios setup */
>  	spinlock_t		cancel_lock;
> @@ -235,6 +234,8 @@ struct ublk_device {
>  	struct completion	completion;
>  	unsigned int		nr_queues_ready;
>  	unsigned int		nr_privileged_daemon;
> +	struct mutex cancel_mutex;
> +	bool canceling;
>  };
>  
>  /* header of ublk_params */
> @@ -1388,7 +1389,7 @@ static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq,
>  	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
>  		return BLK_STS_IOERR;
>  
> -	if (check_cancel && unlikely(ubq->canceling))
> +	if (check_cancel && unlikely(ubq->dev->canceling))
>  		return BLK_STS_IOERR;
>  
>  	/* fill iod to slot in io cmd buffer */
> @@ -1416,7 +1417,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	 * is dealt with, otherwise this request may not be failed in case
>  	 * of recovery, and cause hang when deleting disk
>  	 */
> -	if (unlikely(ubq->canceling)) {
> +	if (unlikely(ubq->dev->canceling)) {
>  		__ublk_abort_rq(ubq, rq);
>  		return BLK_STS_OK;

I'd suggest to keep the per-queue flags if possible for avoiding to fetch one
extra cache line in fast ublk client io code path.

>  	}
> @@ -1573,12 +1574,9 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
>  	 * All requests may be inflight, so ->canceling may not be set, set
>  	 * it now.
>  	 */
> -	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> -		struct ublk_queue *ubq = ublk_get_queue(ub, i);
> -
> -		ubq->canceling = true;
> -		ublk_abort_queue(ub, ubq);
> -	}
> +	ub->canceling = true;
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> +		ublk_abort_queue(ub, ublk_get_queue(ub, i));
>  	blk_mq_kick_requeue_list(disk->queue);
>  
>  	/*
> @@ -1701,23 +1699,17 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
>  	}
>  }
>  
> -/* Must be called when queue is frozen */
> -static void ublk_mark_queue_canceling(struct ublk_queue *ubq)
> -{
> -	spin_lock(&ubq->cancel_lock);
> -	if (!ubq->canceling)
> -		ubq->canceling = true;
> -	spin_unlock(&ubq->cancel_lock);
> -}
> -
> -static void ublk_start_cancel(struct ublk_queue *ubq)
> +static void ublk_start_cancel(struct ublk_device *ub)
>  {
> -	struct ublk_device *ub = ubq->dev;
>  	struct gendisk *disk = ublk_get_disk(ub);
>  
>  	/* Our disk has been dead */
>  	if (!disk)
>  		return;
> +
> +	mutex_lock(&ub->cancel_mutex);
> +	if (ub->canceling)
> +		goto out;
>  	/*
>  	 * Now we are serialized with ublk_queue_rq()
>  	 *
> @@ -1726,8 +1718,10 @@ static void ublk_start_cancel(struct ublk_queue *ubq)
>  	 * touch completed uring_cmd
>  	 */
>  	blk_mq_quiesce_queue(disk->queue);
> -	ublk_mark_queue_canceling(ubq);
> +	ub->canceling = true;

Here each ubq's ->canceling can be set for getting similar result.

The main improvement should be from the above command cancel code path
change, right?


Thanks, 
Ming

