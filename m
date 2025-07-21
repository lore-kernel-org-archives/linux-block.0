Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814CDF49
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084260; cv=none; b=R+OWH9eYA8CpXuMj9jMSc5pt8X6SNH7wgKAFMXAZEYbXcAakvUm0X/2Sq6li1cdKKnIZV8gqc8Z5WuUcWxVLbPYkFWq9K3FyjjWv3M8NS4LdyyXY6LvsIKetlcB5OMbloPhjq1uyw+SmudACkOtYKAKqYGD4pK23XdVJofJ0Tho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084260; c=relaxed/simple;
	bh=OvvC0RbLOZLfKfnrhS/laVui0toO8UHT7c23Di6F8yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESv+fkp6LP9tU6K5/sBY1y2WX6xznKFvSQr6tjgg+1UClJgVy0Fgde+RywU9W3xMUxbmYzfhHfWaRgIlknnBJ/B+30gTa5MO1UpOi42xHiqToQ7yXyIxpKyGCnmfa1R81E4Q4dm5LrXJ0Ns38NKoXGE3E7rIULqur/hYyVmBuLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 806DB68B05; Mon, 21 Jul 2025 09:50:53 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:50:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 7/7] nvme: convert metadata mapping to dma iter
Message-ID: <20250721075053.GH32034@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-8-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-8-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	if (!blk_rq_integrity_dma_map_iter_start(req, dev->dev,
> +						&iod->meta_dma_state, &iter))

Do the normal two-tab indent here to make this a bit more readable?

>  	if (entries == 1) {
> -		nvme_pci_sgl_set_data_sg(sg_list, sgl);
> +		iod->meta_total_len = iter.len;
> +		nvme_pci_sgl_set_data(sg_list, &iter);
> +		iod->nr_meta_descriptors = 0;

This should probably just set up the linear metadata pointer instead
of a single-segment SGL.

> +	if (!iod->nr_meta_descriptors) {
> +		dma_unmap_page(dma_dev, le64_to_cpu(sg_list->addr),
> +				le32_to_cpu(sg_list->length), dir);
> +		return;
> +	}
> +
> +	for (i = 1; i <= iod->nr_meta_descriptors; i++)
> +		dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
> +				le32_to_cpu(sg_list[i].length), dir);
> +}

The use of nr_meta_descriptors is still incorrect here.  nr_descriptors
counts the number of descriptors we got from the dma pools, which
currently is always 1 for metadata SGLs.  The length of the SGL
descriptor simplify comes from le32_to_cpu(sg_list[0].length) divided
by the sgl entry size.

