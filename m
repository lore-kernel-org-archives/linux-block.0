Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8286E1FFC6D
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064160; cv=none; b=L9zyrJv34F96lgbDVx1sfdPNE79qiQFriU7CBMlzJbCFGbqef18EmsDivQ55/SQcW00BLOE43ZoY4EiJi5B572Od4l+zsj7iGJGukbKQicazCocqBlkdV+X72EyjXRCM9DfjtkgiFY0WS0LiY+Or4/yGwbEdiIUO1CFQ3WkYLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064160; c=relaxed/simple;
	bh=RwytZoim/s8xQmYRFYBo5gLE3881p8ljpJe8Sh+0KJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBPOPDkXU7Eyc7uj/kHqgGeT3TNVz6riSnq5LFbvgoId+Pzyl1EW7EyUXeFLTwRCLgrXrCc+EX2vJE0aKjrj9eC3PGgpeMFehdtkJWnhuY7Uj8ZIQnZHjWuyKnpv8YoR2KZ0+Hva7jWnfRq6f19woSczqvuhwfm/K5yzRNmmqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myYtJ7Qs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myYtJ7Qs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E729CC4CEFB;
	Thu, 13 Nov 2025 20:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763064160;
	bh=RwytZoim/s8xQmYRFYBo5gLE3881p8ljpJe8Sh+0KJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=myYtJ7QsP0iFCplpLY5QksgM7Xod+GBVJAcLvPDapTUQFSfjgIInkyabF4jhTwpC3
	 uKv5Ufw5sAEToC4uQSdOOBpiU97XRRpSf273wZjavLWlL1U5+ROaWt8f1Yc69aEpxz
	 YQ3RFQDCAKLNcrOckxX1Y5d8pDDCo47Xdfu6tYBp5hg4rhnhal4UbipJh4bdc1+uzt
	 B+pRieuTnchhtvP2Wn/KAugzjGdMKvR9Pae7jS53zBjLL6BLAdfRGlErU5bPHoBMld
	 iU+35roCf6YMWyvIFvL4yayT0U8RJzooyBxRT7YRVpsT5dTeTj2upmzxumwvag6Mth
	 vom7o1FP9Btng==
Date: Thu, 13 Nov 2025 20:02:37 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
	axboe@kernel.dk, "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4] blk-integrity: support arbitrary buffer alignment
Message-ID: <20251113200237.GB3971299@google.com>
References: <20251113152621.2183637-1-kbusch@meta.com>
 <20251113173135.GD1792@sol>
 <aRYf9S-UuJqa37fi@kbusch-mbp>
 <20251113192022.GA3971299@google.com>
 <aRY2G6xEgEVqLBgb@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRY2G6xEgEVqLBgb@kbusch-mbp>

On Thu, Nov 13, 2025 at 02:48:43PM -0500, Keith Busch wrote:
> On Thu, Nov 13, 2025 at 07:20:22PM +0000, Eric Biggers wrote:
> > On Thu, Nov 13, 2025 at 01:14:13PM -0500, Keith Busch wrote:
> > > On Thu, Nov 13, 2025 at 09:31:35AM -0800, Eric Biggers wrote:
> > > > On Thu, Nov 13, 2025 at 07:26:21AM -0800, Keith Busch wrote:
> > > > > +static void blk_set_ip_pi(struct t10_pi_tuple *pi,
> > > > > +			  struct blk_integrity_iter *iter)
> > > > >  {
> > > > > -	u8 offset = bi->pi_offset;
> > > > > -	unsigned int i;
> > > > > -
> > > > > -	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
> > > > > -		struct crc64_pi_tuple *pi = iter->prot_buf + offset;
> > > > > +	__be16 csum = (__force __be16)~(lower_16_bits(iter->crc));
> > > > 
> > > > This just throws away half of the checksum instead of properly combining
> > > > the two halves.  How is this being tested?
> > > 
> > > Yeah, this is the only guard type I've never seen a device subscribe to,
> > > so not particularly easily tested on my side. I just forced the code
> > > path down here anyway and checked if the result matches the result from
> > > the existing code calling "ip_compute_csum()". Maybe I can just continue
> > > using that as I suspect devices using that can't handle split data
> > > intervals that I'm trying to enable.
> > 
> > Wouldn't csum_fold() combine the halves correctly?
> 
> It doesn't look like that would be correct if we assume the existing
> code is correct. The current result from ip_compute_csum() just
> downcasts the result without folding, just like I'm doing here. My new
> code is produces the same result as the existing code, so worst case
> scenario, this isn't introducing a regression.
> 
> > Anyway, it needs to be tested.
> 
> Like on real hardware? I'm a bit at a loss as to how, I've never seen
> anything subscribe to this format, not even in emulation. The only thing
> I can readily do to test this is run random data through the old code,
> print the result, then run the same data through the new code and see if
> they're the same. That test is successful. Not good enough?

ip_compute_csum() returns a folded 16-bit checksum, whereas
csum_partial() returns an unfolded 32-bit checksum.  I don't see how the
checksums can be the same as before.  Hence my concern about whether
this was tested.  It could be with hardware, an emulator, or a unit
test.

- Eric
