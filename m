Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B595F42AB0
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750060191; cv=none; b=BUxVr04/qTOggYB4/fwMZZzFIAcF4Rwnjfu/MgVPbNaL23kAh7aqmxyH6oeyoWteUi+LVcvv2d9/NMsslD9SEYz6jIw/78x8diuWhMSCYgIi77+RnEoF0VJ9W9mcP9G7/V7DPenp0f9vp7U2pQYop6IGGBPipoLqXfKk/deLy28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750060191; c=relaxed/simple;
	bh=Cz3lDHFGJJSCBLHfEjRzh8NozUVsGBREjmVm7AlWgfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMP5GvBwIc3aCohiMfW4XH2jhVt4p2JhKm5mJU1UxdaKRQxpqc7tEQGr5TkKpN4IHc5E+sMruwEq5YjMX9AOfZnIqFruDMVq38UIyoNd7BaRZDKDRrF1sLqeHsU8ExdDcPSjXULdpU0WZ9KsMe5ayIpJQx23ngpyufJE2g9l5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sgi6QPQq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sgi6QPQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF61C4CEEA;
	Mon, 16 Jun 2025 07:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750060191;
	bh=Cz3lDHFGJJSCBLHfEjRzh8NozUVsGBREjmVm7AlWgfQ=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sgi6QPQqndZXcORblP7IP7+rNuZyWjLXtq2bx8op6hhJIxjguGdlkzWEK2llVQDDr
	 u7iGf2lsdfKC9nsfwi1eNWxt9ggCo+NzoPCkT0JkxOuO6kvH5XQxEVEY0RovkfkEgV
	 HMbB7j+VpJ0sI3nMCD5f2kfV0mGNpMl3xr/7nyGt8HEIQWQXzXzLFUwWBYBv5opdNa
	 0b9/YYpKsDhSgNd15CH7GLpVBLp/3mmNOgHRJsTCjiZ38V9IqZLGqCzrKcpYb1I0gW
	 QhEZZrI+/k8Wlb/5lzi6wXoJQWkkNVD2e3ANonU5qGjUCDzMmO8NQ8Ur4BUbPkpX4b
	 ODo0n4R2OpsHw==
Message-ID: <871b014b-e308-4f20-9701-5581beee91ed@kernel.org>
Date: Mon, 16 Jun 2025 09:49:47 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-8-hch@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250610050713.2046316-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2025 07.06, Christoph Hellwig wrote:
> @@ -46,13 +45,11 @@
>  #define NVME_MAX_NR_DESCRIPTORS	5
>  
>  /*
> - * For data SGLs we support a single descriptors worth of SGL entries, but for
> - * now we also limit it to avoid an allocation larger than PAGE_SIZE for the
> - * scatterlist.
> + * For data SGLs we support a single descriptors worth of SGL entries.
> + * For PRPs, segments don't matter at all.
>   */
>  #define NVME_MAX_SEGS \
> -	min(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc), \
> -	    (PAGE_SIZE / sizeof(struct scatterlist)))
> +	(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc))

IIRC, I've seen in the commit history going from PAGE_SIZE to CC.MPS for
different cases in the driver. PRPs requires contiguous regions to be CC.MPS,
i.e use NVME_CTRL_PAGE_SIZE for PRP lists and entries. But I think that is not a
limit for SGLs. Can we use PAGE_SIZE here?
