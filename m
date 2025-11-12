Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE3934889A;
	Wed, 12 Nov 2025 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972249; cv=none; b=Qq9jCx3dFq5ouKXOgiuN2g+DQZ+kuYXniJHEu5uVVMZ4fTWd+kNtPRHCWf8OzifQczqwDgbrz6+/BpYBeVlyH4mw3xcnPx5Hx4CT0DhPe5Bs6pe+U9fdJ+vF9NqEmPkOdXXjdZ9GZZkKm08BpoLSGRRgVuPKPfigqFnBAqd33y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972249; c=relaxed/simple;
	bh=CNUuHy/bpt4vT9lybSu7TmV/AB42+O/pew00JBqknEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ep5Vm4dhwd0qqITM4i8B8WlHCMNAqBSTSaTVxlrrNSwF0xDzHfojaQdvPdi4Kho3Hjv/XTz54034p26tQQxKUlD5mCyTtt65pXu8t+aoJD/JzPQUZEn/HWdFevNwVkgerjQelRvOZ5/ObZdACorNxTKW4reYW3Jk6tf5Km/DFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0q3oWbE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0q3oWbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627D5C4CEF7;
	Wed, 12 Nov 2025 18:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762972247;
	bh=CNUuHy/bpt4vT9lybSu7TmV/AB42+O/pew00JBqknEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0q3oWbEBImXCu7pv/1N4lXSKrIYXeALiciQ7vUEJAcW7Z3DHOQldOJ4COJS2eNj6
	 gJfu6pqiBaDj1+NWy2dV/IpBi2v2qTC7Rxc7TF+lXc4+rfEBNWe/5f+mUhmHOYxoBo
	 EL2mH54mGM86fUWRoJlEFNGD8qYocRntJqvvhfH5wmDLxZn9yOW7pBz93QaQCV/XjP
	 JNR11E4iY11h1gXstnR5sLOVnaCLcJcGFNvvH1SYFfRsFpw2aScDmQdYaz1hKtabqf
	 TmC/dsqZAjGvDQnj6PGzibnqjMLLYucIypQwafYwbSYXwDgxAj+XOJ/xA34qPq8E6f
	 RqjgKNcuDdlLw==
Date: Wed, 12 Nov 2025 20:30:42 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <20251112183042.GA10544@unreal>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
 <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
 <aRSbzwpS2AuP92_n@kbusch-mbp>
 <20251112151604.GF17382@unreal>
 <aRSmZ6IisXDmI9Yg@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRSmZ6IisXDmI9Yg@kbusch-mbp>

On Wed, Nov 12, 2025 at 10:23:19AM -0500, Keith Busch wrote:
> On Wed, Nov 12, 2025 at 05:16:04PM +0200, Leon Romanovsky wrote:
> > On Wed, Nov 12, 2025 at 09:38:07AM -0500, Keith Busch wrote:
> > > On Mon, Oct 27, 2025 at 09:30:21AM +0200, Leon Romanovsky wrote:
> > > > @@ -732,13 +746,20 @@ static void nvme_unmap_metadata(struct request *req)
> > > >  		return;
> > > >  	}
> > > >  
> > > > -	if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
> > > > -					iod->meta_total_len)) {
> > > > +	if (iod->flags & IOD_META_P2P)
> > > > +		map = PCI_P2PDMA_MAP_BUS_ADDR;
> > > > +	if (iod->flags & IOD_META_MMIO) {
> > > > +		map = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
> > > > +		attrs |= DMA_ATTR_MMIO;
> > > > +	}
> > > 
> > > This should be an 'else if' no?
> > 
> > We can't have both IOD_META_P2P and IOD_META_MMIO. It can be only one or
> > IOD_META_P2P or IOD_META_MMIO. In this case "else if' is not necessary.
> 
> I get that and I'm not saying this is a bug, but it just looks odd.

Sorry, I didn't get the intent.

Thanks

> You're checking the conditions as if they're independent of each other
> when they're not. If the first 'if' is true, there's no need to test the
> second one as we know it's false, but this code flow will test it
> anyway.
