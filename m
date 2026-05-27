Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3DA3C1404
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888134; cv=none; b=B8MFswwfbVnBKfuVzDJZw74WwBN8rgRQ3FvOBmaGOeOmWs9iE7/e+BqJnjJUQns/l+pyWoMozjc6h+c5bAUYpqKRKrLl4Dq+bnPU/ooEloz6OCdDB5fAZC9f86lx2bDGgdxqfI6qtM8iVYEv8+2pybE8+mLFZQ20QOPwriI1zJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888134; c=relaxed/simple;
	bh=dYKo00BEjXBkvscZL2wt8dh9evNCXHt+pu7Y5jNER58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBd5vQ8kpeYSxF+/jJn6aw/T7CLbt08NjQFvpriVfSpTY1UyLPGC2c9HgIrveKy73+r8mbaduwXOJf+0v3184ZnJ7WP2wWN4znfCOQ7QUXNtdBH8qitOVBGjKipjnxg+b76IrBx3gmIKxCZ/6zrozrFyIBJVeo7Yn/1e6h2fCt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0KDI8oI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0KDI8oI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E330E1F000E9;
	Wed, 27 May 2026 13:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779888133;
	bh=pMBavffiZSnRm2SoY87F2ixUkUHdGCw3hRW7BgBJuUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N0KDI8oIyMcqZYtRTHjWMP4UhTdnoLGBE4fLS+2hbONXogf3hE9PuhV9xWFqqL1rz
	 kVyIoj9EQzTcPHpgptYVoSrQNhbi+5lGEtAHkAMz/oRSdZFisVvb5uf/8lbwuUJs//
	 8cqleVo66V6WibUhqORZyFNoVeJxjLtCSSRRo/6W/4fywp0/kefH92F/2BxH1qXTzU
	 WJ1gVg3bb57Z1HuqawKHRv0Z604RrIhdotPDkjxNZpeUlk9unFz6EpTGMcqUSldFHP
	 YK8+AlJUVeTZw0Uc1wwp1PtXpLZcbMdaMrh3QEFwF8FNSyTP2uDQt7roInS2lHHCzS
	 YUguD3lguAuKQ==
Date: Wed, 27 May 2026 07:22:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	nilay@linux.ibm.com
Subject: Re: [PATCHv2 1/2] block: export passthrough stats enabled
Message-ID: <ahbwAxG1Pj2z3Q21@kbusch-mbp>
References: <20260526153921.2402015-1-kbusch@meta.com>
 <20260526153921.2402015-2-kbusch@meta.com>
 <20260527131458.GA10351@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527131458.GA10351@lst.de>

On Wed, May 27, 2026 at 03:14:58PM +0200, Christoph Hellwig wrote:
> > +static inline bool blk_rq_passthrough_stats(struct request *req,
> > +					    struct request_queue *q)
> 
> The kerneldoc requested last time would be really nice to have.
> Also, now that this is a public API killing the q argument and
> just using req->q would make the API easier to understand.

Oh, my missing kerneldoc is clearly a problem. We need a separate
argument for the request_queue because the q we want to count stats for
may not be the one providing the request. For nvme multipath, we want to
count stats against the head's request_queue, but the request comes from
the ns path, so we need both args.
