Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E1F385516
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 02:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638034; cv=none; b=bi2nfIAbLVLbJg4OLgsZN6mTaIzJkOgJsrbsH48U3emIMZsykSnC3C2xVquP3opHYqr2roSAYdCRdBmpa2oeV7nASuY/9xj1Q5+Vo/FB5JxkPrVtki4MIOrDld2rASXEZwR8uF2n/At1v9KqjM5cFnz02AZ7Fg+VLvR2616rkKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638034; c=relaxed/simple;
	bh=jprJhpld/Mk2XlinAxM/3WSlkZ8NEDLsKiq2VYww0aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLDmX09sofWerd2Y9ogDYf+PRsu6fDKiLSpRT44wDvn7Hg50Hc9t+uKhZYLxP4PPkTJJiTe7r5j+LX5akOG0P6lHtEHbOXCiqv1AAj+xt7XwR+MvE4T7wm5rOxi6Z0tkGmBsQCRSDL0bv+baiKxO9iDZpbP82L2SWjJXIjK06OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9Hh1Kwf; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9Hh1Kwf"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d1872504cbso5678020a34.0
        for <linux-block@vger.kernel.org>; Tue, 12 May 2026 19:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778638031; x=1779242831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IDZwW21tBDiD5Djz5iGheLqVcuwXEHQGYpEEmxE1AJg=;
        b=C9Hh1KwfdEwYkCMIyNLCbwljqF1Oe6k8WDlgXOv7O/9JqQ6XGcSsxnwDh+7ZofW9NA
         9INKffq5I6e5JZWr1FpSx014U5U1O0AnP0UPjgaiM+gZXb2uhwGxLW/sA0/e63M21Q5B
         /C4+lrLdyqwi5JAga7VM2/+LHrLSn48vn4OZ9GwcDbET6YYSFFP6hZ0a2SnFaEntMd9V
         5pobnY+/ziG80d3DfG+fLXowsQrdGyJOuSKej9ZdU9rWVJIz8jLk4Y3sMpMbFZuT/CqV
         hqoeFsCh8KhbMlpAE7R5yQRffUfYfBEFzsQ5GWYVKpj3G2tltAdyImfk+I4eqoSZLL1S
         NuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778638031; x=1779242831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDZwW21tBDiD5Djz5iGheLqVcuwXEHQGYpEEmxE1AJg=;
        b=ew1dMVGlsNbhsya0c4lYQQa8jOgl+xZmf6SdAs1oYADFVtDg88ILhhYstcltmIiM4q
         P7Y1XG7x+SUjP0vPFiGoy8AE2sM2lnJtrHmc4fLrP2J++7lQ3ayTZFq4+EYPwfQP6iPn
         jsLChM5z2q26GRN+saOu9FPK0Pfk1rIkwAhHer8b0FAracAp75ePjZ9jipjuKynYHNcx
         KUdc/nkE9IsZ2D1NT+wSDkUHp97g7qPLKcLMczYjqhCPuH36c7i6BGg4cOVwSGmemD6w
         P/ek1GvoUeU2Krz+YsMRS3VH6ESitdr0Pnt7UUWKTrLVbpl6O0uprSHzrGKl9KH5iZIR
         oRYw==
X-Forwarded-Encrypted: i=1; AFNElJ+1xOT20DoBvOCI5QHAhm9hhbfMQvSf374V6hFXGRHeneCKmLSELV0njBDxD12rNJKjwwtoGe9XVGQLNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhhV+zqBs8U4IQ91h/4otP4NOaTWzNeoOap2ApzWYPSb07Q4Ar
	t+OXiR8KY19gt/12FLzSARZ1Is9edb1uKazkS/hrTH+Gtzd85GZFu8Wu17tht5EV0OA=
X-Gm-Gg: Acq92OEQm5YRCRbIFrTZ3k1khetszaDVwIC2+gpxzyBv2nWSm3FByBg0mxi+ZOSHllk
	1mada1kC3Xjgj65/UVYrZXWYR6lGSgTYhmNHHaiTwTzDNMTD24NJ5WfOD3Fz0zdNyS6ficXvctM
	WfPIZwdLiGG1ZG9iDaUFpGhr9bdmMX9necb9Jz0bw5mQeHmjaXy+orfDU1jYv1JCzfkk3WJ/tqT
	9Mjwcww45u9FxP2SwrJUeYJAh7XNR2sCXDkQVIOAQ6TDlyU0VqiTU5VMeYrAdEmTZtooEgp0nED
	NugAs2jyRY/OBHsZPkY82gApGy3Rc8/Lf2kRxQomjivwR5ViII5aO2tdj8TboWM639omID7A6GO
	gd5XeU0QVFmNuZ+6jS42fVVjrM1hUggQ57yp6iglRYt+iXIX9YG2LHnOb8G5sIlD2fvBMWUFiWv
	V1eBr22pqGj15UqrOUPSx20YXPm5kCdnO61JUEHg3jx40ockMzAnnK5VSpUJmLb6pUP2S18c2mF
	Jh1iASany/AS1dLqqi+oNlQKW4umD0=
X-Received: by 2002:a05:6830:6484:b0:7dc:a51c:9197 with SMTP id 46e09a7af769-7e3d885bdaamr873084a34.7.1778638031241;
        Tue, 12 May 2026 19:07:11 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367c05393sm10616856a34.9.2026.05.12.19.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 19:07:10 -0700 (PDT)
Date: Wed, 13 May 2026 10:07:03 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Michael Wu <michael@allwinnertech.com>,
	Xiaosen He <xiaosen.he@oss.qualcomm.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH] sched: flush plug in schedule_preempt_disabled() to
 prevent deadlock
Message-ID: <agPcx_vuO3ZYbAy1@fedora>
References: <20260512085939.1107372-1-tom.leiming@gmail.com>
 <20260512120431.GC1889694@noisy.programming.kicks-ass.net>
 <20260512124021.GA2214256@noisy.programming.kicks-ass.net>
 <agNLCof3zO5-QAo9@fedora>
 <agNgdIMacaG-41vj@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agNgdIMacaG-41vj@slm.duckdns.org>

On Tue, May 12, 2026 at 07:16:36AM -1000, Tejun Heo wrote:
> Hello, Ming.
> 
> On Tue, May 12, 2026 at 11:45:14PM +0800, Ming Lei wrote:
> > On Tue, May 12, 2026 at 02:40:21PM +0200, Peter Zijlstra wrote:
> > > On Tue, May 12, 2026 at 02:04:32PM +0200, Peter Zijlstra wrote:
> > > > On Tue, May 12, 2026 at 04:59:39PM +0800, Ming Lei wrote:
> > > > > On preemptible kernels, a deadlock can occur when a task with plugged IO
> > > > > calls schedule_preempt_disabled():
> > > > > 
> > > > >   schedule_preempt_disabled()
> > > > >     sched_preempt_enable_no_resched()  // preemption now enabled
> > > > >     schedule()                         // <-- preemption can happen here
> > > > >       sched_submit_work()
> > > > >         blk_flush_plug()
> > > > > 
> > > > > After sched_preempt_enable_no_resched() re-enables preemption, the task
> > > > > can be preempted (e.g., by a higher-priority RT task) before reaching
> > > > > blk_flush_plug() in sched_submit_work(). Since the task's state is
> > > > > already TASK_UNINTERRUPTIBLE (set by the mutex/rwsem slowpath caller),
> > > > > requests in current->plug remain unflushed for an unbounded time.
> > > > > 
> > > > > If another task depends on those plugged requests to make progress (e.g.,
> > > > > to release a lock the sleeping task needs), a deadlock results:
> > > > > 
> > > > >   - Task A (writeback worker): holds plugged IO, preempted before
> > > > >     flushing, stuck on run queue behind higher-priority work
> > > > >   - Task B: waiting for IO completion from Task A's plug, holds a lock
> > > > >     that Task A needs to be woken up
> 
> My memory is hazy around io_schedule but the above reads really weird to me.
> A task, regardless of its current state stays on the runqueue when
> preempted, so the condition is temporary. As soon as the preempted task can
> get CPU, it should unwind the situation. That's not a deadlock. Is the
> problem that there can be preemption-induced delay in flushing the plugs?

IMO, preempting a `!TASK_RUNNING` task can be thought as effective sleep,
however block layer plug list isn't flushed before this 'sleep', which is
absolutely fragile to cause deadlock.


Thanks,
Ming
