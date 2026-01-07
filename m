Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9832C35580D
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796490; cv=none; b=OEyRJFmxbxRdz5Lqtr9opHkLUjRgVyMmCu8b9eqJ+QzeZRTzidTJybdv8pTUse2Wbt8I5sgNEXHpz0PbXu1n3T+tbW5gk+thpbcO88oNseAyGjtpniPhiGrHl2Oe/hsS1YBH4sTBt4iD8jiFy7cFo41C2ZcFIJ+1FVkDZijjGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796490; c=relaxed/simple;
	bh=pVwPvqVF/3OYGOmZa92dXmTH/hpbuXJOVfTNKdbisfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVFviuB5hrCF9tbiE2jTuMMYW8pY76hyzFnxT1yPFc7idQuJHOHXWe7QYzf7txY+CJgkWOYR2y4S1ZN4aPBqRuCNm0ErrbzREWvfRvzrpuxypQdsuO0lAYj6H2KkII3rGqgaiFMhICNKhDah8E+Bw1XESBKIpRn/orfZ5Lt+HCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASVLzJIq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASVLzJIq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767796487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lI3+ABR/UfQWX5OhdRiWYp8FwAK6DLQvYdlEjxwWtMM=;
	b=ASVLzJIqbrg92g11T6NIxrtjV9r+LL4+2luune2Hg04dENPApmGIpNCb3cx5gD4boQ2qqq
	eo/oLe8SEkhnzS86mjn/oN7d3sPtE6VkQdBf2PAmKerJ6KQBU4IqLIhrCqKCNkrHV5JRlk
	knAdaWmxM/P7sCB6WBSMHbyWhsN2+xs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-tXMKIhpgMdu8L-ApI7v0Zw-1; Wed,
 07 Jan 2026 09:34:46 -0500
X-MC-Unique: tXMKIhpgMdu8L-ApI7v0Zw-1
X-Mimecast-MFC-AGG-ID: tXMKIhpgMdu8L-ApI7v0Zw_1767796485
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0918C19541B5;
	Wed,  7 Jan 2026 14:34:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.199])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D06A30002D1;
	Wed,  7 Jan 2026 14:34:40 +0000 (UTC)
Date: Wed, 7 Jan 2026 22:34:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"csander@purestorage.com" <csander@purestorage.com>,
	Jared Holzman <jholzman@nvidia.com>, Omri Levi <omril@nvidia.com>
Subject: Re: [PATCH v4 2/2] ublk: add UBLK_CMD_TRY_STOP_DEV command
Message-ID: <aV5u_EkgS9hZJkT2@fedora>
References: <20260106203333.30589-1-yoav@nvidia.com>
 <20260106203333.30589-3-yoav@nvidia.com>
 <aV5djH9ueztZm49y@fedora>
 <d88b1705-e4e1-455e-89d4-1cc92fbd6921@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d88b1705-e4e1-455e-89d4-1cc92fbd6921@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Jan 07, 2026 at 01:34:49PM +0000, Yoav Cohen wrote:
> On 07/01/2026 15:20, Ming Lei wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tue, Jan 06, 2026 at 10:33:33PM +0200, Yoav Cohen wrote:
> >> This command is similar to UBLK_CMD_STOP_DEV, but it only stops the
> >> device if there are no active openers for the ublk block device.
> >> If the device is busy, the command returns -EBUSY instead of
> >> disrupting active clients. This allows safe, non-destructive stopping.
> >>
> >> Advertise UBLK_CMD_TRY_STOP_DEV support via UBLK_F_SAFE_STOP_DEV
> >> feature flag.
> >>
> >> Signed-off-by: Yoav Cohen <yoav@nvidia.com>
> >> ---
> >>   drivers/block/ublk_drv.c             | 44 ++++++++++++++++++++++++++--
> >>   include/uapi/linux/ublk_cmd.h        |  9 +++++-
> >>   tools/testing/selftests/ublk/kublk.c |  1 +
> >>   3 files changed, 51 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> >> index 2d5602ef05cc..fc8b87902f8f 100644
> >> --- a/drivers/block/ublk_drv.c
> >> +++ b/drivers/block/ublk_drv.c
> >> @@ -54,6 +54,7 @@
> >>   #define UBLK_CMD_DEL_DEV_ASYNC       _IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
> >>   #define UBLK_CMD_UPDATE_SIZE _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
> >>   #define UBLK_CMD_QUIESCE_DEV _IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
> >> +#define UBLK_CMD_TRY_STOP_DEV        _IOC_NR(UBLK_U_CMD_TRY_STOP_DEV)
> >>
> >>   #define UBLK_IO_REGISTER_IO_BUF              _IOC_NR(UBLK_U_IO_REGISTER_IO_BUF)
> >>   #define UBLK_IO_UNREGISTER_IO_BUF    _IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF)
> >> @@ -73,7 +74,8 @@
> >>                | UBLK_F_AUTO_BUF_REG \
> >>                | UBLK_F_QUIESCE \
> >>                | UBLK_F_PER_IO_DAEMON \
> >> -             | UBLK_F_BUF_REG_OFF_DAEMON)
> >> +             | UBLK_F_BUF_REG_OFF_DAEMON \
> >> +             | UBLK_F_SAFE_STOP_DEV)
> >>
> >>   #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> >>                | UBLK_F_USER_RECOVERY_REISSUE \
> >> @@ -239,6 +241,8 @@ struct ublk_device {
> >>        struct delayed_work     exit_work;
> >>        struct work_struct      partition_scan_work;
> >>
> >> +     bool                    block_open; /* protected by open_mutex */
> >> +
> >>        struct ublk_queue       *queues[];
> >>   };
> >>
> >> @@ -919,6 +923,9 @@ static int ublk_open(struct gendisk *disk, blk_mode_t mode)
> >>                        return -EPERM;
> >>        }
> >>
> >> +     if (ub->block_open)
> >> +             return -EBUSY;
> >> +
> >>        return 0;
> >>   }
> >>
> >> @@ -3188,7 +3195,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
> >>        ub->dev_info.flags |= UBLK_F_CMD_IOCTL_ENCODE |
> >>                UBLK_F_URING_CMD_COMP_IN_TASK |
> >>                UBLK_F_PER_IO_DAEMON |
> >> -             UBLK_F_BUF_REG_OFF_DAEMON;
> >> +             UBLK_F_BUF_REG_OFF_DAEMON |
> >> +             UBLK_F_SAFE_STOP_DEV;
> >>
> >>        /* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
> >>        if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
> >> @@ -3309,6 +3317,34 @@ static void ublk_ctrl_stop_dev(struct ublk_device *ub)
> >>        ublk_stop_dev(ub);
> >>   }
> >>
> >> +static int ublk_ctrl_try_stop_dev(struct ublk_device *ub)
> >> +{
> >> +     struct gendisk *disk;
> >> +     int ret = 0;
> >> +
> >> +     disk = ublk_get_disk(ub);
> >> +     if (!disk)
> >> +             return -ENODEV;
> >> +
> >> +     mutex_lock(&disk->open_mutex);
> >> +     if (disk_openers(disk) > 0) {
> >> +             ret = -EBUSY;
> >> +             goto unlock;
> >> +     }
> >> +     ub->block_open = true;
> >> +     /* release open_mutex as del_gendisk() will reacquire it */
> >> +     mutex_unlock(&disk->open_mutex);
> >> +
> >> +     ublk_ctrl_stop_dev(ub);
> >> +     goto out;
> >> +
> >> +unlock:
> >> +     mutex_unlock(&disk->open_mutex);
> >> +out:
> >> +     ublk_put_disk(disk);
> >> +     return ret;
> >> +}
> >> +
> >>   static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
> >>                const struct ublksrv_ctrl_cmd *header)
> >>   {
> >> @@ -3704,6 +3740,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
> >>        case UBLK_CMD_END_USER_RECOVERY:
> >>        case UBLK_CMD_UPDATE_SIZE:
> >>        case UBLK_CMD_QUIESCE_DEV:
> >> +     case UBLK_CMD_TRY_STOP_DEV:
> >>                mask = MAY_READ | MAY_WRITE;
> >>                break;
> >>        default:
> >> @@ -3817,6 +3854,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
> >>        case UBLK_CMD_QUIESCE_DEV:
> >>                ret = ublk_ctrl_quiesce_dev(ub, header);
> >>                break;
> >> +     case UBLK_CMD_TRY_STOP_DEV:
> >> +             ret = ublk_ctrl_try_stop_dev(ub);
> >> +             break;
> >>        default:
> >>                ret = -EOPNOTSUPP;
> >>                break;
> >> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> >> index ec77dabba45b..9daa8ab372f0 100644
> >> --- a/include/uapi/linux/ublk_cmd.h
> >> +++ b/include/uapi/linux/ublk_cmd.h
> >> @@ -55,7 +55,8 @@
> >>        _IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
> >>   #define UBLK_U_CMD_QUIESCE_DEV               \
> >>        _IOWR('u', 0x16, struct ublksrv_ctrl_cmd)
> >> -
> >> +#define UBLK_U_CMD_TRY_STOP_DEV              \
> >> +     _IOWR('u', 0x17, struct ublksrv_ctrl_cmd)
> >>   /*
> >>    * 64bits are enough now, and it should be easy to extend in case of
> >>    * running out of feature flags
> >> @@ -311,6 +312,12 @@
> >>    */
> >>   #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
> >>
> >> +/*
> >> + * The device supports the UBLK_CMD_TRY_STOP_DEV command, which
> >> + * allows stopping the device only if there are no openers.
> >> + */
> >> +#define UBLK_F_SAFE_STOP_DEV (1ULL << 17)
> >> +
> >>   /* device state */
> >>   #define UBLK_S_DEV_DEAD      0
> >>   #define UBLK_S_DEV_LIVE      1
> >> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> >> index 185ba553686a..6739e28c4059 100644
> >> --- a/tools/testing/selftests/ublk/kublk.c
> >> +++ b/tools/testing/selftests/ublk/kublk.c
> >> @@ -1454,6 +1454,7 @@ static int cmd_dev_get_features(void)
> >>                FEAT_NAME(UBLK_F_QUIESCE),
> >>                FEAT_NAME(UBLK_F_PER_IO_DAEMON),
> >>                FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
> >> +             FEAT_NAME(UBLK_F_SAFE_STOP_DEV),
> > 
> > We usually split driver and test code into different patches, and the patch
> > looks fine:
> > 
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > 
> > But we usually separate test code from driver change, also new feature needs
> > selftest code for verifying, can you move `+FEAT_NAME(UBLK_F_SAFE_STOP_DEV)` into
> > the attached selftest patch and post all 3 in v5?
> > 
> > 
> > 
> > Thanks,
> > Ming
> 
> Hi,
> 
> Thank you Ming, just to be sure:
> I'll split the kublk change to a 3rd patch - that's ok.
> But do you also want me to write a selftest for this feature as part of 
> the 3rd patch?

The 3rd patch has included one complete test case, but feel free to
fix/improve, or even rewrite it if you think it isn't good.


Thanks,
Ming

