Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB428D841
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312494; cv=none; b=Z/HmtMO22iU570No4iUeuS9qHGUFZKaeCZNetlJyeVuIUXaI+huPoLbZt1V/fm8JDGGiIHh4793DwY2zKdRLr7D38q1TI0OuuFWuFTV+kuTlzD+xeolw6lFjRS1k0vFclGTfC/xWcj3Cg6538pbFYunLv1gG0kMUPExQYBLmgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312494; c=relaxed/simple;
	bh=FfQyZjJngCj0NwDnl+fOZ0ckCxaPFf3tx7rfq0BfHUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmt6TZJEhtMSrEFjGjJvSnfmu9fVj9dWUTrcAFx3VewIUvxijVK3xOKO3wjM272Ai2v8eQFvpgwtqZwgxaPZDKhL/Crt+PSfyCTCMeq8ZiBAQpHhIj+8bQDjOcEiRPKpL2EFObOqdW210WjRhNPPft/HBmxX+WP6eNIo028Ho7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OgqgG0yv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OgqgG0yv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CsYtj+99g3ufjQJJHjFAKOMB1TbPSAbut7l/t4VyhoI=; b=OgqgG0yvYXYzbeEjyL07gDUjCu
	mmr8lsjZFCr15eIv1ausUPOR8UA6YqU5DRnILF0lcUOvDriAt5FgPGrdK1hTQyKI25p7Qi67DBnAI
	+j4/l7AGRBgE+wd4KSGfoKoE9jTREvBKNDNDCO3iiYqLN+JFn+ohlEi9oGS9PAzMq+FSWWIpEJulF
	QR6HLHfRrDEjRHKJA55MuY5tUvZ+Z4j3G7BUUatHHwAVL8v0+HmUSAS+Cqnax/juu0QN8ymkw777o
	l4nba4AJDruop7NKF5V8tQPBOlRJyWhzMusRCZY34/xPg2+5efM2k4+67Uoal/vBmwe0W+ZBVp0gx
	LtTdjosA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2xMN-00000003HtV-1JN8;
	Thu, 10 Apr 2025 19:14:47 +0000
Date: Thu, 10 Apr 2025 20:14:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	David Howells <dhowells@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: Does GUP page unpinning have to be done in the pinning context?
Message-ID: <Z_gYpwn5TvvYap6N@casper.infradead.org>
References: <939183.1743762009@warthog.procyon.org.uk>
 <67d4486b-658e-4f3f-9a67-8785616e6905@redhat.com>
 <dcb80dc4-a9f7-44d8-b88c-7221ea29deab@nvidia.com>
 <Z_NzBWIy-QvFBQZk@infradead.org>
 <f04289cd-128a-492e-a692-6f760e2271e2@nvidia.com>
 <Z_dzKUp1ukaArcSx@infradead.org>
 <21dfcbfc-5295-4493-8ae1-eaa82f018472@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21dfcbfc-5295-4493-8ae1-eaa82f018472@nvidia.com>

On Thu, Apr 10, 2025 at 12:11:42PM -0700, John Hubbard wrote:
> On 4/10/25 12:28 AM, Christoph Hellwig wrote:
> > On Wed, Apr 09, 2025 at 07:56:07PM -0700, John Hubbard wrote:
> >> This topic always worries me, because the original problem with
> >> dirty pages is still unfixed: setting pages dirty upon unpinning
> >> is both widely done (last time I checked), and yet broken, because
> >> it doesn't do a mkdirty() call to set up writeback buffers.
> >>
> >> The solution always seemed to point toward "get a file lease on that
> >> range, before pinning", but it's a contentious design area to say
> >> the least.
> > 
> > For the bio based direct I/O implementations we do set the pages
> > dirty before starting I/O using bio_set_pages_dirty, which uses
> > folio_mark_dirty and thus calls into the file systems using
> > ->dirty_folio.  But we also do a second pass on I/O completion
> > before the buffers are unpinned.  Which I think now that we pin
> > the folios is superfluous.
> > 
> 
> Oh actually I think I was wrong in my earlier reply about clearing
> the dirty bit. Because in Jan Kara's original bug report, what
> happened was that periodic writeback came in while the pages
> were pinned, and cleared the dirty bit--and also deleted the
> page buffers (file system specific behavior) that are required
> for writeback.
> 
> So then later when the pages are unpinned and marked dirty,
> that causes the next writeback to fail in an unexpected way
> (it used to cause ext4 BUG checks, in fact).
> 
> So the problem here is that these pinned pages can get cleaned
> while they are pinned, and then dirtied again by DMA (invisible
> to the filesystem).

Did we fix that already?  Because it's relatively easy to writeback
pinned pages and _not_ clear the dirty flag.  That handles the two
problems which are falsely thinking that a heavily-mapped order-0 page 
is pinned (we write it back anyway, so don't lose data on crash),
and doesn't strip the bufferheads.
