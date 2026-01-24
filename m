Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6C4A35
	for <linux-block@vger.kernel.org>; Sat, 24 Jan 2026 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769218241; cv=none; b=SwFuhJcB6IrCabgl6HbHXlM9eFF7N5olexFDi9RNwyd67+eaRreCZSH5HBDO00N1DiJT0FytcelrTODgPWp0B2nH7ARhnq+KtDQMapbuqr+g2HOV8AlQzcSIu4rtWDe9nDKMxrNJR+z13+de9AxR1wjy6zEObdNdOHfMti7Fh1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769218241; c=relaxed/simple;
	bh=X8caK4645WVB2mqUd2MGQcaOmzlolK3ftZJwGgc/ZCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t40xk7u7KPhINaUdBsuYV8toaOaq3hF2n0p1BH4J/UeQfUN74QSV/HoFlNvc/Qe14Q44nzG3eO/ukBULJGWvsSpfVenBn29InlD2DBlKg+yh9l19w88wE0KSp8mpHzWJMaaLFu19Ateap2hNHzJCezak0IU6YloLpsThjR2dSgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMhmLCEF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMhmLCEF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769218239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wkyky0Yh3h2WXVz4HXYnbhvfsNXstogpwvjH+5Vu8hc=;
	b=jMhmLCEFgcfe+9ym8M+vZYqrTC4akytNSbbI/nn5fFWchLVZDekddJjaw4Olk3DMF0qtTp
	xOSm97YckJnptQjbmnWlqZZhvuVWPpAvsXpCG4rWLZjZ4Y1WEX8qjCDxOKn/fyIa1jRhLi
	+yFSc4Giy3YXc2RUN8ZoezkLK7RIF9Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-Zo3KpfB-MwSKuGoO7jdhkw-1; Fri,
 23 Jan 2026 20:30:37 -0500
X-MC-Unique: Zo3KpfB-MwSKuGoO7jdhkw-1
X-Mimecast-MFC-AGG-ID: Zo3KpfB-MwSKuGoO7jdhkw_1769218236
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 788E218005B0;
	Sat, 24 Jan 2026 01:30:36 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73D7D1800577;
	Sat, 24 Jan 2026 01:30:33 +0000 (UTC)
Date: Sat, 24 Jan 2026 09:30:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 2/2] ublk: document IO reference counting design
Message-ID: <aXQgtDq2ffpAwnUW@fedora>
References: <20260123135205.2202474-1-ming.lei@redhat.com>
 <20260123135205.2202474-3-ming.lei@redhat.com>
 <CADUfDZog7YhUz0RXfyR=guO3-aKo_FnSF6cSVY1uVv0=m-xB1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZog7YhUz0RXfyR=guO3-aKo_FnSF6cSVY1uVv0=m-xB1A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Jan 23, 2026 at 12:37:07PM -0800, Caleb Sander Mateos wrote:
> On Fri, Jan 23, 2026 at 5:53 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add comprehensive documentation for ublk's split reference counting
> > model (io->ref + io->task_registered_buffers) above ublk_init_req_ref()
> > given this model isn't very straightforward.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 64 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 7981decd1cee..91218b78e711 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -985,6 +985,70 @@ static inline bool ublk_dev_need_req_ref(const struct ublk_device *ub)
> >                ublk_dev_support_auto_buf_reg(ub);
> >  }
> >
> > +/*
> > + * ublk IO Reference Counting Design
> > + * ==================================
> > + *
> > + * For user-copy and zero-copy modes, ublk uses a split reference model with
> > + * two counters that together track IO lifetime:
> > + *
> > + *   - io->ref: refcount for off-task buffer registrations and user-copy ops
> > + *   - io->task_registered_buffers: count of buffers registered on the IO task
> > + *
> > + * Key Invariant:
> > + * --------------
> > + * The sum (io->ref + io->task_registered_buffers) must equal UBLK_REFCOUNT_INIT
> 
> This is only true when UBLK_IO_FLAG_OWNED_BY_SRV is set. If the
> ublk_io isn't currently dispatched to the ublk server, ref and
> task_registered_buffers would both be 0.

Yeah, it also means the reference counter is initialized, which is implied
in the whole doc.

> 
> > + * when no active references exist. This invariant is checked by
> > + * ublk_check_and_reset_active_ref() during daemon exit to determine if all
> > + * references have been released.
> > + *
> > + * Why Split Counters:
> > + * -------------------
> > + * Buffers registered on the IO daemon task can use the lightweight
> > + * task_registered_buffers counter (simple increment/decrement) instead of
> > + * atomic refcount operations. The ublk_io_release() callback checks if
> > + * current == io->task to decide which counter to update.
> 
> However, this optimization can only be used before the I/O is
> completed, since task_registered_buffers is collapsed into the atomic
> ref at that point. All subsequent buffer unregistrations need to use
> the atomic ref since they may be releasing the last reference.

The point is ublk_need_complete_req()/ublk_sub_req_ref(), we can make it
explicit.

> 
> > + *
> > + * Reference Lifecycle:
> > + * --------------------
> > + * 1. ublk_init_req_ref(): Sets io->ref = UBLK_REFCOUNT_INIT at IO dispatch
> > + *
> > + * 2. During IO processing:
> > + *    - On-task buffer reg: task_registered_buffers++ (no ref change)
> > + *    - Off-task buffer reg: ref++ via ublk_get_req_ref()
> > + *    - Buffer unregister callback (ublk_io_release):
> > + *      * If on-task: task_registered_buffers--
> > + *      * If off-task: ref-- via ublk_put_req_ref()
> > + *
> > + * 3. ublk_sub_req_ref() at IO completion:
> > + *    - Computes: sub_refs = UBLK_REFCOUNT_INIT - task_registered_buffers
> > + *    - Subtracts sub_refs from ref
> > + *    - This accounts for the initial UBLK_REFCOUNT_INIT minus any on-task
> > + *      buffers that were already counted in task_registered_buffers
> 
> I would note that task_registered_buffers is also zeroed during
> ublk_sub_req_ref(). Effectively, it's transferring/collapsing
> task_registered_buffers into the atomic ref.

OK.

> 
> > + *
> > + * Example (zero-copy, register on-task, unregister off-task):
> > + *   - Dispatch: ref = UBLK_REFCOUNT_INIT, task_registered_buffers = 0
> > + *   - Register buffer on-task: task_registered_buffers = 1
> > + *   - Unregister off-task: ref-- (UBLK_REFCOUNT_INIT - 1), task_registered_buffers stays 1
> > + *   - Completion via ublk_sub_req_ref():
> > + *     sub_refs = UBLK_REFCOUNT_INIT - 1, ref = (UBLK_REFCOUNT_INIT - 1) - (UBLK_REFCOUNT_INIT - 1) = 0
> > + *
> > + * Example (auto buffer registration):
> > + *   Auto buffer registration sets task_registered_buffers = 1 at dispatch.
> > + *
> > + *   - Dispatch: ref = UBLK_REFCOUNT_INIT, task_registered_buffers = 1
> > + *   - Buffer unregister: task_registered_buffers-- (becomes 0)
> > + *   - Completion via ublk_sub_req_ref(): sub_refs = UBLK_REFCOUNT_INIT - 0, ref becomes 0
> 
> I think the order here was actually reversed in commit b749965edda8
> "ublk: remove ublk_commit_and_fetch()". ublk_need_complete_req() will
> call ublk_sub_req_ref(), and io_buffer_unregister_bvec() is called
> *afterwards*, which results in a call to ublk_io_release(). So the

Right.

> buffer unregister will end up performing an atomic decrement of ref.
> 
> > + *   - Daemon exit check: sum = ref + task_registered_buffers = UBLK_REFCOUNT_INIT
> 
> Both ref  and task_registered_buffers are 0 at this point, no?

It can be UBLK_REFCOUNT_INIT or zero, please see ublk_check_and_reset_active_ref(),
the doc mentions `Daemon exit check`. But yes, both reset finally when we confirm
that the io hasn't active references.


Thanks, 
Ming

