Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD98E289360
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428541; cv=none; b=hyzu452K+nol0zOg1+xjaw8S5MVMQLKJ/YHokZKV5FrgcOXuu2CLQwE/wun6TMtXb+3qoTylyDCl0lo+QLBPpQW6Kupt0nJ9+GUSCMd4G/Fz54dN1eSA3687uvXo6U7CthH2JnxLmCX3l+Lu+onzejglww6RPJSD6reSm+n91gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428541; c=relaxed/simple;
	bh=ZSWmIXnoHeqHpg22is4DCb+FQUxyjWQhdchI0xl2uAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tqf00ac7tqg6A1JztbHOCyp8DYkyFcIxGe0Bpb5+jVNEj6PGih1SE85TBOR++lRxYTAGowYWa3EYano2c+VpYs2qjSGKTx7P9qGvEeCXqZs2Hda6AXrwbmxvNQknBPbf/ryXp7bAs4ttwpeLtCMDc599Qv3/BB2pUR3beMascLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=f3RJOF+9; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f3RJOF+9"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86cce5dac90so71140241.0
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 10:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745428539; x=1746033339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sAA3ahIS+2Nb+9ARKVTXCSjk2uwR/TOFzjA5DEQnqxg=;
        b=f3RJOF+9I5aUeLfKwhY41cyNNsV/7gzE8mnt0B7y7vbeRVxS8lsyPkRNroBYBI3tAJ
         LoOcUnWESA/cjHCPlWjRHA3M+53oDTrejya0NpMfeL6ljH+lfqQ/w5WsXx5ptqIdwRDv
         nsp4EdSeE1qB0xl7OhzzYJKM36aE0m+MI2XLpfk6xpvXrCfNBJoewKHE7+njIVYSVVE9
         uh237S2zCPLxHmND8hCSoBynFpTclSrt0aPYz/VfLhJATgS9agmNsggyOtAJAI5FOQCt
         Odf2Xxn7vp+XAbxZin8Yl6xswoHmQ5A7Db9GS23ti5naaSYjMpciujFTq8n0nXWju1+8
         8EaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428539; x=1746033339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAA3ahIS+2Nb+9ARKVTXCSjk2uwR/TOFzjA5DEQnqxg=;
        b=r1GrBgVnyWIwYT4fl8luUJoHyDF561Uw7mPgbZSDYdDbVvZt5oc55Gn8e8b4Xe45YC
         67IMKGqRLo34V0/Iv4/vO68PQpM4786LFxex1Bx5+QPbMCaondq8OXM6JMBrexKGmhy9
         KTHD4hquzNYBB8Si+BJkXVIDNxu/958gjyB3jN/0Kat671pyKoptTiCu8BaiNOYBAVvx
         5ehN+UJPXxJTB5cBwOGuCQ20ciKkm987j1p3uSz34H/v4vYHGXT4erPQr9zN2cBlQ+fV
         60RwswbUcGwM89Aovo4WkCpFUxPy4vtFSKsrF4HdU6yOCMxsYMpr42sfZ8B+C2AT19Wx
         lIMA==
X-Forwarded-Encrypted: i=1; AJvYcCUev5CjSQ7/31+ZEqSPBGZvu3y46RKmmrqV4pumXXDQwL2Mgv+KS/VZcaSNqJYmyET4YjO3i5Tk3HtksQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqojO5/udXhzD+5/jiV9qcORV+po4YItpm07reJCECEgvk/b99
	wAK4IOzR8+ucFSdtlRtWRZLUu+8GQT9hwQg/XAsFnsXrlN7flMV1OCn37yueNig=
X-Gm-Gg: ASbGnctyOx+lMbYeY/Pl3CFnEVVXPGAbFhX+A3taJLsjEDGnlnm91BP49GZ9Xt+OICe
	jyaOnTykLOGvYX8+2Mllze0cjDcWt4aQFIxS8mpECYI9fJ/+BGfTjFdUDOEQi2rQ3XPWtXc56O8
	hYKUNI/9+KHlT+hanTeW+K9A/hY3TbWDb2Hv9qTpzomdbUF1Mkr/AteJ+nBsRzJeqBWZ4s4Z+v2
	KvLi9K35/jlbGp76hZtbjgfovWFYYxSo3//kAXBSbGTK7CY1HTce73buM6TxkQgzZTGgc8/9agx
	mmIzFDvF30zmBk/iKc/PX5v0OC3tPNmRlP3IgoXKDaZws4l8v9CVMcFJQIHzY/8TIs85Sdp1qLS
	w/MYZRw835uWUqT7gyjRXb9/ihGfkNg==
X-Google-Smtp-Source: AGHT+IG91ka296h4XrJ4QPDo73jdYlZoOj1Zkc9PInMILwbVuqXEZMd5w4C/WgEttaatAxBubBvu3Q==
X-Received: by 2002:a05:6122:3c54:b0:529:24f8:dbdd with SMTP id 71dfb90a1353d-529253da601mr17813854e0c.4.1745428538734;
        Wed, 23 Apr 2025 10:15:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52a74d3a2d0sm79186e0c.40.2025.04.23.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:15:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dhB-00000007LQW-2UhV;
	Wed, 23 Apr 2025 14:15:37 -0300
Date: Wed, 23 Apr 2025 14:15:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v9 03/24] iommu: generalize the batched sync after map
 interface
Message-ID: <20250423171537.GJ1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <2ce6a74ddf5e13a7fdb731984aa781a15f17749d.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ce6a74ddf5e13a7fdb731984aa781a15f17749d.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:12:54AM +0300, Leon Romanovsky wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> For the upcoming IOVA-based DMA API we want to use the interface batch the
> sync after mapping multiple entries from dma-iommu without having a
> scatterlist.

Grammer:

 For the upcoming IOVA-based DMA API we want to batch the
 ops->iotlb_sync_map() call after mapping multiple IOVAs from
 dma-iommu without having a scatterlist. Improve the API.

 Add a wrapper for the map_sync as iommu_sync_map() so that callers don't
 need to poke into the methods directly.

 Formalize __iommu_map() into iommu_map_nosync() which requires the
 caller to call iommu_sync_map() after all maps are completed.

 Refactor the existing sanity checks from all the different layers
 into iommu_map_nosync().

>  drivers/iommu/iommu.c | 65 +++++++++++++++++++------------------------
>  include/linux/iommu.h |  4 +++
>  2 files changed, 33 insertions(+), 36 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +	/* Discourage passing strange GFP flags */
> +	if (WARN_ON_ONCE(gfp & (__GFP_COMP | __GFP_DMA | __GFP_DMA32 |
> +				__GFP_HIGHMEM)))
> +		return -EINVAL;

There is some kind of overlap with the new iommu_alloc_pages_node()
here that does a similar check, nothing that can be addressed in this
series but maybe a TBD for later..

Jason
