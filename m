Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A8E1A315D
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749777502; cv=none; b=q5NjTsyW6iwJ0fbcbkCPjsWEIMsCqsL83LPBIN8tgutr1B1nROsDOlTWYJGeKbulUNwAurkgIolrIZwZEbeG6YingXMqjh7oLSpIPWJlk1qoo874Kgs01I9c5q2iUEYAcg1XNTOXxusRa9jNuIGkP+A5d3eLfoSIAF4L9Kv+R1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749777502; c=relaxed/simple;
	bh=X8v5Ry6YpBspb01fSV9N31SILxbVMmdnsttEpRPZSdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2p15DStDJCJnlSnKicAckHU9wd0hEFaEtBKf9eI716aOms54lRMUo8qMD5yBtenozxTb9gaPxM46tKUfKYGTkBFy6jIkLBpeZ9T+Njz4dPg7YziaZoMprB/kk7sp6W+nEKpyUTOZu1+x2hrmkdVkZJ6d2zNQMVevyntOwVK06o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCudplhe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCudplhe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749777499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T1Nh9t0HjVQwbmRbQ5Ef34Qj+ayrajdlULwufviNPfs=;
	b=GCudplhe9uayVpTPKrMpextam7sL5uCKxpd00eB1XVYCb82KCdU5/CbZ+LHPeLnPSmHDLH
	b1jBgBWsgs/SIR3tKSstKUbQQipHlyqLwOJwRbm/v0qzSOOOkagdcH7/T7Gi+0+yxIrWNc
	pPj058sD2sGWNkKej9J4Nz2EYheNxSU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-Ni3XoaYeOSOYliEupLfLDQ-1; Thu,
 12 Jun 2025 21:18:16 -0400
X-MC-Unique: Ni3XoaYeOSOYliEupLfLDQ-1
X-Mimecast-MFC-AGG-ID: Ni3XoaYeOSOYliEupLfLDQ_1749777495
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 000C1180135B;
	Fri, 13 Jun 2025 01:18:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.73])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEBD2180035C;
	Fri, 13 Jun 2025 01:18:11 +0000 (UTC)
Date: Fri, 13 Jun 2025 09:18:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH] ublk: document auto buffer
 registration(UBLK_F_AUTO_BUF_REG)
Message-ID: <aEt8Tu1mgjQerFuy@fedora>
References: <20250609121426.1997271-1-ming.lei@redhat.com>
 <CADUfDZrHpGFKAEJhDqPNq_WMzWU5v9riN-i8V0dROo2tc=1DyA@mail.gmail.com>
 <aEeTO3t8qnBne9ef@fedora>
 <CADUfDZo-5ft7Krx==YLYbabPE+3Z1Yjrw2zcmn7VRqfx5XyFgg@mail.gmail.com>
 <aEpGh41uV3AJF-dG@fedora>
 <CADUfDZowptAiBxQ2w6NPJ4Bz0uCuJs3HsZ3pH1Q1J9wUmTXQ8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZowptAiBxQ2w6NPJ4Bz0uCuJs3HsZ3pH1Q1J9wUmTXQ8g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Jun 12, 2025 at 07:38:01AM -0700, Caleb Sander Mateos wrote:
> On Wed, Jun 11, 2025 at 8:16 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Wed, Jun 11, 2025 at 08:54:53AM -0700, Caleb Sander Mateos wrote:
> > > On Mon, Jun 9, 2025 at 7:07 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Mon, Jun 09, 2025 at 03:29:34PM -0700, Caleb Sander Mateos wrote:
> > > > > On Mon, Jun 9, 2025 at 5:14 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > >
> > > > > > Document recently merged feature auto buffer registration(UBLK_F_AUTO_BUF_REG).
> > > > > >
> > > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > >
> > > > > Thanks, this is a nice explanation. Just a few suggestions.
> > > > >
> > > > > > ---
> > > > > >  Documentation/block/ublk.rst | 67 ++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 67 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> > > > > > index c368e1081b41..16ffca54eed4 100644
> > > > > > --- a/Documentation/block/ublk.rst
> > > > > > +++ b/Documentation/block/ublk.rst
> > > > > > @@ -352,6 +352,73 @@ For reaching best IO performance, ublk server should align its segment
> > > > > >  parameter of `struct ublk_param_segment` with backend for avoiding
> > > > > >  unnecessary IO split, which usually hurts io_uring performance.
> > > > > >
> > > > > > +Auto Buffer Registration
> > > > > > +------------------------
> > > > > > +
> > > > > > +The ``UBLK_F_AUTO_BUF_REG`` feature automatically handles buffer registration
> > > > > > +and unregistration for I/O requests, which simplifies the buffer management
> > > > > > +process and reduces overhead in the ublk server implementation.
> > > > > > +
> > > > > > +This is another feature flag for using zero copy, and it is compatible with
> > > > > > +``UBLK_F_SUPPORT_ZERO_COPY``.
> > > > > > +
> > > > > > +Feature Overview
> > > > > > +~~~~~~~~~~~~~~~~
> > > > > > +
> > > > > > +This feature automatically registers request buffers to the io_uring context
> > > > > > +before delivering I/O commands to the ublk server and unregisters them when
> > > > > > +completing I/O commands. This eliminates the need for manual buffer
> > > > > > +registration/unregistration via ``UBLK_IO_REGISTER_IO_BUF`` and
> > > > > > +``UBLK_IO_UNREGISTER_IO_BUF`` commands, then IO handling in ublk server
> > > > > > +can avoid dependency on the two uring_cmd operations.
> > > > > > +
> > > > > > +This way not only simplifies ublk server implementation, but also makes
> > > > > > +concurrent IO handling becomes possible.
> > > > >
> > > > > I'm not sure what "concurrent IO handling" refers to. Any ublk server
> > > > > can handle incoming I/O requests concurrently, regardless of what
> > > > > features it has enabled. Do you mean it avoids the need for linked
> > > > > io_uring requests to properly order buffer registration and
> > > > > unregistration with the I/O operations using the registered buffer?
> > > >
> > > > Yes, if io_uring OPs depends on buffer registering & unregistering, these
> > > > OPs can't be issued concurrently any more, that is one io_uring constraint.
> > > >
> > > > I will add the above words.
> > > >
> > > > >
> > > > > > +
> > > > > > +Usage Requirements
> > > > > > +~~~~~~~~~~~~~~~~~~
> > > > > > +
> > > > > > +1. The ublk server must create a sparse buffer table on the same ``io_ring_ctx``
> > > > > > +   used for ``UBLK_IO_FETCH_REQ`` and ``UBLK_IO_COMMIT_AND_FETCH_REQ``.
> > > > > > +
> > > > > > +2. If uring_cmd is issued on a different ``io_ring_ctx``, manual buffer
> > > > > > +   unregistration is required.
> > > > >
> > > > > nit: don't think this needs to be a separate point, could be combined with (1).
> > > >
> > > > OK.
> > > >
> > > > >
> > > > > > +
> > > > > > +3. Buffer registration data must be passed via uring_cmd's ``sqe->addr`` with the
> > > > > > +   following structure::
> > > > >
> > > > > nit: extra ":"
> > > >
> > > > In reStructuredText (reST), the double colon :: serves as a literal block marker to
> > > > indicate preformatted text.
> > > >
> > > > >
> > > > > > +
> > > > > > +    struct ublk_auto_buf_reg {
> > > > > > +        __u16 index;      /* Buffer index for registration */
> > > > > > +        __u8 flags;       /* Registration flags */
> > > > > > +        __u8 reserved0;   /* Reserved for future use */
> > > > > > +        __u32 reserved1;  /* Reserved for future use */
> > > > > > +    };
> > > > >
> > > > > Suggest using ublk_auto_buf_reg_to_sqe_addr()? Otherwise, it seems
> > > > > ambiguous how this struct is "passed" in sqe->addr.
> > > >
> > > > OK
> > > >
> > > > >
> > > > > > +
> > > > > > +4. All reserved fields in ``ublk_auto_buf_reg`` must be zeroed.
> > > > > > +
> > > > > > +5. Optional flags can be passed via ``ublk_auto_buf_reg.flags``.
> > > > > > +
> > > > > > +Fallback Behavior
> > > > > > +~~~~~~~~~~~~~~~~~
> > > > > > +
> > > > > > +When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
> > > > > > +
> > > > > > +1. If auto buffer registration fails:
> > > > >
> > > > > I would switch these. Both (1) and (2) refer to when auto buffer
> > > > > registration fails. So I would expect something like:
> > > > >
> > > > > If auto buffer registration fails:
> > > > >
> > > > > 1. When ``UBLK_AUTO_BUF_REG_FALLBACK`` is enabled:
> > > > > ...
> > > > > 2. If fallback is not enabled:
> > > > > ...
> > > > >
> > > > > > +   - The uring_cmd is completed
> > > > >
> > > > > Maybe add "without registering the request buffer"?
> > > > >
> > > > > > +   - ``UBLK_IO_F_NEED_REG_BUF`` is set in ``ublksrv_io_desc.op_flags``
> > > > > > +   - The ublk server must manually register the buffer
> > > > >
> > > > > Only if it wants a registered buffer for the ublk request. Technically
> > > > > the ublk server could decide to fall back on user-copy, for example.
> > > >
> > > > Good catch!
> > > >
> > > > >
> > > > > > +
> > > > > > +2. If fallback is not enabled:
> > > > > > +   - The ublk I/O request fails silently
> > > > >
> > > > > "silently" is a bit ambiguous. It's certainly not silent to the
> > > > > application submitting the ublk I/O. Maybe say that the ublk I/O
> > > > > request fails and no uring_cmd is completed to the ublk server?
> > > >
> > > > Yes, but the document focus on ublk side, and the client is generic
> > > > for every driver, so I guess it may be fine.
> > > >
> > > > >
> > > > > > +
> > > > > > +Limitations
> > > > > > +~~~~~~~~~~~
> > > > > > +
> > > > > > +- Requires same ``io_ring_ctx`` for all operations
> > > > >
> > > > > Another limitation that prevents us from adopting the auto buffer
> > > > > registration feature is the need to reserve a unique buffer table
> > > > > index for every ublk tag on the io_ring_ctx. Since the io_ring_ctx
> > > > > buffer table has a max size of 16K (could potentially be increased to
> > > > > 64K), this limit is easily reached when there are a large number of
> > > > > ublk devices or the ublk queue depth is large. I think we could remove
> > > > > this limitation in the future by adding support for allocating buffer
> > > > > indices on demand, analogous to IORING_FILE_INDEX_ALLOC.
> > > >
> > > > OK.
> > > >
> > > > But I guess it isn't big deal in reality since the task context should
> > > > be saturated easily with so big setting.
> > >
> > > I don't know about your "reality" but it's certainly a big deal for us :)
> > > To reduce contention on the blk-mq queues for the application
> > > submitting I/O to the ublk devices, we want a large number of queues
> > > for each ublk device. But we also want a large queue depth for each
> > > individual queue to avoid the async request allocation path in case
> > > any one application thread issues a lot of concurrent I/O to a single
> > > ublk device. And we have 128 ublk devices, which again all want large
> > > queue depths in case the application sends a lot of I/O to a single
> > > ublk device. The result is that concurrently each ublk server thread
> > > fetches 512K ublk I/Os, which is significantly above the io_ring_ctx
> > > buffer table limit.
> >
> > Yes, you can setup 512K I/Os in single task/io_uring context, but how many
> > can be actively handled during unit time? The number could be much less than
> > 512k or 16K, because it is a single pthread/io_uring/cpu core, which may be
> > saturated easily, so most of these IOs may wait somewhere for cpu or whatever
> > resource.
> 
> Yes, that's exactly my point. Our ublk server only allocates enough
> resources to handle 4K concurrent I/Os per thread. But since we don't
> know which ublk devices or queues might receive the I/Os, we have to
> fetch a queue depth of 4K on *every* ublk device queue. Perhaps the
> batched approach you're working on will help here. But for now, the
> total number of fetched ublk I/Os is an obstacle to adopting auto
> buffer registration.

oops, I forget the point that buffer index has to be provided beforehand,
that is really one limit for your case with too many IOs in single uring
context.

The batched approach may not help too because the model is to issue command
beforehand for fetching new io command.

> And waiting to allocate the buffer index until an
> incoming I/O actually needs to register a buffer seems like a
> straightforward way to avoid this obstacle.

One way is to rely on bpf program to allocate & provide buffer index via
struct_ops, which can be called exactly before registering & unregistering
io buffer. The concept should be simple, but the whole implementation may
take some effort(most are boiler plate).

thanks,
Ming

