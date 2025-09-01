Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45A2FB62E
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716310; cv=none; b=c7skFusmco4N+08ljmc8wIWrdsJKVv9JLIdaFmMOxySCZsItbKJJ7jUmRxRj2N1d+I9Kq05vAgwJ3DWcVQC7xYM6YzQdIa4NbaOmzmycwM0r24vmAZYEz5XeXRmereAFn50Ovhx4trvI4SPeczEit3HOo4yTae6Zcum0SNq9SaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716310; c=relaxed/simple;
	bh=AhlvBVxDwZhYCV6Gj7StDOKIz3Ja9P9Dxs64SVFXK1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBis0sWNgKfFx/JaoZvNaf4aVsycGsJD3QUcuBXouMtcfpygQuryCqiTImSZwJ7vCARNygBTSrDm8APQsJx/1lEw/+/D37CD+SSIDBemQ4YNwgfjfMJEB0MWOhR2Ox/syYYK07EprxbwIFWS25YAFmHaXmJXOTOSMJuuO+QClL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBTY4D2k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBTY4D2k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756716307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uvxiJPSJQkMyA7rnxksrv/oRovVQH2ELYUFsb6+os4=;
	b=jBTY4D2krb6ri8LQ+Ri+XPkKGNz1diE0HHUrvnHtPfW6I4Q061lgRvwPSVtrZo0cllHg1B
	tCYETyiqMU92IhxUnSlctsELinKvpBKJMlYLz8OJbqT7Muj06Neyh0xh8OZ8xMLYwCZmOC
	tBNhOkvZgbwNCTg0/tp3XCg74Xr+Zt4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-CYjqnNLCP7CpS6bD0yCp1A-1; Mon,
 01 Sep 2025 04:45:05 -0400
X-MC-Unique: CYjqnNLCP7CpS6bD0yCp1A-1
X-Mimecast-MFC-AGG-ID: CYjqnNLCP7CpS6bD0yCp1A_1756716304
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99F9D195E90A;
	Mon,  1 Sep 2025 08:45:04 +0000 (UTC)
Received: from fedora (unknown [10.72.116.133])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEDBE1955EA4;
	Mon,  1 Sep 2025 08:45:00 +0000 (UTC)
Date: Mon, 1 Sep 2025 16:44:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 1/2] ublk: avoid ublk_io_release() called after ublk
 char dev is closed
Message-ID: <aLVdB4q_Bk5Ypzcr@fedora>
References: <20250825124827.2391820-1-ming.lei@redhat.com>
 <20250825124827.2391820-2-ming.lei@redhat.com>
 <CADUfDZp1-Tg+Gp+9kaudFNYyz3mLjNn+v=H3wKLEoKDftcX1wg@mail.gmail.com>
 <aK1xLM9TLUBxEmmC@fedora>
 <CADUfDZqJ8PN8FT50gg0grJ+Kj+gOaosRctS_dimWAaRC-myfRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqJ8PN8FT50gg0grJ+Kj+gOaosRctS_dimWAaRC-myfRw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Aug 29, 2025 at 08:37:28AM -0700, Caleb Sander Mateos wrote:
> On Tue, Aug 26, 2025 at 1:33 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Mon, Aug 25, 2025 at 10:49:49PM -0700, Caleb Sander Mateos wrote:
> > > On Mon, Aug 25, 2025 at 5:49 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > When running test_stress_04.sh, the following warning is triggered:
> > > >
> > > > WARNING: CPU: 1 PID: 135 at drivers/block/ublk_drv.c:1933 ublk_ch_release+0x423/0x4b0 [ublk_drv]
> > > >
> > > > This happens when the daemon is abruptly killed:
> > > >
> > > > - some references may still be held, because registering IO buffer
> > > > doesn't grab ublk char device reference
> > >
> > > Ah, good observation. That's definitely a problem.
> > >
> > > >
> > > > OR
> > > >
> > > > - io->task_registered_buffers won't be cleared because io buffer is
> > > > released from non-daemon context
> > >
> > > I don't think the task_registered_buffers optimization is really
> > > involved here; that's just a different way of tracking the reference
> > > count. Regardless of what task the buffer is registered or
> > > unregistered on, the buffer still counts as 1 reference on the
> > > ublk_io. Summing up the reference counts and making sure they are both
> > > reset to 0 seems like a good approach to me.
> >
> > The warning in ublk_queue_reinit() is triggered because
> >
> > - the reference is not dropped
> >
> > OR
> >
> > - the io buf unregister is done from another task context(kernel wq), so
> > both io->ref and io->task_registered_buffers are not zero, which is started
> > from task_registered_buffers optimization
> 
> Right, but I would consider that to be an outstanding reference. I
> think we're on the same page.
> 
> >
> > >
> > > >
> > > > For zero-copy and auto buffer register modes, I/O reference crosses
> > > > syscalls, so IO reference may not be dropped naturally when ublk server is
> > > > killed abruptly. However, when releasing io_uring context, it is guaranteed
> > > > that the reference is dropped finally, see io_sqe_buffers_unregister() from
> > > > io_ring_ctx_free().
> > > >
> > > > Fix this by adding ublk_drain_io_references() that:
> > > > - Waits for active I/O references dropped in async way by scheduling
> > > >   work function, for avoiding ublk dev and io_uring file's release
> > > >   dependency
> > > > - Reinitializes io->ref and io->task_registered_buffers to clean state
> > > >
> > > > This ensures the reference count state is clean when ublk_queue_reinit()
> > > > is called, preventing the warning and potential use-after-free.
> > >
> > > One scenario I worry about is if the ublk server has already issued
> > > UBLK_IO_COMMIT_AND_FETCH_REQ for an I/O but is killed while it still
> > > has registered buffer(s). It's possible the ublk server hasn't
> > > finished performing I/O to/from the registered buffers and so the I/O
> > > isn't really complete yet. But when io_uring automatically releases
> > > the registered buffers, the reference count will hit 0 and the ublk
> > > I/O will be completed successfully. There seems to be some data
> > > corruption risk in this scenario.
> >
> > The final io buffer unregister is from freeing io_uring conext in
> > io_uring_release(), any user of this uring context has been done,
> > so it isn't possible that ublk server is performing io with the
> > un-registered buffer.
> 
> Well, the ublk server could have been killed before it could submit an
> I/O using the registered buffer. But it's an existing concern,
> certainly not introduced by your patch. I think you can make a
> reasonable argument that a ublk server shouldn't submit a
> UBLK_IO_COMMIT_AND_FETCH_REQ until it knows the I/O completed
> successfully or with an error, otherwise it won't be able to change
> the result code if the I/O using the registered buffer unexpectedly
> fails.

Yes, it was one trouble because ublk server can do whatever.

However, since your task_registered_buffers optimization, ublk request
won't be completed from freeing uring_ctx context any more, and it is always
aborted from ublk_abort_queue(), so it is failed in case of killed ublk
server.

The situation can be improved by failing request explicitly by setting io->res
as -EIO, then -EIO can be taken first in case of killed ublk server.

> 
> >
> > > But maybe it doesn't make sense for
> > > a ublk server to issue UBLK_IO_COMMIT_AND_FETCH_REQ with a result code
> > > before knowing whether the zero-copy I/Os succeeded?
> > >
> > > >
> > > > Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
> > > > Fixes: 1ceeedb59749 ("ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on daemon task")
> > > > Fixes: 8a8fe42d765b ("ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon task")
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c | 94 +++++++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 92 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index 99abd67b708b..f608c7efdc05 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -239,6 +239,7 @@ struct ublk_device {
> > > >         struct mutex cancel_mutex;
> > > >         bool canceling;
> > > >         pid_t   ublksrv_tgid;
> > > > +       struct delayed_work     exit_work;
> > > >  };
> > > >
> > > >  /* header of ublk_params */
> > > > @@ -1595,12 +1596,84 @@ static void ublk_set_canceling(struct ublk_device *ub, bool canceling)
> > > >                 ublk_get_queue(ub, i)->canceling = canceling;
> > > >  }
> > > >
> > > > -static int ublk_ch_release(struct inode *inode, struct file *filp)
> > > > +static void ublk_reset_io_ref(struct ublk_device *ub)
> > > >  {
> > > > -       struct ublk_device *ub = filp->private_data;
> > > > +       int i, j;
> > > > +
> > > > +       if (!(ub->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY |
> > > > +                                       UBLK_F_AUTO_BUF_REG)))
> > > > +               return;
> > > > +
> > > > +       for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> > > > +               struct ublk_queue *ubq = ublk_get_queue(ub, i);
> > > > +
> > > > +               for (j = 0; j < ubq->q_depth; j++) {
> > > > +                       struct ublk_io *io = &ubq->ios[j];
> > > > +                       /*
> > > > +                        * Reinitialize reference counting fields after
> > > > +                        * draining. This ensures clean state for queue
> > > > +                        * reinitialization.
> > > > +                        */
> > > > +                       refcount_set(&io->ref, 0);
> > > > +                       io->task_registered_buffers = 0;
> > > > +               }
> > > > +       }
> > > > +}
> > > > +
> > > > +static bool ublk_has_io_with_active_ref(struct ublk_device *ub)
> > > > +{
> > > > +       int i, j;
> > > > +
> > > > +       if (!(ub->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY |
> > > > +                                       UBLK_F_AUTO_BUF_REG)))
> > > > +               return false;
> > > > +
> > > > +       for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> > > > +               struct ublk_queue *ubq = ublk_get_queue(ub, i);
> > > > +
> > > > +               for (j = 0; j < ubq->q_depth; j++) {
> > > > +                       struct ublk_io *io = &ubq->ios[j];
> > > > +                       unsigned int refs = refcount_read(&io->ref) +
> > > > +                               io->task_registered_buffers;
> > > > +
> > > > +                       /*
> > > > +                        * UBLK_REFCOUNT_INIT or zero means no active
> > > > +                        * reference
> > > > +                        */
> > > > +                       if (refs != UBLK_REFCOUNT_INIT && refs != 0)
> > > > +                               return true;
> > >
> > > It's technically possible to hit refs == UBLK_REFCOUNT_INIT by having
> > > UBLK_REFCOUNT_INIT active references. It would be safer to check
> > > UBLK_IO_FLAG_OWNED_BY_SRV: if the flag is set, the reference count
> > > needs to reach UBLK_REFCOUNT_INIT; if the flag is unset, the reference
> > > count needs to reach 0.
> >
> > It is actually one invariant that the two's sum is zero or UBLK_REFCOUNT_INIT
> > any time if the io buffer isn't registered, so it is enough and
> > simpler.
> 
> I think it's theoretically possible to make the reference count
> arbitrarily high with ublk registered buffers, which can cause it to
> actually have UBLK_REFCOUNT_INIT references (not because all
> references are released) or the reference count to overflow back to 0.
> One way to do this would be to register the same I/O's buffer in many
> slots of many io_urings at the same time.

The reference is initialized as UBLK_REFCOUNT_INIT, the only way for
triggering it is to make the counter overflow first.


> Another possibility would be
> to repeatedly register the buffer, use it in an I/O that never
> completes (e.g. recv from an empty socket), and then unregister the
> buffer. But this reference count overflow issue is an existing issue,
> not introduced by the patch.

Yes, overflow can be detected & warned by refcount checking, also it is only
allowed for privileged user, so looks this way is just fine.


Thanks, 
Ming

