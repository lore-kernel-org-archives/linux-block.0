Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDED4139561
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710265219; cv=none; b=vFsfW5GbBF3aPW69ld7H/Roba4InoWY22K5HIzazZZGRgMOtr6MS0mGGa93A7FEiLyqI4E11YFops/hYWRVjUUowQMhPGdIsa/ASb1horzi42oIoquknzfNuiswQH5uhKYCVQGzMjduD/zBEK7E4DYTjDj624tB+E89mLujwq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710265219; c=relaxed/simple;
	bh=p88PjSuHMvSiaGd3Tm+j/bqmPqJOVDkKkHYaPNEuiek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SeZZm3MSf6kL4SXuW7IHdm3y8RH70UJPXmTiXrBgxDs4PCclllx9DeFLkwT5IQ/uEf8CZ5pz2d5rZb5mF4ZC7gP4tSZHrbEg3bnNtZOQAYGnf4XjwQQI4lDmrM3yVZuC/rYqu5pH8L/scZX7yRKrCkaMonV5ELRQ58dCCFko9Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UQWjCBko; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UQWjCBko"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=uiprbajIkx81C1BpAcArVOCqoHy/7DhppwCGLpEAJyI=; b=UQWjCBkodZ5NGq2YKxmwA1NzP1
	PnplBTj80bWUhA6iSwBApPAbzM7D2TRfT5n0MES7uuiuqvc0Kol7gFzQ3E0hiqoT/ixRBEUqumq6z
	06TuyV8WSKOyPJsYtvWXDAo9BrZbFCueBj6G1icEkLh9iCBJ9bt1xh3wz4nO8AKu3YQ0p3siStBAW
	/tGNQoQWUeRzuDP92ESdQQwb77bBQcBhPtfny71nqk9bS+FLyMyAopO3T28Pvp5SNUqDvW9eh6MJW
	pWpqkChmLaF5eBf8FW9+4hUSv4fR8yl2DaNLm1K771zzEWCEuVwkWTMAH+5BUa+KMzBDqRaUArLwz
	jL/1H9Kg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk66n-00000003Xkd-1ARV;
	Tue, 12 Mar 2024 17:40:13 +0000
Date: Tue, 12 Mar 2024 17:40:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: brd in a memdesc world
Message-ID: <ZfCTfa9gfZwnCie0@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jens,

I'm looking for an architecture-level decision on what the brd driver
should look like once struct page has been shrunk to a minimal size
(more detail at https://kernelnewbies.org/MatthewWilcox/Memdescs )

Currently brd uses page->index as a debugging check.  In the memdesc
future, struct page has no members (you could store a small amount of
information in it, but I'm not willing to commit to more than a few bits).

brd doesn't use anything else from struct page, as far as I can tell.
It just calls kmap_atomic() / __free_page() / flush_dcache_page() (and
it doesn't need to call flush_dcache_page() because you can't mmap the
pages in the brd's array).

Now if you have plans to, eg, support page migration, you're going to need
a bit more infrastructure than just allocating pages, but for what you
have at the moment, just removing the debugging checks that page->index ==
idx would make you entirely compatible with the memdesc future.

Any problem with that?
