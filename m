Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EB820458A
	for <linux-block@vger.kernel.org>; Sun,  7 Dec 2025 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765115927; cv=none; b=b9YyR7tkvgdf39Ml6PX3eVHrUJ/J1QxVfTOvc2A0cHDYQPfMY04iLHqHiO0/f24Z+Ph5QMZ+FY1kOncw2fTTnspbSfYV+ct/4+zgbmONdX7fl3bN/GZ/pN51uzXjW0z5pw5WFktUDNNzoKGs8ALf8EWg4sW71zhhNuh3QSAb+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765115927; c=relaxed/simple;
	bh=Sp+7jZQ1la/KbwbrjCu1gAiE8XWswtO7JIYHdRyxxQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu8UctDsIGhzJ+96s14f2gfsuJtF+vWgyYpk73iCDSbnlkJa4gjQquDGzxepTeabCMyc3Q2P2B1GPvBeKt7U6Wwd/3YlO5tW2R24tA7pFccBPJmF4Z+Ithkko2xiamflRVZAs73xdIU7RyHHG6DHoM05wOPO/VgGTxZlgVC4QP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqrqeW01; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqrqeW01"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765115924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/IUAYGrNRWE4XL2OgW5PPUIQUheLLk+CAzA59AzMDg=;
	b=NqrqeW01poN5tXy+CNxAI0CSB/09mdkN1N8+bSbeLAf4gG9wr31JxNncp8EdwRK1ufeyHv
	UD1ctZgQM2qqfPohK7zIqHMSZKHUZXdQcjY4yhapwK/6I9TF/fE3X/SIeI7KOpPFdgfi3a
	d+XXd1EVIvb2xGfxejzukdQ/V8qH05M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685--wBmSFdfPeCIeX1UzphO3g-1; Sun,
 07 Dec 2025 08:58:41 -0500
X-MC-Unique: -wBmSFdfPeCIeX1UzphO3g-1
X-Mimecast-MFC-AGG-ID: -wBmSFdfPeCIeX1UzphO3g_1765115920
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1898E1956053;
	Sun,  7 Dec 2025 13:58:40 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6DD81800576;
	Sun,  7 Dec 2025 13:58:30 +0000 (UTC)
Date: Sun, 7 Dec 2025 21:58:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V5 10/21] ublk: add new feature UBLK_F_BATCH_IO
Message-ID: <aTWH_37UUY5zLvJu@fedora>
References: <20251202121917.1412280-1-ming.lei@redhat.com>
 <20251202121917.1412280-11-ming.lei@redhat.com>
 <CADUfDZpN+QWKzhRnS9y1Hvn-jgQ2kd+6GxX5YyNU8gi4sCmpaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpN+QWKzhRnS9y1Hvn-jgQ2kd+6GxX5YyNU8gi4sCmpaA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sun, Dec 07, 2025 at 12:16:35AM -0800, Caleb Sander Mateos wrote:
> On Tue, Dec 2, 2025 at 4:21 AM Ming Lei <ming.lei@redhat.com> wrote:
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
> > UBLK_U_IO_NEED_GET_DATA isn't supported in batch io yet, but it may be
> > enabled in future via its batch pair.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 53 +++++++++++++++++++++++++++++------
> >  include/uapi/linux/ublk_cmd.h | 16 +++++++++++
> >  2 files changed, 61 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 3865edabe1e6..034420e8df55 100644
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
> > @@ -331,12 +332,12 @@ static void ublk_batch_dispatch(struct ublk_queue *ubq,
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
> > @@ -3462,6 +3463,35 @@ static int ublk_validate_batch_fetch_cmd(struct ublk_batch_io_data *data,
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
> > +
> > +       if (cmd->cmd_op == UBLK_U_IO_UNREGISTER_IO_BUF)
> > +               return ublk_unregister_io_buf(cmd, ub, index, issue_flags);
> > +
> > +       if (q_id >= ub->dev_info.nr_hw_queues)
> > +               return -EINVAL;
> > +
> > +       if (tag >= ub->dev_info.queue_depth)
> > +               return -EINVAL;
> > +
> > +       if (cmd->cmd_op != UBLK_U_IO_REGISTER_IO_BUF)
> > +               return -EOPNOTSUPP;
> > +
> > +       ubq = ublk_get_queue(ub, q_id);
> > +       io = &ubq->ios[tag];
> > +       return ublk_register_io_buf(cmd, ub, q_id, tag, io, index,
> > +                       issue_flags);
> > +}
> > +
> >  static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
> >                                        unsigned int issue_flags)
> >  {
> > @@ -3509,7 +3539,8 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
> >                 ret = ublk_handle_batch_fetch_cmd(&data);
> >                 break;
> >         default:
> > -               ret = -EOPNOTSUPP;
> > +               ret = ublk_handle_non_batch_cmd(cmd, issue_flags);
> 
> It looks like the non-batch commands still perform the if
> (data.header.q_id >= ub->dev_info.nr_hw_queues) check in
> ublk_ch_batch_io_uring_cmd() even though they use struct
> ublksrv_io_cmd instead of struct ublk_batch_io. I think it would be
> preferable to move that check to ublk_check_batch_cmd() and
> ublk_handle_batch_fetch_cmd().

Yes, will fix it in next version.

> 
> > +               break;
> >         }
> >  out:
> >         return ret;
> > @@ -4179,10 +4210,9 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
> >          */
> >         ub->dev_info.flags &= UBLK_F_ALL;
> >
> > -       ub->dev_info.flags |= UBLK_F_CMD_IOCTL_ENCODE |
> > -               UBLK_F_URING_CMD_COMP_IN_TASK |
> > -               UBLK_F_PER_IO_DAEMON |
> > -               UBLK_F_BUF_REG_OFF_DAEMON;
> 
> Why are these reported features removed? This will break ublk servers
> that check for these features in the ublk device flags.

oops, it is really one accident.


Thanks,
Ming

