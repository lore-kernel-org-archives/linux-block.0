Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B842690FB
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650457; cv=none; b=FdiGqfmj0HulUVQl0DOqt6P4mNs08kt3ZmuGEvZTIfdkwYH6fHp9PA9XGwMlyV6pyFzejrewFUQKVwe2js1Nsgx7SC9yVq5dqIZNvVgbGO4Y5DhWmsiEmGVWSe6qHOzK0ydqt6CAaMln+J0iomgd7gj3tx926cEokHGFQWSrUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650457; c=relaxed/simple;
	bh=/2cgRtZohrG3eN6FRl+viVw3dfVpN9tpcKWa5PFKI/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cY/Rw7+gG4lTN6udaNL/gOvVN0Lo3F1KHfTI9C6iGpSOsCYeXAEnYWYGmrKG4wPitH7J4mgbZCmcwS3Nk3zKxQAzEiDSpfBi07aFwwq6+1adCFnn1UQyqGUiFIaS/4kLZGocDEc1kOQov1s4BfugPid8hIMjliB6GDKG/5tyFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1GZ3fam; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1GZ3fam"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAE5C4CEE3;
	Wed, 11 Jun 2025 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749650457;
	bh=/2cgRtZohrG3eN6FRl+viVw3dfVpN9tpcKWa5PFKI/I=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i1GZ3famHxEyfV4BGY3mQMDLuUOmwHP65OmvhVqZa4HUTfbuBZvKH3a/B9LcscYl2
	 Pfp+ff1Gg4UkJg5/P++m4niShm3PKqXTcng9NPwoKqwHOZ+LC/7cw5FYP0PXZKIQcw
	 +wFtDgWQzhq8Uo/8nbSxxgelZ+2g7RAN1ICG223PiKFY13GkMIJiHT1VJVhnLMAINF
	 rLzDDqMs0hxO37PVv959kFYnDSAht51AoJpRKaBhvRFhCSpuGNBR+XzPJOWXbyj54W
	 HIkxDLujt+RpGKP/shF6cd7rzgY8sxbqZqxPK81AL0yYHZfe+3K6qrw6DnFEsgcexd
	 6EcVr2VQgvYUA==
Message-ID: <dbcbf77b-e1c6-4ab0-8e0a-07ad63a74faf@kernel.org>
Date: Wed, 11 Jun 2025 16:00:53 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 8/9] nvme-pci: replace NVME_MAX_KB_SZ with NVME_MAX_BYTE
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-9-hch@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250610050713.2046316-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2025 07.06, Christoph Hellwig wrote:
> Having a define in kiB units is a bit weird.  Also update the
> comment now that there is not scatterlist limit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)


Reviewed-by: Daniel Gomez <da.gomez@samsung.com>


> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 2d3573293d0c..735f448d8db2 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c

...

> @@ -3363,7 +3362,8 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>  	 * over a single page.
>  	 */
>  	dev->ctrl.max_hw_sectors = min_t(u32,
> -		NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev) >> 9);
> +			NVME_MAX_BYTES >> SECTOR_SHIFT,
> +			dma_opt_mapping_size(&pdev->dev) >> 9);

We use SECTOR_SHIFT for MAX_BYTES but not for the bytes returned from
dma_opt_mapping_size(). Yes, I know this is not part of the change, but still is
the same line. I think it make sense to convert it too.
