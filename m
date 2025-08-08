Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9501DE8A4
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754676251; cv=none; b=rxJfyocQcQS7GoPqOvFOGYXkSZAvsdc6J1pKaxYOzjFEuv/6H3LMzN6w4TP0fFOEMoVgd0S16WGheOUk2c3l0+gYEvzahvQ8PpCaXKUpw8jZKoNcwLORU32OHMEM8JXkvxCWUZRX0eeGnVsLwtlBVde3IhwDXvcz7UlyMwSW9zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754676251; c=relaxed/simple;
	bh=S8Tu0zazISBc4SKdYPPuzDxu1aVvArA/JTP2EOFHPQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzFwRb/bl+0gxGMFq0IovrrDf2PJpvG/tj256s6yJFBGCInLVLl/8YkJllqxanYAxvCLozOcWPdc6m7SL6fBaZ7bgab+mV1kJxx8MuWE99XbGRyODfZh2C2buKrggbGrC6GrlM1Vm9LvuTz7A3YIs9IeUdcFoM4EKYloU1Z9/f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MLHY0T9Q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MLHY0T9Q"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2400a0c3cf7so4323085ad.0
        for <linux-block@vger.kernel.org>; Fri, 08 Aug 2025 11:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1754676249; x=1755281049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evY4+eDXJzJxiwKDLdddSuNC/hZO/qDyeUCoXab8qto=;
        b=MLHY0T9QY7O+vT21bkLAa1QuWiZmr3BSo6LgUb7ADRUla1Z4DWPTBQI+GbTh5AezA0
         Tl585wlJw+7Nw67LFo9ITyoRpoX6VoZM9J31VVwJU61Z4Rb52ig1v7WHQoAEvqJOycHO
         Ko3P1bf1wscoXSxzsY1gKN8/W/wjRLcykJrK9kYRWwjO9oKtL1Ms2nyXswQJR/DZ0QUc
         umwJ1R3SB7DYQlUugf8FqZHDJvsiWQ1TL9ikPe/VdW008nMofyPlviYKw3+j3EWIXv4y
         aUxa3lBBPkrzdskBDONNZfefHE2cU9AfSRoFnzJLDpgariA9f2FBtnl6EDTVo1/nuDfP
         YcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754676249; x=1755281049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evY4+eDXJzJxiwKDLdddSuNC/hZO/qDyeUCoXab8qto=;
        b=rYksduFRjFFe+2mco3RdSjh+W4j8LOqe3oGvrvgGaie8fknfrxwr6Y3DltkyZJsONJ
         jrzLMeSlMaCFY4IgKj0RKDSrJnSgKxoMLQppu5cRyt1d5rxPSns0UhRQ5ksgvdo6b7lU
         KiaBsbkkJ2W6mjJkrxzcDA/wYyWsk1pcvi365+CrWtHY28mN65nluSo1QRD/+UOtXLMx
         epy/ULJwuGXosK1wRKgs3TRG7O5KENxqu3pUBo088FdkRUS76U2Mss74nkGrw3tyqI3I
         Y5jffJq4Ahg/j0RyoEQnq4EF2uv+YOj5HTjLR7GbuCIzsKS4mqn72nLI9mKocaiudD3L
         /Q+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3uDxnCr0VIBSWRBC9KcYnXUS9oNpRad+LR9hWmvQIK6vALGvyVOJgyrmz84KIbYrVn/GjnEexOHzcdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6o8h7DBhNruC5QNzXTdy9dK7F2/NSz2QuDz8hpdABk2/6Ao/W
	2s0Fo86mSc7yRplWy6DUyR1vEwbPR4q9CmolPeyHcWlRZ2AgxaZvZzsCKLCXjDT22E18g09WR+g
	FB8Au7Uvb9LcfQJ6PedmbUlnNRYOZJvLDAXgL1adJPw==
X-Gm-Gg: ASbGncuVlamOksdYaMZb7Egm4yuWMG6NS6w0LckL1W1NiaRVNGhmR45GnEyMzGCLjSt
	d65+5EqDrrPzmdJNXfMwtWEGRmdVNZ32Vv6LQG5sDeAQRYNOjQhfv4qzxEDom7NDYQgcfnNaJtn
	Mo3YcLhxhHAHvZwvA8o5hYPoI/1DqcTqHCFofQGljyJCxEKD4bM6b5iAo3xGxuJ3uBxlIbDrig6
	Eismg==
X-Google-Smtp-Source: AGHT+IGVxnKjIynfdZLWqtSh9fHzYltbcrWG6UxwdhrKSSzs1MbOC7aPSN3TBrYKqGm6MtfCPX3BJLY6GvVEfO22dA0=
X-Received: by 2002:a17:902:fc48:b0:240:1879:c2fd with SMTP id
 d9443c01a7336-242c25a352dmr28055195ad.2.1754676249124; Fri, 08 Aug 2025
 11:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808155216.296170-1-csander@purestorage.com> <aJY7fPmOLMe7T5A7@dev-ushankar.dev.purestorage.com>
In-Reply-To: <aJY7fPmOLMe7T5A7@dev-ushankar.dev.purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 8 Aug 2025 14:03:57 -0400
X-Gm-Features: Ac12FXyvrSy6RuKGNG4Qv3aEGNsmQMPDvbbXUgyu660PYbxlVuK2l0QXeKWdURI
Message-ID: <CADUfDZqz1R=aTuyRhsVjpJnoUgXBgsf1Jkg4qX_sn+NtP4TPeQ@mail.gmail.com>
Subject: Re: [PATCH] ublk: check for unprivileged daemon on each I/O fetch
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 2:01=E2=80=AFPM Uday Shankar <ushankar@purestorage.c=
om> wrote:
>
> On Fri, Aug 08, 2025 at 09:52:15AM -0600, Caleb Sander Mateos wrote:
> > Commit ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue
> > daemon") allowed each ublk I/O to have an independent daemon task.
> > However, nr_privileged_daemon is only computed based on whether the las=
t
> > I/O fetched in each ublk queue has an unprivileged daemon task.
> > Fix this by checking whether every fetched I/O's daemon is privileged.
> > Change nr_privileged_daemon from a count of queues to a boolean
> > indicating whether any I/Os have an unprivileged daemon.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > Fixes: ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue=
 daemon")
>
> Nice catch!
>
> > ---
> >  drivers/block/ublk_drv.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 6561d2a561fa..a035070dd690 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -233,11 +233,11 @@ struct ublk_device {
> >
> >       struct ublk_params      params;
> >
> >       struct completion       completion;
> >       unsigned int            nr_queues_ready;
> > -     unsigned int            nr_privileged_daemon;
> > +     bool                    unprivileged_daemons;
> >       struct mutex cancel_mutex;
> >       bool canceling;
> >       pid_t   ublksrv_tgid;
> >  };
> >
> > @@ -1548,11 +1548,11 @@ static void ublk_reset_ch_dev(struct ublk_devic=
e *ub)
> >               ublk_queue_reinit(ub, ublk_get_queue(ub, i));
> >
> >       /* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
> >       ub->mm =3D NULL;
> >       ub->nr_queues_ready =3D 0;
> > -     ub->nr_privileged_daemon =3D 0;
> > +     ub->unprivileged_daemons =3D false;
> >       ub->ublksrv_tgid =3D -1;
> >  }
> >
> >  static struct gendisk *ublk_get_disk(struct ublk_device *ub)
> >  {
> > @@ -1978,16 +1978,14 @@ static void ublk_reset_io_flags(struct ublk_dev=
ice *ub)
> >  /* device can only be started after all IOs are ready */
> >  static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_que=
ue *ubq)
> >       __must_hold(&ub->mutex)
> >  {
> >       ubq->nr_io_ready++;
> > -     if (ublk_queue_ready(ubq)) {
> > +     if (ublk_queue_ready(ubq))
> >               ub->nr_queues_ready++;
> > -
> > -             if (capable(CAP_SYS_ADMIN))
> > -                     ub->nr_privileged_daemon++;
> > -     }
> > +     if (!ub->unprivileged_daemons && !capable(CAP_SYS_ADMIN))
> > +             ub->unprivileged_daemons =3D true;
>
> Shorter:
>
> ub->unprivileged_daemons |=3D !capable(CAP_SYS_ADMIN);

I was trying to avoid the capable() call if unprivileged_daemons was
already set. But maybe that's not a common case and it's not worth
optimizing?

Best,
Caleb

>
> >
> >       if (ub->nr_queues_ready =3D=3D ub->dev_info.nr_hw_queues) {
> >               /* now we are ready for handling ublk io request */
> >               ublk_reset_io_flags(ub);
> >               complete_all(&ub->completion);
> > @@ -2878,12 +2876,12 @@ static int ublk_ctrl_start_dev(struct ublk_devi=
ce *ub,
> >       ub->dev_info.ublksrv_pid =3D ublksrv_pid;
> >       ub->ub_disk =3D disk;
> >
> >       ublk_apply_params(ub);
> >
> > -     /* don't probe partitions if any one ubq daemon is un-trusted */
> > -     if (ub->nr_privileged_daemon !=3D ub->nr_queues_ready)
> > +     /* don't probe partitions if any daemon task is un-trusted */
> > +     if (ub->unprivileged_daemons)
> >               set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> >
> >       ublk_get_device(ub);
> >       ub->dev_info.state =3D UBLK_S_DEV_LIVE;
> >
> > --
> > 2.45.2
> >
