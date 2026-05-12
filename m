Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DC73D5C22;
	Tue, 12 May 2026 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606198; cv=none; b=jG/2L03Cc6bbCtDc1kfE2BU69VCPVfDcnjjrO3JtY7wEx8m3VWf/7VZs0NVXPzxEJJPUN08RRBy5wfKvndVqUDgPsGkzC0WbIJY3AYbnAlSOSr31ccxvzOOpHIi4qSvFMk+8491CqjiuRVNf8yORYo5z0Sw54L5JIx5KR2P9Zyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606198; c=relaxed/simple;
	bh=sovKxckqx+iH72hRcc5csfej5CeG5ZSKNqU9k8oSiJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmVf1R9Vnjz/mQjLp59+Vo2+B5XvE7+/qbuIfyhaZcAO9/Hm4HvRAF3RpgBY5NgTiPU7Pdj556SvKudbnmXzVLycrLaeN0PzUC/EZVqRq1oB/WDgoGpPPiWvuEz1UeekFsNBkdWCXg0NG87Nhvk8n/yfVDXf99W25O/AuLVDDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnXfhBWa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnXfhBWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06ABC2BCB0;
	Tue, 12 May 2026 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778606198;
	bh=sovKxckqx+iH72hRcc5csfej5CeG5ZSKNqU9k8oSiJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BnXfhBWaYzmZo4ZmpnmM4muVrcQ6hHSYmS9y3rmqnS07eHna5XmJzhiqD6lqUNAij
	 w4yMTx+luO0zxPoxRteknmzH6i/8Y7OHQitCXRJVf55zig9ktWmFMEuEv9ZvSrhJQ7
	 jIWMX7y/vTH9gsqOlynr2QSGaDJy2Y/4VZFAzAp+N3dnrEFm77hSOxVx8G1yZ/PNTS
	 u30UmjawOxBGjkuq1cw63Lgy0FHs+kj7kogdivReme0A/LlapvHYlmqI1G32gXj7N/
	 GxafxYLYExtIXVXnV1RhPT5P8DZCQtkbvQDiKCSg93/q5u8G4WlqkEoT/bN9h/Jyty
	 Lx/54r481n0Zg==
Date: Tue, 12 May 2026 07:16:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Michael Wu <michael@allwinnertech.com>,
	Xiaosen He <xiaosen.he@oss.qualcomm.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH] sched: flush plug in schedule_preempt_disabled() to
 prevent deadlock
Message-ID: <agNgdIMacaG-41vj@slm.duckdns.org>
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

Hello, Ming.

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

My memory is hazy around io_schedule but the above reads really weird to me.
A task, regardless of its current state stays on the runqueue when
preempted, so the condition is temporary. As soon as the preempted task can
get CPU, it should unwind the situation. That's not a deadlock. Is the
problem that there can be preemption-induced delay in flushing the plugs?

Thanks.

-- 
tejun
