Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4479A1DED52
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656850; cv=none; b=gW64FB8+KrlB9OkrfQbn3Fel1oQJLv0K9onP2tr046NcqYxfmXsRtc7jVuJhA5/nYLn8aUgu6G5fmF2QJ9SxwHnCUICL1OlWfwAUJfSt7EKjXDlK9sDvmYAUw/kjLMYw+wGKz2wq3GxrUOFInI0szSe/dDbaTiPgEx0UqXcUGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656850; c=relaxed/simple;
	bh=RrQlVVkepoXXPDb4r3cNSNCB59YpIZPsdNNgzNW/Iq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHpGFBMnV1Qytubm3MZLVxgB752en9RL1UHM6WcIwYORVi7h+zOfFGXmL5m2Qosljqyk267/H5q2KztZW5yv0l190HreS5VQqmKbJFLiwHQ+lnu5VoEnRDqRyE5E9urueVlZ15HIQh/fnJ0kdrHe+5gKfNK8chl7o03nNuNnPzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bxMnsqNx; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bxMnsqNx"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313336f8438so11111a91.0
        for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 08:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749656847; x=1750261647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37sWPxXhmoG84FYIIf/tNXiwsmFQPTAmmTwHnHZ2IrI=;
        b=bxMnsqNxfvPa91mKPfd3PL4XEcRvBu6m3h7yIy4hyv9Jzr2NP3CaywX6FCU68qUecv
         pNTrXVrB5PJYDXa2B4rK1EdvHtjPsC+hCrMurl8R3j89q6CzHWnOlfVJsZObvlarDmyo
         bEsycOG4yQmCcae/1j+Z8CKaKAjlJ4srZIbYNoCQ9nXze17ucWCkHC59TecKyGUXEBEo
         DjZYUGxnI0r6a8CcVsr2wXU08TtfpV+4y/DuLJlgCGIrICRQiIzlprQva/X9uU+aLcWl
         eN+iVuev/26X+MLVyIFx9pSfd+0EyPJhdAmuy2BIH4bl6YxaN2nBN9vhODlEo7OITxJc
         hdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749656847; x=1750261647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37sWPxXhmoG84FYIIf/tNXiwsmFQPTAmmTwHnHZ2IrI=;
        b=ndUAh0mtnUqgWBRW1Cav3c2K+O8uAIZyW4GEUigisZJRF8UbkKS+Z066XiF1gTyzNw
         LocY5GYX+0VdPepP4yX1cMfcGUk/CR8BvqRDIoLMWvqK4azpwHzufXkkhN5Eif4rF9uy
         671HoDMhCNcl3qnOuOWL/lOqVfITbhCQ83plG91gC6Iuih3Xck1XUDU/jxcpjK/fNuxk
         oZwsVYl5oa/3rh5sLi8d2/NdgW5B/gN2awI7XVs5OSh/UscOjStW9h2llp1GSOTPmbjg
         pz8YTE59/e+3tnNE//dMchCjTpfmqrAdqxiCJJ4HssadvRzBDmyn3xTkSqEVclRRFEyo
         OuFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU79bhmNONZfoCaDrjEjgXVSgq3X3gpQbqk/79YwgYgAkVfaVWgoFnSwwbp7/asedeDfPKhci0M7WwpOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp5GgAfXg6kd1WW6jV71HrdEW1SaDnoiCFPfxtVPQRk91ZYXc/
	rt9hctRIQ+AZ71k3B9S8iUS0pP4cwU+FK6skwDske0fLp0D5EOfMlLNtxaazvzqCdAqFt0Aky5m
	RZ9snF0uz7T9zV3IrG+CCO0T7rhodYMGFsLIuUnNfvA==
X-Gm-Gg: ASbGnctNMSE8UiUz+QmY2O+QMK3CGFqHnBaF1h+yl5VpICHiER82XEYAnluZC3r0Eyp
	5wYBhD+SFc7RvoU4dKE5re/DPkN4azRmhmjQMuSq7l2sBsenGpbHMSbCLSJDrp/4ydFIjdgjU6m
	S5mG4GTCAUHlMb+K40R6aKXNBeooUKzO6nnY505NA/bRY=
X-Google-Smtp-Source: AGHT+IFgLlvVlMvvfJopVA47Lmh8qm9GbaCneEby3Hh8XvZFGw2+vfCIcizVlJr9kIaAHIrfUonZj/7cWHodTbkaT0w=
X-Received: by 2002:a17:90b:1d88:b0:313:2f9a:13c0 with SMTP id
 98e67ed59e1d1-313af148e83mr2061542a91.1.1749656847369; Wed, 11 Jun 2025
 08:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606214011.2576398-1-csander@purestorage.com>
 <20250606214011.2576398-7-csander@purestorage.com> <aEbUx51iu6oMkPB7@fedora>
 <CADUfDZoCCFs6ZKwxDrgsHGTiCgyehS1uODu+iDmz1+5_k7tLbw@mail.gmail.com> <aEeLsEHxZV_Xs7yC@fedora>
In-Reply-To: <aEeLsEHxZV_Xs7yC@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 11 Jun 2025 08:47:15 -0700
X-Gm-Features: AX0GCFv4C_ZtS7jxfG5LKELkMhAFDuA6vkPFW8D7K8U1CLb7x9J7e15LNsEwTPE
Message-ID: <CADUfDZpbZS52SHzzHem3oFoSt6CM16XX6D6u+6OSD7zmzHPVSQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] ublk: allow UBLK_IO_(UN)REGISTER_IO_BUF on any task
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 6:34=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Mon, Jun 09, 2025 at 10:49:09AM -0700, Caleb Sander Mateos wrote:
> > On Mon, Jun 9, 2025 at 5:34=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > On Fri, Jun 06, 2025 at 03:40:09PM -0600, Caleb Sander Mateos wrote:
> > > > Currently, UBLK_IO_REGISTER_IO_BUF and UBLK_IO_UNREGISTER_IO_BUF ar=
e
> > > > only permitted on the ublk_io's daemon task. But this restriction i=
s
> > > > unnecessary. ublk_register_io_buf() calls __ublk_check_and_get_req(=
) to
> > > > look up the request from the tagset and atomically take a reference=
 on
> > > > the request without accessing the ublk_io. ublk_unregister_io_buf()
> > > > doesn't use the q_id or tag at all.
> > > >
> > > > So allow these opcodes even on tasks other than io->task.
> > > >
> > > > Handle UBLK_IO_UNREGISTER_IO_BUF before obtaining the ubq and io si=
nce
> > > > the buffer index being unregistered is not necessarily related to t=
he
> > > > specified q_id and tag.
> > > >
> > > > Add a feature flag UBLK_F_BUF_REG_OFF_DAEMON that userspace can use=
 to
> > > > determine whether the kernel supports off-daemon buffer registratio=
n.
> > > >
> > > > Suggested-by: Ming Lei <ming.lei@redhat.com>
> > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c      | 37 +++++++++++++++++++++----------=
----
> > > >  include/uapi/linux/ublk_cmd.h |  8 ++++++++
> > > >  2 files changed, 30 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index a8030818f74a..2084bbdd2cbb 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -68,11 +68,12 @@
> > > >               | UBLK_F_ZONED \
> > > >               | UBLK_F_USER_RECOVERY_FAIL_IO \
> > > >               | UBLK_F_UPDATE_SIZE \
> > > >               | UBLK_F_AUTO_BUF_REG \
> > > >               | UBLK_F_QUIESCE \
> > > > -             | UBLK_F_PER_IO_DAEMON)
> > > > +             | UBLK_F_PER_IO_DAEMON \
> > > > +             | UBLK_F_BUF_REG_OFF_DAEMON)
> > > >
> > > >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> > > >               | UBLK_F_USER_RECOVERY_REISSUE \
> > > >               | UBLK_F_USER_RECOVERY_FAIL_IO)
> > > >
> > > > @@ -2018,20 +2019,10 @@ static int ublk_register_io_buf(struct io_u=
ring_cmd *cmd,
> > > >       }
> > > >
> > > >       return 0;
> > > >  }
> > > >
> > > > -static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
> > > > -                               const struct ublk_queue *ubq,
> > > > -                               unsigned int index, unsigned int is=
sue_flags)
> > > > -{
> > > > -     if (!ublk_support_zero_copy(ubq))
> > > > -             return -EINVAL;
> > > > -
> > > > -     return io_buffer_unregister_bvec(cmd, index, issue_flags);
> > > > -}
> > > > -
> > > >  static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue =
*ubq,
> > > >                     struct ublk_io *io, __u64 buf_addr)
> > > >  {
> > > >       struct ublk_device *ub =3D ubq->dev;
> > > >       int ret =3D 0;
> > > > @@ -2184,10 +2175,18 @@ static int __ublk_ch_uring_cmd(struct io_ur=
ing_cmd *cmd,
> > > >
> > > >       ret =3D ublk_check_cmd_op(cmd_op);
> > > >       if (ret)
> > > >               goto out;
> > > >
> > > > +     /*
> > > > +      * io_buffer_unregister_bvec() doesn't access the ubq or io,
> > > > +      * so no need to validate the q_id, tag, or task
> > > > +      */
> > > > +     if (_IOC_NR(cmd_op) =3D=3D UBLK_IO_UNREGISTER_IO_BUF)
> > > > +             return io_buffer_unregister_bvec(cmd, ub_cmd->addr,
> > > > +                                              issue_flags);
> > > > +
> > > >       ret =3D -EINVAL;
> > > >       if (ub_cmd->q_id >=3D ub->dev_info.nr_hw_queues)
> > > >               goto out;
> > > >
> > > >       ubq =3D ublk_get_queue(ub, ub_cmd->q_id);
> > > > @@ -2204,12 +2203,21 @@ static int __ublk_ch_uring_cmd(struct io_ur=
ing_cmd *cmd,
> > > >
> > > >               ublk_prep_cancel(cmd, issue_flags, ubq, tag);
> > > >               return -EIOCBQUEUED;
> > > >       }
> > > >
> > > > -     if (READ_ONCE(io->task) !=3D current)
> > > > +     if (READ_ONCE(io->task) !=3D current) {
> > > > +             /*
> > > > +              * ublk_register_io_buf() accesses only the request, =
not io,
> > > > +              * so can be handled on any task
> > > > +              */
> > > > +             if (_IOC_NR(cmd_op) =3D=3D UBLK_IO_REGISTER_IO_BUF)
> > > > +                     return ublk_register_io_buf(cmd, ubq, tag, ub=
_cmd->addr,
> > > > +                                                 issue_flags);
> > > > +
> > > >               goto out;
> > > > +     }
> > > >
> > > >       /* there is pending io cmd, something must be wrong */
> > > >       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)) {
> > > >               ret =3D -EBUSY;
> > >
> > > It also skips check on UBLK_IO_FLAG_OWNED_BY_SRV for both UBLK_IO_REG=
ISTER_IO_BUF
> > > and UBLK_IO_UNREGISTER_IO_BUF, :-(
> >
> > As we've discussed before[1], accessing io->flags on tasks other than
> > the io's daemon would be a race condition. So I don't see how it's
> > possible to keep this check for off-daemon
> > UBLK_IO_(UN)REGISTER_IO_BUF. What value do you see in checking for
> > UBLK_IO_FLAG_OWNED_BY_SRV? My understanding is that the
> > refcount_inc_not_zero() already ensures the ublk I/O has been
> > dispatched to the ublk server and either hasn't been completed or has
> > other registered buffers still in use, which is pretty similar to
> > UBLK_IO_FLAG_OWNED_BY_SRV.
>
> request can't be trusted any more for UBLK_F_BUF_REG_OFF_DAEMON because i=
t
> may be freed from elevator switch code or stopping dev code path, so we
> can't rely on refcount_inc_not_zero(pdu(req)) only.

I don't know much about how an elevator switch works, could you
explain a bit more how the request can be freed? Is this not already a
concern for user copy, where ublk_ch_read_iter() and
ublk_ch_write_iter() can be issued on any thread? Those code paths
also seem to be relying on the refcount_inc_not_zero() (plus the
blk_mq_request_started(req) and req->tag checks) in
__ublk_check_and_get_req() to prevent use-after-free.

>
> However the existing per-io-task and checking UBLK_IO_FLAG_OWNED_BY_SRV c=
an
> guarantee that the request is valid.
>
> > For UBLK_IO_UNREGISTER_IO_BUF, I don't think checking io->flags &
> > UBLK_IO_FLAG_OWNED_BY_SRV is sufficient to prevent misuse, since
> > there's no requirement that the buffer index (addr) being unregistered
> > matches the q_id, tag, or even ublk device specified in the command.
>
> It should be fine to skip the check for UBLK_IO_UNREGISTER_IO_BUF because=
 it
> doesn't touch io & request.
>
> However I think it is still correct to validate ZERO_COPY flag for
> UBLK_IO_UNREGISTER_IO_BUF cause ZERO_COPY is only allowed for privileged
> userspace.

Okay, I will check for UBLK_F_SUPPORT_ZERO_COPY on the ublk_device
instead to avoid the ublk_queue lookup.

Best,
Caleb
