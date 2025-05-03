Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65C61B0421
	for <linux-block@vger.kernel.org>; Sat,  3 May 2025 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746298521; cv=none; b=hCQnlV7uaTRuF+9FOMOJhPHkdvdhNgUpYdc/K2SYfDCl0hXAcud93N3bDUdVCo1yKQMm933rXFzC5NV/7coOqN4dnMfKn7qnkGb4SjodcZY/9XOzWg7XQttkSI2VHqsHhA6zO0jomXS07zT+x9IdyMeHM2mQI8xcNsME5cff4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746298521; c=relaxed/simple;
	bh=gdF0baaOaGsLf0LJTINQfnV36xXHMBt16DPXn0eP1gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPA8QJAKpIyfOY78mRW5HqtDuDXA1lnCNueTCvdZzgisVqNK9MAJIGM5Z1V41HoSsOS6t93+9BbXtNNo9ox5yZ6qZ1QQU4PX7YLEya0+ZPno0p5kT66GKOnbsN5Zd46KCJ4F0LIbhHapx3mcvkC7VkTFNP4flNNISUAPh+bnOVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PVOD19Lv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PVOD19Lv"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22e19c71070so1749675ad.3
        for <linux-block@vger.kernel.org>; Sat, 03 May 2025 11:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746298517; x=1746903317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9h+PagQO+DZ8VarF0aamKHZ38VVRHlm1A3553jom0iA=;
        b=PVOD19LviaxzAjgsBpcKIhAQUov7HuRALBjeQZCfza2q22pgGO4WPrZ3Prrvna57bn
         qdcRunoTw0HVPMaQswbouAgKVHHlaCE+RRWxE3YW/e8pFWUZSGJsuT29kYYDnDSKMIGb
         KBVHJN7/ummtTTsK9pGLaZbo8+gXseosIg2/+cCGp6EpGXXqPlJsCnjCkjkkYqAdAJcC
         14Iq0rGV+QaYg0VYYS11wSgnCHZLcGNa9z98y6gN8hYV82Y9IDSDvunFb33CWe5qn9mG
         HTxe9FbuDPEPmzHR7l4LrX2LJuh8sXVD5EE2WuR7iTWq/38f6CY+dUi5Hxp3Sawh+KZk
         2mkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746298517; x=1746903317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h+PagQO+DZ8VarF0aamKHZ38VVRHlm1A3553jom0iA=;
        b=JxRjfRBiOkkFIFWbzpK5eommSr0hdGlWdX94RFJ5UgORD+vVmS1ICh8KIQ+x/33A/H
         xTW0GmGwrFVXTwZTOGlBfSoTsYeDX6qm3rkgPZdiZokygXfNtx2qygtVm5ETSgANE+Ot
         Lp7Dk0ndwMUcWkFeqBsDBaRuVCSjNq0cG+TbiZXi4cxnQRF0WMt7d/d7DehCC0QHmgVF
         wpBPULnFOrN+xkAgodDd/dLmg8i9cBjNXjVobe8dqG49f/oh+qWN/heDalAOSboL1uA9
         ZjztvTBU04J86NRpu5ytkIvy7IWzRlozvt6VkB/p0iVL8qNPLqJ9lTbNw372UwPLnZXl
         eEag==
X-Forwarded-Encrypted: i=1; AJvYcCVBxUJ/1TFhK+KyFp6jq1mDx2jcHwM/X1wqJtKls2SWrwaeV01YSXVywbfPGgmYqMYtBNlV0cRYbUygBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIvVXD7fytXhvTtGN2nLXrLyS9lYnzXJZUYSZHe9Dcy4ltZVJK
	u6CxFi32sgQl2qZZXvkDPK/tDLU+0jweHGMD2n1fWMcPINq2GR6sDAKTLtRKRew613kA2qT/0EQ
	g+RU383LmAk/CEEgiY9fyaNSVOj5UgPvLMok/+imGrPoNUfOajM76Gw==
X-Gm-Gg: ASbGncvAXlzH3vQQiIu/dqGio5tFmVrygljFDncXbbvXsxmzsUnZn24nW7LzULyUuuC
	Ktu6SA0KuiLImbxlrDhGeIJyCvTDvrd8KPwxaENb+ZZetP/SxtU5UrgvUi3veYyhj88ZPlr4eSt
	Zq7TUbDvZou4A8shubZafP
X-Google-Smtp-Source: AGHT+IF/1hCTFidAeu+wIQgPaMb7/eM95Cs2RPI7wbrrua1BCg0/sxNwsLC+GyjuUG/R7u5qAfL2vNxiuO0Lw07Tvhc=
X-Received: by 2002:a17:90b:380a:b0:2ff:5540:bb48 with SMTP id
 98e67ed59e1d1-30a4e72539emr4377869a91.8.1746298516973; Sat, 03 May 2025
 11:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428094420.1584420-1-ming.lei@redhat.com> <20250428094420.1584420-4-ming.lei@redhat.com>
 <CADUfDZrXTzXM4tA6vRcOz1qn61he+Y6p5UsLeprbmhDVJe0gbg@mail.gmail.com>
 <aBJDClTlYV48h3P3@fedora> <CADUfDZoROJeDKNWOzbgEqrs_B7kU2qNWwZxfnS2TDqYxiXrY0w@mail.gmail.com>
 <aBTr5fz5KOgd9RiD@fedora> <CADUfDZqetfAE_s8-GDSLmYTdgrqFLv+YZ1vndg0uD38NuXW3Nw@mail.gmail.com>
 <aBVqndZc-FjlHG-V@fedora>
In-Reply-To: <aBVqndZc-FjlHG-V@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 3 May 2025 11:55:05 -0700
X-Gm-Features: ATxdqUEdPZwCBFis4Wrvh-DVRB1KXULDLjebG8Mj6VZyldqTNA8PhCZLBt5BlL0
Message-ID: <CADUfDZoypP63aBjwUB50hZTiZ_ouN1Bt73-hHBY75xsNq9OGZQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] io_uring: support to register bvec buffer to
 specified io_uring
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 6:00=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Fri, May 02, 2025 at 02:21:05PM -0700, Caleb Sander Mateos wrote:
> > On Fri, May 2, 2025 at 8:59=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > On Thu, May 01, 2025 at 06:31:03PM -0700, Caleb Sander Mateos wrote:
> > > > On Wed, Apr 30, 2025 at 8:34=E2=80=AFAM Ming Lei <ming.lei@redhat.c=
om> wrote:
> > > > >
> > > > > On Mon, Apr 28, 2025 at 05:43:12PM -0700, Caleb Sander Mateos wro=
te:
> > > > > > On Mon, Apr 28, 2025 at 2:44=E2=80=AFAM Ming Lei <ming.lei@redh=
at.com> wrote:
> > > > > > >
> > > > > > > Extend io_buffer_register_bvec() and io_buffer_unregister_bve=
c() for
> > > > > > > supporting to register/unregister bvec buffer to specified io=
_uring,
> > > > > > > which FD is usually passed from userspace.
> > > > > > >
> > > > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > > > ---
> > > > > > >  include/linux/io_uring/cmd.h |  4 ++
> > > > > > >  io_uring/rsrc.c              | 83 ++++++++++++++++++++++++++=
+---------
> > > > > > >  2 files changed, 67 insertions(+), 20 deletions(-)
> > > > > > >
> > > > > > > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_=
uring/cmd.h
> > > > > > > index 78fa336a284b..7516fe5cd606 100644
> > > > > > > --- a/include/linux/io_uring/cmd.h
> > > > > > > +++ b/include/linux/io_uring/cmd.h
> > > > > > > @@ -25,6 +25,10 @@ struct io_uring_cmd_data {
> > > > > > >
> > > > > > >  struct io_buf_data {
> > > > > > >         unsigned short index;
> > > > > > > +       bool has_fd;
> > > > > > > +       bool registered_fd;
> > > > > > > +
> > > > > > > +       int ring_fd;
> > > > > > >         struct request *rq;
> > > > > > >         void (*release)(void *);
> > > > > > >  };
> > > > > > > diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> > > > > > > index 5f8ab130a573..701dd33fecf7 100644
> > > > > > > --- a/io_uring/rsrc.c
> > > > > > > +++ b/io_uring/rsrc.c
> > > > > > > @@ -969,21 +969,6 @@ static int __io_buffer_register_bvec(str=
uct io_ring_ctx *ctx,
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > -int io_buffer_register_bvec(struct io_uring_cmd *cmd,
> > > > > > > -                           struct io_buf_data *buf,
> > > > > > > -                           unsigned int issue_flags)
> > > > > > > -{
> > > > > > > -       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx=
;
> > > > > > > -       int ret;
> > > > > > > -
> > > > > > > -       io_ring_submit_lock(ctx, issue_flags);
> > > > > > > -       ret =3D __io_buffer_register_bvec(ctx, buf);
> > > > > > > -       io_ring_submit_unlock(ctx, issue_flags);
> > > > > > > -
> > > > > > > -       return ret;
> > > > > > > -}
> > > > > > > -EXPORT_SYMBOL_GPL(io_buffer_register_bvec);
> > > > > > > -
> > > > > > >  static int __io_buffer_unregister_bvec(struct io_ring_ctx *c=
tx,
> > > > > > >                                        struct io_buf_data *bu=
f)
> > > > > > >  {
> > > > > > > @@ -1006,19 +991,77 @@ static int __io_buffer_unregister_bvec=
(struct io_ring_ctx *ctx,
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > -int io_buffer_unregister_bvec(struct io_uring_cmd *cmd,
> > > > > > > -                             struct io_buf_data *buf,
> > > > > > > -                             unsigned int issue_flags)
> > > > > > > +static inline int do_reg_unreg_bvec(struct io_ring_ctx *ctx,
> > > > > > > +                                   struct io_buf_data *buf,
> > > > > > > +                                   unsigned int issue_flags,
> > > > > > > +                                   bool reg)
> > > > > > >  {
> > > > > > > -       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx=
;
> > > > > > >         int ret;
> > > > > > >
> > > > > > >         io_ring_submit_lock(ctx, issue_flags);
> > > > > > > -       ret =3D __io_buffer_unregister_bvec(ctx, buf);
> > > > > > > +       if (reg)
> > > > > > > +               ret =3D __io_buffer_register_bvec(ctx, buf);
> > > > > > > +       else
> > > > > > > +               ret =3D __io_buffer_unregister_bvec(ctx, buf)=
;
> > > > > >
> > > > > > It feels like unifying __io_buffer_register_bvec() and
> > > > > > __io_buffer_unregister_bvec() would belong better in the prior =
patch
> > > > > > that changes their signatures.
> > > > >
> > > > > Can you share how to do above in previous patch?
> > > >
> > > > I was thinking you could define do_reg_unreg_bvec() in the previous
> > > > patch. It's a logical step once you've extracted out all the
> > > > differences between io_buffer_register_bvec() and
> > > > io_buffer_unregister_bvec() into the helpers
> > > > __io_buffer_register_bvec() and __io_buffer_unregister_bvec(). But
> > > > either way is fine.
> > >
> > > 'has_fd' and 'ring_fd' fields isn't added yet, the defined do_reg_unr=
eg_bvec()
> > > could be quite simple, looks no big difference, I can do that...
> > >
> > > >
> > > > >
> > > > > >
> > > > > > >         io_ring_submit_unlock(ctx, issue_flags);
> > > > > > >
> > > > > > >         return ret;
> > > > > > >  }
> > > > > > > +
> > > > > > > +static int io_buffer_reg_unreg_bvec(struct io_ring_ctx *ctx,
> > > > > > > +                                   struct io_buf_data *buf,
> > > > > > > +                                   unsigned int issue_flags,
> > > > > > > +                                   bool reg)
> > > > > > > +{
> > > > > > > +       struct io_ring_ctx *remote_ctx =3D ctx;
> > > > > > > +       struct file *file =3D NULL;
> > > > > > > +       int ret;
> > > > > > > +
> > > > > > > +       if (buf->has_fd) {
> > > > > > > +               file =3D io_uring_register_get_file(buf->ring=
_fd, buf->registered_fd);
> > > > > > > +               if (IS_ERR(file))
> > > > > > > +                       return PTR_ERR(file);
> > > > > >
> > > > > > It would be good to avoid the overhead of this lookup and
> > > > > > reference-counting in the I/O path. Would it be possible to mov=
e this
> > > > > > lookup to when UBLK_IO_FETCH_REQ (and UBLK_IO_COMMIT_AND_FETCH_=
REQ, if
> > > > > > it specifies a different ring_fd) is submitted? I guess that mi=
ght
> > > > > > require storing an extra io_ring_ctx pointer in struct ublk_io.
> > > > >
> > > > > Let's start from the flexible way & simple implementation.
> > > > >
> > > > > Any optimization & improvement can be done as follow-up.
> > > >
> > > > Sure, we can start with this as-is. But I suspect the extra
> > > > reference-counting here will significantly decrease the benefit of =
the
> > > > auto-register register feature.
> > >
> > > The reference-counting should only be needed for registering buffer t=
o
> > > external ring, which may have been slow because of the cross-ring thi=
ng...
> >
> > The current code is incrementing and decrementing the io_uring file
> > reference count even if the remote_ctx =3D=3D ctx, right? I agree it
>
> Yes, but it can be changed to drop the inc/dec file reference easily sinc=
e we
> have a flag field.
>
> > should definitely be possible to skip the reference count in that
> > case, as this code is already running in task work context for a
> > command on the io_uring.
>
> The current 'uring_cmd' instance holds one reference of the
> io_ring_ctx instance.
>
> > It should also be possible to avoid atomic
> > reference-counting in the UBLK_AUTO_BUF_REGISTERED_RING case too.
>
> For registering buffer to external io_ring, it is hard to avoid to grag
> the io_uring_ctx reference when specifying the io_uring_ctx via its FD.

If the io_uring is specified by a file descriptor (not using
UBLK_AUTO_BUF_REGISTERED_RING), I agree reference counting is
necessary.
But the whole point of registering ring fds is to avoid reference
counting of the io_uring file. See how IORING_ENTER_REGISTERED_RING is
handled in io_uring_enter(). It simply indexes
current->io_uring->registered_rings to get the file, skipping the
fget() and fput(). Since the auto register is running in task work
context, it should also be able to access the task-local
registered_rings without reference counting.

>
> >
> > >
> > > Maybe we can start automatic buffer register for ubq_daemon context o=
nly,
> > > meantime allow to register buffer from external io_uring by adding pe=
r-io
> > > spin_lock, which may help the per-io task Uday is working on too.
> >
> > I'm not sure I understand why a spinlock would be required? In Uday's
> > patch set, each ublk_io still belongs to a single task. So no
> > additional locking should be required.
>
> I think it is very useful to allow to register io buffer in the
> other(non-ubq_daemon) io_uring context by the offload style.
>
> Especially the register/unregister io buffer uring_cmd is for handling
> target IO, which should have been issued in same context of target io
> handling.
>
> Without one per-io spinlock, it is hard to avoid one race you mentioned:

I don't believe a spinlock is necessary. It should be possible to
avoid accessing the ublk_io at all when registering the request
buffer. __ublk_check_and_get_req() calls kref_get_unless_zero() on the
request, which already ensures the request is owned by the ublk server
and prevents it from completing while its buffer is registered. This
is analogous to how UBLK_F_USER_COPY works;
ublk_ch_read_iter()/ublk_ch_write_iter() can be safely called from any
thread.

Best,
Caleb

>
> https://lore.kernel.org/linux-block/aA2pNRkBhgKsofRP@fedora/#t
>
> in case of bad ublk server implementation.
>
> >
> > >
> > > And the interface still allow to support automatic buffer register to
> > > external io_uring since `ublk_auto_buf_reg` includes 'flags' field, w=
e can
> > > enable it in future when efficient implementation is figured out.
> >
> > Sure, we can definitely start with support only for auto-registering
> > the buffer with the ublk command's own io_uring. Implementing a flag
> > in the future to specify a different io_uring seems like a good
> > approach.
>
> OK, I will send V2 by starting with auto-registering buffer to the ublk
> uring_cmd io_uring first.
>
>
> Thanks,
> Ming
>
