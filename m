Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ECC63A9
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 02:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749695533; cv=none; b=rUm0Z7jF2MdEmSxvWqOFTOucFOGbI916TxxyDZKfsxi3RXB/gPqyxXVuiKUz1AwMXOoNKRERYdd244sM2RsKr1ETNAJBm5f1Gug+4Tf4c0KnGDzFAlD7nZM9RwqIOsXFFcq0T0Y7FrZ6SBejrjUF9vsBQvn3fKXaUWmaCjgH2ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749695533; c=relaxed/simple;
	bh=TFqKHV2jMcBkeMRazHFqhP8CAWWt0tB7W5/h2Jx5CUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4iK3HueEoRO6UJRdTqC39prtWQ8Owmv3GuMkIqTXTO6AS73/2RrBOyCiBrhiCVkdEoU8hqkQuRXmn/DRQDStShSMsEgk9J/fdNVLcm3ctekVcHBNQdsxtYIBNQEL0ZXKSdOCsKvrP08UJEwBGJIlj36Q4nmDCAXalVyrUzBBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVJtuL1l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVJtuL1l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749695530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XkoPfTJSxUuoORNBUBEnrpeXLdzu0r5KDxG7idNkMYI=;
	b=cVJtuL1lNOIyboChRAAyCbFRAqwtgCELj9joOUAh+oW3N2FqorlILIzPrByxxJi/1l+Cs/
	32RtboBiF/Z/TJ8t89h/D8//1UDW5ZgKBvcgUYEuux0jvkJOWED/eNPyGdBrlm2cB26Wut
	7gvWMp53kIoUiUqkdf2y0WP/nPlWPVM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-KLdNa_6ROzKqtl6PzXEA-Q-1; Wed,
 11 Jun 2025 22:32:06 -0400
X-MC-Unique: KLdNa_6ROzKqtl6PzXEA-Q-1
X-Mimecast-MFC-AGG-ID: KLdNa_6ROzKqtl6PzXEA-Q_1749695525
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA10319560AA;
	Thu, 12 Jun 2025 02:32:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.109])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05226180045C;
	Thu, 12 Jun 2025 02:32:02 +0000 (UTC)
Date: Thu, 12 Jun 2025 10:31:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 6/8] ublk: allow UBLK_IO_(UN)REGISTER_IO_BUF on any task
Message-ID: <aEo8HXN_haQ4wiuP@fedora>
References: <20250606214011.2576398-1-csander@purestorage.com>
 <20250606214011.2576398-7-csander@purestorage.com>
 <aEbUx51iu6oMkPB7@fedora>
 <CADUfDZoCCFs6ZKwxDrgsHGTiCgyehS1uODu+iDmz1+5_k7tLbw@mail.gmail.com>
 <aEeLsEHxZV_Xs7yC@fedora>
 <CADUfDZpbZS52SHzzHem3oFoSt6CM16XX6D6u+6OSD7zmzHPVSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpbZS52SHzzHem3oFoSt6CM16XX6D6u+6OSD7zmzHPVSQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Jun 11, 2025 at 08:47:15AM -0700, Caleb Sander Mateos wrote:
> On Mon, Jun 9, 2025 at 6:34 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Mon, Jun 09, 2025 at 10:49:09AM -0700, Caleb Sander Mateos wrote:
> > > On Mon, Jun 9, 2025 at 5:34 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Fri, Jun 06, 2025 at 03:40:09PM -0600, Caleb Sander Mateos wrote:
> > > > > Currently, UBLK_IO_REGISTER_IO_BUF and UBLK_IO_UNREGISTER_IO_BUF are
> > > > > only permitted on the ublk_io's daemon task. But this restriction is
> > > > > unnecessary. ublk_register_io_buf() calls __ublk_check_and_get_req() to
> > > > > look up the request from the tagset and atomically take a reference on
> > > > > the request without accessing the ublk_io. ublk_unregister_io_buf()
> > > > > doesn't use the q_id or tag at all.
> > > > >
> > > > > So allow these opcodes even on tasks other than io->task.
> > > > >
> > > > > Handle UBLK_IO_UNREGISTER_IO_BUF before obtaining the ubq and io since
> > > > > the buffer index being unregistered is not necessarily related to the
> > > > > specified q_id and tag.
> > > > >
> > > > > Add a feature flag UBLK_F_BUF_REG_OFF_DAEMON that userspace can use to
> > > > > determine whether the kernel supports off-daemon buffer registration.
> > > > >
> > > > > Suggested-by: Ming Lei <ming.lei@redhat.com>
> > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > > ---
> > > > >  drivers/block/ublk_drv.c      | 37 +++++++++++++++++++++--------------
> > > > >  include/uapi/linux/ublk_cmd.h |  8 ++++++++
> > > > >  2 files changed, 30 insertions(+), 15 deletions(-)
> > > > >
> > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > index a8030818f74a..2084bbdd2cbb 100644
> > > > > --- a/drivers/block/ublk_drv.c
> > > > > +++ b/drivers/block/ublk_drv.c
> > > > > @@ -68,11 +68,12 @@
> > > > >               | UBLK_F_ZONED \
> > > > >               | UBLK_F_USER_RECOVERY_FAIL_IO \
> > > > >               | UBLK_F_UPDATE_SIZE \
> > > > >               | UBLK_F_AUTO_BUF_REG \
> > > > >               | UBLK_F_QUIESCE \
> > > > > -             | UBLK_F_PER_IO_DAEMON)
> > > > > +             | UBLK_F_PER_IO_DAEMON \
> > > > > +             | UBLK_F_BUF_REG_OFF_DAEMON)
> > > > >
> > > > >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> > > > >               | UBLK_F_USER_RECOVERY_REISSUE \
> > > > >               | UBLK_F_USER_RECOVERY_FAIL_IO)
> > > > >
> > > > > @@ -2018,20 +2019,10 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
> > > > >       }
> > > > >
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > -static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
> > > > > -                               const struct ublk_queue *ubq,
> > > > > -                               unsigned int index, unsigned int issue_flags)
> > > > > -{
> > > > > -     if (!ublk_support_zero_copy(ubq))
> > > > > -             return -EINVAL;
> > > > > -
> > > > > -     return io_buffer_unregister_bvec(cmd, index, issue_flags);
> > > > > -}
> > > > > -
> > > > >  static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
> > > > >                     struct ublk_io *io, __u64 buf_addr)
> > > > >  {
> > > > >       struct ublk_device *ub = ubq->dev;
> > > > >       int ret = 0;
> > > > > @@ -2184,10 +2175,18 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
> > > > >
> > > > >       ret = ublk_check_cmd_op(cmd_op);
> > > > >       if (ret)
> > > > >               goto out;
> > > > >
> > > > > +     /*
> > > > > +      * io_buffer_unregister_bvec() doesn't access the ubq or io,
> > > > > +      * so no need to validate the q_id, tag, or task
> > > > > +      */
> > > > > +     if (_IOC_NR(cmd_op) == UBLK_IO_UNREGISTER_IO_BUF)
> > > > > +             return io_buffer_unregister_bvec(cmd, ub_cmd->addr,
> > > > > +                                              issue_flags);
> > > > > +
> > > > >       ret = -EINVAL;
> > > > >       if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
> > > > >               goto out;
> > > > >
> > > > >       ubq = ublk_get_queue(ub, ub_cmd->q_id);
> > > > > @@ -2204,12 +2203,21 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
> > > > >
> > > > >               ublk_prep_cancel(cmd, issue_flags, ubq, tag);
> > > > >               return -EIOCBQUEUED;
> > > > >       }
> > > > >
> > > > > -     if (READ_ONCE(io->task) != current)
> > > > > +     if (READ_ONCE(io->task) != current) {
> > > > > +             /*
> > > > > +              * ublk_register_io_buf() accesses only the request, not io,
> > > > > +              * so can be handled on any task
> > > > > +              */
> > > > > +             if (_IOC_NR(cmd_op) == UBLK_IO_REGISTER_IO_BUF)
> > > > > +                     return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr,
> > > > > +                                                 issue_flags);
> > > > > +
> > > > >               goto out;
> > > > > +     }
> > > > >
> > > > >       /* there is pending io cmd, something must be wrong */
> > > > >       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)) {
> > > > >               ret = -EBUSY;
> > > >
> > > > It also skips check on UBLK_IO_FLAG_OWNED_BY_SRV for both UBLK_IO_REGISTER_IO_BUF
> > > > and UBLK_IO_UNREGISTER_IO_BUF, :-(
> > >
> > > As we've discussed before[1], accessing io->flags on tasks other than
> > > the io's daemon would be a race condition. So I don't see how it's
> > > possible to keep this check for off-daemon
> > > UBLK_IO_(UN)REGISTER_IO_BUF. What value do you see in checking for
> > > UBLK_IO_FLAG_OWNED_BY_SRV? My understanding is that the
> > > refcount_inc_not_zero() already ensures the ublk I/O has been
> > > dispatched to the ublk server and either hasn't been completed or has
> > > other registered buffers still in use, which is pretty similar to
> > > UBLK_IO_FLAG_OWNED_BY_SRV.
> >
> > request can't be trusted any more for UBLK_F_BUF_REG_OFF_DAEMON because it
> > may be freed from elevator switch code or stopping dev code path, so we
> > can't rely on refcount_inc_not_zero(pdu(req)) only.
> 
> I don't know much about how an elevator switch works, could you
> explain a bit more how the request can be freed? Is this not already a

If elevator is attached, any request is allocated from elevator, and it will
be freed when switching the elevator off, so request retrieved from
ub->tag_set.tags[tag] may become stale since elevator may be switched out
anytime.

> concern for user copy, where ublk_ch_read_iter() and
> ublk_ch_write_iter() can be issued on any thread? Those code paths
> also seem to be relying on the refcount_inc_not_zero() (plus the
> blk_mq_request_started(req) and req->tag checks) in
> __ublk_check_and_get_req() to prevent use-after-free.

Looks there is the risk.

It could be solved by grabbing queue usage counter for __ublk_check_and_get_req()
or moving the reference counter to 'ublk_io'.


Thanks, 
Ming

