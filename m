Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5392333554C
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607401; cv=none; b=VWARzVsxw6M0FqbMlqqCassXdCajg2W63gxZdz/mXRJ6BNlxRZifjGugUGauYtLhGPzfMPKVdc6/NDExgn7ShYXDhLm7ztNyEfNPU+5IlUrClRvLEKjxEZue2NPE05Ck7lxjoVh0PjzISd+wsdliu4BKE7pwAB7fbMuZQ48Dvr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607401; c=relaxed/simple;
	bh=DDEtF5sHdcZD+mK+Pu5YI646IfFK2O8u3JuX4dhTfo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oE9iRhC8KyS9Uo6RZnSdWAsGv70K31p9IngmwS8631Xc1OOHf+kwJfSnm/CN7TKrgO0cLp7NSidT99CIr4eyzrWaFkzWnAf1CHRN25RwK8fh5wgKKonLTpBoEtC0CwURI5otO+XlSL3nj7eVrSFaW35Dh7550vNB6s6KyvCFoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UImExQjK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UImExQjK"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b8ba3c8ca1so602688b3a.2
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 08:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764607398; x=1765212198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUjl54ylsNAgqBhXHBioRCynLwXpfBTnZju/tL81Kq0=;
        b=UImExQjKB2yfW/Hs9nikzcDICxWZIBNFO/LYinHmvcKubIWxakYGkSY0ixdREghY+L
         HB+qS7O2dG/WARvlTpk0/LZcq+Qew1yFGKQpjrvuKef+Ki1Wcf77sTzp5jefppZQ5g6p
         pyhoUHoJmTIBic19OpqxmdH6c7NQ1avicsc8GqUlEVdCxgMhqcqNjoObWSfPEEaTCZFU
         EjzGpKQATHtPs6HjDv4O0LHtyvrxMdYTO4lcEbD36wmAOZsaq+yyxbxCUCpqlN9mJUQq
         aJOqjthon4QQfRr+NQcjFJxFHuyK6peMXxEK2k+kmgCn+TgJ9+KwLAyrCPQPllykp8/z
         JhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607398; x=1765212198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aUjl54ylsNAgqBhXHBioRCynLwXpfBTnZju/tL81Kq0=;
        b=DNUbUpYGrn+h3DWcvlaleKmCcklbE6gfelWSMVDl8kZ3pYV5zz661kEwBzxWKKrSDd
         974/lxhVcVl50nmdndQ6aEJlVi9Q1D0faxJJUfFxnAg9jpH6vzOS7rDpc19hkc4kZdvl
         Kyv/32yS0K3BCQt2WaO9n74jXlkReQUF4y++uotalqRdpUARfgMQQsXE20wQrkoi3s0s
         M2A7c/V9iMSeJoTmeA1P+Y8ahU0fqzTXsFEZ44gtZ5uXWoOjTz8pFmYJJ8kKAhg3Q1oS
         uUNaT5VqSFDlczjgfpSHPlIFJhUf0XcmIzxwykfnhn3kj+6jyducegpKXIrkzZF7aY9m
         OMiw==
X-Forwarded-Encrypted: i=1; AJvYcCUdA2FMQtvcXPqQhwVE0MCn9bAZETtk4bqd6SNnHuJ/OzTIhFEVwYYpOhXtO9Wr/QyZ+Q0HJyq3AcuG8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl3jbSaQSbNK56y9u3E9j3VFoATB5sMul61lxlQ3VVtWA2mXuF
	MiC4JNZJA3ZAKv04J/2l7L7PE3pt0JHCkMbKK4d+Gfiwgiv71cv/HHNTAGChqU90zXZ6TDqakXJ
	XJltGXQfXkdxVw0gQ8KItr3QKGmiVgK1YegJtkNH+qpJcoeD57S/AV6PMVg==
X-Gm-Gg: ASbGncs5M4UxCbqU8OL4dlE3PL21VAW07tCcXvzQRJ4bJXopGwqHt3CuWP7+FXhUWWw
	Ln8ZN6ti9FFojrpfbbUBTR40BQqDglhC8jGzKgZzfdyXop/Q+PNzDlKH8pwFabiK6KJYOeeINmp
	jsPeAsZbe8S7y2eLZ3tvDRQFBIlvIdtk9qY7oNZcDiDR/uYFgE6Y29FaDer1AEKNJehrwSPUsTl
	kvtAIkOLqXoRUhxkGA3CxjNrvNm7CVN58qQy76co6nq3FQsKKhp65bsSHHf1Da1fTxtqCKs
X-Google-Smtp-Source: AGHT+IEakPeh3jenag0es3RtPmrQ16ezAiM6dUFn4e1fOC2YFTmPt1Q3L73ftqqany9utzTL2zXIQ8bo0xPCYDTGm/A=
X-Received: by 2002:a05:7023:c007:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-11c9f3a16demr15106205c88.5.1764607398300; Mon, 01 Dec 2025
 08:43:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-12-ming.lei@redhat.com>
 <CADUfDZqtoN=Xv17txG5cZ9foD3ToxgiiW_DSgnABG2ocK7p-UQ@mail.gmail.com> <aS1tLp7tBi8K_NWk@fedora>
In-Reply-To: <aS1tLp7tBi8K_NWk@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 1 Dec 2025 08:43:06 -0800
X-Gm-Features: AWmQ_bk8T7OesKE9ocQJislNJWu8Ky_75PjdR2XeFQKwpTqANFAKzuWqOQkosOc
Message-ID: <CADUfDZr5Z+UnE5WHnNkW-ZTnBgjcVyjUCcUy545QzZQumqCdpg@mail.gmail.com>
Subject: Re: [PATCH V4 11/27] ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 2:26=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Sun, Nov 30, 2025 at 08:39:49AM -0800, Caleb Sander Mateos wrote:
> > On Thu, Nov 20, 2025 at 5:59=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Handle UBLK_U_IO_COMMIT_IO_CMDS by walking the uring_cmd fixed buffer=
:
> > >
> > > - read each element into one temp buffer in batch style
> > >
> > > - parse and apply each element for committing io result
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 117 ++++++++++++++++++++++++++++++++=
--
> > >  include/uapi/linux/ublk_cmd.h |   8 +++
> > >  2 files changed, 121 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 66c77daae955..ea992366af5b 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -2098,9 +2098,9 @@ static inline int ublk_set_auto_buf_reg(struct =
ublk_io *io, struct io_uring_cmd
> > >         return 0;
> > >  }
> > >
> > > -static int ublk_handle_auto_buf_reg(struct ublk_io *io,
> > > -                                   struct io_uring_cmd *cmd,
> > > -                                   u16 *buf_idx)
> > > +static void __ublk_handle_auto_buf_reg(struct ublk_io *io,
> > > +                                      struct io_uring_cmd *cmd,
> > > +                                      u16 *buf_idx)
> >
> > The name could be a bit more descriptive. How about "ublk_clear_auto_bu=
f_reg()"?
>
> Looks fine.
>
> >
> > >  {
> > >         if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
> > >                 io->flags &=3D ~UBLK_IO_FLAG_AUTO_BUF_REG;
> > > @@ -2118,7 +2118,13 @@ static int ublk_handle_auto_buf_reg(struct ubl=
k_io *io,
> > >                 if (io->buf_ctx_handle =3D=3D io_uring_cmd_ctx_handle=
(cmd))
> > >                         *buf_idx =3D io->buf.auto_reg.index;
> > >         }
> > > +}
> > >
> > > +static int ublk_handle_auto_buf_reg(struct ublk_io *io,
> > > +                                   struct io_uring_cmd *cmd,
> > > +                                   u16 *buf_idx)
> > > +{
> > > +       __ublk_handle_auto_buf_reg(io, cmd, buf_idx);
> > >         return ublk_set_auto_buf_reg(io, cmd);
> > >  }
> > >
> > > @@ -2553,6 +2559,17 @@ static inline __u64 ublk_batch_buf_addr(const =
struct ublk_batch_io *uc,
> > >         return 0;
> > >  }
> > >
> > > +static inline __u64 ublk_batch_zone_lba(const struct ublk_batch_io *=
uc,
> > > +                                       const struct ublk_elem_header=
 *elem)
> > > +{
> > > +       const void *buf =3D (const void *)elem;
> >
> > Unnecessary cast
>
> OK
>
> >
> > > +
> > > +       if (uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA)
> > > +               return *(__u64 *)(buf + sizeof(*elem) +
> > > +                               8 * !!(uc->flags & UBLK_BATCH_F_HAS_B=
UF_ADDR));
> >
> > Cast to a const pointer?
>
> OK, but I feel it isn't necessary.

I don't feel strongly, just seems like the purpose of the cast is
clearer when it doesn't change the const-ness of the pointer.

>
> >
> >
> > > +       return -1;
> > > +}
> > > +
> > >  static struct ublk_auto_buf_reg
> > >  ublk_batch_auto_buf_reg(const struct ublk_batch_io *uc,
> > >                         const struct ublk_elem_header *elem)
> > > @@ -2708,6 +2725,98 @@ static int ublk_handle_batch_prep_cmd(const st=
ruct ublk_batch_io_data *data)
> > >         return ret;
> > >  }
> > >
> > > +static int ublk_batch_commit_io_check(const struct ublk_queue *ubq,
> > > +                                     struct ublk_io *io,
> > > +                                     union ublk_io_buf *buf)
> > > +{
> > > +       struct request *req =3D io->req;
> > > +
> > > +       if (!req)
> > > +               return -EINVAL;
> >
> > This check seems redundant with the UBLK_IO_FLAG_OWNED_BY_SRV check?
>
> I'd keep the check, which has document benefit, or warn_on()?

WARN_ON() seems okay, though not sure it's necessary. Though there are
several existing places that assume io->req is set when
UBLK_IO_FLAG_OWNED_BY_SRV is set. (And that's the documented
precondition for using io->req: "valid if UBLK_IO_FLAG_OWNED_BY_SRV is
set".)

Best,
Caleb

>
> >
> > > +
> > > +       if (io->flags & UBLK_IO_FLAG_ACTIVE)
> > > +               return -EBUSY;
> >
> > Aren't UBLK_IO_FLAG_ACTIVE and UBLK_IO_FLAG_OWNED_BY_SRV mutually
> > exclusive? Then this check is also redundant with the
> > UBLK_IO_FLAG_OWNED_BY_SRV check.
>
> OK.
>
> >
> > > +
> > > +       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> > > +               return -EINVAL;
> > > +
> > > +       if (ublk_need_map_io(ubq)) {
> > > +               /*
> > > +                * COMMIT_AND_FETCH_REQ has to provide IO buffer if
> > > +                * NEED GET DATA is not enabled or it is Read IO.
> > > +                */
> > > +               if (!buf->addr && (!ublk_need_get_data(ubq) ||
> > > +                                       req_op(req) =3D=3D REQ_OP_REA=
D))
> > > +                       return -EINVAL;
> > > +       }
> > > +       return 0;
> > > +}
> > > +
> > > +static int ublk_batch_commit_io(struct ublk_queue *ubq,
> > > +                               const struct ublk_batch_io_data *data=
,
> > > +                               const struct ublk_elem_header *elem)
> > > +{
> > > +       struct ublk_io *io =3D &ubq->ios[elem->tag];
> > > +       const struct ublk_batch_io *uc =3D &data->header;
> > > +       u16 buf_idx =3D UBLK_INVALID_BUF_IDX;
> > > +       union ublk_io_buf buf =3D { 0 };
> > > +       struct request *req =3D NULL;
> > > +       bool auto_reg =3D false;
> > > +       bool compl =3D false;
> > > +       int ret;
> > > +
> > > +       if (ublk_dev_support_auto_buf_reg(data->ub)) {
> > > +               buf.auto_reg =3D ublk_batch_auto_buf_reg(uc, elem);
> > > +               auto_reg =3D true;
> > > +       } else if (ublk_dev_need_map_io(data->ub))
> > > +               buf.addr =3D ublk_batch_buf_addr(uc, elem);
> > > +
> > > +       ublk_io_lock(io);
> > > +       ret =3D ublk_batch_commit_io_check(ubq, io, &buf);
> > > +       if (!ret) {
> > > +               io->res =3D elem->result;
> > > +               io->buf =3D buf;
> > > +               req =3D ublk_fill_io_cmd(io, data->cmd);
> > > +
> > > +               if (auto_reg)
> > > +                       __ublk_handle_auto_buf_reg(io, data->cmd, &bu=
f_idx);
> > > +               compl =3D ublk_need_complete_req(data->ub, io);
> > > +       }
> > > +       ublk_io_unlock(io);
> > > +
> > > +       if (unlikely(ret)) {
> > > +               pr_warn("%s: dev %u queue %u io %u: commit failure %d=
\n",
> > > +                       __func__, data->ub->dev_info.dev_id, ubq->q_i=
d,
> > > +                       elem->tag, ret);
> >
> > This warning can be triggered by userspace. It should probably be
> > rate-limited or changed to pr_devel().
>
> Looks fine.
>
>
>
> Thanks,
> Ming
>
