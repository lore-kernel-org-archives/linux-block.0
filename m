Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE03396F8
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644850; cv=none; b=YH2D8JOoYamJXwaUSJ4c36YZLzzBxGqFi+dl6LM+7FMHM0Z/NUp0r8WKpcZaU1KYPDwGqLKrGsWldoq5UZQeeGCPU1avJJmU+FzKiBpbXoMfduoJZPoO89/rWinZ/TRDsgMjk4goiD/XkHB5jUQrJ0UCWSweD69WBqxwPdxrHHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644850; c=relaxed/simple;
	bh=FAIy2u4gJscDNGUshiInImCPqOKl3iOKQJH6e6Bc4JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j73Is1L1y/hYZPTLGyM2b1FX5oE11NPoP8+GHXxjSWSqBJH27j8ZTcBuYQpTPxx8s89sj6hK9gFFbTcg/VLnnJyL8Sm+PsBYyh31534V6ZvDQGhhe6Qsa3um+YLkIJDjJAjQLj+dnsHS2VnMEcHVUFzESOclAKx5+ex52iYODVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jMJVlNB8; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jMJVlNB8"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2e530a748so73587085a.0
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 05:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763644847; x=1764249647; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GaI8T1P9V7HUSR5GC1P83jhUObFww+4fRanAKkUJgJM=;
        b=jMJVlNB8LyM4AYZyl088cBiSIlJ90Q1dm2hb+qOJix1EHdJs4siUbnVhSfjdoo+d8b
         CpJ6KfO7u7JniZDhdoBs1zVrqavLhdwn31rKFf/kVN8vkyxieUH5wcPJTih/9lZw+PEX
         fzdm1aYuxKCanV8/aYUVsuP51mR3HV9FaHggDK4qYX5m3Eht6ufYvvO9vptn0SOijTOl
         cfmQgVoxaFFQaCv0MtR3VFkL7VdP7LsWZJMB5e2tkAY+4CqMtLl57rP2UzUjo5ld0ad3
         Ew7cnRVtQJOT76Gc3wbQzgtVC/yQSTJ4MullMwUuBOCRwifmwR9JypsEhj+RRVt4akF1
         VX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763644847; x=1764249647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaI8T1P9V7HUSR5GC1P83jhUObFww+4fRanAKkUJgJM=;
        b=JT/SXHjoPfbxQ5di/2H3gvSsUZlf5p09umObamHcOzWjoSli7n1zgW6ykVV4VBVd+u
         2rWa42ePYSz6tMaJx+7NrsJ1OTsdco639SeAKHmeF+93W65eUUymACn9uIfuVW5hvRzn
         +sKHqS3sgZ3bjexTXK2HhgaccYTIk3kBmasU4G61pSle7lAzOOv0RO9znRFKvo9txeKY
         N0iQLl6WlGn6oTGHmdjMvR3ursjtFB4P6CCF0yBO6mU0aSF48MvsqJooNuJ5SvHHUzny
         AYpDQ6uDvV5RvtNLPOQ8uXjwLgoeMJ1KzkfFnmRTIkQsxL8uRXyLiY3CLOCyUjbb8+lx
         m7jw==
X-Forwarded-Encrypted: i=1; AJvYcCVOxwTLvWi41rZdvS8x7LWqDnQIHdnWsMZdF8CJUciE3dNijv4joWg2pu+UqmxQ3ToxMN0oUnwYNXSjqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKZc2MDqvPoRd2amyvogU5JWZtXrSpf+lWXy3sZBzIkPTeY685
	QvD2nmgWZYIhnzKPQn53RpKQ04tHkrQu1w6dPS2jJqtfkKju/3/6749dZfj0w7rfzEw=
X-Gm-Gg: ASbGncvWL2WlqNI26FE2ta+xqNJGJkIREWfCelZ7/CFa8wxiPKaafee09p0Ttb4M7g4
	jIRQw/IU5876Fvkz1/IIU3dFFudW2GzxJkFuoIDN0qxI5fB0NGQf8RYt6nyAWOoInRSFiQAfL6B
	SQqgfJfOPY4V5Gow3q5Uj7tNsrAUcaMs/Qq4UhT0wTQHEaGhiEAVPwnuJFeJyex85/TuibrD3N4
	t48AmGVdTZ7yLRcblQBlDqpCB+s4OUbm7/C2C5w3ap9ihchcGq9VrPSmobecL87Bv9UYXuOAYNp
	GP1cUaw8YhrgxFxd1Fnv7GKswEzsjVl5VilVs+Ipl8acD0e52susXsYR71EfUW8rVrlry6GzsYP
	342xtifUh+mj1Gt2ZpgCojz2iutNSF/pDN5l+TpQqSxF1zboorHElI/dRbW34ykMtKC+n8k4WnV
	F9c8cg9J8ZwKh/euTBY7+3+E1bnKalCnzHzoJ/tQ4FuSA8qEa78CK8Yzbw
X-Google-Smtp-Source: AGHT+IHQ4fmxCAI4/D2tK1B8sYqUFbudidu6PckWMercsX/iRS90WBjHNHkg95yPWC8b179KW1QKQA==
X-Received: by 2002:a05:620a:318a:b0:89f:27dc:6536 with SMTP id af79cd13be357-8b32a193b85mr303322785a.54.1763644847316;
        Thu, 20 Nov 2025 05:20:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295c13ccsm148498285a.26.2025.11.20.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:20:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vM4ac-00000000gLM-0tBz;
	Thu, 20 Nov 2025 09:20:46 -0400
Date: Thu, 20 Nov 2025 09:20:46 -0400
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
Message-ID: <20251120132046.GU17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
 <8a11b605-6ac7-48ac-8f27-22df7072e4ad@amd.com>
 <20251119132511.GK17968@ziepe.ca>
 <69436b2a-108d-4a5a-8025-c94348b74db6@amd.com>
 <20251119193114.GP17968@ziepe.ca>
 <c115432c-b63d-4b99-be18-0bf96398e153@amd.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c115432c-b63d-4b99-be18-0bf96398e153@amd.com>

On Thu, Nov 20, 2025 at 08:08:27AM +0100, Christian König wrote:
> >> The exporter should be able to decide if it actually wants to use
> >> P2P when the transfer has to go through the host bridge (e.g. when
> >> IOMMU/bridge routing bits are enabled).
> > 
> > Sure, but this is a simplified helper for exporters that don't have
> > choices where the memory comes from.
> 
> That is extremely questionable as justification to put that in common DMA-buf code.

FWIW we already have patches for a RDMA exporter lined up to use it as
well. That's two users already...

Jason
