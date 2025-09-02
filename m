Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA621E5B71;
	Tue,  2 Sep 2025 05:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791375; cv=none; b=EUUoZ1byjKBMWftUb+xlZegbIj3+nWuQqo2xfKPX7OFobIfTXpJ5UrxbP072AxwqPy+fvmTb50KcRfKcyzsvjgBy0rAhafq9rHmgF037EUHIHEjSQ4WCJGBYChHT4P18qxfFnNpPAR6VCLxcf/22nDw1JCIlyp9RwE1AfXSU8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791375; c=relaxed/simple;
	bh=tHL3AD9YoFk15zlZ59e5+khJ6OCA/HBCyPSvZjg7Pxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4ssWaH0Enx2qG7GeRPTT5Qqv8BRLebJ06ezdCNd2Av6VOc5SRJ+YVwPVpxtt8K4xcJmPoWeuxjxch+C77u17lVG7ME6B6PjM8W8/bB0yte8aFxlJcBuCCx1DHE4B+iKULF5Qy99nwOs5W0RG5p6TkGh58fD9Ria8Wg7ax+aQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5E5D68AA6; Tue,  2 Sep 2025 07:36:08 +0200 (CEST)
Date: Tue, 2 Sep 2025 07:36:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	iommu@lists.linux.dev, willy@infradead.org, netdev@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250902053608.GA11396@lst.de>
References: <20250821204420.2267923-1-kbusch@meta.com> <20250821204420.2267923-2-kbusch@meta.com> <aKxpSorluMXgOFEI@infradead.org> <aKxu83upEBhf5gT7@kbusch-mbp> <20250826130344.GA32739@lst.de> <aK27AhpcQOWADLO8@kbusch-mbp> <20250826135734.GA4532@lst.de> <aK42K_-gHrOQsNyv@kbusch-mbp> <20250827073709.GA25032@lst.de> <aLJYPGKE4Y_6QzY2@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLJYPGKE4Y_6QzY2@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 29, 2025 at 07:47:40PM -0600, Keith Busch wrote:
> On Wed, Aug 27, 2025 at 09:37:09AM +0200, Christoph Hellwig wrote:
> > On Tue, Aug 26, 2025 at 04:33:15PM -0600, Keith Busch wrote:
> > > virt boundary check. It's looking like replace bvec's "page + offset"
> > > with phys addrs, yeah?!
> > 
> > Basically everything should be using physical address.  The page + offset
> > is just a weird and inefficient way to represent that and we really
> > need to get rid of it.
> 
> I was plowing ahead with converting to phys addrs only to discover
> skb_frag_t overlays a bvec with tightly coupled expectations on its
> layout. I'm not comfortable right now messing with that type. I think it
> may need to be decoupled to proceed on this path. :(

willy got really angry at this for all the right reasons, and we
still need it fixed.  Can we just revert the unreviewed crap the
network folks did here to move the kernel forward?
