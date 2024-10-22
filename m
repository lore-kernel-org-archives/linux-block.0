Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833D13D882;
	Tue, 22 Oct 2024 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581553; cv=none; b=Lhs4IH2QKZ/14tDZKmssnkZZrq5poNKDk1xJt3O1CDL8f1v5ZfHFa3rWrRK00fbbvsCEVW3Hbk6ZJMp92EOph5WIfUKAVY+3DN5ahzQeIUwXseVngbpfFl8PpNKll/GNW5UwjUx5dkz0wuig/3bxu0eivX8AEwNtA0tIsoCuit8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581553; c=relaxed/simple;
	bh=bOd2pJA+OQ4Wiyc0xC3OFKruekd2mLtOFG4A0OEfIwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjxsOiZlaEJ62m27XNER+vmbMixG7oW+64PY+Sj2rm98EMUZgNJdd81XAtjR8NT5r7XI+Zo5qWwLd2aTjl7czFZjyuIadQDzYcMCLATIfervvyhmw2Wo+cHRiFSrYWer4MU3xVMAOP2C29danKUkvO1acgnkIcE9/dl8tfdEOLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A5IZ1USG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A5IZ1USG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qaYQ1rVzEt4Vw3LMHwydD4okZekMGYJ1gtLduqVq4Pw=; b=A5IZ1USGOA/+pfurT/i4KAGSmg
	6Mby2jPp+v+AsC0PuDGFoy/DZkAmck9gGtcds7GM8wbcK08UXmD6n8sBU10reS7WVg/U47fPzf7Nj
	7J6kBq1GPwOcHzTnFnBvRmkDW7T1SesDpGwVOw1uhnh/oudhYIe2WJr3wOdkJ4QDAqX7MNz9uL5ei
	fc6df1qLLGrX38gfZgdYEZyLVZ8QG0uLEp5SR9bTfwgPaVVFyaHoA4rDg60ks5go7CveIRqJD3Tfk
	ZlFDlnSiCw3ep92vMuI3InM+S9SidJLqoEcBQp6nPXRs8R+QkEgt1pZr10zWSRED9N9oDiOSCbXXl
	Bgb7c77g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t39AX-0000000049H-1pjx;
	Tue, 22 Oct 2024 07:19:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A2F5530073F; Tue, 22 Oct 2024 09:19:05 +0200 (CEST)
Date: Tue, 22 Oct 2024 09:19:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: model freeze & enter queue as rwsem for
 supporting lockdep
Message-ID: <20241022071905.GB16066@noisy.programming.kicks-ass.net>
References: <20241018013542.3013963-1-ming.lei@redhat.com>
 <20241022061805.GA10573@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022061805.GA10573@lst.de>

On Tue, Oct 22, 2024 at 08:18:05AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 18, 2024 at 09:35:42AM +0800, Ming Lei wrote:
> > Recently we got several deadlock report[1][2][3] caused by blk_mq_freeze_queue
> > and blk_enter_queue().
> > 
> > Turns out the two are just like one rwsem, so model them as rwsem for
> > supporting lockdep:
> > 
> > 1) model blk_mq_freeze_queue() as down_write_trylock()
> > - it is exclusive lock, so dependency with blk_enter_queue() is covered
> > - it is trylock because blk_mq_freeze_queue() are allowed to run concurrently
> 
> Is this using the right terminology?  down_write and other locking
> primitives obviously can run concurrently, the whole point is to
> synchronize the code run inside the criticial section.
> 
> I think what you mean here is blk_mq_freeze_queue can be called more
> than once due to a global recursion counter.
> 
> Not sure modelling it as a trylock is the right approach here,
> I've added the lockdep maintainers if they have an idea.

So lockdep supports recursive reader state, but you're looking at
recursive exclusive state?

If you achieve this using an external nest count, then it is probably (I
haven't yet had morning juice) sufficient to use the regular exclusive
state on the outermost lock / unlock pair and simply ignore the inner
locks.
