Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7143F86F4
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979054; cv=none; b=RThxJFE9ZtVCPP3+4Sd7PcS5ACMcHqxdQaoae4lCVqFwudD6sN3N21rSGExmdgUh246o54ww5rVrhqdvFopAM5NsVMMGQ7E0lWuCyoLtxsH52LQxgs05KL0rV/I87rZXbqLHmIwcS7VvPNibcySqr3YX3orbHoIArI5Voygn4sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979054; c=relaxed/simple;
	bh=tw2NclNL1E2gSTC9BU7C9BrZsUMWs58xZSXMZWe0Ntc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDm5Idhu3GSW4lGPQwvrDwDDZIusUzhbCYtO67ls5fD1QDQAJHNp+XMvcO7KjxxDO9FxbG3e+wGmQHrDPMbogWNtOMFb45+HPLHgpU21n8iF+5VdIdgMSyJnzmH7az0htdAt5UZvjIpI2tFwzJBZ4mAiojB7NmYA45l1R9opYII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ7zjmLQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ7zjmLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C691F00A3E;
	Mon, 17 Aug 2026 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786979052;
	bh=jm7PcU8Aa1TRTh8v7z0Hd1RwXA20VkWp1Jxa2fvIwWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VQ7zjmLQEkog4fy0l/zQG1M2x9CmrCLxOMaTLPcjSOOxXJXxZYrg3ZWbcSd0TH2PA
	 FOYIe9rQM5vQ2a4y4Z0WQFL308LwfGp+KdZOjX/en57jr7K+GG9pTwUHkq+DGZqKaY
	 IFKbEOeRSi6oUSTwDgY3nljN6e7Skdr8zM+XsCSRFhjtEyoln8DA1Yl9u5F6RotcBL
	 i2BhuURMAf/Hpji64nGxPzT1JmqF/WRW7VfgMyAz2y4u2Z7AbLGsKHAXQYbiGGu9hS
	 g8XBfyK7BWvbuO2rpCvf0rHfQUmam6rwOGe7StIsjng4BAsUYyDq4o0NXbc9XqLxrT
	 m1xZdBbCNObcg==
Date: Mon, 17 Aug 2026 09:04:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Auger <eauger@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, Jeff Moyer <jmoyer@redhat.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <aoMi6y2qsnRVembg@kbusch-mbp>
References: <20251014150456.2219261-1-kbusch@meta.com>
 <20251014150456.2219261-2-kbusch@meta.com>
 <1805eed3-90ec-4f62-9d71-e3f898a464ad@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1805eed3-90ec-4f62-9d71-e3f898a464ad@redhat.com>

On Mon, Aug 17, 2026 at 03:23:14PM +0200, Eric Auger wrote:
> >  
> > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > index 449950029872a..94d3461b5bc8e 100644
> > --- a/block/blk-mq-dma.c
> > +++ b/block/blk-mq-dma.c
> > @@ -79,8 +79,7 @@ static bool blk_map_iter_next(struct request *req, struct blk_map_iter *iter,
> >  static inline bool blk_can_dma_map_iova(struct request *req,
> >  		struct device *dma_dev)
> >  {
> > -	return !((queue_virt_boundary(req->q) + 1) &
> > -		dma_get_merge_boundary(dma_dev));
> > +	return !(req_phys_gap_mask(req) & dma_get_merge_boundary(dma_dev));
> 
> I observe a regression on RHEL due to that change in
> blk_can_dma_map_iova() with a 64kB host. This also occurs with upstream
> (7.2-rc7).
> 
> For an NVME device blk_can_dma_map_iova() now returns trues while it did
> not before. And it seems it shouldn't because it then causes some errors
> on the dma_iova_link() path due to unaligned iova:
> 
> [ 4486.655564] iommu: unaligned: iova 0x14c34000 pa 0x000010764d790000
> size 0x1d0000 min_pagesz 0x10000
> 
> It occurs when launching a 4kB guest with virtio-blk.
> 
> I traced:
> nvme 0015:01:00.0: req_phys_gap_mask=0xffffffffffff0000,
> queue_virt_boundary+1=0x1, get_merge_boundary=0xffff

The first thing that looks odd to me here is the page offset in the iova
isn't reflected in the pa, so I think something in the construction
isn't setting it up the first vector correctly.

Thanks for the notice, I'm looking into it.
