Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA81F951
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728353514; cv=none; b=PWCIJ4dbg1ERqyixZYaukYWrQeqskrE3comoMn4zi1lisq7cQNpRNnLzUrln157o9zfkUoz2tLA4ePV2AAnFpW3Gx1hlN8p4u1OycRtY30ZI3IXtYeGWuba/94IjHfbAUCaJ21mXDW1x68m9Fh/L1pFlaEjLSRgWBhqbaPXPK1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728353514; c=relaxed/simple;
	bh=SeUGdni2V7rWtRsZ+FReiODM13TaSA6q1tQ5Riof3zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHvt76v9Ma0PH3jCC6zIgyRs/Xv7mmRbF71wII3T+HqSlErApcR52cS3RdQ8BMO1WvyMCxuVzMR3dETqXu/ONzdT9UCHaNBRGM++gs9tRvY2dYrau43vstrMkLVREdeCJ2gDHSujdO16b5MqzJmLrDQ5YHlh+/M63MNG31rl/rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fvcr+qG5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fvcr+qG5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728353510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqRpji42m/ur09QZ+k9AeA/nvzIucTjdqvm0w0y5jCs=;
	b=Fvcr+qG5tbjwgHY1eyBVYgnkz7EVTZbZ91ItndfPyqJIHmYn/p0x9Y/oPFvBhPPxhIKHxk
	3SJ62jCCB9FiCMCgGFS5JqaWpv7I0uIpc+LVBm8VRRbFEkf6NiqCRimUAMFOFJbXUr3CbE
	Kai/Pci79846RGDixK3Azsb1AQOqMmA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-_AJOf0WTOTaUMavVLWBoug-1; Mon,
 07 Oct 2024 22:11:47 -0400
X-MC-Unique: _AJOf0WTOTaUMavVLWBoug-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E18731955F3C;
	Tue,  8 Oct 2024 02:11:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.102])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 015B919560A3;
	Tue,  8 Oct 2024 02:11:41 +0000 (UTC)
Date: Tue, 8 Oct 2024 10:11:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: decouple hctx and ublk server threads
Message-ID: <ZwSU1yRc0e6ipehp@fedora>
References: <20241002224437.3088981-1-ushankar@purestorage.com>
 <ZwJWRSBnH7Cm3djA@fedora>
 <ZwQ7cQPSiUlmEGZc@dev-ushankar.dev.purestorage.com>
 <ZwSPO4b6rccVVx-H@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwSPO4b6rccVVx-H@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Oct 08, 2024 at 09:47:39AM +0800, Ming Lei wrote:
> On Mon, Oct 07, 2024 at 01:50:09PM -0600, Uday Shankar wrote:
> > On Sun, Oct 06, 2024 at 05:20:05PM +0800, Ming Lei wrote:
> > > On Wed, Oct 02, 2024 at 04:44:37PM -0600, Uday Shankar wrote:
> > > > Currently, ublk_drv associates to each hardware queue (hctx) a unique
> > > > task (called the queue's ubq_daemon) which is allowed to issue
> > > > COMMIT_AND_FETCH commands against the hctx. If any other task attempts
> > > > to do so, the command fails immediately with EINVAL. When considered
> > > > together with the block layer architecture, the result is that for each
> > > > CPU C on the system, there is a unique ublk server thread which is
> > > > allowed to handle I/O submitted on CPU C. This can lead to suboptimal
> > > > performance under imbalanced load generation. For an extreme example,
> > > > suppose all the load is generated on CPUs mapping to a single ublk
> > > > server thread. Then that thread may be fully utilized and become the
> > > > bottleneck in the system, while other ublk server threads are totally
> > > > idle.
> > > 
> > > I am wondering why the problem can't be avoided by setting ublk server's
> > > thread affinity manually.
> > 
> > I don't think the ublk server thread CPU affinity has any effect here.
> > Assuming that the ublk server threads do not pass I/Os between
> > themselves to balance the load, each ublk server thread must handle all
> > the I/O issued to its associated hctx, and each thread is limited by how
> > much CPU it can get. Since threads are the unit of parallelism, one
> > thread can make use of at most one CPU, regardless of the affinity of
> > the thread. And this can become a bottleneck.
> 
> If ublk server may be saturated, there is at least two choices:
> 
> - increase nr_hw_queues, so each ublk server thread can handle IOs from
>   less CPUs
> 
> - let ublk server focus on submitting UBLK_IO_COMMIT_AND_FETCH_REQ
> uring_cmd, and moving actual IO handling into new worker thread if ublk
> server becomes saturated, and the communication can be done with eventfd,
> please see example in:
> 
> https://github.com/ublk-org/ublksrv/blob/master/demo_event.c
> 
> > 
> > > > be balanced across all ublk server threads by having the threads fetch
> > > > I/Os for the same QID in a round robin manner. For example, in a system
> > > > with 4 ublk server threads, 2 hctxs, and a queue depth of 4, the threads
> > > > could issue fetch requests as follows (where each entry is of the form
> > > > qid, tag):
> > > > 
> > > > poller thread:	T0	T1	T2	T3
> > > > 		0,0	0,1	0,2	0,3
> > > > 		1,3	1,0	1,1	1,2
> > > 
> > > How many ublk devices there are? If it is 1, just wondering why you use
> > > 4 threads? Usually one thread is enough to drive one queue, and the
> > > actually io command handling can be moved to new work thread if the queue
> > > thread is saturated.
> > 
> > This is just a small example to demonstrate the idea, not necessarily a
> > realistic one.
> 
> OK, but I'd suggest to share examples closing to reality, then we can
> just focus on problems in real cases.
> 
> > 
> > > > -static inline void ublk_forward_io_cmds(struct ublk_queue *ubq,
> > > > -					unsigned issue_flags)
> > > > -{
> > > > -	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
> > > > -	struct ublk_rq_data *data, *tmp;
> > > > -
> > > > -	io_cmds = llist_reverse_order(io_cmds);
> > > > -	llist_for_each_entry_safe(data, tmp, io_cmds, node)
> > > > -		__ublk_rq_task_work(blk_mq_rq_from_pdu(data), issue_flags);
> > > > -}
> > > > -
> > > > -static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd, unsigned issue_flags)
> > > > -{
> > > > -	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> > > > -	struct ublk_queue *ubq = pdu->ubq;
> > > > -
> > > > -	ublk_forward_io_cmds(ubq, issue_flags);
> > > > -}
> > > > -
> > > >  static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
> > > >  {
> > > > -	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
> > > > -
> > > > -	if (llist_add(&data->node, &ubq->io_cmds)) {
> > > > -		struct ublk_io *io = &ubq->ios[rq->tag];
> > > > -
> > > > -		io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
> > > > -	}
> > > > +	struct ublk_io *io = &ubq->ios[rq->tag];
> > > > +	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(io->cmd);
> > > > +	pdu->req = rq;
> > > > +	io_uring_cmd_complete_in_task(io->cmd, __ublk_rq_task_work);
> > > >  }
> > > 
> > > It should be fine to convert to io_uring_cmd_complete_in_task() since
> > > the callback list is re-ordered in io_uring.
> > 
> > Yes, I noticed that task_work has (lockless) internal queueing, so
> > there shouldn't be a need to maintain our own queue of commands in
> > ublk_drv. I can factor this change out into its own patch if that is
> > useful.
> 
> Yeah, please go ahead, since it does simplify things.
> 
> > 
> > > 
> > > >  
> > > >  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> > > >  {
> > > >  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> > > > +	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
> > > >  	unsigned int nr_inflight = 0;
> > > >  	int i;
> > > >  
> > > >  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> > > > -		if (!ubq->timeout) {
> > > > -			send_sig(SIGKILL, ubq->ubq_daemon, 0);
> > > > -			ubq->timeout = true;
> > > > -		}
> > > > -
> > > > +		send_sig(SIGKILL, data->task, 0);
> > > >  		return BLK_EH_DONE;
> > > >  	}
> > > >  
> > > > -	if (!ubq_daemon_is_dying(ubq))
> > > > +	if (!(data->task->flags & PF_EXITING))
> > > >  		return BLK_EH_RESET_TIMER;
> > > 
> > > ->task is only for error handling, but it may not work any more since
> > > who knows which task is for handling the io command actually.
> > 
> > Yes, you are right - this part right here is the only reason we need to
> > save/take a reference to the task. I have a couple alternative ideas:
> > 
> > 1. Don't kill anything if a timeout happens. Instead, synchronize
> >    against the "normal" completion path (i.e. commit_and_fetch), and if
> >    timeout happens first, normal completion gets an error. If normal
> >    completion happens first, timeout does nothing.
> 
> But how to synchronize? Looks the only weapon could be RCU.
> 
> Also one server thread may have bug and run into dead loop.
> 
> > 2. Require that all threads handling I/O are threads of the same process
> >    (in the kernel, I think this means their task_struct::group_leader is
> >    the same?)
> 
> So far we only allow single process to open /dev/ublkcN, so all threads
> have to belong to same process.
> 
> And that can be thought as another limit of ublk implementation.
> 
> > In the normal completion path, we replace the check that
> >    exists today (check equality with ubq_daemon) with ensuring that the
> >    current task is within the process. In the timeout path, we send
> >    SIGKILL to the top-level process, which should propagate to the
> >    threads as well.
> 
> It should be enough to kill the only process which opens '/dev/ublkcN'.
> 
> > 
> > Does either of those sound okay?
> 
> Looks #2 is more doable.

Forget to mention, `struct ublk_queue` and `struct ublk_io` are operated
lockless now, since we suppose both two are read/write in single pthread.

If we kill this limit, READ/WRITE on the two structures have to
protected, which may add extra cost, :-(


Thanks,
Ming

