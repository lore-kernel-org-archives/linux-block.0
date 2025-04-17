Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8371FE469
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932925; cv=none; b=bIyU5/zn690HcbvNG6eTlXf+B5wjcYPBztAKngHJtXC/ZRBmJbOlYt3gWr+0nTZMrDuSSonj1h7HsDnwlI1Bt+yfEaAwiDZCcR0oUdvI3tPBscsxQmpkCNYZ1NWXplPWQICvedlmge97ZRAVqGJPERaBK21GMnHxt42YpXkCIO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932925; c=relaxed/simple;
	bh=aH3DrWcjqAF+Nd7X8ManoDKIrjr1yKeC0bWIgEiMV0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chtIhDkWihIoSzwgfmtzhbQAHumnw6vJF3ZNwhhq9W9DQ10llHbeelvQO6EeBaTdXqxJ1IaN1xACyaqbQhy7Np028Up0y/N4dXllIGNixgGmyUWsI02UNDeNdY33qySBroHzE8IqYkOeRlPcvddIPQki3puil1kAqrcMipXDQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5Iw+X4S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5Iw+X4S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744932922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmkqdOC0y+GDsIUkmanR2brjgYplniigba6f4Ghrhuo=;
	b=e5Iw+X4SjaYgFUqsTu8/EescbSmI0jRqd0MdpGxfvoumYwZVUGaZ88zQEf5HrXbMpc/a7W
	AnQ3DK+zpC5wrBkFYKL5hkvSFerxCUG/J72mEUKQFHtiErR0Ky7AFeGBmyhK4RJePL4HsG
	zv+HJpfxyUsAeAqduZpo93uc6MrpSpI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-73gMbh6yPQ2JZLXIWuqkwA-1; Thu,
 17 Apr 2025 19:35:18 -0400
X-MC-Unique: 73gMbh6yPQ2JZLXIWuqkwA-1
X-Mimecast-MFC-AGG-ID: 73gMbh6yPQ2JZLXIWuqkwA_1744932918
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 726D51800446;
	Thu, 17 Apr 2025 23:35:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.13])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02D351801770;
	Thu, 17 Apr 2025 23:35:13 +0000 (UTC)
Date: Fri, 18 Apr 2025 07:35:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jared Holzman <jholzman@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, csander@purestorage.com
Subject: Re: [PATCH v4]: ublk: Add UBLK_U_CMD_UPDATE_SIZE
Message-ID: <aAGQLYDOFY5PyUMJ@fedora>
References: <918750ec-42e8-46d4-bbfb-e01d3dce6ed0@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <918750ec-42e8-46d4-bbfb-e01d3dce6ed0@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Apr 16, 2025 at 01:07:47PM +0300, Jared Holzman wrote:
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
>  drivers/block/ublk_drv.c      | 18 +++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |  7 +++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index cdb1543fa4a9..128f094efbad 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -64,7 +64,8 @@
>          | UBLK_F_CMD_IOCTL_ENCODE \
>          | UBLK_F_USER_COPY \
>          | UBLK_F_ZONED \
> -        | UBLK_F_USER_RECOVERY_FAIL_IO)
> +        | UBLK_F_USER_RECOVERY_FAIL_IO \
> +        | UBLK_F_UPDATE_SIZE)
> 
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>          | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -3067,6 +3068,16 @@ static int ublk_ctrl_get_features(const struct
> ublksrv_ctrl_cmd *header)

I try to apply this patch downloaded from both lore or patchwork, and 'git
am' always complains the patch is broken:

[root@ktest-40 linux]# git am raw
warning: Patch sent with format=flowed; space at the end of lines might be lost.
Applying: ublk: Add UBLK_U_CMD_UPDATE_SIZE
error: corrupt patch at line 11
Patch failed at 0001 ublk: Add UBLK_U_CMD_UPDATE_SIZE
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"
[root@ktest-40 linux]# patch -p1 < raw
patching file drivers/block/ublk_drv.c
Hunk #1 FAILED at 64.
patch: **** malformed patch at line 192: ublksrv_ctrl_cmd *header)

Please use 'git-format-patch' to make patch and run `./scripts/checkpatch.pl -g HEAD`
in kernel top directory to make sure no ERROR.

>      return 0;
>  }
> 
> +static void ublk_ctrl_set_size(struct ublk_device *ub, const struct
> ublksrv_ctrl_cmd *header)
> +{
> +    struct ublk_param_basic *p = &ub->params.basic;
> +    u64 new_size = header->data[0];
> +
> +    mutex_lock(&ub->mutex);
> +    p->dev_sectors = new_size;
> +    set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
> +    mutex_unlock(&ub->mutex);
> +}
>  /*
>   * All control commands are sent via /dev/ublk-control, so we have to check
>   * the destination device's permission
> @@ -3152,6 +3163,7 @@ static int ublk_ctrl_uring_cmd_permission(struct
> ublk_device *ub,
>      case UBLK_CMD_SET_PARAMS:
>      case UBLK_CMD_START_USER_RECOVERY:
>      case UBLK_CMD_END_USER_RECOVERY:
> +    case _IOC_NR(UBLK_U_CMD_UPDATE_SIZE):

Here it could be more clean to add one private definition:

	#define UBLK_CMD_UPDATE_SIZE _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)

just like what we did for `UBLK_CMD_DEL_DEV_ASYNC`.

Then use UBLK_CMD_UPDATE_SIZE directly.

>          mask = MAY_READ | MAY_WRITE;
>          break;
>      default:
> @@ -3243,6 +3255,10 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd
> *cmd,
>      case UBLK_CMD_END_USER_RECOVERY:
>          ret = ublk_ctrl_end_recovery(ub, header);
>          break;
> +    case _IOC_NR(UBLK_U_CMD_UPDATE_SIZE):

Same with above.

> +        ublk_ctrl_set_size(ub, header);
> +        ret = 0;
> +        break;
>      default:
>          ret = -EOPNOTSUPP;
>          break;
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index 583b86681c93..587a54b3cfe1 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -51,6 +51,8 @@
>      _IOR('u', 0x13, struct ublksrv_ctrl_cmd)
>  #define UBLK_U_CMD_DEL_DEV_ASYNC    \
>      _IOR('u', 0x14, struct ublksrv_ctrl_cmd)
> +#define UBLK_U_CMD_UPDATE_SIZE        \
> +    _IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
> 
>  /*
>   * 64bits are enough now, and it should be easy to extend in case of
> @@ -211,6 +213,11 @@
>   */
>  #define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)
> 
> +/*
> + * Resizing a block device is possible with UBLK_U_CMD_UPDATE_SIZE
> + */
> +#define UBLK_F_UPDATE_SIZE         (1ULL << 10)

Please document how size is passed, and the unit is sector.

With above addressed, this patch looks fine.


Thanks,
Ming

