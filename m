Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45FB3F0776
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119991; cv=none; b=WQxEJmU2LSJRWtAbcPo/zJsDyrr7h9RPncLVkL2pY5lt1J5FCPIAbU3l9SRsqBdMDSwNkag0KpPnCRvUqbX1acqqR3yGyMXWTrVNpwI9ub6yXE0ybvn1nFQ80IN/U8AQreT5610SQFKJfMr1ymKsNj5fog5S6+aVmbemSbjSMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119991; c=relaxed/simple;
	bh=Kg7B5auV9tXADYowXxsGxpw/09xnFCG5b5bDhOol+Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nj1znbs0NijfIXqP0xuTiB7Sllrv8q2kw6HiOrQqOzxwytN0ZA5AQVHPgMJqTLoUFVhW+U/l+SO8avoMGpTyl5zGCreQVa9R8ev7808biR3hmNTZk8X5Oakcb3AR8lmE2mPfxMZF9NKfrKLXIutDzz6UUdcGak3tXRvTSzGvgzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7775068C4E; Thu, 26 Feb 2026 16:32:58 +0100 (CET)
Date: Thu, 26 Feb 2026 16:32:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, wagi@monom.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2 1/2] block: move bio queue-transition flag fixups
 into blk_steal_bios()
Message-ID: <20260226153258.GA31398@lst.de>
References: <20260226031243.87200-1-kch@nvidia.com> <20260226031243.87200-2-kch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226031243.87200-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 25, 2026 at 07:12:42PM -0800, Chaitanya Kulkarni wrote:
> blk_steal_bios() transfers bios from a request to a bio_list when the
> request is requeued to a different queue. The NVMe multipath failover
> path (nvme_failover_req) currently open-codes clearing of REQ_POLLED,
> bi_cookie, and REQ_NOWAIT on each bio before calling blk_steal_bios().
> 
> Move these fixups into blk_steal_bios() itself so that any caller
> automatically gets correct flag state when bios cross queue boundaries.
> Simplify nvme_failover_req() accordingly.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

