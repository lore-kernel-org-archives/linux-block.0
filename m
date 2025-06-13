Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E382F4317
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 01:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749778615; cv=none; b=IzEgzorBqvfkxy4szi9JSURYj01bkEBZg6KrTP44/lhwcvHAWWxh8Teuq3TTLrKbx7NdgpLPYYPgITCGmpxHzy0Xr5Vt7j//IvmCCTp16NmfTnpdP6YowiB6YuAygOypx/SuGSVVfuPweG2nAcyYPS7VwThjurfGlU/g4+TBw0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749778615; c=relaxed/simple;
	bh=AHsPeXkz5Diy+MbW88Ivm4A4sFqQdytEh11dPoIBVng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYPQ4JFfU0JS4JV4oa2CAwNW9XjxmC9oA2AU00HBATWO7pmAi6/rwqTAOdg2hYE22k/oFnuDTMf45qmVHrP7MZDJuvJ16oKRl/ce+QmJw33GnEXOQswi89B0XYPJ8U8i/ZIrWwTIl051LdiwKExD1XjWpWGkY33zn+nCoHLtyjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DdFJVeT2; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DdFJVeT2"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-312a806f002so189264a91.3
        for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 18:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749778613; x=1750383413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CfN5tIScXY6QW50fI8mKTAxAfcecM3ZmCeqI06+eHo=;
        b=DdFJVeT2mI4zXXG4+E0StIrMTL7QBhvHcdJXkxiTCMCKvhPOvQapPjsmW2ipYH2FX6
         ARrXWnoW4W94PcR68gMOnzVTX090Nsc/atd19CrtFJYpSeCrSIPnVPQgAz0xXJ1G36v7
         rcskoIMO1SxsimJNOddc8c4+o4/0vyaBHw9zhNSzeTbEsookeyreEWGOG6gRH/rJ2LEk
         eNEjchgXwpuCeL6VuKy+2BNVpwfuuZeduLFTX3/6cqfQofAwQ6t/5sceAPpbHsRynhaA
         QDFd3pShEbNfGZcMq/FXQvwOSblACnVwEew7Fagm9X9zpea/4Ls3B2rq7IqVXIX/hg5h
         mYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749778613; x=1750383413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CfN5tIScXY6QW50fI8mKTAxAfcecM3ZmCeqI06+eHo=;
        b=MB00sk1xX99Uuo/nqytuVogrcStSbsMdDov3yWAo0cCFaXvWeSCjm2T3Qpv1wsfOGw
         Fntdwpe0m6dL2Q61LTIXknD8B9MwwxjpGnv56hk4XLJDQhbTKDDgZ364f9GYIkVOaYzL
         DiyOkE6wfnRDWyQ46O12ZZ8qV0MXzJRkrx5MXza5Efezl3j6FzXI0KeeM7qlCzVNkV6g
         Z3kdqDTtJT8cu6CV6EiRNWDHKWDID4RTzy3R35SanXU3oGVFOffeM/k4fDtTT69yVm14
         +4LvpXk4VL1BlJYd/5z3ZocdrQ9PQW8eV4Oj/G1nZtEXLUsEChgLpscUBiqlWx+bKnyX
         zDkg==
X-Forwarded-Encrypted: i=1; AJvYcCXYWcMvOUJTnWAxeGiOXO8j6/EhSlEv+LAGi7Lzu8sMK6NvQ4ULkyxCjq/WLkqocly1zWEM2WYqTGMI+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUI6Z564Mq7EIw4qoAgPzsoeH+BJzekTQUEjcYYXiiT+uuCLOd
	tnLqwTzyPOMvND7rHg15Mm3iZS3ZnlCFrMxoks5UAcgt/eWynGpA+qd5Q107iNqDDLYLYHPD231
	tN4Vn/IKNh3JN0utqD7tb5WTQzv4L+Eb/uylzOI4wxA==
X-Gm-Gg: ASbGncucL0j5ncCldmDLkDl1YAOqDh8RLosUVf12vBhbVsKTnCu1Dq3eOligFPE1u9u
	4Est0ZP1WsJYW287vvjmK8l20obiuw8/SuGgy3v3tQEvx4O1hPJ9sz4DGiwyY49EYwgPEScJd7O
	dF023GiqFb2p+zi5fxCXeup8JC0vWJR+1PjdPcouwN3Lo=
X-Google-Smtp-Source: AGHT+IE1DVH0noMXsEEjSOu5y5s+PXLL632/fuHGPaXOI4KxOBsW+GkWyc1UuImFLSFdy9WuYVJak7XZhcr/d17zbwU=
X-Received: by 2002:a17:902:c94c:b0:234:d7b2:2aaf with SMTP id
 d9443c01a7336-2365d8c61bemr6381985ad.7.1749778612694; Thu, 12 Jun 2025
 18:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609121426.1997271-1-ming.lei@redhat.com> <CADUfDZrHpGFKAEJhDqPNq_WMzWU5v9riN-i8V0dROo2tc=1DyA@mail.gmail.com>
 <aEeTO3t8qnBne9ef@fedora> <CADUfDZo-5ft7Krx==YLYbabPE+3Z1Yjrw2zcmn7VRqfx5XyFgg@mail.gmail.com>
 <aEpGh41uV3AJF-dG@fedora> <CADUfDZowptAiBxQ2w6NPJ4Bz0uCuJs3HsZ3pH1Q1J9wUmTXQ8g@mail.gmail.com>
 <aEt8Tu1mgjQerFuy@fedora>
In-Reply-To: <aEt8Tu1mgjQerFuy@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 12 Jun 2025 18:36:41 -0700
X-Gm-Features: AX0GCFsvWxUL9BT8nmJUmkifcs2VW_zowryR6e3b7JIbAWLA9PT76CzQQxjKd_c
Message-ID: <CADUfDZr9t4gipcSaimv1kg21++kh-g49fKk92wPDzRvT3F+43A@mail.gmail.com>
Subject: Re: [PATCH] ublk: document auto buffer registration(UBLK_F_AUTO_BUF_REG)
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 6:18=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Jun 12, 2025 at 07:38:01AM -0700, Caleb Sander Mateos wrote:
> > On Wed, Jun 11, 2025 at 8:16=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > On Wed, Jun 11, 2025 at 08:54:53AM -0700, Caleb Sander Mateos wrote:
> > > > On Mon, Jun 9, 2025 at 7:07=E2=80=AFPM Ming Lei <ming.lei@redhat.co=
m> wrote:
> > > > >
> > > > > On Mon, Jun 09, 2025 at 03:29:34PM -0700, Caleb Sander Mateos wro=
te:
> > > > > > On Mon, Jun 9, 2025 at 5:14=E2=80=AFAM Ming Lei <ming.lei@redha=
t.com> wrote:
> > > > > > >
> > > > > > > Document recently merged feature auto buffer registration(UBL=
K_F_AUTO_BUF_REG).
> > > > > > >
> > > > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > >
> > > > > > Thanks, this is a nice explanation. Just a few suggestions.
> > > > > >
> > > > > > > ---
> > > > > > >  Documentation/block/ublk.rst | 67 ++++++++++++++++++++++++++=
++++++++++
> > > > > > >  1 file changed, 67 insertions(+)
> > > > > > >
> > > > > > > diff --git a/Documentation/block/ublk.rst b/Documentation/blo=
ck/ublk.rst
> > > > > > > index c368e1081b41..16ffca54eed4 100644
> > > > > > > --- a/Documentation/block/ublk.rst
> > > > > > > +++ b/Documentation/block/ublk.rst
> > > > > > > @@ -352,6 +352,73 @@ For reaching best IO performance, ublk s=
erver should align its segment
> > > > > > >  parameter of `struct ublk_param_segment` with backend for av=
oiding
> > > > > > >  unnecessary IO split, which usually hurts io_uring performan=
ce.
> > > > > > >
> > > > > > > +Auto Buffer Registration
> > > > > > > +------------------------
> > > > > > > +
> > > > > > > +The ``UBLK_F_AUTO_BUF_REG`` feature automatically handles bu=
ffer registration
> > > > > > > +and unregistration for I/O requests, which simplifies the bu=
ffer management
> > > > > > > +process and reduces overhead in the ublk server implementati=
on.
> > > > > > > +
> > > > > > > +This is another feature flag for using zero copy, and it is =
compatible with
> > > > > > > +``UBLK_F_SUPPORT_ZERO_COPY``.
> > > > > > > +
> > > > > > > +Feature Overview
> > > > > > > +~~~~~~~~~~~~~~~~
> > > > > > > +
> > > > > > > +This feature automatically registers request buffers to the =
io_uring context
> > > > > > > +before delivering I/O commands to the ublk server and unregi=
sters them when
> > > > > > > +completing I/O commands. This eliminates the need for manual=
 buffer
> > > > > > > +registration/unregistration via ``UBLK_IO_REGISTER_IO_BUF`` =
and
> > > > > > > +``UBLK_IO_UNREGISTER_IO_BUF`` commands, then IO handling in =
ublk server
> > > > > > > +can avoid dependency on the two uring_cmd operations.
> > > > > > > +
> > > > > > > +This way not only simplifies ublk server implementation, but=
 also makes
> > > > > > > +concurrent IO handling becomes possible.
> > > > > >
> > > > > > I'm not sure what "concurrent IO handling" refers to. Any ublk =
server
> > > > > > can handle incoming I/O requests concurrently, regardless of wh=
at
> > > > > > features it has enabled. Do you mean it avoids the need for lin=
ked
> > > > > > io_uring requests to properly order buffer registration and
> > > > > > unregistration with the I/O operations using the registered buf=
fer?
> > > > >
> > > > > Yes, if io_uring OPs depends on buffer registering & unregisterin=
g, these
> > > > > OPs can't be issued concurrently any more, that is one io_uring c=
onstraint.
> > > > >
> > > > > I will add the above words.
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +Usage Requirements
> > > > > > > +~~~~~~~~~~~~~~~~~~
> > > > > > > +
> > > > > > > +1. The ublk server must create a sparse buffer table on the =
same ``io_ring_ctx``
> > > > > > > +   used for ``UBLK_IO_FETCH_REQ`` and ``UBLK_IO_COMMIT_AND_F=
ETCH_REQ``.
> > > > > > > +
> > > > > > > +2. If uring_cmd is issued on a different ``io_ring_ctx``, ma=
nual buffer
> > > > > > > +   unregistration is required.
> > > > > >
> > > > > > nit: don't think this needs to be a separate point, could be co=
mbined with (1).
> > > > >
> > > > > OK.
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +3. Buffer registration data must be passed via uring_cmd's `=
`sqe->addr`` with the
> > > > > > > +   following structure::
> > > > > >
> > > > > > nit: extra ":"
> > > > >
> > > > > In reStructuredText (reST), the double colon :: serves as a liter=
al block marker to
> > > > > indicate preformatted text.
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +    struct ublk_auto_buf_reg {
> > > > > > > +        __u16 index;      /* Buffer index for registration *=
/
> > > > > > > +        __u8 flags;       /* Registration flags */
> > > > > > > +        __u8 reserved0;   /* Reserved for future use */
> > > > > > > +        __u32 reserved1;  /* Reserved for future use */
> > > > > > > +    };
> > > > > >
> > > > > > Suggest using ublk_auto_buf_reg_to_sqe_addr()? Otherwise, it se=
ems
> > > > > > ambiguous how this struct is "passed" in sqe->addr.
> > > > >
> > > > > OK
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +4. All reserved fields in ``ublk_auto_buf_reg`` must be zero=
ed.
> > > > > > > +
> > > > > > > +5. Optional flags can be passed via ``ublk_auto_buf_reg.flag=
s``.
> > > > > > > +
> > > > > > > +Fallback Behavior
> > > > > > > +~~~~~~~~~~~~~~~~~
> > > > > > > +
> > > > > > > +When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
> > > > > > > +
> > > > > > > +1. If auto buffer registration fails:
> > > > > >
> > > > > > I would switch these. Both (1) and (2) refer to when auto buffe=
r
> > > > > > registration fails. So I would expect something like:
> > > > > >
> > > > > > If auto buffer registration fails:
> > > > > >
> > > > > > 1. When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
> > > > > > ...
> > > > > > 2. If fallback is not enabled:
> > > > > > ...
> > > > > >
> > > > > > > +   - The uring_cmd is completed
> > > > > >
> > > > > > Maybe add "without registering the request buffer"?
> > > > > >
> > > > > > > +   - ``UBLK_IO_F_NEED_REG_BUF`` is set in ``ublksrv_io_desc.=
op_flags``
> > > > > > > +   - The ublk server must manually register the buffer
> > > > > >
> > > > > > Only if it wants a registered buffer for the ublk request. Tech=
nically
> > > > > > the ublk server could decide to fall back on user-copy, for exa=
mple.
> > > > >
> > > > > Good catch!
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +2. If fallback is not enabled:
> > > > > > > +   - The ublk I/O request fails silently
> > > > > >
> > > > > > "silently" is a bit ambiguous. It's certainly not silent to the
> > > > > > application submitting the ublk I/O. Maybe say that the ublk I/=
O
> > > > > > request fails and no uring_cmd is completed to the ublk server?
> > > > >
> > > > > Yes, but the document focus on ublk side, and the client is gener=
ic
> > > > > for every driver, so I guess it may be fine.
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +Limitations
> > > > > > > +~~~~~~~~~~~
> > > > > > > +
> > > > > > > +- Requires same ``io_ring_ctx`` for all operations
> > > > > >
> > > > > > Another limitation that prevents us from adopting the auto buff=
er
> > > > > > registration feature is the need to reserve a unique buffer tab=
le
> > > > > > index for every ublk tag on the io_ring_ctx. Since the io_ring_=
ctx
> > > > > > buffer table has a max size of 16K (could potentially be increa=
sed to
> > > > > > 64K), this limit is easily reached when there are a large numbe=
r of
> > > > > > ublk devices or the ublk queue depth is large. I think we could=
 remove
> > > > > > this limitation in the future by adding support for allocating =
buffer
> > > > > > indices on demand, analogous to IORING_FILE_INDEX_ALLOC.
> > > > >
> > > > > OK.
> > > > >
> > > > > But I guess it isn't big deal in reality since the task context s=
hould
> > > > > be saturated easily with so big setting.
> > > >
> > > > I don't know about your "reality" but it's certainly a big deal for=
 us :)
> > > > To reduce contention on the blk-mq queues for the application
> > > > submitting I/O to the ublk devices, we want a large number of queue=
s
> > > > for each ublk device. But we also want a large queue depth for each
> > > > individual queue to avoid the async request allocation path in case
> > > > any one application thread issues a lot of concurrent I/O to a sing=
le
> > > > ublk device. And we have 128 ublk devices, which again all want lar=
ge
> > > > queue depths in case the application sends a lot of I/O to a single
> > > > ublk device. The result is that concurrently each ublk server threa=
d
> > > > fetches 512K ublk I/Os, which is significantly above the io_ring_ct=
x
> > > > buffer table limit.
> > >
> > > Yes, you can setup 512K I/Os in single task/io_uring context, but how=
 many
> > > can be actively handled during unit time? The number could be much le=
ss than
> > > 512k or 16K, because it is a single pthread/io_uring/cpu core, which =
may be
> > > saturated easily, so most of these IOs may wait somewhere for cpu or =
whatever
> > > resource.
> >
> > Yes, that's exactly my point. Our ublk server only allocates enough
> > resources to handle 4K concurrent I/Os per thread. But since we don't
> > know which ublk devices or queues might receive the I/Os, we have to
> > fetch a queue depth of 4K on *every* ublk device queue. Perhaps the
> > batched approach you're working on will help here. But for now, the
> > total number of fetched ublk I/Os is an obstacle to adopting auto
> > buffer registration.
>
> oops, I forget the point that buffer index has to be provided beforehand,
> that is really one limit for your case with too many IOs in single uring
> context.
>
> The batched approach may not help too because the model is to issue comma=
nd
> beforehand for fetching new io command.
>
> > And waiting to allocate the buffer index until an
> > incoming I/O actually needs to register a buffer seems like a
> > straightforward way to avoid this obstacle.
>
> One way is to rely on bpf program to allocate & provide buffer index via
> struct_ops, which can be called exactly before registering & unregisterin=
g
> io buffer. The concept should be simple, but the whole implementation may
> take some effort(most are boiler plate).

A BPF program feels overly complex. Ideally the ublk server could
create a sparse buffer table and just let io_uring allocate an unused
buffer index for each incoming ublk I/O and return it in the io_uring
CQE. This is basically identical to IORING_FILE_INDEX_ALLOC, except
for registered buffers instead of registered files. It would require a
change in io_uring to support allocating a registered buffer index on
demand, but hopefully not too much work to leverage what already
exists for registered files. And the ublk server would of course have
to set UBLK_AUTO_BUF_REG_FALLBACK to gracefully handle buffer index
allocation failures if the client application issues more concurrent
I/Os than there are available buffer indices.

Best,
Caleb
