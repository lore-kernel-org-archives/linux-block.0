Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCD71E495;
	Tue, 22 Oct 2024 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577891; cv=none; b=uTWgbM6MriHNW94I+tYcF0rOquLv0Kv4E0mBAaiiLo6r/zLzUmrsn78IniS6mJxMc0iKPhEuqq5J9pnc/lJjE3BxmCmubIKi3Vc26j8/aZARe1dpH7fYQUoZBptUHaX8dmSO8MeK/g4gmJF6KrxLY68Y4f/LOwTPxmBftBUkm8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577891; c=relaxed/simple;
	bh=jnNdPRp+iOBTESphayrxI0LVZxX6Hz9FgwN3dhnFQ/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtpL6/Kx4Z5qEOIrtWMx8jLOTvnZHexbw1Kziy784KF6sK61abp6xIcHzO9FUgDXJqRwejNRlXS2+8Es6FvNnwIp3P3i91OE+343rjQNk/gDCY5CK4GrhDrtR4GqStUD8Pa1GJv35OePV8ier4p+9Cx4SkLPx7CmOiGBXb6Xm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2892F227AA8; Tue, 22 Oct 2024 08:18:06 +0200 (CEST)
Date: Tue, 22 Oct 2024 08:18:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: model freeze & enter queue as rwsem for
 supporting lockdep
Message-ID: <20241022061805.GA10573@lst.de>
References: <20241018013542.3013963-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018013542.3013963-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 18, 2024 at 09:35:42AM +0800, Ming Lei wrote:
> Recently we got several deadlock report[1][2][3] caused by blk_mq_freeze_queue
> and blk_enter_queue().
> 
> Turns out the two are just like one rwsem, so model them as rwsem for
> supporting lockdep:
> 
> 1) model blk_mq_freeze_queue() as down_write_trylock()
> - it is exclusive lock, so dependency with blk_enter_queue() is covered
> - it is trylock because blk_mq_freeze_queue() are allowed to run concurrently

Is this using the right terminology?  down_write and other locking
primitives obviously can run concurrently, the whole point is to
synchronize the code run inside the criticial section.

I think what you mean here is blk_mq_freeze_queue can be called more
than once due to a global recursion counter.

Not sure modelling it as a trylock is the right approach here,
I've added the lockdep maintainers if they have an idea.

> 
> 2) model blk_enter_queue() as down_read()
> - it is shared lock, so concurrent blk_enter_queue() are allowed
> - it is read lock, so dependency with blk_mq_freeze_queue() is modeled
> - blk_queue_exit() is often called from other contexts(such as irq), and
> it can't be annotated as rwsem_release(), so simply do it in
> blk_enter_queue(), this way still covered cases as many as possible
> 
> NVMe is the only subsystem which may call blk_mq_freeze_queue() and
> blk_mq_unfreeze_queue() from different context, so it is the only
> exception for the modeling. Add one tagset flag to exclude it from
> the lockdep support.

rwsems have a non_owner variant for these kinds of uses cases,
we should do the same for blk_mq_freeze_queue to annoate the callsite
instead of a global flag.

