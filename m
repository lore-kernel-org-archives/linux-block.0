Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61213594A
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750728404; cv=none; b=QjFrAz1YKE0Nyr9Brw0oIhCLbvputZJjJ2Zqlo2ol6YNjr8rcQwTbYfvGau2FSY2Ldiwx7XVsrvjQIbd4Jc9iXtUAOJRxlO0Y5ttEz5x3hYr+YpHaN0QH/5zhB413xIjkM79TMXCMkIQCFWMc6IjTL2qAwVUmK0AYB4rIW6P5Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750728404; c=relaxed/simple;
	bh=1NnDLPnI6nRi6sAojnL//BP4T5z2ao9MeAGFOzBoNGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCwo0GbV70zgJD4VbJSfBy1a6RMcOr/XNsohjOxEDvUqIoTfGXvKuGyR/L1PsOeK3/LkAKm7glxAYMaulIEnUABKGLHxZoefG7vBguMDfNOP+GY713/OHN+IrTDr56cChSLTzVVQMfy5VWq8611fbpC0vq8Pbg4PxylfZt1FmXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=awOzgHkF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awOzgHkF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750728397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uq6XnlmauGas+f6HUksO9YNlrUdQoa4NgFcUSknIIsE=;
	b=awOzgHkFxrilK7zAYgrZ7ggkotbRq1YIcy7Fa+yL8KBA5TfZ8Rq8Nzojsslh6FHQJxWz61
	ocrcRMRVngT+zc8ePmHRnvb3RL6oUrdTP0RLfvqcBN/A/BmeqCB+fXDWD4ViN5f1LTKy5b
	8iQbjKt2/xz4GO8//XvS2OeGFGKApjk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-uQpY-apYM-27ZPU5EfHWwg-1; Mon,
 23 Jun 2025 21:26:35 -0400
X-MC-Unique: uQpY-apYM-27ZPU5EfHWwg-1
X-Mimecast-MFC-AGG-ID: uQpY-apYM-27ZPU5EfHWwg_1750728394
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB149195609D;
	Tue, 24 Jun 2025 01:26:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.90])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B89B218002B8;
	Tue, 24 Jun 2025 01:26:31 +0000 (UTC)
Date: Tue, 24 Jun 2025 09:26:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Changhui Zhong <czhong@redhat.com>,
	Linux Block Devices <linux-block@vger.kernel.org>
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address:
 0000000000000001
Message-ID: <aFn-wpK5rw4rE1WI@fedora>
References: <CAGVVp+VN9QcpHUz_0nasFf5q9i1gi8H8j-G-6mkBoqa3TyjRHA@mail.gmail.com>
 <aFjR1M2RwGn8y9Rs@fedora>
 <CAGVVp+V-X6vEz1sbvenTBeXJa_8OZTaV3MwPOhhR5aOjmWm50Q@mail.gmail.com>
 <CADUfDZr9rLCcZ_fO+6kivSesxLV4xj8Efrzp3C0oJ++YNGO-EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZr9rLCcZ_fO+6kivSesxLV4xj8Efrzp3C0oJ++YNGO-EQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Jun 23, 2025 at 01:33:44PM -0700, Caleb Sander Mateos wrote:
> On Mon, Jun 23, 2025 at 2:13 AM Changhui Zhong <czhong@redhat.com> wrote:
> >
> > On Mon, Jun 23, 2025 at 12:02 PM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > Hi Changhui,
> > >
> > > On Mon, Jun 23, 2025 at 10:58:24AM +0800, Changhui Zhong wrote:
> > > > Hello,
> > > >
> > > > the following kernel panic was triggered by ubdsrv  generic/002,
> > > > please help check and let me know if you need any info/test, thanks.
> > > >
> > > > commit HEAD:
> > > >
> > > > commit 2589cd05008205ee29f5f66f24a684732ee2e3a3
> > > > Merge: 98d0347fe8fb e1c75831f682
> > > > Author: Jens Axboe <axboe@kernel.dk>
> > > > Date:   Wed Jun 18 05:11:50 2025 -0600
> > > >
> > > >     Merge branch 'io_uring-6.16' into for-next
> > > >
> > > >     * io_uring-6.16:
> > > >       io_uring: fix potential page leak in io_sqe_buffer_register()
> > > >       io_uring/sqpoll: don't put task_struct on tctx setup failure
> > > >       io_uring: remove duplicate io_uring_alloc_task_context() definition
> > >
> > > The above branch has been merged to v6.16-rc3, can you reproduce it with -rc3?
> > >
> > > I tried to duplicate in my test VM, not succeed with -rc3.
> > >
> > > ...
> > >
> > > > [ 7044.064528] BUG: kernel NULL pointer dereference, address: 0000000000000001
> > > > [ 7044.071507] #PF: supervisor read access in kernel mode
> > > > [ 7044.076653] #PF: error_code(0x0000) - not-present page
> > > > [ 7044.081801] PGD 462c42067 P4D 462c42067 PUD 462c43067 PMD 0
> > > > [ 7044.087488] Oops: Oops: 0000 [#1] SMP NOPTI
> > > > [ 7044.091685] CPU: 13 UID: 0 PID: 367 Comm: kworker/13:1H Not tainted
> > > > 6.16.0-rc2+ #1 PREEMPT(voluntary)
> > > > [ 7044.100991] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS
> > > > 2.22.2 09/12/2024
> > > > [ 7044.108565] Workqueue: kblockd blk_mq_requeue_work
> > > > [ 7044.113374] RIP: 0010:__io_req_task_work_add+0x18/0x1f0
> > >
> > > Can you share where the above line points to source line if it can be
> > > reproduced in -rc3?
> > >
> > > gdb> l *(__io_req_task_work_add+0x18)
> > >
> > >
> > > Thanks,
> > > Ming
> > >
> >
> > now successfully reproduced on v6.16-rc3, more loop tests are needed
> > to trigger this issue，
> >
> > [ 8898.102836] BUG: kernel NULL pointer dereference, address: 0000000000000001
> > [ 8898.109848] #PF: supervisor read access in kernel mode
> > [ 8898.115011] #PF: error_code(0x0000) - not-present page
> > [ 8898.120161] PGD 80000001bcd7b067 P4D 80000001bcd7b067 PUD 1ee49f067 PMD 0
> > [ 8898.127043] Oops: Oops: 0000 [#1] SMP PTI
> > [ 8898.131065] CPU: 2 UID: 0 PID: 47056 Comm: kworker/2:2H Not tainted
> > 6.16.0-rc3 #1 PREEMPT(voluntary)
> > [ 8898.140283] Hardware name: Dell Inc. PowerEdge R340/045M96, BIOS
> > 2.17.3 09/12/2024
> > [ 8898.147860] Workqueue: kblockd blk_mq_requeue_work
> > [ 8898.152658] RIP: 0010:__io_req_task_work_add+0x18/0x1f0
> > [ 8898.157895] Code: 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> > 90 90 66 0f 1f 00 0f 1f 44 00 00 41 56 41 55 41 54 55 53 48 8b 6f 60
> > 48 89 fb <f6> 45 01 20 0f 84 8e 00 00 00 31 c0 f6 47 48 0c 0f 94 c0 21
> > c6 41
> 
> Disassembling this:
> 0:  41 56                   push   r14
> 2:  41 55                   push   r13
> 4:  41 54                   push   r12
> 6:  55                      push   rbp
> 7:  53                      push   rbx
> 8:  48 8b 6f 60             mov    rbp,QWORD PTR [rdi+0x60]
> c:  48 89 fb                mov    rbx,rdi
> f:  f6 45 01 20             test   BYTE PTR [rbp+0x1],0x20 <--here
> 13: 0f 84 8e 00 00 00       je     0xa7
> 19: 31 c0                   xor    eax,eax
> 1b: f6 47 48 0c             test   BYTE PTR [rdi+0x48],0xc
> 1f: 0f 94 c0                sete   al
> 22: 21 c6                   and    esi,eax
> 
> So we look to be at the start of __io_req_task_work_add(). rdi stores
> req, rbp stores req->ctx, and so the test instruction that's faulting
> is loading (the second byte of) req->ctx->flags for the
> req->ctx->flags & IORING_SETUP_DEFER_TASKRUN check. This means
> req->ctx is NULL. Is it possible the req has already been completed or
> cancelled? The stacktrace shows that this is coming from
> blk_mq_requeue_work, which is definitely interesting.
> 

The issue should be in handling UBLK_IO_NEED_GET_DATA, -EIOCBQUEUED is
returned without setting io->cmd.

I will send a fix soon.


Thanks
Ming

