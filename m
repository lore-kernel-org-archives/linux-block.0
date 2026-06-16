Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C084657FD;
	Tue, 16 Jun 2026 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628899; cv=none; b=bE7HrD6Ehz3DwZrkjgtOjK3eWgOlXZx2Wz9ljOP9nxXd4XTGs2KOUuqdw/CjqIP9MHLDHt1mmbZ7lffDfEsf+WbH3jR9KvoMHI7ZYsVjgLwXRAj6UPzGMPJzhghDGIDw4o9/NlB/JNdd3uuRgCHN1EOGyddW/BY+IVpvbKjs348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628899; c=relaxed/simple;
	bh=TGVQrrRHB8jwvI3LplHYp9if1LDh5YNgwh4LK1hZQyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFyZ1HztIWVVZVIoTmytGKgLXwXGdiaQP6/dKNL4+5HXvtqTMGL3bXrbvXwDio6z/JFyre/SIxV+eYQgPqe529+2qKwnzCBPsBeD+Pn/Kn2TmFWSdC5U3kQwowZo5ZU/8l3TSvPjvz8JmW50i0nbuq1xR182ooajY5eqQT4RNCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pjaCCcsH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pjaCCcsH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UsioZgCl3ygMsDPWTe1IsIctgvxIyenK9qFb5jgIt7E=; b=pjaCCcsHYO6bqDp3zzDxmnzj3k
	50UWPnAHUEOy3rL9Gh5vN+/qX6cZaFJV1m9bEbWx/mEIDSArx/DRyZ9xs5ULHk3k1aBhoUxcsu2sy
	2txO9K+B+Djt4ScmnVskmTK0/VBX9csDSHDDsCJh7fXgyRzX/ADqxkScpiU5++3s8+6RdBugPvtfp
	8LA0A17RYn9yQbCIxVOCS9wyohioChH2EJ+IfExxy3m3TyWeDNyjyvZIhjVhb5rZKTo/TcCDKEiM7
	phJBhFJ0B9g507NqDxMdb+1vPGo9JqAyuDsPO257tEKa5xUQ5XajuR/rV50dBffJb6i2JbCvKx46k
	SeA+pO/w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wZX3c-0000000BALP-2JEl;
	Tue, 16 Jun 2026 16:54:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BC075300CB5; Tue, 16 Jun 2026 18:54:34 +0200 (CEST)
Date: Tue, 16 Jun 2026 18:54:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, bsegall@google.com,
	dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
	mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
	vincent.guittot@linaro.org, vschneid@redhat.com,
	Usama Arif <usama.arif@linux.dev>, shakeel.butt@linux.dev,
	hannes@cmpxchg.org, riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH 0/2] block: invalidate cached plug timestamp on context
 switch
Message-ID: <20260616165434.GG49951@noisy.programming.kicks-ass.net>
References: <20260616141604.328820-1-usama.arif@linux.dev>
 <178162611741.2191657.12211870708971600814.b4-ty@b4>
 <43b0010d-1919-4986-a88a-a4ccdb3639dd@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43b0010d-1919-4986-a88a-a4ccdb3639dd@kernel.dk>

On Tue, Jun 16, 2026 at 10:10:31AM -0600, Jens Axboe wrote:
> On 6/16/26 10:08 AM, Jens Axboe wrote:
> > 
> > On Tue, 16 Jun 2026 07:15:16 -0700, Usama Arif wrote:
> >> The details for this are in patch 2. The main reason for this series
> >> is to invalidate the cached timestamp on context switch. This was
> >> done in sched_update_worker() only before which was resulting in
> >> blk-iocost reading stale timestamps and throttling based on wrong
> >> information.
> >>
> >> Patch 1 is a prerequisite to create the invariant that
> >> PF_BLOCK_TS set implies current->plug != NULL.
> >>
> >> [...]
> > 
> > Applied, thanks!
> > 
> > [1/2] kernel/fork: clear PF_BLOCK_TS in copy_process()
> >       commit: fd38b75c4b43295b10d69772a46d1c74dbd6fc81
> > [2/2] block: invalidate cached plug timestamp after task switch
> >       commit: fad156c2af227f42ca796cbb20ddc354a6dd9932
> 
> Note: I tentatively queued this on up as a) it looks good to me (and
> thanks Usama for fixing this!), and b) about to head OOO for a week
> or so. If Peter or any of the sched people disagree, let me know and
> we can deal with it. If not, then I plan on sending this in with the
> usual follow-up merge window fixes next week.

FWIW, looks good to me.

