Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7B6433A4
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 03:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745723672; cv=none; b=fn81a8BFOrHPbIbBOydXXoA65T+azgWtL5UdWhFfSzr2bY5uPSKiqW67aj1riMKg25U/mnY00lBhJq3i7LmX+42JHXErYCMZ3WPWluHdl6jf7et6O0+wyrdjnNFzM0Jk50e2aLeRA1Q2hLcyd1U4I11c3cRF2DxuXvd/31D1b6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745723672; c=relaxed/simple;
	bh=nEmVHP8nDWjET/l2lxbl9MAlyRvjIlyfQ/P67O0lnkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z067Qup0N4Xba0JUcFHNCqRVgzPBGaCW7H3VsanVPkGsq2Bple7UVzGrJe+Z79X2sw2b9Z1bQKcNo/AcMH4arI8AmukIRfzxbq/qV/kQP2FNePmwUZ6Mtfo63PYtxN41S/ktV6GB/GbuinTckkWOrQDWS+r54i51EUgqwPtYRP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bftVqnNw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bftVqnNw"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2241c95619eso7202315ad.0
        for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 20:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745723669; x=1746328469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3a+Czqnav4aHUplLmd7WlSB+YRFMlvhGPZuL0UU9Q3A=;
        b=bftVqnNwKGbgqubzoJUJuBR3sAgEWzH4ufsiPaTKGO+1hf4fdzKtAMyaPGHTEwb5Lk
         xknUDx5nvyKT+JVVKDiFj8fit1yZzRj6PAv9USF2gT1Yu1VvTDCmsA6RLL5KoC//Olf0
         TBKHt4ekzw5SE1tn/FayZ221TAqF4REgBG8Gju9+rAABQ5JU+M2PAMIl2LU1HR1ecOOO
         KNsf7vDbTGvR6INe29PMJNgrm3VpKViEZ+32Wc1nYg5UQqhkcEE2edypGkAbHJE7rSJu
         BLCXG2nGeEjsAu3tTrcR44G5WsUDLtqaPTaB2/fg+S7xQCAVmQvqCw7xGMAA5NtSSu/V
         1btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745723669; x=1746328469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3a+Czqnav4aHUplLmd7WlSB+YRFMlvhGPZuL0UU9Q3A=;
        b=QXxZWkb6TD+1vgjyQ0bzUeIjsweNmUFDvBPLAkZiHRwupLLjkzSVeLcu9LEVazda7T
         aPFUogqK1aVL54M44NbWiuFYVokgT7nlfcSHDjJ8wPNEGxS12LkUCn1zIWZJOTrQZOkE
         WtHyRflP4Re1pOQEmv4erixyd0l+qpcbg3QYDWDHGWFirTOZne9zbFVSA+gL7QWyxUcs
         25esOmYBbhONJyz/JT+saHNGRudBot3D59te3rMY7SgTlrJm01YesXpl2XH6rDNP/zd1
         0KrtA884bTyB146O0uPTwDaqbREXjqcligx6yMQ08yhjnhwY2W0H4h7dTQ8FQelpOKd3
         dW8g==
X-Forwarded-Encrypted: i=1; AJvYcCV6GY8U3sKZNegrsSmGqc8/xUEm2y3DV7h94efffrnxLhqby9JWNaHgizoQJOlYr8P6/Xf+GkZb57S6/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHXBSHt5WOExXdCQjHAabAUWd1EUo49cUwhApbVWU/yMFsia3I
	9N0YeHhJZaHaYT5qjTEK1GXksDe+0Vq7L04uq+SiM/a5l721x3rUvP/1dhQSbweMKILmMxC4N+2
	vvKOofWZgyT0vkPo8ByZmXD3aLEGUKu7IjQosew==
X-Gm-Gg: ASbGncs8Bpth+ecFwZKJN7PepXlrm4466fEeg4kpj8S3vWOoMsAGBfebHFZaRfLKM9V
	EL4A4ZWGuWuTsf7J8nfoYsW22yIrIktz7g7a1nkbkPwpRCsC4rdvVLZapCOCnQZ95JCkgWcvVph
	ifeKuONRF1WLYruyjpEFfH
X-Google-Smtp-Source: AGHT+IE5veedSEGxZ1S/elwHRJyJtQ7adeSjuIQDcs5VImoH3gMhb51Jai5LgNIsQp8mcS/sPAZEUY7273wDVbLTbCI=
X-Received: by 2002:a17:902:da8e:b0:223:5e86:efa9 with SMTP id
 d9443c01a7336-22dbf5fd47cmr41846205ad.8.1745723669302; Sat, 26 Apr 2025
 20:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426094111.1292637-1-ming.lei@redhat.com> <20250426094111.1292637-3-ming.lei@redhat.com>
 <CADUfDZrF71gPfCghE+wNyLXTmtAUprMfpo1XtP1C7kxx-=eP+w@mail.gmail.com> <aA2KPuQl1_hTlplG@fedora>
In-Reply-To: <aA2KPuQl1_hTlplG@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 26 Apr 2025 20:14:18 -0700
X-Gm-Features: ATxdqUEldfi2esHniqSxQjCgNp2BmabJLimNf-AlQ-JRDWLHoUbf2upcx0K2sEs
Message-ID: <CADUfDZqZ_9O7vUAYtxrrujWqPBuP05nBhCbzNuNsc9kJTmX2sA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ublk: enhance check for register/unregister io buffer command
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2025 at 6:37=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Sat, Apr 26, 2025 at 01:38:14PM -0700, Caleb Sander Mateos wrote:
> > On Sat, Apr 26, 2025 at 2:41=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > The simple check of UBLK_IO_FLAG_OWNED_BY_SRV can avoid incorrect
> > > register/unregister io buffer easily, so check it before calling
> > > starting to register/un-register io buffer.
> > >
> > > Also only allow io buffer register/unregister uring_cmd in case of
> > > UBLK_F_SUPPORT_ZERO_COPY.
> >
> > Indeed, both these checks make sense. (Hopefully there aren't any
> > applications depending on the ability to use ublk zero-copy without
> > setting the flag.) I too was thinking of adding the
> > UBLK_IO_FLAG_OWNED_BY_SRV check because it could allow the
> > kref_get_unless_zero() to be replaced with the cheaper kref_get(). I
> > think the checks could be split into 2 separate commits, but up to
> > you.
>
> Let's do it in single patch for making everyone easier.
>
> >
> > >
> > > Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 23 ++++++++++++++++++++++-
> > >  1 file changed, 22 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 40f971a66d3e..347790b3a633 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -609,6 +609,11 @@ static void ublk_apply_params(struct ublk_device=
 *ub)
> > >                 ublk_dev_param_zoned_apply(ub);
> > >  }
> > >
> > > +static inline bool ublk_support_zero_copy(const struct ublk_queue *u=
bq)
> > > +{
> > > +       return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
> > > +}
> > > +
> > >  static inline bool ublk_support_user_copy(const struct ublk_queue *u=
bq)
> > >  {
> > >         return ubq->flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_C=
OPY);
> > > @@ -1950,9 +1955,16 @@ static int ublk_register_io_buf(struct io_urin=
g_cmd *cmd,
> > >                                 unsigned int index, unsigned int issu=
e_flags)
> > >  {
> > >         struct ublk_device *ub =3D cmd->file->private_data;
> > > +       struct ublk_io *io =3D &ubq->ios[tag];
> >
> > I thought you had mentioned in
> > https://lore.kernel.org/linux-block/aAmYJxaV1-yWEMRo@fedora/ wanting
> > to the ability to offload the ublk zero-copy buffer registration to a
> > thread other than ubq_daemon. Are you still planning to do that, or
> > does the "auto-register" feature supplant the need for that?
>
> The auto-register idea is actually thought of when I was working on ublk
> selftest offload function.
>
> If this auto-register feature is supported, it becomes less important to
> relax the ubq_daemon limit for register_io_buffer command, then I jump
> on this feature & post put the patch.
>
> But I will continue to work on the offload test code and finally relax
> the limit for register/unregister io buffer command, hope it can be
> done in next week.
>
> > Accessing
> > the ublk_io here only seems safe when on the ubq_daemon thread.
>
> Both ublk_register_io_buf()/ublk_unregister_io_buf() just reads ublk_io o=
r
> the request buffer only, so it is just fine for the two to run from other
> contexts.

Isn't it racy to check io->flags when it could be concurrently
modified by another thread (the ubq_daemon)?

Best,
Caleb

>
> >
> > >         struct request *req;
> > >         int ret;
> > >
> > > +       if (!ublk_support_zero_copy(ubq))
> > > +               return -EINVAL;
> > > +
> > > +       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> > > +               return -EINVAL;
> >
> > Every opcode except UBLK_IO_FETCH_REQ now checks io->flags &
> > UBLK_IO_FLAG_OWNED_BY_SRV. Maybe it would make sense to lift the check
> > up to __ublk_ch_uring_cmd() to avoid duplicating it?
>
> Good point.
>
>
> Thanks,
> Ming
>
