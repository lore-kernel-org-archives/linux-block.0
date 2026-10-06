Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91BE3E51E8
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298617; cv=none; b=SvrZ/rBMZkxrheS1sMjiDT1y0UXtj/2m7yayj9oC85vct1x8jFA2swjMtvay/C1ObpMKRiTf2QsM7z0xbHyzOVqOmIOh3t1pBnNIbWAZFoNlBb4VwpPe5QzV4rIHTiVp1k2dydM39lgO200nV76PUlN749b7skQrKZwmwPfcZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298617; c=relaxed/simple;
	bh=WJTaj7qEpvVgaPO3Tnc6JqvNBCbv1gYN73W9stG4+50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7qKdnZwFKqXHeo5OBS8Bo59fIm0xtWQR15A2Y3VomxbunRM9+E/pQuy0uPfcJl+cvJNUVgUHXKu53YvbYlwwNe+VW/2T8pTiNETPqvll8hlYZXeXwV7TEYHf6hx8SA1KECU2gCI/5rQ2FHnR95nUI4wV2hvb6ydtBBnE/rCNtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBuT5j1h; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBuT5j1h"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f432ac553fso1747989a34.3
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 07:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791298614; x=1791903414; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5wke3rQYW3Bss11lhL2bthj0kAeLYeUV7DEa2nAyb/c=;
        b=ZBuT5j1hiFHNFYCdOB+QbooZdvlP2c6/yxrvWMD87cLbTvi+/DJ7jwt0WvWuRURlmq
         84UN1ZMPxEqre9jHyBVTjc4nuLO+x2hxmLM6BW2ezowT4Hr3iyzIVOntTelDNdRiQtyy
         zNt5K7Rzo21ImVs/4Annjy923q/hke4wQWGaX/AAK0MfDALcSND6lKtyjtmAOq1zqzCR
         rVzVMUjEMh+OeVn40wSIifkOxykvDW1xnsTTaILA+KAilZQL1buK/nLr3L9rZRIFElRC
         Vn+AVnDgCdlP9k021IwCDmV5CYeysK0eiEY+FRXllNHsi6dYKx2BPp5OXR2twdeLIrrb
         HZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791298614; x=1791903414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5wke3rQYW3Bss11lhL2bthj0kAeLYeUV7DEa2nAyb/c=;
        b=cPRz1LbIqowk8wDs+rDYD1MqAr6CyO6Dxm7t2k8KsGwj15ztH+W9d5KosvZ5z01Dc4
         HmC2hoSJxMggLpN31hJlZG/cFI1dr1LC0I2mOUmP4JZYtc/gFuJ5q7X8BlganrZxneNj
         xvzrnlEU8TPbGq+IYRv6UlB6+XZnLOPnRmocxhpyJuuhPP1L4ya1Ghc6i1P6ThTMZXB0
         dpwsNfPJVD8xKJM1kjLLsblVzCsUv9bhHxdkZ44ouHpXlMRUHz9MzbYU9YA6s+tPCz7K
         B06lMM20R9MPncbPZP4FTR5ukUc6fmVC9PphmF88s90SIukHqiikMv32x1XdH40RxhWE
         VFLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfgxkqkvflVG2vQyHZtjoxvwdaA7vMKsTnEy0qx1m1dCO/rG7+qglEUupFnIK1MGyNCwOIfe7kZ6+HOg==@vger.kernel.org
X-Gm-Message-State: AFuF++mRH1o3mOUZ+DfWTqpmF+GNBC3eJjhcmZXDEqLXKHeUBYDzvd8n
	Zcu5Tp1ZWRGSSOdbZN9CcoxjrDJL5dNj1N+GoAv8YRVuo3yxwT/iQ9gS
X-Gm-Gg: AYBFou1hbHozmF7CfJA89UmR42mWWLAdDn8juEBmW0YeZryz2kHHoK18Tsc6zwbqJvV
	75tL+I/e2CIIN2Htob+8ExLjiimtX6OV+d0x1YC8AwqN1INifhunYgpX1HY/cYEaQegmDoOO6VP
	EVdjbDzTg3cJCDS4HfbWmj+p5gs2nQ2QUTuf0o4TfaPrPDD36M7hc/wsE3b4WgIrhJZk6tFcPti
	h+PYhMjDgutepg5DTFFaCUFKUVlQS+7TuSaboCxRluZkYTcnJ3cKjNL18L33GuD3Vh5Q+TRcrdj
	VFAnFFeQrk6qnD53ApmsJycXAHIYf8KXYlMmgdVPzDYjyEy4pA++lMaPZobnCcSlwscXd/prpD8
	1ko1SH0w6YEF55WNGrXvGiJ8IY6Bhb/lMm1th8Z6a5nIKkXVZ2epZCZ3Kwy7/hY4gCmR9rywQwE
	qrAEeUgk1PQeN+de0XEzxVLHTR73ijvd1Xb3e/c0R3rzsFJ4URknEl3b3D5E/MwY4En7F3UJ3E2
	FXaa111LS9cGGiD8e3+2I4vaz24fKh8eTI5MDx8Q9pMjgRZ4qbsKrtlxpwmFkSRp9BtgvVKhDpR
	bBk=
X-Received: by 2002:a05:6830:6a98:b0:811:4c27:f3c0 with SMTP id 46e09a7af769-8289eb39e71mr1857849a34.3.1791298614393;
        Tue, 06 Oct 2026 07:56:54 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8281db458fbsm2617214a34.2.2026.10.06.07.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:56:53 -0700 (PDT)
Date: Tue, 6 Oct 2026 09:56:42 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	csander@purestorage.com, jholzman@nvidia.com, omril@nvidia.com
Subject: Re: [PATCH 1/2] ublk: complete requests via
 blk_mq_complete_request() so rq_affinity applies
Message-ID: <asUMKqdP3PwEnJBk@fedora-laptop>
References: <20261006085517.33974-1-yoav@nvidia.com>
 <20261006085517.33974-2-yoav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261006085517.33974-2-yoav@nvidia.com>

On Tue, Oct 06, 2026 at 11:55:16AM +0300, Yoav Cohen wrote:
> ublk ends successfully completed requests inline on the server thread
> that issued UBLK_IO_COMMIT_AND_FETCH_REQ, so rq_affinity never
> redirects completion back to the submitting CPU, unlike NVMe, SCSI,
> virtio-blk, loop, nbd and rnbd.
> 
> Route completion through blk_mq_complete_request_remote(), with a new
> ->complete() callback, ublk_end_rq(). Add UBLK_F_SUPPORT_RQ_AFFINITY
> so servers can detect support via UBLK_CMD_GET_FEATURES.
> 
> Signed-off-by: Yoav Cohen <yoav@nvidia.com>
> ---
>  drivers/block/ublk_drv.c      | 72 +++++++++++++++++++++++++----------
>  include/uapi/linux/ublk_cmd.h |  8 ++++
>  2 files changed, 59 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 66eb55e7162e..48bdb5d782ee 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -90,7 +90,8 @@
>  		| UBLK_F_BATCH_IO \
>  		| UBLK_F_NO_AUTO_PART_SCAN \
>  		| UBLK_F_SHMEM_ZC \
> -		| UBLK_F_IO_DESC_SIZE)
> +		| UBLK_F_IO_DESC_SIZE \
> +		| UBLK_F_SUPPORT_RQ_AFFINITY)
>  
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>  		| UBLK_F_USER_RECOVERY_REISSUE \
> @@ -1549,13 +1550,54 @@ static void ublk_end_request(struct request *req, blk_status_t error)
>  	local_bh_enable();
>  }
>  
> +/*
> + * Update @req with its result and requeue it if it was only partially
> + * completed. Returns true if @req was requeued, in which case the caller
> + * must not touch it any further.
> + *
> + * Run bio->bi_end_io() with softirqs disabled. If the final fput happens
> + * off this path, then that will prevent ublk's blkdev_release() from
> + * being called on current's task work, see fput() implementation.
> + *
> + * This matters for the caller completing @req locally on the ublk
> + * server's own thread: it may already be holding disk->open_mutex, e.g.
> + * reading the partition table from bdev_open(), and an fput() running
> + * inline there could deadlock on it. Preferably we would not be doing
> + * IO with a mutex held that is also used for release, but this
> + * work-around will suffice for now. A caller reached instead via
> + * blk_mq_complete_request_remote()'s softirq/IPI redirect never runs on
> + * that thread, so it isn't exposed to this hazard, but disabling
> + * softirqs here is harmless for it too.
> + */
> +static inline bool ublk_update_and_requeue(struct request *req,
> +					   struct ublk_io *io)
> +{
> +	bool requeue;
> +
> +	local_bh_disable();
> +	requeue = blk_update_request(req, BLK_STS_OK, io->res);
> +	local_bh_enable();
> +	if (requeue)
> +		blk_mq_requeue_request(req, true);
> +	return requeue;
> +}
> +
> +static void ublk_end_rq(struct request *req)
> +{
> +	struct ublk_queue *ubq = req->mq_hctx->driver_data;
> +	struct ublk_io *io = &ubq->ios[req->tag];
> +
> +	if (!ublk_update_and_requeue(req, io) &&
> +	    likely(!blk_should_fake_timeout(req->q)))
> +		__blk_mq_end_request(req, BLK_STS_OK);
> +}
> +
>  /* todo: handle partial completion */
>  static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
>  				      bool need_map, struct io_comp_batch *iob)
>  {
>  	unsigned int unmapped_bytes;
>  	blk_status_t res = BLK_STS_OK;
> -	bool requeue;
>  
>  	/* failed read IO if nothing is read */
>  	if (!io->res && req_op(req) == REQ_OP_READ)
> @@ -1588,25 +1630,11 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
>  		io->res = unmapped_bytes;
>  	}
>  
> -	/*
> -	 * Run bio->bi_end_io() with softirqs disabled. If the final fput
> -	 * happens off this path, then that will prevent ublk's blkdev_release()
> -	 * from being called on current's task work, see fput() implementation.
> -	 *
> -	 * Otherwise, ublk server may not provide forward progress in case of
> -	 * reading the partition table from bdev_open() with disk->open_mutex
> -	 * held, and causes dead lock as we could already be holding
> -	 * disk->open_mutex here.
> -	 *
> -	 * Preferably we would not be doing IO with a mutex held that is also
> -	 * used for release, but this work-around will suffice for now.
> -	 */
> -	local_bh_disable();
> -	requeue = blk_update_request(req, BLK_STS_OK, io->res);
> -	local_bh_enable();
> -	if (requeue)
> -		blk_mq_requeue_request(req, true);
> -	else if (likely(!blk_should_fake_timeout(req->q))) {
> +	if (blk_mq_complete_request_remote(req))
> +		return;

Only copy-mode READs get the new completion path. In __ublk_complete_rq(), anything
that needs no copy back to the request jumps to exit: ublk_end_request(), which
completes inline as before:

- all WRITEs, flush and discard;
- all USER_COPY, ZERO_COPY, AUTO_BUF_REG and shmem zero-copy I/O;
- every error.
    
Only a successful READ in copy mode reaches the new blk_mq_complete_request_remote()
call. So the uapi comment "Request completion honors … rq_affinity" is false for most I/O.

> +
> +	if (!ublk_update_and_requeue(req, io) &&
> +	    likely(!blk_should_fake_timeout(req->q))) {
>  		if (blk_mq_add_to_batch(req, iob, false, blk_mq_end_request_batch))
>  			return;
>  		__blk_mq_end_request(req, BLK_STS_OK);
> @@ -2347,6 +2375,7 @@ static const struct blk_mq_ops ublk_mq_ops = {
>  	.queue_rqs      = ublk_queue_rqs,
>  	.init_hctx	= ublk_init_hctx,
>  	.timeout	= ublk_timeout,
> +	.complete	= ublk_end_rq,
>  };
>  
>  static const struct blk_mq_ops ublk_batch_mq_ops = {
> @@ -2355,6 +2384,7 @@ static const struct blk_mq_ops ublk_batch_mq_ops = {
>  	.queue_rqs      = ublk_batch_queue_rqs,
>  	.init_hctx	= ublk_init_hctx,
>  	.timeout	= ublk_timeout,
> +	.complete	= ublk_end_rq,
>  };
>  
>  static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index 33b25dd13965..47b5fba9519c 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -420,6 +420,14 @@ struct ublk_shmem_buf_reg {
>  /* ublksrv_io_desc size is specified by ublksrv_ctrl_dev_info's io_desc_size */
>  #define UBLK_F_IO_DESC_SIZE (1ULL << 20)
>  
> +/*
> + * Request completion honors the block device's rq_affinity setting
> + * (/sys/block/ublkbN/queue/rq_affinity): the submitting CPU's completion
> + * work can run there instead of always on the ublk server's CPU. Without
> + * this feature, rq_affinity has no effect on ublk devices.
> + */
> +#define UBLK_F_SUPPORT_RQ_AFFINITY (1ULL << 21)

This flag should be checked somewhere given it is passed from userspace,
otherwise it can be nop.


Thanks,
Ming
