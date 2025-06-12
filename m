Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FF24A079
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739096; cv=none; b=raEhrwM91DQlCNcqpcPomfKIGscZsjAC+O6rHZi0aRixNpwzq/XK7SfSY767TFWb4YZ1r7XjZbVlFK4o7srv9L4cYUkL88OHUVSZjl0nvABM34VU51mSRp7Ak7RizFj0Qt8MWNzVE8Lg5unEE2LyPkDItDHsiTmOXhK2YXjUhOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739096; c=relaxed/simple;
	bh=0Lp3ik1KMLmawBurhau7omDlUEqf1UDOmdA8OEhmpBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgrn9XVv1+U5FHEkhdOYGX0xrl//2nF3fMI4zghngoepQjxO0iPtt81xvkld26HVvW+265xntFvkUnA7Jnp2X5Kf0UcYmaHJYsH1/PkPOQ3qe+e413T1hXxvftCIntSkBcKJMl+eW0s1FPBcq7u9mdC4SD4+6Me3S3xIrg0Lb98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Q+3sRdrv; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Q+3sRdrv"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31306794b30so139253a91.2
        for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 07:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749739094; x=1750343894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7h/dRpgrCP/Y0M3AzxYUurKuTtj5s6Z0w+k6AxA3QM=;
        b=Q+3sRdrvqxajcIGXokPhU6AHi+Uz7wG7ND3UxknPhftOC+IpbsggAfx3IASsXzOPkg
         7wDre3P9+IReVOukHQ+1s/wID0Dj2Pkgd9wO1MjHj7t4uq0WmJ/SXXhgfMDYRjNx/Rgd
         a9nCNlBlpsUJU9brJo5Phf5K0RqDYb0UczRZ3fq3pMCDC/z7QuRXtV4LjaK50lcwcZ7D
         OMjnqEq8flhb7yCnD36DB/YX9A34qF5xlp1xbCFwU2JyQ47DkoSpypC68HJSXvDYpIE5
         TUIHZy0gpS4Mu+lybyIui88kwR+8pC43IyyW9gDod0LW8XjKEqCqcPAEy3qm9xQfy6ES
         6Y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749739094; x=1750343894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7h/dRpgrCP/Y0M3AzxYUurKuTtj5s6Z0w+k6AxA3QM=;
        b=QUDsUqBAUs7EW6PsyPADMbKQuB3frpw4ecChkxzett7DGgbgG+SvrUTVDThgL+xHRN
         d8U119WbjdoFLS4CDS0acg+I6KLNfxhHueV23M25WJuOHbpgWObiJzf1BdLzEJluSrCW
         Q1sV73tzciPkbkq3/adXytDhq2ppQntuq+VmLB4nuzWeLX5Dblu2CvmDVrLaREpCMFAW
         SAFdlD4V+DZl4aNVXIenyynrgpV/Se1guzolM0gcXDuZWBR9VNiAyswSIlL+nVqKT8cP
         GsTUZAHZPQJvQGzBPvas3gfcpqFl964moJ8mpn3E3TKVojESZG6P/MhNhL0CvevHGCEZ
         Wpng==
X-Forwarded-Encrypted: i=1; AJvYcCUzq4DmeqUt4h9oaUTn1jzjbrRtfOthgtPHOXn6G7j17TSqsR/Dd9UwdFs1PEslYpom1cfSb+AU8UwmOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRyJMWxuWJ7vvl7ZK+wTXFNjcA/fmN9GopzfR6QTabvEYR5Cub
	a5KY8v4RfQlzmS+2UlfqWr3FMbirRPiUarKz86GBvDVJVUo91DFQMowSrwF6SnJfX4pxG1auYDV
	scnM6QFoeEvGzuLsbJ8YWxk6pJpJFRlDElJ3xVPDpDg==
X-Gm-Gg: ASbGncsnEVUr+ogrALRTOIU+BP7ZxlpP8+xUkfxfKf3b9UiKeM/rS54DAh75QEuUFzn
	tSs/I2m6R/ajFOwD71jY+BQDNydD8tl1ZiFEE9yQs826Ku4h/YT1VtlENAlhN72DUV0G9MgwBH0
	GvBdGTwoHj2B2GT1su95tf3uM4DfXznILLvbDGGF0ENkY=
X-Google-Smtp-Source: AGHT+IGegkjyJx45AvkGgA/1oRpj9OLJ/RDgZzmJYfGglARx7zFwkJcycDlcHt6+E2Smrv3fILkDwqQzevcq12lPlqk=
X-Received: by 2002:a17:90b:1b0e:b0:310:8d79:dfe4 with SMTP id
 98e67ed59e1d1-313af1f4a37mr3991296a91.4.1749739093635; Thu, 12 Jun 2025
 07:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609121426.1997271-1-ming.lei@redhat.com> <CADUfDZrHpGFKAEJhDqPNq_WMzWU5v9riN-i8V0dROo2tc=1DyA@mail.gmail.com>
 <aEeTO3t8qnBne9ef@fedora> <CADUfDZo-5ft7Krx==YLYbabPE+3Z1Yjrw2zcmn7VRqfx5XyFgg@mail.gmail.com>
 <aEpGh41uV3AJF-dG@fedora>
In-Reply-To: <aEpGh41uV3AJF-dG@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 12 Jun 2025 07:38:01 -0700
X-Gm-Features: AX0GCFunffGcW1DnHY2Ji5x59RtbBqrj6IH3AkXpFBjL5RgQStCTfeNzqmeo2ZI
Message-ID: <CADUfDZowptAiBxQ2w6NPJ4Bz0uCuJs3HsZ3pH1Q1J9wUmTXQ8g@mail.gmail.com>
Subject: Re: [PATCH] ublk: document auto buffer registration(UBLK_F_AUTO_BUF_REG)
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 8:16=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Wed, Jun 11, 2025 at 08:54:53AM -0700, Caleb Sander Mateos wrote:
> > On Mon, Jun 9, 2025 at 7:07=E2=80=AFPM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > On Mon, Jun 09, 2025 at 03:29:34PM -0700, Caleb Sander Mateos wrote:
> > > > On Mon, Jun 9, 2025 at 5:14=E2=80=AFAM Ming Lei <ming.lei@redhat.co=
m> wrote:
> > > > >
> > > > > Document recently merged feature auto buffer registration(UBLK_F_=
AUTO_BUF_REG).
> > > > >
> > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > >
> > > > Thanks, this is a nice explanation. Just a few suggestions.
> > > >
> > > > > ---
> > > > >  Documentation/block/ublk.rst | 67 ++++++++++++++++++++++++++++++=
++++++
> > > > >  1 file changed, 67 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/block/ublk.rst b/Documentation/block/u=
blk.rst
> > > > > index c368e1081b41..16ffca54eed4 100644
> > > > > --- a/Documentation/block/ublk.rst
> > > > > +++ b/Documentation/block/ublk.rst
> > > > > @@ -352,6 +352,73 @@ For reaching best IO performance, ublk serve=
r should align its segment
> > > > >  parameter of `struct ublk_param_segment` with backend for avoidi=
ng
> > > > >  unnecessary IO split, which usually hurts io_uring performance.
> > > > >
> > > > > +Auto Buffer Registration
> > > > > +------------------------
> > > > > +
> > > > > +The ``UBLK_F_AUTO_BUF_REG`` feature automatically handles buffer=
 registration
> > > > > +and unregistration for I/O requests, which simplifies the buffer=
 management
> > > > > +process and reduces overhead in the ublk server implementation.
> > > > > +
> > > > > +This is another feature flag for using zero copy, and it is comp=
atible with
> > > > > +``UBLK_F_SUPPORT_ZERO_COPY``.
> > > > > +
> > > > > +Feature Overview
> > > > > +~~~~~~~~~~~~~~~~
> > > > > +
> > > > > +This feature automatically registers request buffers to the io_u=
ring context
> > > > > +before delivering I/O commands to the ublk server and unregister=
s them when
> > > > > +completing I/O commands. This eliminates the need for manual buf=
fer
> > > > > +registration/unregistration via ``UBLK_IO_REGISTER_IO_BUF`` and
> > > > > +``UBLK_IO_UNREGISTER_IO_BUF`` commands, then IO handling in ublk=
 server
> > > > > +can avoid dependency on the two uring_cmd operations.
> > > > > +
> > > > > +This way not only simplifies ublk server implementation, but als=
o makes
> > > > > +concurrent IO handling becomes possible.
> > > >
> > > > I'm not sure what "concurrent IO handling" refers to. Any ublk serv=
er
> > > > can handle incoming I/O requests concurrently, regardless of what
> > > > features it has enabled. Do you mean it avoids the need for linked
> > > > io_uring requests to properly order buffer registration and
> > > > unregistration with the I/O operations using the registered buffer?
> > >
> > > Yes, if io_uring OPs depends on buffer registering & unregistering, t=
hese
> > > OPs can't be issued concurrently any more, that is one io_uring const=
raint.
> > >
> > > I will add the above words.
> > >
> > > >
> > > > > +
> > > > > +Usage Requirements
> > > > > +~~~~~~~~~~~~~~~~~~
> > > > > +
> > > > > +1. The ublk server must create a sparse buffer table on the same=
 ``io_ring_ctx``
> > > > > +   used for ``UBLK_IO_FETCH_REQ`` and ``UBLK_IO_COMMIT_AND_FETCH=
_REQ``.
> > > > > +
> > > > > +2. If uring_cmd is issued on a different ``io_ring_ctx``, manual=
 buffer
> > > > > +   unregistration is required.
> > > >
> > > > nit: don't think this needs to be a separate point, could be combin=
ed with (1).
> > >
> > > OK.
> > >
> > > >
> > > > > +
> > > > > +3. Buffer registration data must be passed via uring_cmd's ``sqe=
->addr`` with the
> > > > > +   following structure::
> > > >
> > > > nit: extra ":"
> > >
> > > In reStructuredText (reST), the double colon :: serves as a literal b=
lock marker to
> > > indicate preformatted text.
> > >
> > > >
> > > > > +
> > > > > +    struct ublk_auto_buf_reg {
> > > > > +        __u16 index;      /* Buffer index for registration */
> > > > > +        __u8 flags;       /* Registration flags */
> > > > > +        __u8 reserved0;   /* Reserved for future use */
> > > > > +        __u32 reserved1;  /* Reserved for future use */
> > > > > +    };
> > > >
> > > > Suggest using ublk_auto_buf_reg_to_sqe_addr()? Otherwise, it seems
> > > > ambiguous how this struct is "passed" in sqe->addr.
> > >
> > > OK
> > >
> > > >
> > > > > +
> > > > > +4. All reserved fields in ``ublk_auto_buf_reg`` must be zeroed.
> > > > > +
> > > > > +5. Optional flags can be passed via ``ublk_auto_buf_reg.flags``.
> > > > > +
> > > > > +Fallback Behavior
> > > > > +~~~~~~~~~~~~~~~~~
> > > > > +
> > > > > +When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
> > > > > +
> > > > > +1. If auto buffer registration fails:
> > > >
> > > > I would switch these. Both (1) and (2) refer to when auto buffer
> > > > registration fails. So I would expect something like:
> > > >
> > > > If auto buffer registration fails:
> > > >
> > > > 1. When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
> > > > ...
> > > > 2. If fallback is not enabled:
> > > > ...
> > > >
> > > > > +   - The uring_cmd is completed
> > > >
> > > > Maybe add "without registering the request buffer"?
> > > >
> > > > > +   - ``UBLK_IO_F_NEED_REG_BUF`` is set in ``ublksrv_io_desc.op_f=
lags``
> > > > > +   - The ublk server must manually register the buffer
> > > >
> > > > Only if it wants a registered buffer for the ublk request. Technica=
lly
> > > > the ublk server could decide to fall back on user-copy, for example=
.
> > >
> > > Good catch!
> > >
> > > >
> > > > > +
> > > > > +2. If fallback is not enabled:
> > > > > +   - The ublk I/O request fails silently
> > > >
> > > > "silently" is a bit ambiguous. It's certainly not silent to the
> > > > application submitting the ublk I/O. Maybe say that the ublk I/O
> > > > request fails and no uring_cmd is completed to the ublk server?
> > >
> > > Yes, but the document focus on ublk side, and the client is generic
> > > for every driver, so I guess it may be fine.
> > >
> > > >
> > > > > +
> > > > > +Limitations
> > > > > +~~~~~~~~~~~
> > > > > +
> > > > > +- Requires same ``io_ring_ctx`` for all operations
> > > >
> > > > Another limitation that prevents us from adopting the auto buffer
> > > > registration feature is the need to reserve a unique buffer table
> > > > index for every ublk tag on the io_ring_ctx. Since the io_ring_ctx
> > > > buffer table has a max size of 16K (could potentially be increased =
to
> > > > 64K), this limit is easily reached when there are a large number of
> > > > ublk devices or the ublk queue depth is large. I think we could rem=
ove
> > > > this limitation in the future by adding support for allocating buff=
er
> > > > indices on demand, analogous to IORING_FILE_INDEX_ALLOC.
> > >
> > > OK.
> > >
> > > But I guess it isn't big deal in reality since the task context shoul=
d
> > > be saturated easily with so big setting.
> >
> > I don't know about your "reality" but it's certainly a big deal for us =
:)
> > To reduce contention on the blk-mq queues for the application
> > submitting I/O to the ublk devices, we want a large number of queues
> > for each ublk device. But we also want a large queue depth for each
> > individual queue to avoid the async request allocation path in case
> > any one application thread issues a lot of concurrent I/O to a single
> > ublk device. And we have 128 ublk devices, which again all want large
> > queue depths in case the application sends a lot of I/O to a single
> > ublk device. The result is that concurrently each ublk server thread
> > fetches 512K ublk I/Os, which is significantly above the io_ring_ctx
> > buffer table limit.
>
> Yes, you can setup 512K I/Os in single task/io_uring context, but how man=
y
> can be actively handled during unit time? The number could be much less t=
han
> 512k or 16K, because it is a single pthread/io_uring/cpu core, which may =
be
> saturated easily, so most of these IOs may wait somewhere for cpu or what=
ever
> resource.

Yes, that's exactly my point. Our ublk server only allocates enough
resources to handle 4K concurrent I/Os per thread. But since we don't
know which ublk devices or queues might receive the I/Os, we have to
fetch a queue depth of 4K on *every* ublk device queue. Perhaps the
batched approach you're working on will help here. But for now, the
total number of fetched ublk I/Os is an obstacle to adopting auto
buffer registration. And waiting to allocate the buffer index until an
incoming I/O actually needs to register a buffer seems like a
straightforward way to avoid this obstacle.

Best,
Caleb
