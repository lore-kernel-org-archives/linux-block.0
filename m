Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174F7388882;
	Tue, 12 May 2026 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589641; cv=none; b=Z4B+1bx41BLOdHIk0VJYinJmAXOV80MhuwgPsmK6UAKEOURNv03wN2itmWaiHEUdvBQ8EgAy4kreNk/boGZcGgOrUTgtL4wGUMeUInpZ0SUKy5dLKdQOTvN4TiPqUy2/yt6QIhKO1a7xUHa7JoXw2yZgibYz70pa2z7nOdAWMxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589641; c=relaxed/simple;
	bh=/aPJ2FydTuDDFHfqQVZJ+O0BFa6yGd9S7P2jzRkEpY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roMTr3FrMq2rjwRthhD5W2qafU8fyrZ6W2lpfggzeKn77MgZkTvAA73/u9nYHLa2G3WnQib4lHRy9pcth8fi8ZgAkhYn3XYGA485My67wWiEfcBXsiafKtnB42WCkPxhvad1KeYWcb4LWqVlANO9SGcz8Sj7jY4mzhPrROWdFKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UkiPQoMT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UkiPQoMT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sx/aTUJMAwlAnMQA5EsetnGYrgOYuy3tvG0DXI0Vbvk=; b=UkiPQoMTiH8AXS40Q3WvXcUaRw
	RTG2OFWFJceysjCLH0VO8Nm2BcaMzdp4v9ZrC0I2XfmPmOPsA2ZNC7cqi3de9WHxKapMwEOerVxcK
	b+pnbjPULxj8TAtRXD4NtB2Q2Ai9f42vn3dxRcyO4sKo4+KaAWxg8Vod7YbKFt4Ev2tNFnq73czAp
	lnBMKOpkbf0um3Fzf1vt7VxDWIO1uxlQeR+6UOIDIz7VnqZ0Kmxx5j0D4SZtVgOYGGL3S38GG/20s
	5Y6ZERDtS/nje0VLh9k85+bPXKO+109KaA6/kiac7gWDiwX2T6A4JCwnWJUcyRcty2di3HjzQWJDo
	QQf7t7AQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMmPO-00000009k1N-3WLe;
	Tue, 12 May 2026 12:40:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2E75B30075A; Tue, 12 May 2026 14:40:21 +0200 (CEST)
Date: Tue, 12 May 2026 14:40:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Michael Wu <michael@allwinnertech.com>,
	Xiaosen He <xiaosen.he@oss.qualcomm.com>
Subject: Re: [PATCH] sched: flush plug in schedule_preempt_disabled() to
 prevent deadlock
Message-ID: <20260512124021.GA2214256@noisy.programming.kicks-ass.net>
References: <20260512085939.1107372-1-tom.leiming@gmail.com>
 <20260512120431.GC1889694@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512120431.GC1889694@noisy.programming.kicks-ass.net>

On Tue, May 12, 2026 at 02:04:32PM +0200, Peter Zijlstra wrote:
> On Tue, May 12, 2026 at 04:59:39PM +0800, Ming Lei wrote:
> > On preemptible kernels, a deadlock can occur when a task with plugged IO
> > calls schedule_preempt_disabled():
> > 
> >   schedule_preempt_disabled()
> >     sched_preempt_enable_no_resched()  // preemption now enabled
> >     schedule()                         // <-- preemption can happen here
> >       sched_submit_work()
> >         blk_flush_plug()
> > 
> > After sched_preempt_enable_no_resched() re-enables preemption, the task
> > can be preempted (e.g., by a higher-priority RT task) before reaching
> > blk_flush_plug() in sched_submit_work(). Since the task's state is
> > already TASK_UNINTERRUPTIBLE (set by the mutex/rwsem slowpath caller),
> > requests in current->plug remain unflushed for an unbounded time.
> > 
> > If another task depends on those plugged requests to make progress (e.g.,
> > to release a lock the sleeping task needs), a deadlock results:
> > 
> >   - Task A (writeback worker): holds plugged IO, preempted before
> >     flushing, stuck on run queue behind higher-priority work
> >   - Task B: waiting for IO completion from Task A's plug, holds a lock
> >     that Task A needs to be woken up
> > 
> > Both reported deadlocks involve mutex/rwsem slowpaths, which are the
> > primary callers of schedule_preempt_disabled() with non-running task
> > state.
> > 
> > Fix by flushing the plug in schedule_preempt_disabled() while
> > preemption is still disabled. This ensures the plug is empty before the
> > preemption window opens.
> 
> How is this different from any path calling schedule()? That would be
> subject to exactly the same issue.
> 
> The patch cannot be correct.

Also, is there a reason io_schedule_prepare() has a blk_flush_plug()
call?

io_schedule()
  token = io_schedule_prepare()
    blk_flush_plug(current->plug, true);
  schedule()
    if (!task_is_running(tsk))
      sched_submit_work()
        blk_flush_plug(tsk->plug, true);

Why isn't the one in sched_submit_work() sufficient? This thing either
needs a comment justifying its existence, or get removed.
