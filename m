Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061244A11
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749698200; cv=none; b=BZoMLQ1LqOtEgUJ2JhyHe8W+j1V9cNMR2qgBt+FJtYZeGVwqbKfUDT1JvOzqJ2+2S224jqQBQ2v3NbCsEklZDJYkQxFgZ0lyPRe/Rz8vz3VXso64KJq0zPL2eHxhcnkGQlitvNNse2uZpJVmjwv9EDhb+mTdB1D7sWLqq+rnTl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749698200; c=relaxed/simple;
	bh=O6YMSS+BC9emiQhoNQe/CBW89b2r5r3b1yGttczaS70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiHBAleDIJ8p/3X5jN5/N2TuQcz6vSsrwriU7ddiZ9bIBDtnigyZY9W9jrCnAKzT1rG4ttK1mBQEyMNfvCBXgNNIpCxXUSYXbpQvqBzEGeyWZbstjvNPxFu3wZEvvSJ/2zonH1TkQgcHAxTqVfkaEHTn/Qomx0JsT0iVGbaSxBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0Ya999B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0Ya999B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749698196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xADfTy0SIBAHn67YyeojEKOuM6wfSoiwVdGOv86vpeE=;
	b=M0Ya999BNywVnz3movbZYeSpOMJslSBRoTSkpsolEcxcSUkIAqDeqGLbLkZEpVej1x0VOn
	oKRljr83lyrhKhrvAmrsDXbd1A5+HplCrYk22QbRW9ouCv7EcPHAXM9n8NnjGUHj/guIS4
	UpIsLJmTx3P7Z2NXShs6bzPQv0yKmfU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-60Wd21jVM9qEaVX6pRhWGQ-1; Wed,
 11 Jun 2025 23:16:33 -0400
X-MC-Unique: 60Wd21jVM9qEaVX6pRhWGQ-1
X-Mimecast-MFC-AGG-ID: 60Wd21jVM9qEaVX6pRhWGQ_1749698192
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D89091956095;
	Thu, 12 Jun 2025 03:16:31 +0000 (UTC)
Received: from fedora (unknown [10.72.116.109])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61E6C30002C3;
	Thu, 12 Jun 2025 03:16:27 +0000 (UTC)
Date: Thu, 12 Jun 2025 11:16:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH] ublk: document auto buffer
 registration(UBLK_F_AUTO_BUF_REG)
Message-ID: <aEpGh41uV3AJF-dG@fedora>
References: <20250609121426.1997271-1-ming.lei@redhat.com>
 <CADUfDZrHpGFKAEJhDqPNq_WMzWU5v9riN-i8V0dROo2tc=1DyA@mail.gmail.com>
 <aEeTO3t8qnBne9ef@fedora>
 <CADUfDZo-5ft7Krx==YLYbabPE+3Z1Yjrw2zcmn7VRqfx5XyFgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZo-5ft7Krx==YLYbabPE+3Z1Yjrw2zcmn7VRqfx5XyFgg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Jun 11, 2025 at 08:54:53AM -0700, Caleb Sander Mateos wrote:
> On Mon, Jun 9, 2025 at 7:07 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Mon, Jun 09, 2025 at 03:29:34PM -0700, Caleb Sander Mateos wrote:
> > > On Mon, Jun 9, 2025 at 5:14 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > Document recently merged feature auto buffer registration(UBLK_F_AUTO_BUF_REG).
> > > >
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > >
> > > Thanks, this is a nice explanation. Just a few suggestions.
> > >
> > > > ---
> > > >  Documentation/block/ublk.rst | 67 ++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 67 insertions(+)
> > > >
> > > > diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> > > > index c368e1081b41..16ffca54eed4 100644
> > > > --- a/Documentation/block/ublk.rst
> > > > +++ b/Documentation/block/ublk.rst
> > > > @@ -352,6 +352,73 @@ For reaching best IO performance, ublk server should align its segment
> > > >  parameter of `struct ublk_param_segment` with backend for avoiding
> > > >  unnecessary IO split, which usually hurts io_uring performance.
> > > >
> > > > +Auto Buffer Registration
> > > > +------------------------
> > > > +
> > > > +The ``UBLK_F_AUTO_BUF_REG`` feature automatically handles buffer registration
> > > > +and unregistration for I/O requests, which simplifies the buffer management
> > > > +process and reduces overhead in the ublk server implementation.
> > > > +
> > > > +This is another feature flag for using zero copy, and it is compatible with
> > > > +``UBLK_F_SUPPORT_ZERO_COPY``.
> > > > +
> > > > +Feature Overview
> > > > +~~~~~~~~~~~~~~~~
> > > > +
> > > > +This feature automatically registers request buffers to the io_uring context
> > > > +before delivering I/O commands to the ublk server and unregisters them when
> > > > +completing I/O commands. This eliminates the need for manual buffer
> > > > +registration/unregistration via ``UBLK_IO_REGISTER_IO_BUF`` and
> > > > +``UBLK_IO_UNREGISTER_IO_BUF`` commands, then IO handling in ublk server
> > > > +can avoid dependency on the two uring_cmd operations.
> > > > +
> > > > +This way not only simplifies ublk server implementation, but also makes
> > > > +concurrent IO handling becomes possible.
> > >
> > > I'm not sure what "concurrent IO handling" refers to. Any ublk server
> > > can handle incoming I/O requests concurrently, regardless of what
> > > features it has enabled. Do you mean it avoids the need for linked
> > > io_uring requests to properly order buffer registration and
> > > unregistration with the I/O operations using the registered buffer?
> >
> > Yes, if io_uring OPs depends on buffer registering & unregistering, these
> > OPs can't be issued concurrently any more, that is one io_uring constraint.
> >
> > I will add the above words.
> >
> > >
> > > > +
> > > > +Usage Requirements
> > > > +~~~~~~~~~~~~~~~~~~
> > > > +
> > > > +1. The ublk server must create a sparse buffer table on the same ``io_ring_ctx``
> > > > +   used for ``UBLK_IO_FETCH_REQ`` and ``UBLK_IO_COMMIT_AND_FETCH_REQ``.
> > > > +
> > > > +2. If uring_cmd is issued on a different ``io_ring_ctx``, manual buffer
> > > > +   unregistration is required.
> > >
> > > nit: don't think this needs to be a separate point, could be combined with (1).
> >
> > OK.
> >
> > >
> > > > +
> > > > +3. Buffer registration data must be passed via uring_cmd's ``sqe->addr`` with the
> > > > +   following structure::
> > >
> > > nit: extra ":"
> >
> > In reStructuredText (reST), the double colon :: serves as a literal block marker to
> > indicate preformatted text.
> >
> > >
> > > > +
> > > > +    struct ublk_auto_buf_reg {
> > > > +        __u16 index;      /* Buffer index for registration */
> > > > +        __u8 flags;       /* Registration flags */
> > > > +        __u8 reserved0;   /* Reserved for future use */
> > > > +        __u32 reserved1;  /* Reserved for future use */
> > > > +    };
> > >
> > > Suggest using ublk_auto_buf_reg_to_sqe_addr()? Otherwise, it seems
> > > ambiguous how this struct is "passed" in sqe->addr.
> >
> > OK
> >
> > >
> > > > +
> > > > +4. All reserved fields in ``ublk_auto_buf_reg`` must be zeroed.
> > > > +
> > > > +5. Optional flags can be passed via ``ublk_auto_buf_reg.flags``.
> > > > +
> > > > +Fallback Behavior
> > > > +~~~~~~~~~~~~~~~~~
> > > > +
> > > > +When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
> > > > +
> > > > +1. If auto buffer registration fails:
> > >
> > > I would switch these. Both (1) and (2) refer to when auto buffer
> > > registration fails. So I would expect something like:
> > >
> > > If auto buffer registration fails:
> > >
> > > 1. When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
> > > ...
> > > 2. If fallback is not enabled:
> > > ...
> > >
> > > > +   - The uring_cmd is completed
> > >
> > > Maybe add "without registering the request buffer"?
> > >
> > > > +   - ``UBLK_IO_F_NEED_REG_BUF`` is set in ``ublksrv_io_desc.op_flags``
> > > > +   - The ublk server must manually register the buffer
> > >
> > > Only if it wants a registered buffer for the ublk request. Technically
> > > the ublk server could decide to fall back on user-copy, for example.
> >
> > Good catch!
> >
> > >
> > > > +
> > > > +2. If fallback is not enabled:
> > > > +   - The ublk I/O request fails silently
> > >
> > > "silently" is a bit ambiguous. It's certainly not silent to the
> > > application submitting the ublk I/O. Maybe say that the ublk I/O
> > > request fails and no uring_cmd is completed to the ublk server?
> >
> > Yes, but the document focus on ublk side, and the client is generic
> > for every driver, so I guess it may be fine.
> >
> > >
> > > > +
> > > > +Limitations
> > > > +~~~~~~~~~~~
> > > > +
> > > > +- Requires same ``io_ring_ctx`` for all operations
> > >
> > > Another limitation that prevents us from adopting the auto buffer
> > > registration feature is the need to reserve a unique buffer table
> > > index for every ublk tag on the io_ring_ctx. Since the io_ring_ctx
> > > buffer table has a max size of 16K (could potentially be increased to
> > > 64K), this limit is easily reached when there are a large number of
> > > ublk devices or the ublk queue depth is large. I think we could remove
> > > this limitation in the future by adding support for allocating buffer
> > > indices on demand, analogous to IORING_FILE_INDEX_ALLOC.
> >
> > OK.
> >
> > But I guess it isn't big deal in reality since the task context should
> > be saturated easily with so big setting.
> 
> I don't know about your "reality" but it's certainly a big deal for us :)
> To reduce contention on the blk-mq queues for the application
> submitting I/O to the ublk devices, we want a large number of queues
> for each ublk device. But we also want a large queue depth for each
> individual queue to avoid the async request allocation path in case
> any one application thread issues a lot of concurrent I/O to a single
> ublk device. And we have 128 ublk devices, which again all want large
> queue depths in case the application sends a lot of I/O to a single
> ublk device. The result is that concurrently each ublk server thread
> fetches 512K ublk I/Os, which is significantly above the io_ring_ctx
> buffer table limit.

Yes, you can setup 512K I/Os in single task/io_uring context, but how many
can be actively handled during unit time? The number could be much less than
512k or 16K, because it is a single pthread/io_uring/cpu core, which may be
saturated easily, so most of these IOs may wait somewhere for cpu or whatever
resource.

So when you have one nice per-task buf-index allocation algorithm, it may not
be one issue given 16K is big enough.


Thanks,
Ming

