Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7853B1E7C03;
	Wed,  6 Aug 2025 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505516; cv=none; b=Rp922zo4xI6sI8BU9x1MJ9NtzuGa2yvj0REMj2+yMWmbyaOncJqC5m8Y6lhKctWelcCJYEgvOkdnqbUsXkXQZY7vfY6PpyyM0iK166o6IqdYpffEtBsxTOTe3xWPGhlNFsJnRkrRB92AG+ArAdWGJCIMZoom6im01qc0cORqIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505516; c=relaxed/simple;
	bh=3VsSAjLVcmccxCZ3hnnn1RvFFPeP1KXfNR/kPK523tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGB+9w3Zal79NvdQPqWOeBLsoaT/6Tq1a+ONW8dICnPbbGwy24jMXAjVBOAGNtSTnTTzoPQugMSfBeLeAw9R7v8RgjXK3wgNX4Bx1JprnGrmrfrO4j4iXRR7WJDeLcUTSs3MdpjiuLugTaMB1Ywp4oup9a4bfA8FzAhNVY47FbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ge50qjue; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge50qjue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410C2C4CEE7;
	Wed,  6 Aug 2025 18:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754505514;
	bh=3VsSAjLVcmccxCZ3hnnn1RvFFPeP1KXfNR/kPK523tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ge50qjueu3yzrmSLvI7mO9n8KQkiFiYfr4PhBvbyi9xJtwRH+3VLE26OL160ezEfS
	 l7n3yTGZYML7usXiAxesUibX5X3uv+Y7zSbVhAbamikh3Xal+W4d9sOmoNJufjNKOd
	 mltqBVBcA3J9CQVjxxN7y8g/410e0ODnTntjvgOrjJZ0GcQu7FKKjy5hCvF14lL7EB
	 GCHlgBFQUU1u6mCSnNeVtRb+60F9YWCMntqEV5h3kpkOIbolMnee/QD5F6iZ+TELym
	 IpJ05UFpUZfqx3imORqYTmOC8S0Z30OtwN23sPhn2SppRACGNtVevxAEaRFm6toCBl
	 Pc8wnVLkh3LNQ==
Date: Wed, 6 Aug 2025 21:38:31 +0300
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
Subject: Re: [PATCH v1 03/16] dma-debug: refactor to use physical addresses
 for page mapping
Message-ID: <20250806183831.GW402218@unreal>
References: <cover.1754292567.git.leon@kernel.org>
 <9ba84c387ce67389cd80f374408eebb58326c448.1754292567.git.leon@kernel.org>
 <20250806182630.GC184255@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806182630.GC184255@nvidia.com>

On Wed, Aug 06, 2025 at 03:26:30PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 04, 2025 at 03:42:37PM +0300, Leon Romanovsky wrote:
> > +void debug_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
> > +		int direction, dma_addr_t dma_addr, unsigned long attrs)
> >  {
> >  	struct dma_debug_entry *entry;
> 
> Should this patch should also absorb debug_dma_map_resource() into
> here as well and we can have the caller of dma_dma_map_resource() call
> debug_dma_map_page with ATTR_MMIO?

It is done in "[PATCH v1 11/16] dma-mapping: export new dma_*map_phys() interface".

Thanks

> 
> If not, this looks OK
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason
> 
