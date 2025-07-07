Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55315EEDE
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901223; cv=none; b=TnOTySpVXDslRXOBFNdPeiwd85YvBvZRyaSJwrw60lYEcbplLR1d7qBSri2oT1fnidQwtMrrK3l/H5DqHwyQ5XnKF/V4lQlls/Jz/5R/v8aXFfFOiyVami5Ir2mDKnPNHKDlxa3wyDZifsu2ZmHiTplYDHtmgAXRg9sIN308UOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901223; c=relaxed/simple;
	bh=2NVZxjr92+sQKDR41ncVJhGFd6vWuk+6KzB7YIEW2f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=db+sVJNvaiCbho/JPhNfZTPqcHA68w7Bb0uOWpyLeyFdECYq+GMr7UjTdZOT4UwpDgstCZgSHbree9zYaZ/6+/e77KglgatYaO6wCHthIud4X43+oSOlp+Gbltl+M788liQZOUFAgrJrJE+yKKBiSYzriEm4oV8Y/U+roo6hEzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l55wWOT2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l55wWOT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7752BC4CEE3;
	Mon,  7 Jul 2025 15:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751901220;
	bh=2NVZxjr92+sQKDR41ncVJhGFd6vWuk+6KzB7YIEW2f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l55wWOT26aAcfqKiPwk6nodQ/u2UdoRXI02XVWZ/PrMmmp7hK7fKuAb9Da0DB0yjs
	 vaI5eH3dopkcKc7tql7C16MGAsiExw0IXU8OgCmkX6dImHvydB2SPOYg9Npa9Y/qL1
	 n1HN+0iFS3btUDTziZCHmFeCSAC4Sn0xP6G2RTuzZ1RinmIYoyb1oKErGxuEYD+o7e
	 MfCnK03CMKBz69k3MXzKZcJwoyFhdp2E4fq2kLHVXm/cCd4jTl/8SBhH70KExdoRzK
	 QKn5vBMZXZZphnkUXCQ9fJXzfT6arvT4mDQRp2liEm5hg/t28Y21xRhz6PjC+N1WsO
	 k0hPm1EynpaHg==
Date: Mon, 7 Jul 2025 09:13:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, sagi@grimberg.me, ben.copeland@linaro.org,
	leon@kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not
 using the IOVA mapping
Message-ID: <aGvkIt-j_QNo250Y@kbusch-mbp>
References: <20250707125223.3022531-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707125223.3022531-1-hch@lst.de>

On Mon, Jul 07, 2025 at 02:52:23PM +0200, Christoph Hellwig wrote:
> The current version of the blk_rq_dma_map support in nvme-pci tries to
> reconstruct the DMA mappings from the on the wire descriptors if they
> are needed for unmapping.  While this is not the case for the direct
> mapping fast path and the IOVA path, it is needed for the non-IOVA slow
> path, e.g. when using the interconnect is not dma coherent, when using
> swiotlb bounce buffering, or a IOMMU mapping that can't coalesce.
> 
> While the reconstruction is easy and works fine for the SGL path, where
> the on the wire representation maps 1:1 to DMA mappings, the code to
> reconstruct the DMA mapping ranges from PRPs can't always work, as a
> given PRP layout can come from different DMA mappings, and the current
> code doesn't even always get that right.
> 
> Give up on this approach and track the actual DMA mapping when actually
> needed again.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
