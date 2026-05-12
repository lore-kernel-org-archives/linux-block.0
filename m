Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E543C5849
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600726; cv=none; b=Iq71Zx2u+tHUJREx3yiAF5va/GqN4jxbqSKANTAmNlN8DQSQzwLvunn1Qo2AtFPkLbxVRcqIG1tKgVSns/Nm0N9Wpx2q5jN9kjZiSJraPcBe63n/XpqxAb/TLwntuUNxa1tjTMezrQKJesEdr5v1/oli5777nS2t1xfkwPRTfZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600726; c=relaxed/simple;
	bh=0VqlMifA9WfgtGvIY7oa1hJjCcmJdHVbFplw7GNQXjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EurZHPz7tAOyCFE+SAl08cFBTRLre9ITYq/kniVCRFKAkW3H4yaUCNOOfnNArQqgzvpgLVSWF6J/45zwxNvJkUer9GT5AjLMctFCtXAWfOZJlMZemgoEGroUUIRBUGEwZR3BtTswq5vybNZ+SsMPEDDm6iOctY7DRnxBV8La6kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9F+0o/K; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9F+0o/K"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d1872504cbso5208188a34.0
        for <linux-block@vger.kernel.org>; Tue, 12 May 2026 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778600723; x=1779205523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OodPr8B22yRreAu513frxaApOkBgnO2v0gw1uJXccro=;
        b=m9F+0o/KTa7NMhxe6rnZewq5xrhtn6vdNtHzPkv16Y1unf+y9Xzxhb6NicxBgWeXds
         qv37erLRy7x7KGHfDIZVBTEUniC8mD9tamFLyhEJlzDrwBnu4LwgMSRrBv2bYTgbGc/r
         7HWjRQ0CHoMr/EKuNtt4H/P0+lgx7qzk/AdC42UNxe/+caOk/wesfCFtr6tfxKNMKNHw
         abBE58n2rp6KWAUVKtv2GaksktEoE9jWGbUjRdYVYylB+2KFog/DldEw8cvti8EpuKxI
         EEADAOQ1q7sNC+7e2EanWcLSIwMZXlXvVfCapFhH68e/48p2Si/YnjGl6hwHUBjWDmT3
         tnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600723; x=1779205523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OodPr8B22yRreAu513frxaApOkBgnO2v0gw1uJXccro=;
        b=gBBlNyeZK9efK2OoH+Wmb6uXnO3zDlZrZTZN5JLzhVU3xugqaONn5eDYrLn5NOhCX5
         2CixfB/1YmkTQ2tpJm8TN+eQCHP9q2h0u4Yl0ceF9mXobKhcXLRbaUVzoV39hFI9Cc4y
         HNiTNoGIZiHzZqScw9a2ZZDiIQ7uB6ZmJo+/Yg+zJ5n8b1Lq9lJ0ymMJzsh9UQ93Byl3
         sSSLHl0aB012agSpdksxojt33N+cwKc3aS0ILZlLAweS9VAi564EcCc7zhkjlkdWvRea
         6HIlb1riTt9Is6CYL8HmtA1YwKHhKBZZ6KZ7nO5Hpd2rLZLCTFtDYzejGv0aOM5KTInt
         7xsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OAxDH6NUOGXQ+eAWPRSrhHluGlG5rBllkAkIYgtfAY9UIN8WDDsntAc6RbE2zp5YaZyE2/yXytnStXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzigFC4z0HSrQqgZWXsjiSGCXQj9X+IFrzbr5AIusaJzJupCN9T
	3O9Ym+Xb4Uy2Z4o7tivglU0MgApkXcge1zRaJ6Ig3Lr109K5O50F82gz
X-Gm-Gg: Acq92OF+iki/5f1QOc1Sr70TkikDYbp15iB6uxD2Bd1HBEeWO4T9rKSzNZP6rAuoF1j
	pwM6wWD0x833G6Nshfir0Ia1ceU8ns3JR5CP1/dXZR7TABoeQZkv3j+t4MjKlk7V59cBkwgURNR
	6hWpOXd+o4b0t8Pzs+vQ+hskgqu9E6rrLiJPLxXIgVhIm5/ePSBEX39VSyHvVQjRhKAOAAI0oGn
	WiCc+EfGSCs6HF2yuhdfnA/N/9HPPRdS3Oh6Bxksv7jHiEmDOyasD50XLSIFye6R6ZYdDr5gRc1
	45pYX9uOdQvuFxpA6o0K0aMX+5ZhwqUaDwOrz1TxeO3XF2ZTXKBBDYFLfsaT7zAytFcP/oCZ7jf
	iqgQWaJ2quv7FSIwSZtlc8Xo1/sMyCY5wgL52t9kxV7hSuAzj0aSy2HkhZ7mRbn4P12kSAx4NOI
	3IhsuVYakhpnb/wDRn8BLryiJzGo6ehRJcZpjgVQPCA7PotmljfY3KpqM6ewscdGq9xePchIH2t
	Wcm6REwp3Z/zLmS9nUH
X-Received: by 2002:a9d:799a:0:b0:7dc:e2ae:c15c with SMTP id 46e09a7af769-7e3bd35333fmr1627765a34.16.1778600723396;
        Tue, 12 May 2026 08:45:23 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d9d788sm8910606a34.24.2026.05.12.08.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:45:22 -0700 (PDT)
Date: Tue, 12 May 2026 23:45:14 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Michael Wu <michael@allwinnertech.com>,
	Xiaosen He <xiaosen.he@oss.qualcomm.com>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH] sched: flush plug in schedule_preempt_disabled() to
 prevent deadlock
Message-ID: <agNLCof3zO5-QAo9@fedora>
References: <20260512085939.1107372-1-tom.leiming@gmail.com>
 <20260512120431.GC1889694@noisy.programming.kicks-ass.net>
 <20260512124021.GA2214256@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512124021.GA2214256@noisy.programming.kicks-ass.net>

On Tue, May 12, 2026 at 02:40:21PM +0200, Peter Zijlstra wrote:
> On Tue, May 12, 2026 at 02:04:32PM +0200, Peter Zijlstra wrote:
> > On Tue, May 12, 2026 at 04:59:39PM +0800, Ming Lei wrote:
> > > On preemptible kernels, a deadlock can occur when a task with plugged IO
> > > calls schedule_preempt_disabled():
> > > 
> > >   schedule_preempt_disabled()
> > >     sched_preempt_enable_no_resched()  // preemption now enabled
> > >     schedule()                         // <-- preemption can happen here
> > >       sched_submit_work()
> > >         blk_flush_plug()
> > > 
> > > After sched_preempt_enable_no_resched() re-enables preemption, the task
> > > can be preempted (e.g., by a higher-priority RT task) before reaching
> > > blk_flush_plug() in sched_submit_work(). Since the task's state is
> > > already TASK_UNINTERRUPTIBLE (set by the mutex/rwsem slowpath caller),
> > > requests in current->plug remain unflushed for an unbounded time.
> > > 
> > > If another task depends on those plugged requests to make progress (e.g.,
> > > to release a lock the sleeping task needs), a deadlock results:
> > > 
> > >   - Task A (writeback worker): holds plugged IO, preempted before
> > >     flushing, stuck on run queue behind higher-priority work
> > >   - Task B: waiting for IO completion from Task A's plug, holds a lock
> > >     that Task A needs to be woken up
> > > 
> > > Both reported deadlocks involve mutex/rwsem slowpaths, which are the
> > > primary callers of schedule_preempt_disabled() with non-running task
> > > state.
> > > 
> > > Fix by flushing the plug in schedule_preempt_disabled() while
> > > preemption is still disabled. This ensures the plug is empty before the
> > > preemption window opens.
> > 
> > How is this different from any path calling schedule()? That would be
> > subject to exactly the same issue.
> > 
> > The patch cannot be correct.
> 
> Also, is there a reason io_schedule_prepare() has a blk_flush_plug()
> call?

It is added in Tejun's "[PATCHSET RFC] sched, jbd2: mark sleeps on journal->j_checkpoint_mutex as iowait":

https://lore.kernel.org/all/1477673892-28940-1-git-send-email-tj@kernel.org/#t

which fixes iowait accounting for ext4, meantime adds the model
"io_schedule_prepare() + schedule() + io_schedule_finish()", which actually
can avoid this kind issue easily because io_schedule_prepare() is called
in task running state.

For this f2fs issue, maybe it can be addressed by adding rwsem io variant
just like mutex_lock_io(), meantime iowait accounting is covered too.

> io_schedule()
>   token = io_schedule_prepare()
>     blk_flush_plug(current->plug, true);
>   schedule()
>     if (!task_is_running(tsk))
>       sched_submit_work()
>         blk_flush_plug(tsk->plug, true);
> 
> Why isn't the one in sched_submit_work() sufficient? This thing either
> needs a comment justifying its existence, or get removed.

This plug is originally added in 73c101011926 "block: initial patch for
on-stack per-task plugging") and commit a237c1c5bc5d "block: let io_schedule()
flush the plug inline" by Jens, when there isn't such preempt issue.

But it is moved out to sched_submit_work() latter in commit 9c40cef2b799
"sched: Move blk_schedule_flush_plug() out of __schedule()") by Thomas
Gleixner, when this issue starts to become likely.

If io_schedule_prepare() can be called in every iowait context, looks
blk_flush_plug() from sched_submit_work() may be removed.


Thanks,
Ming
