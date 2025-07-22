Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3C928C85C
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163387; cv=none; b=SPMfKC9SMJMIXKSqVhnE8XOmO95Mfvw0+TrmckcW/X2L16U5E4fY7b+iLqzPb8S3XFV3mkFtSdvqP2Gyv1EvBeg6TmJlSacR05+fw9Y9xynRjebmZpu/ueiT9FW+kiR6eOcOgl4f3Ee9Y3eJpwrsZyQ/dpmrjzD/GOD11krk0Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163387; c=relaxed/simple;
	bh=b1stE+etoOcBpj3mwS58xWwSsIPPB50ZWXvXwNcHBLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvsV5MBs9KePRsNQMb6jxK38m4pHANDb8mHQB9uxf324jxlgy3TR1zoBhY6cjKAQTyxzHET4vw58nYsFugm/tr2UuemYi1+0rWyZPNjatXR/cszwYkXosIja2XSzeDrifDp5P8ToUY6RYa1Isqx4ts3v426NI1uGZahZLRgKOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6EDDA68AA6; Tue, 22 Jul 2025 07:49:41 +0200 (CEST)
Date: Tue, 22 Jul 2025 07:49:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, leonro@nvidia.com
Subject: Re: [PATCHv2 7/7] nvme: convert metadata mapping to dma iter
Message-ID: <20250722054940.GA13634@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-8-kbusch@meta.com> <20250721075053.GH32034@lst.de> <aH49fa1qH4HN5P7w@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH49fa1qH4HN5P7w@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 21, 2025 at 07:15:41AM -0600, Keith Busch wrote:
> > This should probably just set up the linear metadata pointer instead
> > of a single-segment SGL.
> 
> Okay, but we should still use SGL with user passthrough commands for
> memory safety. Even if we have an iommu protecting access, there's still
> a possibility of corrupting adjacent iova's if using MPTR.

True.

> In this patch, the nr_meta_descriptors value matches the sg_list length.
> The only real reason I need this 'nr_' value is to distinguish the
> single data descriptor condition from the segment descriptor use, but I
> can just add an iod flag for that too and save some space.

Yes, that would be great.
