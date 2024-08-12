Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF40D1494B8
	for <linux-block@vger.kernel.org>; Mon, 12 Aug 2024 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480522; cv=none; b=KWYtFQ+5HQB/mEiTc0t+1A+mY4KPiD15CarEML+WydW4HoNsLWpl/zE9KaLGcqSpIpD4Ajt1xcifod/Dw8f+jZULAgYUA4YtmdpXwdvyMTmUbsCTXkY3nPh66CJSJqgwcUCS1i0akN60CzBZgPlF23K6Lvo/iqpFBd1YETcWVvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480522; c=relaxed/simple;
	bh=bYBwW6XOIAo39GfNhIvu5RjaqM65aUGLBF0ZJ3LIDRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gA21oabAPIGjNJ3lYXPZewXA5q4iymNJz9uv0K1pn9qHehBbSu1Uzk73Mcf6TyuAD1jteElz9cOzkhT8X3UeIeN9t9OgGGAFJHON/ggobUObVyBVb5XXFUhtAFIK2eQZz+8gtV+6dxzv4vjdj+U80XYjqcT8bSLkphO3kQWmuXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=azrEYN/6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="azrEYN/6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dywFelliws6FM4c0Lj8ZrMCn0rQSphqxFUzWSn3/gs4=; b=azrEYN/6vrOY3nyV7UxzBbCtdN
	P3Ugau8iQGIbMtCsUYsfQ+4WLVT6rO4/xZu6wwOxZKUqWmyP6cGbSIrzn2D6PQil1/MlKe7z4OJmA
	uNoG+RE5JBDdjfAhcK2aGLbfrfgZYFOIrvV5Iu1NX0n2iN2ILEL5Aiw1TEeRFBQYuSykipR7dCpA4
	KX7bzkqGd6EaOXTlwiw5pvxjGcr0nbJxyNkDoJLuKOsH93MAFy4XRWHj0c8kwcQ8dBxuOfANukb+w
	ApjJUeYWT0eUpKXcy6CmY9RL216jdk7HfWNNz/U5yXzdC/ECntm7QEPa5pw66AIwxffvMIkYmLnkS
	MeWqVXzQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdY0q-00000000trC-0o9L;
	Mon, 12 Aug 2024 16:35:16 +0000
Date: Mon, 12 Aug 2024 09:35:16 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kundan Kumar <kundan.kumar@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, kernel@pankajraghav.com,
	axboe@kernel.dk, willy@infradead.org, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v8 0/5] block: add larger order folio instead of pages
Message-ID: <Zro5xJgcVlSaM4zP@bombadil.infradead.org>
References: <CGME20240711051521epcas5p348f2cd84a1a80577754929143255352b@epcas5p3.samsung.com>
 <20240711050750.17792-1-kundan.kumar@samsung.com>
 <ZrVO45fvpn4uVmFH@bombadil.infradead.org>
 <20240812133843.GA24570@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812133843.GA24570@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Aug 12, 2024 at 03:38:43PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 08, 2024 at 04:04:03PM -0700, Luis Chamberlain wrote:
> > This is not just about mTHP uses though, this can also affect buffered IO and
> > direct IO patterns as well and this needs to be considered and tested as well.
> 
> Not sure what the above is supposed to mean.  Besides small tweaks
> to very low-level helpers the changes are entirely in the direct I/O
> path, and they optimize that path for folios larger than PAGE_SIZE.

Which was my expectation as well.

> > I've given this a spin on top of of the LBS patches [0] and used the LBS
> > patches as a baseline. The good news is I see a considerable amount of
> > larger IOs for buffered IO and direct IO, however for buffered IO there
> > is an increase on unalignenment to the target filesystem block size and
> > that can affect performance.
> 
> Compared to what?  There is nothing in the series here changing buffered
> I/O patterns.  What do you compare?  If this series changes buffered
> I/O patterns that is very well hidden and accidental, so we need to
> bisect which patch does it and figure out why, but it would surprise me
> a lot.

The comparison was the without the patches Vs with the patches on the
same fio run with buffered IO. I'll re-test more times and bisect.

Thanks,

  Luis
