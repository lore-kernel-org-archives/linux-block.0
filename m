Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3266730675F;
	Mon,  7 Sep 2026 07:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765203; cv=none; b=GRuoYiDGH0uV5SKj4c5y1Rs0JwsfH4peiH3LYwFsijjytK0kINoTsp+ta4iK/1Av052RISp2bW0tpAsYhcp+az6PPgjoAl7bGFAmk4ucAJboq8WUr5N3xCNZBM1rwO5D7MGFeYdhdtZOE0YO2WphAxPG8Gqw75bppe5X9tNwvuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765203; c=relaxed/simple;
	bh=xjH2ATr01D/klgKvcvuG/Yf4qw9apeBH+VusSGwYi1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9p9mDHFRwpNIcJt9FpEnogt7DCjz5tLEhlxAg0iKcJDigC3vGLO+T75tOUEhAShDqqZRgJ8gh5RZ/gaWfXqgckNxMkT2dMSJ8ZA3CvemcOu2+nd6cmZqL3h9MuXesKHTXhEKQKXAz0WJGAYK8VfUEdAVSFPaJgqT76bas3i2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE41B68BFE; Mon,  7 Sep 2026 09:13:18 +0200 (CEST)
Date: Mon, 7 Sep 2026 09:13:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] block: unpin all pages of a bvec in
 bio_iov_iter_align_down()
Message-ID: <20260907071318.GE934@lst.de>
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu> <20260828-blkdev-fixes-v2-6-32f3f40cebed@columbia.edu> <8da4a2dd-a4ef-4a61-888f-60c611d3f911@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8da4a2dd-a4ef-4a61-888f-60c611d3f911@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 28, 2026 at 05:36:24PM +0300, Tal Zussman wrote:
> > Both issues occur only with a logical block size above PAGE_SIZE and a
> > large folio backing the user buffer. On a device with a 64K logical
> > block size, an O_DIRECT pwritev() from a hugetlb mapping that ends 16K
> > past a block boundary leaks one huge page per call, whether the
> > remainder is its own bvec or the tail of a larger one.

Do you have a reproducer for that?

> > @@ -1213,14 +1219,24 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
> >  	bio->bi_iter.bi_size -= nbytes;
> >  	while (nbytes >= bv->bv_len) {
> >  		if (bio_flagged(bio, BIO_PAGE_PINNED))
> > -			unpin_user_page(bv->bv_page);
> > +			unpin_user_folio(bvec_folio(bv),
> > +					 bvec_nr_pages(bv));
> 
> And right after sending this, I noticed bvec_unpin()...
> 
> I think a cleaner solution is to move bvec_unpin() up, make bvec_nr_pages()
> handle bv_offset > PAGE_SIZE, use bvec_nr_pages() in bvec_unpin(), and then
> use bvec_unpin() here.

Yes, that sounds better.

