Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596221BBBCD;
	Thu, 10 Oct 2024 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728546844; cv=none; b=ahq0BFZXQX+EbP/5DnbRHTur1CLKsAyFmTYT6EtQeFGRD/JkoH/fCo+GIYqz/4RwLO77mABfdM3NjObk3HpoF+RvjHug5WjJFkCfPjbTYD5KUmtON7TLw80gFqAhAdIimjO0EmTUk/DpXNGx6UEpn7sVxFCC98s+ClWFuEB4WFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728546844; c=relaxed/simple;
	bh=0bdHFbtrmDVKMpJol5tXaerKItGaRETRvqUGqTpUxuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggIxqaN6KRVIbtsxExQzFQ/3P6bWGhdfOTbCu5ycGMtJmH6eET71XMGaOXJ+Ooq329ZOBTQJ/wiPjkjuwS2ZnMSedwgeREK3DrsTFIg6VkAdPOFqN9DX4IyiCVGex8q7c1Yxs3iI3ruB1/dESskmAvDGwgcTzRn0AP/sz6TTf+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 15AD9227A8E; Thu, 10 Oct 2024 09:53:52 +0200 (CEST)
Date: Thu, 10 Oct 2024 09:53:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
	dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 1/2] nvme: make independent ns identify default
Message-ID: <20241010075351.GA7525@lst.de>
References: <20241008145503.987195-1-m@bjorling.me> <20241008145503.987195-2-m@bjorling.me> <20241009074611.GB16181@lst.de> <ZwaZoJayzu6XZom1@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwaZoJayzu6XZom1@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 09, 2024 at 08:56:32AM -0600, Keith Busch wrote:
> On Wed, Oct 09, 2024 at 09:46:11AM +0200, Christoph Hellwig wrote:
> > On Tue, Oct 08, 2024 at 04:55:02PM +0200, Matias Bjørling wrote:
> > > However, the independent namespace data structure
> > > is mandatory for devices that implement features from the 2.0+
> > > specification. Therefore, we can check this data structure first. If
> > > unavailable, retrieve the generic attributes from the NVM command set
> > > identify namespace data structure.
> > 
> > I'm not a huge fan of this.  For pre-2.0 controllers this means
> > we'll now send a command that will fail most of them time.  And for
> > all the cheap low-end consumer device I'm actually worried that they'll
> > get it wrong and break something.
> 
> We already send identify commands that we expect may break on pre-2.0
> controllers: the Identify NS Descriptor List.

Identify NS Descriptor List is mandatory starting with NVMe 1.3.  We only
issue it for 1.3 or if the controller advertises supporting multiple
command sets.

