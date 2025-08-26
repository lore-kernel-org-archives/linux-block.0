Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA2C133;
	Tue, 26 Aug 2025 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756247598; cv=none; b=dz94O0Ozv9mlSLU+N8LlrwwCQQKMiX3LS9N47nhPwKapkJ0PGzCT3qYO49Y8A6DiRoKaDAa6LvxIcQCrl3J2mEGE2Fp6sbGcyghXqtQQ0r5GK1bMg3Qg1OBzYTyr1o/P9GRpOA2wnwQwyL6XoGsDZlTP9+hK9ySTwRTIKVlvbQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756247598; c=relaxed/simple;
	bh=enAWv7FM+3cCYyKIq2hsdtFuRu631uhygsKoaTBzjso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/5DcD79ITpf4+byX+zw/XGAP5bspxC8anuQSkK9FFY++l+IqqA3Nn3dClFew9vW7RJwZxtxRIS9CO1X8TiIbi8q8V0uKxlENY48f6Y/hsI3fI5SvBwwYnq+UgsESfmLqeftcksUkWcFj23EMX0hYAsUr2SCMn7wDrWegcvD+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvAZzZJ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvAZzZJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84940C4CEF1;
	Tue, 26 Aug 2025 22:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756247598;
	bh=enAWv7FM+3cCYyKIq2hsdtFuRu631uhygsKoaTBzjso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvAZzZJ16Lko9gWeA6XLyGd0vlNbHlTJ+grcokJ3kz7RBiXyBw7uMkBBbcHDOQcoe
	 fOUS9A0kfmH8cp/OebZHMMchUkyWWE2AjJqWkRWGvI89IBtHhAdL/JiUUIqjER+yt4
	 iwZzxCWbdhSY3UkqRtzVWTfFXsebYOu44eezPldyHW0QP5oG5xbzhgjCk8ECy+YV6F
	 tB7yigAWW93QqgPSUG9bFU+C1kxXPzXK8vcGKUPgNOjIEx6DsGTEr2yWSqw3hBE0J8
	 DdT0leJ3Pjo9EPGaB/ftg4PJIwRi1AR2N8VqJ7mxJFeujjgW1O82iDx92Hx55O0fk3
	 iFz7f5gn9CIww==
Date: Tue, 26 Aug 2025 16:33:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, iommu@lists.linux.dev
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <aK42K_-gHrOQsNyv@kbusch-mbp>
References: <20250821204420.2267923-1-kbusch@meta.com>
 <20250821204420.2267923-2-kbusch@meta.com>
 <aKxpSorluMXgOFEI@infradead.org>
 <aKxu83upEBhf5gT7@kbusch-mbp>
 <20250826130344.GA32739@lst.de>
 <aK27AhpcQOWADLO8@kbusch-mbp>
 <20250826135734.GA4532@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826135734.GA4532@lst.de>

On Tue, Aug 26, 2025 at 03:57:34PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 26, 2025 at 07:47:46AM -0600, Keith Busch wrote:
> > Currently, the virtual boundary is always compared to bv_offset, which
> > is a page offset. If the virtual boundary is larger than a page, then we
> > need something like "page_to_phys(bv.bv_page) + bv.bv_offset" every
> > place we need to check against the virt boundary.
> 
> bv_offset is only guaranteed to be a page offset if your use
> bio_for_each_segment(_all) or the low-level helpers implementing
> it and not bio_for_each_bvec(_all) where it can be much larger
> than PAGE_SIZE.

Yes, good point. So we'd have a folio offset when it's not a single
page, but I don't think we want to special case large folios for every
virt boundary check. It's looking like replace bvec's "page + offset"
with phys addrs, yeah?!
