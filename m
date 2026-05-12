Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09B83C585A;
	Tue, 12 May 2026 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604796; cv=none; b=pXhbhkkBFzhGVAeTK5IHCMcO2q9wmYCLR+D9WqsA9COBX9Zr83agoPTJFdJxxOJgN0efSyjR8Y7bwlK5xBNKKEsYI+obfh1cMK/5G6CgqFNph4oR3BmMt6/0xroRwCpZqNnZ6PmkQUnoce0vG63iQT+RZZG+Nojw5zSz3NN+HuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604796; c=relaxed/simple;
	bh=H51awmjchn3ktm1kEw3yzsvYYjYeUcUygf/vtUrpzGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jn1mh+KY9O5ONxMCWwh0RhpFY31cWXaGIL1orb1DURkq9c3GwoQhGqet9p9G910kXYaBIZH1BTKTgotT1P2I7K7kpjOYxmu73QJdcbVayb2PRL3PwUtdX9zY9EXglznC9NXX/GQEzafJsIAz861+o5f2KFATpGMDXIjIrpRoc70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NH3uMjJ5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NH3uMjJ5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cp8Ov3Km4p0cgJ79n5HhDt4ZPrXGNqNCqzbE5ZqPAk0=; b=NH3uMjJ5Z0O7U3S6diofk/1sOJ
	etdgyE5oFamij5asCZ5NNOFE/i4fNgIxKEGX0vxJdgUlOs3UNRMRHg0+fEfgzSYqM8MJ2ACX1bRT0
	xshoKVxgOQ+hNywQ4RkniJCXox3/U8Q+dicE5Fx9u08HAz/9HYuSCFvqo8nEERrjoab1yHvA8MzhJ
	I2/KAqWQoRvdUlSGYpalCUTfIpd7WfjRDDF+CNVfJDXtgmlKXya6UlpsYDk+IO5CbmS7QqyFE+LXg
	zl2MXY1osN9tD7XDa5Un+xSVePqcx9IHHH3GqNVm8iCqPGPz1vINfH+DVcEqvCPjP63TWHE8a/Zoo
	W2afC0Og==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMqLz-0000000FPDC-3we8;
	Tue, 12 May 2026 16:53:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2E2D4302F8E; Tue, 12 May 2026 18:53:07 +0200 (CEST)
Date: Tue, 12 May 2026 18:53:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Michael Wu <michael@allwinnertech.com>,
	Xiaosen He <xiaosen.he@oss.qualcomm.com>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH] sched: flush plug in schedule_preempt_disabled() to
 prevent deadlock
Message-ID: <20260512165306.GB2677887@noisy.programming.kicks-ass.net>
References: <20260512085939.1107372-1-tom.leiming@gmail.com>
 <20260512120431.GC1889694@noisy.programming.kicks-ass.net>
 <20260512124021.GA2214256@noisy.programming.kicks-ass.net>
 <agNLCof3zO5-QAo9@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agNLCof3zO5-QAo9@fedora>

On Tue, May 12, 2026 at 11:45:14PM +0800, Ming Lei wrote:
> On Tue, May 12, 2026 at 02:40:21PM +0200, Peter Zijlstra wrote:
> > On Tue, May 12, 2026 at 02:04:32PM +0200, Peter Zijlstra wrote:
> > > On Tue, May 12, 2026 at 04:59:39PM +0800, Ming Lei wrote:
> > > > On preemptible kernels, a deadlock can occur when a task with plugged IO
> > > > calls schedule_preempt_disabled():
> > > > 
> > > >   schedule_preempt_disabled()
> > > >     sched_preempt_enable_no_resched()  // preemption now enabled
> > > >     schedule()                         // <-- preemption can happen here
> > > >       sched_submit_work()
> > > >         blk_flush_plug()
> > > > 
> > > > After sched_preempt_enable_no_resched() re-enables preemption, the task
> > > > can be preempted (e.g., by a higher-priority RT task) before reaching
> > > > blk_flush_plug() in sched_submit_work(). Since the task's state is
> > > > already TASK_UNINTERRUPTIBLE (set by the mutex/rwsem slowpath caller),
> > > > requests in current->plug remain unflushed for an unbounded time.
> > > > 
> > > > If another task depends on those plugged requests to make progress (e.g.,
> > > > to release a lock the sleeping task needs), a deadlock results:
> > > > 
> > > >   - Task A (writeback worker): holds plugged IO, preempted before
> > > >     flushing, stuck on run queue behind higher-priority work
> > > >   - Task B: waiting for IO completion from Task A's plug, holds a lock
> > > >     that Task A needs to be woken up
> > > > 
> > > > Both reported deadlocks involve mutex/rwsem slowpaths, which are the
> > > > primary callers of schedule_preempt_disabled() with non-running task
> > > > state.
> > > > 
> > > > Fix by flushing the plug in schedule_preempt_disabled() while
> > > > preemption is still disabled. This ensures the plug is empty before the
> > > > preemption window opens.
> > > 
> > > How is this different from any path calling schedule()? That would be
> > > subject to exactly the same issue.
> > > 
> > > The patch cannot be correct.
> > 
> > Also, is there a reason io_schedule_prepare() has a blk_flush_plug()
> > call?
> 
> It is added in Tejun's "[PATCHSET RFC] sched, jbd2: mark sleeps on journal->j_checkpoint_mutex as iowait":
> 
> https://lore.kernel.org/all/1477673892-28940-1-git-send-email-tj@kernel.org/#t
> 
> which fixes iowait accounting for ext4, meantime adds the model
> "io_schedule_prepare() + schedule() + io_schedule_finish()", which actually
> can avoid this kind issue easily because io_schedule_prepare() is called
> in task running state.
> 
> For this f2fs issue, maybe it can be addressed by adding rwsem io variant
> just like mutex_lock_io(), meantime iowait accounting is covered too.

So personally I detest all of iowait, its an abomination. And I don't
see how having an iowait specific version avoids any problem.

You can get preempted at any point before between getting the io started
and blocking.
