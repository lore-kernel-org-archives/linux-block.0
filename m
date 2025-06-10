Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179372989AA
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559493; cv=none; b=QjeOeqSm4QCepKNfB0GT2WzQKM+Fk7NNILCrW7ArsnVQKfA3USGpWdx8evi1HjETKUU1EnxliIL6Hqz6fkhZTnsFSQb4lWT4mOeJcaqgrhNBlMFfM3bDnDyYCuNPUbnHN87L7piZKgrOuzTBCqBuH+ozlrbCr4JoFTaeERsWv58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559493; c=relaxed/simple;
	bh=nENN5E4cU4vlaajFZf4FyS7H/8oCnYy0WKTBohDXero=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSrOPQYYdYOXf+h1CdFifJKdMAVdmSkjmmaaL8qv7pA8oTLMqbtNkM9zpiEZG3KnQ+PKLKWYwgRebhVDQs67p5coq60AlLj56J5MkhOCycc6wUCCuhTebfIZG+WcFi9yefLVA5rl/CAWS2NBWyazy1droPLSfMwoChA/hBQeJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmlpSdTs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmlpSdTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A414C4CEF2;
	Tue, 10 Jun 2025 12:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749559492;
	bh=nENN5E4cU4vlaajFZf4FyS7H/8oCnYy0WKTBohDXero=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SmlpSdTs5cjVi8dmgyDQWcAGloOwm4MYO70IWjrwc/CjghgQ9KI65CHsejYQkoj0M
	 E0hklrtJVjnHXkMaJIVE7aMkmRhZO6jrTvdClB/bkfOHAUPPPoDRDN+eEV0oCS57S5
	 +tWGDTyO2t/Q8KI+ohMY2z3JrpiSpYL6ZE7m6wJtC0pksASUKfxfWqMBn4ArAkNXT4
	 gIQ4OnBTPGT2Go3o3BZQGKc69hWan2AfPZxZxE7OyA9QtGx+wYUwyDqn3IhpIHSica
	 Q5Y73tbvK2IvJkDsnbANU2+YYChtWgDyiEmVdQf5Mzm4zJvNluy9Z00fExnr+lxTS5
	 d35LeRDfuXI8w==
Date: Tue, 10 Jun 2025 15:44:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P transfers
 in a single bio
Message-ID: <20250610124448.GC10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-2-hch@lst.de>

On Tue, Jun 10, 2025 at 07:06:39AM +0200, Christoph Hellwig wrote:
> To get out of the DMA mapping helpers having to check every segment for
> it's P2P status, ensure that bios either contain P2P transfers or non-P2P
> transfers, and that a P2P bio only contains ranges from a single device.
> 
> This means we do the page zone access in the bio add path where it should
> be still page hot, and will only have do the fairly expensive P2P topology
> lookup once per bio down in the DMA mapping path, and only for already
> marked bios.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio-integrity.c     |  3 +++
>  block/bio.c               | 20 +++++++++++++-------
>  include/linux/blk_types.h |  2 ++
>  3 files changed, 18 insertions(+), 7 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
