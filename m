Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7E0270557
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691531; cv=none; b=PLtFVyVJysRP7R96XFrsu7g414te2YniKz0KK4iX/i0HZsgGyuYJ5hsuBMt85EgJYHFyk6mq2ka3+V72TrGaw90g/5Dsgezck0t4Qyi5LCvfe7mbM9kDFcGbAQip5BaJhNY015YVU511sDRW0M+iDjjxfZI9rWTA6Dvot3qcEv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691531; c=relaxed/simple;
	bh=YO++vEL+OZ1dPvx0RD6jialYGenmC47/E92WntkMBAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLdKpWI3GZbYisHZCe6xWCFVIa7daXW5z4J2R5NIBPxZJyP5IO+5HflD2uB6n5jge8zy206Jf/n23/o798m/Ddzf3cAPeWkTuDlOJ+iU7dbp+6i5csNsHeQ9/hcmwyXou9rkdk1mX9Zw1cQUCSf9yhuXVUnzgZkXV6FVFPfdbDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gYMETgLv; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gYMETgLv"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b983fbc731bso418166a12.2
        for <linux-block@vger.kernel.org>; Tue, 02 Dec 2025 08:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764691528; x=1765296328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixD6EDHW7WmuD/smIh00HSb5BUDNC5j73qGSOJezWLg=;
        b=gYMETgLvB0HbW67yQA3dZQqxPhCk78PxwCJvyw8qqJ6RZiMClM6w7NevthzPbvy4Xm
         EyWVQoisR+mM97U+1+sGb/V/TUrDmcEBHfR8KpNOMnaLaPzfpuNlYsDXeRUnt6Ovr1ru
         SIA5HZcNbYWKYygSdHu3IXhIS4L0xxzrRWl4JA3Vm+pdmGu03TgrnjvKTHaIM/GvPHqW
         sQjiDdnQ7mtYS28kHQ33MDLR6UQw9aokWsWD7KfXbayrlHdVu/3krjNoqgRx/OvBZiOI
         Az4fKjsV+1y1ymN0oPwK8u06N2GGHIjlJN7u2ElWSc16NlIZumb6YbLuz8Oibr3oEUhn
         Rm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764691528; x=1765296328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ixD6EDHW7WmuD/smIh00HSb5BUDNC5j73qGSOJezWLg=;
        b=FstNegTduTkBvovGXZip9o7FZkwOQsxlQWJdzXX2wpU3sZY+50r7/KNcVhkOKpmSPO
         yZpbF6mptVi2hhx00YOloJRFXXd8F6VnTvq33W4DaIP9FkXMu7ZldvVHaCGZ+zBoJUYx
         HIXO3zQRa+Uj1ZUQH7B3Zf7ddYll7FRqJXGBO+7aXZGptD5WYu3QFrr6bbV/6MR7Az/+
         85pUL1ONwj9P8b7pAcuMIQjgT+AzIktvl8RC5RZ55XXgvEWfDkZHSXrx3rqlOFHgMT0E
         7Cl7o/+2IEVOLGg66rV1Dp/PWEpnNoecooQwU1FMeTAGxQcNaXm5Foev+PWI1AhOLVL5
         Clhw==
X-Forwarded-Encrypted: i=1; AJvYcCVbpJC4OtTqsi+iZIhbw1fG9f1NnejZE87D2ZJMCh7ARkywEpnoFLBsqGetx2JSAjVRnMpL4ihpY8wF6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9DeMcZmuG6RnRlx0qeHxfmX+078f8GYb/iVbac6+fsOK8KbNQ
	ltm7ATIK0GqgY4XyHOYhLF5nG+w9VNhKuRZ60pOA4K+1kx2Mq17xjyCs3P7d2AQP+7ITyrbd7SU
	PaA6Yqm89VB6hBo9rF+w8WpDYqCm/4DdrgQjOZjD34npre7vaVYHh4IkVFg==
X-Gm-Gg: ASbGncubUBk9xz0HE/J9t8ai9x7TW9lMkIa2EB+F9ZyP1DopA3cuGsgLWMDPCQxqUYM
	IPYE440VbcmkYjkRD2jj5BYxdar88/yWKNlMyjp/CoVCfGcONOsKQhUsq0vHtn/yBGhubzRTIGk
	I9ZY3DaykJzWVQUjSQq16gy+RfZTBibsYQT9I1uYFnY3VlY+1gcZ3oAXSH5ALT2jMiGnubisuT8
	oXyG2Riz+X+1j0T83YSQCh9UOG3qr6zhOjEEsGyjQYuAUeV065hXUudfPpG+WRVkWCBAIj9
X-Google-Smtp-Source: AGHT+IFFeS7lgv0kjZZI3sIt+15nLopgUN5HGcR4HtKQMon6W2xJPTZz2X3+kZFtQThdFPjGVMlCTtxyXO4ccaTXJlw=
X-Received: by 2002:a05:7022:69a9:b0:119:e56a:4ffb with SMTP id
 a92af1059eb24-11c9d5538e8mr27956585c88.0.1764691528143; Tue, 02 Dec 2025
 08:05:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-17-ming.lei@redhat.com>
 <CADUfDZoXKATH_nQ0TEqj6BrN+e-Shkd11CUJaJJ_FKbrTrv=GQ@mail.gmail.com> <aS5EgbJQFa2fm6GR@fedora>
In-Reply-To: <aS5EgbJQFa2fm6GR@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 2 Dec 2025 08:05:17 -0800
X-Gm-Features: AWmQ_bnfgXpFEUsp-Gr5hGayT8VExqrRelvC56Oqx-5hTjfG4iuJi2xvUGeyclQ
Message-ID: <CADUfDZqRQ3WmwswwfQf_vhP84OVmwU3LGMF8Rb8mShQSjnZAJQ@mail.gmail.com>
Subject: Re: [PATCH V4 16/27] ublk: add new feature UBLK_F_BATCH_IO
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 5:44=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Mon, Dec 01, 2025 at 01:16:04PM -0800, Caleb Sander Mateos wrote:
> > On Thu, Nov 20, 2025 at 6:00=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Add new feature UBLK_F_BATCH_IO which replaces the following two
> > > per-io commands:
> > >
> > >         - UBLK_U_IO_FETCH_REQ
> > >
> > >         - UBLK_U_IO_COMMIT_AND_FETCH_REQ
> > >
> > > with three per-queue batch io uring_cmd:
> > >
> > >         - UBLK_U_IO_PREP_IO_CMDS
> > >
> > >         - UBLK_U_IO_COMMIT_IO_CMDS
> > >
> > >         - UBLK_U_IO_FETCH_IO_CMDS
> > >
> > > Then ublk can deliver batch io commands to ublk server in single
> > > multishort uring_cmd, also allows to prepare & commit multiple
> > > commands in batch style via single uring_cmd, communication cost is
> > > reduced a lot.
> > >
> > > This feature also doesn't limit task context any more for all support=
ed
> > > commands, so any allowed uring_cmd can be issued in any task context.
> > > ublk server implementation becomes much easier.
> > >
> > > Meantime load balance becomes much easier to support with this featur=
e.
> > > The command `UBLK_U_IO_FETCH_IO_CMDS` can be issued from multiple tas=
k
> > > contexts, so each task can adjust this command's buffer length or num=
ber
> > > of inflight commands for controlling how much load is handled by curr=
ent
> > > task.
> > >
> > > Later, priority parameter will be added to command `UBLK_U_IO_FETCH_I=
O_CMDS`
> > > for improving load balance support.
> > >
> > > UBLK_U_IO_GET_DATA isn't supported in batch io yet, but it may be
> >
> > UBLK_U_IO_NEED_GET_DATA?
>
> Yeah.
>
> >
> > > enabled in future via its batch pair.
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 58 ++++++++++++++++++++++++++++++++-=
--
> > >  include/uapi/linux/ublk_cmd.h | 16 ++++++++++
> > >  2 files changed, 69 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 849199771f86..90cd1863bc83 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -74,7 +74,8 @@
> > >                 | UBLK_F_AUTO_BUF_REG \
> > >                 | UBLK_F_QUIESCE \
> > >                 | UBLK_F_PER_IO_DAEMON \
> > > -               | UBLK_F_BUF_REG_OFF_DAEMON)
> > > +               | UBLK_F_BUF_REG_OFF_DAEMON \
> > > +               | UBLK_F_BATCH_IO)
> > >
> > >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> > >                 | UBLK_F_USER_RECOVERY_REISSUE \
> > > @@ -320,12 +321,12 @@ static void ublk_batch_dispatch(struct ublk_que=
ue *ubq,
> > >
> > >  static inline bool ublk_dev_support_batch_io(const struct ublk_devic=
e *ub)
> > >  {
> > > -       return false;
> > > +       return ub->dev_info.flags & UBLK_F_BATCH_IO;
> > >  }
> > >
> > >  static inline bool ublk_support_batch_io(const struct ublk_queue *ub=
q)
> > >  {
> > > -       return false;
> > > +       return ubq->flags & UBLK_F_BATCH_IO;
> > >  }
> > >
> > >  static inline void ublk_io_lock(struct ublk_io *io)
> > > @@ -3450,6 +3451,41 @@ static int ublk_validate_batch_fetch_cmd(struc=
t ublk_batch_io_data *data,
> > >         return 0;
> > >  }
> > >
> > > +static int ublk_handle_non_batch_cmd(struct io_uring_cmd *cmd,
> > > +                                    unsigned int issue_flags)
> > > +{
> > > +       const struct ublksrv_io_cmd *ub_cmd =3D io_uring_sqe_cmd(cmd-=
>sqe);
> > > +       struct ublk_device *ub =3D cmd->file->private_data;
> > > +       unsigned tag =3D READ_ONCE(ub_cmd->tag);
> > > +       unsigned q_id =3D READ_ONCE(ub_cmd->q_id);
> > > +       unsigned index =3D READ_ONCE(ub_cmd->addr);
> > > +       struct ublk_queue *ubq;
> > > +       struct ublk_io *io;
> > > +       int ret =3D -EINVAL;
> >
> > I think it would be clearer to just return -EINVAL instead of adding
> > this variable, but up to you
> >
> > > +
> > > +       if (!ub)
> > > +               return ret;
> >
> > How is this case possible?
>
> Will remove the check.
>
> >
> > > +
> > > +       if (q_id >=3D ub->dev_info.nr_hw_queues)
> > > +               return ret;
> > > +
> > > +       ubq =3D ublk_get_queue(ub, q_id);
> > > +       if (tag >=3D ubq->q_depth)
> >
> > Can avoid the likely cache miss here by using ub->dev_info.queue_depth
> > instead, analogous to ublk_ch_uring_cmd_local()
>
> OK.
>
> >
> > > +               return ret;
> > > +
> > > +       io =3D &ubq->ios[tag];
> > > +
> > > +       switch (cmd->cmd_op) {
> > > +       case UBLK_U_IO_REGISTER_IO_BUF:
> > > +               return ublk_register_io_buf(cmd, ub, q_id, tag, io, i=
ndex,
> > > +                               issue_flags);
> > > +       case UBLK_U_IO_UNREGISTER_IO_BUF:
> > > +               return ublk_unregister_io_buf(cmd, ub, index, issue_f=
lags);
> > > +       default:
> > > +               return -EOPNOTSUPP;
> > > +       }
> > > +}
> > > +
> > >  static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
> > >                                        unsigned int issue_flags)
> > >  {
> > > @@ -3497,7 +3533,8 @@ static int ublk_ch_batch_io_uring_cmd(struct io=
_uring_cmd *cmd,
> > >                 ret =3D ublk_handle_batch_fetch_cmd(&data);
> > >                 break;
> > >         default:
> > > -               ret =3D -EOPNOTSUPP;
> > > +               ret =3D ublk_handle_non_batch_cmd(cmd, issue_flags);
> >
> > We should probably skip the if (data.header.q_id >=3D
> > ub->dev_info.nr_hw_queues) check for a non-batch command?
>
> It is true only for UBLK_IO_UNREGISTER_IO_BUF.

My point was that this relies on the q_id field being located at the
same offset in struct ublksrv_io_cmd and struct ublk_batch_io, which
seems quite subtle. I think it would make more sense not to read the
SQE as a struct ublk_batch_io for the non-batch commands.

Best,
Caleb

>
> >
> > > +               break;
> > >         }
> > >  out:
> > >         return ret;
> > > @@ -4163,9 +4200,13 @@ static int ublk_ctrl_add_dev(const struct ublk=
srv_ctrl_cmd *header)
> > >
> > >         ub->dev_info.flags |=3D UBLK_F_CMD_IOCTL_ENCODE |
> > >                 UBLK_F_URING_CMD_COMP_IN_TASK |
> > > -               UBLK_F_PER_IO_DAEMON |
> > > +               (ublk_dev_support_batch_io(ub) ? 0 : UBLK_F_PER_IO_DA=
EMON) |
> >
> > Seems redundant with the logic below to clear UBLK_F_PER_IO_DAEMON if
> > (ublk_dev_support_batch_io(ub))?
>
> Good catch.
>
> >
> > >                 UBLK_F_BUF_REG_OFF_DAEMON;
> > >
> > > +       /* So far, UBLK_F_PER_IO_DAEMON won't be exposed for BATCH_IO=
 */
> > > +       if (ublk_dev_support_batch_io(ub))
> > > +               ub->dev_info.flags &=3D ~UBLK_F_PER_IO_DAEMON;
> > > +
> > >         /* GET_DATA isn't needed any more with USER_COPY or ZERO COPY=
 */
> > >         if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_Z=
ERO_COPY |
> > >                                 UBLK_F_AUTO_BUF_REG))
> > > @@ -4518,6 +4559,13 @@ static int ublk_wait_for_idle_io(struct ublk_d=
evice *ub,
> > >         unsigned int elapsed =3D 0;
> > >         int ret;
> > >
> > > +       /*
> > > +        * For UBLK_F_BATCH_IO ublk server can get notified with exis=
ting
> > > +        * or new fetch command, so needn't wait any more
> > > +        */
> > > +       if (ublk_dev_support_batch_io(ub))
> > > +               return 0;
> > > +
> > >         while (elapsed < timeout_ms && !signal_pending(current)) {
> > >                 unsigned int queues_cancelable =3D 0;
> > >                 int i;
> > > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_=
cmd.h
> > > index cd894c1d188e..5e8b1211b7f4 100644
> > > --- a/include/uapi/linux/ublk_cmd.h
> > > +++ b/include/uapi/linux/ublk_cmd.h
> > > @@ -335,6 +335,22 @@
> > >   */
> > >  #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
> > >
> > > +
> > > +/*
> > > + * Support the following commands for delivering & committing io com=
mand
> > > + * in batch.
> > > + *
> > > + *     - UBLK_U_IO_PREP_IO_CMDS
> > > + *     - UBLK_U_IO_COMMIT_IO_CMDS
> > > + *     - UBLK_U_IO_FETCH_IO_CMDS
> > > + *     - UBLK_U_IO_REGISTER_IO_BUF
> > > + *     - UBLK_U_IO_UNREGISTER_IO_BUF
> >
> > Seems like it might make sense to provided batched versions of
> > UBLK_U_IO_REGISTER_IO_BUF and UBLK_U_IO_UNREGISTER_IO_BUF. That could
> > be done in the future, I guess, but it might simplify
> > ublk_ch_batch_io_uring_cmd() to only have to handle struct
> > ublk_batch_io.
>
> Agree, and it can be added in future.
>
>
>
>
> Thanks,
> Ming
>
