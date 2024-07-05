Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01EE14B96D
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178557; cv=none; b=rfpWz2TFThOJp5ioJC9/EubB4oM3HTLNlTjKqHEDqKbiy3o4E8UzNr0QYQsuESCQeAX3FqUoYTwuPwtu4uBg+tn6ulbuWUVmRh6ITbN/iiivqhabDjlbhOtHTqxssoMbTMmGfqZ0IMxLNCXFUHQdbAGxa8f+ANN86DZ2st/7YSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178557; c=relaxed/simple;
	bh=/Ojy+AeicrIyephb0m3+wVAl6KvQSonHwnBW4QEBwXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouP4o3DHb0pfY5Yw0/V7alq4HJ7KwfarxDopq+kiTaBuLKcBtZFXFoQeMlpnEsy3CvlRrEGNnGY5o3wnatGXPfTm8sn091DJcLeKLO9b8wfOMyZzcwBVDqJYnMNOKHJbZ+zBKaGlG6y1u4UxRGGQNLtiVZITql/06olfh1vRFxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 361DB68B05; Fri,  5 Jul 2024 13:22:30 +0200 (CEST)
Date: Fri, 5 Jul 2024 13:22:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: add a bvec_phys helper
Message-ID: <20240705112230.GA28636@lst.de>
References: <20240705081508.2110169-1-hch@lst.de> <20240705081508.2110169-3-hch@lst.de> <CAMuHMdWmqRq2oBtgY0w1ZPcCchqBm7pmsWBGmqQhAPK6V-Tz7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWmqRq2oBtgY0w1ZPcCchqBm7pmsWBGmqQhAPK6V-Tz7g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 05, 2024 at 10:50:31AM +0200, Geert Uytterhoeven wrote:
> > +               seg_size = get_max_segment_size(lim, bvec_phys(bv) + total_len);
> >                 seg_size = min(seg_size, len);
> >
> >                 (*nsegs)++;
> > @@ -492,8 +491,7 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
> >         while (nbytes > 0) {
> >                 unsigned offset = bvec->bv_offset + total;
> >                 unsigned len = min(get_max_segment_size(&q->limits,
> > -                                  page_to_phys(bvec->bv_page) + offset),
> > -                                  nbytes);
> > +                                  bvec_phys(bvec) + total), nbytes);
> >                 struct page *page = bvec->bv_page;
> >
> >                 /*
> 
> If you would have introduce bvec_phys() first, you could fold the above
> two hunks into [PATCH 1/2].

Not sure what the advantage of that is, though?

> Which suggests this is arch-specific, and may not always be defined
> the same? I checked a few (but not all) that seem to differ from the
> above at first sight, but end up doing the same...
> 
> I think it would be good to make sure they are identical, and if
> they are, move them to a common place first, to any subtle breakages.

It fundamentally is a wrapper around page_to_pfn that converts from
the PFN to the full physical address.  There a bunch of weird
incosnsitencies and it should really move to common code, but I don't
want this series to depend on that.  The only interesting part is
that for architectures with physical addresses larger than unsigned long
we need to cast to a 64-bit type, although all the architectures that
actually do that in the page_to_phys helper itself do that incorrectly
by casting to a dma_addr_t instdead of a phys_addr_t.  Fortunately we've
stopped supporting a dma_addr_t smaller than phys_addr_t a long time ago,
and even back then that only affected sparc (IIRC).

