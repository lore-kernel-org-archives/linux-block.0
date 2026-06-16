Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A3B44BCBE
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624178; cv=none; b=gibjj2YKRm2QtXPCeaSQ6197S6PPnxTcdLyj9WUj05iYrjn1E/9OjeY37uXRSgM08Ynzp18OFi6B8nmR2xN3w8KnxDzBy9EFfQyhg4TVn+hkw+gBhw0wE7Lhs4Nm8d5tvD4ix+6jxj/X2U56nHC9hkIKO9BPp+BGXOh23hCDYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624178; c=relaxed/simple;
	bh=grT1qA9lUeWaFenHae7doyegh2HHUvnM4Xf2fxaX58Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgGpOpUElgWFX1al6tEZa2vo4ONRTTd0z1a83MM8xEgrmavnHCO+qo3VWxAUVmLASLatoWKuUdcxZqS2V7T0XwF7Xi2wU3lMqRHs5ZMsEj5SDuyiIPx6FEHFgyW2DH++BaRs5Of3ba6kEUi/Tq8s1vsi0dI1/nmcuRsWXLfTO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBnjzKlh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBnjzKlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5AF1F000E9;
	Tue, 16 Jun 2026 15:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624177;
	bh=v+X/MHvNtxwrhQ7a0cfBtfH77O5NOBeKXOMXglD71Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kBnjzKlhSFd/ifpiJtPOw1UqVzLs+kZsV13pH8FeUC0+1ONer36/t+WJ9e5f+41eE
	 6u0POEBkNySUvKAfcF5gxEcEDlXUFrpwplOkbs7un11KA+/HjuToucC5MC1IgKUZeV
	 J00KuWrl464mTikYgo2x8OlliC3X+5E83ecvO3mja5Jhju1/khw0sZXaVygqXw0Q9W
	 KGMbR+JqXjx+g7l47uURNjySB+7jywWkxgeXu9cPTKnUVFJDhvOmG1eWMP+1ytwI44
	 4alp6V40kLWogjDaTyg0SmIYf1b/NeqCdPrxJwJSUCWpz01Izfy6ORG+7rFqJMXWln
	 0lUfBAFwRHhsg==
Date: Tue, 16 Jun 2026 09:36:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH] block: check bio split for unaligned bvec
Message-ID: <ajFtbzPiEI1kFjp6@kbusch-mbp>
References: <20260612223205.465913-1-kbusch@meta.com>
 <20260615133549.GC26132@lst.de>
 <ajB36Wt9lU_F-r7h@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajB36Wt9lU_F-r7h@kbusch-mbp>

On Mon, Jun 15, 2026 at 04:08:41PM -0600, Keith Busch wrote:
>   3: can handle arbitrary memory but advertise default dma_alignment=511
>       (brd, pmem, zram, ps3vram, simdisk - "limits lie")

That's actually not right because they iterate with
bio_for_each_segment, which requires all the bv_len's are sector size
granularity, so their default limits are correct. Just no one's
enforcing them right now.
