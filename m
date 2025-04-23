Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED16284695
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429939; cv=none; b=VSiPWVY0z9+UsjiaIvavN3G1unhsHbc40k6VuuCxh1yspdFhG4muFzpGEuJdjzp0aRPFHsNz47NoDhQd/nAkDCyXQP3T5x85Kk9u8ZjXHKUD1OoGgajtrBUX4TB6WBSdktJTFC7Sism8L2Q5WPPHS1Vc4hEoy1hrR6tDqJR7XS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429939; c=relaxed/simple;
	bh=jyCSrAMbJeJJMtfyLp932NW76okHOgg35e8+PFG3Bes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0SFy4PEU6bKQ9aC0aknSRjkK//VmOWC3XKbkzB++Zat8PF7ruPeg/RRWi3XOmexhjz+UYA9rqOVxnPnV3iO0TnwoOaglUnNPpk8d7Mjiny3toCHip/YjorH7OK1+BNlVANxfi6nRKTp11gaJJNvMiCVP1xoyM4b4pIXvp4IYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XV88OjQX; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XV88OjQX"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c54a9d3fcaso7878185a.2
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745429935; x=1746034735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZKbLbO/VBglO/Va9GZRrTXMgQWmFJOWwhYhgpmasyg=;
        b=XV88OjQXLvia7kK4o00ZKUcesjYunq5WroYYymOJIGPMGmbS/9i7/qihmuV7uOasU4
         OXl8PETx5N3fBmnwdHey/3OYAFXqGUH3OPC9lDRQ3t7t5ywtpMDnAQfl5fXiXDw0kz0Y
         CY7vXgT33OAcwYME65ecscD4qSwBEzKjCIcCmKALFBpmrDUzivrqYevJro0byOJABFZm
         U27EyPyD2OYa9Q5WnrYhRvJ6IlClmvfZsSYDVXfiY18SHL3rcq5umqVuzT5sD0yp3yd5
         P0OLu9NB/5EVomSa/v3aTFE9KbMXn5dTG7PuVElsFKFgm+UzdsRy6Q7MuGfp0offCZkj
         bQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429935; x=1746034735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZKbLbO/VBglO/Va9GZRrTXMgQWmFJOWwhYhgpmasyg=;
        b=IMKWdGL3ETJM03WplH4OHEjc3tQ+uILJMCBJQpYftFfPTP6GW9r/0i3QhELzM4XG8Z
         8SCJ3vPiuSI3MAPpmUcEXMwq8IiIIj4fVMRBi3DYzr+LoSqYPd1AT2faa33IMrJSn7Cq
         JQXuJv+CA/6xwaeyyKPZpfr+rcpuVx+kbkx9YlN5KiLsSA+ekmFV7Ln2v1S9c8e8urkh
         9iA1ku2vuhe+PfZC5shYOWg3YCzjUrFaw/61KdP8Iofd9oskDh71t054s4R7bjDn7FBu
         l48JwzQyFznYO0m2eLVOkmTsJUZk/3rhZwLwu6ZnmChYGa2CrtENH94i5k8ZHhnsbR4S
         TH0g==
X-Forwarded-Encrypted: i=1; AJvYcCW7a7j/OJU600XLLMS1ReS2u75d86gjm3uLOgHGbRn5aACCc+oC/tRXk3uFkl+2wKPU5Yq84+ovPfW3lA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIXoBO7C2k0zCM8IjAPlnV18aAvBASchSdrJMd2bKL3fY/zuSr
	qegC16jb78aiymX6cTmXCOX6mtrt4V8hiTpvQlMcJjw45aS6jbC5m8xYEIPxEc0=
X-Gm-Gg: ASbGncsja8dAwP1w/+eKFUNZBndGmlNuechTrrv4k/Xs6GHAU4maahU9ZhURWmXqc3r
	j6+mT0B8+5os+7e0c7y/pnJnPx0qKf04oHAkn2muqQgsBTcRaQv5NGUWJkICz/YPxxwOZ9NQZpG
	JwNl/JL+phraZteymkjKIurz1jMjWPwkFDhccs3zegNv1Dyiym7dWRpT+3mJVnxOuJ9LTqNxXRW
	hCbwnjbg5HTniw4J/Eh1YUgYdA7C99M/0gPjwzKtjgcbIM+IXyZ0Vf+wJtd5YBFGBvOyZEl5KZw
	7PrnYdun18z61auvJ7s5kxA/YSfkeEv8HAFTl5xuD2huhzmk7Sco+1Aty47CYrclpqfrpUgxQX5
	JfCoeFXIvpkxIvU4PADI=
X-Google-Smtp-Source: AGHT+IGgN3qsfS6onNY8+gQMZCTHD3MSF9+S5w+6n1/7VM1d4IchwJLfZsPm7/0ZCJyeB599ZskZwg==
X-Received: by 2002:a05:620a:1917:b0:7c5:ae20:e832 with SMTP id af79cd13be357-7c927f6ff15mr2997015185a.11.1745429935582;
        Wed, 23 Apr 2025 10:38:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8c9f2sm708523885a.29.2025.04.23.10.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:38:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7e3i-00000007Le6-2jjE;
	Wed, 23 Apr 2025 14:38:54 -0300
Date: Wed, 23 Apr 2025 14:38:54 -0300
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
Subject: Re: [PATCH v9 14/24] RDMA/umem: Separate implicit ODP initialization
 from explicit ODP
Message-ID: <20250423173854.GP1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <c79721bb70988f60fa23fdfb6785e13f6ef806c5.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c79721bb70988f60fa23fdfb6785e13f6ef806c5.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:05AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Create separate functions for the implicit ODP initialization
> which is different from the explicit ODP initialization.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 91 +++++++++++++++---------------
>  1 file changed, 46 insertions(+), 45 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
