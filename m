Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60633202981
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746220879; cv=none; b=H153VsqS4u83KLKNxGOG+Rz71yNqB4LQ/Z3leNdnOLN+tYBdFLY9c6H2dKdIV8MCGrYEegSViTAoVyAIX8T/Y23Xq1hw5ON0KNmuvqbqzpb2YlK6mdnqIg764ogcGJJaAQ3PGNZ5OXB5z+iMdEztArrC1p+lFjHchwNw3gx30rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746220879; c=relaxed/simple;
	bh=5qzvUAzjMKZ98X02mWPJ9V1UfMrvM30yqBubo7Y4XZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQR0+9AmPk+sDdZs/E1kK1P58kOpqeF00DX5rca1ADZAhJVRcwTYRyHNggn7IOY6S2wwp5AOR9IS7BlvO00UUpRl7j+e041rrjB/LelAyfeyXqXa+EzIJ2+a4XbBIy1bdCNulZ6QOBF6CzpBeZxJ6mBaepqKUEv85SAKiXP0CEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Y3KOmvge; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Y3KOmvge"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e162515acso1181095ad.3
        for <linux-block@vger.kernel.org>; Fri, 02 May 2025 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746220876; x=1746825676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGdpwYguXPs2lAGo5+MRzYtLbXouPVwccJyaENazssQ=;
        b=Y3KOmvgeo3fJTqwPsvTJAsdAgiazQjFeZ5TMS9tTR76/fg8TM1tdrS6DH+Ew/KBeD8
         gSS6HTZWOnBWaaHI59AwzvR1hoLe039UN0tlrgCALz7/E2SN5iYXnw9gpiBbVW+7L0w7
         twGUfzXri0UQXvboZJ2yqtwwWHg2jjongcURN6pYJ9ekCHzCsWHbCcJ3dzB2iyG8Hwl3
         tRpylVzEmFpy8JwXiVHzuEV6vfvsttUwSUEsUwkR8STmOx6VcceginBQv2YffeYrjC7O
         tGD4KNfWbW7KGSwpJOHAVRo/S+YQg0VEiq0ELSXWfPZSb5JXFOwjtcO3qJbvE8GvqNTF
         g2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746220876; x=1746825676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGdpwYguXPs2lAGo5+MRzYtLbXouPVwccJyaENazssQ=;
        b=PfRgzCbJsWRsxTAuKAnMlGdTHbC0ynzi6a42GittiMOnBNQ1m/UKzOVRdYPN+saZEC
         zZRrUTtgrwFJdiFAyTTE4w/bGp8GphtNeiFxAXosWG/jmaX9as3NGIWN/wA5+22wGWIf
         SJ5STLYwb48TpukgoxSBJSBUgZwGr5hsHJwbHUoGr0aqy3+fcuIFKpyBpM4TLS15enqL
         N8sN4fg7gYhpLnnO3HTCC2er95SsqOFL+BrFRiKYRxc/ipvTjVugxhkk5DEyGI9YXdQz
         Q6B4KRswoaddWKgZhzC/cS+KvK+ea/zbcAZSCrh4+HzztwBiobasvBE+Tz/z0h0oKnfx
         uL4w==
X-Forwarded-Encrypted: i=1; AJvYcCVc9M7qsk3jTiAxF83+/Pmb1oeJ1GArMhv6jE2TOSS73AWAtaly8ncP+VlUtNHp5Hvjb86jidDHSn1JUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKaF3XRxbfBD4B57tFQl8ruMWGRiWs4MYACBAx1f5dVKUcJMTX
	n5nH5Cxh2JRcwlXyNJ2YMMLOFZ8JGZX97lEIqd26t9y3GO2GBQOKUAtOAOa3obbHBQz3cghnL6D
	Jt48GP2gZZbXLRvU6U1FBl3Wejn/k8qhLMvv4dA==
X-Gm-Gg: ASbGncs7bcETL8nczO11bz0hN3fKyTuENLkFMwWmug1Jz41af7SYSJ84QoOQZ1rfflH
	LsPq7jNs4vqAcd1n17fqUfWQ7tn3dgAlry3Pj/trdxymc5eKzKYpwYcV6z2CZkauof9k3Vbb7sJ
	Dk+dSSNUYfMAK1Mgo89jG0NgAGPNV6S+U=
X-Google-Smtp-Source: AGHT+IEekHOSH67QQO93z3HxLM7D2jg+Tc2O2qhVSg0XxBBXf6I/qf3ryBFJNoqliUj2t5cYKBs6x4eXT+wjer3RIRg=
X-Received: by 2002:a17:902:d504:b0:223:659d:ac66 with SMTP id
 d9443c01a7336-22e103446c8mr27465575ad.12.1746220876553; Fri, 02 May 2025
 14:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428094420.1584420-1-ming.lei@redhat.com> <20250428094420.1584420-4-ming.lei@redhat.com>
 <CADUfDZrXTzXM4tA6vRcOz1qn61he+Y6p5UsLeprbmhDVJe0gbg@mail.gmail.com>
 <aBJDClTlYV48h3P3@fedora> <CADUfDZoROJeDKNWOzbgEqrs_B7kU2qNWwZxfnS2TDqYxiXrY0w@mail.gmail.com>
 <aBTr5fz5KOgd9RiD@fedora>
In-Reply-To: <aBTr5fz5KOgd9RiD@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 2 May 2025 14:21:05 -0700
X-Gm-Features: ATxdqUFbCpcOs7pkSiWyjPo8U72KxIZTNWjfqU_o_S_MVX0DxXE_7x-nakROhVA
Message-ID: <CADUfDZqetfAE_s8-GDSLmYTdgrqFLv+YZ1vndg0uD38NuXW3Nw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] io_uring: support to register bvec buffer to
 specified io_uring
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 8:59=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Thu, May 01, 2025 at 06:31:03PM -0700, Caleb Sander Mateos wrote:
> > On Wed, Apr 30, 2025 at 8:34=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > On Mon, Apr 28, 2025 at 05:43:12PM -0700, Caleb Sander Mateos wrote:
> > > > On Mon, Apr 28, 2025 at 2:44=E2=80=AFAM Ming Lei <ming.lei@redhat.c=
om> wrote:
> > > > >
> > > > > Extend io_buffer_register_bvec() and io_buffer_unregister_bvec() =
for
> > > > > supporting to register/unregister bvec buffer to specified io_uri=
ng,
> > > > > which FD is usually passed from userspace.
> > > > >
> > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > ---
> > > > >  include/linux/io_uring/cmd.h |  4 ++
> > > > >  io_uring/rsrc.c              | 83 +++++++++++++++++++++++++++---=
------
> > > > >  2 files changed, 67 insertions(+), 20 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_urin=
g/cmd.h
> > > > > index 78fa336a284b..7516fe5cd606 100644
> > > > > --- a/include/linux/io_uring/cmd.h
> > > > > +++ b/include/linux/io_uring/cmd.h
> > > > > @@ -25,6 +25,10 @@ struct io_uring_cmd_data {
> > > > >
> > > > >  struct io_buf_data {
> > > > >         unsigned short index;
> > > > > +       bool has_fd;
> > > > > +       bool registered_fd;
> > > > > +
> > > > > +       int ring_fd;
> > > > >         struct request *rq;
> > > > >         void (*release)(void *);
> > > > >  };
> > > > > diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> > > > > index 5f8ab130a573..701dd33fecf7 100644
> > > > > --- a/io_uring/rsrc.c
> > > > > +++ b/io_uring/rsrc.c
> > > > > @@ -969,21 +969,6 @@ static int __io_buffer_register_bvec(struct =
io_ring_ctx *ctx,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > -int io_buffer_register_bvec(struct io_uring_cmd *cmd,
> > > > > -                           struct io_buf_data *buf,
> > > > > -                           unsigned int issue_flags)
> > > > > -{
> > > > > -       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> > > > > -       int ret;
> > > > > -
> > > > > -       io_ring_submit_lock(ctx, issue_flags);
> > > > > -       ret =3D __io_buffer_register_bvec(ctx, buf);
> > > > > -       io_ring_submit_unlock(ctx, issue_flags);
> > > > > -
> > > > > -       return ret;
> > > > > -}
> > > > > -EXPORT_SYMBOL_GPL(io_buffer_register_bvec);
> > > > > -
> > > > >  static int __io_buffer_unregister_bvec(struct io_ring_ctx *ctx,
> > > > >                                        struct io_buf_data *buf)
> > > > >  {
> > > > > @@ -1006,19 +991,77 @@ static int __io_buffer_unregister_bvec(str=
uct io_ring_ctx *ctx,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > -int io_buffer_unregister_bvec(struct io_uring_cmd *cmd,
> > > > > -                             struct io_buf_data *buf,
> > > > > -                             unsigned int issue_flags)
> > > > > +static inline int do_reg_unreg_bvec(struct io_ring_ctx *ctx,
> > > > > +                                   struct io_buf_data *buf,
> > > > > +                                   unsigned int issue_flags,
> > > > > +                                   bool reg)
> > > > >  {
> > > > > -       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> > > > >         int ret;
> > > > >
> > > > >         io_ring_submit_lock(ctx, issue_flags);
> > > > > -       ret =3D __io_buffer_unregister_bvec(ctx, buf);
> > > > > +       if (reg)
> > > > > +               ret =3D __io_buffer_register_bvec(ctx, buf);
> > > > > +       else
> > > > > +               ret =3D __io_buffer_unregister_bvec(ctx, buf);
> > > >
> > > > It feels like unifying __io_buffer_register_bvec() and
> > > > __io_buffer_unregister_bvec() would belong better in the prior patc=
h
> > > > that changes their signatures.
> > >
> > > Can you share how to do above in previous patch?
> >
> > I was thinking you could define do_reg_unreg_bvec() in the previous
> > patch. It's a logical step once you've extracted out all the
> > differences between io_buffer_register_bvec() and
> > io_buffer_unregister_bvec() into the helpers
> > __io_buffer_register_bvec() and __io_buffer_unregister_bvec(). But
> > either way is fine.
>
> 'has_fd' and 'ring_fd' fields isn't added yet, the defined do_reg_unreg_b=
vec()
> could be quite simple, looks no big difference, I can do that...
>
> >
> > >
> > > >
> > > > >         io_ring_submit_unlock(ctx, issue_flags);
> > > > >
> > > > >         return ret;
> > > > >  }
> > > > > +
> > > > > +static int io_buffer_reg_unreg_bvec(struct io_ring_ctx *ctx,
> > > > > +                                   struct io_buf_data *buf,
> > > > > +                                   unsigned int issue_flags,
> > > > > +                                   bool reg)
> > > > > +{
> > > > > +       struct io_ring_ctx *remote_ctx =3D ctx;
> > > > > +       struct file *file =3D NULL;
> > > > > +       int ret;
> > > > > +
> > > > > +       if (buf->has_fd) {
> > > > > +               file =3D io_uring_register_get_file(buf->ring_fd,=
 buf->registered_fd);
> > > > > +               if (IS_ERR(file))
> > > > > +                       return PTR_ERR(file);
> > > >
> > > > It would be good to avoid the overhead of this lookup and
> > > > reference-counting in the I/O path. Would it be possible to move th=
is
> > > > lookup to when UBLK_IO_FETCH_REQ (and UBLK_IO_COMMIT_AND_FETCH_REQ,=
 if
> > > > it specifies a different ring_fd) is submitted? I guess that might
> > > > require storing an extra io_ring_ctx pointer in struct ublk_io.
> > >
> > > Let's start from the flexible way & simple implementation.
> > >
> > > Any optimization & improvement can be done as follow-up.
> >
> > Sure, we can start with this as-is. But I suspect the extra
> > reference-counting here will significantly decrease the benefit of the
> > auto-register register feature.
>
> The reference-counting should only be needed for registering buffer to
> external ring, which may have been slow because of the cross-ring thing..=
.

The current code is incrementing and decrementing the io_uring file
reference count even if the remote_ctx =3D=3D ctx, right? I agree it
should definitely be possible to skip the reference count in that
case, as this code is already running in task work context for a
command on the io_uring. It should also be possible to avoid atomic
reference-counting in the UBLK_AUTO_BUF_REGISTERED_RING case too.

>
> Maybe we can start automatic buffer register for ubq_daemon context only,
> meantime allow to register buffer from external io_uring by adding per-io
> spin_lock, which may help the per-io task Uday is working on too.

I'm not sure I understand why a spinlock would be required? In Uday's
patch set, each ublk_io still belongs to a single task. So no
additional locking should be required.

>
> And the interface still allow to support automatic buffer register to
> external io_uring since `ublk_auto_buf_reg` includes 'flags' field, we ca=
n
> enable it in future when efficient implementation is figured out.

Sure, we can definitely start with support only for auto-registering
the buffer with the ublk command's own io_uring. Implementing a flag
in the future to specify a different io_uring seems like a good
approach.

Best,
Caleb
