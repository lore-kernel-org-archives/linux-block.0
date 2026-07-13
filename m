Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38C408014
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957475; cv=none; b=oL4PnlwMbc7j/+drZgj6Ox+vnEIc0gZkjH/VDV10WdD3eolnu/KBY2gqK+GQqqYr1KTPGIvAtYlO+ivNWoKyJDQ1qVApxdRlQN+ZIF2o1HzswHo+OLBmygCu4OZUGo+CZb+sZnb6rZNT/4LXiEHYXRTLL48aLWesZf5Oj2zPVbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957475; c=relaxed/simple;
	bh=KmCWdwH8dzmSDUD3h77SHO6TrDuVgyCFGsoEfDLhpmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOQF3SwKKPHEUv/7eRSlTJXL6u/Y53x+UXrMBGWnUXwzcHyQnuOcYIBSkESmjPNPdQAHbrEotJJT63/zAnrAdsvjxPj3GnTi01YKMzUJ0IucZBapr62shPuLSjyYAAf7L5DtWd7BY7CudnHKby1MTvQFia8t9RgESMmbEZmxg/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf+Og+7o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf+Og+7o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416C51F00A3E;
	Mon, 13 Jul 2026 15:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783957471;
	bh=pMq20bV1HJ+pAimyAGmQIGBlr5PY0yZ1lhIFnnpdzdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bf+Og+7o7gca4eEVDcljO8Y/9gZos9OHivSqsWs9D9Tuf2pU5uQ2/ScaLvM5IZSav
	 MaHzG0CVFxOp+DyGzeP6YslJ2IG+Vb4KV0Do1FcEjoNaW0yZqTtTKJGbbiUOOrS6B2
	 Zq2o6YLswnB0dGkZ+Or7DuXvJMiBH0xNMuBLcebyDjal8aiJtGoz7nCT8JHkgPNtCz
	 9NqIYFNY6a0EpZz39viUUnuIm/4Y0yetnP55HerwDkoISzWsmganMB8FK/+ZlyNyDd
	 Qwto55q28WrMDA9D1XYZJ2aVU0jnt9nVDXEFvuGEXjWtMef0A0L6G2EUtWLzAyNhlp
	 3aOF0th3/eTlw==
Date: Mon, 13 Jul 2026 09:44:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, z1281552865@gmail.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix aligning of bounced dio read bios
Message-ID: <alUH3a7hP1tytq4a@kbusch-mbp>
References: <20260713152912.2333321-1-hch@lst.de>
 <alUGlVDWkZNyUE4N@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alUGlVDWkZNyUE4N@kbusch-mbp>

On Mon, Jul 13, 2026 at 09:39:01AM -0600, Keith Busch wrote:
> On Mon, Jul 13, 2026 at 05:29:11PM +0200, Christoph Hellwig wrote:
> > bio_iov_iter_align_down expects the "normal" biovec layout from vector 0,
> > while bio_iov_iter_bounce_read abuses vector 0 for a bounce buffer
> > allocation.  Pass an explicit bvec to bio_iov_iter_align_down to deal
> > with this case to avoid a double unpin.
> 
> Can you instead just have bio_iov_iter_bounce_read() align down the size
> it extracts rather than letting it over-extract and reverting the excess?

Oh sorry, nevermind. We can do partial extractions, so we don't
necessarily know where we're going to end, so have to align after
constructing the bio vec.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
