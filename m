Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A429293471
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559934; cv=none; b=X0zn3pMwiiislL0JEw9E2BqyKCTnATyLb93Vy8RGbY3eoK4B+wzaPxYqIxn9bJwO9nWqW7fcgLaRZRJOkm4sHCLoAXHkVIOImn3K7rkQyciu1gnT5WnQFI92zX55CxxPJmR/kVg7huVK6I0akPFZ2pRm/8YnQhOAU2LH8BzKry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559934; c=relaxed/simple;
	bh=JwfMRaXFDDcYug2KIgrnVERgvWlE8wove/kTuolnULA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+q3gZzAQXzjrhjJP16Yh2GjhRvHu1Lll8WO/IKChzgH73o0xIOpn6JkARqjyqJBpmvJAdrBeMUwmJP0jnTFcXlx1UoLEoESG2knygPkd02gfKccMvoegqs+YibhVG/G7SFFioZlpNKf0+rlWTEhtKM8DnbgOBp26w78sHs4ERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYWPXDVm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYWPXDVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA52C4CEED;
	Tue, 10 Jun 2025 12:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749559934;
	bh=JwfMRaXFDDcYug2KIgrnVERgvWlE8wove/kTuolnULA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYWPXDVmLs7QdDfubenWppMxdAmlxmoTZDbldEtP3Bg2abqUShOY7wFM3XjANm6CW
	 pL3XOgp6l5Guu1faLUlG3hxdXmx2l9Nx7lBgnXGWizzm31R7Pw58o9KQ9hmUQ952Fh
	 voG4DcUnqBbIw7h1mgdE5NIBmCEzy8e41dw7GLBfWgJEl5mJcm0ZJlzD/jONrXlYW1
	 IOVMOtNahLhfKttyz8qakCt0l0YdrEbbRcsme2/pDOEX4f7kj9GLbdP1vAkG0/ZPgA
	 UJSw5ycRSdwPtyq4D/FdYw/AIAfxiihwKiY+u+jKSXbwtvXSDMdCGP+lDvT38SxvFK
	 u5tOS+5aoe1LA==
Date: Tue, 10 Jun 2025 15:52:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/9] nvme-pci: simplify nvme_pci_metadata_use_sgls
Message-ID: <20250610125210.GE10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-4-hch@lst.de>

On Tue, Jun 10, 2025 at 07:06:41AM +0200, Christoph Hellwig wrote:
> Move the nvme_ctrl_meta_sgl_supported into the callers.  2 out of
> three already have it, and the third will be simplified in follow on
> patches.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
