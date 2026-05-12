Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB91D2F12DA;
	Tue, 12 May 2026 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587483; cv=none; b=rs2vLb4LLTlRyBNBuVrIOXLC9jqRGQtgLHeD8Hyt1Jp8ypxPtZxBCz8xkGFP5kF++M0/DiP53VXE0tyaOlXNNfqQ87TxNyy82/jiW01pKimWp1/pALU60QOmnOFrZFymXDMrHGh03+KjB5yMOrMng027yAkGNccbXAmiKi0qXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587483; c=relaxed/simple;
	bh=4V43S6Dj0iZy2lMXEaOFqXdpJsj1QL0+DKe1V9xS89w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeeT1A79TS/H9CfJnmY+mJnLedPDaL1F2EasxIteYKKVC6o7J/8iZwQMLS9Nj2TdWpEniIPw14DxS2JbpLvTYw20UctujgIAqJmpiUGKm4DG43vtpD0lEp4kXFnicIs8ZLe+4jaguXEqB4JQeyXk6GLhm6qzjcRYRqRifiCBrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YNZ7oVyI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YNZ7oVyI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BzSQcLPIQ3AfygSkxes+P0fY0tOS1ixZrgeVnP+FvGI=; b=YNZ7oVyINV9lrqvCEAEOYgyx4U
	fdy8FxZX4ma6ZaGCDZSrikaF12tlPZCNoYlVV6I7nzmXZMOEl0kN5nmNeDMcTTqUg8FmzzLMpR+vJ
	6lW/Dy0vEJy16K3DAE+AzR+2GbvBVK/AKMcO0v1nFM+eQsLZ+LmlAW2T62cJC2xdJsxCEKetx42NH
	1efgE+Lpy2iWBR6q2YNzdsR3L/1Pcisq5TtmXkZFE3K/WLrlmwNnWcW60hjJSMuuBkjrRQ9iVwqLh
	Xg6Oq6vVIgwOUF/KC9p9ThqROB2tKt8IqIBa0Po6IC6YzAGuDMx4QLzXjQy58ohZJMe6A94kecn5n
	leS5Y5Iw==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMlqj-00000009hpL-34LK;
	Tue, 12 May 2026 12:04:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F2C6830075A; Tue, 12 May 2026 14:04:31 +0200 (CEST)
Date: Tue, 12 May 2026 14:04:31 +0200
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
Message-ID: <20260512120431.GC1889694@noisy.programming.kicks-ass.net>
References: <20260512085939.1107372-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512085939.1107372-1-tom.leiming@gmail.com>

On Tue, May 12, 2026 at 04:59:39PM +0800, Ming Lei wrote:
> On preemptible kernels, a deadlock can occur when a task with plugged IO
> calls schedule_preempt_disabled():
> 
>   schedule_preempt_disabled()
>     sched_preempt_enable_no_resched()  // preemption now enabled
>     schedule()                         // <-- preemption can happen here
>       sched_submit_work()
>         blk_flush_plug()
> 
> After sched_preempt_enable_no_resched() re-enables preemption, the task
> can be preempted (e.g., by a higher-priority RT task) before reaching
> blk_flush_plug() in sched_submit_work(). Since the task's state is
> already TASK_UNINTERRUPTIBLE (set by the mutex/rwsem slowpath caller),
> requests in current->plug remain unflushed for an unbounded time.
> 
> If another task depends on those plugged requests to make progress (e.g.,
> to release a lock the sleeping task needs), a deadlock results:
> 
>   - Task A (writeback worker): holds plugged IO, preempted before
>     flushing, stuck on run queue behind higher-priority work
>   - Task B: waiting for IO completion from Task A's plug, holds a lock
>     that Task A needs to be woken up
> 
> Both reported deadlocks involve mutex/rwsem slowpaths, which are the
> primary callers of schedule_preempt_disabled() with non-running task
> state.
> 
> Fix by flushing the plug in schedule_preempt_disabled() while
> preemption is still disabled. This ensures the plug is empty before the
> preemption window opens.

How is this different from any path calling schedule()? That would be
subject to exactly the same issue.

The patch cannot be correct.
