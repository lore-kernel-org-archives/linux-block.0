Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731743C818B;
	Tue, 12 May 2026 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604601; cv=none; b=J/VCZYVjVtu9Y+iPolSC6lJsMl8yD2avdPpEy/iFBN6X8kO6Xrg3AxG94/12NfzvLDW5AGRrknndgPBMFUJF3Cjt2RaaQpuKpTvPfoeYLSwQX5+ibCWCEscSMtHgH75sFzjLAPPbqqTPW95wWMAJDkiTnfXUFmcq/inD2R/+Jgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604601; c=relaxed/simple;
	bh=1VybkO1ey9HUBChnRAl/Wfnbfvc5CTmA9VlPmoVrCtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+PmSIko0Ch3IzEznG8Dzahv0Y/wKfIrqk51Dvk2R9cvJ6CZAESUXLX2qPR+nHQlFafE2I3Jt+2orEirwVq1ZQCED4R/o0WWahykwDLvLsIPgGlVTwph40qG9Jr9tVqZ4O803DIzHZ9FH12fl2K56YMjaaaq4cCbX1YZrTHwDCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ak2J/HiL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ak2J/HiL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6dNhPeJ3jvn+PTHt7mnSPCUGdsfKMzmZfQJid2iPVI0=; b=Ak2J/HiLHKyTmY+aeHFL/KiUQV
	rjbkNbwmdAeK2UyK8je84KSMJLLkQYFKOcKj5x/GU7Zd4KbufBAMFnCX2PnqCAHh7a4CKgUbRo3IN
	PVtPHbDr2IEMGEYGVgbjDvM96y11N7WjIioVhZkS0BlectShidHfCywKD9/gAX8zJ/1cUWpCyFwh3
	vzgJQUxyzPKY21aAETW0Ou5NNmTqseqkpEeSvwIxN9slxh340CDU0AekVj3b0GginnIf03kkeQE1H
	6k4aqacF0aDV3KzLbfFYvVm3H/Ji1eOTqKEAlWBghylyhpzb1XzBJIO0+Z8YM8E8vXESKQGsNIRt6
	tOCO9OtQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMqIm-0000000FOd7-3y3P;
	Tue, 12 May 2026 16:49:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9102B3013A0; Tue, 12 May 2026 18:49:47 +0200 (CEST)
Date: Tue, 12 May 2026 18:49:47 +0200
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
Message-ID: <20260512164947.GA2677887@noisy.programming.kicks-ass.net>
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

> > io_schedule()
> >   token = io_schedule_prepare()
> >     blk_flush_plug(current->plug, true);
> >   schedule()
> >     if (!task_is_running(tsk))
> >       sched_submit_work()
> >         blk_flush_plug(tsk->plug, true);
> > 
> > Why isn't the one in sched_submit_work() sufficient? This thing either
> > needs a comment justifying its existence, or get removed.

> If io_schedule_prepare() can be called in every iowait context, looks
> blk_flush_plug() from sched_submit_work() may be removed.

No, the other way around. I don't see the point of having the one in
io_schedule_prepare(), since we'll hit the one in sched_submit_work().

