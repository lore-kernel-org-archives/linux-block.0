Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6573010A3E
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 01:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749519294; cv=none; b=bppiNQan9RIOwRQOBnehhUX01chOU03dcY4gVMiqk8YnbMQS3WOiMxldmrDtBuFZQ2FRQOU3HsQE9c3XR6JHWu4RrCkiZBA3k+yQYX9ckftxKgwBK7ou5uJsXnMtji0hLbOfk+7y9D+HRo137o2xVy/DNkX5TdtDAoRQZFzUIXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749519294; c=relaxed/simple;
	bh=401ZAR323MnIgx6xO+7MeVf3FGCWJMIn7tzpsJMeXOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD71dfbZoPothVl53P7ZcSF2kGEV4OD6GIACAadDj+2FqZjzl8UNLD0somJ+rN6wzDnRLbXH3lLuR5QYZZWJ84JjrY+o41CUeTwcG8bSc+pdY59p00U5LOX6InEGjEgl9+brrwFF65aHrrVxCS2cABCO5H8hHjj2niGr4IQwf3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xas7FRp1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xas7FRp1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749519291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgeNfW3g2OHhfWW0iOwNE6tBc9IhpaO3w3EEGlZCC6Y=;
	b=Xas7FRp1WjcjCpHpL9EV/lxwutZin5rEpxbBH+enLWrJq1gPT/9sOSuf47MvdWH/JSWsTU
	xPzmLqgVC7E5jeiHQISvTwWfuJ9Fzl6luQGD+W547N7BQZnErqfZOYI68lWQ7BzfjVSRse
	H9RvPs4BET/BLfNRjH7r8u4GZJU/yFE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-UQ8vEucJMzi91kBxxxOz-g-1; Mon,
 09 Jun 2025 21:34:49 -0400
X-MC-Unique: UQ8vEucJMzi91kBxxxOz-g-1
X-Mimecast-MFC-AGG-ID: UQ8vEucJMzi91kBxxxOz-g_1749519288
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8145A1808985;
	Tue, 10 Jun 2025 01:34:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF8211800287;
	Tue, 10 Jun 2025 01:34:45 +0000 (UTC)
Date: Tue, 10 Jun 2025 09:34:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 6/8] ublk: allow UBLK_IO_(UN)REGISTER_IO_BUF on any task
Message-ID: <aEeLsEHxZV_Xs7yC@fedora>
References: <20250606214011.2576398-1-csander@purestorage.com>
 <20250606214011.2576398-7-csander@purestorage.com>
 <aEbUx51iu6oMkPB7@fedora>
 <CADUfDZoCCFs6ZKwxDrgsHGTiCgyehS1uODu+iDmz1+5_k7tLbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoCCFs6ZKwxDrgsHGTiCgyehS1uODu+iDmz1+5_k7tLbw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Jun 09, 2025 at 10:49:09AM -0700, Caleb Sander Mateos wrote:
> On Mon, Jun 9, 2025 at 5:34 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Fri, Jun 06, 2025 at 03:40:09PM -0600, Caleb Sander Mateos wrote:
> > > Currently, UBLK_IO_REGISTER_IO_BUF and UBLK_IO_UNREGISTER_IO_BUF are
> > > only permitted on the ublk_io's daemon task. But this restriction is
> > > unnecessary. ublk_register_io_buf() calls __ublk_check_and_get_req() to
> > > look up the request from the tagset and atomically take a reference on
> > > the request without accessing the ublk_io. ublk_unregister_io_buf()
> > > doesn't use the q_id or tag at all.
> > >
> > > So allow these opcodes even on tasks other than io->task.
> > >
> > > Handle UBLK_IO_UNREGISTER_IO_BUF before obtaining the ubq and io since
> > > the buffer index being unregistered is not necessarily related to the
> > > specified q_id and tag.
> > >
> > > Add a feature flag UBLK_F_BUF_REG_OFF_DAEMON that userspace can use to
> > > determine whether the kernel supports off-daemon buffer registration.
> > >
> > > Suggested-by: Ming Lei <ming.lei@redhat.com>
> > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 37 +++++++++++++++++++++--------------
> > >  include/uapi/linux/ublk_cmd.h |  8 ++++++++
> > >  2 files changed, 30 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index a8030818f74a..2084bbdd2cbb 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -68,11 +68,12 @@
> > >               | UBLK_F_ZONED \
> > >               | UBLK_F_USER_RECOVERY_FAIL_IO \
> > >               | UBLK_F_UPDATE_SIZE \
> > >               | UBLK_F_AUTO_BUF_REG \
> > >               | UBLK_F_QUIESCE \
> > > -             | UBLK_F_PER_IO_DAEMON)
> > > +             | UBLK_F_PER_IO_DAEMON \
> > > +             | UBLK_F_BUF_REG_OFF_DAEMON)
> > >
> > >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> > >               | UBLK_F_USER_RECOVERY_REISSUE \
> > >               | UBLK_F_USER_RECOVERY_FAIL_IO)
> > >
> > > @@ -2018,20 +2019,10 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
> > >       }
> > >
> > >       return 0;
> > >  }
> > >
> > > -static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
> > > -                               const struct ublk_queue *ubq,
> > > -                               unsigned int index, unsigned int issue_flags)
> > > -{
> > > -     if (!ublk_support_zero_copy(ubq))
> > > -             return -EINVAL;
> > > -
> > > -     return io_buffer_unregister_bvec(cmd, index, issue_flags);
> > > -}
> > > -
> > >  static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
> > >                     struct ublk_io *io, __u64 buf_addr)
> > >  {
> > >       struct ublk_device *ub = ubq->dev;
> > >       int ret = 0;
> > > @@ -2184,10 +2175,18 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
> > >
> > >       ret = ublk_check_cmd_op(cmd_op);
> > >       if (ret)
> > >               goto out;
> > >
> > > +     /*
> > > +      * io_buffer_unregister_bvec() doesn't access the ubq or io,
> > > +      * so no need to validate the q_id, tag, or task
> > > +      */
> > > +     if (_IOC_NR(cmd_op) == UBLK_IO_UNREGISTER_IO_BUF)
> > > +             return io_buffer_unregister_bvec(cmd, ub_cmd->addr,
> > > +                                              issue_flags);
> > > +
> > >       ret = -EINVAL;
> > >       if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
> > >               goto out;
> > >
> > >       ubq = ublk_get_queue(ub, ub_cmd->q_id);
> > > @@ -2204,12 +2203,21 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
> > >
> > >               ublk_prep_cancel(cmd, issue_flags, ubq, tag);
> > >               return -EIOCBQUEUED;
> > >       }
> > >
> > > -     if (READ_ONCE(io->task) != current)
> > > +     if (READ_ONCE(io->task) != current) {
> > > +             /*
> > > +              * ublk_register_io_buf() accesses only the request, not io,
> > > +              * so can be handled on any task
> > > +              */
> > > +             if (_IOC_NR(cmd_op) == UBLK_IO_REGISTER_IO_BUF)
> > > +                     return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr,
> > > +                                                 issue_flags);
> > > +
> > >               goto out;
> > > +     }
> > >
> > >       /* there is pending io cmd, something must be wrong */
> > >       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)) {
> > >               ret = -EBUSY;
> >
> > It also skips check on UBLK_IO_FLAG_OWNED_BY_SRV for both UBLK_IO_REGISTER_IO_BUF
> > and UBLK_IO_UNREGISTER_IO_BUF, :-(
> 
> As we've discussed before[1], accessing io->flags on tasks other than
> the io's daemon would be a race condition. So I don't see how it's
> possible to keep this check for off-daemon
> UBLK_IO_(UN)REGISTER_IO_BUF. What value do you see in checking for
> UBLK_IO_FLAG_OWNED_BY_SRV? My understanding is that the
> refcount_inc_not_zero() already ensures the ublk I/O has been
> dispatched to the ublk server and either hasn't been completed or has
> other registered buffers still in use, which is pretty similar to
> UBLK_IO_FLAG_OWNED_BY_SRV.

request can't be trusted any more for UBLK_F_BUF_REG_OFF_DAEMON because it
may be freed from elevator switch code or stopping dev code path, so we
can't rely on refcount_inc_not_zero(pdu(req)) only.

However the existing per-io-task and checking UBLK_IO_FLAG_OWNED_BY_SRV can
guarantee that the request is valid.

> For UBLK_IO_UNREGISTER_IO_BUF, I don't think checking io->flags &
> UBLK_IO_FLAG_OWNED_BY_SRV is sufficient to prevent misuse, since
> there's no requirement that the buffer index (addr) being unregistered
> matches the q_id, tag, or even ublk device specified in the command.

It should be fine to skip the check for UBLK_IO_UNREGISTER_IO_BUF because it
doesn't touch io & request.

However I think it is still correct to validate ZERO_COPY flag for
UBLK_IO_UNREGISTER_IO_BUF cause ZERO_COPY is only allowed for privileged
userspace.



Thanks,
Ming

