Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE4F145B3E;
	Tue, 22 Oct 2024 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581679; cv=none; b=Ilw/bzPt50Dk8DKBxvcF0Fd8x3dlDVDjdsTMu3mz0qhRuVaxZ8JEpR++VX0g7WCM0Cf6o9DrDOuB6zUuAFOwlZibBu4nMDXDknyabSmWNeXR30sgDW4JteSZhbNRHHZxbcs4tWC/0nzC3o+vyHIJ+IoGIf7rH6fiUVUgsPtFmzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581679; c=relaxed/simple;
	bh=2g3mqdCtlNkQy/8v0fs8LaHaQDz3ajYknz0J4ApgLKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nsc4gTWCWeCg/LGEH0KeJRVhbfewaAJ4KsOlIZ3mbQnchx16Jam2K4M9mZs6I3W9x+vxXnNd1khVZmWURMFZ42CmfcpDsScsAWskA2CTgLxgckO8cvAC9mm0xCcjdTPLtNQewYkQcI6QSBhW5uDcScIgMQ8Cz7ihzvo6/J2d7co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B5C08227AA8; Tue, 22 Oct 2024 09:21:12 +0200 (CEST)
Date: Tue, 22 Oct 2024 09:21:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: model freeze & enter queue as rwsem for
 supporting lockdep
Message-ID: <20241022072112.GA12249@lst.de>
References: <20241018013542.3013963-1-ming.lei@redhat.com> <20241022061805.GA10573@lst.de> <20241022071905.GB16066@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022071905.GB16066@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 22, 2024 at 09:19:05AM +0200, Peter Zijlstra wrote:
> > Not sure modelling it as a trylock is the right approach here,
> > I've added the lockdep maintainers if they have an idea.
> 
> So lockdep supports recursive reader state, but you're looking at
> recursive exclusive state?

Yes.

> If you achieve this using an external nest count, then it is probably (I
> haven't yet had morning juice) sufficient to use the regular exclusive
> state on the outermost lock / unlock pair and simply ignore the inner
> locks.

There obviosuly is an external nest count here, so I guess that should
do the job.  Ming?
