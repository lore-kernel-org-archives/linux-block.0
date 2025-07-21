Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C071E9B0B
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083573; cv=none; b=etR6jqA7xyx5C0sMVgceorRfR3zKZV4EjQvkggklWnYbjmT/S/C2Esc7VXbt0AL55l1IM85M8rlOplNgs17NWaXjW+m2o8om+G9b8WE4GJ/jfKONA2AMfCGfkVHJaEzgO5pEtvbcWpr0J69VHPuF+lICpci5Paj8IXPGYvQ2zSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083573; c=relaxed/simple;
	bh=MUdhk+arQ5ws5KVkMNtCLf45nq32xl0IBWJ+fAdxvNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xe5Zoepd4AvEKkHFzOvbMkM58h3Z03aDCag/6BzvHBSlHBrcScW5g8MeMZCpmwNNZ5R0AdA+gZTQ+Zt1wRztjYHKBX9+dLenG6RIveKaga0ACNOESUFRQlpUXvHyI3UoDPCl4Zr2rT5Gta3f+v60zp5DItQtyCaTaWrkkWZOTQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 594E568BFE; Mon, 21 Jul 2025 09:39:28 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:39:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 3/7] blk-mq-dma: require unmap caller provide p2p map
 type
Message-ID: <20250721073927.GC32034@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-4-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jul 20, 2025 at 11:40:36AM -0700, Keith Busch wrote:
>  static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
> -		struct dma_iova_state *state, size_t mapped_len)
> +		struct dma_iova_state *state, size_t mapped_len, bool p2p)

Nit: can we names this is_p2p as that makes reading these boolean flags
a bit easier?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

