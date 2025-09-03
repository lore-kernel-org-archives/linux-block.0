Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED92D97A0
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887635; cv=none; b=siZ56DrfCRYQeySbhGPzPw5GSdLOYmXoS6GeEZF2SZRIXSfTPtk/eTbu9izFjtHsnQqmOC5fWP/Nc31aVeLIiWwebMP0qdO1z53ZUYh4R2ABfKcFrdMaPliokozMbBpIf7TbR9Uxy2oZlLrHFKDCJmX6DxbEcFkYTZrrp1apwe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887635; c=relaxed/simple;
	bh=4us/JiNGyyrs1E2mZPfotIPzzrOl7wDbBGjrnF20ulI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfMdGYCr3o1vPBIWsJay18M0nIGi9ArnzVFpm7ivACb3UwOSzQ1bxIJnFztxQ0z8lnzAxvom9gLfSO0uGs0zb7N3/l2xFcNFdkwfGQaQfAOnQDTUZe5ZaJrl6am1AViBsexfXvBpPcLHWx+4BMepifHNs3Je4nWSXosYMb76B7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0/Oj2+L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0/Oj2+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC15BC4CEF0;
	Wed,  3 Sep 2025 08:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756887634;
	bh=4us/JiNGyyrs1E2mZPfotIPzzrOl7wDbBGjrnF20ulI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0/Oj2+L6B0v9fV5Bbt8gwblJ/pFlIqW+QAC0oqsd2a6T/covNIJza3ENaF87vAP2
	 6W+pKv8n/OLFSju4g8AxWnJtSeU3kxAB9FTpSQzzG8n38BncuGpZRfwdXubLVJ4ru4
	 SEx6WlSpeJaOuOJvtRYAalM5TWmQhGAItn1BfhA9yUGY1wCfH5I5ZBnFA1rlxvFeKX
	 iDP6DDKnwz1XyfktB+Pbpx+vMCucC9R2huAuoOUndFzcW13ZdzJ6pPVH1lZ+hHjem0
	 lvHEg21/Wi6uS6um6sTwNs7mAKP83LUwPi64NNqwYbyaUfgpSnTZw4DZH6eK+aNLZy
	 tWzmr7O5oP1mw==
Date: Wed, 3 Sep 2025 11:20:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, martin.petersen@oracle.com, jgg@nvidia.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] blk-mq-dma: bring back p2p request flags
Message-ID: <20250903082030.GA5608@unreal>
References: <20250902200121.3665600-1-kbusch@meta.com>
 <20250902200121.3665600-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902200121.3665600-3-kbusch@meta.com>

On Tue, Sep 02, 2025 at 01:01:21PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We need to consider data and metadata dma mapping types separately. The
> request and bio integrity payload have enough flag bits to internally
> track the mapping type for each. Use these so the caller doesn't need to
> track them, and provide separete request and integrity helpers to the
> common code. This will make it easier to scale new mappings, like the
> proposed MMIO attribute, without burdening the caller to track such
> things.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-mq-dma.c            |  4 ++++
>  drivers/nvme/host/pci.c       | 21 ++++-----------------
>  include/linux/bio-integrity.h |  1 +
>  include/linux/blk-integrity.h | 14 ++++++++++++++
>  include/linux/blk-mq-dma.h    | 11 +++++++++--
>  include/linux/blk_types.h     |  2 ++
>  6 files changed, 34 insertions(+), 19 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
