Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E551D684
	for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQUphc5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8D1C433C8;
	Wed, 13 Dec 2023 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702486153;
	bh=Kdku5Kk/He4SP0w3GJBoiu5bWOZ4QHD9VCETiaZp8+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQUphc5bl7YvzdCq8xLF1KpRG/WFEYoltQfcDaKdiHH2NwRpRHArl+D3aMDmEcvH6
	 Xx+Q+YyZv8sxB1n6BOICsoou0lnoK7hmgCpXGSnzvuhrwjpGprOIpSCsgymywk0b2T
	 TK10jtXDCpGJKzcY/xadn+LgEvaU/KrkhImSHkNN/CZJ7x4Nih9j/ux62KoiaaoKeL
	 FD0JIREUQiTRAq+mGCwb5hCEfhrI+9EoiQHe9+nTR+yZCE/96OHkX4SYETNwE8+xI3
	 lNBeyHYbTM2wC2Y70WqgP64PJGTEIaCa5XzrkXx9UMQBc9fqT7Gu+OlUgdv6pXdH5K
	 S2g0F0NLFAREA==
Date: Wed, 13 Dec 2023 08:49:11 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <ZXngh1tkV3NBpq9E@google.com>
References: <42054848-2e8d-4856-b404-c042a4365097@acm.org>
 <20231212171846.GA28682@lst.de>
 <686cc853-96e2-4aa4-8f68-fdcc5cdabbba@acm.org>
 <20231212174802.GA30659@lst.de>
 <5b7be2e9-3691-409d-abff-f1fbf04cef7d@acm.org>
 <20231212181304.GA32666@lst.de>
 <19cd459e-d79e-4ecd-8ec8-778be0066e84@acm.org>
 <20231212182613.GA1216@lst.de>
 <ZXiual-UkUY4OWY2@google.com>
 <8f807991-f478-4f71-9ce5-f39ba4a08c64@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f807991-f478-4f71-9ce5-f39ba4a08c64@kernel.org>

On 12/13, Damien Le Moal wrote:
> On 12/13/23 04:03, Jaegeuk Kim wrote:
> > On 12/12, Christoph Hellwig wrote:
> >> On Tue, Dec 12, 2023 at 10:19:31AM -0800, Bart Van Assche wrote:
> >>> "Fundamentally broken model" is your personal opinion. I don't know anyone
> >>> else than you who considers zoned writes as a broken model.
> >>
> >> No Bart, it is not.  Talk to Damien, talk to Martin, to Jens.  Or just
> >> look at all the patches you're sending to the list that play a never
> >> ending hac-a-mole trying to bandaid over reordering that should be
> >> perfectly fine.  You're playing a long term losing game by trying to
> >> prevent reordering that you can't win.
> > 
> > As one of users of zoned devices, I disagree this is a broken model, but even
> > better than the zone append model. When considering the filesystem performance,
> > it is essential to place the data per file to get better bandwidth. And for
> > NAND-based storage, filesystem is the right place to deal with the more efficient
> > garbage collecion based on the known data locations. That's why all the flash
> > storage vendors adopted it in the JEDEC. Agreed that zone append is nice, but
> > IMO, it's not practical for production.
> 
> The work on btrfs is a counter argument to this statement. The initial zone
> support based on regular writes was going nowhere as trying to maintain ordering
> was too complex and/or too invasive. Using zone append for the data path solved
> and simplified many things.

We're in supporting zoned writes, and we don't see huge problem of reordering
issues like you mention. I do agree there're pros and cons between the two, but
I believe using which one depends on user behaviors. If there's a user, why it
should be blocked? IOWs, why not just trying to support both?

> 
> I do think that zone append has a narrower use case spectrum for applications
> relying on the raw block device directly. But for file systems, it definitely is
> an easier to use writing model for zoned storage.
> 
> -- 
> Damien Le Moal
> Western Digital Research
