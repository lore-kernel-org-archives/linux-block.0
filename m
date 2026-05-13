Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612B93D4104;
	Wed, 13 May 2026 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657453; cv=none; b=HvBwVsW5FnqDvvU01v7BPT9h7w7FOl2OfPsNuOhy/Vdw1fq249+NQv9BDXKrkpcAXsGpMNrGV/TMSEtT96QHzQ+I/ZFO3eBFo6C06tPCi6XOf911jRI32bWjZSmp1RRGoNlXaJXSHwpnyJap38/8H5BlbiKp6KLwKF/M1pp63/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657453; c=relaxed/simple;
	bh=sHHEeh1NuYMOz39RVPhutDH2Th9ic/7cN/3pcanDWmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmdcHCLH5VDQEOFav6VXXR/QuOLaHwru8Uzbm8yp/m4kB0JRqLKhh8Y4zf3wv45R+aY2nY7Wtpn2LkPZAppS3CyjFR4CXHeSRf92EKVhZaY1hou9xzGJOZmZ9hszusYmotJBD9ELpMSFXh2puGSZ2//fb4Asc83Xx+jG/JzPghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rcdWXIhS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rcdWXIhS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xjQFRjkezZkTmlB/Y0Z7GgDrnew9T0juWzyuh6esmBg=; b=rcdWXIhSkdPyqAO/JOilkcxQL5
	j15FRKghCnH+zODAYkLqH2kROWCekZw6qnD+f0g2fd5SJXr8bl+o3lqQsE/K9O3ckcwRsOqd4j2ln
	MU1xrKUfvq3mkSS1D4ehfVl3vZCST7vd4ghJX5oeTnXDbwZqJBH0wHbmwOjVWbRJOcmzdoX97qyAg
	H5hjv2puTQ86o7kwEm7ix6oEXaOMG9+4uRFJFS1NPDGWIRbOnsn3HpSQKIoIyjEaayjQDP5zLsFsG
	oHfxUnHFvkM30Sfr7fPeq1jYx6r38W+pqYBid63ith0mPBQALb/ENdXOw7N7NPsDFvFvZtubMl+6Y
	hgML444w==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN43E-0000000GllF-0oEf;
	Wed, 13 May 2026 07:30:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 021AA300B8A; Wed, 13 May 2026 09:30:40 +0200 (CEST)
Date: Wed, 13 May 2026 09:30:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Michael Wu <michael@allwinnertech.com>,
	Xiaosen He <xiaosen.he@oss.qualcomm.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH] sched: flush plug in schedule_preempt_disabled() to
 prevent deadlock
Message-ID: <20260513073039.GG1889694@noisy.programming.kicks-ass.net>
References: <20260512085939.1107372-1-tom.leiming@gmail.com>
 <20260512120431.GC1889694@noisy.programming.kicks-ass.net>
 <20260512124021.GA2214256@noisy.programming.kicks-ass.net>
 <agNLCof3zO5-QAo9@fedora>
 <agNgdIMacaG-41vj@slm.duckdns.org>
 <agPcx_vuO3ZYbAy1@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agPcx_vuO3ZYbAy1@fedora>

On Wed, May 13, 2026 at 10:07:03AM +0800, Ming Lei wrote:
> On Tue, May 12, 2026 at 07:16:36AM -1000, Tejun Heo wrote:
> > Hello, Ming.
> > 
> > On Tue, May 12, 2026 at 11:45:14PM +0800, Ming Lei wrote:
> > > On Tue, May 12, 2026 at 02:40:21PM +0200, Peter Zijlstra wrote:
> > > > On Tue, May 12, 2026 at 02:04:32PM +0200, Peter Zijlstra wrote:
> > > > > On Tue, May 12, 2026 at 04:59:39PM +0800, Ming Lei wrote:
> > > > > > On preemptible kernels, a deadlock can occur when a task with plugged IO
> > > > > > calls schedule_preempt_disabled():
> > > > > > 
> > > > > >   schedule_preempt_disabled()
> > > > > >     sched_preempt_enable_no_resched()  // preemption now enabled
> > > > > >     schedule()                         // <-- preemption can happen here
> > > > > >       sched_submit_work()
> > > > > >         blk_flush_plug()
> > > > > > 
> > > > > > After sched_preempt_enable_no_resched() re-enables preemption, the task
> > > > > > can be preempted (e.g., by a higher-priority RT task) before reaching
> > > > > > blk_flush_plug() in sched_submit_work(). Since the task's state is
> > > > > > already TASK_UNINTERRUPTIBLE (set by the mutex/rwsem slowpath caller),
> > > > > > requests in current->plug remain unflushed for an unbounded time.
> > > > > > 
> > > > > > If another task depends on those plugged requests to make progress (e.g.,
> > > > > > to release a lock the sleeping task needs), a deadlock results:
> > > > > > 
> > > > > >   - Task A (writeback worker): holds plugged IO, preempted before
> > > > > >     flushing, stuck on run queue behind higher-priority work
> > > > > >   - Task B: waiting for IO completion from Task A's plug, holds a lock
> > > > > >     that Task A needs to be woken up
> > 
> > My memory is hazy around io_schedule but the above reads really weird to me.
> > A task, regardless of its current state stays on the runqueue when
> > preempted, so the condition is temporary. As soon as the preempted task can
> > get CPU, it should unwind the situation. That's not a deadlock. Is the
> > problem that there can be preemption-induced delay in flushing the plugs?
> 
> IMO, preempting a `!TASK_RUNNING` task can be thought as effective sleep,

No it cannot be. Preemption ignores task state.
