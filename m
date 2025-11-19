Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28771F4606
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763519964; cv=none; b=PdyyuAfvDuFkE0wmPOa0OiiPAmLqZL/TkF0dpmiT0qi8HZMRXJ+NGo5kFR/YvNARan1CVL36xHhIjGhgERQcC0FWRJEH2oBC2FLlEoNrppIQrnUQhlZNKtKNC82OoRVK75o7GMOVIwtBdiduwIMWj+yOq4iMh7Hjf1f8EmSFNE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763519964; c=relaxed/simple;
	bh=ZZoAqwk2WnHV6JTuFhk5kmLwnSIqpyDYVL7YdI513lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjKfSxVPMbYQaaOVcqJ2z+Try+caIheVGAyNSe6GYJ/g1cDmwTzdvYRdJ5Ed2sbMNpQlzNw1LvVqAEUbpguGqP/iYBUsb7mMYURQP/WySQUrT/qjB9AqfcPWFZGQlUjs8N+B1wiwVXjktChn3R7vw42HruRfgYYW1ijIYJ0yB4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SnKjOWVY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SnKjOWVY"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29806bd4776so7845905ad.0
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 18:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763519961; x=1764124761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaBWvDvzM70iqBEAfgy+gw+WEDaYxsaLDCuK4H4pjjs=;
        b=SnKjOWVYJXXDIw1eglHUZZdZ5TeZLoiojQP8ryI5mayo/4jlNmFkK2wNb7RXITp6y+
         PAhiaAiCkbL+0rm/QucmPXTPJYiOLdcfYbhYCG1goij3IHn9thnEkUJ2JdzCfJ2hwbk3
         F0hmbAjxIMRsZYClJ8AJQSnNkzAGRdNo9wGSGDReBo0FXt0XQsvUw3TUWIdSl0EsW6P5
         2IlGNB/uXIreggf6jk0Rss9US4t0NVGjXWt2yewH8nYP0KTyu5kRzKQ0Eos3wgA98nba
         YoHmmzxSgXPEC7U0RsMk0Qz+qnHr58GOahKTpkL8ei/3qSHdgL9hsoOprbG2O+KRjBVS
         2sGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763519961; x=1764124761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FaBWvDvzM70iqBEAfgy+gw+WEDaYxsaLDCuK4H4pjjs=;
        b=xTBJe1dVerDBkREXsVi5gFK11+Nr0vSTpwMJXeyKPnooY7bz9SOGGj8tzvVVrhmyLd
         K7LAVwFo/vGBea6clOTnbXzuUwgUug8RlDC4BD6RJIHNFD9yS/Q/sXEiRshITxFcuz+v
         fjXm2z7X9gyCQG0m6iDp1eRAU6hO/QjcFfaqlN0Q7fYyBhjet5gb0hMCJUoNvM+RERAZ
         OPwqq3lwvyvJB1f7o1J+qWRHTML5wJKWPBR081eEEOW/V1PYnW1Bv5H4BlQ6YftqZTy+
         SBqU8USISQVxSBnq5OeYpw12THyP84U+YBXMRbMNn+xytwMSY7eKPDSsPIshS7bzuAvu
         8ghg==
X-Forwarded-Encrypted: i=1; AJvYcCW5EtKbTrJSM65dVCsiprfDbswW09VxlBrg/H7PJszVa4S5FPmBvGm+f8Bb+EAlAvCea7uHzCWpaL3phw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzebSlruidsYiM+K/MPGjpgtfBMJrXz2UBlfvzBjKFyiWFR/hB4
	mmFFBhqDNS4wXERvgGujYQz98XHSRGDPOcOMd4QNiiMXJHmEkz2MAlo/nRWjckrutmDO2eJyJGm
	n1GYneq/32A7DPcZiKz/CSHtT3mwSyZrpB909lB9J9g==
X-Gm-Gg: ASbGncsgvt9cMv7t0pHRbsWrB6y9E4M2cUoq4UFxZPGG48pOVN6qWupcvTf9wGQ0PwI
	MP/sd//YkJ6QTIXelUr8DdFc8TkzbttCruvuglSf/E5pZLU7OCxkFw8qm8FT2Ta2hZ4XzzJpq5v
	y1vsLQIg/msDfTgKdgT1KwHBnmqglyD7aB/VA0mH7Ow0eeNn5YyXsqnkNDGZ3RyTnDD6YprhMyW
	Y05iyoRcwH9eLcp/QJ9aG2OEmXM8NBRM2ZGKZMyRvTJ2zICNyWtpNNSYE8q/+IQDVAVPbvH5wK1
	Jp5NSUk=
X-Google-Smtp-Source: AGHT+IE4RyUie7nDvIdMI1jBIJRm0MlQstrSzGlYStnuihA41UI33Jw3KOcfnmRdmEaE29aFoNtX7cynsrkVpaZSDxg=
X-Received: by 2002:a05:7022:6297:b0:11a:c044:ec44 with SMTP id
 a92af1059eb24-11c78562aa4mr1654256c88.0.1763519960812; Tue, 18 Nov 2025
 18:39:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112093808.2134129-1-ming.lei@redhat.com> <20251112093808.2134129-10-ming.lei@redhat.com>
 <CADUfDZpoeUF+dAm4AtjzC-+BOwwZr2CnTgcZoPAE_4KNNsmoXw@mail.gmail.com>
In-Reply-To: <CADUfDZpoeUF+dAm4AtjzC-+BOwwZr2CnTgcZoPAE_4KNNsmoXw@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 18 Nov 2025 18:39:09 -0800
X-Gm-Features: AWmQ_bmO5V5fz3DddZISmrIKBkexPRmrFacnmb8SYB7t-ziyPwuC2qugA4xiiYw
Message-ID: <CADUfDZo0NB39mgp-4zpL63bGi6WtsEsfxZ95Jrj6RBqQ60NZug@mail.gmail.com>
Subject: Re: [PATCH V3 09/27] ublk: add new batch command UBLK_U_IO_PREP_IO_CMDS
 & UBLK_U_IO_COMMIT_IO_CMDS
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 6:37=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Wed, Nov 12, 2025 at 1:39=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wr=
ote:
> >
> > Add new command UBLK_U_IO_PREP_IO_CMDS, which is the batch version of
> > UBLK_IO_FETCH_REQ.
> >
> > Add new command UBLK_U_IO_COMMIT_IO_CMDS, which is for committing io co=
mmand
> > result only, still the batch version.
> >
> > The new command header type is `struct ublk_batch_io`, and fixed buffer=
 is
> > required for these two uring_cmd.
> >
> > This patch doesn't actually implement these commands yet, just validate=
s the
> > SQE fields.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 107 +++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/ublk_cmd.h |  49 ++++++++++++++++
> >  2 files changed, 155 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index c62b2f2057fe..5f9d7ec9daa4 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -85,6 +85,11 @@
> >          UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> >          UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> >
> > +#define UBLK_BATCH_F_ALL  \
> > +       (UBLK_BATCH_F_HAS_ZONE_LBA | \
> > +        UBLK_BATCH_F_HAS_BUF_ADDR | \
> > +        UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK)
> > +
> >  struct ublk_uring_cmd_pdu {
> >         /*
> >          * Store requests in same batch temporarily for queuing them to
> > @@ -108,6 +113,12 @@ struct ublk_uring_cmd_pdu {
> >         u16 tag;
> >  };
> >
> > +struct ublk_batch_io_data {
> > +       struct ublk_device *ub;
> > +       struct io_uring_cmd *cmd;
> > +       struct ublk_batch_io header;
> > +};
> > +
> >  /*
> >   * io command is active: sqe cmd is received, and its cqe isn't done
> >   *
> > @@ -2520,10 +2531,104 @@ static int ublk_ch_uring_cmd(struct io_uring_c=
md *cmd, unsigned int issue_flags)
> >         return ublk_ch_uring_cmd_local(cmd, issue_flags);
> >  }
> >
> > +static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
> > +{
> > +       const u16 mask =3D UBLK_BATCH_F_HAS_BUF_ADDR | UBLK_BATCH_F_HAS=
_ZONE_LBA;
> > +       const unsigned header_len =3D sizeof(struct ublk_elem_header);
> > +
> > +       if (uc->flags & ~UBLK_BATCH_F_ALL)
> > +               return -EINVAL;
> > +
> > +       /* UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK requires buffer index */
> > +       if ((uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) &&
> > +                       (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR))
> > +               return -EINVAL;
> > +
> > +       switch (uc->flags & mask) {
> > +       case 0:
> > +               if (uc->elem_bytes !=3D header_len)
> > +                       return -EINVAL;
> > +               break;
> > +       case UBLK_BATCH_F_HAS_ZONE_LBA:
> > +       case UBLK_BATCH_F_HAS_BUF_ADDR:
> > +               if (uc->elem_bytes !=3D header_len + sizeof(u64))
> > +                       return -EINVAL;
> > +               break;
> > +       case UBLK_BATCH_F_HAS_ZONE_LBA | UBLK_BATCH_F_HAS_BUF_ADDR:
> > +               if (uc->elem_bytes !=3D header_len + sizeof(u64) + size=
of(u64))
> > +                       return -EINVAL;
> > +               break;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int ublk_check_batch_cmd(const struct ublk_batch_io_data *data)
> > +{
> > +
> > +       const struct ublk_batch_io *uc =3D &data->header;
> > +
> > +       if (!(data->cmd->flags & IORING_URING_CMD_FIXED))
> > +               return -EINVAL;
> > +
> > +       if (uc->nr_elem * uc->elem_bytes > data->cmd->sqe->len)
>
> sqe->len should be accessed with READ_ONCE() since it may point to
> user-mapped memory.

Actually, is there any point in this check since sqe->len is no longer
used anywhere?
