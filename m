Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com [209.85.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DB01DE4F3
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728330615; cv=none; b=BTi1fRJ8aBv1KFIuo6ef9hsYmiLIL1gcq1NLmGmR8wEsRI9o9KwqjoW2RsXBUU0MzBYHtYaUw5Dja312nlpMC4YS2uNLMyGhyZYg1Fj6KyPKc6W9Npk0FTsMg1oY7NUvlmmHOEKdIruub4uCXe2KbriUe+JoATaiEzc0tSW6idw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728330615; c=relaxed/simple;
	bh=esDOm3VQ2upfZl8bJIRxlOGr2a7KYNCeFdAKipz9fOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQoPIhI4xttG4Av5ByLmmjmHVzJO9qsjpyaFWTEV3xsK1eE4jO6nIW6DxFI3UYIWiMYQvjuiEMXEUA1upj4WsEfPCY6BpqerRGOPKtxHvH+cW/dqm21UWyLTXHFH988gI24h5qqi/oA1MDldbpxyvQ7jpLbPlndDLmnT0NXToeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GRZCZNHb; arc=none smtp.client-ip=209.85.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GRZCZNHb"
Received: by mail-lf1-f99.google.com with SMTP id 2adb3069b0e04-53995380bb3so5821601e87.1
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 12:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1728330611; x=1728935411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eHtovep0JE14xTwzXcwyLxOz1fN+CqpTD2vMREb0zFM=;
        b=GRZCZNHbfMQb3lmwVG9V7sm32Pf5Np/fJHkTv/OIXcNBz2N0QIc3XfQ/oVybtn4xpH
         Bw54Kl/VaTBZVdYmR1NkB4z6X7ShqC+LiBrQOTBecjUlXWsJWzt+o1I0XBmHFHelm5gD
         6hGyycMkVlgdob3m2QFPWUaug4T42wOXFIfWcaqWVB97ejsK6/IUyejRbvcvrKy0oL8L
         C4h1ZwrN9Au64ZulY9AvrrYU0f5K5dGRI3VFcLs7VNBAWioYukfpzdgp8BMHHaUB+dfc
         meqgxPWGBVl4t7eQSV5Jp8rZjwUeCxxHu82qG4hfERz1tqxIfh73+FZjVyYFWSZ70eFX
         qgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728330611; x=1728935411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHtovep0JE14xTwzXcwyLxOz1fN+CqpTD2vMREb0zFM=;
        b=xGxTSFHFxZVR7Pd0JEumdBFXzI2GAelU+cM3z6xOOONeIAFvhjkbNHXh87FqJLYMSR
         4uTp3mDpdYYioGtZnQR6IFDEe+5OSopI2pntA6KHHv6kcfGmQsoBwxQ5OT4l97/svACH
         f7TlCMOlh6pyCZZCQmsR2SvC+BJztndjBP7aZQGpP/xcbo8kXPxswujQeMygxVxk6RHf
         E6/qZNwbE3YVRbnFAStiKMequNm5rGv8QUcim3fJjH2U04fwe0QLdc8lwIrrOiCcGQo6
         ty0yj2YB3xBKCLdmnJrNsxf8KrzE0yPNd/GM4JWWIm1gyNPC0q1Btj4tmD/5IM6u0lXv
         JSew==
X-Forwarded-Encrypted: i=1; AJvYcCUw2JRV53QCRJ60gUvPaUPfe616rG9lLIPqAwPoQiS2DpTVAT6xN1jMSo/U0EXr3G+OggfgVAROe+IIaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsl1yDZNY95muTEm1+nWj+nE574VVTfaDWqiChZsE3FMNKbfcb
	vUlvb4gm3FbejEoL+OoNfYsGpgq9TDlDClbSS8O+g50j8Af9sKBHDcLekCZRD1fWHgSQYa1AC/w
	FRvVlpzKE8BicZxhwFovSv4q93YO9eusTnQNWgj6JDUo8sBkL
X-Google-Smtp-Source: AGHT+IHDR1sh0KU/BLTglMFNZABrBQ97qYDCacOiTl5vyD6JB1//tugSa8laz/+GrYmyS6VQRBUGjNrtec6/
X-Received: by 2002:a05:6512:3ba8:b0:537:a864:dca7 with SMTP id 2adb3069b0e04-539ab9ed1c7mr6794442e87.55.1728330610602;
        Mon, 07 Oct 2024 12:50:10 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-a9939ee438csm10598266b.290.2024.10.07.12.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 12:50:10 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 38029340204;
	Mon,  7 Oct 2024 13:50:09 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 29241E4062A; Mon,  7 Oct 2024 13:50:09 -0600 (MDT)
Date: Mon, 7 Oct 2024 13:50:09 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: decouple hctx and ublk server threads
Message-ID: <ZwQ7cQPSiUlmEGZc@dev-ushankar.dev.purestorage.com>
References: <20241002224437.3088981-1-ushankar@purestorage.com>
 <ZwJWRSBnH7Cm3djA@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwJWRSBnH7Cm3djA@fedora>

On Sun, Oct 06, 2024 at 05:20:05PM +0800, Ming Lei wrote:
> On Wed, Oct 02, 2024 at 04:44:37PM -0600, Uday Shankar wrote:
> > Currently, ublk_drv associates to each hardware queue (hctx) a unique
> > task (called the queue's ubq_daemon) which is allowed to issue
> > COMMIT_AND_FETCH commands against the hctx. If any other task attempts
> > to do so, the command fails immediately with EINVAL. When considered
> > together with the block layer architecture, the result is that for each
> > CPU C on the system, there is a unique ublk server thread which is
> > allowed to handle I/O submitted on CPU C. This can lead to suboptimal
> > performance under imbalanced load generation. For an extreme example,
> > suppose all the load is generated on CPUs mapping to a single ublk
> > server thread. Then that thread may be fully utilized and become the
> > bottleneck in the system, while other ublk server threads are totally
> > idle.
> 
> I am wondering why the problem can't be avoided by setting ublk server's
> thread affinity manually.

I don't think the ublk server thread CPU affinity has any effect here.
Assuming that the ublk server threads do not pass I/Os between
themselves to balance the load, each ublk server thread must handle all
the I/O issued to its associated hctx, and each thread is limited by how
much CPU it can get. Since threads are the unit of parallelism, one
thread can make use of at most one CPU, regardless of the affinity of
the thread. And this can become a bottleneck.

> > be balanced across all ublk server threads by having the threads fetch
> > I/Os for the same QID in a round robin manner. For example, in a system
> > with 4 ublk server threads, 2 hctxs, and a queue depth of 4, the threads
> > could issue fetch requests as follows (where each entry is of the form
> > qid, tag):
> > 
> > poller thread:	T0	T1	T2	T3
> > 		0,0	0,1	0,2	0,3
> > 		1,3	1,0	1,1	1,2
> 
> How many ublk devices there are? If it is 1, just wondering why you use
> 4 threads? Usually one thread is enough to drive one queue, and the
> actually io command handling can be moved to new work thread if the queue
> thread is saturated.

This is just a small example to demonstrate the idea, not necessarily a
realistic one.

> > -static inline void ublk_forward_io_cmds(struct ublk_queue *ubq,
> > -					unsigned issue_flags)
> > -{
> > -	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
> > -	struct ublk_rq_data *data, *tmp;
> > -
> > -	io_cmds = llist_reverse_order(io_cmds);
> > -	llist_for_each_entry_safe(data, tmp, io_cmds, node)
> > -		__ublk_rq_task_work(blk_mq_rq_from_pdu(data), issue_flags);
> > -}
> > -
> > -static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd, unsigned issue_flags)
> > -{
> > -	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> > -	struct ublk_queue *ubq = pdu->ubq;
> > -
> > -	ublk_forward_io_cmds(ubq, issue_flags);
> > -}
> > -
> >  static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
> >  {
> > -	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
> > -
> > -	if (llist_add(&data->node, &ubq->io_cmds)) {
> > -		struct ublk_io *io = &ubq->ios[rq->tag];
> > -
> > -		io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
> > -	}
> > +	struct ublk_io *io = &ubq->ios[rq->tag];
> > +	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(io->cmd);
> > +	pdu->req = rq;
> > +	io_uring_cmd_complete_in_task(io->cmd, __ublk_rq_task_work);
> >  }
> 
> It should be fine to convert to io_uring_cmd_complete_in_task() since
> the callback list is re-ordered in io_uring.

Yes, I noticed that task_work has (lockless) internal queueing, so
there shouldn't be a need to maintain our own queue of commands in
ublk_drv. I can factor this change out into its own patch if that is
useful.

> 
> >  
> >  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> >  {
> >  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> > +	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
> >  	unsigned int nr_inflight = 0;
> >  	int i;
> >  
> >  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> > -		if (!ubq->timeout) {
> > -			send_sig(SIGKILL, ubq->ubq_daemon, 0);
> > -			ubq->timeout = true;
> > -		}
> > -
> > +		send_sig(SIGKILL, data->task, 0);
> >  		return BLK_EH_DONE;
> >  	}
> >  
> > -	if (!ubq_daemon_is_dying(ubq))
> > +	if (!(data->task->flags & PF_EXITING))
> >  		return BLK_EH_RESET_TIMER;
> 
> ->task is only for error handling, but it may not work any more since
> who knows which task is for handling the io command actually.

Yes, you are right - this part right here is the only reason we need to
save/take a reference to the task. I have a couple alternative ideas:

1. Don't kill anything if a timeout happens. Instead, synchronize
   against the "normal" completion path (i.e. commit_and_fetch), and if
   timeout happens first, normal completion gets an error. If normal
   completion happens first, timeout does nothing.
2. Require that all threads handling I/O are threads of the same process
   (in the kernel, I think this means their task_struct::group_leader is
   the same?) In the normal completion path, we replace the check that
   exists today (check equality with ubq_daemon) with ensuring that the
   current task is within the process. In the timeout path, we send
   SIGKILL to the top-level process, which should propagate to the
   threads as well.

Does either of those sound okay?

