Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0413B2A4
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749203660; cv=none; b=Hkx7jcjRJ5Z88Vu9J3YWWWc7m7YLTTnbNaQ3IqKFwum9f//hCexLNnorZxI71CJPnUOvm9uik+nG+1Ls7GteGf/4uASLeZIoP4yFfBxdmRDB60zmGbyAOMwV3H2L7P6xbIk0/zcf7Rzzk9JN/03quAy9S+3+L5wxMWmq3K6GCHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749203660; c=relaxed/simple;
	bh=lIfuDV1RrBFwWqSLoAwRYokJ7fRVkIQ3AIQnoA8VDoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6BZ8p1LJhv2NucZm0mWUJ+sQKzUfNuoDKkBU0CfrKqKIE7cUeXOxS0xJP4NsGbt66mRbyyB6RIcOU7x1kUrIrLvJOSdJ+c0tpGEQMnBjbezwytWh62rwJHsmDUUHHtwLRWShR2NmnpLXuJnevh31SwLKbqyYvdN/wKEEycivrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqjL1z9K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqjL1z9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749203655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EGAiLnb730j6bGurI+GhiQXv4/NcgEujlEQU28kMMAI=;
	b=KqjL1z9K2s7GA4sjoNH1qvIa3jKyZ+AwFnJ1ZLjZcqNEeLa1Io6aY5btMV8OQdjd7Qg22h
	r2wpwjH5Bntmc/4w7y7Keg83H77Jh5TDkhTS87NCUnEmS1aCSL31Vwmvflw/eFUvhHGftH
	QQd8iqylqKWlUQu8A4/uW1dj/yxOFEA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-VakCkfWONgipVAHGIYKc3g-1; Fri,
 06 Jun 2025 05:54:12 -0400
X-MC-Unique: VakCkfWONgipVAHGIYKc3g-1
X-Mimecast-MFC-AGG-ID: VakCkfWONgipVAHGIYKc3g_1749203651
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CCF818003FD;
	Fri,  6 Jun 2025 09:54:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.163])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD89E1956087;
	Fri,  6 Jun 2025 09:54:06 +0000 (UTC)
Date: Fri, 6 Jun 2025 17:54:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE
Message-ID: <aEK6uZBU1qeJLmXe@fedora>
References: <20250522163523.406289-1-ming.lei@redhat.com>
 <20250522163523.406289-3-ming.lei@redhat.com>
 <DM4PR12MB6328039487A411B3AF0C678BA96FA@DM4PR12MB6328.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB6328039487A411B3AF0C678BA96FA@DM4PR12MB6328.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Yoav,

On Thu, Jun 05, 2025 at 12:37:01PM +0000, Yoav Cohen wrote:
> Hi Ming,
> 
> Thank you for that.
> Can you please clarify this
> +/* Wait until each hw queue has at least one idle IO */
> what do you exactly wait here? and why it is per io queue?
> As I understand if the wait timedout the operation will be canceled.

One idle IO means one active io_uring cmd, so we can use this command
for notifying ublk server. Otherwise, ublk server may not get chance to
know the quiesce action.

Because each queue may have standalone task context.

The condition should be satisfied easily in any implementation, but please
let me if it could be one issue in your ublk server implementation.

Big reason is that ublk doesn't have one such admin command for
housekeeping.

Thanks,
Ming


> 
> Thank you
> 
> ________________________________________
> From: Ming Lei <ming.lei@redhat.com>
> Sent: Thursday, May 22, 2025 7:35 PM
> To: Jens Axboe; linux-block@vger.kernel.org
> Cc: Uday Shankar; Caleb Sander Mateos; Yoav Cohen; Ming Lei
> Subject: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE
> 
> External email: Use caution opening links or attachments
> 
> 
> Add feature UBLK_F_QUIESCE, which adds control command `UBLK_U_CMD_QUIESCE_DEV`
> for quiescing device, then device state can become `UBLK_S_DEV_QUIESCED`
> or `UBLK_S_DEV_FAIL_IO` finally from ublk_ch_release() with ublk server
> cooperation.
> 
> This feature can help to support to upgrade ublk server application by
> shutting down ublk server gracefully, meantime keep ublk block device
> persistent during the upgrading period.
> 
> The feature is only available for UBLK_F_USER_RECOVERY.
> 
> Suggested-by: Yoav Cohen <yoav@nvidia.com>
> Link: https://lore.kernel.org/linux-block/DM4PR12MB632807AB7CDCE77D1E5AB7D0A9B92@DM4PR12MB6328.namprd12.prod.outlook.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 124 +++++++++++++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |  19 ++++++
>  2 files changed, 142 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index fbd075807525..6f51072776f1 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -51,6 +51,7 @@
>  /* private ioctl command mirror */
>  #define UBLK_CMD_DEL_DEV_ASYNC _IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
>  #define UBLK_CMD_UPDATE_SIZE   _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
> +#define UBLK_CMD_QUIESCE_DEV   _IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
> 
>  #define UBLK_IO_REGISTER_IO_BUF                _IOC_NR(UBLK_U_IO_REGISTER_IO_BUF)
>  #define UBLK_IO_UNREGISTER_IO_BUF      _IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF)
> @@ -67,7 +68,8 @@
>                 | UBLK_F_ZONED \
>                 | UBLK_F_USER_RECOVERY_FAIL_IO \
>                 | UBLK_F_UPDATE_SIZE \
> -               | UBLK_F_AUTO_BUF_REG)
> +               | UBLK_F_AUTO_BUF_REG \
> +               | UBLK_F_QUIESCE)
> 
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                 | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -2841,6 +2843,11 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
>                 return -EINVAL;
>         }
> 
> +       if ((info.flags & UBLK_F_QUIESCE) && !(info.flags & UBLK_F_USER_RECOVERY)) {
> +               pr_warn("UBLK_F_QUIESCE requires UBLK_F_USER_RECOVERY\n");
> +               return -EINVAL;
> +       }
> +
>         /*
>          * unprivileged device can't be trusted, but RECOVERY and
>          * RECOVERY_REISSUE still may hang error handling, so can't
> @@ -3233,6 +3240,117 @@ static void ublk_ctrl_set_size(struct ublk_device *ub, const struct ublksrv_ctrl
>         set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
>         mutex_unlock(&ub->mutex);
>  }
> +
> +struct count_busy {
> +       const struct ublk_queue *ubq;
> +       unsigned int nr_busy;
> +};
> +
> +static bool ublk_count_busy_req(struct request *rq, void *data)
> +{
> +       struct count_busy *idle = data;
> +
> +       if (!blk_mq_request_started(rq) && rq->mq_hctx->driver_data == idle->ubq)
> +               idle->nr_busy += 1;
> +       return true;
> +}
> +
> +/* uring_cmd is guaranteed to be active if the associated request is idle */
> +static bool ubq_has_idle_io(const struct ublk_queue *ubq)
> +{
> +       struct count_busy data = {
> +               .ubq = ubq,
> +       };
> +
> +       blk_mq_tagset_busy_iter(&ubq->dev->tag_set, ublk_count_busy_req, &data);
> +       return data.nr_busy < ubq->q_depth;
> +}
> +
> +/* Wait until each hw queue has at least one idle IO */
> +static int ublk_wait_for_idle_io(struct ublk_device *ub,
> +                                unsigned int timeout_ms)
> +{
> +       unsigned int elapsed = 0;
> +       int ret;
> +
> +       while (elapsed < timeout_ms && !signal_pending(current)) {
> +               unsigned int queues_cancelable = 0;
> +               int i;
> +
> +               for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> +                       struct ublk_queue *ubq = ublk_get_queue(ub, i);
> +
> +                       queues_cancelable += !!ubq_has_idle_io(ubq);
> +               }
> +
> +               /*
> +                * Each queue needs at least one active command for
> +                * notifying ublk server
> +                */
> +               if (queues_cancelable == ub->dev_info.nr_hw_queues)
> +                       break;
> +
> +               msleep(UBLK_REQUEUE_DELAY_MS);
> +               elapsed += UBLK_REQUEUE_DELAY_MS;
> +       }
> +
> +       if (signal_pending(current))
> +               ret = -EINTR;
> +       else if (elapsed >= timeout_ms)
> +               ret = -EBUSY;
> +       else
> +               ret = 0;
> +
> +       return ret;
> +}
> +
> +static int ublk_ctrl_quiesce_dev(struct ublk_device *ub,
> +                                const struct ublksrv_ctrl_cmd *header)
> +{
> +       /* zero means wait forever */
> +       u64 timeout_ms = header->data[0];
> +       struct gendisk *disk;
> +       int i, ret = -ENODEV;
> +
> +       if (!(ub->dev_info.flags & UBLK_F_QUIESCE))
> +               return -EOPNOTSUPP;
> +
> +       mutex_lock(&ub->mutex);
> +       disk = ublk_get_disk(ub);
> +       if (!disk)
> +               goto unlock;
> +       if (ub->dev_info.state == UBLK_S_DEV_DEAD)
> +               goto put_disk;
> +
> +       ret = 0;
> +       /* already in expected state */
> +       if (ub->dev_info.state != UBLK_S_DEV_LIVE)
> +               goto put_disk;
> +
> +       /* Mark all queues as canceling */
> +       blk_mq_quiesce_queue(disk->queue);
> +       for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> +               struct ublk_queue *ubq = ublk_get_queue(ub, i);
> +
> +               ubq->canceling = true;
> +       }
> +       blk_mq_unquiesce_queue(disk->queue);
> +
> +       if (!timeout_ms)
> +               timeout_ms = UINT_MAX;
> +       ret = ublk_wait_for_idle_io(ub, timeout_ms);
> +
> +put_disk:
> +       ublk_put_disk(disk);
> +unlock:
> +       mutex_unlock(&ub->mutex);
> +
> +       /* Cancel pending uring_cmd */
> +       if (!ret)
> +               ublk_cancel_dev(ub);
> +       return ret;
> +}
> +
>  /*
>   * All control commands are sent via /dev/ublk-control, so we have to check
>   * the destination device's permission
> @@ -3319,6 +3437,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
>         case UBLK_CMD_START_USER_RECOVERY:
>         case UBLK_CMD_END_USER_RECOVERY:
>         case UBLK_CMD_UPDATE_SIZE:
> +       case UBLK_CMD_QUIESCE_DEV:
>                 mask = MAY_READ | MAY_WRITE;
>                 break;
>         default:
> @@ -3414,6 +3533,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
>                 ublk_ctrl_set_size(ub, header);
>                 ret = 0;
>                 break;
> +       case UBLK_CMD_QUIESCE_DEV:
> +               ret = ublk_ctrl_quiesce_dev(ub, header);
> +               break;
>         default:
>                 ret = -EOPNOTSUPP;
>                 break;
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index 1c40632cb164..56c7e3fc666f 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -53,6 +53,8 @@
>         _IOR('u', 0x14, struct ublksrv_ctrl_cmd)
>  #define UBLK_U_CMD_UPDATE_SIZE         \
>         _IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
> +#define UBLK_U_CMD_QUIESCE_DEV         \
> +       _IOWR('u', 0x16, struct ublksrv_ctrl_cmd)
> 
>  /*
>   * 64bits are enough now, and it should be easy to extend in case of
> @@ -253,6 +255,23 @@
>   */
>  #define UBLK_F_AUTO_BUF_REG    (1ULL << 11)
> 
> +/*
> + * Control command `UBLK_U_CMD_QUIESCE_DEV` is added for quiescing device,
> + * which state can be transitioned to `UBLK_S_DEV_QUIESCED` or
> + * `UBLK_S_DEV_FAIL_IO` finally, and it needs ublk server cooperation for
> + * handling `UBLK_IO_RES_ABORT` correctly.
> + *
> + * Typical use case is for supporting to upgrade ublk server application,
> + * meantime keep ublk block device persistent during the period.
> + *
> + * This feature is only available when UBLK_F_USER_RECOVERY is enabled.
> + *
> + * Note, this command returns -EBUSY in case that all IO commands are being
> + * handled by ublk server and not completed in specified time period which
> + * is passed from the control command parameter.
> + */
> +#define UBLK_F_QUIESCE         (1ULL << 12)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
>  #define UBLK_S_DEV_LIVE        1
> --
> 2.47.0
> 

-- 
Ming

