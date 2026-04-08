Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19FA35CB8B;
	Wed,  8 Apr 2026 06:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775628516; cv=none; b=PEIuklV0DqXxSQtU3ED6vYc/1pRB1vKlgyGe1Qs+7xBCsRcAutUiQTjvviJqiRxVFG+hsYFsA8bwxhfMLgjH4CWC90B1dcLGacSPoCuC2bHclhonjBhr4bA3icvfulPdYwGWfv/j03v25qQ+6mtqCVRhGMdcUmXltbFZQWGSCNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775628516; c=relaxed/simple;
	bh=sEXlTf/MCChKynZoLjrjMnGcWzPWtiEzsbg1VGb/G7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI5iyWPcv4HyLHlTDUJc9XhjKKkV7Hp3pmTDNg03CAi7tl4ZwLRoY7uTul/PBgN1S4B/4moDqhz0nmW0pLVt8ASniRzRodyhrxzj9yghyBjIm5l7RTVMq00FbUpeT0qwRyHMr2/9SJefn/xD0GHHuYk+Um8aXyMyTl2bBgTFJdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4019668C4E; Wed,  8 Apr 2026 08:08:26 +0200 (CEST)
Date: Wed, 8 Apr 2026 08:08:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 2/2] block: allow different-pgmap pages as separate
 bvecs in bio_add_page
Message-ID: <20260408060825.GA24532@lst.de>
References: <20260401082329.1602328-1-namjain@linux.microsoft.com> <20260401082329.1602328-3-namjain@linux.microsoft.com> <20260401140850.GC21703@lst.de> <70c82c3a-d135-4877-ab46-c15d329815f5@linux.microsoft.com> <20260402053057.GA11783@lst.de> <d48427c2-9aa3-42a2-a8d7-43a7a3b3b685@linux.microsoft.com> <20260407055247.GA6405@lst.de> <6106a655-2d4b-4ebf-b269-459e3bd3efd4@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6106a655-2d4b-4ebf-b269-459e3bd3efd4@linux.microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Naman,

On Tue, Apr 07, 2026 at 12:38:30PM +0530, Naman Jain wrote:
>> So the zone_device_pages_have_same_pgmap check should go into
>> zone_device_pages_compatible and we need to stop building the bio
>> as well in that case.
>
> Ok, so rest all things same, from my last email, but my previous compatible 
> function would look like this:
>
> static inline bool zone_device_pages_compatible(const struct page *a,
>                         const struct page *b)
> {
>     if (is_pci_p2pdma_page(a) || is_pci_p2pdma_page(b))
>         return zone_device_pages_have_same_pgmap(a, b);
>     return true;
> }
>
> This would prevent two P2PDMA pages from different pgmaps (different PCI 
> devices) passing the compatible check and both get added to the bio.
> Please correct me if that is not what you meant. I'll wait for a couple 
> more days and send the next version with this, and we can review this 
> again.

This looks good modulo the tabs vs spaces in the indentation.

