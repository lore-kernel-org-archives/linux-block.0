Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE336657F
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558716; cv=none; b=GKTYnXkyhpxlmIRBVSELcdKhXUFs1b+WbnRYvwKAeVE3PD1XtSRiwjDmoDa1GeLmLipzNyJxDhjUMzq6CxAx64IMyN2+GBLcbdhDIAlUNJ40wLFPhoTF6OvRNOfeGK+KDOCmqnYnLrJTAZxDVp4ZnfXABQa0fPgSYaZHQc/90P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558716; c=relaxed/simple;
	bh=NY4W006Vmm4O8KX13k1mpx8rxHpApVfJH2xGg7x9Lfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A39GTjKWtAFotkTMnZn0K4cNIcpFoNdx5QtLMo3lmwqtiwxJJjlk98E5j9BPeEYW2X/IaSVsosFY6ifUwBVS7hyuvGLe43dTAZjKojMcstpvRlkiM//KvcgyoypKEDkOiiAw27xNg4BdmKJYuztu2jELkQt40W3q/KLdeNAF79Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WMfJevXW; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WMfJevXW"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4edb7c8232aso94334701cf.3
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 05:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763558713; x=1764163513; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7FcA8gVt6NKvMsMWTMSBQuU8SYBlABMNBdbtn9F9iv8=;
        b=WMfJevXWqU3CRU2AHZ4/IK/wY+6nPWRcEwraHsRz8KDG1ijClMR7G9IMKrHNcSkml6
         uvAsh5rLHr6z7QMHuiddDP5u7ySsTrbmvBiSEaRfIbiTEg4T+EyqwuDj6qvP1Gi4ynzl
         1Yyd6lkGWpXGvLNmMmXvWAHOugKBbY3LnZC473Sgx4w/MLtN0gyaXN1wIlc4MdtY1PZc
         Mv78ThOUOJbmHwU7y1/kA0/5bQB6tqj3kMJhg+KIl0nk2JjqWWx9BUmZhrEIO9aElB6z
         3NpQY8He2tWwR7LjI1fXnqHlIf/Fu2dHJ9DG+XIENzU3PcWORuGmfl/m/lVDxT77cRMR
         0mtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763558713; x=1764163513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FcA8gVt6NKvMsMWTMSBQuU8SYBlABMNBdbtn9F9iv8=;
        b=WfrHUBQKH/REFMxyQ5Be6OzWcWEdGXZjdmF8A1M6HpgEQYd+VkyRSeCqPDpV3oQLLX
         /UDvZRfyL97GhFe/7+SJE6LQy/SfOUZ++Oyf20UsccRr5b0vb/ZIvOhcJJMPf5Nb/Nlf
         yN/xgXB610sBQ4wiocgMZpZ+vBXtWW5Hg7zwCRklNE48hVuKL2+eMQZeMgJWYkCr16p7
         +NJNbfPv9eNAgnuQxVaJ+o1s6Jj4SD7LUheDi2oWzdSJ0IgH+Of7dSYlmLBFMZPUfwtw
         k8G8pCodzvfrIKRcA3VN2Nte5Fn74eTBpdtqNG7QOSCy/sg7W3uw/4fZw16Qtb0seMI3
         /rTA==
X-Forwarded-Encrypted: i=1; AJvYcCUJVdVQ17hsQM+JCUe9vyjGaesFkwhtQGcdyVE8sK98Fc6ofL+/OkCu/zjC/qLkudwmNsj7nd7gUsIjPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGyX33m2X3XiyQ/AMa/jzFf98Z45AQKLzQGnjHrR++UPEahqH4
	AMucg2gQDVEFZHe6VrUmSgFiWt3TFrfxlAQ10yQ5eD7zUi5yr6uunrizqXpAbIGePUQ=
X-Gm-Gg: ASbGncurRfYoSeaIDPoALoqpwxw9ORZ5krQu6EHZWH1pQNKHeqydBNyJmU9OtsRcykI
	shx515yQF/Fv0jz9FoF87BmLiHPBCUs/Gu2is/XmvEOz+ig9uURBM6CnaPOlvDwA5pXHnpabS2E
	hjZOc7lU89Z9/Ytd6MgmpU7bW5JQJjWXISkjLz8QKz8Y23ESk26LBMDV1xcF/yFbT+Ael2Arbh9
	jVlmDT8wF4ucpsloLrWzm4ICM6OhnzGj2AW5/zDf55qbODq9Qf2yvri4KJ9kPvuNiAhokCpSA8D
	p6eneT6MNaESvvVWPl2I2BoHaSAVPhD7gu6oXjKMwh/jr/ieyDPBl81URfAm+syms4/KmXzmVcw
	SZJlVmsk8lpEPE7/aFJ/l1vKRshfPWi3NRw3roTEBhD7h9tnCWPtqlM36N390sG3N2HN1WKlOxd
	X7+dcN3Pl6gc5c07s2M3oZ2dF57tS04rbqKATcwl+ynB4hhjU56n7gTXYl7hEZpsmo0bezGXFRi
	oQ6EQ==
X-Google-Smtp-Source: AGHT+IGcHnQoF5t1hy3jZRVLXrR3AGxUUwufE8qFpbPEJxiBipRIqKgpWukFR+qkVncUWaOAApoSpg==
X-Received: by 2002:a05:622a:1a8d:b0:4ee:219e:e66 with SMTP id d75a77b69052e-4ee219e1ccbmr140009891cf.83.1763558712629;
        Wed, 19 Nov 2025 05:25:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286588be1sm133530266d6.47.2025.11.19.05.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:25:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLiBL-00000000Z6L-0jbP;
	Wed, 19 Nov 2025 09:25:11 -0400
Date: Wed, 19 Nov 2025 09:25:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, Alex Mastro <amastro@fb.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [Linaro-mm-sig] [PATCH v8 06/11] dma-buf: provide phys_vec to
 scatter-gather mapping routine
Message-ID: <20251119132511.GK17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
 <8a11b605-6ac7-48ac-8f27-22df7072e4ad@amd.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a11b605-6ac7-48ac-8f27-22df7072e4ad@amd.com>

On Wed, Nov 19, 2025 at 02:16:57PM +0100, Christian König wrote:
> > +/**
> > + * dma_buf_map - Returns the scatterlist table of the attachment from arrays
> > + * of physical vectors. This funciton is intended for MMIO memory only.
> > + * @attach:	[in]	attachment whose scatterlist is to be returned
> > + * @provider:	[in]	p2pdma provider
> > + * @phys_vec:	[in]	array of physical vectors
> > + * @nr_ranges:	[in]	number of entries in phys_vec array
> > + * @size:	[in]	total size of phys_vec
> > + * @dir:	[in]	direction of DMA transfer
> > + *
> > + * Returns sg_table containing the scatterlist to be returned; returns ERR_PTR
> > + * on error. May return -EINTR if it is interrupted by a signal.
> > + *
> > + * On success, the DMA addresses and lengths in the returned scatterlist are
> > + * PAGE_SIZE aligned.
> > + *
> > + * A mapping must be unmapped by using dma_buf_unmap().
> > + */
> > +struct sg_table *dma_buf_map(struct dma_buf_attachment *attach,
> 
> That is clearly not a good name for this function. We already have overloaded the term *mapping* with something completely different.
> 
> > +			     struct p2pdma_provider *provider,
> > +			     struct dma_buf_phys_vec *phys_vec,
> > +			     size_t nr_ranges, size_t size,
> > +			     enum dma_data_direction dir)
> > +{
> > +	unsigned int nents, mapped_len = 0;
> > +	struct dma_buf_dma *dma;
> > +	struct scatterlist *sgl;
> > +	dma_addr_t addr;
> > +	size_t i;
> > +	int ret;
> > +
> > +	dma_resv_assert_held(attach->dmabuf->resv);
> > +
> > +	if (WARN_ON(!attach || !attach->dmabuf || !provider))
> > +		/* This function is supposed to work on MMIO memory only */
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
> > +	if (!dma)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	switch (pci_p2pdma_map_type(provider, attach->dev)) {
> > +	case PCI_P2PDMA_MAP_BUS_ADDR:
> > +		/*
> > +		 * There is no need in IOVA at all for this flow.
> > +		 */
> > +		break;
> > +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> > +		dma->state = kzalloc(sizeof(*dma->state), GFP_KERNEL);
> > +		if (!dma->state) {
> > +			ret = -ENOMEM;
> > +			goto err_free_dma;
> > +		}
> > +
> > +		dma_iova_try_alloc(attach->dev, dma->state, 0, size);
> 
> Oh, that is a clear no-go for the core DMA-buf code.
> 
> It's intentionally up to the exporter how to create the DMA
> addresses the importer can work with.

I can't fully understand this remark?

> We could add something like a dma_buf_sg_helper.c or similar and put it in there.

Yes, the intention is this function is an "exporter helper" that an
exporter can call if it wants to help generate the scatterlist.

So your "no-go" is just about what file it is in, not anything about
how it works?

Thanks,
Jason
