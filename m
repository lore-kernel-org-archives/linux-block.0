Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F463FD1
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750078926; cv=none; b=EQU4j59AvVX3QDDl1F6nwSRlUva4jpGsEnjxl3hHLC+qJZoqhsUsIv5rOSNqLXJuiHpIh8rg83f26pSStEWC2Rg4zlqZlbPg29LAehyvnV10NccoG0EBAXH4Jv3PvXI4fVJgTkMUemxoZSI7bM6eYMdLDRC7glgwj8k9CwcDhUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750078926; c=relaxed/simple;
	bh=xMZ7vG+5LewdiNU4hlUZUaiSxp9SxjHd9xtudsGnlxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icb8FA1BH4+7d0DgAsWSnBNbmDYoSGiy9fvRcYh+yUXjGGzDEbunDhCi+BzHSwGQ+JHsQ/f2XsVSIyjzxrrwaXhAwzT4EfmXO/+S5XbzY7aS3PnlYwW4/lZPUEzmdo9YqRrD5INozSeqwbyIln3mkbjIOnBvTFxwgEUustl3tYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4B9D567373; Mon, 16 Jun 2025 15:01:59 +0200 (CEST)
Date: Mon, 16 Jun 2025 15:01:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
Message-ID: <20250616130158.GA28914@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-3-hch@lst.de> <dab07466-a1fe-4fba-b3a8-60da853a48be@kernel.org> <20250616050247.GA860@lst.de> <2105172c-5540-40d0-9573-15001b745648@kernel.org> <20250616113141.GA21749@lst.de> <4973015e-ecb2-4bd9-ac26-05927fa8fbd4@kernel.org> <20250616124205.GA27570@lst.de> <2c210c03-9213-4c62-aa4f-2803b6d0ef0a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c210c03-9213-4c62-aa4f-2803b6d0ef0a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 02:52:15PM +0200, Daniel Gomez wrote:
> It should be valid already. But if the initialized value at line 160 can be
> changed through the previous code then, this should suffice:

Why?  If pci_p2pdma_state returns something other than
PCI_P2PDMA_MAP_BUS_ADDR or PCI_P2PDMA_MAP_THRU_HOST_BRIDGE, BLK_STS_INVAL
should be propagated up the callchain.

