Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1C723817D
	for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213432; cv=none; b=iSNcr+sXsS3jRZtkiDkL7H5yaUiNVq0arRx0eH01E4zWuQ3YhRaFJ5fasxaTx76tN9IFx0UhXFExpfX6pNEWH/4Ly//mU6K+xPKiL+MuEyGdWCEIJEKhTT3mZYcxBz2kCTdimrQYqe9zq65ePDzBnCOjVtPR8ifnnzFiEGxx37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213432; c=relaxed/simple;
	bh=LK7t16I2oWvVomEm2jVsC4K7LY/nsRp5aYNHBQOSqFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpQAI64FiTUrQ0/7Zv2dwS5hyeI8SbOSU3AA5TYRvKjhaBQxmVxH6kCUJX9y6LSaKkL68vdxM9/DM2A4od+owhQKojAzHt+ArnrtDVW2xf2cI5PwNC2GEDIfPbHdi6SecD85lvAdeju6ofUqfR6Ez4e90mGBByleRBLTOABNyhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A230067373; Tue, 26 Aug 2025 15:03:45 +0200 (CEST)
Date: Tue, 26 Aug 2025 15:03:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, iommu@lists.linux.dev
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250826130344.GA32739@lst.de>
References: <20250821204420.2267923-1-kbusch@meta.com> <20250821204420.2267923-2-kbusch@meta.com> <aKxpSorluMXgOFEI@infradead.org> <aKxu83upEBhf5gT7@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKxu83upEBhf5gT7@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 25, 2025 at 08:10:59AM -0600, Keith Busch wrote:
> On Mon, Aug 25, 2025 at 06:46:50AM -0700, Christoph Hellwig wrote:
> > On Thu, Aug 21, 2025 at 01:44:19PM -0700, Keith Busch wrote:
> > 
> > Also use the chance to document why all this is PAGE_SIZE based and
> > not based on either the iommu granule size or the virt boundary.
> 
> This is a good opportunity to double check my assumptions:

Always a good idea!

> 
> PAGE_SIZEs, iommu granules, and virt boundaries are all power-of-two
> values, and PAGE_SIZE is always the largest (or tied for largest) of
> these.

I just had an offlist conversation with someone trying to make a nvme
device with a virt boundary larger than PAGE_SIZE work.  No idea
where that device came from.

I hink IOMMU granule > PAGE_SIZE would be painful, but adding the
IOMMU list to double check.

It would also be really good to document all these assumptions with
both comments and assert so that we immediately see when they are
violated.

