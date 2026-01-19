Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117B82882DB
	for <linux-block@vger.kernel.org>; Mon, 19 Jan 2026 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817903; cv=none; b=dMerdiWsh0AsrG+WAhIHGB0IYKwD6/IJnTQnnmLE1bacjx87T+QTSKm49xfO6kwZ0lJpNjP15IF//grOt+R+D4VP3Optr8v+5sFGgx87Qj8iu9l7yv3OsFc6VK1B1cBnnDue1FDcRsROms/mAOnrJ8Ip7IoGIOvLIuGttdwlOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817903; c=relaxed/simple;
	bh=HC7TLvf3//GCwRLvhQq4nekbKLxPnJB3rO2+KeKKXzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbjGjlnGc+wQkqDCTN6nWYyAx8HIEHi3Y+GdqoVGwu3ixJjL8vbtUfIA3FYcoLJ6Wc2Fy0mRTgUnr63bC7Fp9oOeA4MoCTGbkURqldhrio5MGvzzuvzcrZPFZbr+y+TphgfmbaRitz9UY9d4+X4P8MczLlAZaTp9efR9xrgFBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NUUe4kh7; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NUUe4kh7"
Date: Mon, 19 Jan 2026 05:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768817899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=judHjY1NulyclqVN1tEAJsZ8iFAy2VC8CBrW9yugBCw=;
	b=NUUe4kh73Q/5lSTy4gTD3EymcVm6TXzGbNWdrCSj8RyEg4UyF/Ye2WUMt0AfKeYkf17ezd
	QDIjViWY91RpfS96SZJSk3jFgW9NPESrM03Q+P0zgORBRONtVIr+XNZI+nYKdSn0LJW0oi
	NReV0BoeCERW4JPJWkC2XfDTyc7XiKE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Coly Li <colyli@fnnas.com>, 
	axboe@kernel.dk, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	Shida Zhang <zhangshida@kylinos.cn>
Subject: Re: [PATCH] Revert "bcache: fix improper use of bi_end_io"
Message-ID: <aW4D0UPTBXEap1Jg@moria.home.lan>
References: <20260113060940.46489-1-colyli@fnnas.com>
 <aWX9WmRrlaCRuOqy@infradead.org>
 <aWYCe-MJKFaS__vi@moria.home.lan>
 <aWYDnKOdpT6gwL5b@infradead.org>
 <aWYDySBBmQ01JQOk@moria.home.lan>
 <aWYJRsxQcLfEXJlu@infradead.org>
 <aWZwBZaVVBC0otPd@studio.local>
 <aWZyHz_eZWN-yQiD@infradead.org>
 <aWZyWJiOi9hZgtqo@moria.home.lan>
 <f7af1e25-fbe9-4d37-b902-5b3a9ed4c8f4@flourine.local>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7af1e25-fbe9-4d37-b902-5b3a9ed4c8f4@flourine.local>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 19, 2026 at 10:51:46AM +0100, Daniel Wagner wrote:
> On Tue, Jan 13, 2026 at 11:34:18AM -0500, Kent Overstreet wrote:
> > Coly and I were just on a call discussing updating my old test suite. I
> > haven't used the bcache tests in > 10 years so they do need to be
> > updated, but the harness and related tooling is well supported both for
> > local development and has full CI.
> > 
> > https://evilpiepirate.org/git/ktest.git/tree/README.md
> > https://evilpiepirate.org/git/ktest.git/tree/tests/bcache/
> 
> I just quickly look at the tests and I got the impression some of those
> tests could be added to blktests. blktests is run by various people,
> thus bcache would get some basic test exposure, e.g. in linux-next.

ktest has features that blktests/fstests don't - it's a full testrunner,
with a CI and test dashboard, with subtest level sharding that runs on
entire cluster.

What would make sense would be for ktest to wrap blktests, like it
already does fstests.
