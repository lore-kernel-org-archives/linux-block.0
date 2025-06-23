Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EFF2882A9
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692453; cv=none; b=sHZfU13SgEfFTPBjPSLGgFA0Xv65czrCeuRKIr5je/GE++CvT4uKIPgObjG6X4zrQSYmQjgt76n+LI2TcEgrbd1JK33xnVS8/ts4twYwjET63RPsVAQA1POeLBmwAHCUCyxJycvHQm8QaYyzjejJNZ0k3lBvsc0EfFtSJEgkVMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692453; c=relaxed/simple;
	bh=joX8RW2I71piMAp33vBoXEKsMPja6dSHkMWvCKOCIkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn2xzRvhRFoG/4h1scECuuKVHI+Ex5QfpNt0wCqhByZL9ipOJh0y5Z93+C19fumpuZtNwq8N0ojQDU0pNl1eSoKXqArrQx/h5CxdzujScSzm1Sbzm1AuigIccrA9DdcSSTtTh/pjShyImfSKB3QBQfFmZGOdIrstFLhUX9OXoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1BtWkZO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1BtWkZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A131C4CEEA;
	Mon, 23 Jun 2025 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750692452;
	bh=joX8RW2I71piMAp33vBoXEKsMPja6dSHkMWvCKOCIkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1BtWkZOw1oszg7cK+LkvSPJBc4VzqzqZPe87GeEwmc/ha8yUgrsgOo8+XcCqXmmc
	 JQ9gUWYdqmOjOiYUem1CtvIr2YquiFPjg9ZvGwt0Jv96fhrCAFZKhga5Dw57D91C0K
	 wbLeanlVIl4qIHThXOPmJWg+JpN6tvHJscEphqwwzgH9Rga6O41qCLdAo4V2UsnKxb
	 R1R/4QSj0+cedkdCSU0xUEIEyCWbkR8iT607NTogbX2zMPnIrhLztOoeQaophfnrK0
	 ZBmSn4bUnoOyQqWeA3uhJdOhajPIAR2pWfQ/6Xq1PSY4u99dEXfMYawkSqZv3lug7e
	 EsfVR22zxMZhw==
Date: Mon, 23 Jun 2025 09:27:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/8] nvme-pci: refactor nvme_pci_use_sgls
Message-ID: <aFlyYjALviyhQ-IE@kbusch-mbp>
References: <20250623141259.76767-1-hch@lst.de>
 <20250623141259.76767-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623141259.76767-4-hch@lst.de>

On Mon, Jun 23, 2025 at 04:12:25PM +0200, Christoph Hellwig wrote:
> @@ -888,7 +899,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  		goto out_free_sg;
>  	}
>  
> -	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
> +	if (use_sgl == SGL_FORCED ||
> +	    (use_sgl == SGL_SUPPORTED &&
> +	     (!sgl_threshold || nvme_pci_avg_seg_size(req) >= sgl_threshold)))
>  		ret = nvme_pci_setup_sgls(nvmeq, req, &cmnd->rw);

We historically interpreted sgl_threshold set to 0 to mean disable SGL
usage, maybe because the controller is broken or something. It might be
okay to have 0 mean to not consider segment sizes, but I just wanted to
point out this is a different interpretation of the user parameter.
