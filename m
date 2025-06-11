Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D751DED53
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657307; cv=none; b=f8/kUYziLc8ob/wwoVPtvUnFmOI3TSAE/QlJ9wxmYdYTW/h8WKsD0z5iRzH0AU0njjPqc/9sbWJCpvYsfm8swAzdTvoWUCnyM26H7/DRzsL31A/Qdr7AVlFOIISJGzMV/cx5tCeBIEuGxvjk1sYO/1EsHWQV+mFiRnCGt+4YnJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657307; c=relaxed/simple;
	bh=pU9VofIPK7OjcLckxbPw+Fof6nLC+vCZeaau7Z9i+bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZU7572w3wKJ7BGhcTpf72FUKHHh85JR9rQnm//FdLZlP1Pvw5If/6S17KcAucNLNhjWwh/5F2xh856Jclk7Gyg/YmX1F6LKnDpax33zPM1GujhCaI1Jw8MJEFqTk2nxeSTgBoi/AlYOcqidFRXbp6PG1Wzwk8vbnYcz/4e9g0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=e6P9FDfj; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="e6P9FDfj"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31305ee3281so8550a91.0
        for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749657305; x=1750262105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmQLbsZRnLAKgBd1Yy/5Uk8mGH6+xeKLlsU+eSPvb3k=;
        b=e6P9FDfjxveAOQ+Gi+hU2VGWJsconZGYJCcL/DA7PC8XVl22a7Uhi55JiXAlNIdmKq
         lDGVt5ipSU9p9eM9RRGsk/2SlVwK6TOCnyeb2bLBMUolcESnoiuY9Ml0hc4WPEGzW721
         zmMhjHHltpmPNHvKwm9jAWHeUYJJSbFzEM038k1WD+M8Y7yGCUAH1f5+45n/s+ij7M81
         KM6cUB4GodsMCRi0EdL3tsiBCvsupvubVcQfYv2LYJkwU2UXM+wMA+juoy5X+XuedsWX
         L10Xwiegb80XDZmdrznE36C/W/UnlgG6kPocuXNR7o4Mr1O3qh/OvKV69y5/BmL4Hxfw
         K8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657305; x=1750262105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmQLbsZRnLAKgBd1Yy/5Uk8mGH6+xeKLlsU+eSPvb3k=;
        b=MdmKAcgJn+WjiMmD0LX1hRxsLFKcBimlPyuziTglZ2k3FvNUkDEKo/6C+NEO6nS11c
         NSJOC8IydTq+gBX+V8uhmyxZL6jM+bq1y01lDSlkEyT2xaWDC6RH70Qj6QvBkPBx7H8/
         vXpFT7DSSCFxF8xKYGS+9wYnlsY3l/pDaKPR3uBK2hCIOsbrmzSIrPx3XeH1/XuXk5M4
         RvhkhseGCHZKYyMlVCq4CrVsEOY33K7Ph2Hev+XmyfJjQdAYeZM7BpXULDBj8r0a0xSY
         VRjDc/8hhGXdQcJ4daAdpN4P8YTIFCMo/El/J1+4cMYEigdX6cqCNUxG9LHeWm+fKJGo
         Rsmg==
X-Forwarded-Encrypted: i=1; AJvYcCXWahT8UWq3iARuCep2maQrPyt/2PuNVF4z8e4BPXlo7fDXi7DnHi8eY6JKAx/cbHhFJfAp3ejvcl2xkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOwP4LuMpSGmbFT41YuHyXYEs0YOqazWC9P9awU9WCCNZ1iHc8
	YZyc78wOMI7w7I9orzRIuxJRQMqLc3hlTN66NVT3kBXALVtSQrpFbaF5Kla9eYmB6Xk8UXZ4TZO
	1cJUS+cx37N5QLPr9sEXM1uY3yBK0dvXe6/r/KuSr9Q==
X-Gm-Gg: ASbGnct9YI0Y8yvdo1AHpBuTpeRhl7m7dzv3o2+yN4mlEi725sOO/NChsSXZuy9X5cr
	CbdBygyKCHczfVGvsiD28AuZX5fmV6GL9gGX5ADe6t8QUTMz0v8hmvDnhzcK5I4CQf3qV1+dMPY
	bHLmXcNfOX0Ewhwu8x5Ig+dW+dJvxQtxsBFWd4Sxmi19c=
X-Google-Smtp-Source: AGHT+IFMsAZ2Waw6o5V8bBxuE3gxr1VuKEPq8KLJUCE4X9XdqzMaoGFmm4g7Fsm2yeJDH3DQTSCcvqL9gJqPydYsZvk=
X-Received: by 2002:a17:90b:6cb:b0:311:e9a6:332e with SMTP id
 98e67ed59e1d1-313aee5028cmr2311894a91.0.1749657304886; Wed, 11 Jun 2025
 08:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609121426.1997271-1-ming.lei@redhat.com> <CADUfDZrHpGFKAEJhDqPNq_WMzWU5v9riN-i8V0dROo2tc=1DyA@mail.gmail.com>
 <aEeTO3t8qnBne9ef@fedora>
In-Reply-To: <aEeTO3t8qnBne9ef@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 11 Jun 2025 08:54:53 -0700
X-Gm-Features: AX0GCFu1PKCGaQmpBewTVVjtfW5Hc_9mbY6PmmPy1RiXVT26Yz5o2nLsMRs0oao
Message-ID: <CADUfDZo-5ft7Krx==YLYbabPE+3Z1Yjrw2zcmn7VRqfx5XyFgg@mail.gmail.com>
Subject: Re: [PATCH] ublk: document auto buffer registration(UBLK_F_AUTO_BUF_REG)
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 7:07=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Mon, Jun 09, 2025 at 03:29:34PM -0700, Caleb Sander Mateos wrote:
> > On Mon, Jun 9, 2025 at 5:14=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > Document recently merged feature auto buffer registration(UBLK_F_AUTO=
_BUF_REG).
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >
> > Thanks, this is a nice explanation. Just a few suggestions.
> >
> > > ---
> > >  Documentation/block/ublk.rst | 67 ++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 67 insertions(+)
> > >
> > > diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.=
rst
> > > index c368e1081b41..16ffca54eed4 100644
> > > --- a/Documentation/block/ublk.rst
> > > +++ b/Documentation/block/ublk.rst
> > > @@ -352,6 +352,73 @@ For reaching best IO performance, ublk server sh=
ould align its segment
> > >  parameter of `struct ublk_param_segment` with backend for avoiding
> > >  unnecessary IO split, which usually hurts io_uring performance.
> > >
> > > +Auto Buffer Registration
> > > +------------------------
> > > +
> > > +The ``UBLK_F_AUTO_BUF_REG`` feature automatically handles buffer reg=
istration
> > > +and unregistration for I/O requests, which simplifies the buffer man=
agement
> > > +process and reduces overhead in the ublk server implementation.
> > > +
> > > +This is another feature flag for using zero copy, and it is compatib=
le with
> > > +``UBLK_F_SUPPORT_ZERO_COPY``.
> > > +
> > > +Feature Overview
> > > +~~~~~~~~~~~~~~~~
> > > +
> > > +This feature automatically registers request buffers to the io_uring=
 context
> > > +before delivering I/O commands to the ublk server and unregisters th=
em when
> > > +completing I/O commands. This eliminates the need for manual buffer
> > > +registration/unregistration via ``UBLK_IO_REGISTER_IO_BUF`` and
> > > +``UBLK_IO_UNREGISTER_IO_BUF`` commands, then IO handling in ublk ser=
ver
> > > +can avoid dependency on the two uring_cmd operations.
> > > +
> > > +This way not only simplifies ublk server implementation, but also ma=
kes
> > > +concurrent IO handling becomes possible.
> >
> > I'm not sure what "concurrent IO handling" refers to. Any ublk server
> > can handle incoming I/O requests concurrently, regardless of what
> > features it has enabled. Do you mean it avoids the need for linked
> > io_uring requests to properly order buffer registration and
> > unregistration with the I/O operations using the registered buffer?
>
> Yes, if io_uring OPs depends on buffer registering & unregistering, these
> OPs can't be issued concurrently any more, that is one io_uring constrain=
t.
>
> I will add the above words.
>
> >
> > > +
> > > +Usage Requirements
> > > +~~~~~~~~~~~~~~~~~~
> > > +
> > > +1. The ublk server must create a sparse buffer table on the same ``i=
o_ring_ctx``
> > > +   used for ``UBLK_IO_FETCH_REQ`` and ``UBLK_IO_COMMIT_AND_FETCH_REQ=
``.
> > > +
> > > +2. If uring_cmd is issued on a different ``io_ring_ctx``, manual buf=
fer
> > > +   unregistration is required.
> >
> > nit: don't think this needs to be a separate point, could be combined w=
ith (1).
>
> OK.
>
> >
> > > +
> > > +3. Buffer registration data must be passed via uring_cmd's ``sqe->ad=
dr`` with the
> > > +   following structure::
> >
> > nit: extra ":"
>
> In reStructuredText (reST), the double colon :: serves as a literal block=
 marker to
> indicate preformatted text.
>
> >
> > > +
> > > +    struct ublk_auto_buf_reg {
> > > +        __u16 index;      /* Buffer index for registration */
> > > +        __u8 flags;       /* Registration flags */
> > > +        __u8 reserved0;   /* Reserved for future use */
> > > +        __u32 reserved1;  /* Reserved for future use */
> > > +    };
> >
> > Suggest using ublk_auto_buf_reg_to_sqe_addr()? Otherwise, it seems
> > ambiguous how this struct is "passed" in sqe->addr.
>
> OK
>
> >
> > > +
> > > +4. All reserved fields in ``ublk_auto_buf_reg`` must be zeroed.
> > > +
> > > +5. Optional flags can be passed via ``ublk_auto_buf_reg.flags``.
> > > +
> > > +Fallback Behavior
> > > +~~~~~~~~~~~~~~~~~
> > > +
> > > +When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
> > > +
> > > +1. If auto buffer registration fails:
> >
> > I would switch these. Both (1) and (2) refer to when auto buffer
> > registration fails. So I would expect something like:
> >
> > If auto buffer registration fails:
> >
> > 1. When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
> > ...
> > 2. If fallback is not enabled:
> > ...
> >
> > > +   - The uring_cmd is completed
> >
> > Maybe add "without registering the request buffer"?
> >
> > > +   - ``UBLK_IO_F_NEED_REG_BUF`` is set in ``ublksrv_io_desc.op_flags=
``
> > > +   - The ublk server must manually register the buffer
> >
> > Only if it wants a registered buffer for the ublk request. Technically
> > the ublk server could decide to fall back on user-copy, for example.
>
> Good catch!
>
> >
> > > +
> > > +2. If fallback is not enabled:
> > > +   - The ublk I/O request fails silently
> >
> > "silently" is a bit ambiguous. It's certainly not silent to the
> > application submitting the ublk I/O. Maybe say that the ublk I/O
> > request fails and no uring_cmd is completed to the ublk server?
>
> Yes, but the document focus on ublk side, and the client is generic
> for every driver, so I guess it may be fine.
>
> >
> > > +
> > > +Limitations
> > > +~~~~~~~~~~~
> > > +
> > > +- Requires same ``io_ring_ctx`` for all operations
> >
> > Another limitation that prevents us from adopting the auto buffer
> > registration feature is the need to reserve a unique buffer table
> > index for every ublk tag on the io_ring_ctx. Since the io_ring_ctx
> > buffer table has a max size of 16K (could potentially be increased to
> > 64K), this limit is easily reached when there are a large number of
> > ublk devices or the ublk queue depth is large. I think we could remove
> > this limitation in the future by adding support for allocating buffer
> > indices on demand, analogous to IORING_FILE_INDEX_ALLOC.
>
> OK.
>
> But I guess it isn't big deal in reality since the task context should
> be saturated easily with so big setting.

I don't know about your "reality" but it's certainly a big deal for us :)
To reduce contention on the blk-mq queues for the application
submitting I/O to the ublk devices, we want a large number of queues
for each ublk device. But we also want a large queue depth for each
individual queue to avoid the async request allocation path in case
any one application thread issues a lot of concurrent I/O to a single
ublk device. And we have 128 ublk devices, which again all want large
queue depths in case the application sends a lot of I/O to a single
ublk device. The result is that concurrently each ublk server thread
fetches 512K ublk I/Os, which is significantly above the io_ring_ctx
buffer table limit.

Best,
Caleb
