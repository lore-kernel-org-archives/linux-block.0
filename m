Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BBBBA50
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 01:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746149479; cv=none; b=cj1ThZgRFekVuqqnI30kqudjnidxlC0jYGJ/6oeJsQ2N7m4UndH9i11Uljj3V8wNf1cxoVpOPx5/rLC25CP1hXhzYPWL72ZVSPWQ/Osc15UVVRE5LlIlBKa1BMqozk+YMmYcP2lsyfF8EIjmZ4v9bZ83hirBXFDOBAJBQEgc6oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746149479; c=relaxed/simple;
	bh=aBXkSeZbWBg3ACRRKH1t8pvUHRzCxzItTuGcRq90M8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIRVC3b03yheOH01Srg92VQjy+5+zbtnxnqszqw4yV5NBxptyt+95xGkyH8xQNqv8nrasM+q3ZK+/5Z4Z6UIt8lElUpH3nbEyDMMNtdi/b417pm3tQAE76Yip3VO0wuBEe8BEftuMvoyGOW+gfJx+InVDBtSwXxvGAvY4mH+hMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Gmg266w6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Gmg266w6"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-309f26c68b8so205370a91.2
        for <linux-block@vger.kernel.org>; Thu, 01 May 2025 18:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746149476; x=1746754276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52OBh8gBoLKrtiy2b7ugwPw/JcrBlKvHnxYD5I5wp7Y=;
        b=Gmg266w6tBj59p0nDMo7RM8Naiyn5T8dxQPmq+9JmRCVJ05Y0pqW/qEUiyQDJEyIu3
         03wrdDvuJXoAxqtPbMhtk79UKkB6E+563f8XJmueQNeZXisI7zQHu5uuhv/y14Nrd3lt
         6w0XWBahAm7IVHl//IG0OpS+VtvIdSz9K0rJHsFlkC3BUeoIwt7nUB6NiCy5am5zuFRD
         r2x7Hz5nFONWAh1jl65VME7gmoHsUfkjHyCf22a6c4SFvpueamjFroDVNYC7jtDTnnmF
         lSp1LohIVlgGH7K5ghCxQo7pDSrqKGXDxJKHAMoyRcoHKqopOKpTsgiZqLRzTEqmdKNP
         grKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746149476; x=1746754276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52OBh8gBoLKrtiy2b7ugwPw/JcrBlKvHnxYD5I5wp7Y=;
        b=eFWtR0uGCf7XUzWjpoF6cfVBKpQQoPDpWFFn/QxtmxGzJe5kG6bhmdYP4BAWW5MLcI
         YlNwB2RfGg3nSBQvg54+U7zYJM1W9H+g2+7XabhG+Gq8zDFIx0vz8k28S2thAts8qqkI
         OF1LiSA1ptUMIFQpQyvzlcGstPSfVFY5YfWisqQ5tVNs2qu5iVOvP+C2v7DeRi+bh1GM
         qwX/qqSc3d/cEdygO0VBUtwZ8zrgWoEhT+50tANTc0YYJ0OXCo3nWpnC6nQDAZ4KplUw
         5nlCwE3i61Boe3EL5GEuE5NLXCP6vysJfW2pJC08phi9rkT7zpDIk0qdUq6+Z+UG2JAg
         op9w==
X-Forwarded-Encrypted: i=1; AJvYcCV5dTBADlnDteIvskQ8AeAtszwLKBFOHhiOnR2BBwuh3QzuTWseuqv9rORCADKvWko6ckyOC/csKRyOEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuoZgOw7CPsbm7epkiZ+FykhyJsthD2FwBvs6lA0RbERo25P/i
	kSVrBHru64p4LhAL/B8rYudaRU/p/o05Kd2EvzlYuchPzu7/P3VHbg64tmm/K8uv3ubyRJxKRHe
	M8YBi1/Dmj1Zf5blzmHVTI8jWTn2Jn/AAt2A5gA==
X-Gm-Gg: ASbGncuv9Zr5aFruGEWSpSJc0gy5PPz9KyOjq7dqjDEoasD/1/fECM49+eXUEZ6GeaZ
	ASnMBEjO7Sl4gaofOWGHJ+TzajsZjkzzgpH53bi2+QDx5OxzekDpxtboFZYJY3ip1zNnm07fn0g
	h/mD5CFJJ9wyOEdPtXptE4hF+9AXQRShY=
X-Google-Smtp-Source: AGHT+IFFk2Y+QTiXhMaIxxKuvhAh9eHEjQmKbbETQUOzIwydfN3soS4Fpw/NxwHCqkMYNZmCmNdGrHTn8e5pU9M6FCg=
X-Received: by 2002:a17:90b:1e0e:b0:2ff:7b15:8138 with SMTP id
 98e67ed59e1d1-30a4e720ccfmr608921a91.7.1746149475523; Thu, 01 May 2025
 18:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428094420.1584420-1-ming.lei@redhat.com> <20250428094420.1584420-4-ming.lei@redhat.com>
 <CADUfDZrXTzXM4tA6vRcOz1qn61he+Y6p5UsLeprbmhDVJe0gbg@mail.gmail.com> <aBJDClTlYV48h3P3@fedora>
In-Reply-To: <aBJDClTlYV48h3P3@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 1 May 2025 18:31:03 -0700
X-Gm-Features: ATxdqUEQyLp3dJLNB-6u-FCHzWJ2NopEk-pDfjENzI2y91iIBPJJEPH8yuw6tbY
Message-ID: <CADUfDZoROJeDKNWOzbgEqrs_B7kU2qNWwZxfnS2TDqYxiXrY0w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] io_uring: support to register bvec buffer to
 specified io_uring
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 8:34=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Apr 28, 2025 at 05:43:12PM -0700, Caleb Sander Mateos wrote:
> > On Mon, Apr 28, 2025 at 2:44=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Extend io_buffer_register_bvec() and io_buffer_unregister_bvec() for
> > > supporting to register/unregister bvec buffer to specified io_uring,
> > > which FD is usually passed from userspace.
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  include/linux/io_uring/cmd.h |  4 ++
> > >  io_uring/rsrc.c              | 83 +++++++++++++++++++++++++++-------=
--
> > >  2 files changed, 67 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cm=
d.h
> > > index 78fa336a284b..7516fe5cd606 100644
> > > --- a/include/linux/io_uring/cmd.h
> > > +++ b/include/linux/io_uring/cmd.h
> > > @@ -25,6 +25,10 @@ struct io_uring_cmd_data {
> > >
> > >  struct io_buf_data {
> > >         unsigned short index;
> > > +       bool has_fd;
> > > +       bool registered_fd;
> > > +
> > > +       int ring_fd;
> > >         struct request *rq;
> > >         void (*release)(void *);
> > >  };
> > > diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> > > index 5f8ab130a573..701dd33fecf7 100644
> > > --- a/io_uring/rsrc.c
> > > +++ b/io_uring/rsrc.c
> > > @@ -969,21 +969,6 @@ static int __io_buffer_register_bvec(struct io_r=
ing_ctx *ctx,
> > >         return 0;
> > >  }
> > >
> > > -int io_buffer_register_bvec(struct io_uring_cmd *cmd,
> > > -                           struct io_buf_data *buf,
> > > -                           unsigned int issue_flags)
> > > -{
> > > -       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> > > -       int ret;
> > > -
> > > -       io_ring_submit_lock(ctx, issue_flags);
> > > -       ret =3D __io_buffer_register_bvec(ctx, buf);
> > > -       io_ring_submit_unlock(ctx, issue_flags);
> > > -
> > > -       return ret;
> > > -}
> > > -EXPORT_SYMBOL_GPL(io_buffer_register_bvec);
> > > -
> > >  static int __io_buffer_unregister_bvec(struct io_ring_ctx *ctx,
> > >                                        struct io_buf_data *buf)
> > >  {
> > > @@ -1006,19 +991,77 @@ static int __io_buffer_unregister_bvec(struct =
io_ring_ctx *ctx,
> > >         return 0;
> > >  }
> > >
> > > -int io_buffer_unregister_bvec(struct io_uring_cmd *cmd,
> > > -                             struct io_buf_data *buf,
> > > -                             unsigned int issue_flags)
> > > +static inline int do_reg_unreg_bvec(struct io_ring_ctx *ctx,
> > > +                                   struct io_buf_data *buf,
> > > +                                   unsigned int issue_flags,
> > > +                                   bool reg)
> > >  {
> > > -       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> > >         int ret;
> > >
> > >         io_ring_submit_lock(ctx, issue_flags);
> > > -       ret =3D __io_buffer_unregister_bvec(ctx, buf);
> > > +       if (reg)
> > > +               ret =3D __io_buffer_register_bvec(ctx, buf);
> > > +       else
> > > +               ret =3D __io_buffer_unregister_bvec(ctx, buf);
> >
> > It feels like unifying __io_buffer_register_bvec() and
> > __io_buffer_unregister_bvec() would belong better in the prior patch
> > that changes their signatures.
>
> Can you share how to do above in previous patch?

I was thinking you could define do_reg_unreg_bvec() in the previous
patch. It's a logical step once you've extracted out all the
differences between io_buffer_register_bvec() and
io_buffer_unregister_bvec() into the helpers
__io_buffer_register_bvec() and __io_buffer_unregister_bvec(). But
either way is fine.

>
> >
> > >         io_ring_submit_unlock(ctx, issue_flags);
> > >
> > >         return ret;
> > >  }
> > > +
> > > +static int io_buffer_reg_unreg_bvec(struct io_ring_ctx *ctx,
> > > +                                   struct io_buf_data *buf,
> > > +                                   unsigned int issue_flags,
> > > +                                   bool reg)
> > > +{
> > > +       struct io_ring_ctx *remote_ctx =3D ctx;
> > > +       struct file *file =3D NULL;
> > > +       int ret;
> > > +
> > > +       if (buf->has_fd) {
> > > +               file =3D io_uring_register_get_file(buf->ring_fd, buf=
->registered_fd);
> > > +               if (IS_ERR(file))
> > > +                       return PTR_ERR(file);
> >
> > It would be good to avoid the overhead of this lookup and
> > reference-counting in the I/O path. Would it be possible to move this
> > lookup to when UBLK_IO_FETCH_REQ (and UBLK_IO_COMMIT_AND_FETCH_REQ, if
> > it specifies a different ring_fd) is submitted? I guess that might
> > require storing an extra io_ring_ctx pointer in struct ublk_io.
>
> Let's start from the flexible way & simple implementation.
>
> Any optimization & improvement can be done as follow-up.

Sure, we can start with this as-is. But I suspect the extra
reference-counting here will significantly decrease the benefit of the
auto-register register feature.

>
> Each command may register buffer to different io_uring context,
> it can't be done in UBLK_IO_FETCH_REQ stage, because new IO with same
> tag may register buffer to new io_uring context.

Right, if UBLK_IO_COMMIT_AND_FETCH_REQ specifies a different io_uring
fd, then we'd have to look it up anew. But it seems likely that all
UBLK_IO_COMMIT_AND_FETCH_REQs for a single tag will specify the same
io_uring (certainly that's how our ublk server works). And in that
case, the I/O could just reuse the io_uring context that was looked up
for the prior UBLK_IO_(COMMIT_AND_)FETCH_REQ.

>
> But it can be optimized in future for one specific use case with feature
> flag.
>
> >
> > > +               remote_ctx =3D file->private_data;
> > > +               if (!remote_ctx)
> > > +                       return -EINVAL;
> > > +       }
> > > +
> > > +       if (remote_ctx =3D=3D ctx) {
> > > +               do_reg_unreg_bvec(ctx, buf, issue_flags, reg);
> > > +       } else {
> > > +               if (!(issue_flags & IO_URING_F_UNLOCKED))
> > > +                       mutex_unlock(&ctx->uring_lock);
> > > +
> > > +               do_reg_unreg_bvec(remote_ctx, buf, IO_URING_F_UNLOCKE=
D, reg);
> > > +
> > > +               if (!(issue_flags & IO_URING_F_UNLOCKED))
> > > +                       mutex_lock(&ctx->uring_lock);
> > > +       }
> > > +
> > > +       if (file)
> > > +               fput(file);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +int io_buffer_register_bvec(struct io_uring_cmd *cmd,
> > > +                           struct io_buf_data *buf,
> > > +                           unsigned int issue_flags)
> >
> > If buf->has_fd is set, this struct io_uring_cmd *cmd is unused. Could
> > you define separate functions that take a struct io_uring_cmd * vs. a
> > ring_fd?
>
> The ring_fd may point to the same io_uring context with 'io_uring_cmd',
> we need this information for dealing with io_uring context lock.

Good point.

Best,
Caleb
