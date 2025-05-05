Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964CC2505A5
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448147; cv=none; b=U663qGiHPwoy/H2n9yBdvz78tZWz5kzMRnLR3RT3g6lNRQTokK5A4U6pzt9ycFRs4Rps80aCxTwRO5wOjFHrAwuZlHveJFwE2/yNP7DVeZtIYMTKVbAjW5+cudVS5gUaUgwUix5smtbBvu/QeG4PC+YaDl18F/VV0WAVgqYWQYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448147; c=relaxed/simple;
	bh=8st2WkhNjYa0sS1ZjGydQ5cI8qeMQD3qVytw+PewtLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7eFdgEgaO3UPveEzFordoz4sC9wciBOSkPPbMG+RULcSF9DhVLltE08bNOaS5ir2Q+maoClJgS7coFT3vjfEB5D2e961CEKQPn4W+eKhmovV/8E88h/J1j8sHeppoi5k4KQPmPB9ZVle+aHwEHDuY5xHODIeuM0+dqF5aA0hlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=d5rF7RkT; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d5rF7RkT"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8fce04655so47271166d6.3
        for <linux-block@vger.kernel.org>; Mon, 05 May 2025 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746448144; x=1747052944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfu+tu5hpHDhrhemjgH6VucLj0HupA6g7txg5hR1fns=;
        b=d5rF7RkTmsJIBWsVD7r8ZkiItKXsgG/IbfI1O5P30GgnZ18NuAXa9eP3PofKtR4MG0
         K3hKiOCDSlt1JiNQdhav+XFXb3Uu6gZqSHBorp5ZpiG1Hm/lph0vpRPQ0MP2poUZKyCZ
         gLaF+DKDt6doc4D+XMMDB+puE8X1g0e1seAAPnKRXk6pn30VYcTdFZ2Vv58Th9J4lcvu
         QFpQupl7AMl5vIx0jZlhfvDVfNplt3sa/ll0jeXRRN/jOxqPVOuRRbGLzME9SNr0s1jh
         r80iCVsOAcD5bTSFn1dsarpkJqTWD7NBAJ+kwQbClpuV4o31q9LP5LPBTWmmjxrOJai7
         Nf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746448144; x=1747052944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfu+tu5hpHDhrhemjgH6VucLj0HupA6g7txg5hR1fns=;
        b=lnAlJ3yjDKMbQsTzx2twFqczcYOG5REbeFqBeu5YigUeO9kkpxEvx7LBNvs/AwSD9L
         /Whaiytdmo1Nv0pWFYn1e/XNy29oSLC2wlkHZPAM/pWA/HZW77JTFt18P49nUZ3CHgn3
         SKIzQrcu7Mo2HssASs85kDcQFxiXqheMmYyZgY8ZHjk2aQycD6XI9Urhs3KGrKILBDPE
         BxP799KK2Gih7TIjxgZJoz+7hRG35zWsT2YMn/+nFNMy2RZFHU8P0nXkUepgQyWjJ6Ar
         OQ97tJdJnIXNUEXUESEp46mhJrOXq0i/bYnj8B+vQzMAXd+URWC/ixFhqYNb/cOHsJ6P
         d4uA==
X-Forwarded-Encrypted: i=1; AJvYcCUYc6SF6to5spZKKPLVTrFRJFec7Qs1xlbac8i+OlL6O+gNcHggxP205uDjLUwTckvcbJ5T7bJ8lGeWVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKEhRbcyPkF09eZqbZfzc3rlG6i/eiXrNm3k/8wvKwI/ANDTwx
	uzsdPqlfGGXj7cB6vBT23QKVAbSx1ygDvz+6P2b91bejlJPanyIW3dCHRL6Ubug=
X-Gm-Gg: ASbGncvUWa836wlullkQnj15TOLUUHhJvwdZ+w6FpGRNPcbVmEIMuY2Wu+vU/u97JEU
	8ueiCYrLOFEIihOhrN9P3oRNc/ZZa7djGpyndG+P+IxhalDYRbC5OCJ3Og2rrf9DOF/ItM+1Kyi
	1nZUhVYt5W4gLONNd6OppBGw28Ii+qQzZQoMGq4+8U3Mfz1eZyjuaPZXYBeAxrVwdFS5oLU+yOU
	eqDWxz+6/pnxdjRiCMLu0UEG8CfKIQHV6VOpH8mQZMOJ2eav5vyNVK99rI4yx0TSi9DVUvuKxuQ
	WajgTcGlJGJZr94Z+a7ZDsOt+jwcFMsjCHpjGGt13S8l+OTvaFK995fIRC+RmW1wLrmgMu42Ana
	klgzZF4TLwXK+7J88V8Q=
X-Google-Smtp-Source: AGHT+IHrrCkbPkXSi1eXZMzeybSC5P++W/lKXALdeEOdhNPGMmZG6yFN5oZZyeIbSctGCJtNUEnJAg==
X-Received: by 2002:a05:6214:b69:b0:6d8:99cf:d2db with SMTP id 6a1803df08f44-6f523852b68mr146814446d6.38.1746448144313;
        Mon, 05 May 2025 05:29:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3c3887sm54983076d6.38.2025.05.05.05.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 05:29:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uBuwQ-0000000GxAs-3q1W;
	Mon, 05 May 2025 09:29:02 -0300
Date: Mon, 5 May 2025 09:29:02 -0300
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
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v11 0/9] Provide a new two step DMA mapping API
Message-ID: <20250505122902.GF2260621@ziepe.ca>
References: <cover.1746424934.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1746424934.git.leon@kernel.org>

On Mon, May 05, 2025 at 10:01:37AM +0300, Leon Romanovsky wrote:
> Hi Marek,
> 
> These are the DMA/IOMMU patches only, which have not seen functional
> changes for a while.  They are tested and reviewed and ready to merge.
> 
> We will work with relevant subsystems to merge rest of the conversion
> patches. At least some of them will be done in next cycle to reduce
> merge conflicts.

Please lets have this on a branch so I can do the rdma parts this
cycle.

Thanks,
Jason
