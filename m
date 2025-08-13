Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883A424290E
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100420; cv=none; b=o1/gAX/GngG+A8Msomn59FGyKFTZpL+CedrW3QKey1yGl71yXAnEc3+jfxlIFe5e1bHIHOczqTOIgCtL+nAZxWrtXKbwdvtW/5NvmKh7bnaNMqJy/6PXbnGfONdXXDs0NPpNBPu+z94IiwYLIZmROPQlcn7IpTnfFLZ59mt5u5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100420; c=relaxed/simple;
	bh=R97KMw9VoUHtTX1b6fN8J1Ssl0uFnDdTkRK9lOppuG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTDgNz6bSOc8arEzZm7XsxSU9Cu6Nkd18EQdRwxWL3T5IHnvzZr4YP/feDmOxt6WNi9pY83ssWT/QU2qQztHetNpyCVxrmt0Wn0X8Gw/gf7dcnGhCNbe340ITKbaNdsdibM0YDPAGcKbS6Ynj5hybaAEre6F+YYBc7+rryuOd24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 22FC8227AAC; Wed, 13 Aug 2025 17:53:31 +0200 (CEST)
Date: Wed, 13 Aug 2025 17:53:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv7 4/9] blk-mq: remove REQ_P2PDMA flag
Message-ID: <20250813155331.GB14188@lst.de>
References: <20250813153153.3260897-1-kbusch@meta.com> <20250813153153.3260897-5-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813153153.3260897-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 13, 2025 at 08:31:48AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> It's not serving any particular purpose. pci_p2pdma_state() already has
> all the appropriate checks, so the config and flag checks are not
> guarding anything.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

I think I've also reviewed this before, but:

Reviewed-by: Christoph Hellwig <hch@lst.de>

