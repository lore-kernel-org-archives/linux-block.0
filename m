Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02E2269AFB;
	Wed, 13 Aug 2025 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099453; cv=none; b=Ae+lS1df21PNWB1SjNmYVweoxTT3su8FEbERXqDHQPgmyNHBqDXWrKDjdV9vXyCD/LaDGBR3Hz2QX/gyA4qBVIocINgTwoxh+jwR3WdAv2k2JKkbxLctukr6IX2MvZT1AzTM7vmgpnqkz2XkH5WRJ8HHGvBCsj+xUT6o0r2Lw+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099453; c=relaxed/simple;
	bh=PQhq5rWxBSi6wo5Tnnh0V92zapg7M+UyVJSAH0kCd/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFt4cTn3RHVs3V/ong6dsm69eVJSW+DIFuf21Z64O4REfL6eCKN+kpjhj/PW54NLbmTJzAjmdDCIlfbZtW8+t9YueF0TsJEebhFq5sF3cpZp8CpVOAnjo+yIJruCHt2OxAbFA880qaAjI4wpRq0qIkhyCrWhqXo/F9xk45auUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkqdIE/H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkqdIE/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A911EC4CEEB;
	Wed, 13 Aug 2025 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755099452;
	bh=PQhq5rWxBSi6wo5Tnnh0V92zapg7M+UyVJSAH0kCd/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kkqdIE/HRQ5cedE1zyuMfMRaAZJeqzpFBH0/fLyOJbOpD7Q9Y6fUKKVCUSYg6Iu9+
	 +0lhPpaogX+zo7DE625PlBBN7tO+nQtx0LA2aKRv5GqYQcf/TD8I++3mIddUS1oGuS
	 2Xu0FGRyeN7MRl5kxApDBRYf8dHZhW8fLMu9BCMo8fTZeDkfiJH03TaTo8MCeUS3wk
	 Q3N2kSeVd08IYz9d3sNubS0p0XfPjY2fnOy5IU5HLL6nAdg88Wdvo9IzmX54CnrqWQ
	 dCVsQbDhz8GqQ+nB2+l0260S3CZs7QJe8H773Ex1NmDTheYUl2t1VYx6TqiJOtited
	 Jw1XTt4Q0BCbw==
Date: Wed, 13 Aug 2025 18:37:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 16/16] nvme-pci: unmap MMIO pages with appropriate
 interface
Message-ID: <20250813153728.GC310013@unreal>
References: <cover.1754292567.git.leon@kernel.org>
 <5b0131f82a3d14acaa85f0d1dd608d2913af84e2.1754292567.git.leon@kernel.org>
 <20250807134533.GM184255@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807134533.GM184255@nvidia.com>

On Thu, Aug 07, 2025 at 10:45:33AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 04, 2025 at 03:42:50PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Block layer maps MMIO memory through dma_map_phys() interface
> > with help of DMA_ATTR_MMIO attribute. There is a need to unmap
> > that memory with the appropriate unmap function.
> 
> Be specific, AFIACT the issue is that on dma_ops platforms the map
> will call ops->map_resource for ATTR_MMIO so we must have the unmap
> call ops->unmap_resournce
> 
> Maybe these patches should be swapped then, as adding ATTR_MMIO seems
> like it created this issue?

The best variant will be to squash previous patch "block-dma: properly
take MMIO path", but I don't want to mix them as they for different
kernel areas.

Thanks

> 
> Jason
> 
