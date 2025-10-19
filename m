Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE11B523A;
	Sun, 19 Oct 2025 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760884837; cv=none; b=IBIih//d0w+GZv/4WrIhhgxyRni0THDIx6PDMVLWDiZFW2NrqwpLu1DioMFYdvnlo4FSH+Or+l6d+xCQCf/12lh0vdd+wJ4oiZmmn9fsRcBVNFXmEwd4Mg3hyS/u44GH08RJMDnvmjR/V9OGzbTfs1qOQd89bWjaySFzkzbZubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760884837; c=relaxed/simple;
	bh=OToiYPWcf9HfMtkOEssugJbZhagD9pCuP/win/Rr5Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRHX11kvU791tmHYYZyBhjYDoaW5PW2HUWg2POoT5nnNV3a6WEOIa4dUAwaauKZN+JrUfZiTY98ikJ5kjSHDY7+BFXC/bpYbsxOkODbgD7/D/CD2KHM0oIIM5TMMNEKaVCAmcOC8SN8VEU0kvGHCpp0dOgOgmmY8F9a2HTNB/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3q9VIdg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3q9VIdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EE6C4CEE7;
	Sun, 19 Oct 2025 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760884837;
	bh=OToiYPWcf9HfMtkOEssugJbZhagD9pCuP/win/Rr5Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3q9VIdgXIXmsW1jqkUgZJGBaD2eCGSMV5zSXpMzk1830RVIvkHj16oYU3jUI4pkP
	 O+0GmVrAxb6HjjZDbP8hIGx36Lpxrw+jLFT2StHxyhqCwIEJz+FaHiHmmO7nJPbxv6
	 EQ0qYPwoFOvm9pYgConDUrkycf0oEHWpFaC0eFtNT/Eruh8na4Bn53kChCDrw+LQZg
	 9XW7bMejJfI/q4HtN+m4GshwVlix3GmzQ6OTOdf7K5iOPpWXuwfmbsI8o5kP3LXfQi
	 vdOePQNfA8xbCKhaJT1btsY2P69RbQ2xYxLHphB+KS211UEpx2Lf+0m7YsiHBH4VKf
	 hgvGXJnHRj5/g==
Date: Sun, 19 Oct 2025 17:40:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] blk-mq-dma: migrate to dma_map_phys instead of
 map_page
Message-ID: <20251019144031.GK6199@unreal>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
 <20251017-block-with-mmio-v1-1-3f486904db5e@nvidia.com>
 <20251017061848.GA402@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017061848.GA402@lst.de>

On Fri, Oct 17, 2025 at 08:18:48AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 17, 2025 at 08:31:58AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > After introduction of dma_map_phys(), there is no need to convert
> > from physical address to struct page in order to map page. So let's
> > use it directly.
> > 
> > Reviewed-by: Keith Busch <kbusch@kernel.org>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> You forgot to pick up my review from last round.

I'm sorry that I missed your Reviewed-by tag.

Thanks
