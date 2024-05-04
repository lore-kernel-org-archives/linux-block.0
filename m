Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD5A1D52D
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714840334; cv=none; b=bR6LKDI6nyxYNghBHanY80b1YUgt8hshQcDZGPgXTyYYYFCgUax2aNGF7jbBLytd9goU62WWwScYukgndcdhwoHPa9UB4EXkuixCj3YRBpKxwhYT5dqXNnI/8gr59lFFt8ubPIXVzYrKn47oBFKahWgtjfeZdWO6Q4pi3uamfi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714840334; c=relaxed/simple;
	bh=RvJT9cefv4FcchmE/9sJMsSMqGhSE0uQUs9M/KYv0Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvyIgAH6Sr7d/MpgMb+Tek9qA9Er7wcvm/nw3UxaLoTa3pN/fP0xOmQQ87iQOiNxYWudwmrtcty6fs9jBWLQnTVCwRucgoFQwXasglJTcLtpUiBsbpHAIcyvwClufQVc9Rp/3mUxEt4duQqa59vUxoobn6nkKARhCSqn4cARFUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O6jIu7Nj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O6jIu7Nj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GHtXdDu/jOjvmv3yx9nrIccDnZW3PM8rM3YEW+E9sMg=; b=O6jIu7NjLSr3oxue2lcJC9jurO
	zKWI5uLKW5JylpIzXb2r5FB7cKv7rMnfr1Cty6G7RZY9yLPjYQFwIuuyEe0Mg2AildpHsLWRnFy1d
	lRpY3FiL5AijwJPKwTbvIoSKLLQ3dBuY5blQeM0QDBl/j555IRc6+ZWRUqeGP57zGqZiyTSeMy8r+
	j9FaWutMXg4CrqpCWEvnrkkqlcQw06J+ztxN+8+KJFz922fW69LsN/PpYn1EB9fsjKe5DKk05n6Qq
	6juAtqoVLUIaQQmC8vQ7wnIM3OsercClnpgJpuzEJExX6Cnxfu+LUdl2VOALxQagY1n3nqVgNS7Gt
	7ZlVM8LQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3IIu-00000006lOj-2iUx;
	Sat, 04 May 2024 16:32:04 +0000
Date: Sat, 4 May 2024 17:32:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Kundan Kumar <kundan.kumar@samsung.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org, joshi.k@samsung.com,
	mcgrof@kernel.org, anuj20.g@samsung.com, nj.shetty@samsung.com,
	c.gameti@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v2] block : add larger order folio size instead of pages
Message-ID: <ZjZjBHAdUdt6FJe6@casper.infradead.org>
References: <CGME20240430175735epcas5p103ac74e1482eda3e393c0034cea8e9ff@epcas5p1.samsung.com>
 <20240430175014.8276-1-kundan.kumar@samsung.com>
 <317ce09b-5fec-4ed2-b32c-d098767956d0@suse.de>
 <20240502125340.GB20610@lst.de>
 <ZjUCP08UyIGTzpW_@casper.infradead.org>
 <89417350-2589-4b7d-831e-eccfe1ce1ae2@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89417350-2589-4b7d-831e-eccfe1ce1ae2@suse.de>

On Sat, May 04, 2024 at 02:35:15PM +0200, Hannes Reinecke wrote:
> > I think this is wandering into a minefield.  I'm pretty sure
> > it's considered valid to split the bio, and complete the two halves
> > independently.  Each one will put the refcounts for the pages it touches,
> > and if we do this early putting of references, that's going to fail.
> 
> Precisesly my worries. Something I want to talk to you about at LSF;
> refcounting of folios vs refcounting of pages.
> When one takes a refcount on a folio we are actually taking a refcount
> on the first page, which is okay if we stick with using the folio throughout
> the call chain. But if we start mixing between pages and folios (as we do
> here) we will be getting the refcount wrong.
> 
> Do you have plans how we could improve the situation?
> Like a warning 'Hey, you've used the folio for taking the reference, but now
> you are releasing the references for the page'?

This is a fairly common misunderstanding, but TLDR: problem solved long
before I started this project.

Individual pages don't actually have a refcount.  I know it looks
like they do, and they kind of do, but for tail pages, the refcount is
always 0.  Functions like get_page() and put_page() always operate on
the head page (ie folio) refcount.

Specifically, I think you're concerned about pages coming from GUP.
Take a look at try_get_folio().  We pass in a struct page, explicitly
get the refcount on a folio, check the page is still part of the
folio, then return the folio.  And we return the page to the caller
because the caller needs to know the precise page at that address,
not the folio that contains it.

There are functions which don't surreptitiously call compound_head()
behind your back.  set_page_count(), for example.  And page_ref_count()
(rather than the more normal page_count()).

And none of this is true if you don't use __GFP_COMP.  But let's call
that an aberration that must die.
