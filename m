Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675FA2D7DD4
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057657; cv=none; b=uAN+hOipsD03BTXoAALJz8QKPrqTzLAhp6KBZv7suQBA9H0trLCwUnQ8A3OJGGRBHWlngDWaL5Tg2DAejfdYF8rfeTQgkKKpaHBsqWdtq0YX/mZyz60pbWTBByo5ZI0F9hWJ7YOa2n4GHvBrKRRUUitCk+eKbKI/SO2Ga+MpaXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057657; c=relaxed/simple;
	bh=T/NmWUUzWHyPFDrsJiUJTF7XipWAkHcC3+8jGxnsw8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekyVRiBRljiaxmzGU4AyZc5DxWrA06Pc7rmNCjGI+Z8TsGos0tv4ZAabXk1izY0SScRolbCL8R17+kgHnTSbLo7jhUBV7Rryt8LDS6B0GuiMVnIn686S/JAW5qxq2DJe85xxqMAdaZ085ByFRnDhzf1ORzxzCHdzEVca8dC74OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rhva6+Ch; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rhva6+Ch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23114C19423;
	Thu, 13 Nov 2025 18:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763057656;
	bh=T/NmWUUzWHyPFDrsJiUJTF7XipWAkHcC3+8jGxnsw8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rhva6+Chk5bkUpCz1WMPSLHDX+QCrQlJcyXEGHXDmubrbSUOMc7ggn8qIpe28dphy
	 /UbjZSvrAN6Ao0XLvHjaaFIQ5CzzCipnXhPRj+AEBl+PZIhqjTTwfYFN9aJzER9rWW
	 ymZW3IbjsWmDw6MuxS07Hq0/UcRtTxRCz41HUm1Sh7hs1OoICViMHgB4k6XGFBa7js
	 xbsWIT+LaeFTEs5mEka1mUonE+ofSCRwaHiKQnT8c7Jm6+pdhnDwGkWR4TyXaw2D0R
	 2+1mbXZ5i0h7LPmoRGdUHjiY2UWlVOiM87Y+mYZCkhZLnrcoqE/nGqLhPoTbvr1+VJ
	 S/ijsUiqek7jw==
Date: Thu, 13 Nov 2025 13:14:13 -0500
From: Keith Busch <kbusch@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
	axboe@kernel.dk, "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4] blk-integrity: support arbitrary buffer alignment
Message-ID: <aRYf9S-UuJqa37fi@kbusch-mbp>
References: <20251113152621.2183637-1-kbusch@meta.com>
 <20251113173135.GD1792@sol>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113173135.GD1792@sol>

On Thu, Nov 13, 2025 at 09:31:35AM -0800, Eric Biggers wrote:
> On Thu, Nov 13, 2025 at 07:26:21AM -0800, Keith Busch wrote:
> > +static void blk_set_ip_pi(struct t10_pi_tuple *pi,
> > +			  struct blk_integrity_iter *iter)
> >  {
> > -	u8 offset = bi->pi_offset;
> > -	unsigned int i;
> > -
> > -	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
> > -		struct crc64_pi_tuple *pi = iter->prot_buf + offset;
> > +	__be16 csum = (__force __be16)~(lower_16_bits(iter->crc));
> 
> This just throws away half of the checksum instead of properly combining
> the two halves.  How is this being tested?

Yeah, this is the only guard type I've never seen a device subscribe to,
so not particularly easily tested on my side. I just forced the code
path down here anyway and checked if the result matches the result from
the existing code calling "ip_compute_csum()". Maybe I can just continue
using that as I suspect devices using that can't handle split data
intervals that I'm trying to enable.
