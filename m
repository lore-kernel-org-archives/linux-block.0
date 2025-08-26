Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A23C2FAC10
	for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197193; cv=none; b=IlZYfhGMbq9OlmWcKASwKHlsFdoJ6vMXo5ehJEDN+8g+PyTWHu9oxczd4i2IWHHbv4DXBNVfHFwJYI7qc2pfdPlLa7rfhULro2Z4Nz5gcjsO3CWEcYY60OxH5a+K7DQ23zBTvkfEL9D5fCPG5ZGMQp5Wj6xMM4Kbuh8y9+YIaig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197193; c=relaxed/simple;
	bh=30m2KMKRzAr5OeH1s0nj5VdfZrRnmozbNV5CBpdfQGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcrJkAwW76iWP5pSjb2sGggVuLGOkfnKumxiI4eaO2FqcFaIRJXfpoqpIzLXzLHA/3SKvGbqZP7gvd/cz0eXvjK7srVXHcM23eFR9KScwpv5/dkQBehYcBChlAlCYT9DghP0xoJB9CeYPD0a+PjlZST8FhxdZnjE90ePaSN1IQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxHsyELf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxHsyELf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756197190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jFSh9qQsvqFbK3M7aSLNgXpR64dYKD0Rrkh9Vxx0Ic=;
	b=UxHsyELfyASxPQ7RKaQRfANJbKuK0o/uK4M1g1+93GYUglvmOdH40sMzC+8nLVbn4lk0Si
	iH32RPprlBnmwB6OrrZ8txVwuWt/QIXBAg8jTfdzfMa+O7iUgCT+XDDznWsfU0DrocBXbp
	efH9KgCmyOph8NdgB/6Ctgy8q7g5F0I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-uRkrqvXbN92B2jPGli_UuA-1; Tue,
 26 Aug 2025 04:33:03 -0400
X-MC-Unique: uRkrqvXbN92B2jPGli_UuA-1
X-Mimecast-MFC-AGG-ID: uRkrqvXbN92B2jPGli_UuA_1756197182
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1661A193E8B3;
	Tue, 26 Aug 2025 08:33:02 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54FED30001A5;
	Tue, 26 Aug 2025 08:32:54 +0000 (UTC)
Date: Tue, 26 Aug 2025 16:32:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 1/2] ublk: avoid ublk_io_release() called after ublk
 char dev is closed
Message-ID: <aK1xLM9TLUBxEmmC@fedora>
References: <20250825124827.2391820-1-ming.lei@redhat.com>
 <20250825124827.2391820-2-ming.lei@redhat.com>
 <CADUfDZp1-Tg+Gp+9kaudFNYyz3mLjNn+v=H3wKLEoKDftcX1wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZp1-Tg+Gp+9kaudFNYyz3mLjNn+v=H3wKLEoKDftcX1wg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Aug 25, 2025 at 10:49:49PM -0700, Caleb Sander Mateos wrote:
> On Mon, Aug 25, 2025 at 5:49 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > When running test_stress_04.sh, the following warning is triggered:
> >
> > WARNING: CPU: 1 PID: 135 at drivers/block/ublk_drv.c:1933 ublk_ch_release+0x423/0x4b0 [ublk_drv]
> >
> > This happens when the daemon is abruptly killed:
> >
> > - some references may still be held, because registering IO buffer
> > doesn't grab ublk char device reference
> 
> Ah, good observation. That's definitely a problem.
> 
> >
> > OR
> >
> > - io->task_registered_buffers won't be cleared because io buffer is
> > released from non-daemon context
> 
> I don't think the task_registered_buffers optimization is really
> involved here; that's just a different way of tracking the reference
> count. Regardless of what task the buffer is registered or
> unregistered on, the buffer still counts as 1 reference on the
> ublk_io. Summing up the reference counts and making sure they are both
> reset to 0 seems like a good approach to me.

The warning in ublk_queue_reinit() is triggered because

- the reference is not dropped

OR

- the io buf unregister is done from another task context(kernel wq), so
both io->ref and io->task_registered_buffers are not zero, which is started
from task_registered_buffers optimization

> 
> >
> > For zero-copy and auto buffer register modes, I/O reference crosses
> > syscalls, so IO reference may not be dropped naturally when ublk server is
> > killed abruptly. However, when releasing io_uring context, it is guaranteed
> > that the reference is dropped finally, see io_sqe_buffers_unregister() from
> > io_ring_ctx_free().
> >
> > Fix this by adding ublk_drain_io_references() that:
> > - Waits for active I/O references dropped in async way by scheduling
> >   work function, for avoiding ublk dev and io_uring file's release
> >   dependency
> > - Reinitializes io->ref and io->task_registered_buffers to clean state
> >
> > This ensures the reference count state is clean when ublk_queue_reinit()
> > is called, preventing the warning and potential use-after-free.
> 
> One scenario I worry about is if the ublk server has already issued
> UBLK_IO_COMMIT_AND_FETCH_REQ for an I/O but is killed while it still
> has registered buffer(s). It's possible the ublk server hasn't
> finished performing I/O to/from the registered buffers and so the I/O
> isn't really complete yet. But when io_uring automatically releases
> the registered buffers, the reference count will hit 0 and the ublk
> I/O will be completed successfully. There seems to be some data
> corruption risk in this scenario.

The final io buffer unregister is from freeing io_uring conext in
io_uring_release(), any user of this uring context has been done,
so it isn't possible that ublk server is performing io with the
un-registered buffer.

> But maybe it doesn't make sense for
> a ublk server to issue UBLK_IO_COMMIT_AND_FETCH_REQ with a result code
> before knowing whether the zero-copy I/Os succeeded?
> 
> >
> > Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
> > Fixes: 1ceeedb59749 ("ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on daemon task")
> > Fixes: 8a8fe42d765b ("ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon task")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 94 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 92 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 99abd67b708b..f608c7efdc05 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -239,6 +239,7 @@ struct ublk_device {
> >         struct mutex cancel_mutex;
> >         bool canceling;
> >         pid_t   ublksrv_tgid;
> > +       struct delayed_work     exit_work;
> >  };
> >
> >  /* header of ublk_params */
> > @@ -1595,12 +1596,84 @@ static void ublk_set_canceling(struct ublk_device *ub, bool canceling)
> >                 ublk_get_queue(ub, i)->canceling = canceling;
> >  }
> >
> > -static int ublk_ch_release(struct inode *inode, struct file *filp)
> > +static void ublk_reset_io_ref(struct ublk_device *ub)
> >  {
> > -       struct ublk_device *ub = filp->private_data;
> > +       int i, j;
> > +
> > +       if (!(ub->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY |
> > +                                       UBLK_F_AUTO_BUF_REG)))
> > +               return;
> > +
> > +       for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> > +               struct ublk_queue *ubq = ublk_get_queue(ub, i);
> > +
> > +               for (j = 0; j < ubq->q_depth; j++) {
> > +                       struct ublk_io *io = &ubq->ios[j];
> > +                       /*
> > +                        * Reinitialize reference counting fields after
> > +                        * draining. This ensures clean state for queue
> > +                        * reinitialization.
> > +                        */
> > +                       refcount_set(&io->ref, 0);
> > +                       io->task_registered_buffers = 0;
> > +               }
> > +       }
> > +}
> > +
> > +static bool ublk_has_io_with_active_ref(struct ublk_device *ub)
> > +{
> > +       int i, j;
> > +
> > +       if (!(ub->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY |
> > +                                       UBLK_F_AUTO_BUF_REG)))
> > +               return false;
> > +
> > +       for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> > +               struct ublk_queue *ubq = ublk_get_queue(ub, i);
> > +
> > +               for (j = 0; j < ubq->q_depth; j++) {
> > +                       struct ublk_io *io = &ubq->ios[j];
> > +                       unsigned int refs = refcount_read(&io->ref) +
> > +                               io->task_registered_buffers;
> > +
> > +                       /*
> > +                        * UBLK_REFCOUNT_INIT or zero means no active
> > +                        * reference
> > +                        */
> > +                       if (refs != UBLK_REFCOUNT_INIT && refs != 0)
> > +                               return true;
> 
> It's technically possible to hit refs == UBLK_REFCOUNT_INIT by having
> UBLK_REFCOUNT_INIT active references. It would be safer to check
> UBLK_IO_FLAG_OWNED_BY_SRV: if the flag is set, the reference count
> needs to reach UBLK_REFCOUNT_INIT; if the flag is unset, the reference
> count needs to reach 0.

It is actually one invariant that the two's sum is zero or UBLK_REFCOUNT_INIT
any time if the io buffer isn't registered, so it is enough and
simpler.

> 
> > +               }
> > +       }
> > +       return false;
> > +}
> > +
> > +static void ublk_ch_release_work_fn(struct work_struct *work)
> > +{
> > +       struct ublk_device *ub =
> > +               container_of(work, struct ublk_device, exit_work.work);
> >         struct gendisk *disk;
> >         int i;
> >
> > +       /*
> > +        * For zero-copy and auto buffer register modes, I/O references
> > +        * might not be dropped naturally when the daemon is killed, but
> > +        * io_uring guarantees that registered bvec kernel buffers are
> > +        * unregistered finally when freeing io_uring context, then the
> > +        * active references are dropped.
> > +        *
> > +        * Wait until active references are dropped for avoiding use-after-free
> > +        *
> > +        * registered buffer may be unregistered in io_ring's release hander,
> > +        * so have to wait by scheduling work function for avoiding the two
> > +        * file release dependency.
> > +        */
> > +       if (ublk_has_io_with_active_ref(ub)) {
> > +               schedule_delayed_work(&ub->exit_work, 1);
> > +               return;
> > +       }
> > +
> > +       ublk_reset_io_ref(ub);
> 
> Why the 2 separate loops over nr_hw_queues and q_depth? Could they be
> combined into a single nested loop that waits for each ublk_io's
> references to be released and then resets its reference counts to 0?
> Looks like the ub->dev_info.flags checks could also be consolidated.

This way looks more readable, otherwise ublk_has_io_with_active_ref()
has to check and reset. Not a problem, I can move it to one single helper.

> 
> > +
> >         /*
> >          * disk isn't attached yet, either device isn't live, or it has
> >          * been removed already, so we needn't to do anything
> > @@ -1673,6 +1746,23 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
> >         ublk_reset_ch_dev(ub);
> >  out:
> >         clear_bit(UB_STATE_OPEN, &ub->state);
> > +
> > +       /* put the reference grabbed in ublk_ch_release() */
> > +       ublk_put_device(ub);
> > +}
> > +
> > +static int ublk_ch_release(struct inode *inode, struct file *filp)
> > +{
> > +       struct ublk_device *ub = filp->private_data;
> > +
> > +       /*
> > +        * Grab ublk device reference, so it won't be gone until we are
> > +        * really released from work function.
> > +        */
> > +       ub = ublk_get_device(ub);
> 
> Can taking a reference fail here? If so, the NULL return value would
> need to be handled. If not, the "ub =" could be dropped.

Of course it has to get a reference, otherwise it isn't safe to use `ub`
is the release handler, I will drop "ub =".


Thanks, 
Ming

