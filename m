Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8322BE031;
	Fri,  6 Feb 2026 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770360199; cv=none; b=mckTTQajLBrIsCEX+GNt2/+6GcNH/FR8+p1B+cmQFRKclveHkldTNDF8FDZnGY2YZOhF+1H4vIUpKI2g0nGue5xxdV0LuhP9iVotfVSm41/qvlBOEIy7x6JUszGEL3TQX7ZkKsq9GWPpnGufEd/JhPbm9XPPU1X2VCZZ451TcZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770360199; c=relaxed/simple;
	bh=pKtN8WnCuYXwkWzFvsMQJ/HMrJxyfv9Zg9vpPy/V71o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGZOmQFCV6sBzQDvZt0166hjGPHt+UkLqkUyYqMlR53+BxFWQVjz1FLzAvR0PME3RsxK7vpV1QWAe9JJG9J7hp3+AY1sVNelUWTf/JsUdJZi2OvhlrR5WQGUHxM2Mm7q8lhB5293HihghnZnNgBM307qZjpFsgRYFZetfhrLeVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SEBPOHA6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SEBPOHA6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ZXrRBnmDZKOWe4vfrMf+XXsjZ5+XXZ/4HO8NGf3/PuQ=; b=SEBPOHA6XebvRYRnQLAZyfY3O0
	zPgcE8UITkCIrubNX3UJsMfaL1pPelcPlLCKLo73ZVN96QqfN32iy1MC5ZYXF958Yj9Q2old4HIEi
	1TV4YE/P9Tj1n/qGlBghMeCbH7JWGBsgv2IPuo0QtPJI0cWFDHprPwz0f8c9vMMg8jSdST8HM6Qij
	odQZ2OXIY6KN3lFGy/VVAIZX7e1mPRDKx58DaMQdO70CEs+ex3K4cv3608i5BBvMVFLwftdYFXtOV
	UTRR2I9un++/dXClFjqA+/EZ1/+lFRp4PynD9G0emzYtnTJUr9AZ8AQPaoA16Pgl7IvLsTBazwBg6
	LjifVnwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voFYk-0000000AxLL-49gg;
	Fri, 06 Feb 2026 06:43:19 +0000
Date: Thu, 5 Feb 2026 22:43:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] drbd: always set BLK_FEAT_STABLE_WRITES
Message-ID: <aYWNhtixUGuj3hat@infradead.org>
References: <20260205173928.3166880-2-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205173928.3166880-2-christoph.boehmwalder@linbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 05, 2026 at 06:39:29PM +0100, Christoph Böhmwalder wrote:
> DRBD requires stable pages because it may read the same bio data
> multiple times for local disk I/O and network transmission, and in
> some cases for calculating checksums.
> 
> The BLK_FEAT_STABLE_WRITES flag is set when the device is first
> created, but blk_set_stacking_limits() clears it whenever a
> backing device is attached. In some cases the flag may be
> inherited from the backing device, but we want it to be enabled
> at all times.

This looks like a bug.  If an underlying device requires
BLK_FEAT_STABLE_WRITES, the upper device needs to inherit it.

> Note: this commit is based on the for-6.19/block tree in case it is
> still possible to take it into the 6.19 release as this *could* lead
> to silent data corruption. However, due to other protection
> mechanisms in DRBD, this is relatively unlikely to happen in the
> real world and we have not seen any corresponding reports from users.
> So if this only lands in 6.20/7.0, it is also fine.

I'm fine with this as a hot fix for 6.19 and -stable:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But can you please also do the proper block layer fix and then
revert the drbd one?

