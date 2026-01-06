Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FA829CE9
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767709712; cv=none; b=CeZMrbmysjYdgxYZTa+2AHFGc064nM3CPT21JFgOXo0cz0auFQ1Qmk1KaEwz9KoI39RuLhnMHYQ8G2iMjCxQfBaa3hYU7sGwhQgsRohu3Ki7azsiIpycNJ0CbPRH7HrGoq0MxiEQNn5ukOwWQMKzzUKCxuiiO0i5X2ztHrxlCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767709712; c=relaxed/simple;
	bh=1+94GJ8+LkHE3asxoSQmLwOLrII0o196LUuF2uk5+S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKZxrKWKAyw88ikkzQoBcxoCjZeNAYlQwrc4c+/NIMugWxjLG9HbyncCXwAxq6fwtvO7f07rdAmAs7whgTfuw/at95UOjSgeXu9Ai1gHx0V6u3sZEaV9K8SANNqq0N3fERKzUt3/CnSecOzdxVZlX8yY1UjPQbbWqcM07uMuxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcGlKW5x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcGlKW5x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767709709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERjLT0cuVeu4ym3+lt85LlaMv7KqBqF0oVent2a7UsQ=;
	b=VcGlKW5xvc1/rH5VO82ORlGgEaHs2A2rpJJB9m3CZqd+x79dudPpPBXSv/yC5A50BaXuDO
	FjoaKbTtGy7MbT07R4IqJzudxMVEBQzOYjtxcvbzFbxRywc+YpLBKwc5KrH9Rv3eZiNRKN
	4u9CTrxjNXDHcbUz/rJcy7SEX0LrYEk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-MYrhGzHNPNO4xg49mkcvkw-1; Tue,
 06 Jan 2026 09:28:28 -0500
X-MC-Unique: MYrhGzHNPNO4xg49mkcvkw-1
X-Mimecast-MFC-AGG-ID: MYrhGzHNPNO4xg49mkcvkw_1767709707
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BB0A18002C9;
	Tue,  6 Jan 2026 14:28:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 837211956053;
	Tue,  6 Jan 2026 14:28:23 +0000 (UTC)
Date: Tue, 6 Jan 2026 22:28:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: linux-block@vger.kernel.org, csander@purestorage.com,
	jholzman@nvidia.com, omril@nvidia.com
Subject: Re: [PATCH v2 2/2] ublk: add UBLK_CMD_TRY_STOP_DEV command
Message-ID: <aV0cAkNxHRqxHMHg@fedora>
References: <20260104084839.30065-1-yoav@nvidia.com>
 <20260104084839.30065-3-yoav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104084839.30065-3-yoav@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sun, Jan 04, 2026 at 10:48:39AM +0200, Yoav Cohen wrote:
> This command is similar to UBLK_CMD_STOP_DEV, but it only stops the
> device if there are no active openers for the ublk block device.
> If the device is busy, the command returns -EBUSY instead of
> disrupting active clients. This allows safe, non-destructive stopping.
> 
> Signed-off-by: Yoav Cohen <yoav@nvidia.com>
> ---
>  drivers/block/ublk_drv.c      | 42 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/ublk_cmd.h |  3 ++-
>  2 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2d5602ef05cc..55a5ab11c1cd 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -54,6 +54,7 @@
>  #define UBLK_CMD_DEL_DEV_ASYNC	_IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
>  #define UBLK_CMD_UPDATE_SIZE	_IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
>  #define UBLK_CMD_QUIESCE_DEV	_IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
> +#define UBLK_CMD_TRY_STOP_DEV	_IOC_NR(UBLK_U_CMD_TRY_STOP_DEV)

This need a feature flag, such as UBLK_F_SAFE_STOP, which is set in
ublk_ctrl_add_dev(), meantime document that UBLK_CMD_TRY_STOP_DEV is
supported with this feature.

>  
>  #define UBLK_IO_REGISTER_IO_BUF		_IOC_NR(UBLK_U_IO_REGISTER_IO_BUF)
>  #define UBLK_IO_UNREGISTER_IO_BUF	_IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF)
> @@ -239,6 +240,8 @@ struct ublk_device {
>  	struct delayed_work	exit_work;
>  	struct work_struct	partition_scan_work;
>  
> +	bool			block_open; /* protected by open_mutex */
> +
>  	struct ublk_queue       *queues[];
>  };
>  
> @@ -919,6 +922,9 @@ static int ublk_open(struct gendisk *disk, blk_mode_t mode)
>  			return -EPERM;
>  	}
>  
> +	if (ub->block_open)
> +		return -EBUSY;
> +
>  	return 0;
>  }
>  
> @@ -3309,6 +3315,38 @@ static void ublk_ctrl_stop_dev(struct ublk_device *ub)
>  	ublk_stop_dev(ub);
>  }
>  
> +static int ublk_ctrl_try_stop_dev(struct ublk_device *ub)
> +{
> +	struct gendisk *disk;
> +	int ret = -EINVAL;

-EINVAL is never used, it may save the line of `ret = 0` if it is
initialized as 0.

> +
> +	disk = ublk_get_disk(ub);
> +	if (!disk) {
> +		ret = -ENODEV;
> +		goto out;

		return -ENODEV;


Thanks, 
Ming

