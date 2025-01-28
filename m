Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E9083A14
	for <linux-block@vger.kernel.org>; Tue, 28 Jan 2025 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738043808; cv=none; b=oMVA5+UrIqQayPwE8Fd1DrVEsTHM56bI1G7vpW9achpD7iYno4qF9SJeG48UZ9n+tvvgkgHLDqwM1EOHai+MlscvDKmmIHeQTE8dlfdEuVNc4mSIfjB9lvQe+ep3Bv/6BrxpavxzPbPfTvc3wm3HwmB65y2sY9NpwDi5OLNHXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738043808; c=relaxed/simple;
	bh=49tLfvVgRZnmfOpIcbVQY23mjHunXA9mp2eLuiqBrqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bha9c9czrbLx2vOTf2xTwczya4rxd3bnbLw71KqlL5ckJGc9XUeTpZbqy/L/Q3j7oEKwNt06GhMcvoEo08Be4MYLJChZL1ASCfhxN+de53l8nIHpUBusOqgp3K/K/f7l4kHjdFzRXdsyprmo7p2X42fvHSqlslNt1D6+2mh79SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3Cl3iidw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3Cl3iidw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DNd70bAlVPOMS3w/LevWF2lfIDuBK/+gDQJteY8KR6k=; b=3Cl3iidwjVfupbx3RJEDRR5LFx
	mQkPGChDB8LfWBNQczyOc1vnlSUNLSh/8G+cykxM+o4NKItoCypdp302E3QQxNcmTHYzJrQYwC5Zm
	PjBBSczdfqRe2ba1f8rMysaUNon0Kclc1EtQtn47fl4nO05JsUqKnB+CKo9F9DbqXfbk2ojpS7hIr
	pYXS1jQEMaQuFSitAucbP3plh+ZX6bPWvMOWsDXFtQb1JovU08wIH60l+F7R6bifBbt7rVpaQ1KLe
	EGvMaboB48zmvLncfH5Msv9It2z2DXVxKTnxdb/lG3/2mME9wy0HBX8j3oGdOqFQusdWIIJ06lK+M
	FEOjpp2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tceab-00000004BYO-3lMu;
	Tue, 28 Jan 2025 05:56:45 +0000
Date: Mon, 27 Jan 2025 21:56:45 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>, Jane Chu <jane.chu@oracle.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: Direct I/O performance problems with 1GB pages
Message-ID: <Z5hxnRqbvi7KiXBW@infradead.org>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I read through this and unfortunately have nothing useful to contribute
to the actual lock sharding.  Just two semi-related bits:

On Sun, Jan 26, 2025 at 12:46:45AM +0000, Matthew Wilcox wrote:
> Postgres are experimenting with doing direct I/O to 1GB hugetlb pages.
> Andres has gathered some performance data showing significantly worse
> performance with 1GB pages compared to 2MB pages.  I sent a patch
> recently which improves matters [1], but problems remain.
> 
> The primary problem we've identified is contention of folio->_refcount
> with a strong secondary contention on folio->_pincount.  This is coming
> from the call chain:
> 
> iov_iter_extract_pages ->
> gup_fast_fallback ->
> try_grab_folio_fast

Eww, gup_fast_fallback sent me down the wrong path, as it suggests that
is is the fallback slow path, but it's not.  It got renamed from
internal_get_user_pages_fast in commit 23babe1934d7 ("mm/gup:
consistently name GUP-fast functions").  While old name wasn't all
that great the new one including fallback is just horrible.  Can we
please fix this up?

The other thing is that the whole GUP machinery takes a reference
per page fragment it touches and not just per folio fragment.
I'm not sure how fair access to the atomics is, but I suspect the
multiple calls to increment/decrement them per operation probably
don't make the lock contention any better.

