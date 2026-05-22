Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5653AEF47
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440217; cv=none; b=Haz1lUigrCfPN1yZt7Z1pwv9Hszw7yezoI2DdPkQnIUama/HK9F6KqC4zuB0GegiWj/9wL+1ZRyshawrIcZAYMiibVUyZRNlysno4TGnNM+aFSy4S6MwWWsmQ76hPKREFC65JZPCIqIJCEiQ4jDUheJYc3ghDuiA6bMGKSP2bDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440217; c=relaxed/simple;
	bh=l6U4VCxTg8DeymbyftlGFu1Ji8GLwYsfoxeOt+pMiH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMbIrqCSVOe4B8qyshbFyhBzA1NY51iVCehn8mxZpF7cC1GOKgVcXo+Amxi+xzjqQuNY+xFgiQf16Cg+8YK6ooxjG6h+Jro1qsxlo4jX3ZTUB+lk5lVCOiaTjB54UIqyPBIho1BMDvohdfC6/xID7I61dQt+4Vs1clDlajTCoMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4CB7468AFE; Fri, 22 May 2026 10:56:50 +0200 (CEST)
Date: Fri, 22 May 2026 10:56:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: always take a queue reference in
 blk_mq_submit_bio
Message-ID: <20260522085649.GB6702@lst.de>
References: <20260520084905.1092158-1-hch@lst.de> <89c94510-abb6-485c-87c4-73364c8f6914@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89c94510-abb6-485c-87c4-73364c8f6914@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 21, 2026 at 09:12:05AM -0600, Jens Axboe wrote:
> This is about a 5% regression in peak performance, fwiw. I'm all for
> eliminating this issue, but this kind of big hammer approach is pretty
> crap in terms of adding overhead to the IO path. Maybe we just cover
> blocking split bio case, and look into doing a proper fix for 7.2 that
> isn't such a massive regression?

Well, that assumes we have an idea how to fix it?  So much overhead for a
simple per-cpu counters sounds really weird to start with.  We'd need to
look at the numbers from your setup as I don't have anything equivalent.
 
I'd honestly still prefer to get this right first over optimizations
either way.
