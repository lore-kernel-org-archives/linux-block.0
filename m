Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1871CB9F0
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065864; cv=none; b=sREkyW8K4Ic0n1EZRO4VRoQVSuxtsMMVdG1xpFGhzScecWgx40lJDrA8bgVHb0rKuxZyLAuGBNhM9UKP9NF5j7ppiUoosM1cSpqkn2G8tPhVRu7UcuHRgsStmgD9ggLE4OHrxsY7g7vnCYITvbuGtdUHD8t5FRG5sRVd2LQATdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065864; c=relaxed/simple;
	bh=KdToTAAO2lF+pPPO/W70wK6PlA0xDE7s6k62ZTITOa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qS/t3mTePCycTL5XPaXN8Fmmc+zNkf/kvNEqsbN2np+bRxdRfW/58VPOQgv5frts2dwKlxmoDb4CUbIevp2R8lKyhIJrvwBxl2NnT0D8dXxHKc+5gRJUqgkKcrXWrubJmRA7pZw65SSjX064HWOfI+tAVjefhrjQlmfKBGIOnhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C935F227A87; Wed, 16 Oct 2024 10:04:19 +0200 (CEST)
Date: Wed, 16 Oct 2024 10:04:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [Regression] b1a000d3b8ec ("block: relax direct io memory
 alignment")
Message-ID: <20241016080419.GA30713@lst.de>
References: <Zw6a7SlNGMlsHJ19@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw6a7SlNGMlsHJ19@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 16, 2024 at 12:40:13AM +0800, Ming Lei wrote:
> Hello Guys,
> 
> Turns out host controller's DMA alignment is often too relax, so two DMA
> buffers may cross same cache line easily, and trigger the warning of
> "cacheline tracking EEXIST, overlapping mappings aren't supported".
> 
> The attached test code can trigger the warning immediately with CONFIG_DMA_API_DEBUG
> enabled when reading from one scsi disk which queue DMA alignment is 3.
> 

We should not allow smaller than cache line alignment on architectures
that are not cache coherent indeed.

