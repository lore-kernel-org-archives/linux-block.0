Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C656F2036FD
	for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744358550; cv=none; b=JVhXWzVUV+/3U3DZmDGImMjVEAmnptzAOmwtIH6sfbot6aa3PXOZHRNlMPuQrCAeSQGb+ykzfW+jZjV4Tw5FW0QoiPiPl1XNK51lWs1aMeGoyCGUtwGbeg9Ra1VB2EQTx7UKGCNQLSb14f/QIXJjCpuQGGWfWuFbnGS3i5+WRp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744358550; c=relaxed/simple;
	bh=bJIGWZr09BJQ3gmJowjLO0xP1knQUg5AguP3XTDCXvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIXPs2kgbmp6LQJNBj3j5h+LfS0HJJE0zQQInkiFtb1t/jrwmKd3RXSHgACwx/bzYZd9BTskiFjXpQHLXOvNRy3Bll+eTD6xwWjfUyG27oYaMJ/0nSmJHFRAdy+a74Q+C5pnv10FjwtH+rggQQb71GgxSBqRMB1Cd9Kkbo6bldE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7MVv547; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7MVv547"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744358546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wK13rtIG/Pb5xZ/jbCtytwwKSajj6D7fYkGbfAbg6zo=;
	b=N7MVv547vqMwUg1r2+OLlDziqOuwQsPtIwaunggRO3y/Rmz9rxLQRraK29EFloe6nIxOyd
	UWrWfxnDAjkO/G3NvXfUu5kSeKeUPGXBtVALNrjDSDfqvhmahZGukZcEKiBXtNeb7IU18l
	C2ZB4/V4+IbJQSRD9FNQ0e/a0CCWRX4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-rj8Fmh4CMLW4ocRQt-SQnA-1; Fri,
 11 Apr 2025 04:02:21 -0400
X-MC-Unique: rj8Fmh4CMLW4ocRQt-SQnA-1
X-Mimecast-MFC-AGG-ID: rj8Fmh4CMLW4ocRQt-SQnA_1744358540
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 545701800267;
	Fri, 11 Apr 2025 08:02:20 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C2763001D0E;
	Fri, 11 Apr 2025 08:02:16 +0000 (UTC)
Date: Fri, 11 Apr 2025 16:02:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jared Holzman <jholzman@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] ublk: Add UBLK_U_CMD_UPDATE_SIZE
Message-ID: <Z_jMg4NSBe6ONzpH@fedora>
References: <d90ff20a-b324-49b8-bc63-7d7a35afd1f6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d90ff20a-b324-49b8-bc63-7d7a35afd1f6@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Apr 10, 2025 at 03:29:38PM +0300, Jared Holzman wrote:
> Currently ublk only allows the size of the ublkb block device to be
> set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.
> 
> This does not provide support for extendable user-space block devices
> without having to stop and restart the underlying ublkb block device
> causing IO interruption.
> 
> This patch adds a new ublk command UBLK_U_CMD_UPDATE_SIZE to allow the
> ublk block device to be resized on-the-fly.
> 
> Feature flag UBLK_F_UPDATE_SIZE is also added to indicate support for this
> command.
> 
> Signed-off-by: Omri Mann <omri@nvidia.com>
> ---
>  drivers/block/ublk_drv.c      | 23 ++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |  7 +++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2fd05c1bd30b..acf8aa6c4452 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -64,7 +64,8 @@
>                 | UBLK_F_CMD_IOCTL_ENCODE \
>                 | UBLK_F_USER_COPY \
>                 | UBLK_F_ZONED \
> -               | UBLK_F_USER_RECOVERY_FAIL_IO)
> +               | UBLK_F_USER_RECOVERY_FAIL_IO \
> +               | UBLK_F_UPDATE_SIZE)
> 
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                 | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -3052,6 +3053,22 @@ static int ublk_ctrl_get_features(struct io_uring_cmd
> *cmd)
>         return 0;
>  }
> 
> +static int ublk_ctrl_set_size(struct ublk_device *ub,
> +               struct io_uring_cmd *cmd)
> +{
> +       const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
> +       struct ublk_param_basic *p = &ub->params.basic;
> +       size_t new_size = (int)header->data[0];
> +       int ret = 0;
> +
> +       p->dev_sectors = new_size;

The above line need to be protected by ub->mutex.


thanks,
Ming

