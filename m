Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109628DEE4
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431787; cv=none; b=eejex+UFtZ2s3ZY+JKaWW6eF7mFU4kSbczEtMfREWn7yyVGnEcDnq4W37Wqm4UJkE/MWFQT6jkCSZqeWgrm1vUpsD2UyMdrUze1JjlViScDqP6OYlzt/bOp+LlmfCsgBhjM/AnrJyIECUtHD/My2dLT7relEXoMCtiDOS9hxP8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431787; c=relaxed/simple;
	bh=hE07WPwFRXEpanF4skjNKxYCQC8//IXfbbfB/nEbHRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEFsUjY2Yu5SwXTB1h0G5vyruBLnwgGY7wjU4xjrBwwm8aqhADR6V7Qnku7jQBSHoDWZ4t0aXE3jnbgchPN81J3FgMwo1gVdZ3XPq8G1u995AZxkUNahAAqLfcZ89S+x2iI204OlXLMcXpgnvBZzKfCkp9y/wiFMTga3tzxfb5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IVrkYr9O; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IVrkYr9O"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4775ccf3e56so15637411cf.0
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 11:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745431782; x=1746036582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kL2C8z2XNRWzrThEWzS/MGHmoZb+Ha7gcgLYUEwZduo=;
        b=IVrkYr9OWNFexnkzChtFbEeJ82sJdRjet10LDQZBoVKG/IqUWpRq7BzTKdasu8AI3J
         PCSeri9UkzzpJ1+LI1Y6kiRnEa1Ek/NB4Ich7FJ0mzXyt9CgBmJOGLAl5ioBtCS5Clyf
         yuMsHogkkJho8M0KmLH905m8setMGfwL9k3O/WfTu1YHpiFaCTRKRQxMOOTW5+CMTkYC
         XWnm/KSOpBFMryUh/g/HQiMIQ4TgQvuAQArd2c0VAzkfTSW+ViG3deDi6NI2SXwUAIbN
         zOU5F+V9WDTzr2nW5uS7HPiWohhJAl3lLqjJkpJNcs1n+QHXyW0UXhRTHKzPPjrpcgOc
         Wkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745431782; x=1746036582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kL2C8z2XNRWzrThEWzS/MGHmoZb+Ha7gcgLYUEwZduo=;
        b=h02GMDOmPHx522LJuM+YNmePNaYeU0GG+/Iz25s4iWUgAae/8uWLoo4ihu1KlQCXLZ
         NmXaNyVbp+B8WJZGU4rZUlYFgB2qak/mwrQc25BfOK/kfb9SR+Pwcbyjz6NGDTW4pEXC
         yhbHLzYXjZQ9umLUEc0rWLoINfhorMp+RDUNEDv8B6TWXN7qUjaN4Y5wI4C05PKZxgT1
         WeoKMAV3ZlMvn50k+ukwIsTCKYFN80ax4WWh/Ai8MBD2e/0i0MQS07Ewv7QkJeeDSVtj
         bkbbdtu0OBzZZGINIBM1uEW3WtTZ9Fno4wQKZVfGJwnswDUdtxezwKIdPyVJIrJQa9eQ
         VsBw==
X-Forwarded-Encrypted: i=1; AJvYcCWvH+OzXCW0aIWPpwpPTa2I80/wUpCORXj/YhZQtd1rudmn9nQ+zcCvCEKMLNUid5+WUWifk2zNRQtWuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQYX+p9ghPY0mhwR7XRvJ+VssC2I4QKUP+eSiTKswHFB8zjU3
	j/6H0+5doZ1u1MsQ15RLUBDzArqp0ViodbvHWKVIJb9+wr3AS7WnUCaiQLkjt8Y=
X-Gm-Gg: ASbGncvW9ff4T04QL84718/dYsvDZzEuNNYk/PnK0dEEq2hrtyJfGbcc2z05qPwL55N
	hDAeKEyaIwtX3DqibFKbADm9sR0wDgE7in8HiF1qXRWuxVKvnjYJJnNlPdeazLpa2nzDnJyGlCq
	I8GqmBZP2qwDYiZtIwhD8QUy2bGOLR3feM7/Pw+IxMQLbz5TGst0YnqHirecA6VPxhrkqIHLBYh
	xIidg0esBfKBTIE3HcvH5WhehMa7rkYXo/hq6W1FcomHy+l43HEWx4vJLiaoG+Z21ydXfx+Rlgu
	5i/OuCy3e6R2IRFtxbahndu9WHFUt7BBPhi0EMLPp0wX9/dYzkAb5dfkh0zOaMr079SojA4BNLL
	U1Ob8Tg1IL2W4XMD8Pks=
X-Google-Smtp-Source: AGHT+IH4xfxeCQIatfvhUgdAx8fM2pKJgYvLzginEQw7PV9Sr3aShEQ97+Q+stgMKvhEecV5S0qx4w==
X-Received: by 2002:a05:622a:248d:b0:477:84f5:a0b with SMTP id d75a77b69052e-47e780b3d65mr2842901cf.2.1745431782337;
        Wed, 23 Apr 2025 11:09:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c3b485sm71764181cf.27.2025.04.23.11.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:09:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7eXV-00000007LuW-1WeA;
	Wed, 23 Apr 2025 15:09:41 -0300
Date: Wed, 23 Apr 2025 15:09:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 17/24] vfio/mlx5: Enable the DMA link API
Message-ID: <20250423180941.GS1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <b7a11f0e93a4b244523e07b82475a7616ba739c9.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a11f0e93a4b244523e07b82475a7616ba739c9.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:08AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Remove intermediate scatter-gather table completely and
> enable new DMA link API.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/mlx5/cmd.c  | 298 ++++++++++++++++-------------------
>  drivers/vfio/pci/mlx5/cmd.h  |  21 ++-
>  drivers/vfio/pci/mlx5/main.c |  31 ----
>  3 files changed, 147 insertions(+), 203 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +static int register_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
> +			      struct page **page_list, u32 *mkey_in,
> +			      struct dma_iova_state *state,
> +			      enum dma_data_direction dir)
> +{
> +	dma_addr_t addr;
> +	size_t mapped = 0;
> +	__be64 *mtt;
> +	int i, err;
>  
> -	return mlx5_core_create_mkey(mdev, mkey, mkey_in, inlen);
> +	WARN_ON_ONCE(dir == DMA_NONE);
> +
> +	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
> +
> +	if (dma_iova_try_alloc(mdev->device, state, 0, npages * PAGE_SIZE)) {
> +		addr = state->addr;
> +		for (i = 0; i < npages; i++) {
> +			err = dma_iova_link(mdev->device, state,
> +					    page_to_phys(page_list[i]), mapped,
> +					    PAGE_SIZE, dir, 0);
> +			if (err)
> +				goto error;
> +			*mtt++ = cpu_to_be64(addr);
> +			addr += PAGE_SIZE;
> +			mapped += PAGE_SIZE;
> +		}

This is an area I'd like to see improvement on as a follow up.

Given we know we are allocating contiguous IOVA we should be able to
request a certain alignment so we can know that it can be put into the
mkey as single mtt. That would eliminate the double translation cost in
the HW.

The RDMA mkey builder is able to do this from the scatterlist but the
logic to do that was too complex to copy into vfio. This is close to
being simple enough, just the alignment is the only problem.

Jason
