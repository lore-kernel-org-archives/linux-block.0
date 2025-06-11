Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97011EE033
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649489; cv=none; b=FGMz8IZNrFHgFYBPkRC4MrAGcHNap/924HSldWGdeE5ECopsVGt+/VXFTc93FxJ4+c2KX76a8g09SKbLbwbAWgx3nnXBHTLmwiANacNvAgiuWengiImCMGNEBkktK0dLlgdUV2JEfyGwm0ScWOTjF3i6LlnMdrJAzuMCDjMfhpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649489; c=relaxed/simple;
	bh=bUCsyUGgfW+SkemvFWayFlgQbM6rPi3qk2XeqeQ+FTw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Pfl7Vg2ze8Calt2u8zQg+yf+qU+q6huTJQavsMxRyp+u8a3dLDukimBHP1jAVdIlXeUdT6i48vitN7ljjGfvINpipQcaHyw7QQWBpiDkRhxneevB7/rpvsBwdzkHKVLjqqkmXK6edJZB2Nf1VXPa8EoA8JXtrLbI/xSZni4Y26k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCfH+z2k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCfH+z2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F93C4CEF0;
	Wed, 11 Jun 2025 13:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749649489;
	bh=bUCsyUGgfW+SkemvFWayFlgQbM6rPi3qk2XeqeQ+FTw=;
	h=Date:From:Subject:To:Cc:References:Reply-To:In-Reply-To:From;
	b=ZCfH+z2kj9DXzlQ1Oghg+pguKlt1NUigM0NunFD75uc2pE4h2T4I8B7PBnjfNXQAI
	 y16DCcAimJakFUl1lgpWEWrnThnpdxMLH8q4MrCJXHLcRSsRd0V+Ga11lHJL5ZTI50
	 6iD5b5bC8YsEBGdN27nqWRjbQrOb3kieoLa4GFy0/bxfMPDCMKgzgiMHSy1bZTBXmf
	 ra7ziOQz+8eKrfcBdeGeX6r9iYp6/JucQEljtFyqVkOOkxdn4ZDByNHy/Lyoczzzbh
	 oFYBnEYCIXS++EhvZiZQEwWere02UqVpSplhR/mVFw16u8O83c8Uh2fFf3xhxcQj1C
	 J+XNwagw7zGKw==
Message-ID: <6f0a019c-f9c7-4ccf-837c-c6d15492ba45@kernel.org>
Date: Wed, 11 Jun 2025 15:44:45 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 5/9] nvme-pci: merge the simple PRP and SGL setup into a
 common helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-6-hch@lst.de>
Content-Language: en-US
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250610050713.2046316-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2025 07.06, Christoph Hellwig wrote:
> nvme_setup_prp_simple and nvme_setup_sgl_simple share a lot of logic.
> Merge them into a single helper that makes use of the previously added
> use_sgl tristate.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 77 +++++++++++++++++------------------------
>  1 file changed, 32 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 0b85c11d3c96..50bb1ebe6810 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -814,42 +814,41 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_queue *nvmeq,
>  	return BLK_STS_OK;
>  }
>  
> -static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
> -		struct request *req, struct nvme_rw_command *cmnd,
> -		struct bio_vec *bv)
> +static blk_status_t nvme_pci_setup_data_simple(struct request *req,
> +		enum nvme_use_sgl use_sgl)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -	unsigned int offset = bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
> -	unsigned int first_prp_len = NVME_CTRL_PAGE_SIZE - offset;
> -
> -	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
> -	if (dma_mapping_error(dev->dev, iod->first_dma))
> +	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> +	struct bio_vec bv = req_bvec(req);
> +	unsigned int prp1_offset = bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
> +	bool prp_possible = prp1_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2;
> +	dma_addr_t dma_addr;
> +
> +	if (!use_sgl && !prp_possible)
> +		return BLK_STS_AGAIN;
> +	if (is_pci_p2pdma_page(bv.bv_page))
> +		return BLK_STS_AGAIN;
> +
> +	dma_addr = dma_map_bvec(nvmeq->dev->dev, &bv, rq_dma_dir(req), 0);
> +	if (dma_mapping_error(nvmeq->dev->dev, dma_addr))
>  		return BLK_STS_RESOURCE;
> -	iod->dma_len = bv->bv_len;
> -
> -	cmnd->dptr.prp1 = cpu_to_le64(iod->first_dma);
> -	if (bv->bv_len > first_prp_len)
> -		cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma + first_prp_len);
> -	else
> -		cmnd->dptr.prp2 = 0;
> -	return BLK_STS_OK;
> -}
> +	iod->dma_len = bv.bv_len;
>  
> -static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
> -		struct request *req, struct nvme_rw_command *cmnd,
> -		struct bio_vec *bv)
> -{
> -	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	if (use_sgl == SGL_FORCED || !prp_possible) {

I couldn't find any place other than this where the new FORCED tristate actually
matters. So instead of passing the use_sgl tristate around, why not just check
here whether SGL is forced?
