Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A323783C4
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769752393; cv=none; b=S7Ve7YTJaqAD1JLyIPDplPoyHqbajEckedtCMPgy/X8qtsM/s3d5M25jcgY7Dx+jSuGx07ML53b7Fl0R0cp4WLbagkIiPs5hVC//Ha+U0AyV+p/+DERHVwQ7CZQrZcefq3QVhp2ROArGZJw5rocum/1dJM01KlXhwPBM7lj6NtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769752393; c=relaxed/simple;
	bh=r1+nkGyC2051ts1Jf+bG0Kth6VpzaJ3E/vWKolcTI0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5OIZeZFDQLJRbVGhfdsWGWM27bd/VGybzQ7PSkM3uIkPovEm/KamYOWfJYyDXPeYb6i9aOh3FsPbn4+XPn1tJ7pLjKRqIJiNFvrJXSAvtLSd0WIpy9UFsXaibs27zbUrvEizIXxFSL8mz+kPynx7nLs2O99ev6ED25IAodt1+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MOTPXotF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MOTPXotF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vbm1MP7byqSpkUwHsdpqZtGytMmtgAT6VdLgbKhVR1A=; b=MOTPXotFbiyYpXfHMCVp8Kh9II
	VHUoCUhLSyMRoPfi+C7HxdEHWBoB0ypgCjkTcad16MRX6X9e21dtOStvJYFCLB5lrUQkRBpxaQB6+
	QlZnA0Uv5mwhvhK98r5yqhgMDzGVDo54JPAU4yVZ50QCmnMflSKFXjR/RRZAeZNsJpDVqNLRLRDj6
	K82Ujg+mLSs3vZGr1mIahe9XxVZLKc6myxxTujkq7QAITMVpE1Hr9sZdksDWTSODnqNjKCImO6Lqr
	ftjPGWxquQeaOzvza7XjkQ4jNLXUcIGjEMVr82G/WLSthcVeB2TD7WuLJCMxCiAp6Z+lbnVILfemI
	4AvHgLaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlhRP-000000014li-0DVn;
	Fri, 30 Jan 2026 05:53:11 +0000
Date: Thu, 29 Jan 2026 21:53:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: introduce blk_queue_rot()
Message-ID: <aXxHR6xpve-YHT_5@infradead.org>
References: <20260129072715.1107336-1-dlemoal@kernel.org>
 <20260129072715.1107336-3-dlemoal@kernel.org>
 <aXxEsA_HMLxLORZV@infradead.org>
 <fec8c581-a019-4ff0-9b3a-080d5145fc7d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fec8c581-a019-4ff0-9b3a-080d5145fc7d@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 30, 2026 at 02:50:12PM +0900, Damien Le Moal wrote:
> On 1/30/26 14:42, Christoph Hellwig wrote:
> > On Thu, Jan 29, 2026 at 04:27:15PM +0900, Damien Le Moal wrote:
> >> To check if a request queue is for a rotational device, a double
> >> negation is needed with the pattern "!blk_queue_nonrot(q)". Simplify
> >> this with the introduction of the helper blk_queue_rot() which tests
> >> if a requests queue limit has the BLK_FEAT_ROTATIONAL feature set.
> >> All call sites of blk_queue_nonrot() are modified to use blk_queue_rot()
> >> and blk_queue_nonrot() definition removed.
> > 
> > Looks good, and I should have done that soon after inverting the
> > underlying flag:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> > We should also do the same with bdev_nonrot, maybe staged because
> > of a lot of callers outside the block code.
> 
> Yes, that is why I did not send a patch for that one as the changes are mostly
> in file systems. Will send something later.

It might be a good idea to just add it and use in "block tree" code,
and then we can convert other callers in the next merge window and
eventually kill off bdev_nonrot.

