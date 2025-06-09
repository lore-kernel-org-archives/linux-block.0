Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A0321B191
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490756; cv=none; b=dNgpnDz/6PerHntGvMGBsM4K06nFDu50ndVBwTjBgqNz+F9LBrz9K1p/liiqbLreZPpcYlkMuT31MPTHKvu888KopQjTDH5tPeomlZ/UeDaVC1yFoWgi9Gb170VXzxlGvw+E0qYowv3UCatEVZE1KZ36Dvx6HxLzD3JgywJTa18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490756; c=relaxed/simple;
	bh=ATt6ATy6Lqh0txchaGEMYytbFUNGSFFoWwL92Af/6mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOCWu+iPVIqsbTe7e/lYMcDAIiAM/MoYDwb84Kj72d7Df02rXimimIuTDjbzd0+wYdG50AfRiX/9msQa3FqN+jJDeE4J96QKkDosEK1b5NivwJ6zQCOQPThBmaf3oQla6AedEd1S/NsGgp0HdwE4ApQW2PMwBTaLtv5/QVvp2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fN6es8C9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fN6es8C9"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3138e64fc73so137482a91.2
        for <linux-block@vger.kernel.org>; Mon, 09 Jun 2025 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749490754; x=1750095554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wk9z38XYfZ9E+J96UPB8W5gFRQY4tlfNsQTjUtCWyYU=;
        b=fN6es8C9oFAFNcIRN62KUZH5yN70SDGZWGV64UfdbXqX8bemeb7O22XdC5XHYgK7JS
         effEZlu/Om/JjuL1TWL0jTGNNVEJ/VWePvOfhp5SYjG+WMD40VbVfnalHnAK2il44vyD
         /PqMQBuQjpPZ9/tDDNQjeyIOiLyanWA2zwvrzf8z6Uv6M/hP+7QPPUlvdQLg6I6KnxSg
         VFbC1wIdrL5fhLUiT6DuRGwqxPvKD3VpKgpEDoRzJhpSZuV5/vTxU4BNR129peOWNBy6
         TmsEh1I1JZIk3YTvrJ1TU4y1v5SD3J0GQgYw1oPL2vnD4q3UH/V7J8PAU/CpMtJYb7dw
         FDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749490754; x=1750095554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wk9z38XYfZ9E+J96UPB8W5gFRQY4tlfNsQTjUtCWyYU=;
        b=TO/Ro7Dq2IzFoNgfSiYwyRw0xwIuzfl0+4IdClrek3awqh7uPt5NiI3HOZd8/EEHht
         gOzEJgfw44b3jVYuY7jT9HxpqDxe108aArf6zldcYLlE9rf0Y7df2J6XdcsFIAHbbzO1
         uVEXwVQPcCXsPi9WVBFYN+O1w6RVsFAK62hZ1HiUHIkh/zg299zolf/Cf/jpg+OMgjY5
         aG5JRelRLOy6I4GQaXgQnHr+gU7XJSTogPb780TR6aaG38npe9jb91QxjbW/1qazpX84
         qY23MRAitn/YSm2o9NXlc1YSKewNSU+dK4mjWfPzKvZKR9Rd7NnkZkCXF0PER7tJ8Jdh
         vvlw==
X-Forwarded-Encrypted: i=1; AJvYcCUmLA51oNOYkYVuzTV/72DR3UpIf5C2lo0hQq5cHXQhXwyO3sXmbldF46BMrDYk3+hRFaZL1j+QifL4xQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXQTnqXA0XVfNfaXvM3VKHvb9KC/+kgWALX9hgrEobN8EK+Xlz
	TZGQuio7pvj+hX7WMw5kBr+wGsZ6+2WPdPhlhtTmBBjF+CoQc2ZWABCovBYA1Mgdi2ne9m0j10O
	PSYZ8NCApvZx4Nfg+G7k6XQU1oBWq47TBgPADL/2Ciw==
X-Gm-Gg: ASbGnctmag5EZzb0jiNmK1skbhF6tBYfFhgCMWdumpVHVCUQtX3D5priP8I5jdcpty7
	yqE8selYVuxGkXjG1PnAETVGu1lVC+VffD3AbWhczXtPmb8P2aiTPqHRclOIbJBUIMDL33I75O1
	RIjRiknlqXUeZ5UQkfwwvFCJLVyQ1eDzBC8GdZxKhyFBs=
X-Google-Smtp-Source: AGHT+IGOj/oaoRoWYxj4b+vqkPEHknef+yfnwdu6HZOaHpv/pYaE2Z392PZERF1ph2m4KO54ER2cQFE4B6Btc+6jz5k=
X-Received: by 2002:a17:90b:350f:b0:312:639:a06d with SMTP id
 98e67ed59e1d1-3134e413149mr7804497a91.5.1749490753799; Mon, 09 Jun 2025
 10:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606214011.2576398-1-csander@purestorage.com>
 <20250606214011.2576398-7-csander@purestorage.com> <aEaOh5R_FyMzPNIJ@fedora>
In-Reply-To: <aEaOh5R_FyMzPNIJ@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 9 Jun 2025 10:39:02 -0700
X-Gm-Features: AX0GCFutEPyCvSNULu-q2ddLkAunNXYvwwMZde-2jo9yELtc_D43yL7BfU5DqRc
Message-ID: <CADUfDZoT_eooYR0=Md2w9X0hwAuRZ7UFubTQ2Y7TwOzk8PubJg@mail.gmail.com>
Subject: Re: [PATCH 6/8] ublk: allow UBLK_IO_(UN)REGISTER_IO_BUF on any task
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 12:34=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
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
>
> Yeah, the behavior looks correct, but I'd suggest to validate the q_id
> too for making code more robust.

What value do you see in validating the q_id parameter? It's not used,
only the addr parameter is. I would rather document that the ublk
server doesn't need to provide q_id nor tag for a
UBLK_IO_UNREGISTER_IO_BUF command.

>
> Also you removed ublk_support_zero_copy() check for unregistering io buff=
er
> command, which isn't expected for this patch.

I can move that change into its own patch. I don't think the check
adds much value, though. There's nothing that requires the registered
buffer index passed in addr to belong to this q_id (or even this ublk
device). If you do want to provide a sanity check for the ublk server
that the ublk device supports zero-copy, I would rather just check the
flags on the ublk_device so the ublk server doesn't have to provide a
q_id.

>
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
>
> Maybe you can move UBLK_IO_UNREGISTER_IO_BUF handling here, which seems
> more readable.

I would rather allow the ublk server to omit the q_id and tag
parameters for UBLK_IO_UNREGISTER_IO_BUF since they aren't really
used, and there's no enforcement that they correspond to the
registered buffer index (addr). In which case, there isn't any
io->task to check here. It would also be nice to skip the overhead of
looking up the ubq and io for UBLK_IO_UNREGISTER_IO_BUF since they
aren't used.
In the following patch I add an optimized case for
UBLK_IO_REGISTER_IO_BUF when called on the daemon task, which is why I
duplicate the UBLK_IO_REGISTER_IO_BUF handling here in this patch. But
UBLK_IO_UNREGISTER_IO_BUF doesn't need this special case, so I don't
see the need to handle UBLK_IO_UNREGISTER_IO_BUF in 2 different
places.

Best,
Caleb
