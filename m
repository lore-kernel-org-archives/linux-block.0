Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1C123AB94
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677905; cv=none; b=pl6XEh7kffAfdEtyiXt/p+qh7oi/hJGN97JcrMC10YbkHm1Lc/+OFIvJiTO/isGSaBOs0ScGPxs4HlHJ4gBtEfC7zWYeKjb5uC51cUD4EPRrL2jtJqpSQiw5juWUmg1IvBRugnfpZYCJclPIWaMIFOAktirkzMMhjtVfZvXNubI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677905; c=relaxed/simple;
	bh=2vmuhdS+sywedYC4HhfK5n2ZCNJ9jH2NFwV5aFEEh24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQvJUXiy8gP2R91Z0+YgdYrIqU9iRcj+Ojjn3RUT3+MMr7oyJp4hkYQw3W3TnLtEXToz0nx0QBLhTERxWqEdu0UtJ3GLndkBULPU5OW8ZeFm8buHXURSX4rLy892MA5fk9FD6GLxJPWHnsq6fOZqHtUTK+KkCJCbvsZ5LrHuE6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imnw2ylj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imnw2ylj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43973C4CEE3;
	Wed, 11 Jun 2025 21:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749677905;
	bh=2vmuhdS+sywedYC4HhfK5n2ZCNJ9jH2NFwV5aFEEh24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imnw2yljyKAMX/ToZAK+hpHYEfPElTmY8uzaT3irIF4v/QgcOcs/Hw1RtVKDa/vZ1
	 J4XshinlWGuR+mBdyNcrhs3P7QoqC6ZKubsBawBABAghc5gDlkHgshH7tZky9Xtbwx
	 c6cjm5K6Ig6Ix0O+XQs2/uxZJKQrdgSXMYBO9Fbpc5wsq3R6GgaHsPMh5kbMHWvYRF
	 sGqYT08X7N3gCL2dfeChf0s1jk64wTdNxiH4k4GoO2aQ1RGNLujoyLZenKZfmfdc2v
	 iVjrIr4RCdjUt4R3J7PGIWktZI2JwMGZjcf0FcxiX8Hk7GaWVuB7Y9+Rfd0vBzuUBL
	 N7i+bYLAS+yBA==
Date: Wed, 11 Jun 2025 15:38:22 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/9] nvme-pci: simplify nvme_pci_metadata_use_sgls
Message-ID: <aEn3TZO1nGnh3wvK@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-4-hch@lst.de>

On Tue, Jun 10, 2025 at 07:06:41AM +0200, Christoph Hellwig wrote:
> +static inline bool nvme_pci_metadata_use_sgls(struct request *req)
>  {
> -	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl))
> -		return false;
>  	return req->nr_integrity_segments > 1 ||
>  		nvme_req(req)->flags & NVME_REQ_USERCMD;
>  }

...


> @@ -981,7 +979,7 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req)
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  
>  	if ((iod->cmd.common.flags & NVME_CMD_SGL_METABUF) &&
> -	    nvme_pci_metadata_use_sgls(dev, req))
> +	    nvme_pci_metadata_use_sgls(req))
>  		return nvme_pci_setup_meta_sgls(dev, req);
>  	return nvme_pci_setup_meta_mptr(dev, req);
>  }

Am I missing something here? This looks like it forces user commands to
use metadata SGLs even if the controller doesn't support it.
