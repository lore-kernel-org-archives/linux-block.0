Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B0E2D3228
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763501203; cv=none; b=pNID5EqmAvKwqKQZI5Gx4hbLI5pZoWNkTorGH9kSB/dmQ30yr68N0E3rUa/9Hx9HaakN6OVeDhSjr9/38DN/z0gtJ1TeTaG3Op65n7Ot0cS7dreRVLKRiw9RnDv9k+Lt5pa50kwouql/c40hwy3JAwM64ZoyZ8F6C0B+NR77MEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763501203; c=relaxed/simple;
	bh=bS2Az21uuHO2K4kwO+/USkYSmokEeOK8yQbQMyBuRug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDHB/w1yEr4t5Nx+8OLyyxLrpX/md78GbtU0CGLOZMSsotBz9rfwqvPKpVfV2ofYrij8O3C6xsq7dF75wJ75bUYOch5swjgFvnjht9hlT64urNa98O65ZGCXkcbesmTjLHWI4HgT5LgHSUBgWKmN1xtZSXDjQjxBGhvgTd7KkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUpqlIR4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUpqlIR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A261C4AF0E;
	Tue, 18 Nov 2025 21:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763501202;
	bh=bS2Az21uuHO2K4kwO+/USkYSmokEeOK8yQbQMyBuRug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUpqlIR4Z8VEBnsE267/952fjaYSC37AER4wKtJBIBR0aI7ACPCBDtsq95oI0chuj
	 k1J09qFzSgm4WQ6T3a5mT7wwUaY9DTcaHYQAIn0zlRMaSmvDCbotxwBL8psCNArBmL
	 vp4IWJDxMnGMFu/JBvkllX11S02kLFHyAysdmZyfy/GamvEMffKraBuadaFurnKT8f
	 8Wk2UI34qEboew9yUE+7+ng/Ek62OE1t0kUy6acyQ92lsFRYKD4om+6U/q1CTxlpxW
	 5fLCQhL/ssLufpe1ru9Py/7X0Mkitq5LL9EULb9pvmOqe2vx7XVDfqowGuj7XaRkp+
	 CbDZ0Hi83wLPQ==
Date: Tue, 18 Nov 2025 14:26:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, ebiggers@kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] blk-integrity: support arbitrary buffer alignment
Message-ID: <aRzkjoSdpAINcvZq@kbusch-mbp>
References: <20251117203935.1487303-1-kbusch@meta.com>
 <20251118064513.GA24192@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118064513.GA24192@lst.de>

On Tue, Nov 18, 2025 at 07:45:13AM +0100, Christoph Hellwig wrote:
> On Mon, Nov 17, 2025 at 12:39:35PM -0800, Keith Busch wrote:
> >   * Fixed up ip checksum when it's split among intervals. The previous
> >   version would happen to work if the data interval was aligned in a
> >   single segment, but it would have gotten the wrong final result if it
> >   had to do multiple partial updates.
> > 
> >   Testing this type was a little more difficult than it sounds. The
> >   scsi_debug driver would force alignment, so it would never hit the
> >   partial condition that was previously broken.
> > 
> >   To test it, I hacked up a nvme qemu emulation for this checksum type,
> >   taking some liberty with the protocol's undefined fields.  qemu has
> >   its own checksum implementation, 'net_raw_checksum()', and it is
> >   calculating the same result through its contiguous bounce buffer as
> 
> Hah.  Even if it doesn't work for the IP checksum, can we wire up some
> of your tests in blktests?

Certainly. New versions are being prepared for the mailing list, but
these tests are still fine to hit the kernel's edge cases.

Forcing partial checksum comes from the dio-offsets test here:

  https://lore.kernel.org/linux-block/20251014205420.941424-1-kbusch@meta.com/

And to test out the reftag seed mapping/unmapping, I have this one for
liburing:

  https://lore.kernel.org/io-uring/20251107042953.3393507-1-kbusch@meta.com/

Both of these require nvme for the interesting multi-segment use cases
since PI formats for anyone else forces single segment alignment.

> I think the new split_interval_capable need to be stacked as we still
> build I/O to limits.  Not just for that it might be nice to turn it
> into a BLK_FEAT_* bit.

Yes, sounds good.
