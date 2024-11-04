Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E48C1B6CE2
	for <linux-block@vger.kernel.org>; Mon,  4 Nov 2024 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722770; cv=none; b=Ue+B8XSFuKrwQrb1tOlDxXx6Jsc1lms4Um5QYjSU6slz8UiUepT7oAQ6OcTV6v2qckYe79Vc2IKQt5i0vQW0GvuB6ZkJCQeUwu7uOF9mFaPe2SbfE9IFzXCbM/mEWwIprlTovhFrsZ3jAanykI8t/W8Zj7+Zoqu96+zAOUR/HSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722770; c=relaxed/simple;
	bh=WafvJUVr8z2C1zDRQCvtKO+6K1W+UrIoTEdLDQdvuUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCW6e9RoABZNNPoHoy0z4F9lN/TiOtQH54m8rOFxQfrEF4Z48gNghBo2jj9pLvEGKn1rV920w1EuE7SaBuH5rxgucvmx0a0d2D6lWtdQzsY+gdRlbAjKbpXXmJV4Vf1IOlSCPNl81dZTbFyltEb19XViv2wMYeML6uddFaQiONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bU/bwQTR; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bU/bwQTR"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbe9e8bbb1so30847196d6.1
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2024 04:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730722767; x=1731327567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tx1bOostXz+VH0GPtKgcyKswUQOWFhDDl/A9OfJb8HU=;
        b=bU/bwQTRIAnSnu3ity+sjC0E2sq7Lx/G0WwuhQK1tFta0i+JHHb4ZgDaI+BwMp0GjP
         mTuJkPdog3bS5cRlvNdXCOGo6r9C6lL8DpawfLdS9WQBuXkSkb3uRvVJ+3Jft2TU0l4z
         Z7KQQ+bkelEINXuk6QjGwNJ1comMgCWJsIkvNFZ5eRsjDjojgELoEC7yc5lG8mAlNej8
         74E5s7BmIpYr0/slUqyH43XmVbIAUeR4ArRinA/7yHVjpHr70CAydaCZc60vL5kQVRHN
         60rPc+umLegF9M1e2Yl3TaNdXedLwfhi/5tJn9HzowNouiuDeuDVDwHWq3Uougepuohw
         t3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730722767; x=1731327567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tx1bOostXz+VH0GPtKgcyKswUQOWFhDDl/A9OfJb8HU=;
        b=Dsm60JnWbGBfNbCCBni5O/u4ZDLGKhVjb6/X9Fr/jJUlyjD/r3yt6pl5kW8kFJ5tgj
         9Iz2Xf7X0cBl5J3iZlaFPXlRQU6fBeyHNqWOtjVMMy85M9PplUjWDlsCuTO7OoiPUGag
         zVi+KuQsPoliYFPMYR9bf17hF3Evui/DcHd96WOu5UcpVpu9oEAoN5muSsaFCsN/LUis
         iZ9+cDc+kTYLax4ZfqbOzPQoc6ZvcN7Rfslp+vL1qTMHc827JIUyr1AxHaO1L7d48yZ5
         Rg9yHNYKdC96CWPSTCYRNWx8Mf4dOkXhKqptnWBT1qYgn+W1j8gXCM+YoYZZaJZksrC0
         Q7uw==
X-Forwarded-Encrypted: i=1; AJvYcCXKy+e1cR4L9Vx06AC6xo2YYKB5J7ozohXTgFBB+PaXxI8F1YoxeOXlgPmb4G5xllaOJeBOtrmlSf2NHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9VeG184m1mcS6fDJuH8TMUTCmslKZGhgWAPwsr4p+3RpRGskD
	VmMBmhPrW6OfYjhY6YVdeZ0m507nS4Okw3wSClTKOdlWtrk0K4VYJF2Zk0XJKp4=
X-Google-Smtp-Source: AGHT+IGGw97HgDqXEc70DPdglFSAiLC2/hvL6iix2sWZheUlrSMhSyN4gGvDNAQMyTZfPVibvICZkw==
X-Received: by 2002:a05:6214:3a8b:b0:6cb:c199:462a with SMTP id 6a1803df08f44-6d35c137657mr208089456d6.27.1730722766648;
        Mon, 04 Nov 2024 04:19:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc718csm47611946d6.38.2024.11.04.04.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:19:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t7w3I-00000000hJn-3gHO;
	Mon, 04 Nov 2024 08:19:24 -0400
Date: Mon, 4 Nov 2024 08:19:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20241104121924.GC35848@ziepe.ca>
References: <cover.1730298502.git.leon@kernel.org>
 <f8c7f160c9ae97fef4ccd355f9979727552c7374.1730298502.git.leon@kernel.org>
 <51c5a5d5-6f90-4c42-b0ef-b87791e00f20@arm.com>
 <20241104091048.GA25041@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104091048.GA25041@lst.de>

On Mon, Nov 04, 2024 at 10:10:48AM +0100, Christoph Hellwig wrote:
> >> +		arch_sync_dma_for_device(phys, size, dir);
> >
> > Plus if the aim is to pass P2P and whatever arbitrary physical addresses 
> > through here as well, how can we be sure this isn't going to explode?
> 
> That's a good point.  Only mapped through host bridge P2P can even
> end up here, so the address is a perfectly valid physical address
> in the host.  But I'm not sure if all arch_sync_dma_for_device
> implementations handle IOMMU memory fine.

I was told on x86 if you do a cache flush operation on MMIO there is a
chance it will MCE. Recently had some similar discussions about ARM
where it was asserted some platforms may have similar.

It would be safest to only call arch flushing calls on memory that is
mapped cachable. We can assume that a P2P target is never CPU
mapped cachable, regardless of how the DMA is routed.

Jason
