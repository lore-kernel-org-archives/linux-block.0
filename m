Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E54D35B144;
	Mon, 12 Jan 2026 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226923; cv=none; b=N/6EbmOKbk2j2/G9oFtAlpFfWsQoojbSg+NoG3R856S7fTMltirxBLYuNgicnuURjD/e7ddYvgfI6gOloxdZUOSrtqknGJ+TX8Y71oohtAMeTxH21bLIyzKhia3hEKSsbxneHwO/3vC36sJVtXIg8RnUYttvsxSitQW38YTFhms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226923; c=relaxed/simple;
	bh=p/kjIc8I2+thlOWEzjWlS6wT9qgXJ4+hBaLNZAIGnkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGvqSIhLVgR8pCJS3LjNMNeZt6qOdcQT9JBb6V1tvI8rWNuvfRwWFfd+/AIEJFv//tmSBBsNwAFbpnoPUb38tOiiUIbFkhA/Vk842VcTy7aLd4im4B9H1mOIyW9GKZZXwV60jsCNB7drE9HJhCwUdRHFtb50gJu8yEBfb2UDqpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7NIPlFd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7NIPlFd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AD2C16AAE;
	Mon, 12 Jan 2026 14:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768226922;
	bh=p/kjIc8I2+thlOWEzjWlS6wT9qgXJ4+hBaLNZAIGnkg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D7NIPlFdPgQQBj5p1cViX2P+6mpdYN29mGZZBfHelGeyaGbph1nSlmx4QspeiyZv4
	 1rrO1XNfd4UM4pQuE6c4dOrgM+N/FPtas45xk2wuOV96FIXFJrfmjjGoHV/W+1Cc7/
	 Fq1vOlEZjWH11itW6ZTcN9y+qWIbGwe54EYWOGia6IpxNufW4/g8k1nxIuSMehQWUD
	 ec6JbaYv3w9ad1N/HTf/BI244pQkfLf1CcJryVWwaPuagfziAyrBvE1SiRnO0klHoQ
	 SwrHwfMqXMrDL+aKosF8i9w8N89JkqI+RcJ20CUr26rlkBgkc4jGnh/b9tf4IqEffX
	 MGdMpNoplzccg==
Message-ID: <5b07dbce-2644-4079-a768-9167cbe3e25a@kernel.org>
Date: Mon, 12 Jan 2026 15:08:38 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: blk_rq_dma_map_iter_next is no longer using
 iova state
To: Nitesh Shetty <nj.shetty@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: nitheshshetty@gmail.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260112135736.1982406-1-nj.shetty@samsung.com>
 <CGME20260112140208epcas5p4c3ef0209b01be379c836f705a10efa7d@epcas5p4.samsung.com>
 <20260112135736.1982406-2-nj.shetty@samsung.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260112135736.1982406-2-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 14:57, Nitesh Shetty wrote:
> DMA IOVA state is not used inside blk_rq_dma_map_iter_next
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  drivers/nvme/host/pci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3b528369f5454..065555576d2f9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -823,7 +823,7 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>  
>  	if (iter->len)
>  		return true;
> -	if (!blk_rq_dma_map_iter_next(req, dma_dev, &iod->dma_state, iter))
> +	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))

Hu... Why is this not squashed with the previous patch ? If only patch 1 is
applied, this will not compile, right ?

>  		return false;
>  	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
>  		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
> @@ -1010,8 +1010,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
>  		}
>  		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
>  		iod->total_len += iter->len;
> -	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, &iod->dma_state,
> -				iter));
> +	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
>  
>  	nvme_pci_sgl_set_seg(&iod->cmd.common.dptr.sgl, sgl_dma, mapped);
>  	if (unlikely(iter->status))


-- 
Damien Le Moal
Western Digital Research
