Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600EB3254BE
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 02:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763433534; cv=none; b=JWb44C4zO63htsyNu+yxOh2jd1B3C1p4U6OYU4JWLivTMhvQ7K8gdsO77H0xKzmGd8HyyykKEShOsRxP3j/SyqaJ8OUrg05J7ViHmhtjCKvK2y+1tmWAQPAyxU6SlJByFkjEddxiQ+ME9ZDgUCvFwj2UHOIYiAKoVrjJyO7sFeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763433534; c=relaxed/simple;
	bh=bku0yDtsG2IJtsWS8hc3FBSeHhZ4yDJx2Tie94YlCvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhuFgV8UacG04iJGDrAKmZo3YfZf6jEY62AV6biZHxP2m+UhV45GX7ReWDcl6TaEjKr9F1QFNMOP1p0vcsmy1E2eQR0fdNIG7TqBlL3BiwJh4QpRUkn7Ht2zmlMgutnQANYInquohEewAsQEUBE5gAzntHkVzoTqxkm0ptZVkBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KWlQzdkc; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KWlQzdkc"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b8f70154354so474737a12.2
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 18:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763433531; x=1764038331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3p/OcMvX1uSSN/v4MzlMRu+/W/W+pwcNgy10pfRDDw=;
        b=KWlQzdkcP7ZoupkU3YKEiyQlplQ2W3Mp23mNmVIEklOKJwU9M9soSZMGkpMNE8WNEb
         Ck1LQD8xC4rGgPquiX9CRvT4BiZtDQBXZ01kSxMZaC8WAeNCO6at9fqok4FD4vHJuAmt
         8JRFDBN9HkIXD9HxjzGt1Jv0tcr8ssgwQ7kyLdRKhdaN4eDUoCgR9u1im8YLSeHITvnV
         xgYq/bLb4t/3OMa1VO1IytP83yzVQeLwzCLZk6SMZ0aAXEHQ+ZUD9WK8Dtv61loRh1rr
         TGW5dZ+ZoRQMgNAq9YIcFII/iqDtG3aZTWJj5vj8fq2gc2DW0Wrq+cNxELQM/MTPWkgT
         F2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763433531; x=1764038331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d3p/OcMvX1uSSN/v4MzlMRu+/W/W+pwcNgy10pfRDDw=;
        b=Nv0g8KJtHw4p+fncc2u1iUh3k/2IrwwfMG8uO4XOX2pRXVcB1K4DgKyyuvEAt2xnMX
         6QPVHFpOYAUAFbPIwwDS98qydPpw8vdSf90WnBNQRbN6LjEPREV2E2zkHnDEmoagE12v
         EnidfpgCsCzzgyLY5ORkAKY1/XiZD8E0MfxYgaqc/WWuTuwVnuI0E8Uc19HiBD9WIBGJ
         j4vUajaD3Pj2PDesDTmlWKVlJkyIRsIlzk4Zy0oxCYaYUDr+c+gOdAB3AYEk0IA/rwdD
         9S7o7fyBhJ6Sga7s+wx28khz0pSpVhILmZRgz3R51YGs114MoIbwY89Roo4n7K95YOG1
         HvMA==
X-Forwarded-Encrypted: i=1; AJvYcCWtjOzcYypLQO1YGwDfzG3zrEvLnJm1XQMVd1ZSGdfGZFInf3h1kbe30FdfUvLelcZWpEa1dK3XepbuKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiZM4BkRFdwy4kcwDi9bcE+79SDNUgS1FcG/0ak3/uQgYJQBcg
	OjQr3DX6VXy6bcZP/PU2URRm9zDWiyzy/YIeY7sfmoNQ1EFn3I8eK4FhjLJAikvMcapGW1H9iNI
	hViNxcx6jJerm1mjewGbiXXQel4jj5ozHODlfvbifZQ==
X-Gm-Gg: ASbGncuQC3HcIvLplEpHJ7oi19DHkmIr/8Qq8ytZ72P1Fjmif2GWzHApeX54UI88Y4o
	cpYkByr4hgg3Y6TQmP0MsKBlTPwBf2crFpb3lvod87l1TAOaiU/An7YQwTSHjpR3TArb1nJTRno
	aFuhivqWrlNjjyYrDGfQaTIWF+aILK8AW2CJQ91Ns8I1rqRFxRqa3Ctcxs1i6IUdz1qJ9tSLNNZ
	X8RhEWl0Pp7sK8ocVmdwdCpaSrehFPCkVOQsNLyj7CqsKJu/qpFWWjQZymkbNOxf7DcP6a/rdn2
	jmVU6RU=
X-Google-Smtp-Source: AGHT+IHcCkjAzWZmuCDShXMkYeZW5dDIEZYRq2R7siHymbAE5SXsW9ikDKIM4wP9Jwh55s7MIc6NHN5pRVaEc6MXACE=
X-Received: by 2002:a05:7022:ea46:10b0:11b:65e:f33 with SMTP id
 a92af1059eb24-11c78ddf633mr389649c88.1.1763433531279; Mon, 17 Nov 2025
 18:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112093808.2134129-1-ming.lei@redhat.com> <20251112093808.2134129-10-ming.lei@redhat.com>
 <CADUfDZp3RVr-n4UbiRa=+hDnZh2r-G-fFL0o8PtVD2ERMSfpPw@mail.gmail.com> <aRvV1JWYYnq2nEuw@fedora>
In-Reply-To: <aRvV1JWYYnq2nEuw@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 17 Nov 2025 18:38:40 -0800
X-Gm-Features: AWmQ_bl8X1j0m_b6ljAn4RK26aaGLrDlTxhX9rn5PPrJBWEiPr0TeTGHooUFNPM
Message-ID: <CADUfDZp7rgxSNeiPSrccG1iE+0KawiXVHYnmBov_VGQbFkgntg@mail.gmail.com>
Subject: Re: [PATCH V3 09/27] ublk: add new batch command UBLK_U_IO_PREP_IO_CMDS
 & UBLK_U_IO_COMMIT_IO_CMDS
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 6:11=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Nov 17, 2025 at 01:08:56PM -0800, Caleb Sander Mateos wrote:
> > On Wed, Nov 12, 2025 at 1:39=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Add new command UBLK_U_IO_PREP_IO_CMDS, which is the batch version of
> > > UBLK_IO_FETCH_REQ.
> > >
> > > Add new command UBLK_U_IO_COMMIT_IO_CMDS, which is for committing io =
command
> > > result only, still the batch version.
> > >
> > > The new command header type is `struct ublk_batch_io`, and fixed buff=
er is
> > > required for these two uring_cmd.
> > >
> > > This patch doesn't actually implement these commands yet, just valida=
tes the
> > > SQE fields.
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 107 ++++++++++++++++++++++++++++++++=
+-
> > >  include/uapi/linux/ublk_cmd.h |  49 ++++++++++++++++
> > >  2 files changed, 155 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index c62b2f2057fe..5f9d7ec9daa4 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -85,6 +85,11 @@
> > >          UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> > >          UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> > >
> > > +#define UBLK_BATCH_F_ALL  \
> > > +       (UBLK_BATCH_F_HAS_ZONE_LBA | \
> > > +        UBLK_BATCH_F_HAS_BUF_ADDR | \
> > > +        UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK)
> > > +
> > >  struct ublk_uring_cmd_pdu {
> > >         /*
> > >          * Store requests in same batch temporarily for queuing them =
to
> > > @@ -108,6 +113,12 @@ struct ublk_uring_cmd_pdu {
> > >         u16 tag;
> > >  };
> > >
> > > +struct ublk_batch_io_data {
> > > +       struct ublk_device *ub;
> >
> > Is it possible for this to be a const pointer?
>
> It isn't, for example, mutex_lock(&data->ub->mutex).
>
> >
> > > +       struct io_uring_cmd *cmd;
> > > +       struct ublk_batch_io header;
> > > +};
> > > +
> > >  /*
> > >   * io command is active: sqe cmd is received, and its cqe isn't done
> > >   *
> > > @@ -2520,10 +2531,104 @@ static int ublk_ch_uring_cmd(struct io_uring=
_cmd *cmd, unsigned int issue_flags)
> > >         return ublk_ch_uring_cmd_local(cmd, issue_flags);
> > >  }
> > >
> > > +static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc=
)
> > > +{
> > > +       const u16 mask =3D UBLK_BATCH_F_HAS_BUF_ADDR | UBLK_BATCH_F_H=
AS_ZONE_LBA;
> > > +       const unsigned header_len =3D sizeof(struct ublk_elem_header)=
;
> > > +
> > > +       if (uc->flags & ~UBLK_BATCH_F_ALL)
> > > +               return -EINVAL;
> > > +
> > > +       /* UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK requires buffer index *=
/
> > > +       if ((uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) &&
> > > +                       (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR))
> > > +               return -EINVAL;
> > > +
> > > +       switch (uc->flags & mask) {
> > > +       case 0:
> > > +               if (uc->elem_bytes !=3D header_len)
> > > +                       return -EINVAL;
> > > +               break;
> > > +       case UBLK_BATCH_F_HAS_ZONE_LBA:
> > > +       case UBLK_BATCH_F_HAS_BUF_ADDR:
> > > +               if (uc->elem_bytes !=3D header_len + sizeof(u64))
> > > +                       return -EINVAL;
> > > +               break;
> > > +       case UBLK_BATCH_F_HAS_ZONE_LBA | UBLK_BATCH_F_HAS_BUF_ADDR:
> > > +               if (uc->elem_bytes !=3D header_len + sizeof(u64) + si=
zeof(u64))
> > > +                       return -EINVAL;
> > > +               break;
> > > +       }
> >
> > This could probably be implemented in a less branchy way using
> > conditional moves:
> > unsigned elem_bytes =3D sizeof(struct ublk_elem_header) +
> >         (uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA ? sizeof(u64) : 0) +
> >         (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR ? sizeof(u64) : 0);
> > if (uc->elem_bytes !=3D elem_bytes)
> >         return -EINVAL;
>
> I'd start with current more readable way, but the less branchy optimizati=
on
> can be left in future.

Not sure I'd agree the current way is "more readable" :) but I don't
feel strongly about it.

Best,
Caleb

>
> >
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int ublk_check_batch_cmd(const struct ublk_batch_io_data *dat=
a)
> > > +{
> > > +
> > > +       const struct ublk_batch_io *uc =3D &data->header;
> > > +
> > > +       if (!(data->cmd->flags & IORING_URING_CMD_FIXED))
> > > +               return -EINVAL;
> > > +
> > > +       if (uc->nr_elem * uc->elem_bytes > data->cmd->sqe->len)
> > > +               return -E2BIG;
> > > +
> > > +       if (uc->nr_elem > data->ub->dev_info.queue_depth)
> > > +               return -E2BIG;
> > > +
> > > +       if ((uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA) &&
> > > +                       !ublk_dev_is_zoned(data->ub))
> > > +               return -EINVAL;
> > > +
> > > +       if ((uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR) &&
> > > +                       !ublk_dev_need_map_io(data->ub))
> > > +               return -EINVAL;
> > > +
> > > +       if ((uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK) &&
> > > +                       !ublk_dev_support_auto_buf_reg(data->ub))
> > > +               return -EINVAL;
> > > +
> > > +       if (uc->reserved || uc->reserved2)
> > > +               return -EINVAL;
> >
> > These fields aren't actually copied from the uring_cmd, so this check
> > is a no-op.
>
> Good catch, will kill it in next version.
>
> >
> > > +
> > > +       return ublk_check_batch_cmd_flags(uc);
> > > +}
> > > +
> > >  static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
> > >                                        unsigned int issue_flags)
> > >  {
> > > -       return -EOPNOTSUPP;
> > > +       const struct ublk_batch_io *uc =3D io_uring_sqe_cmd(cmd->sqe)=
;
> > > +       struct ublk_device *ub =3D cmd->file->private_data;
> > > +       struct ublk_batch_io_data data =3D {
> > > +               .ub  =3D ub,
> > > +               .cmd =3D cmd,
> > > +               .header =3D (struct ublk_batch_io) {
> > > +                       .q_id =3D READ_ONCE(uc->q_id),
> > > +                       .flags =3D READ_ONCE(uc->flags),
> > > +                       .nr_elem =3D READ_ONCE(uc->nr_elem),
> > > +                       .elem_bytes =3D READ_ONCE(uc->elem_bytes),
> > > +               },
> > > +       };
> > > +       u32 cmd_op =3D cmd->cmd_op;
> > > +       int ret =3D -EINVAL;
> > > +
> > > +       if (data.header.q_id >=3D ub->dev_info.nr_hw_queues)
> > > +               goto out;
> > > +
> > > +       switch (cmd_op) {
> > > +       case UBLK_U_IO_PREP_IO_CMDS:
> > > +       case UBLK_U_IO_COMMIT_IO_CMDS:
> > > +               ret =3D ublk_check_batch_cmd(&data);
> > > +               if (ret)
> > > +                       goto out;
> > > +               ret =3D -EOPNOTSUPP;
> > > +               break;
> > > +       default:
> > > +               ret =3D -EOPNOTSUPP;
> > > +       }
> > > +out:
> >
> > Is the out label really necessary if there's no cleanup involved? Can
> > we just return the result directly?
>
> Yeah, it isn't necessary, but we have benefit of single exit with `goto`,
> also will avoid extra `return` since command handler is added in followin=
g
> patches.
>
>
> Thanks,
> Ming
>
