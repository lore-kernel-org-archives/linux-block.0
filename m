Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD22857F8
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429789; cv=none; b=PvV4+j/ry1c3sNclszV+d/MhB7FikvYdAsA04FofLM8EOMUxaExbKZuuJMw3nONeKYsoHsxoh79Ha2OVQW2jDpft5K1CH19SnuxKB+wH0BDOg91zh3uyfPWo7JRBThkUSUN0zSabrOGA6Qy9ZAsSQlS7ol+TRmWtMNL9k7D9C28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429789; c=relaxed/simple;
	bh=drAiBKTIiyi9mLR+BwbEskkyvzsYVuH4EzXGje0dF0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Khh1iwo2HRKiQjYd6uAMol8V/qUX0ojlgWsr7BgTe83GNhJQg7vXjVY9KjjYKZcML9QMhx76CjQk5tqs01CC8SPKbWxT7ip8cAREExcjml5q0sgXtMuXRFPvK+h7W+C4DQU09CiKbZTdGbRrlPqiE5yTOgxVZyvjAHybwxx45rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nECGOegw; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nECGOegw"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5aecec8f3so11797685a.1
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745429786; x=1746034586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNJodNA/CGOE8qYPmCoAIvEyeqrCcwNf4apB4pxSGaA=;
        b=nECGOegwoDaon8i7eVtKxXoiAeyi+dwz/Mu4/CD/hldn1xswY9Jn8BCh4H3ajxW1i0
         LYO5ucHVY+hQ6Enk8MJef6znkZLkmrsKK498EwoF216ulIsuSKn9KaxdU4cFdbcPVGD4
         jalkaWuOrHVCdfs5yVqjLX7mi2DMOINJAtF2iY1DKphNwhBU1BAt8TNjjo/7TQi9EWoE
         10WiL8VhTOgMQMWGR9lRHkTcsIOzU7y12U8RAeJT32k19zA0zXtL3WLyTpaYzOO+dcno
         stvqp3Wc7DgapQLNyGoyKUxeLxhjaHDNkRzqHhIwiuTIRTwQ+OimLmRQ9y52fkxYGEJG
         LN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429786; x=1746034586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNJodNA/CGOE8qYPmCoAIvEyeqrCcwNf4apB4pxSGaA=;
        b=MIqCui0o1ECKwzkQfFLYnxU5MIrmRRMLzqYS6VBesBgygz0tQeIp/6p08FDwJ6obt5
         54jzTf38MVTUdzB9Gof2lOPf2AoIBsZRuIzYLAT8EfAuI2u//LEXJ6txjCWo2igcRbHA
         5larqjAar6gkJJ8YAvrfDlkE0Nb+VM2uHcKG3zjqsxwfYFM+bCn1dZ1ijsW2d/OC6uMu
         V9iUtPLphXMJxjjpCMaHvg38yfjkNGYZDLEUzVST/gQJdK0EJJjdS+mxulhP95K7Hjq7
         tZHlgq4ls06CNHOcH4ufl4TZNHWeElog5/K44gHoecxlYxdXDWHPqTpwhr+ZzKcEpFAJ
         u58w==
X-Forwarded-Encrypted: i=1; AJvYcCUOtm+DTrho/89p2r5iGvnQiwCqpYpRREitIDxKHt9c6UWup9oYlntfzE0LKD3c8qduHyo/2MKzjPtY8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YznkdpxNquaYGryPIZsS7znOwjbBs0t7aUFPIMfe8xhtWdCKAZv
	UwTgzDSgjdBDUw2odv1C3y8eXxQh4VrkhianH9sa834SY7qiV/jszggFQLohTeU=
X-Gm-Gg: ASbGncs4hoUcLR3JZ9FWgUspoFCYK266MHa1vsxgSV0XWtBvN4fxOrDUA46E3hJ/I+J
	4YVjKzl6Z4oet1F+VDOrQXQaxuuW1WP+oSqJ1QNWE5TvcuKh7BalB1ajz3X9C1ABC5A4It5Pp/c
	+ry2YCjdWvPabceuFI5NXvbwjsj2Mjij4pUFXlm+NfuryfTlHVCRimXATJoZlcBRMxs0eAq7cYb
	P5fmhEiDIBNz7rq2jNxgdjspK+aF1sap/AcONmqFIQeh7/tCCFkNyXbjcai4V9r/PBPZXjj5+fC
	8FVBPM15Iu4JQJBDEGjzjQyLu0uK6qiIZvo21Oj6xfmlYfCljw1KjQbf7AB0kAcvkpOEmgJs4cM
	vPPEzQmpQbt4KxS4ROQY=
X-Google-Smtp-Source: AGHT+IFfYFJ3H6MHGXkZxUwtNrKhvKS2i7aEibqmChB9ejFnkuFqgY0c21HHcZ68bh6mda7wa7inKA==
X-Received: by 2002:a05:620a:44d3:b0:7c7:a5ce:aaf1 with SMTP id af79cd13be357-7c928018e95mr2986289985a.35.1745429786563;
        Wed, 23 Apr 2025 10:36:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a6eb31sm709808085a.3.2025.04.23.10.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:36:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7e1J-00000007Lca-2cT8;
	Wed, 23 Apr 2025 14:36:25 -0300
Date: Wed, 23 Apr 2025 14:36:25 -0300
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
Subject: Re: [PATCH v9 13/24] RDMA/core: Convert UMEM ODP DMA mapping to
 caching IOVA and page linkage
Message-ID: <20250423173625.GO1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <7d6f3d50c4e6eb3ab75fd4c5bbaa8efcb1a15b3c.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d6f3d50c4e6eb3ab75fd4c5bbaa8efcb1a15b3c.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:04AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Reuse newly added DMA API to cache IOVA and only link/unlink pages
> in fast path for UMEM ODP flow.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/umem_odp.c   | 104 ++++++---------------------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  11 +--
>  drivers/infiniband/hw/mlx5/odp.c     |  40 +++++++----
>  drivers/infiniband/hw/mlx5/umr.c     |  12 +++-
>  drivers/infiniband/sw/rxe/rxe_odp.c  |   4 +-
>  include/rdma/ib_umem_odp.h           |  13 +---
>  6 files changed, 71 insertions(+), 113 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
