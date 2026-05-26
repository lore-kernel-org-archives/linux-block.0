Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9843A3821;
	Tue, 26 May 2026 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779777803; cv=none; b=Gs3V9b6a3bfZlHc4Sn/mjDfHcAeJQIUqii42yo/b+VLMfbjJSFp7sZw09qWjeHA9nVYMdLcLW2mWak8mPbo98xtbNooDtW/NT8xApsezB2qwT3T5tQNrkh5bb5x14Vr6Vc3OEx35a3BzHsfKDNKwfs2ULr89gyklRWeW8kMSGeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779777803; c=relaxed/simple;
	bh=pMK3lewCbONKf/ZZnMIoQTQ2q35+eyJjBvF+qce8zgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/e1d8fDpecXFQa9H+GX0amKprfE6qrwfHCLd2/hEYjDTIZ1QbI2IGYitv8+YHu44mpc+SBS9hEnclW9pIo3dCa1fTV0LS6PZ4ZhB3E+2AQhrYF+Z7ibNK7PS7AnLOHZUpNoGlWxWALClntrvaLlVrd3d/9nGd7HZmnKpDhD6oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1xssw/2q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1xssw/2q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Hq/B9MyNzIjDWjlOiji7GymTvUxjiro9ybF2gAh0PIo=; b=1xssw/2qxfIsqC1gECtA4jqJVw
	bTUQbS1P9ouQw2xLP9TXBNt0HN93OyVk6QEwcUNY03CQ4NTIBH8SLpka1g0F7LBH5Do0LqZo6xYsQ
	WMO8OeogR24+t/fclC7A+kHpFCBtIwFTl6YAp5Yd5ppUdRe+Hh5X00e916FmV6FIdmiGU+rz+z7yZ
	LiITmu0pNh1GqKtUOmiq8Aeu1rPBnPjch1wloUe62V7I2FuFK2+7dRs8MBh+vztsTfHTCAmuicgSY
	arVsEzUodlJuZIW/OBUP2r3BGjiVTCEQsNwTCg/MHfIig0lJ/pxN8e97IozqSgtiZ52gUXImTgUAp
	ekuKYa1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRlVa-00000001Bzg-0NLS;
	Tue, 26 May 2026 06:43:22 +0000
Date: Mon, 25 May 2026 23:43:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-mm@kvack.org,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] block: Add bvec_folio()
Message-ID: <ahVBCtsodsM2FHis@infradead.org>
References: <20260522182122.2489391-1-willy@infradead.org>
 <ahPm4h2gKgyEEuvV@infradead.org>
 <ahROtyLcr567wM8l@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahROtyLcr567wM8l@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, May 25, 2026 at 02:29:27PM +0100, Matthew Wilcox wrote:
> > So I'm not against the function per se, but the documentation must
> > explain the minefields it is stepping into a bit better.
> 
> Lower level drivers shouldn't be concerning themselves with folios.
> For a start, we can put non-folios (eg slab memory) into bvecs.

Well, that is a very good thing to put into the comment.  We can also
put them into high-level bvecs, so framing this as 'only use if you
know the memory is folios, which you can't unless you are the entity
who filled the bio' might be a good choice.

