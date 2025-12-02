Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C508B1494C2
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 01:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639891; cv=none; b=S76Mqdb+QPUYTfQLq+nE2ttXwLWP4hGK9cuReWyB5zrTkVg0AcoK7G0ytcz+eKnuiDq2r4TcNNsnHk2/0LIOmbPCFvxUV2D6Hnk8O9AuSBboOhkKTBYco6EGFXwpV5q6wMasht1MWAJKLbxidfBRPDnDQN71QdBOj+4vTg6pbk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639891; c=relaxed/simple;
	bh=Vtck3mDRJocROVloJdkyRuDEA6QYSBaZTFTADAt18U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S32NtD1/Jx06dFZEU46HOu/yYQ4Ew/hBwGNIp/+VHrt/+o5KvZxucSCgz55kvr9Q98zpFQJ113bpDVuovqtUxaZCCSwTXeHfS4QJF9JNpmdhKFdIBZUBWto/lQNA+iuk+lnHj2duaRE+mtH+UdDa/7Im7FIoSRn7Edl4W/b+dWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EwyKWyIe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwyKWyIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764639888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bU2TPx1G6M30i6WlyoyrTR14gjKlPP0N0nC829WmHZc=;
	b=EwyKWyIeH/S3WBCKHntFeVOizEt8qSlSK+OZPKFPk5JZrM7lvKJM/TlWWLUyi2rzaqV253
	7vdegx/dGde32Ks4ui/L1xYTehtCb2yQDBi3eDSHzO459z9ZGYjgjsr8hxP4I2C+dKYfth
	+k045YOMyx5NyrLPHNx7idM7b6+PtIA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-jfA1qgB0Me2eygrw6PRYnw-1; Mon,
 01 Dec 2025 20:44:45 -0500
X-MC-Unique: jfA1qgB0Me2eygrw6PRYnw-1
X-Mimecast-MFC-AGG-ID: jfA1qgB0Me2eygrw6PRYnw_1764639884
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABE0F180045C;
	Tue,  2 Dec 2025 01:44:43 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD24219560A7;
	Tue,  2 Dec 2025 01:44:38 +0000 (UTC)
Date: Tue, 2 Dec 2025 09:44:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 16/27] ublk: add new feature UBLK_F_BATCH_IO
Message-ID: <aS5EgbJQFa2fm6GR@fedora>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
 <20251121015851.3672073-17-ming.lei@redhat.com>
 <CADUfDZoXKATH_nQ0TEqj6BrN+e-Shkd11CUJaJJ_FKbrTrv=GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoXKATH_nQ0TEqj6BrN+e-Shkd11CUJaJJ_FKbrTrv=GQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Dec 01, 2025 at 01:16:04PM -0800, Caleb Sander Mateos wrote:
> On Thu, Nov 20, 2025 at 6:00 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add new feature UBLK_F_BATCH_IO which replaces the following two
> > per-io commands:
> >
> >         - UBLK_U_IO_FETCH_REQ
> >
> >         - UBLK_U_IO_COMMIT_AND_FETCH_REQ
> >
> > with three per-queue batch io uring_cmd:
> >
> >         - UBLK_U_IO_PREP_IO_CMDS
> >
> >         - UBLK_U_IO_COMMIT_IO_CMDS
> >
> >         - UBLK_U_IO_FETCH_IO_CMDS
> >
> > Then ublk can deliver batch io commands to ublk server in single
> > multishort uring_cmd, also allows to prepare & commit multiple
> > commands in batch style via single uring_cmd, communication cost is
> > reduced a lot.
> >
> > This feature also doesn't limit task context any more for all supported
> > commands, so any allowed uring_cmd can be issued in any task context.
> > ublk server implementation becomes much easier.
> >
> > Meantime load balance becomes much easier to support with this feature.
> > The command `UBLK_U_IO_FETCH_IO_CMDS` can be issued from multiple task
> > contexts, so each task can adjust this command's buffer length or number
> > of inflight commands for controlling how much load is handled by current
> > task.
> >
> > Later, priority parameter will be added to command `UBLK_U_IO_FETCH_IO_CMDS`
> > for improving load balance support.
> >
> > UBLK_U_IO_GET_DATA isn't supported in batch io yet, but it may be
> 
> UBLK_U_IO_NEED_GET_DATA?

Yeah.

> 
> > enabled in future via its batch pair.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 58 ++++++++++++++++++++++++++++++++---
> >  include/uapi/linux/ublk_cmd.h | 16 ++++++++++
> >  2 files changed, 69 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 849199771f86..90cd1863bc83 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -74,7 +74,8 @@
> >                 | UBLK_F_AUTO_BUF_REG \
> >                 | UBLK_F_QUIESCE \
> >                 | UBLK_F_PER_IO_DAEMON \
> > -               | UBLK_F_BUF_REG_OFF_DAEMON)
> > +               | UBLK_F_BUF_REG_OFF_DAEMON \
> > +               | UBLK_F_BATCH_IO)
> >
> >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> >                 | UBLK_F_USER_RECOVERY_REISSUE \
> > @@ -320,12 +321,12 @@ static void ublk_batch_dispatch(struct ublk_queue *ubq,
> >
> >  static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
> >  {
> > -       return false;
> > +       return ub->dev_info.flags & UBLK_F_BATCH_IO;
> >  }
> >
> >  static inline bool ublk_support_batch_io(const struct ublk_queue *ubq)
> >  {
> > -       return false;
> > +       return ubq->flags & UBLK_F_BATCH_IO;
> >  }
> >
> >  static inline void ublk_io_lock(struct ublk_io *io)
> > @@ -3450,6 +3451,41 @@ static int ublk_validate_batch_fetch_cmd(struct ublk_batch_io_data *data,
> >         return 0;
> >  }
> >
> > +static int ublk_handle_non_batch_cmd(struct io_uring_cmd *cmd,
> > +                                    unsigned int issue_flags)
> > +{
> > +       const struct ublksrv_io_cmd *ub_cmd = io_uring_sqe_cmd(cmd->sqe);
> > +       struct ublk_device *ub = cmd->file->private_data;
> > +       unsigned tag = READ_ONCE(ub_cmd->tag);
> > +       unsigned q_id = READ_ONCE(ub_cmd->q_id);
> > +       unsigned index = READ_ONCE(ub_cmd->addr);
> > +       struct ublk_queue *ubq;
> > +       struct ublk_io *io;
> > +       int ret = -EINVAL;
> 
> I think it would be clearer to just return -EINVAL instead of adding
> this variable, but up to you
> 
> > +
> > +       if (!ub)
> > +               return ret;
> 
> How is this case possible?

Will remove the check.

> 
> > +
> > +       if (q_id >= ub->dev_info.nr_hw_queues)
> > +               return ret;
> > +
> > +       ubq = ublk_get_queue(ub, q_id);
> > +       if (tag >= ubq->q_depth)
> 
> Can avoid the likely cache miss here by using ub->dev_info.queue_depth
> instead, analogous to ublk_ch_uring_cmd_local()

OK.

> 
> > +               return ret;
> > +
> > +       io = &ubq->ios[tag];
> > +
> > +       switch (cmd->cmd_op) {
> > +       case UBLK_U_IO_REGISTER_IO_BUF:
> > +               return ublk_register_io_buf(cmd, ub, q_id, tag, io, index,
> > +                               issue_flags);
> > +       case UBLK_U_IO_UNREGISTER_IO_BUF:
> > +               return ublk_unregister_io_buf(cmd, ub, index, issue_flags);
> > +       default:
> > +               return -EOPNOTSUPP;
> > +       }
> > +}
> > +
> >  static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
> >                                        unsigned int issue_flags)
> >  {
> > @@ -3497,7 +3533,8 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
> >                 ret = ublk_handle_batch_fetch_cmd(&data);
> >                 break;
> >         default:
> > -               ret = -EOPNOTSUPP;
> > +               ret = ublk_handle_non_batch_cmd(cmd, issue_flags);
> 
> We should probably skip the if (data.header.q_id >=
> ub->dev_info.nr_hw_queues) check for a non-batch command?

It is true only for UBLK_IO_UNREGISTER_IO_BUF.

> 
> > +               break;
> >         }
> >  out:
> >         return ret;
> > @@ -4163,9 +4200,13 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
> >
> >         ub->dev_info.flags |= UBLK_F_CMD_IOCTL_ENCODE |
> >                 UBLK_F_URING_CMD_COMP_IN_TASK |
> > -               UBLK_F_PER_IO_DAEMON |
> > +               (ublk_dev_support_batch_io(ub) ? 0 : UBLK_F_PER_IO_DAEMON) |
> 
> Seems redundant with the logic below to clear UBLK_F_PER_IO_DAEMON if
> (ublk_dev_support_batch_io(ub))?

Good catch.

> 
> >                 UBLK_F_BUF_REG_OFF_DAEMON;
> >
> > +       /* So far, UBLK_F_PER_IO_DAEMON won't be exposed for BATCH_IO */
> > +       if (ublk_dev_support_batch_io(ub))
> > +               ub->dev_info.flags &= ~UBLK_F_PER_IO_DAEMON;
> > +
> >         /* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
> >         if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
> >                                 UBLK_F_AUTO_BUF_REG))
> > @@ -4518,6 +4559,13 @@ static int ublk_wait_for_idle_io(struct ublk_device *ub,
> >         unsigned int elapsed = 0;
> >         int ret;
> >
> > +       /*
> > +        * For UBLK_F_BATCH_IO ublk server can get notified with existing
> > +        * or new fetch command, so needn't wait any more
> > +        */
> > +       if (ublk_dev_support_batch_io(ub))
> > +               return 0;
> > +
> >         while (elapsed < timeout_ms && !signal_pending(current)) {
> >                 unsigned int queues_cancelable = 0;
> >                 int i;
> > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> > index cd894c1d188e..5e8b1211b7f4 100644
> > --- a/include/uapi/linux/ublk_cmd.h
> > +++ b/include/uapi/linux/ublk_cmd.h
> > @@ -335,6 +335,22 @@
> >   */
> >  #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
> >
> > +
> > +/*
> > + * Support the following commands for delivering & committing io command
> > + * in batch.
> > + *
> > + *     - UBLK_U_IO_PREP_IO_CMDS
> > + *     - UBLK_U_IO_COMMIT_IO_CMDS
> > + *     - UBLK_U_IO_FETCH_IO_CMDS
> > + *     - UBLK_U_IO_REGISTER_IO_BUF
> > + *     - UBLK_U_IO_UNREGISTER_IO_BUF
> 
> Seems like it might make sense to provided batched versions of
> UBLK_U_IO_REGISTER_IO_BUF and UBLK_U_IO_UNREGISTER_IO_BUF. That could
> be done in the future, I guess, but it might simplify
> ublk_ch_batch_io_uring_cmd() to only have to handle struct
> ublk_batch_io.

Agree, and it can be added in future.




Thanks,
Ming

