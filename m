Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A0C3B71AA
	for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781561324; cv=none; b=tuBE7ByXXreOLIjTtI4tSH2i6KU5sXUoKJvM2IeKvqiewEZDh8qxKeQ6s/HpxneuAUAGEmuOoCVQm4le3IBBaE2WSJ2VP8kQqCHe5lLgYIJpTjqjXdWsk4FpmCJadx9rI3jPKeMsfhAEx8OImE0+26+4GTKB8Wr5EW1NSJC6SRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781561324; c=relaxed/simple;
	bh=hsCqoCy2mAXVVtFRBaYgaRQIBNHXnjWFHDjS2267De4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s++GT9wP6t7XdU8s3bKXEzMrcco8MLSFDN0qlTlJI7PJS19Z6pYOAdnKamCR/6qzj/mnx8y8B2TnIYZRuQztjFiKQ5IqQSfz+/TLAXy/at4NUTarK2Lxd/mXTOA6V5O+H09678BQ5cXrgQAwz5DN6agmN+PnUyckwmCL/6FhL8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQkcvy6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQkcvy6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516CC1F000E9;
	Mon, 15 Jun 2026 22:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781561323;
	bh=LU5HA5oTPoiMtOsyR/6JwVh+zPur+2Xz5VTdM0VAA4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cQkcvy6QLNDmVWp1S1fezPiu89syjhE5h5MwYHpQmU47SCs+eYvioPgjXxKtidYeH
	 nWEyF4O1kYGINF1ca0g8tlEdIMLlMpsq1zS/OBq+nQor0Wo7N/fd936eMxK7gDyog7
	 Shmty6uxkDFi6ubgMRkhxvPLFVYcNgHLHgB9zuxyD6CpSTFZh0CFXcOVsD4mSm+AzH
	 9eRcb8FjJz2r5oCpOp6Sw+P5+dzHgOsWns1T+D+CuxvcxxxmPlG/bOUoxdfb8DzLmS
	 FFvAAjoVmyLwjW2NCwHhay6w8Ol3G4vB4tr8JwZ+y2OM4MSq7iqzFqv6uSL2+Sp/EG
	 eqEL+lOmbzQag==
Date: Mon, 15 Jun 2026 16:08:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH] block: check bio split for unaligned bvec
Message-ID: <ajB36Wt9lU_F-r7h@kbusch-mbp>
References: <20260612223205.465913-1-kbusch@meta.com>
 <20260615133549.GC26132@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260615133549.GC26132@lst.de>

On Mon, Jun 15, 2026 at 03:35:49PM +0200, Christoph Hellwig wrote:
> On Fri, Jun 12, 2026 at 03:32:04PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Offsets and lengths need to be validated against the dma alignment. This
> > check was skipped for sufficiently a small bio with a single bvec, which
> > may allow an invalid request dispatched to the driver. Force the
> > validation for an unaligned bvec by forcing the bio split path that
> > handles this condition.
> 
> This fix itself looks good, but we'll also need something similar
> for bio-based drivers that never call into the splitting helper.

Totally agree. I'm looking at all the .submit_bio drivers, and I think
they fall into one of four catagories:

  1: already split (md/nvme-mp/drbd; dm conditional)
  2: don't split
      * btt, dcssblk: already reject unaligned
      * n64cart: WARNs, but potentially proceeds to undefined behavior
      * nfhd: silently corrupts, but looks like a driver problem
  3: can handle arbitrary memory but advertise default dma_alignment=511
      (brd, pmem, zram, ps3vram, simdisk - "limits lie")
  4: forward/self-split (bcache)

I think the block layer can fix 3 with a BLK_FEAT flag to allow a zero
dma_alignment limit for the drivers that really don't need it from the
source buffer.

As for the rest, I don't know of anyone caring to ensure n64 or nfhd are
correctly handling degenerate applications.
