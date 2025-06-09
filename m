Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28D11A841F
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749491362; cv=none; b=X5Xf2ZEBcAqWlM2egu+B5vC1LpvSHHT1uk+QEuvQc6LLSw/mvDiryI/o/n+6XPHUOI2Mxub/IHd+xeLtiARIH/V8PD5U5k+/vzl88yTAhdYk5560aHhcxvpoVg+1dNxgH6QZScKoJnE5pf43Pwqic68/qJFh3C2tPq9YfpSI3GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749491362; c=relaxed/simple;
	bh=BX8IjBhs93qZ9a0zfy9TBu9/J7STSUPVZq9OTXm578s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvWjq3jSp7qzhVyDHYFAe4qSnRWyIunAOz9tbq1aMz2A8sJ9ggbfzA1plRV1Yd1g6vK+3IKlT6JTHgLV+p/RoE+ylGuw+jlhp/sj+Ookg6nbvMtykbxxt0OC1L1KkWGhypgUwWyQSYdwQt7a82gT8WrDh62nZxKDNauTX9KzPYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GIzIpjWz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GIzIpjWz"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23496600df1so5287045ad.2
        for <linux-block@vger.kernel.org>; Mon, 09 Jun 2025 10:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749491360; x=1750096160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAKhwCEQCW9zRoxMPrvi+tGcBpKNE4yFbyEigtT5eb4=;
        b=GIzIpjWz9V4P7WThpM9IhddD/2wMIoRTp9AEsWDJ5inY2AK1QLuTjcjP9Wi2imEBp3
         VO0DKifCEus7pv+vbLhK+cOos2uTkkZCm1xAeIX0Hu3Khyx3iSsR1qlTL3JkyC5Yqeix
         A0RsexV0SeqbS8v4dLbD1KA+nbGDXc7LmlOymQXWoqNgx5ppZXXgth8AJGvt/ro1vw98
         iCfMuQFrG9Aa3H5kIXHzXKF5hIl9PQQFy9bI3PdRA+VtBAepieSW3p36YdlK3aOevYFZ
         G/EJCb2XO/v+gpuj8lJmSsyOD7Lj2Yimh4CLlWU9Q/n7++90KwukPvkkFg1cdfqqXXzT
         w0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749491360; x=1750096160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAKhwCEQCW9zRoxMPrvi+tGcBpKNE4yFbyEigtT5eb4=;
        b=pXHkmLEnChN/b639EFpHrv6RzQSUhxI+WQVPMsKuEiD/fFPr1FTLkF6cJXzw47io6n
         ZUcEcfE7fhxpM+zKo5yB57AiOeftJowSbt15oyBmzrW4dfoTAdZM1miiVJbT3yvKyBcM
         qHInM+zViKa9jmwpYS7xtlhavbgvTv+raWJhnD8cRVxKHFb/s29Vgn9Nn/FOUYeeAZ1J
         P7eUsqPGun8XL6D9n0rF/Vv1NhjPsn+I2OQqjeqCFP+qeRBuR6q5i1WHY+wQ51w0HIDm
         58d2u5MaNZlBHwIbpJmKrXcdKnup8I1q69h7YofXwLuESwK743FoR8aVOkXcYjLAeZIR
         gCCA==
X-Forwarded-Encrypted: i=1; AJvYcCV0BHS8RAGc3ees51UvqoojqGaLw3ARvJM25ZDaCT7+g+GJtUI373peVodBkdeeQ6bqu5f7j1IYjJxXTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFYSPnN40pjYmexl46IZVTAe2GUmnf4zeJjJn0w/nFIEqO6cm
	L/8oFYa9t5uBvp/g10LZ97Pv5CTGgf/hqanIn+oxsFUTVIH3H3yL0XvsUqksey+d6EsWgLWTW/8
	Rc1+rqMzG6a0GDsaYyIjl5tDgxX78SNVKnf1sNIigrw==
X-Gm-Gg: ASbGncuKmTnN7K/CNnThzIs1wdQHpwVYFh62Pyq/O6+ptd8tBmN3V4F9H1ZUaek9e8f
	eK4nLGh6fy2IgsYBD80fHbu+mf8GS+pnfx61fBpWcHLIAkzYXGTITnSsKkm/zXM6WVKpquQKTjn
	RzR5OfVPjSikzSyGLv/30v+OXt1mvr/3Y5
X-Google-Smtp-Source: AGHT+IGsMeghNyxtcC0ikK+J/PUZIjyJubbVtpGHHRoKd7YVYLtPJEyF/lpSeTpDy/9jUYkEEkUY/aBz029aneNb3uM=
X-Received: by 2002:a17:903:1247:b0:234:ef42:5d52 with SMTP id
 d9443c01a7336-23604028ea5mr70508765ad.6.1749491360159; Mon, 09 Jun 2025
 10:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606214011.2576398-1-csander@purestorage.com>
 <20250606214011.2576398-7-csander@purestorage.com> <aEbUx51iu6oMkPB7@fedora>
In-Reply-To: <aEbUx51iu6oMkPB7@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 9 Jun 2025 10:49:09 -0700
X-Gm-Features: AX0GCFuGYb7Z1iJyYekjrq_X6p0PtWBefP2lDhP6WpclNqK5piFdDh3CGP3qkzs
Message-ID: <CADUfDZoCCFs6ZKwxDrgsHGTiCgyehS1uODu+iDmz1+5_k7tLbw@mail.gmail.com>
Subject: Re: [PATCH 6/8] ublk: allow UBLK_IO_(UN)REGISTER_IO_BUF on any task
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 5:34=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Fri, Jun 06, 2025 at 03:40:09PM -0600, Caleb Sander Mateos wrote:
> > Currently, UBLK_IO_REGISTER_IO_BUF and UBLK_IO_UNREGISTER_IO_BUF are
> > only permitted on the ublk_io's daemon task. But this restriction is
> > unnecessary. ublk_register_io_buf() calls __ublk_check_and_get_req() to
> > look up the request from the tagset and atomically take a reference on
> > the request without accessing the ublk_io. ublk_unregister_io_buf()
> > doesn't use the q_id or tag at all.
> >
> > So allow these opcodes even on tasks other than io->task.
> >
> > Handle UBLK_IO_UNREGISTER_IO_BUF before obtaining the ubq and io since
> > the buffer index being unregistered is not necessarily related to the
> > specified q_id and tag.
> >
> > Add a feature flag UBLK_F_BUF_REG_OFF_DAEMON that userspace can use to
> > determine whether the kernel supports off-daemon buffer registration.
> >
> > Suggested-by: Ming Lei <ming.lei@redhat.com>
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c      | 37 +++++++++++++++++++++--------------
> >  include/uapi/linux/ublk_cmd.h |  8 ++++++++
> >  2 files changed, 30 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index a8030818f74a..2084bbdd2cbb 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -68,11 +68,12 @@
> >               | UBLK_F_ZONED \
> >               | UBLK_F_USER_RECOVERY_FAIL_IO \
> >               | UBLK_F_UPDATE_SIZE \
> >               | UBLK_F_AUTO_BUF_REG \
> >               | UBLK_F_QUIESCE \
> > -             | UBLK_F_PER_IO_DAEMON)
> > +             | UBLK_F_PER_IO_DAEMON \
> > +             | UBLK_F_BUF_REG_OFF_DAEMON)
> >
> >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> >               | UBLK_F_USER_RECOVERY_REISSUE \
> >               | UBLK_F_USER_RECOVERY_FAIL_IO)
> >
> > @@ -2018,20 +2019,10 @@ static int ublk_register_io_buf(struct io_uring=
_cmd *cmd,
> >       }
> >
> >       return 0;
> >  }
> >
> > -static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
> > -                               const struct ublk_queue *ubq,
> > -                               unsigned int index, unsigned int issue_=
flags)
> > -{
> > -     if (!ublk_support_zero_copy(ubq))
> > -             return -EINVAL;
> > -
> > -     return io_buffer_unregister_bvec(cmd, index, issue_flags);
> > -}
> > -
> >  static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq=
,
> >                     struct ublk_io *io, __u64 buf_addr)
> >  {
> >       struct ublk_device *ub =3D ubq->dev;
> >       int ret =3D 0;
> > @@ -2184,10 +2175,18 @@ static int __ublk_ch_uring_cmd(struct io_uring_=
cmd *cmd,
> >
> >       ret =3D ublk_check_cmd_op(cmd_op);
> >       if (ret)
> >               goto out;
> >
> > +     /*
> > +      * io_buffer_unregister_bvec() doesn't access the ubq or io,
> > +      * so no need to validate the q_id, tag, or task
> > +      */
> > +     if (_IOC_NR(cmd_op) =3D=3D UBLK_IO_UNREGISTER_IO_BUF)
> > +             return io_buffer_unregister_bvec(cmd, ub_cmd->addr,
> > +                                              issue_flags);
> > +
> >       ret =3D -EINVAL;
> >       if (ub_cmd->q_id >=3D ub->dev_info.nr_hw_queues)
> >               goto out;
> >
> >       ubq =3D ublk_get_queue(ub, ub_cmd->q_id);
> > @@ -2204,12 +2203,21 @@ static int __ublk_ch_uring_cmd(struct io_uring_=
cmd *cmd,
> >
> >               ublk_prep_cancel(cmd, issue_flags, ubq, tag);
> >               return -EIOCBQUEUED;
> >       }
> >
> > -     if (READ_ONCE(io->task) !=3D current)
> > +     if (READ_ONCE(io->task) !=3D current) {
> > +             /*
> > +              * ublk_register_io_buf() accesses only the request, not =
io,
> > +              * so can be handled on any task
> > +              */
> > +             if (_IOC_NR(cmd_op) =3D=3D UBLK_IO_REGISTER_IO_BUF)
> > +                     return ublk_register_io_buf(cmd, ubq, tag, ub_cmd=
->addr,
> > +                                                 issue_flags);
> > +
> >               goto out;
> > +     }
> >
> >       /* there is pending io cmd, something must be wrong */
> >       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)) {
> >               ret =3D -EBUSY;
>
> It also skips check on UBLK_IO_FLAG_OWNED_BY_SRV for both UBLK_IO_REGISTE=
R_IO_BUF
> and UBLK_IO_UNREGISTER_IO_BUF, :-(

As we've discussed before[1], accessing io->flags on tasks other than
the io's daemon would be a race condition. So I don't see how it's
possible to keep this check for off-daemon
UBLK_IO_(UN)REGISTER_IO_BUF. What value do you see in checking for
UBLK_IO_FLAG_OWNED_BY_SRV? My understanding is that the
refcount_inc_not_zero() already ensures the ublk I/O has been
dispatched to the ublk server and either hasn't been completed or has
other registered buffers still in use, which is pretty similar to
UBLK_IO_FLAG_OWNED_BY_SRV.
For UBLK_IO_UNREGISTER_IO_BUF, I don't think checking io->flags &
UBLK_IO_FLAG_OWNED_BY_SRV is sufficient to prevent misuse, since
there's no requirement that the buffer index (addr) being unregistered
matches the q_id, tag, or even ublk device specified in the command.

[1]: https://lore.kernel.org/linux-block/CADUfDZqZ_9O7vUAYtxrrujWqPBuP05nBh=
CbzNuNsc9kJTmX2sA@mail.gmail.com/

Best,
Caleb
