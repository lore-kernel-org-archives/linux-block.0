Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D52AD0C
	for <linux-block@vger.kernel.org>; Thu, 11 Sep 2025 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757614416; cv=none; b=lG7vYbtfS45Hnl1ZCFrbpKiGUv8P3Z+au1MBqMDsrt8bB8PJa3wAEXm0M8ANTV23SXxexdLETW0WorW8rRYrAQ4sXQVwYgr+OI7kaRFhcLyfMbPWg8+4CDak3KqZvds88Q1CaypERLcnjpZ3Q7DsD/kmZHDoonZlJ7KgNqawEZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757614416; c=relaxed/simple;
	bh=O7xR5YN2QEBRS2DntUeo0cEuUiTeBPLWLGTo0Dw/BeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mczPnVKXdew/qUmg5KStPbmO4Fv96XlGxWxrFcRO9YrtjzioRFb0lGvmi9axccB1IbxT39EVBta8RfcNoj6zFxW3+YQ46ydxCXor3VQQXKsExgZ6nDmE/mVNPBHYOEXXdtj9ow4zE8Oj9W8OcGB+T/2V1D616+caBmC1wWt27PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GztQx/CF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GztQx/CF"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24b150fb800so1941155ad.2
        for <linux-block@vger.kernel.org>; Thu, 11 Sep 2025 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757614414; x=1758219214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RJxHNURn8PonHglYCSclRL1xCIUVBfju3qb192vi+g=;
        b=GztQx/CFPDTcYeXFYlAEalA24qIBG2ZQI6YtRrvqbBfQ90GKUbTYfp7Vjcj521l7uW
         7ugvluR4+Mxu5MdJ2Gh5J33Z1DC3ul8TMlH9IQ3t66SxwDXv+aaoZKeFoZPJPv+MVjRV
         /mNsTr3MolnSfOKLW0xos21y+7MWslXAZF91tYTcW6qzo9cteHPPnfIWt/S5xXSKrQEd
         Rmz0ZMGuSjlfaDjiSpGZnS6niqnCMRCxBZOQDugRWYp33R2mq72GUaRjnA+Wc30xpKSW
         3P9vasQomGk03yDof1r5i137GdVzKyaPqenoZSF/bpPJDHGtvMasppJokLqiid96+Cim
         YAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757614414; x=1758219214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RJxHNURn8PonHglYCSclRL1xCIUVBfju3qb192vi+g=;
        b=Nwv9Y4A29KGjQBFYhinXb+CnTmy6ovPAKht8mngb3MRZvHqPV6PCcfZK5wo+blxTVv
         bN4Tymqok7oqZV52RZ3S6EY9IQcCIo5EyadzMg54DiAdd8AzfEOSRjs77sPs2DHgdmZq
         B63wEJXvtzuDg6fMhbPRLNMl58kFGP/Ng4pT1wGIMb5Q4Ka1HBseR2cuF9BWZ5w3/E2K
         TBsJWv3IPf0/9AZKQU8v8zElC32DFZv764H6pyyyKbixrHQ3eR3ZOUxkukOOE6z0RRUe
         z7q2ic0kKRt3FF7IK1dNRRDhDmNFlmJlIY5SDK8TJFDDD6PWljLODVBwE62QyEdg1x2L
         NbEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDkxuS6saH53oSL9f45L5q/zyLH8rZheJMSYcxvXhKmxRj7RGNFLE6V1lfA+yVq1ICvjZNe5SBLtJtnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCU1dG3LcNSZR1xNVsiLyTvbiM4Day3HmMVwygfn+f2z4AnviA
	28LL9fdqL20yxVeTPScJb0Wm8jaMQCyvaulMD0gl7PVvbxJ80yxUzZXVlAYSWovNIPnlWfcbS+E
	3/1Ja2W7fkComDR98guafzoDSIvmX93RoDhY4Ap7GUA==
X-Gm-Gg: ASbGncutob6yIBU9qxSFo9HWShpB0XuwuCIf78xeFbpbZdFfAKtoAt3hZv8fjRqkSnB
	QgpNIZHAoacoN1iQXviMjjXqFdbBa+y3M3jXr/OShrzzS7L5X18gb/fNO48glsx/B0aNb9/ODkD
	S9QM3/BBfebQqPlEU6st49oEt5Dn5Dp61LTzvLJEfaFtwLjtmrFE6TybTowNu2F4oTHsETCVRYI
	D32y1/N1epeO8N0rXNdgiWL8Po6uqh4x2GBizJ5TvVvtnPC9FCjTFsDD1lD
X-Google-Smtp-Source: AGHT+IHrrOv+o6MycqPMB1He56RolZPTpgand2nP7dfgPmjaK5oMWVnc3PvB51n8ZCpnTgCkxxXOObLY4V29mHFqIWc=
X-Received: by 2002:a17:902:c406:b0:24c:b36d:637 with SMTP id
 d9443c01a7336-25d246da083mr1995355ad.1.1757614413965; Thu, 11 Sep 2025
 11:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901100242.3231000-1-ming.lei@redhat.com> <20250901100242.3231000-4-ming.lei@redhat.com>
 <CADUfDZqfFC__Y7uqE4LDUsKmWwM=Fyiyh4KMNL-OE+iw059g7Q@mail.gmail.com> <aMDhGBhYvmuRg20C@fedora>
In-Reply-To: <aMDhGBhYvmuRg20C@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 11 Sep 2025 11:13:22 -0700
X-Gm-Features: Ac12FXzzSjJgYE63gjjdX-p9FYdpv3P9WpxVIt8VlNygwqOnqSm4cUz9gH4zF3Y
Message-ID: <CADUfDZpMfJKQKub29yxafGhJUmf-=29BVpwJ=NU9+7Lm4N_zOQ@mail.gmail.com>
Subject: Re: [PATCH 03/23] ublk: refactor auto buffer register in ublk_dispatch_req()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 7:23=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Tue, Sep 02, 2025 at 09:41:55PM -0700, Caleb Sander Mateos wrote:
> > On Mon, Sep 1, 2025 at 3:03=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > Refactor auto buffer register code and prepare for supporting batch I=
O
> > > feature, and the main motivation is to put 'ublk_io' operation code
> > > together, so that per-io lock can be applied for the code block.
> > >
> > > The key changes are:
> > > - Rename ublk_auto_buf_reg() as ublk_do_auto_buf_reg()
> >
> > Thanks, the type and the function having the same name was a minor anno=
yance.
> >
> > > - Introduce an enum `auto_buf_reg_res` to represent the result of
> > >   the buffer registration attempt (FAIL, FALLBACK, OK).
> > > - Split the existing `ublk_do_auto_buf_reg` function into two:
> > >   - `__ublk_do_auto_buf_reg`: Performs the actual buffer registration
> > >     and returns the `auto_buf_reg_res` status.
> > >   - `ublk_do_auto_buf_reg`: A wrapper that calls the internal functio=
n
> > >     and handles the I/O preparation based on the result.
> > > - Introduce `ublk_prep_auto_buf_reg_io` to encapsulate the logic for
> > >   preparing the I/O for completion after buffer registration.
> > > - Pass the `tag` directly to `ublk_auto_buf_reg_fallback` to avoid
> > >   recalculating it.
> > >
> > > This refactoring makes the control flow clearer and isolates the diff=
erent
> > > stages of the auto buffer registration process.
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 65 +++++++++++++++++++++++++++-----------=
--
> > >  1 file changed, 44 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 9185978abeb7..e53f623b0efe 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -1205,17 +1205,36 @@ static inline void __ublk_abort_rq(struct ubl=
k_queue *ubq,
> > >  }
> > >
> > >  static void
> > > -ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, struct ublk=
_io *io)
> > > +ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, unsigned ta=
g)
> > >  {
> > > -       unsigned tag =3D io - ubq->ios;
> >
> > The reason to calculate the tag like this was to avoid the pointer
> > dereference in req->tag. But req->tag is already accessed just prior
> > in ublk_dispatch_req(), so it should be cached and not too expensive
> > to load again.
>
> Ok, one thing is that ublk_auto_buf_reg_fallback() should be called in sl=
ow
> path...

What you have seems fine. Just providing some background on why I
wrote it like this.

Best,
Caleb

>
> >
> > >         struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, tag);
> > >
> > >         iod->op_flags |=3D UBLK_IO_F_NEED_REG_BUF;
> > >  }
> > >
> > > -static bool ublk_auto_buf_reg(const struct ublk_queue *ubq, struct r=
equest *req,
> > > -                             struct ublk_io *io, struct io_uring_cmd=
 *cmd,
> > > -                             unsigned int issue_flags)
> > > +enum auto_buf_reg_res {
> > > +       AUTO_BUF_REG_FAIL,
> > > +       AUTO_BUF_REG_FALLBACK,
> > > +       AUTO_BUF_REG_OK,
> > > +};
> >
> > nit: move this enum definition next to the function that returns it?
>
> Yeah, good point.
>
> >
> > > +
> > > +static void ublk_prep_auto_buf_reg_io(const struct ublk_queue *ubq,
> > > +                                  struct request *req, struct ublk_i=
o *io,
> > > +                                  struct io_uring_cmd *cmd, bool reg=
istered)
> >
> > How about passing enum auto_buf_reg_res instead of bool registered to
> > avoid the duplicated =3D=3D AUTO_BUF_REG_OK in the callers?
>
> OK, either way is fine for me.
>
> >
> > > +{
> > > +       if (registered) {
> > > +               io->task_registered_buffers =3D 1;
> > > +               io->buf_ctx_handle =3D io_uring_cmd_ctx_handle(cmd);
> > > +               io->flags |=3D UBLK_IO_FLAG_AUTO_BUF_REG;
> > > +       }
> > > +       ublk_init_req_ref(ubq, io);
> > > +       __ublk_prep_compl_io_cmd(io, req);
> > > +}
> > > +
> > > +static enum auto_buf_reg_res
> > > +__ublk_do_auto_buf_reg(const struct ublk_queue *ubq, struct request =
*req,
> > > +                      struct ublk_io *io, struct io_uring_cmd *cmd,
> > > +                      unsigned int issue_flags)
> > >  {
> > >         int ret;
> > >
> > > @@ -1223,29 +1242,27 @@ static bool ublk_auto_buf_reg(const struct ub=
lk_queue *ubq, struct request *req,
> > >                                       io->buf.auto_reg.index, issue_f=
lags);
> > >         if (ret) {
> > >                 if (io->buf.auto_reg.flags & UBLK_AUTO_BUF_REG_FALLBA=
CK) {
> > > -                       ublk_auto_buf_reg_fallback(ubq, io);
> > > -                       return true;
> > > +                       ublk_auto_buf_reg_fallback(ubq, req->tag);
> > > +                       return AUTO_BUF_REG_FALLBACK;
> > >                 }
> > >                 blk_mq_end_request(req, BLK_STS_IOERR);
> > > -               return false;
> > > +               return AUTO_BUF_REG_FAIL;
> > >         }
> > >
> > > -       io->task_registered_buffers =3D 1;
> > > -       io->buf_ctx_handle =3D io_uring_cmd_ctx_handle(cmd);
> > > -       io->flags |=3D UBLK_IO_FLAG_AUTO_BUF_REG;
> > > -       return true;
> > > +       return AUTO_BUF_REG_OK;
> > >  }
> > >
> > > -static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
> > > -                                  struct request *req, struct ublk_i=
o *io,
> > > -                                  struct io_uring_cmd *cmd,
> > > -                                  unsigned int issue_flags)
> > > +static void ublk_do_auto_buf_reg(const struct ublk_queue *ubq, struc=
t request *req,
> > > +                                struct ublk_io *io, struct io_uring_=
cmd *cmd,
> > > +                                unsigned int issue_flags)
> > >  {
> > > -       ublk_init_req_ref(ubq, io);
> > > -       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
> > > -               return ublk_auto_buf_reg(ubq, req, io, cmd, issue_fla=
gs);
> > > +       enum auto_buf_reg_res res =3D __ublk_do_auto_buf_reg(ubq, req=
, io, cmd,
> > > +                       issue_flags);
> > >
> > > -       return true;
> > > +       if (res !=3D AUTO_BUF_REG_FAIL) {
> > > +               ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res =3D=
=3D AUTO_BUF_REG_OK);
> > > +               io_uring_cmd_done(cmd, UBLK_IO_RES_OK, 0, issue_flags=
);
> > > +       }
> > >  }
> > >
> > >  static bool ublk_start_io(const struct ublk_queue *ubq, struct reque=
st *req,
> > > @@ -1318,8 +1335,14 @@ static void ublk_dispatch_req(struct ublk_queu=
e *ubq,
> > >         if (!ublk_start_io(ubq, req, io))
> > >                 return;
> > >
> > > -       if (ublk_prep_auto_buf_reg(ubq, req, io, io->cmd, issue_flags=
))
> > > +       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req)) =
{
> > > +               struct io_uring_cmd *cmd =3D io->cmd;
> >
> > Don't really see the need for this intermediate variable
>
> Yes, will remove it, but the big thing is that there isn't io->cmd for BA=
TCH_IO
> any more.
>
>
> Thanks,
> Ming
>
