Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A9428C5B2
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428644; cv=none; b=HaALqzsAmXNpkurpgww2h6KilIebE79HyvBBsjRIofy0uv+3lF1O0MEhJlGijKMTLX9YJJrGtOg7/uZ9tDuuINkQOtQqXSNVtupCN4wkauOZjDZj5RtnKdiHtnr09Sg5H2uso4wSHFptjoF547Y6iISZNgHmvVKB+v8lrxwi7/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428644; c=relaxed/simple;
	bh=EiBhyUfzV2Z7UDyJtWT+jDVz3vG5z4pmjKVdd/tf4pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNhjfVrKFSeBk/r6bcx6ql+BH44IrWbOJd4UYX2XAk8r4AXmciOfNKPvXMb3+IjbhMNwB8Sib+WVnJO7m/8aJ3lKqVx5EY9fFKQCLFWukgimV1qP9iXiwQ2S8JbifiQ+KEdmP3d00xboGwkJ38vMJVlvMU0xF9H0EmivRL4bfOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=npaeDpuZ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="npaeDpuZ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4766631a6a4so837491cf.2
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745428641; x=1746033441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFsItIzcNoABKT1tTnR+L3KluEl/QW6UiWkd3yuS4gc=;
        b=npaeDpuZ5VPkOZqrigtgKEO3dCkGR0IX2y98q9Ii9PH6a4ySKU1Jl4WwtNJ6vivJox
         7hEhKgYIFPYqeHFyrzJiO3d33Z8ckzVE0eaA8fEtLnT8cYn03BrtVZuBiETLqrfiK/nf
         gFTPKeLi7Cpt7+qx2b+ZjMHPmjzmah7oNakivA1lRSbQMUGY1if5wHCAKmZlpI9uAt6a
         Zy6Lvyyn98F2uzFdf2FiWobaepLTsF6ukZ61MMk+0nGEE0Blu0FjWpPxnQrpfafrFL4m
         rX9Cge4tjMFyn+s+tbrBkE7lZCL4t6Rs9j2pRiBe6X2c5Xq9grXs9D9XN/yfjfw31f4z
         4q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428641; x=1746033441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFsItIzcNoABKT1tTnR+L3KluEl/QW6UiWkd3yuS4gc=;
        b=aWzRQcX3gsCXxAFkLGV9QDhvIR7hBIIxEy3ThD/5CFqZIxJG5bydK5w4+Tez8ah/bX
         MTw3FPpKRDytl8/NpdOyCun2/x9Ee2CjVFaKOFpiuhMVOhW49QM/Qm6ea96sUKrPnLTG
         zKJ1OMZz/htfIyPIfEFmRHOhgwbZK2GUk7FamZkjW2wOkCdJLSZtn7o1xI3hTm+7SU0F
         9v8A30fjkVWg7DWd7JZaE8fzZfwxIBuap6cee5xPJPQix2ejzv9h0wPRwkX4xX8A9dGW
         3sJYKMuFgACbPVku2lLUw2+c4amak58L8f+LJdB03rrGmU2o9DNLeQtk6FMpoMtVXBZL
         kwDA==
X-Forwarded-Encrypted: i=1; AJvYcCX9TPCoX9Cnlyc/8PUL7umY1iYUwZOwa6K3x5W2YGS0QQJeUHi5QTi3e0iWYNlmqer5tTsZR/u1xDnVnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuG/ogszQ8n3Mn9WQJq5YCy57kHWZNNG4j6iCO5tFbeBECX97a
	rV02+qBVGiZ0UIK1YbEybYjTxg1m8go9j3Zvh0Px6GbjRZVY77vg0aZGtc0o9hw=
X-Gm-Gg: ASbGncugeSSBwUElcj9pKeUmY2RVhkecDdOyOh6wjRpkTA5cRGDjH7kbYBhkPAkkDZi
	CEve26IyifQp+oPR5gYTz4Mlx/WP7WZLS9mQdYfHBtwqpdklYI3fJopJuFgSQpMcxborb35h+8V
	IzNVt3EsJwCrLWGy9GAR4cEhjYuTBxBxQ7FVMjpe0AumYWIJrBoMu8qw5ZERfSkgId9sGOgOVs7
	FIe9kak+5Apnd0y1DakfTpoiJKPe3WNXyA6tWgOJwWiSouXcs5DD59ycdCOanmBAP4wTQT4CBAb
	ZYnkyX2pZR5I6j6aJFa1aXZAEWVLJN9XLtZTqxUIGaGuFC07D+NKngxHkqHGvP3s18IrdtBDj51
	4NEckt6Nk7lM3xRG5ojc=
X-Google-Smtp-Source: AGHT+IFtKlYmuMPWfMKQK8kh2VV5wwxeBA4j6ePEQHIEvAPMlC2NtpfOcLZrcYI7RZQRiXVuJwSHAw==
X-Received: by 2002:ac8:7f51:0:b0:476:838c:b0ce with SMTP id d75a77b69052e-47e7607d5ddmr844071cf.13.1745428641397;
        Wed, 23 Apr 2025 10:17:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cf9f29sm70808611cf.71.2025.04.23.10.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:17:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7diq-00000007LSZ-1iS9;
	Wed, 23 Apr 2025 14:17:20 -0300
Date: Wed, 23 Apr 2025 14:17:20 -0300
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
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
Message-ID: <20250423171720.GL1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:01AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Introduce new sticky flag (HMM_PFN_DMA_MAPPED), which isn't overwritten
> by HMM range fault. Such flag allows users to tag specific PFNs with
> information if this specific PFN was already DMA mapped.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/linux/hmm.h | 17 +++++++++++++++
>  mm/hmm.c            | 51 ++++++++++++++++++++++++++++-----------------
>  2 files changed, 49 insertions(+), 19 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This would be part of the RDMA bits

Jason
