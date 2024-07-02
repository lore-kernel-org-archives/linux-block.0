Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2941B4C4A
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927975; cv=none; b=QEvycDXq8R6CPS702Bad4RJZ3W2uAHpypDI+lMjLXAUvUkIRV3rIb+c1yMJrCkwt/UygP30OJp72+yvm7Eq5hGLwOGJ6x6Gw7KbCAuu/0GMdUHYlAe3OSw7lUGkp2J09AmCKmvE3kl5trDyzS9+1RjDSV75bJwrcoXYhd+DWfjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927975; c=relaxed/simple;
	bh=XITe6mB+VqQ41dcXMqZzIlZJC1Y2c43y1dRr9y19axQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0JBB4JhN6CmnLAcB3rzqmthEAruN3c8++gvPtQJCQ0N8TVC4acj05uRA9ermIJbbHn4ZdZXLUv0f5rC0d1JgpA7cxYJANJZTtaoZDggiIVlfLxbjiZcNw8P6J7IZ1/pKs+IwjYZOLf2vIyATi+Imrj37eG5EKB5pwSW/Ckt3iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJzEZ2fv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJzEZ2fv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719927972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkpLrHSD+az7lxbhhUKmG6UcdBFGAXFNQNlF8Ii3haQ=;
	b=JJzEZ2fvsSop+bllJe1CdSmJUgrDbuZ/QKdIv69MbuVMvWp1LoLkUC61Gp+cy4vESrlCLM
	h7vbIUwJC4/fLL3CpC48z7p0qVI5CXtADzA6q/+4ndfxhaD+JYaRSlEdztLA05kRc/AfVG
	Qex4YDAJBbof2eAHUx+5gPuIUmI2F7M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-GOrPhrnpOnyvfb4HEnlKoQ-1; Tue,
 02 Jul 2024 09:46:10 -0400
X-MC-Unique: GOrPhrnpOnyvfb4HEnlKoQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8453E1956083;
	Tue,  2 Jul 2024 13:46:09 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E21A3000229;
	Tue,  2 Jul 2024 13:46:05 +0000 (UTC)
Date: Tue, 2 Jul 2024 21:46:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH 4/4] ublk: support device recovery without I/O queueing
Message-ID: <ZoQEmCuPIq0thaON@fedora>
References: <20240617194451.435445-1-ushankar@purestorage.com>
 <20240617194451.435445-5-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617194451.435445-5-ushankar@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jun 17, 2024 at 01:44:51PM -0600, Uday Shankar wrote:
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
> behavior under the new flag UBLK_F_USER_RECOVERY_NOQUEUE.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  drivers/block/ublk_drv.c      | 53 +++++++++++++++++++++++++++--------
>  include/uapi/linux/ublk_cmd.h | 18 ++++++++++++
>  2 files changed, 60 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 0496fa372cc1..4fec8b48d30e 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -57,10 +57,12 @@
>  		| UBLK_F_UNPRIVILEGED_DEV \
>  		| UBLK_F_CMD_IOCTL_ENCODE \
>  		| UBLK_F_USER_COPY \
> -		| UBLK_F_ZONED)
> +		| UBLK_F_ZONED \
> +		| UBLK_F_USER_RECOVERY_NOQUEUE)
>  
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> -		| UBLK_F_USER_RECOVERY_REISSUE)
> +		| UBLK_F_USER_RECOVERY_REISSUE \
> +		| UBLK_F_USER_RECOVERY_NOQUEUE)
>  
>  /* All UBLK_PARAM_TYPE_* should be included here */
>  #define UBLK_PARAM_TYPE_ALL                                \
> @@ -679,7 +681,14 @@ static inline bool ublk_nosrv_should_queue_io(struct ublk_device *ub)
>  static inline bool ublk_nosrv_should_stop_dev(struct ublk_device *ub)
>  {
>  	return (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY)) &&
> -	       (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY_REISSUE));
> +	       (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY_REISSUE)) &&
> +	       (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY_NOQUEUE));
> +}
> +
> +static inline bool ublk_dev_in_recoverable_state(struct ublk_device *ub)
> +{
> +	return ub->dev_info.state == UBLK_S_DEV_QUIESCED ||
> +	       ub->dev_info.state == UBLK_S_DEV_FAIL_IO;
>  }
>  
>  static void ublk_free_disk(struct gendisk *disk)
> @@ -1243,6 +1252,11 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	struct request *rq = bd->rq;
>  	blk_status_t res;
>  
> +	if (ubq->dev->dev_info.state == UBLK_S_DEV_FAIL_IO) {
> +		return BLK_STS_TARGET;
> +	}
> +	WARN_ON_ONCE(ubq->dev->dev_info.state != UBLK_S_DEV_LIVE);
> +

I'd suggest to add one per-ublk-queue flag for this purpose instead of
device state, then fetching device can be avoided in fast io path, please see
similar example of `->force_abort`.

>  	/* fill iod to slot in io cmd buffer */
>  	res = ublk_setup_iod(ubq, rq);
>  	if (unlikely(res != BLK_STS_OK))
> @@ -1602,7 +1616,15 @@ static void ublk_nosrv_work(struct work_struct *work)
>  	mutex_lock(&ub->mutex);
>  	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
>  		goto unlock;
> -	__ublk_quiesce_dev(ub);
> +
> +	if (ublk_nosrv_should_queue_io(ub)) {

Here ublk_nosrv_should_queue_io() doesn't cover UBLK_F_USER_RECOVERY_REISSUE.

> +		__ublk_quiesce_dev(ub);
> +	} else {
> +		blk_mq_quiesce_queue(ub->ub_disk->queue);
> +		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
> +		blk_mq_unquiesce_queue(ub->ub_disk->queue);
> +	}

If the above extra device state is saved, the whole change can be simplified,
and __ublk_quiesce_dev() still can be called for
UBLK_F_USER_RECOVERY_NOQUEUE, and UBLK_S_DEV_QUIESCED can cover this new flag,
meantime setting one per-ublk-queue flag, such as, ->fail_io_in_recovery.

> +
>   unlock:
>  	mutex_unlock(&ub->mutex);
>  	ublk_cancel_dev(ub);
> @@ -2351,6 +2373,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>  	case 0:
>  	case UBLK_F_USER_RECOVERY:
>  	case (UBLK_F_USER_RECOVERY | UBLK_F_USER_RECOVERY_REISSUE):
> +	case UBLK_F_USER_RECOVERY_NOQUEUE:
>  		break;
>  	default:
>  		pr_warn("%s: invalid recovery flags %llx\n", __func__,
> @@ -2682,14 +2705,18 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
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
> @@ -2727,18 +2754,22 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
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
> -	blk_mq_unquiesce_queue(ub->ub_disk->queue);
> -	pr_devel("%s: queue unquiesced, dev id %d.\n",
> -			__func__, header->dev_id);
> -	blk_mq_kick_requeue_list(ub->ub_disk->queue);
> +
>  	ub->dev_info.state = UBLK_S_DEV_LIVE;
> +	if (ublk_nosrv_should_queue_io(ub)) {
> +		blk_mq_unquiesce_queue(ub->ub_disk->queue);
> +		pr_devel("%s: queue unquiesced, dev id %d.\n",
> +				__func__, header->dev_id);
> +		blk_mq_kick_requeue_list(ub->ub_disk->queue);
> +	}
> +
>  	ret = 0;
>   out_unlock:
>  	mutex_unlock(&ub->mutex);
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index c8dc5f8ea699..c4512b3a3c52 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -147,8 +147,18 @@
>   */
>  #define UBLK_F_NEED_GET_DATA (1UL << 2)
>  
> +/*
> + * - Block devices are recoverable if ublk server exits and restarts
> + * - Outstanding I/O when ublk server exits is met with errors
> + * - I/O issued while there is no ublk server queues
> + */
>  #define UBLK_F_USER_RECOVERY	(1UL << 3)
>  
> +/*
> + * - Block devices are recoverable if ublk server exits and restarts
> + * - Outstanding I/O when ublk server exits is reissued
> + * - I/O issued while there is no ublk server queues
> + */
>  #define UBLK_F_USER_RECOVERY_REISSUE	(1UL << 4)
>  
>  /*
> @@ -184,10 +194,18 @@
>   */
>  #define UBLK_F_ZONED (1ULL << 8)
>  
> +/*
> + * - Block devices are recoverable if ublk server exits and restarts
> + * - Outstanding I/O when ublk server exits is met with errors
> + * - I/O issued while there is no ublk server is met with errors
> + */
> +#define UBLK_F_USER_RECOVERY_NOQUEUE (1ULL << 9)

Maybe UBLK_F_USER_RECOVERY_FAIL_IO is more readable?


Thanks,
Ming

