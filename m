Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACA2D46A2
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103744; cv=none; b=TatRs81eZz15arWRDaCdSZTG+ulqGy9e6+xYThjE5ScikCEVnJO8gD97XkJDFjrbKfkAkMeDN/ITAwswWMHDoj83BRoYIdn3GP2i89PXFUXnO8OX5fczrlUMl0cFlzOTQCfEQnPSh7QbEObn28K5+Ha+dPq/zKU84yJzIjn6KLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103744; c=relaxed/simple;
	bh=mwwxA6mQpFGv/fMSObulRQgthQ8CoywztVNbwD6LVJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBMZ931sj9DCn74c4Q6MjJ1IrAwCu7Kh30kR22wLy/QybvcDydAGCzzdDDa+iXXZ63rxQ0YrHFyybWQQBtf7vheZB+NbwsbiNq7Y5jwl4sxBXUQp0MKIKb/caL2JErxDDZFYkvwYwT90z6zCiT4MdIs9x6njNc488JpVE2+isKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8Uf7fF3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8Uf7fF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3752DC4CEED;
	Mon, 21 Jul 2025 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753103743;
	bh=mwwxA6mQpFGv/fMSObulRQgthQ8CoywztVNbwD6LVJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8Uf7fF33mwkmPDNI8ecdi4l0ppwuaq4Om6A7aSvZwa1VrdzDYOKFaqox6IaOeoFJ
	 R4qCH8CUcFUPlq7twRUvsn6yp3HlkTbLpVcM4lk2qEWDvq6ynuTCgmpGSnxoN/r1LP
	 pU55/I0GFR/i6JcriobOJzHYnKEJfrDwnPagTy4fD7pZ5zyn/whO7YuHayIIJ/tfPn
	 /LRGwHdzudKoc069TmYeBL82EqSfoeXYXzdEtTleX5nmwm2g91+cxADokV7nL7B2LW
	 rukV6sdececKdTkhUPOWuFEarUZwH6bly7BV6Vb/XFmM0Bg6urVnx1psXgJEa4Rh5h
	 9d2/CmH69tHuA==
Date: Mon, 21 Jul 2025 07:15:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk, leonro@nvidia.com
Subject: Re: [PATCHv2 7/7] nvme: convert metadata mapping to dma iter
Message-ID: <aH49fa1qH4HN5P7w@kbusch-mbp>
References: <20250720184040.2402790-1-kbusch@meta.com>
 <20250720184040.2402790-8-kbusch@meta.com>
 <20250721075053.GH32034@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721075053.GH32034@lst.de>

On Mon, Jul 21, 2025 at 09:50:53AM +0200, Christoph Hellwig wrote:
> >  	if (entries == 1) {
> > -		nvme_pci_sgl_set_data_sg(sg_list, sgl);
> > +		iod->meta_total_len = iter.len;
> > +		nvme_pci_sgl_set_data(sg_list, &iter);
> > +		iod->nr_meta_descriptors = 0;
> 
> This should probably just set up the linear metadata pointer instead
> of a single-segment SGL.

Okay, but we should still use SGL with user passthrough commands for
memory safety. Even if we have an iommu protecting access, there's still
a possibility of corrupting adjacent iova's if using MPTR.
 
> > +	if (!iod->nr_meta_descriptors) {
> > +		dma_unmap_page(dma_dev, le64_to_cpu(sg_list->addr),
> > +				le32_to_cpu(sg_list->length), dir);
> > +		return;
> > +	}
> > +
> > +	for (i = 1; i <= iod->nr_meta_descriptors; i++)
> > +		dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
> > +				le32_to_cpu(sg_list[i].length), dir);
> > +}
> 
> The use of nr_meta_descriptors is still incorrect here.  nr_descriptors
> counts the number of descriptors we got from the dma pools, which
> currently is always 1 for metadata SGLs.  The length of the SGL
> descriptor simplify comes from le32_to_cpu(sg_list[0].length) divided
> by the sgl entry size.

In this patch, the nr_meta_descriptors value matches the sg_list length.
The only real reason I need this 'nr_' value is to distinguish the
single data descriptor condition from the segment descriptor use, but I
can just add an iod flag for that too and save some space.
