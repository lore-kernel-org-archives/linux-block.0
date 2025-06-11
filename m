Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF1C185920
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675057; cv=none; b=bnbV1vh9JlcsC0v69kYWLu5rH/MA8MyGqrLQncS5YPS6ZF5ivZXFkBuc2+mCPxYBGC8Mi25Piu6kuCACBuXbxuLOgAdcu1BuyOWTkA/FiTlYhuLAaOnqoqa6G8UjeHtAvPmrJkPVpI1Vrg2Z7/dc7L4CdwqcMbZGBjyPPAkZ5Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675057; c=relaxed/simple;
	bh=gf+hIWT9HhXqRqMoHWdMRBTuwbAJOSl9YndIJ3I3zes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8IIZb2OG52JBvwgmvQSK+seJ36iuljbheJ3B0H+/hI+/pLKDy3calsy+m3SsM4E/1ap1FydAh7oBs6nDP14Opl8gJWxo1jMhkOoBieFh81edwUySR9fbAm6kZLT+orbrk4EtyPBzxvXsp8FWhfIp/p5xBWb8OBfFd3GHxc61ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7QrJChk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7QrJChk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67CDC4CEE3;
	Wed, 11 Jun 2025 20:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749675056;
	bh=gf+hIWT9HhXqRqMoHWdMRBTuwbAJOSl9YndIJ3I3zes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7QrJChkFzVsAw+KF7PRDhHLQXFndOX0uKd0aorRVyzMoe+tPQKuqHDQa3IsdzLaw
	 c5s33sv5Z4MH+KAwkjhkh2xtJUav98RNFW5LJs69IqCTxAfMHsn94LgljVB61Q3Z35
	 YjxOcss1faPyrskjewVIXlpGBZqadCVyBYC6ircuDrPzXXpBD2Vlk9IJa/yWgOsgdQ
	 h6Ja5peuxUqkuSslDEm9RN7N9EgR6dGQfPUYLB5d8l0E1CTJzeOKcOCOI6++VgN13b
	 IB4VGBKZ+eLjmGlHnv0sd7g2X+tIA5bBX5z5BoPl6qsdSkSJ43OdaEKffhnsQE5Mtv
	 FwoH0ZWZbcqtQ==
Date: Wed, 11 Jun 2025 14:50:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] nvme-pci: refactor nvme_pci_use_sgls
Message-ID: <aEnsLRDcZ-ykBsVX@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-5-hch@lst.de>

On Tue, Jun 10, 2025 at 07:06:42AM +0200, Christoph Hellwig wrote:
>  static inline bool nvme_pci_metadata_use_sgls(struct request *req)
>  {
>  	return req->nr_integrity_segments > 1 ||
>  		nvme_req(req)->flags & NVME_REQ_USERCMD;
>  }
>  
> -static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
> -				     int nseg)
> +static inline enum nvme_use_sgl nvme_pci_use_sgls(struct nvme_dev *dev,
> +		struct request *req)
>  {
>  	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> -	unsigned int avg_seg_size;
>  
> -	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
> +	if (nvmeq->qid && nvme_ctrl_sgl_supported(&dev->ctrl)) {
> +		if (nvme_req(req)->flags & NVME_REQ_USERCMD)
> +			return SGL_FORCED;
> +		if (nvme_pci_metadata_use_sgls(req))
> +			return SGL_FORCED;

nvme_pci_metadata_use_sgls() already handles checking for
NVME_REQ_USERCMD flagged commands, so I don't think you need both of
these conditions to return FORCED.

> @@ -886,7 +897,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  		goto out_free_sg;
>  	}
>  
> -	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
> +	if (use_sgl == SGL_FORCED ||
> +	    (use_sgl == SGL_SUPPORTED &&
> +	     (!sgl_threshold || nvme_pci_avg_seg_size(req) < sgl_threshold)))

This looks backwards for deciding to use sgls in the non-forced case.
Shouldn't it be:

	     (sgl_threshold && nvme_pci_avg_seg_size(req) >= sgl_threshold)))

?

>  		ret = nvme_pci_setup_sgls(nvmeq, req, &cmnd->rw);
>  	else
>  		ret = nvme_pci_setup_prps(nvmeq, req, &cmnd->rw);
