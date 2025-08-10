Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC75AD51
	for <linux-block@vger.kernel.org>; Sun, 10 Aug 2025 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754834896; cv=none; b=eRVtukoZ+xRoCUVkQGJBcM4ThbF9ww1d6F1vNSUSRhpWHK04Iy0h+oT6o3wc7ZJFWmHbjYOs/4jHttD1tDinxDXdNSl1mBnzbfBdmwLElUx0wWCqAoKwCdBAAVU5TvPZzKszP61yiTXsqXLBx2kTYwSO7CrIgTumEdX0CcKoNz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754834896; c=relaxed/simple;
	bh=Ep6yeHqRAJpuiwro7/AABOz3vxFaeplBqfUhTAo9tCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVlQWX4vNbJpH7X1xVfnLf3EkHf9hPUuyB5mkvV85GdXSjRL1HPO7dBVORpTJzao0p8+evy9Cc4yHtbjkwuAGAyxhQlsPWKbJGJ1vMhcawP3SE1qVW8+oIPPW5C5j8l0OCMpxsW4wVSXrww33zzrAoy/fTAbnrJGbfT3o1RyDdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E258168BEB; Sun, 10 Aug 2025 16:08:10 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:08:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 3/8] blk-mq-dma: require unmap caller provide p2p map
 type
Message-ID: <20250810140810.GC4262@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-4-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 08, 2025 at 08:58:21AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> In preparing for integrity dma mappings, we can't rely on the request
> flag because data and metadata may have different mapping types.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

