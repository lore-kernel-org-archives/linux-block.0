Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C431BC5C;
	Mon, 27 Oct 2025 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547772; cv=none; b=ZrVHolKYYnc1+cCaV216glRRNPqbnZfmp0qkGtE/NZyqr4n2ped/DjxJdK4nNaqE1gfbb86Cz2u86/xeFh2J0JrQAPYa0ukCSuszYMPT3GC+9QIeYx2SpZH4awzW4Tp5V/AgFkIDsnfndtEDL76JfQBO7gUpvYOIUBkuBbioGis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547772; c=relaxed/simple;
	bh=dy3hG9lcSRFajtflUdOASNs8cxHjWZ3khoJ1Pn+foxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFzMdSWncX5mj3hMlYRF6bMUEOL68qiA70+V6iSVYr8IwdVYSVLLvUsVVbwNjqxTJnOQbNPDBj07Uqmn314d5bsmd52EFXUdZOb+4p/ZLI1KhEjcPBgpIbksKu/cT9L0emxeGynbno+XKqdtwMw1wCttZm38VN6Gm+kj8x0zjis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4660C227A87; Mon, 27 Oct 2025 07:49:26 +0100 (CET)
Date: Mon, 27 Oct 2025 07:49:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/2] nvme-pci: migrate to dma_map_phys instead of
 map_page
Message-ID: <20251027064926.GA13214@lst.de>
References: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com> <20251020-block-with-mmio-v2-1-147e9f93d8d4@nvidia.com> <20251022061418.GC4317@lst.de> <20251026123804.GD12554@unreal>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026123804.GD12554@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Oct 26, 2025 at 02:38:04PM +0200, Leon Romanovsky wrote:
> On Wed, Oct 22, 2025 at 08:14:18AM +0200, Christoph Hellwig wrote:
> > This actually has block and nvme bits, so the subject line should
> > say that.
> > 
> > > +	unsigned int attrs = 0;
> > 
> > attrs is always zero here, no need to start passing it for the
> > map_phys conversion alone.
> > 
> > > +	unsigned int attrs = 0;
> > 
> > Same here.
> 
> It gave me more clean second patch where I only added new attribute, but
> if it doesn't look right to you, let's change.

The usual rule is do one thing at a time.  There might be an occasinal
slight bend of the rule to make life easier, but I don't think that
really fits here.
