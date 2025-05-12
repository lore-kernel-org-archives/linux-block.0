Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD027456
	for <linux-block@vger.kernel.org>; Mon, 12 May 2025 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747030912; cv=none; b=MCLbjrVOMWN0cyhWU1U2IMyCbh6zp6R5AhF1D1wHl1ioHyvhVbYkKBiGZgycyOCYSITGEYk1ElgDpApFdgHcqunjBb3hvNEFC8IoLU8H2J+frtapTWJXxzm8OiFwblCJAQ5O8CRZtNcV4/vTDeZIXHslH1+NpzDRrZTIFDEVOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747030912; c=relaxed/simple;
	bh=zh4Oscl4aGoPZ53WCfJVs/FsTUSDxLs75o9T5ButJg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIo0PJCvaBgUq7EUpWSEbWAPtE8fzBalHxjugvV4gQfIpPQOlftEJydbsoIrn62kbHbSoc2Yk9TzfV+is0pq6n+MK3sJjWvFkzA/7oH5Ox05fPQr6Mj3PexE1Cq0DByDsWSkYV9IEYs8y0ii8b+81fRYEKKcsgKX6pB/752qBfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Fq4XvHuo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fq4XvHuo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mOYcyfOTEvmW7YlZTR2UYgH6ijut7zsCHvBlq+wYpns=; b=Fq4XvHuogpwCkqkgJbFSI9qq9e
	9uUopkxAipJPb7LK0R7cJqwKGMMyIYrUWCYpOyoCkPd1AHXIzlehPJZ4MeBVDqHn5s39JSrT3ykA8
	WbvqIfvX/KOo5HsyXa47EXc4K051999ksVFP9/0o7lcSbwYgR+4n6dMvzJ3v+7Xocw43aAxQXPNfo
	V9feCKURIbqxL2vAL62gjEcwd9Ml6qBb1QhkwJr8k4PgxUy1XdJ1dgZoat2I6fs9lp8s81wEAE7RP
	KvaxhZr8Lo85V5yFQuATHoqLShjvDl1d+WqZ/eb3luQXqq+2uRCuSMDVUO7NvzpyT7Bq6g808XMQQ
	1wriUE9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEMXp-00000008Ujw-1UrX;
	Mon, 12 May 2025 06:21:45 +0000
Date: Sun, 11 May 2025 23:21:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	David Howells <dhowells@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	willy@infradead.org, linux-mm@kvack.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: Does GUP page unpinning have to be done in the pinning context?
Message-ID: <aCGTeY2HswIFHsD0@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 10, 2025 at 12:11:42PM -0700, John Hubbard wrote:
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

I've looked around a bit.  We do skip pinned pags in shrink_folio_list
(btw, can someone please split that thing up, it's so huge that it
is completely unreadable) but that's not really relevant for clearing
the dirty bit for filemap folios these days despite comments talking
about just that.

So I guess, yes - we'd need to skip folio_maybe_dma_pinned() in
writeback, or wait for the bit to be cleared for data integrity
writeback.  Which doesn't sound too hard, but there might be
pitfalls.

