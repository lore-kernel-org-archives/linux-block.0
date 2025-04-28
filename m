Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3982686AA
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846195; cv=none; b=QQpcWs3mHGJcv44AjjTmToFFI5tpIOzdrpnnPLXBTrcXvc+eYCl67vQK4J2tZRxon+2d7PhzJMO1l9E5xEzGO9xH/1UFG+g+6OzuA4dqySF7THBLKKJ539rOZPE1rzTW3k4gXjxq6ei4nl6XzKK+lUVYmcR15nquyDFFdXiMfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846195; c=relaxed/simple;
	bh=NW84TxEhdb7ZElUc5cFUgz5zc5jpHgx7GoeBgURA278=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/nly2meZNNO+LCZVU5163iMP2THm7sr6xrgAK7P7ZVcKySBqobSROZOezzJN5lFIXNvPGb+mqWuyR+CTqxS8A6tKVSBW4/CdJ1RUiTAO8DQ9g0lFFrX088lCnJGxyyN2t3tkC3nmvPbJbAJH6BnloY+D33qUxjwElzILiUxaCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=N/XOlj9E; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N/XOlj9E"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f0ad74483fso54775596d6.1
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745846193; x=1746450993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4DHTb7AvO4YicH+xSWtDalbuQanacnJSYHX0xM691I=;
        b=N/XOlj9EFqhqN5MhWNQAiQ+QnTjPBWKDnC0nsRikpONqYlFezdqGxS2LJY56ggJ+mt
         JkNXx1eAXQ0xucYtxQXYDAFibfCxNIIu832IdctCno0zDAB24Bu7nvnin4U4wyxe/1kp
         zD+0GcShK5MfbKTPnXw9UQqUrrpYggeWrFKjywHAg5ivdfg5C9jf2sa3Dcry+88GIdGk
         xwy6i3RsslHx8Tr+MkipL2QTqCbomlv2KJr4e+MHcIkVlCutdWik/D4sEOK1yj+QVhne
         sI+td4RlizN3PgS9Nsm6v2gQ6m6ioDYTiIXEQPA5J/ncuPm5PC/YlHCYV5OdDXtU/xl+
         bWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745846193; x=1746450993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4DHTb7AvO4YicH+xSWtDalbuQanacnJSYHX0xM691I=;
        b=YrEPW9kNz+6v5jmoxRe86RVk5kouqyPmx/PtTdSoZqvnr3+MHVEJAN+PVC67w5+yA5
         nAdAM91XYfXRzRI9CZ1Xg4PtlSnX+8/6D8z4N+9ODsZ3HCcn8TfENUi429SJ6AVhT9FA
         S1hsIaPHD/+P7GzK0XPDlMzoO78/3kBNVojoa9JHv8JJbcZHtaRitZCnGlj2cqwPHVIC
         jxB/UbjHksiER1aeveJJXocmaoKre2lgYZfVoat2h5oPFUdpsoOQYcL3QuXFDGmFYytv
         OAzC8o28qWllg5RSgQA2QMUvjgmd3HPyAL0ALNAE/OvpvkQErgw0d17I/ffJomDE7gaK
         X2/w==
X-Forwarded-Encrypted: i=1; AJvYcCWu53lk82Tc/BCjoC9cq0kht7TZJyL3P+W0WwvChW16lbxmE8WhJbPJ3TvhQCwdwxlqa+1jrBUjpFXnxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWB3sNJqchy3dwNojt1fwYYUWhhKdMXunhs4fFLZYh12Rr7B/M
	SxroOhDLIADSiTd+ZXJR2vLCfENUypRpj0w2YdpmwiOeW2vZC5SJoF8/OZNBcK8=
X-Gm-Gg: ASbGncsENBPEx5CZOMkMZrXdo0YAuuHpXLC2pXtdsb1GlKzThXqcNhver3UeXOvgei3
	GxULBod7bzXRIN3cHU9YpVjOlD3KgB2WTfU2XDYRZCXUO7vhnQQbxaKXAZM/LHdzEjUHUZjRbto
	ognKQ7KWutMujBFV/VuCL7pXTGol1D5gq7APrqjcYgO66dwWjy9rbBNEIsU4bZGMnGDY5bkL5H1
	JRkLX6RiD7OhNj8DaGjs2//vyguddbkErGQFBTjM2kdY/1SyP00Bi31a8fIqA0EWJsdZrHprL9P
	KjmEUeViLBPQquFsT9CGixh4ekAwNVvuO3ME6Zyh2dBodtQwCPTuT8O6XBRnsCNmiEhPxkTIPCv
	3qwDF4vTf6l+5X8Megpg=
X-Google-Smtp-Source: AGHT+IGm1OrVyo7NrhtixKONc1TT2Ec0eky4BVMvt9fZIav2cWhkRh7ddfgsBqvKXcfpG60XtXV5Kw==
X-Received: by 2002:a05:6214:76c:b0:6f2:d367:56bf with SMTP id 6a1803df08f44-6f4cba51bd9mr207427746d6.31.1745846192886;
        Mon, 28 Apr 2025 06:16:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c74d3dcbsm53164536d6.50.2025.04.28.06.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 06:16:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u9OLX-00000009TaN-1zxp;
	Mon, 28 Apr 2025 10:16:31 -0300
Date: Mon, 28 Apr 2025 10:16:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
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
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 07/24] dma-mapping: Implement link/unlink ranges API
Message-ID: <20250428131631.GB1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <2d6ca43ef8d26177d7674b9e3bdf0fe62b55a7ed.1745394536.git.leon@kernel.org>
 <aA1iRtCsPkuprI-X@bombadil.infradead.org>
 <20250427081312.GE5848@unreal>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427081312.GE5848@unreal>

On Sun, Apr 27, 2025 at 11:13:12AM +0300, Leon Romanovsky wrote:
> > So arch_sync_dma_for_device() is a no-op on some architectures, notably x86.
> > So since you're doing this work and given the above pattern is common on
> > the non iova case, we could save ourselves 2 branches checks on x86 on
> > __dma_iova_link() and also generalize savings for the non-iova case as
> > well. For the non-iova case we have two use cases, one with the attrs on
> > initial mapping, and one without on subsequent sync ops. For the iova
> > case the attr is always consistently used.
> 
> I want to believe that compiler will discards these "if (!coherent &&
> !(attrs & DMA_ATTR_SKIP_CPU_SYNC)))" branch if case is empty.

Yeah, I'm pretty sure it will

Jason
