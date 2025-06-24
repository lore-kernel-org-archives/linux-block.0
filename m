Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18314221F3E
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779382; cv=none; b=oXBO/W6rKSspMlp0X2wrOpcSzsBIGz5YSpZIldbOGcvhUWGeJ+213wsgK999VGBm75g4ek5J1ai3yS7p84ZhAAguCYyvck3bD4dC7KxaILSH+lYcH9yLauvn92WqUKFi/W58+/NscwWmyx0h7nqgIWGKp3iWDMkB3rtm4F8j8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779382; c=relaxed/simple;
	bh=pBBuYh8dalr7PKi4l4iLgdU/uW8jj6ovWQyE1eN3fhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVOMAW/QBUFKXpp+Pq0t72dR77F+TW1qd6Fr9d5xVcZbygKa0//A9mTL7nYPMA3pbvm+Z30VNja4xFz6h+PowWchZI1tZ6O6k5S9fAIQNCkAzHzLH8PHTzCAFXLd77k9dP/PhXUU1M+wt4T8YdcL8tfy8Tuv+oD59YB/tvOyk6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Kv7isYln; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Kv7isYln"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31306794b30so691056a91.2
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 08:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750779379; x=1751384179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rb6VRDvbXi06rpTfdBubgi2gfUy7cBri+A5FCb5u/W4=;
        b=Kv7isYln17fLleUEszZFxFvHnJldoqlYpgP9HoEdJDkDbwpYOl7lVbpBlkV/Dq6EQc
         ICgRCbOJVnTUXvHxhnW3q2gYXyzYt6sPfTpqB9Le5nzmFoGJA6Z3y+oU72Dq9V56le8h
         nSDxP6NqoMyXxi28wuIVs3SXMs9XKV8mlMYryxhZ3FWMspTJm/zM25QMwsk1WQ9ytycy
         fIScO8UlkJEj8HiXRC66XaxdyLoKDGxDmR5/ouIEf/Xq0w325sS7uEf60scRLlTJPVFQ
         0hcBrrGGd5UEDArsJ/17fn7Z6dwCtwNSRj3kNsAormkH8zBTA5NM+UFiZSVRs3WbotPz
         SpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750779379; x=1751384179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rb6VRDvbXi06rpTfdBubgi2gfUy7cBri+A5FCb5u/W4=;
        b=rTCms69G/crSyQVjk995L/se3plbvPpsjUyUjYf0Sg01jpTCX68WYZzgMHoCRKOfsO
         799OIEPDeKYQ8FU2Fcfw6GHeP5b2mt0by7WTXi+CojFY+LZeQqwu/PkFigvYV+xhfaa0
         r2cgGBClfuwqmxtfEB6+9dZhrKlWqA+0ID0D5aiqzBKCj5jug8VztgZVMm4QLfB6zobh
         x5mSm6K+umzI5J8GOzxKIgv72JvGbGlGXCFj3ihH4XZTZbpCtsC6G37EEtwxgrOgdwhg
         GPNYEoWW862t2HMU/8HLUellQG/jTAIK4uW8d2yOEafgsS0T8Nj1MENqd8J8j2FdZFp/
         q1fA==
X-Forwarded-Encrypted: i=1; AJvYcCWslKR79VHllsM1W2IL2mJZA6V3+ZQTv2XxHVAvQm7wW+LTU62Pg7Fbu7vtH1PVyva6e8gNo7gVhf/hrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg8tnd4kMxDTXj4l3RUP39kj00L+o6QY8i7NeHFI2eDBhwSm28
	LkJZch6RCoVi4q2KOGW++gwgtQs3mhOPQoLRB9Yu5D8j/p01c06VLDilFPHyh0i4C8KAmcuOfVj
	HMkb7qaxb6xUEbUIkQlFmq7pW2oum0uV79mvFMfkk/Q==
X-Gm-Gg: ASbGncuac61wWRSUIs97wF18QhzvSDTXwXH2ljpnTqxo1gq98BgSkOxo9OVHh8GarfD
	yvAmliIHjscmkLtCBA/VKWhyNNLL+dLfI12lqMb+5Y5IpsyLkKVByNI6pws/+JVsN4pe1P7ykmQ
	SzWy5XcOjkzj+CZiuR1+XuyjaBnuyHMnFZyd26gS/Dxg==
X-Google-Smtp-Source: AGHT+IFVfhR+JgFa3JcSzWNgvKBp0YeS6rd32UW/iqCYIBLptz94m2dagzIOzv9IXr6zuDCxSLHS1AB+o6oGR38t8X0=
X-Received: by 2002:a17:90b:57ec:b0:311:9c9a:58e8 with SMTP id
 98e67ed59e1d1-3159d90f997mr8419207a91.7.1750779379163; Tue, 24 Jun 2025
 08:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624104121.859519-1-ming.lei@redhat.com> <CADUfDZo4+roZtoMJWBDemrJi7fzkzYEPWMN4zD=kC0ainvALPQ@mail.gmail.com>
In-Reply-To: <CADUfDZo4+roZtoMJWBDemrJi7fzkzYEPWMN4zD=kC0ainvALPQ@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 24 Jun 2025 08:36:07 -0700
X-Gm-Features: AX0GCFvD4MUWZBTZL1V7csF9BHjqkMuTP5sdOjl4ENsSuWRDiruZNydPdJh1Yr8
Message-ID: <CADUfDZoa7++i4=P7BV2TuYEu63_RWQnRxCHsHX7dQZ9YqbumTQ@mail.gmail.com>
Subject: Re: [PATCH V2] ublk: setup ublk_io correctly in case of
 ublk_get_data() failure
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Changhui Zhong <czhong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 8:16=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Tue, Jun 24, 2025 at 3:41=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wr=
ote:
> >
> > If ublk_get_data() fails, -EIOCBQUEUED is returned and the current comm=
and
> > becomes ASYNC. And the only reason is that mapping data can't move on,
> > because of no enough pages or pending signal, then the current ublk req=
uest
> > has to be requeued.
> >
> > Once the request need to be requeued, we have to setup `ublk_io` correc=
tly,
> > including io->cmd and flags, otherwise the request may not be forwarded=
 to
> > ublk server successfully.
> >
> > Fixes: 9810362a57cb ("ublk: don't call ublk_dispatch_req() for NEED_GET=
_DATA")
>
> Don't think this is the right Fixes tag; the issue predates this
> refactoring. I pointed out this existing issue when we discussed that
> patch: https://lore.kernel.org/linux-block/CADUfDZroQ4zHanPjytcEUhn4tQc3B=
YMPZD2uLOik7jAXvOCjGg@mail.gmail.com/
>
> Looks like the correct commit would be c86019ff75c1 ("ublk_drv: add
> support for UBLK_IO_NEED_GET_DATA").

Ah never mind, I see my commit removed the call to ublk_fill_io_cmd().
I see that's necessary for the -EIOCBQUEUED return to work correctly.

>
> > Reported-by: Changhui Zhong <czhong@redhat.com>
> > Closes: https://lore.kernel.org/linux-block/CAGVVp+VN9QcpHUz_0nasFf5q9i=
1gi8H8j-G-6mkBoqa3TyjRHA@mail.gmail.com/
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > V2:
> >         - move io->addr assignment into ublk_fill_io_cmd()
> >
> >  drivers/block/ublk_drv.c | 35 +++++++++++++++++++++++++----------
> >  1 file changed, 25 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index d36f44f5ee80..3566d7c36b8d 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1148,8 +1148,8 @@ static inline void __ublk_complete_rq(struct requ=
est *req)
> >         blk_mq_end_request(req, res);
> >  }
> >
> > -static void ublk_complete_io_cmd(struct ublk_io *io, struct request *r=
eq,
> > -                                int res, unsigned issue_flags)
> > +static struct io_uring_cmd *__ublk_prep_compl_io_cmd(struct ublk_io *i=
o,
> > +                                                    struct request *re=
q)
>
> nit: don't think the underscores are necessary
>
> >  {
> >         /* read cmd first because req will overwrite it */
> >         struct io_uring_cmd *cmd =3D io->cmd;
> > @@ -1164,6 +1164,13 @@ static void ublk_complete_io_cmd(struct ublk_io =
*io, struct request *req,
> >         io->flags &=3D ~UBLK_IO_FLAG_ACTIVE;
> >
> >         io->req =3D req;
> > +       return cmd;
> > +}
> > +
> > +static void ublk_complete_io_cmd(struct ublk_io *io, struct request *r=
eq,
> > +                                int res, unsigned issue_flags)
> > +{
> > +       struct io_uring_cmd *cmd =3D __ublk_prep_compl_io_cmd(io, req);
> >
> >         /* tell ublksrv one io request is coming */
> >         io_uring_cmd_done(cmd, res, 0, issue_flags);
> > @@ -2148,10 +2155,9 @@ static int ublk_commit_and_fetch(const struct ub=
lk_queue *ubq,
> >         return 0;
> >  }
> >
> > -static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io=
 *io)
> > +static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io=
 *io,
> > +                         struct request *req)
> >  {
> > -       struct request *req =3D io->req;
> > -
> >         /*
> >          * We have handled UBLK_IO_NEED_GET_DATA command,
> >          * so clear UBLK_IO_FLAG_NEED_GET_DATA now and just
> > @@ -2178,6 +2184,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
> >         u32 cmd_op =3D cmd->cmd_op;
> >         unsigned tag =3D ub_cmd->tag;
> >         int ret =3D -EINVAL;
> > +       struct request *req;
> >
> >         pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
> >                         __func__, cmd->cmd_op, ub_cmd->q_id, tag,
> > @@ -2236,11 +2243,19 @@ static int __ublk_ch_uring_cmd(struct io_uring_=
cmd *cmd,
> >                         goto out;
> >                 break;
> >         case UBLK_IO_NEED_GET_DATA:
> > -               io->addr =3D ub_cmd->addr;
> > -               if (!ublk_get_data(ubq, io))
> > -                       return -EIOCBQUEUED;
> > -
> > -               return UBLK_IO_RES_OK;
> > +               /*
> > +                * ublk_get_data() may fail and fallback to requeue, so=
 keep
> > +                * uring_cmd active first and prepare for handling new =
requeued
> > +                * request
> > +                */
> > +               req =3D io->req;
> > +               ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> > +               io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV;
> > +               if (likely(ublk_get_data(ubq, io, req))) {
> > +                       __ublk_prep_compl_io_cmd(io, req);
>
> Isn't __ublk_prep_compl_io_cmd() basically undoing the
> ublk_fill_io_cmd() and io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV? How
> about something like this instead?
>
> io->addr =3D ub_cmd->addr;
> if (likely(ublk_get_data(ubq, io)))
>         return UBLK_IO_RES_OK;
>
> ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV;
> break;
>
> Best,
> Caleb
>
> > +                       return UBLK_IO_RES_OK;
> > +               }
> > +               break;
> >         default:
> >                 goto out;
> >         }
> > --
> > 2.49.0
> >
