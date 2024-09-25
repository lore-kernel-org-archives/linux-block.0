Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CED14B94C
	for <linux-block@vger.kernel.org>; Wed, 25 Sep 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261924; cv=none; b=kauFJwHAWeInBq2Lcp/fstVfZLdJhTbWufnzVOEv/ijSzSXIj+bWAc4L4yse//OBtzgyfOSSWRhxsRahxJ254OnVhFOuCp0hM5GuvyIqSUe9scy6Jblk8FJmSbF3tQxPCrpztmQF7L7mno6EA0dy6HO6gNAPqlh/RamsbhjTK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261924; c=relaxed/simple;
	bh=AD8qQ8oIFpYMx0NSvqjkJPaO8l5/qZ+Mi6h9FVizZTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6Ll2lxe+SluVKO4fnqyhb2TWp7aeRkXVkAjBU6g5BqPMtQ+dLF7T5LMl4GsRYTDQkv3Vzuc/earOmUYqD3YNb2oDqSUO6N1bxw2d6RhxkEuEVsRePh6RGogqkD83R99ka8eh1ipV9DVFYG5OGJij6uAu4SbWyOUN/hYBqaEHbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iIPKbqeA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIPKbqeA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727261921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tjvsI20CEZyn0oB2O4z5PLB1LKRwGi7K5BsBMFdQkNM=;
	b=iIPKbqeAHjhO69aqNe3QjZ446x9H5owxato73D1ogHuCSgunQyMZlWjMwXIlzmNO9BovCL
	0HCckYdT+kbIm4t1Z97dGtxnnonSggy7oKk2TmrUfSnWDF36yRjAsCyEBxKEh8oxi3ejn3
	f2+A3N5rc2C57BqUZMPSjytiKHM/iUo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-C2G0NCrYP56UyVLrHWQJ_w-1; Wed,
 25 Sep 2024 06:58:39 -0400
X-MC-Unique: C2G0NCrYP56UyVLrHWQJ_w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBE1719367BE;
	Wed, 25 Sep 2024 10:58:38 +0000 (UTC)
Received: from fedora (unknown [10.72.116.14])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB12A1956054;
	Wed, 25 Sep 2024 10:58:35 +0000 (UTC)
Date: Wed, 25 Sep 2024 18:58:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ublk: support device recovery without I/O queueing
Message-ID: <ZvPs1h1byAkpYMGC@fedora>
References: <20240917002155.2044225-1-ushankar@purestorage.com>
 <20240917002155.2044225-5-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917002155.2044225-5-ushankar@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Sep 16, 2024 at 06:21:55PM -0600, Uday Shankar wrote:
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
> Changes since v1 (https://lore.kernel.org/linux-block/20240617194451.435445-5-ushankar@purestorage.com/):
> - Change flag name from UBLK_F_USER_RECOVERY_NOQUEUE to
>   UBLK_F_USER_RECOVERY_FAIL_IO
> - Require UBLK_F_USER_RECOVERY to be set along with the new flag for it
>   to be effective. This makes more sense, as UBLK_F_USER_RECOVERY
>   essentially selects behavior 2 above (and not setting
>   UBLK_F_USER_RECOVERY selects behavior 1).
> - Add per-ublk-queue flag which is true iff device state is
>   UBLK_S_DEV_FAIL_IO. This lets us avoid fetching the device in the fast
>   path.
> 
>  drivers/block/ublk_drv.c      | 75 ++++++++++++++++++++++++++++-------
>  include/uapi/linux/ublk_cmd.h | 18 +++++++++
>  2 files changed, 79 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c7a0493b3545..548043eeefb9 100644
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
> @@ -712,7 +717,14 @@ static inline bool ublk_nosrv_should_queue_io(struct ublk_queue *ubq)
>  static inline bool ublk_nosrv_should_stop_dev(struct ublk_device *ub)
>  {
>  	return (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY)) &&
> -	       (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY_REISSUE));
> +	       (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY_REISSUE)) &&
> +	       (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY_FAIL_IO));
> +}
> +
> +static inline bool ublk_dev_in_recoverable_state(struct ublk_device *ub)
> +{
> +	return ub->dev_info.state == UBLK_S_DEV_QUIESCED ||
> +	       ub->dev_info.state == UBLK_S_DEV_FAIL_IO;
>  }
>  
>  static void ublk_free_disk(struct gendisk *disk)
> @@ -1276,6 +1288,10 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
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
> @@ -1626,6 +1642,7 @@ static void ublk_nosrv_work(struct work_struct *work)
>  {
>  	struct ublk_device *ub =
>  		container_of(work, struct ublk_device, nosrv_work);
> +	int i;
>  
>  	if (ublk_nosrv_should_stop_dev(ub)) {
>  		ublk_stop_dev(ub);
> @@ -1635,7 +1652,18 @@ static void ublk_nosrv_work(struct work_struct *work)
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
> +	}
> +
>   unlock:
>  	mutex_unlock(&ub->mutex);
>  	ublk_cancel_dev(ub);
> @@ -2389,8 +2417,13 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>  		return -EPERM;
>  
>  	/* forbid nonsense combinations of recovery flags */
> -	if ((info.flags & UBLK_F_USER_RECOVERY_REISSUE) &&
> -	    !(info.flags & UBLK_F_USER_RECOVERY)) {
> +	switch (info.flags & UBLK_F_ALL_RECOVERY_FLAGS) {
> +	case 0:
> +	case UBLK_F_USER_RECOVERY:
> +	case (UBLK_F_USER_RECOVERY | UBLK_F_USER_RECOVERY_REISSUE):
> +	case (UBLK_F_USER_RECOVERY | UBLK_F_USER_RECOVERY_FAIL_IO):
> +		break;
> +	default:
>  		pr_warn("%s: invalid recovery flags %llx\n", __func__,
>  			info.flags & UBLK_F_ALL_RECOVERY_FLAGS);
>  		return -EINVAL;
> @@ -2722,14 +2755,18 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
>  	 *     and related io_uring ctx is freed so file struct of /dev/ublkcX is
>  	 *     released.
>  	 *
> +	 * and one of the following holds
> +	 *
>  	 * (2) UBLK_S_DEV_QUIESCED is set, which means the quiesce_work:
>  	 *     (a)has quiesced request queue
>  	 *     (b)has requeued every inflight rqs whose io_flags is ACTIVE
>  	 *     (c)has requeued/aborted every inflight rqs whose io_flags is NOT ACTIVE
>  	 *     (d)has completed/camceled all ioucmds owned by ther dying process
> +	 *
> +	 * (3) UBLK_S_DEV_FAIL_IO is set, which means the queue is not
> +	 *     quiesced, but all I/O is being immediately errored
>  	 */
> -	if (test_bit(UB_STATE_OPEN, &ub->state) ||
> -			ub->dev_info.state != UBLK_S_DEV_QUIESCED) {
> +	if (test_bit(UB_STATE_OPEN, &ub->state) || !ublk_dev_in_recoverable_state(ub)) {
>  		ret = -EBUSY;
>  		goto out_unlock;
>  	}
> @@ -2753,6 +2790,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
>  	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
>  	int ublksrv_pid = (int)header->data[0];
>  	int ret = -EINVAL;
> +	int i;
>  
>  	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
>  			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
> @@ -2767,18 +2805,27 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
>  	if (ublk_nosrv_should_stop_dev(ub))
>  		goto out_unlock;
>  
> -	if (ub->dev_info.state != UBLK_S_DEV_QUIESCED) {
> +	if (!ublk_dev_in_recoverable_state(ub)) {
>  		ret = -EBUSY;
>  		goto out_unlock;
>  	}
>  	ub->dev_info.ublksrv_pid = ublksrv_pid;
>  	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
>  			__func__, ublksrv_pid, header->dev_id);
> +
> +	blk_mq_quiesce_queue(ub->ub_disk->queue);
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> +		ublk_get_queue(ub, i)->fail_io = false;
> +	}
>  	blk_mq_unquiesce_queue(ub->ub_disk->queue);
> -	pr_devel("%s: queue unquiesced, dev id %d.\n",
> -			__func__, header->dev_id);
> -	blk_mq_kick_requeue_list(ub->ub_disk->queue);
>  	ub->dev_info.state = UBLK_S_DEV_LIVE;
> +	if (ublk_nosrv_dev_should_queue_io(ub)) {
> +		blk_mq_unquiesce_queue(ub->ub_disk->queue);
> +		pr_devel("%s: queue unquiesced, dev id %d.\n",
> +				__func__, header->dev_id);
> +		blk_mq_kick_requeue_list(ub->ub_disk->queue);
> +	}

I'd suggest to change the above into the following:

	if (ublk_nosrv_dev_should_queue_io(ub)) {
	  	ub->dev_info.state = UBLK_S_DEV_LIVE;
		blk_mq_unquiesce_queue(ub->ub_disk->queue);
		pr_devel("%s: queue unquiesced, dev id %d.\n",
				__func__, header->dev_id);
		blk_mq_kick_requeue_list(ub->ub_disk->queue);
	} else {
		blk_mq_quiesce_queue(ub->ub_disk->queue);
	  	ub->dev_info.state = UBLK_S_DEV_LIVE;
		for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
			ublk_get_queue(ub, i)->fail_io = false;
		blk_mq_unquiesce_queue(ub->ub_disk->queue);
	}

- one more quiesce is avoided
- ub->dev_info.state is only updated if request queue is quiesced.

Otherwise, this patch looks fine.


Thanks, 
Ming

