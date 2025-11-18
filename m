Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F72DE702
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763506978; cv=none; b=Nfft3hmax4newLoaCqoTUzuFkI3YqbS5/y9tY6erF77hcsirK1najWGsH6ffMa1XtZ2Ce3tm3FvrXdoV6czj8an3W2xE1rZvBDdOzr8gO9igllApVQxjeKHiX/pWcdrNKcG/5YiMIyyoCzUQhwGZTzxi9VVou9yaNXZwR+AJBYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763506978; c=relaxed/simple;
	bh=scFNZX9ag0i6pgwb7zn5W5v2rOxL4+aniwaNGa7QpTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkSZhaB1tiflWCFaAFg/4+sxdujK1MRtAL+In5jAG7xYKG61B42y2lqCxGAJTG1PlGarlHEtVde5aYkkOorOne3inHxc5gToMWNmB4vCKeEEV2iSOhkTJEOxhf8cNG10I1lYL/esZNKtdqlaIwhzv98NXEaO7d32oEoz2GTe8q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PGtrMolH; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PGtrMolH"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b2dcdde698so502965385a.3
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 15:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763506975; x=1764111775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9774m00qC+l22EqhxH404c/5WuwECoHlv+7tMAloKg=;
        b=PGtrMolH6Qz2B+82VKf1tqJiPDAxYTw1ids62c39Hjs96vRIcsgVJLYiUmwdEnCZtd
         +cip3SWdQ1IAz+Wc9ftRRHpkdn635dM17uGQggs02cjVxhL14Pyn8YNfqVoGmOq9J/7T
         wa3EIqW9TPC8OrvrngjqzH5aXDB6ZC8za0V3t98PCbk+XDHVS+i9UVe2MiA2sDZaGCw9
         SJ6oFOpBWUPpMIrZaEXmW2/8PBOA6Kcx5SqFZ4VRW89JehH10ySlJf/qqsZRhb8BfYjF
         xbSVLqnwywsiz63rrA8JtuloT1Is74xQn1fLg51SzLGsuOB4IJOoEKMMQ2ZKzgScxY2+
         +Lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763506975; x=1764111775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9774m00qC+l22EqhxH404c/5WuwECoHlv+7tMAloKg=;
        b=ACSmBxMoSvcpKHQ/qrLmBxY1wu8aDqjv8GQVQsakinShaE6PuWQAGip8KDapsy+dKx
         zM4zPUFP4Gk2gGGESMTG8POXKVZnSydULhMN3YGxMEJppaSQTU4icjjBK1V0Zog1uniK
         oywALYuEDBzV4wLLmaLqEdw74ngOj3wqfaWQxgsXbWKH3OSuxwRVooKZtLvpr5HtTw+n
         vyia/zzI4FA4pta6tkzF14PNWaiC4L2kfNP3IDNEzYhMdCqz+zXVI9WfM3Fm+Dfwc+iK
         k1eTc2uII70MBranx45doEoEztuSp6yn9Z2P5srAWc/+YOzr9lLr0+Kr7PhpAoPAosgB
         N2og==
X-Forwarded-Encrypted: i=1; AJvYcCWC2aR3LdG6TTWsT27XIXX++loBYAKjALpZvh2q70BfST4wWlFvIJEvhPpUUzUTPJmf9LEqccPEgjJVeg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy/czwoLdSCN9H93azp0m2eEqFNxzY0R57UB/5FkRzG5cJqJFN
	kp4xj1R3EcLkyhZqH6qZxldvDfe7BEmL3jAdXgMB7/x3qVvp+Bmj5Fu0bUO1JCOWPvg=
X-Gm-Gg: ASbGnctvEsVA7D3deeAO9M7C4zXz/NoFML1fHmPw1Wd8YN0Uo1VCmzw/eMfnzzHZA3C
	heWj2mLQ/7apxcIpvbLuPGrlQHgvYwTQzAC8J8HxXfip2ZVDEfdbDFKY1X3Tmi1v76of0fAuVnL
	6FTKLBv5YUuZ+18tkKyYaGxoW01qfosLPZMxGlKRsjMxfjqFX0QVP0JchW0CxVZq72u1xf1BXx5
	QK7b2m4JbiqS6FcIa+Vqz5UhoFBrL4E6lLSo29G8luG5eFE37+4dquP5eVU6RoQzYk4zRzaPKaV
	1wOejHuDkOqAld812x3eWh/kPMgQs8dQSUBmkVmpmpLhUAULYrCXd+t+O1CMZkhoktxylwGMfjF
	4jpIEs57dsu/6i7gmTkiwiNkqcln3kUY+B1QDLz9OhEWSj5q1WW+zJEM4wYquCiA6nELTPTBNiC
	w19BUaHStboDh+7fKmcvnm1T8SzZ/MkOOIoANdSN/yR8OIofHvm0IDmW7Z
X-Google-Smtp-Source: AGHT+IE7qxNdGTB3O4Cyd9l/l5kqP+7hVSaobWOJQOGThUG/TNMz01RlkEIy242KlmPT6y0A+36Y2Q==
X-Received: by 2002:a05:620a:4454:b0:8b2:eab0:629a with SMTP id af79cd13be357-8b2eab06506mr1265910785a.70.1763506975311;
        Tue, 18 Nov 2025 15:02:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2da3e4cf4sm883665285a.10.2025.11.18.15.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 15:02:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLUiq-00000000W6g-43N6;
	Tue, 18 Nov 2025 19:02:52 -0400
Date: Tue, 18 Nov 2025 19:02:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Kees Cook <kees@kernel.org>,
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
Subject: Re: [PATCH v8 06/11] dma-buf: provide phys_vec to scatter-gather
 mapping routine
Message-ID: <20251118230252.GJ17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>

On Tue, Nov 11, 2025 at 11:57:48AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Add dma_buf_map() and dma_buf_unmap() helpers to convert an array of
> MMIO physical address ranges into scatter-gather tables with proper
> DMA mapping.
> 
> These common functions are a starting point and support any PCI
> drivers creating mappings from their BAR's MMIO addresses. VFIO is one
> case, as shortly will be RDMA. We can review existing DRM drivers to
> refactor them separately. We hope this will evolve into routines to
> help common DRM that include mixed CPU and MMIO mappings.
> 
> Compared to the dma_map_resource() abuse this implementation handles
> the complicated PCI P2P scenarios properly, especially when an IOMMU
> is enabled:
> 
>  - Direct bus address mapping without IOVA allocation for
>    PCI_P2PDMA_MAP_BUS_ADDR, using pci_p2pdma_bus_addr_map(). This
>    happens if the IOMMU is enabled but the PCIe switch ACS flags allow
>    transactions to avoid the host bridge.
> 
>    Further, this handles the slightly obscure, case of MMIO with a
>    phys_addr_t that is different from the physical BAR programming
>    (bus offset). The phys_addr_t is converted to a dma_addr_t and
>    accommodates this effect. This enables certain real systems to
>    work, especially on ARM platforms.
> 
>  - Mapping through host bridge with IOVA allocation and DMA_ATTR_MMIO
>    attribute for MMIO memory regions (PCI_P2PDMA_MAP_THRU_HOST_BRIDGE).
>    This happens when the IOMMU is enabled and the ACS flags are forcing
>    all traffic to the IOMMU - ie for virtualization systems.
> 
>  - Cases where P2P is not supported through the host bridge/CPU. The
>    P2P subsystem is the proper place to detect this and block it.
> 
> Helper functions fill_sg_entry() and calc_sg_nents() handle the
> scatter-gather table construction, splitting large regions into
> UINT_MAX-sized chunks to fit within sg->length field limits.
> 
> Since the physical address based DMA API forbids use of the CPU list
> of the scatterlist this will produce a mangled scatterlist that has
> a fully zero-length and NULL'd CPU list. The list is 0 length,
> all the struct page pointers are NULL and zero sized. This is stronger
> and more robust than the existing mangle_sg_table() technique. It is
> a future project to migrate DMABUF as a subsystem away from using
> scatterlist for this data structure.
> 
> Tested-by: Alex Mastro <amastro@fb.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/dma-buf/dma-buf.c | 235 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-buf.h   |  18 ++++
>  2 files changed, 253 insertions(+)

I've looked at this enough times now, the logic for DMA mapping and
the construction of the scatterlist is good:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
