Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C382652A6
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867397; cv=none; b=SF64+394MQelVMukesKvxD4KKAf/Gn8L/lMXZDlZIGDLoD63nLy6ak5NwfLel8rs/7FQnjjIzKCKKZpL8yIcS2r4U1g/CIsRTNTm0FOKk0Vh55nAkj1mw0Cz9Xx6FDtA2coRRHN8IiekN7loKvgaD/2zuK9ic3LvkbjnXyEYX5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867397; c=relaxed/simple;
	bh=DB+eC0c3o2pnETrjNuTskHB3LeYZnQynixMCUoGGhxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC6PiezCsC1W3ZJpyUGhUJ6drXjatrZ7S2NJGf7BuDMHaux4YCI2FFIL0q3YlsI8XFnyxz9Jnavc69XSIABDiI2guXjcd5KV/on3fIT+P5qnyvQFL4MJtvFRK/w6eQHfjpRBF4COp0zdEsLgOxLkffsxlOd+dAXCjyHGYMAcXoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQytwcdC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQytwcdC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44F0C4CEEB;
	Wed, 25 Jun 2025 16:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750867395;
	bh=DB+eC0c3o2pnETrjNuTskHB3LeYZnQynixMCUoGGhxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQytwcdCVx19NT/KhwTZvD+/xzS0fsE/dOAekhrVpx5Lo0XX80oUDaB+mvAchxJnZ
	 8j/vgqi631Q0GVo4YsX18SE5I3Nol3M1bRD4ZLjZWLfeCUIoLnuSxeM3jN+qy4MFEM
	 bFGLocuPIfmysKMeZqpIjUeVYlM2J3YtilWFHY9omxPW4K+O6t929c9zlVycbVDJbo
	 /jk/S7p3u1F29/j88wRJK7hzFmXm9H5Gzxbaelbh6nBIrU6rrqwBsDyA5MGp68pvUT
	 MJGJ9fvCKgxF5w+JZPKS9Fp3rcUKqHlavMKct01rFOuHPLZ0ZFI8240EpG6BF8mM4B
	 3SxySj7OxPOTA==
Date: Wed, 25 Jun 2025 10:03:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/8] nvme-pci: refactor nvme_pci_use_sgls
Message-ID: <aFwdwa4-36u0w8Cx@kbusch-mbp>
References: <20250625113531.522027-1-hch@lst.de>
 <20250625113531.522027-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625113531.522027-4-hch@lst.de>

On Wed, Jun 25, 2025 at 01:35:00PM +0200, Christoph Hellwig wrote:
> Move the average segment size into a separate helper, and return a
> tristate to distinguish the case where can use SGL vs where we have to
> use SGLs.  This will allow the simplify the code and make more efficient
> decisions in follow on changes.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
