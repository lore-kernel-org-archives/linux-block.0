Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A86722CBC0
	for <linux-block@vger.kernel.org>; Wed,  3 Dec 2025 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764728520; cv=none; b=Q9of0QPjnx8VhVkZXyXdIZ4cF8HyAS1C4PHZge7VrtIMqLRjljxoQR4NG21T8xlPa6IiU5eXxZoBkKbp3KmcNu8M8QYA3nMva1s1vlCcXeAkUgORjzbpidkJEuUoM+t334x7CQTYc6bXe7iSoJCG7Fb/M+rbEBy/LDwKL0vJLV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764728520; c=relaxed/simple;
	bh=lX7krLrYeW62fvJTJqXel1TOGcfzbtPALwT8ddSg9Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEoyBwSNQouP9OTAeQCR4oHXeyujzK9z3f06j9pIj1zwGTlsg8PztWSQiOJzQh0C71Hql3jgll65pzUeac3fxoQ8+cryit15/PLDzN6ellPqfJa0BHRvWEcFukbej3A6N7AGLcBx7uMj6GUEPx06LSAiKD21F6rjTW6KStKB2AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9WWtAnC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9WWtAnC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764728516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfB2uZsQEd1yMEgRnUcfGl3vHtAWfdtHqQECJ71veEs=;
	b=D9WWtAnCz+at0bF486NmxHnVWZtjdrtpljdesn4rTFvvK+/TsweKJ/cMyIOFcNW+YNxDOR
	0XqooX3aoQuoxq8Eqs9n1Y83FX5BQrNGokjIg67wDk0sQPvcEKOECJdME8VEpfiN7PvScL
	/a9bqlvwm+xlkxfbkmFtHDsplnI18Ao=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-2eyl1k3JPyWu12P2D83i8Q-1; Tue,
 02 Dec 2025 21:21:51 -0500
X-MC-Unique: 2eyl1k3JPyWu12P2D83i8Q-1
X-Mimecast-MFC-AGG-ID: 2eyl1k3JPyWu12P2D83i8Q_1764728510
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B58BF180048E;
	Wed,  3 Dec 2025 02:21:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3A6C1800947;
	Wed,  3 Dec 2025 02:21:44 +0000 (UTC)
Date: Wed, 3 Dec 2025 10:21:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 16/27] ublk: add new feature UBLK_F_BATCH_IO
Message-ID: <aS-es2I_f6d_H_C9@fedora>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
 <20251121015851.3672073-17-ming.lei@redhat.com>
 <CADUfDZoXKATH_nQ0TEqj6BrN+e-Shkd11CUJaJJ_FKbrTrv=GQ@mail.gmail.com>
 <aS5EgbJQFa2fm6GR@fedora>
 <CADUfDZqRQ3WmwswwfQf_vhP84OVmwU3LGMF8Rb8mShQSjnZAJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqRQ3WmwswwfQf_vhP84OVmwU3LGMF8Rb8mShQSjnZAJQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Dec 02, 2025 at 08:05:17AM -0800, Caleb Sander Mateos wrote:
> On Mon, Dec 1, 2025 at 5:44 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Mon, Dec 01, 2025 at 01:16:04PM -0800, Caleb Sander Mateos wrote:
> > > On Thu, Nov 20, 2025 at 6:00 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > Add new feature UBLK_F_BATCH_IO which replaces the following two
> > > > per-io commands:
> > > >
> > > >         - UBLK_U_IO_FETCH_REQ
> > > >
> > > >         - UBLK_U_IO_COMMIT_AND_FETCH_REQ
> > > >
> > > > with three per-queue batch io uring_cmd:
> > > >
> > > >         - UBLK_U_IO_PREP_IO_CMDS
> > > >
> > > >         - UBLK_U_IO_COMMIT_IO_CMDS
> > > >
> > > >         - UBLK_U_IO_FETCH_IO_CMDS
> > > >
> > > > Then ublk can deliver batch io commands to ublk server in single
> > > > multishort uring_cmd, also allows to prepare & commit multiple
> > > > commands in batch style via single uring_cmd, communication cost is
> > > > reduced a lot.
> > > >
> > > > This feature also doesn't limit task context any more for all supported
> > > > commands, so any allowed uring_cmd can be issued in any task context.
> > > > ublk server implementation becomes much easier.
> > > >
> > > > Meantime load balance becomes much easier to support with this feature.
> > > > The command `UBLK_U_IO_FETCH_IO_CMDS` can be issued from multiple task
> > > > contexts, so each task can adjust this command's buffer length or number
> > > > of inflight commands for controlling how much load is handled by current
> > > > task.
> > > >
> > > > Later, priority parameter will be added to command `UBLK_U_IO_FETCH_IO_CMDS`
> > > > for improving load balance support.
> > > >
> > > > UBLK_U_IO_GET_DATA isn't supported in batch io yet, but it may be
> > >
> > > UBLK_U_IO_NEED_GET_DATA?
> >
> > Yeah.
> >
> > >
> > > > enabled in future via its batch pair.
> > > >
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c      | 58 ++++++++++++++++++++++++++++++++---
> > > >  include/uapi/linux/ublk_cmd.h | 16 ++++++++++
> > > >  2 files changed, 69 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index 849199771f86..90cd1863bc83 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -74,7 +74,8 @@
> > > >                 | UBLK_F_AUTO_BUF_REG \
> > > >                 | UBLK_F_QUIESCE \
> > > >                 | UBLK_F_PER_IO_DAEMON \
> > > > -               | UBLK_F_BUF_REG_OFF_DAEMON)
> > > > +               | UBLK_F_BUF_REG_OFF_DAEMON \
> > > > +               | UBLK_F_BATCH_IO)
> > > >
> > > >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> > > >                 | UBLK_F_USER_RECOVERY_REISSUE \
> > > > @@ -320,12 +321,12 @@ static void ublk_batch_dispatch(struct ublk_queue *ubq,
> > > >
> > > >  static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
> > > >  {
> > > > -       return false;
> > > > +       return ub->dev_info.flags & UBLK_F_BATCH_IO;
> > > >  }
> > > >
> > > >  static inline bool ublk_support_batch_io(const struct ublk_queue *ubq)
> > > >  {
> > > > -       return false;
> > > > +       return ubq->flags & UBLK_F_BATCH_IO;
> > > >  }
> > > >
> > > >  static inline void ublk_io_lock(struct ublk_io *io)
> > > > @@ -3450,6 +3451,41 @@ static int ublk_validate_batch_fetch_cmd(struct ublk_batch_io_data *data,
> > > >         return 0;
> > > >  }
> > > >
> > > > +static int ublk_handle_non_batch_cmd(struct io_uring_cmd *cmd,
> > > > +                                    unsigned int issue_flags)
> > > > +{
> > > > +       const struct ublksrv_io_cmd *ub_cmd = io_uring_sqe_cmd(cmd->sqe);
> > > > +       struct ublk_device *ub = cmd->file->private_data;
> > > > +       unsigned tag = READ_ONCE(ub_cmd->tag);
> > > > +       unsigned q_id = READ_ONCE(ub_cmd->q_id);
> > > > +       unsigned index = READ_ONCE(ub_cmd->addr);
> > > > +       struct ublk_queue *ubq;
> > > > +       struct ublk_io *io;
> > > > +       int ret = -EINVAL;
> > >
> > > I think it would be clearer to just return -EINVAL instead of adding
> > > this variable, but up to you
> > >
> > > > +
> > > > +       if (!ub)
> > > > +               return ret;
> > >
> > > How is this case possible?
> >
> > Will remove the check.
> >
> > >
> > > > +
> > > > +       if (q_id >= ub->dev_info.nr_hw_queues)
> > > > +               return ret;
> > > > +
> > > > +       ubq = ublk_get_queue(ub, q_id);
> > > > +       if (tag >= ubq->q_depth)
> > >
> > > Can avoid the likely cache miss here by using ub->dev_info.queue_depth
> > > instead, analogous to ublk_ch_uring_cmd_local()
> >
> > OK.
> >
> > >
> > > > +               return ret;
> > > > +
> > > > +       io = &ubq->ios[tag];
> > > > +
> > > > +       switch (cmd->cmd_op) {
> > > > +       case UBLK_U_IO_REGISTER_IO_BUF:
> > > > +               return ublk_register_io_buf(cmd, ub, q_id, tag, io, index,
> > > > +                               issue_flags);
> > > > +       case UBLK_U_IO_UNREGISTER_IO_BUF:
> > > > +               return ublk_unregister_io_buf(cmd, ub, index, issue_flags);
> > > > +       default:
> > > > +               return -EOPNOTSUPP;
> > > > +       }
> > > > +}
> > > > +
> > > >  static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
> > > >                                        unsigned int issue_flags)
> > > >  {
> > > > @@ -3497,7 +3533,8 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
> > > >                 ret = ublk_handle_batch_fetch_cmd(&data);
> > > >                 break;
> > > >         default:
> > > > -               ret = -EOPNOTSUPP;
> > > > +               ret = ublk_handle_non_batch_cmd(cmd, issue_flags);
> > >
> > > We should probably skip the if (data.header.q_id >=
> > > ub->dev_info.nr_hw_queues) check for a non-batch command?
> >
> > It is true only for UBLK_IO_UNREGISTER_IO_BUF.
> 
> My point was that this relies on the q_id field being located at the
> same offset in struct ublksrv_io_cmd and struct ublk_batch_io, which
> seems quite subtle. I think it would make more sense not to read the
> SQE as a struct ublk_batch_io for the non-batch commands.

OK, got it, then the check can be moved to ublk_check_batch_cmd() and
ublk_validate_batch_fetch_cmd(). It can be one delta fix for V5.


Thanks,
Ming

