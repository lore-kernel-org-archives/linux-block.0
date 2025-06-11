Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531EC288CC
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 04:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749615733; cv=none; b=ctFn4zqvqWmhwj2UP8BwWUQueedr3sSD6R5Li1bni49QmBWUZX93CnPWKFMn3spr4CMtGBImpUQDitHEHFJKDi9xtpGmXbtHUssCTplkF3NbxFuH0EoMIKrEmkMIbgOBT00Xwbm4eYa+a33nMhAGsbw+wapx7hrkINKEH8mXXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749615733; c=relaxed/simple;
	bh=zR1ATugMxchKtgvmBml557TJDCqdx+bYomxJLLjCfhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoxGy6glXP+hkJ1AFFmql3sr37pUGXuOid5ooR0YLx6IZOdr7JobqlEHtruL3fDydqJX1PVGiFq2VIXRpUzaBEx/WHtGXl27yoWtI7DHamLtJrjgQBkVLlIFbmzW3kh7vJXIZBfabISHFXJNhmn17pZeQHdv+uEEI7YoBm+K940=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2z5ynnw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2z5ynnw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B74C4CEEE;
	Wed, 11 Jun 2025 04:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749615732;
	bh=zR1ATugMxchKtgvmBml557TJDCqdx+bYomxJLLjCfhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P2z5ynnwzFm0/jDaeGt5Qt6CHhUuF6Tktff2iZGNNLgjTo3j9SwpPu6nVoImsJtzL
	 p85Ey0U6agTfqLq1hmskbBpotCy7aSOB9j34QcobTsaR4DsWb0R8bkjPOcjJXgsbH3
	 Xo4iJ5LvkwsT1w+izihr/E9p1uK+tqOUCQyIJqAM30hePEAB5xUQlPLNvrz4aaqbnQ
	 RBE5zjs+d6HWCn7sqL0HV3XkuNb6nBe+XkReIW3E8ekoK7hraxROyA8DDKQ/+XBhN7
	 sf9i3IGpeWFD4ybkYPI6yTGkP/HgD8OcFn85Ab6IEHj+9c9NJA0aEV/c+WMsOpLZD/
	 ZwKwufTGAguLw==
Date: Tue, 10 Jun 2025 21:21:48 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	Ming Lei <ming.lei@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
Message-ID: <20250611042148.GC1484147@sol>
References: <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
 <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org>
 <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
 <20250526052434.GA11639@lst.de>
 <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org>
 <20250609035515.GA26025@lst.de>
 <83e74dd7-55bb-4e39-b7c6-e2fb952db90b@acm.org>
 <aEi9KxqQr-pWNJHs@kbusch-mbp>
 <20250611034031.GA2704@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611034031.GA2704@lst.de>

On Wed, Jun 11, 2025 at 05:40:31AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 10, 2025 at 05:18:03PM -0600, Keith Busch wrote:
> > I think you could just prep the encryption at the point the bio is split
> > to its queue's limits, and then all you need to do after that is ensure
> > the limits don't exceed what the fallback requires (which appears to
> > just be a simple segment limitation). It looks like most of the bio
> > based drivers split to limits already.
> 
> I'm still a bit confused about the interaction of block-crypto and
> stacking drivers.  For native support you obviously always want to pass
> the crypt context down to the lowest level hardware driver, and dm
> has code to support this.  But if you stacking driver is not dm, or
> the algorithm is not supported by the underlying hardware it looks
> like we might still be able to run the fallback for a stacking
> driver.  Or am I missing something here?  Eric/Bart: any chance to
> get blktests (or xfstets if that's easier to wire up) to exercise all
> these corner cases?

blk-crypto-fallback runs at the top layer, so yes it's different from native
inline encryption support where the encryption is done at the bottom.  (But the
results are the same from the filesystem's perspective, since native support
only gets passed through and used when it would give the expected result.)

If it helps, blk-crypto-fallback can be exercised by running the "encrypt" group
of xfstests on ext4 or f2fs with "inlinecrypt" added to the mount options.
These include tests that the data on-disk is actually encrypted correctly.

But that probably doesn't help much here, where the issue is with bio splitting.

It's been a while since I looked at blk-crypto-fallback.  But the reason that it
does splitting is because it has to replace the data with encrypted data, and it
allocates encrypted bounce pages individually which each needs its own bio_vec.
Therefore, if the bio is longer than BIO_MAX_VECS pages, it has to be split.

If the splitting to stay within BIO_MAX_VECS pages could be done before
blk-crypto-fallback is given the bio instead, that should work fine too.

Just keep in mind that blk-crypto-fallback is meant to work on any block device
(even ones that don't have a crypto profile, as the profile is just for the
native support).  So we do need to make sure it always gets invoked when needed.

- Eric
