Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7627A131
	for <linux-block@vger.kernel.org>; Tue, 27 May 2025 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367929; cv=none; b=E5cRJ525ySJDFhn5Y09MUdFpzpaxdx7cIJ93W6k04T9dRNHnz4eNLqSA5ZjHRrExth1mU9tCmfA1adlzFZmd+1vy31MVLWDJ/JuhK28p/49iRCYC2kfTWECqWceKtPbzMB+wucxrtTd/4duMgiH441w5JBtlfQ0bov6LIa7SNiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367929; c=relaxed/simple;
	bh=Hg7+II8HEX5zi/FluJO3H7vljaGyCQoWcCtOW5y0tpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLmURmVWLV/rrE80qgpyxszB1bPOEk8TgFKbgvGZPdE50do53PBaPZ8bvvgTThHYq1105k9UY/sSxjP5tOiqGJLHikU4A59keLTlFclXVS9zmf6dVtsKIdnuY8OCzIS/lkU9xNNpY4SkKo2zQjGjYWo0bOa58b7+jlpWayqNQHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYxPGptj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYxPGptj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFE4C4CEE9;
	Tue, 27 May 2025 17:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748367929;
	bh=Hg7+II8HEX5zi/FluJO3H7vljaGyCQoWcCtOW5y0tpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYxPGptj4xyzvLholB4bpFVUA4rlJWG6jnK/pvlYQWKl7O1mfx6czMU2rGI9/E3sl
	 toRQMnPPwASqJ/0FIASpln8CxbrR2L5cr7K96TRyFM6PhP4H72zYl/f8zpsU/8Q5XU
	 4HRkc4X9qFGZxd/wTmpu/QNRixK7ZcjD667ZzoCBDaWND3wB6MI75721/KeBZGDxgx
	 yyrPifQwS6A8Uj8wgHOhq8krJMqjsXL4irnpV1lu6ZnjYy7UYx9C4rD7YO7YGaSphO
	 xP8PeuCAGloDi5MJVDKIByVzAuN0sse+w81dSpboCAew4DQR0lRgbkInhC11cyL5HY
	 kJNEGHulPacTQ==
Date: Tue, 27 May 2025 11:45:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aDX6NjOuGvxhbw7C@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
 <aDBt1qXj90JO1y2v@infradead.org>
 <aDCqGLY4irp-6N5M@kbusch-mbp>
 <aDP5o1qb02iwgw-V@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDP5o1qb02iwgw-V@infradead.org>

On Sun, May 25, 2025 at 10:18:27PM -0700, Christoph Hellwig wrote:
> Well, I'd expect most uses cases of things like GC to use the "fallback"
> for now - because copy isn't actually that often supported, and when it
> is performance might not be good enough.  So we'll need to optimize
> for both cases.  Maybe a fallback code is useful, but I'd leave the
> buffer management for it to the caller so that it can reuse them.  Or
> maybe don't bother given how trivial the code is anyway.  The use case
> for common code would be strong if it refactored existing code and
> showed that existing callers actually have enough common logic that
> it's worth the effort.

Just fyi, the initial user I was planning to target with the block
layer's copy fallback isn't in kernel yet. Just an RFC at this moment on
btrfs:

  https://lore.kernel.org/linux-btrfs/20250515163641.3449017-10-maharmstone@fb.com/

The blk-lib function could easily replace that patch's "do_copy()"
without to much refactoring on the btrfs side.
