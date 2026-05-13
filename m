Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB8368D4E
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659728; cv=none; b=oTCJCdM7xxsQ593hABERIxD7Kl7lPwj3v2hH6Z5YVGpK0Z0MTcODXDeFPXqWiM6M98ADu46rDugXueH/tsbpVYkSc5/vxBi4h6+L8DllESaKqxFItO7paW8WZKbIogWRcvt9vctizI3kYcTEQqxQCLJEYzoX257jYjS+AT1R2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659728; c=relaxed/simple;
	bh=4btVtrjwZj+qvTMRZdaxsK35m7G7BWtAvytYXi/zXOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/QubUZkoySvgUII4viQ6t57gkOY3xt+gg5TM1NzHxbvmUp4LgmFCAEPeDpNq49mC+xlxyEd/CgRHMJsyJRp4Idx5BaRozhqQVFNupV76QYMZRNBTdqlU62qinSSFM6u84yqk4eV2BbUxX56Rz1lqCrCjEApBZQ/DEdUlbvsjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsWSX6j6; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsWSX6j6"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40423dbe98bso3263116fac.2
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 01:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778659726; x=1779264526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WLWC9LhEn5jAtEa1iuRPCWA08PAJdtUr0z7GULsP2M4=;
        b=lsWSX6j62SG7jYBAv+iuol8lXaCzjZ8dXvVrvBPPfl/zyBfD59HEAhL+idCvm2Sx68
         PQhdFCwruWnYHDRjyfnH7+G5PkS8nPUHdWAUfUIqpw2/vIcIUYtAnYiZMHgWt5WCaWUF
         Yma1fdRL6L0+vRS9k9ZsYYzbEDFfarlF02o7XrhQ7TXvf5PWDNs+XAzsMztiU/dRal+0
         PwSFhKDrCMNCO+YIqxC/DbpW8Ch1zQhJ/Fe8fuEOrCcomX7WgVBbsAjk4UdVjDDbVqqk
         l3o+Cw8Gf0cV5vGZUbOfeSP0LN5W2B4zMd476o/983tYb8IKm/LflFGQKYp3k+oqPX/P
         YpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778659726; x=1779264526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLWC9LhEn5jAtEa1iuRPCWA08PAJdtUr0z7GULsP2M4=;
        b=qxyMy2Q7jxph5as2ayYWdJSqVy9Xr/2pe+mFW+EmKZFj0jZS5sRLcFHiNQRzBKrqAU
         LFLpMLmna5vu+zPN2Bjl2M9rbmjOumwC96m9BbrhT6rm3ZrR8YeCHKSjbmTJptQ8xTzU
         0r6ti3OisL4UBKN1CroTh6S2Hwje8GdIzY55hhWhQZ88O49Fm3VnCLm5eLzAhKKZL46G
         M/ZQv2qf5GbFuXKyKhZAy724blRD+q3jMaCmdUNostkvMdFM9VUDbHDAX3oK0qCOHp0b
         op6KDnEukhNHhtLxTNfVLOuAUpIQdEJXNlU4aI4VLmAOIuvSEfAahYG6Hf1aU9i4+oid
         WZbg==
X-Forwarded-Encrypted: i=1; AFNElJ9t89gKQ8buTUXCpurfXVBxxDBUGdYV7SGVsWew8/WlNtZjd8nZD4oYfVjLVJowveHuJsLqGXIfO1RB2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzel73SHKIROwS/pYeyVgqPPTRSXdWvkBYGnw5HUr6P7IjB4MUu
	nULqOmNubKQ8cn/Bk5hpr2kRaQ+VeXqUAcyaFVA3o4u0lEcVCITt0X9Y
X-Gm-Gg: Acq92OFpTqc4unMMfMt2C/IGea7flWgQAfla3de2F2/UrXIVdSk9DiYS03wXZ4OVI5B
	3c3un3ejoWPXaq9NGjo90bZVNg+/avhn1BGwux+ayXJYNjG8m6SLJxHr5QxG45KGtTlIB542qpq
	byhp93E8h4QNjCeb0qor3M8W63+ZbKf/jd+3wHhs9e264x2oLNWJqizfdYp0VChUqRTxL4u+tEI
	UKMqXGqELR+wcizprE99q2QxyIanB9eRtxVt4U6xH8srGpfhHGGXPoTT2lCbW5PnW9zYXP0I15W
	JE0at/hayjJM8XwDXbIFUE2+L9JCBkAM7mqK1VbLkNXoTh5/nrNl3apAdGu6JjyMPdBXt1pSaiw
	PHfrq299IlzFnty05MSBqn+OjC297EKkY6+3aTkkMJvIovhl+7/Y5DfaeFSFqS8qtOClwzKe+kY
	lvzIVPLHDgSiSwkT3HgiP/uBD7H7DJCLmfk1n8FILRvIUke0qtPHMqct6UC3Fc5vBT64Vegujmc
	/fgLUAcWrWMszKfQt1RNw5TnP4kju0=
X-Received: by 2002:a05:6870:c101:b0:42f:af81:276d with SMTP id 586e51a60fabf-439ce4ceca8mr1236116fac.36.1778659725904;
        Wed, 13 May 2026 01:08:45 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355710cfccsm15347800fac.8.2026.05.13.01.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:08:45 -0700 (PDT)
Date: Wed, 13 May 2026 16:08:35 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Michael Wu <michael@allwinnertech.com>,
	Xiaosen He <xiaosen.he@oss.qualcomm.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH] sched: flush plug in schedule_preempt_disabled() to
 prevent deadlock
Message-ID: <agQxg-pBzF8rp1Ii@fedora>
References: <20260512085939.1107372-1-tom.leiming@gmail.com>
 <20260512120431.GC1889694@noisy.programming.kicks-ass.net>
 <20260512124021.GA2214256@noisy.programming.kicks-ass.net>
 <agNLCof3zO5-QAo9@fedora>
 <agNgdIMacaG-41vj@slm.duckdns.org>
 <agPcx_vuO3ZYbAy1@fedora>
 <20260513073039.GG1889694@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513073039.GG1889694@noisy.programming.kicks-ass.net>

On Wed, May 13, 2026 at 09:30:39AM +0200, Peter Zijlstra wrote:
> On Wed, May 13, 2026 at 10:07:03AM +0800, Ming Lei wrote:
> > On Tue, May 12, 2026 at 07:16:36AM -1000, Tejun Heo wrote:
> > > Hello, Ming.
> > > 
> > > On Tue, May 12, 2026 at 11:45:14PM +0800, Ming Lei wrote:
> > > > On Tue, May 12, 2026 at 02:40:21PM +0200, Peter Zijlstra wrote:
> > > > > On Tue, May 12, 2026 at 02:04:32PM +0200, Peter Zijlstra wrote:
> > > > > > On Tue, May 12, 2026 at 04:59:39PM +0800, Ming Lei wrote:
> > > > > > > On preemptible kernels, a deadlock can occur when a task with plugged IO
> > > > > > > calls schedule_preempt_disabled():
> > > > > > > 
> > > > > > >   schedule_preempt_disabled()
> > > > > > >     sched_preempt_enable_no_resched()  // preemption now enabled
> > > > > > >     schedule()                         // <-- preemption can happen here
> > > > > > >       sched_submit_work()
> > > > > > >         blk_flush_plug()
> > > > > > > 
> > > > > > > After sched_preempt_enable_no_resched() re-enables preemption, the task
> > > > > > > can be preempted (e.g., by a higher-priority RT task) before reaching
> > > > > > > blk_flush_plug() in sched_submit_work(). Since the task's state is
> > > > > > > already TASK_UNINTERRUPTIBLE (set by the mutex/rwsem slowpath caller),
> > > > > > > requests in current->plug remain unflushed for an unbounded time.
> > > > > > > 
> > > > > > > If another task depends on those plugged requests to make progress (e.g.,
> > > > > > > to release a lock the sleeping task needs), a deadlock results:
> > > > > > > 
> > > > > > >   - Task A (writeback worker): holds plugged IO, preempted before
> > > > > > >     flushing, stuck on run queue behind higher-priority work
> > > > > > >   - Task B: waiting for IO completion from Task A's plug, holds a lock
> > > > > > >     that Task A needs to be woken up
> > > 
> > > My memory is hazy around io_schedule but the above reads really weird to me.
> > > A task, regardless of its current state stays on the runqueue when
> > > preempted, so the condition is temporary. As soon as the preempted task can
> > > get CPU, it should unwind the situation. That's not a deadlock. Is the
> > > problem that there can be preemption-induced delay in flushing the plugs?
> > 
> > IMO, preempting a `!TASK_RUNNING` task can be thought as effective sleep,
> 
> No it cannot be. Preemption ignores task state.

Yeah, I get similar conclusion too with AI's assistance.

But both two reports show that the preempted task aren't switched back for
long enough time, can you share any idea for Michael & Xiaosen to investigate
further from scheduler side?

https://lore.kernel.org/linux-block/20260417082744.30124-1-michael@allwinnertech.com/

https://lore.kernel.org/linux-block/5660795d-87de-46f5-add4-7729a02225ef@oss.qualcomm.com/


Thanks,
Ming
