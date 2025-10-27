Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACF31C6A3;
	Mon, 27 Oct 2025 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553025; cv=none; b=fFzS0bBPiwYpfwTOGvG9V6MvMMx4MTFG5t+vhtfMAhD6fJQa0SOK9phlXGVmELXZCMj/anVgTwRJapp+TfL8jdglo7DEn/iusAh2S5d8YbJdVaMYRtCNTn/fmiHU8kmSuv63cTwEyBs2e288FYIX/7uFqm1qfzxxHF+FAHkCsLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553025; c=relaxed/simple;
	bh=3s+c9UrgxVlE87z6LbpFebBA+Z7zC+mE0JUYrBr/dMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6vbqwq7OaBkkFHTJ2pm4aR47hkgFwkPuN9/kQ5Y6Gp0NPxULvCl6fBI7moo5GchN753xhyasBxNU4kv7begR7G4eIUR3WuhLfwG+AYeNtLGhwXb1sP1x35FJlh7C3IjKZ7f5MD2NuJl0KiB0O6jjKBsCpRQBkv2WKIn+2h4uZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 76B4A227A87; Mon, 27 Oct 2025 09:16:58 +0100 (CET)
Date: Mon, 27 Oct 2025 09:16:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <20251027081658.GA15229@lst.de>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com> <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com> <20251027074922.GA14543@lst.de> <20251027075738.GF12554@unreal> <20251027081142.GG12554@unreal>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027081142.GG12554@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 27, 2025 at 10:11:42AM +0200, Leon Romanovsky wrote:
> BTW, one can reorganize pci_p2pdma_map_type to make sure that
> PCI_P2PDMA_MAP_BUS_ADDR will be 2 and PCI_P2PDMA_MAP_THRU_HOST_BRIDGE
> will be 3, so it will be possible to take 2 bits per-type instead of 3.

Maybe.  I'd be happy to leave this as-is and then see if we can optimize
things once we grow more users.

