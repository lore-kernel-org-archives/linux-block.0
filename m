Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D86A1C84AD
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 01:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749779878; cv=none; b=Qm3r0XKL9pvbOO5j3+BUr32tccMpzClsSotHWYzbaIw21uQ4wbruoufI3V2vihCn/DdQPN0zOUIUoLLZGTGmDxkMM6ov/wj89UrmrnfTwTcYKVTimrKV0ZrSqrzSVu+mzh7B66S6styNVVePrgeYJaHcL5v9pXCthM1X73F/oSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749779878; c=relaxed/simple;
	bh=viIbmpG8MOVCywFltxK7shjj36zV8J8XIY82L6QSNic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVC1bhSIhtAI0+hK98gb1KyWtwiiKsDMBQnxR0gP24ER6SYlgAbDgQf7se6QRCVtrTESHRzWhjdJOjg8tJPytOgdGppDk52pwSl3rAQeGmjls3S3p13kI/A/H1gMfKLkZAtIhP3I/Wd46EPYVoxe/7YzCT6GWj9TDDpmFNb29sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JeSgnx6m; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JeSgnx6m"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313067339e9so239388a91.2
        for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 18:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749779876; x=1750384676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pc4I5QvTDGSX8XaUiLyFuKxtD9QvzNHnnfeRU8JT2EY=;
        b=JeSgnx6m8FnLgLQEQxDJhybTz9CQxrxv7OFAh+1nq/UD6iU8KLIRhQAT6pi3SLcVym
         HuCr7E3W/+p790StvITLnnXQEAMnaOdKnGFxZgUHXafhvfqfaLTZ/9CvrzY/44maD+Kr
         7Wj31pTEgMtwJRxea6HGPg3wnZ/EO2fmPSmvd1fannQA8qf+rBL0SZvbsr1HvbYMFA9j
         JePEoCt7gcmg20M87Z0vDVm1hU7My2dIjL1Wgldnb3z9xeioTsnD58z5tqIGsJBM1rpj
         /jNGkokV+5IEj9O4G32bcINDXx2/wKk8lzw5HjYtzkRSyMnJ/m+aH0/Xe/Sea59lon/l
         SqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749779876; x=1750384676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pc4I5QvTDGSX8XaUiLyFuKxtD9QvzNHnnfeRU8JT2EY=;
        b=IuuBPkPFh5qFrWFzdKgKRlR5yCxC2odjtWPySJwLX05z5L/AQwK4zQQdUPt3FZIYCr
         UWy2DrZfxNgI+TZPXz3+OeJj5ScJk52kw7hALEawwOD0Bt6oF+Ajwx+AljAOj2N3pKSs
         z7VBnVYKpLFc2F9qHNnIefgOXfCpkHyw57Dkph8ZTlOgbxT7bX2zoobQEE52GTHUJJjR
         A4Grj8+F4Jir2I52y04J/HtRZhZDHOERyr4eyrwE6enIkuogEWf9SLWsOdDkEL1DDnTN
         lBe1SCiY8UrSS3tUpFz1rqurp8+ewbXmgiILLqaupggl9UJLzVMNWvSb1OTg5u8et7R4
         FT+w==
X-Forwarded-Encrypted: i=1; AJvYcCWC+8XVb6de1yf0aScOA/6It/mLurlkrycDdGyK5xMVm3iWTjZC6fCAtuSSJD0B3gnlT02HqboUmphmVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0GAOXqAhOxXnChiXPLUNfemxsYvvHesP7tY9M++AOR9OMjFKu
	YJ2+GBJOyF/DksOphy+IiSD0F0tk2weFfiIfMX1gNLYhce5wENJ1kDBGNatLxTf5UvQWoPKkUtC
	rb5tqJpeQ4QNz9AkMc9NNfGyS8ly2Gdxf9eOrpuYFdw==
X-Gm-Gg: ASbGncv/i2POT2VczmfN3P7hMthT+KiDF9wmIRaKg7dzuVl385p/hkDZq/7bxGoby1V
	Mp8rYBfSB874D09ESrkt8Cd3Yi5UlRezLyvA40VaQoetKXj2yzZGXAT1U13SFB0UocNU4SwmI8p
	QLRjI1kQ9nfk4uZGooge/NbHh75xImzEBPx27FwY23ciU=
X-Google-Smtp-Source: AGHT+IH9rORcZVFvCURPsEQItnf932vkufokMuGekzotS9lqCzBHYvIe3cTLKWdkmxHA/z/DryrtMh8PAjI98zpvo6w=
X-Received: by 2002:a17:90b:3b4e:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-313d9eb10d7mr716736a91.5.1749779875747; Thu, 12 Jun 2025
 18:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609121426.1997271-1-ming.lei@redhat.com> <CADUfDZrHpGFKAEJhDqPNq_WMzWU5v9riN-i8V0dROo2tc=1DyA@mail.gmail.com>
 <aEeTO3t8qnBne9ef@fedora> <CADUfDZo-5ft7Krx==YLYbabPE+3Z1Yjrw2zcmn7VRqfx5XyFgg@mail.gmail.com>
 <aEpGh41uV3AJF-dG@fedora> <CADUfDZowptAiBxQ2w6NPJ4Bz0uCuJs3HsZ3pH1Q1J9wUmTXQ8g@mail.gmail.com>
 <aEt8Tu1mgjQerFuy@fedora> <CADUfDZr9t4gipcSaimv1kg21++kh-g49fKk92wPDzRvT3F+43A@mail.gmail.com>
 <aEuEmlC9BCYelEGc@fedora>
In-Reply-To: <aEuEmlC9BCYelEGc@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 12 Jun 2025 18:57:44 -0700
X-Gm-Features: AX0GCFuft0njyfPyQyxHiG6LrQxOS_nNmF97iVwqhSMIR-L5H9BDwZHXLzcIbLI
Message-ID: <CADUfDZrEUZNkwYUvgGQEZL4rD-1jwVSfV3xsG5_juLTubTh8eA@mail.gmail.com>
Subject: Re: [PATCH] ublk: document auto buffer registration(UBLK_F_AUTO_BUF_REG)
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 6:53=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Jun 12, 2025 at 06:36:41PM -0700, Caleb Sander Mateos wrote:
> > On Thu, Jun 12, 2025 at 6:18=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > On Thu, Jun 12, 2025 at 07:38:01AM -0700, Caleb Sander Mateos wrote:
> > > > On Wed, Jun 11, 2025 at 8:16=E2=80=AFPM Ming Lei <ming.lei@redhat.c=
om> wrote:
> > > > >
> > > > > On Wed, Jun 11, 2025 at 08:54:53AM -0700, Caleb Sander Mateos wro=
te:
> > > > > > On Mon, Jun 9, 2025 at 7:07=E2=80=AFPM Ming Lei <ming.lei@redha=
t.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 09, 2025 at 03:29:34PM -0700, Caleb Sander Mateos=
 wrote:
> > > > > > > > On Mon, Jun 9, 2025 at 5:14=E2=80=AFAM Ming Lei <ming.lei@r=
edhat.com> wrote:
> > > > > > > > >
> > > > > > > > > Document recently merged feature auto buffer registration=
(UBLK_F_AUTO_BUF_REG).
> > > > > > > > >
> > > > > > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > > > >
> > > > > > > > Thanks, this is a nice explanation. Just a few suggestions.
> > > > > > > >
> > > > > > > > > ---
> > > > > > > > >  Documentation/block/ublk.rst | 67 ++++++++++++++++++++++=
++++++++++++++
> > > > > > > > >  1 file changed, 67 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/Documentation/block/ublk.rst b/Documentation=
/block/ublk.rst
> > > > > > > > > index c368e1081b41..16ffca54eed4 100644
> > > > > > > > > --- a/Documentation/block/ublk.rst
> > > > > > > > > +++ b/Documentation/block/ublk.rst
> > > > > > > > > @@ -352,6 +352,73 @@ For reaching best IO performance, ub=
lk server should align its segment
> > > > > > > > >  parameter of `struct ublk_param_segment` with backend fo=
r avoiding
> > > > > > > > >  unnecessary IO split, which usually hurts io_uring perfo=
rmance.
> > > > > > > > >
> > > > > > > > > +Auto Buffer Registration
> > > > > > > > > +------------------------
> > > > > > > > > +
> > > > > > > > > +The ``UBLK_F_AUTO_BUF_REG`` feature automatically handle=
s buffer registration
> > > > > > > > > +and unregistration for I/O requests, which simplifies th=
e buffer management
> > > > > > > > > +process and reduces overhead in the ublk server implemen=
tation.
> > > > > > > > > +
> > > > > > > > > +This is another feature flag for using zero copy, and it=
 is compatible with
> > > > > > > > > +``UBLK_F_SUPPORT_ZERO_COPY``.
> > > > > > > > > +
> > > > > > > > > +Feature Overview
> > > > > > > > > +~~~~~~~~~~~~~~~~
> > > > > > > > > +
> > > > > > > > > +This feature automatically registers request buffers to =
the io_uring context
> > > > > > > > > +before delivering I/O commands to the ublk server and un=
registers them when
> > > > > > > > > +completing I/O commands. This eliminates the need for ma=
nual buffer
> > > > > > > > > +registration/unregistration via ``UBLK_IO_REGISTER_IO_BU=
F`` and
> > > > > > > > > +``UBLK_IO_UNREGISTER_IO_BUF`` commands, then IO handling=
 in ublk server
> > > > > > > > > +can avoid dependency on the two uring_cmd operations.
> > > > > > > > > +
> > > > > > > > > +This way not only simplifies ublk server implementation,=
 but also makes
> > > > > > > > > +concurrent IO handling becomes possible.
> > > > > > > >
> > > > > > > > I'm not sure what "concurrent IO handling" refers to. Any u=
blk server
> > > > > > > > can handle incoming I/O requests concurrently, regardless o=
f what
> > > > > > > > features it has enabled. Do you mean it avoids the need for=
 linked
> > > > > > > > io_uring requests to properly order buffer registration and
> > > > > > > > unregistration with the I/O operations using the registered=
 buffer?
> > > > > > >
> > > > > > > Yes, if io_uring OPs depends on buffer registering & unregist=
ering, these
> > > > > > > OPs can't be issued concurrently any more, that is one io_uri=
ng constraint.
> > > > > > >
> > > > > > > I will add the above words.
> > > > > > >
> > > > > > > >
> > > > > > > > > +
> > > > > > > > > +Usage Requirements
> > > > > > > > > +~~~~~~~~~~~~~~~~~~
> > > > > > > > > +
> > > > > > > > > +1. The ublk server must create a sparse buffer table on =
the same ``io_ring_ctx``
> > > > > > > > > +   used for ``UBLK_IO_FETCH_REQ`` and ``UBLK_IO_COMMIT_A=
ND_FETCH_REQ``.
> > > > > > > > > +
> > > > > > > > > +2. If uring_cmd is issued on a different ``io_ring_ctx``=
, manual buffer
> > > > > > > > > +   unregistration is required.
> > > > > > > >
> > > > > > > > nit: don't think this needs to be a separate point, could b=
e combined with (1).
> > > > > > >
> > > > > > > OK.
> > > > > > >
> > > > > > > >
> > > > > > > > > +
> > > > > > > > > +3. Buffer registration data must be passed via uring_cmd=
's ``sqe->addr`` with the
> > > > > > > > > +   following structure::
> > > > > > > >
> > > > > > > > nit: extra ":"
> > > > > > >
> > > > > > > In reStructuredText (reST), the double colon :: serves as a l=
iteral block marker to
> > > > > > > indicate preformatted text.
> > > > > > >
> > > > > > > >
> > > > > > > > > +
> > > > > > > > > +    struct ublk_auto_buf_reg {
> > > > > > > > > +        __u16 index;      /* Buffer index for registrati=
on */
> > > > > > > > > +        __u8 flags;       /* Registration flags */
> > > > > > > > > +        __u8 reserved0;   /* Reserved for future use */
> > > > > > > > > +        __u32 reserved1;  /* Reserved for future use */
> > > > > > > > > +    };
> > > > > > > >
> > > > > > > > Suggest using ublk_auto_buf_reg_to_sqe_addr()? Otherwise, i=
t seems
> > > > > > > > ambiguous how this struct is "passed" in sqe->addr.
> > > > > > >
> > > > > > > OK
> > > > > > >
> > > > > > > >
> > > > > > > > > +
> > > > > > > > > +4. All reserved fields in ``ublk_auto_buf_reg`` must be =
zeroed.
> > > > > > > > > +
> > > > > > > > > +5. Optional flags can be passed via ``ublk_auto_buf_reg.=
flags``.
> > > > > > > > > +
> > > > > > > > > +Fallback Behavior
> > > > > > > > > +~~~~~~~~~~~~~~~~~
> > > > > > > > > +
> > > > > > > > > +When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
> > > > > > > > > +
> > > > > > > > > +1. If auto buffer registration fails:
> > > > > > > >
> > > > > > > > I would switch these. Both (1) and (2) refer to when auto b=
uffer
> > > > > > > > registration fails. So I would expect something like:
> > > > > > > >
> > > > > > > > If auto buffer registration fails:
> > > > > > > >
> > > > > > > > 1. When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
> > > > > > > > ...
> > > > > > > > 2. If fallback is not enabled:
> > > > > > > > ...
> > > > > > > >
> > > > > > > > > +   - The uring_cmd is completed
> > > > > > > >
> > > > > > > > Maybe add "without registering the request buffer"?
> > > > > > > >
> > > > > > > > > +   - ``UBLK_IO_F_NEED_REG_BUF`` is set in ``ublksrv_io_d=
esc.op_flags``
> > > > > > > > > +   - The ublk server must manually register the buffer
> > > > > > > >
> > > > > > > > Only if it wants a registered buffer for the ublk request. =
Technically
> > > > > > > > the ublk server could decide to fall back on user-copy, for=
 example.
> > > > > > >
> > > > > > > Good catch!
> > > > > > >
> > > > > > > >
> > > > > > > > > +
> > > > > > > > > +2. If fallback is not enabled:
> > > > > > > > > +   - The ublk I/O request fails silently
> > > > > > > >
> > > > > > > > "silently" is a bit ambiguous. It's certainly not silent to=
 the
> > > > > > > > application submitting the ublk I/O. Maybe say that the ubl=
k I/O
> > > > > > > > request fails and no uring_cmd is completed to the ublk ser=
ver?
> > > > > > >
> > > > > > > Yes, but the document focus on ublk side, and the client is g=
eneric
> > > > > > > for every driver, so I guess it may be fine.
> > > > > > >
> > > > > > > >
> > > > > > > > > +
> > > > > > > > > +Limitations
> > > > > > > > > +~~~~~~~~~~~
> > > > > > > > > +
> > > > > > > > > +- Requires same ``io_ring_ctx`` for all operations
> > > > > > > >
> > > > > > > > Another limitation that prevents us from adopting the auto =
buffer
> > > > > > > > registration feature is the need to reserve a unique buffer=
 table
> > > > > > > > index for every ublk tag on the io_ring_ctx. Since the io_r=
ing_ctx
> > > > > > > > buffer table has a max size of 16K (could potentially be in=
creased to
> > > > > > > > 64K), this limit is easily reached when there are a large n=
umber of
> > > > > > > > ublk devices or the ublk queue depth is large. I think we c=
ould remove
> > > > > > > > this limitation in the future by adding support for allocat=
ing buffer
> > > > > > > > indices on demand, analogous to IORING_FILE_INDEX_ALLOC.
> > > > > > >
> > > > > > > OK.
> > > > > > >
> > > > > > > But I guess it isn't big deal in reality since the task conte=
xt should
> > > > > > > be saturated easily with so big setting.
> > > > > >
> > > > > > I don't know about your "reality" but it's certainly a big deal=
 for us :)
> > > > > > To reduce contention on the blk-mq queues for the application
> > > > > > submitting I/O to the ublk devices, we want a large number of q=
ueues
> > > > > > for each ublk device. But we also want a large queue depth for =
each
> > > > > > individual queue to avoid the async request allocation path in =
case
> > > > > > any one application thread issues a lot of concurrent I/O to a =
single
> > > > > > ublk device. And we have 128 ublk devices, which again all want=
 large
> > > > > > queue depths in case the application sends a lot of I/O to a si=
ngle
> > > > > > ublk device. The result is that concurrently each ublk server t=
hread
> > > > > > fetches 512K ublk I/Os, which is significantly above the io_rin=
g_ctx
> > > > > > buffer table limit.
> > > > >
> > > > > Yes, you can setup 512K I/Os in single task/io_uring context, but=
 how many
> > > > > can be actively handled during unit time? The number could be muc=
h less than
> > > > > 512k or 16K, because it is a single pthread/io_uring/cpu core, wh=
ich may be
> > > > > saturated easily, so most of these IOs may wait somewhere for cpu=
 or whatever
> > > > > resource.
> > > >
> > > > Yes, that's exactly my point. Our ublk server only allocates enough
> > > > resources to handle 4K concurrent I/Os per thread. But since we don=
't
> > > > know which ublk devices or queues might receive the I/Os, we have t=
o
> > > > fetch a queue depth of 4K on *every* ublk device queue. Perhaps the
> > > > batched approach you're working on will help here. But for now, the
> > > > total number of fetched ublk I/Os is an obstacle to adopting auto
> > > > buffer registration.
> > >
> > > oops, I forget the point that buffer index has to be provided beforeh=
and,
> > > that is really one limit for your case with too many IOs in single ur=
ing
> > > context.
> > >
> > > The batched approach may not help too because the model is to issue c=
ommand
> > > beforehand for fetching new io command.
> > >
> > > > And waiting to allocate the buffer index until an
> > > > incoming I/O actually needs to register a buffer seems like a
> > > > straightforward way to avoid this obstacle.
> > >
> > > One way is to rely on bpf program to allocate & provide buffer index =
via
> > > struct_ops, which can be called exactly before registering & unregist=
ering
> > > io buffer. The concept should be simple, but the whole implementation=
 may
> > > take some effort(most are boiler plate).
> >
> > A BPF program feels overly complex. Ideally the ublk server could
> > create a sparse buffer table and just let io_uring allocate an unused
> > buffer index for each incoming ublk I/O and return it in the io_uring
> > CQE. This is basically identical to IORING_FILE_INDEX_ALLOC, except
> > for registered buffers instead of registered files. It would require a
> > change in io_uring to support allocating a registered buffer index on
> > demand, but hopefully not too much work to leverage what already
> > exists for registered files. And the ublk server would of course have
> > to set UBLK_AUTO_BUF_REG_FALLBACK to gracefully handle buffer index
> > allocation failures if the client application issues more concurrent
> > I/Os than there are available buffer indices.
>
> Indeed, it may be simpler than IORING_FILE_INDEX_ALLOC, since it needn't
> to expose as uapi, the user can be just io_buffer_register_bvec().
>
> Care to make a patch?

Sure, can do. Give me a couple days, I have a number of other things
on my plate.

Best,
Caleb
