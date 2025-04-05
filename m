Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926B1AAE28
	for <linux-block@vger.kernel.org>; Sat,  5 Apr 2025 02:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743821487; cv=none; b=US/fdJtHQNlKuOQNTr2BN+jEVvu2+8xNdzYM5IqMT6aegwV5bjDHUmbfsmfEj758ld+9IF9xqcxNVCNNwJcu1wesPjIUd2NHmAetfHjRhOYk7uv+ZscvOSt4Ivs9b3nkNqKXqTbod5wqoACnXoPRNU+uOGVNON6oGcQ3FazqC2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743821487; c=relaxed/simple;
	bh=qTTiIo2Hwj2oZepleSGN1UqYWbojRb7VWml+TQ6OAG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRqpc8cKtIT8Q0NkW2Zul4ZPdb6C20MxFiBlIWudZWvcgyEjSegnCfhFDRw6mAHUgIixGIuUNs38nLLjox21uuNgeDEIdR89q1L6uCR0XHhPg7TrJ9HNJth38HEvkZHQ/mPr0PG4gj4feayGRBInlvVu4TLG8I+pRzvs0DhrMtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hx3694+i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hx3694+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743821484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5Pzidrd4gjFd4NGTawODfyIkMxP4bXEOLn8muTnXdM=;
	b=hx3694+i+j48F5Vwyz2PhNKWk6/F+r+S7feHDpIaOJvx3FldN/iRiQleUbwS0e9S5DOFEa
	wjNR9AK7qElO3EKn7sceeITPqb+dicTPFPwCCOA32IPpy1l0e/B0ZJ2LQ+Hmj4qW10IDAO
	DkXm8UVzSBq6Tq5d0ers9cTKqLf9zWw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-HdyYDzdnPfW6dFSvSQyXfw-1; Fri,
 04 Apr 2025 22:51:20 -0400
X-MC-Unique: HdyYDzdnPfW6dFSvSQyXfw-1
X-Mimecast-MFC-AGG-ID: HdyYDzdnPfW6dFSvSQyXfw_1743821479
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AF451956048;
	Sat,  5 Apr 2025 02:51:19 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D22B18009BC;
	Sat,  5 Apr 2025 02:51:15 +0000 (UTC)
Date: Sat, 5 Apr 2025 10:51:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jared Holzman <jholzman@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] ublk: Add UBLK_U_CMD_SET_SIZE
Message-ID: <Z_Cana4Ibs8zN_wA@fedora>
References: <20250331135449.3371818-1-jholzman@nvidia.com>
 <SJ1PR12MB63639AFCE9BC8C1EC4D28795B1AE2@SJ1PR12MB6363.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR12MB63639AFCE9BC8C1EC4D28795B1AE2@SJ1PR12MB6363.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello Jared,

On Thu, Apr 03, 2025 at 12:37:11PM +0000, Jared Holzman wrote:
> Apologies if this is a dup, but I am not seeing the original mail on the mailing list archive.

I guess it is because the patch is sent as html, instead of plain test,
please follow the patch submission guide:

https://www.kernel.org/doc/Documentation/process/submitting-patches.rst

> 
> ________________________________
> From: Jared Holzman <jholzman@nvidia.com>
> Sent: Monday, 31 March 2025 4:54 PM
> To: linux-block@vger.kernel.org <linux-block@vger.kernel.org>
> Cc: ming.lei@redhat.com <ming.lei@redhat.com>; Omri Mann <omri@nvidia.com>; Ofer Oshri <ofer@nvidia.com>; Omri Levi <omril@nvidia.com>; Jared Holzman <jholzman@nvidia.com>
> Subject: [PATCH] ublk: Add UBLK_U_CMD_SET_SIZE
> 
> From: Omri Mann <omri@nvidia.com>
> 
> Currently ublk only allows the size of the ublkb block device to be
> set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.
> 
> This does not provide support for extendable user-space block devices
> without having to stop and restart the underlying ublkb block device
> causing IO interruption.

The requirement is reasonable.

> 
> This patch adds a new ublk command UBLK_U_CMD_SET_SIZE to allow the
> ublk block device to be resized on-the-fly.

Looks CMD_SET_SIZE is not generic enough, maybe UBLK_CMD_UPDATE_PARAMS
can be added for support any parameter update by allowing to do it
when device is in LIVE state.

> 
> Signed-off-by: Omri Mann <omri@nvidia.com>
> ---
>  Documentation/block/ublk.rst  |  5 +++++
>  drivers/block/ublk_drv.c      | 26 +++++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |  7 +++++++
>  3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> index 1e0e7358e14a..7eca87a66b9c 100644
> --- a/Documentation/block/ublk.rst
> +++ b/Documentation/block/ublk.rst
> @@ -139,6 +139,11 @@ managing and controlling ublk devices with help of several control commands:
>    set up the per-queue context efficiently, such as bind affine CPUs with IO
>    pthread and try to allocate buffers in IO thread context.
> 
> +- ``UBLK_F_SET_SIZE``
> +
> +  Allows changing the size of the block device after it has started. Useful for
> +  userspace implementations that allow extending the underlying block device.
> +
>  - ``UBLK_CMD_GET_DEV_INFO``
> 
>    For retrieving device info via ``ublksrv_ctrl_dev_info``. It is the server's
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c060da409ed8..ab6364475b9c 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -64,7 +64,8 @@
>                  | UBLK_F_CMD_IOCTL_ENCODE \
>                  | UBLK_F_USER_COPY \
>                  | UBLK_F_ZONED \
> -               | UBLK_F_USER_RECOVERY_FAIL_IO)
> +               | UBLK_F_USER_RECOVERY_FAIL_IO \
> +               | UBLK_F_SET_SIZE)
> 
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                  | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -2917,6 +2918,25 @@ static int ublk_ctrl_get_features(struct io_uring_cmd *cmd)
>          return 0;
>  }
> 
> +static int ublk_ctrl_set_size(struct ublk_device *ub,
> +               struct io_uring_cmd *cmd)
> +{
> +       const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
> +       struct ublk_param_basic *p = &ub->params.basic;
> +       size_t new_size = (int)header->data[0];
> +       int ret = 0;
> +       unsigned int memflags;
> +
> +       p->dev_sectors = new_size;
> +
> +       memflags = blk_mq_freeze_queue(ub->ub_disk->queue);
> +       mutex_lock(&ub->mutex);
> +       set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
> +       mutex_unlock(&ub->mutex);
> +       blk_mq_unfreeze_queue(ub->ub_disk->queue, memflags);

Actually if it is just for updating device size, queue freeze isn't needed,
because bio_check_eod() is called without grabbing ->q_usage_counter, but
for updating other parameters, freezing queue is often needed.


Thanks,
Ming

