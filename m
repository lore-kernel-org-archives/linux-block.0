Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D15E2FCC1B;
	Thu, 14 Aug 2025 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755193057; cv=none; b=ubIMjtlh1lR9FzvsH/fGSvtqveOam9NrwihjflmSzWqVxy1j6nqzQVhUdB40pBCLq7ZuQ6jDri4bKzp1T8pHHMj3uh8zRfDW833QMgoQqliVqbyQNYnso5Z1Xm/M5Scq4BjgGkRBpFY35lG5pE/MjlstR7KCepp+VwIxmIcXAl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755193057; c=relaxed/simple;
	bh=35OSPT0f4Af9mWm5Mjmz1qp4rxi1vAcU3tfv/dQervA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UiXG0WdXFeCeAfBZozP99vr7wvXamcScYNGcMwV6cTTOT1W7BVNdVY1YggNmt4rqXYm/8RzEyLFl+WGGyhGVr8j5r1vMPoyEi0pCkWXeO2tY7hK42yHoaYUCHdAbC/Of9mGaODEGmbmUbdFvV23ltfNaOdjGAplKSz5xSvgyHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4KLyFDU/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4KLyFDU/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=OE4LAchkYGbRbWIAPtKdq4yp8AV8hBrJ1qdnR14GXT4=; b=4KLyFDU/Vumsz96izTNEFh1dPT
	gcELlCyTppY1dhYETNtbcxbOIeh1/sthMu9DbTeiVaAcP7tcEuyIkykR+tjpcFgzaiM4l5e7zW/99
	WT21f95NU5V6ne9427BqfukuNCmE4P8LKLVbcXGI3NVbyx+CI0xucaJY3VBJ0r3B7kFJXEhhBYBCH
	rRABtXI9ZkOcgZvf82D6jL0f5HF0S2ekt30gXEkdZuKsfcL0Px0gARfb1GdZ7N6PG/l3W5OuzmpWz
	GxsIWFejW3a3LSYz1Mfw2PcJDMlTUQWwRae7vRCeE50nJNZOOiGyqf3SNV1eNn7Mpy146jdENj5EG
	0OjLyf7Q==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umbtD-00000000E9n-3MTt;
	Thu, 14 Aug 2025 17:37:23 +0000
Message-ID: <c855a4f9-4a50-4e02-9ac6-372abe7da730@infradead.org>
Date: Thu, 14 Aug 2025 10:37:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] dma-mapping: introduce new DMA attribute to
 indicate MMIO memory
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Alexander Potapenko <glider@google.com>, Alex Gaynor
 <alex.gaynor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
 iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
 Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
 kasan-dev@googlegroups.com, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-trace-kernel@vger.kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, "Michael S. Tsirkin"
 <mst@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, Stefano Stabellini
 <sstabellini@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
 xen-devel@lists.xenproject.org
References: <cover.1755153054.git.leon@kernel.org>
 <f832644c76e13de504ecf03450fd5d125f72f4c6.1755153054.git.leon@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <f832644c76e13de504ecf03450fd5d125f72f4c6.1755153054.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Leon,

On 8/14/25 3:13 AM, Leon Romanovsky wrote:
> diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
> index 1887d92e8e92..58a1528a9bb9 100644
> --- a/Documentation/core-api/dma-attributes.rst
> +++ b/Documentation/core-api/dma-attributes.rst
> @@ -130,3 +130,21 @@ accesses to DMA buffers in both privileged "supervisor" and unprivileged
>  subsystem that the buffer is fully accessible at the elevated privilege
>  level (and ideally inaccessible or at least read-only at the
>  lesser-privileged levels).
> +
> +DMA_ATTR_MMIO
> +-------------
> +
> +This attribute indicates the physical address is not normal system
> +memory. It may not be used with kmap*()/phys_to_virt()/phys_to_page()
> +functions, it may not be cachable, and access using CPU load/store

Usually "cacheable" (git grep -w cacheable counts 1042 hits vs.
55 hits for "cachable"). And the $internet agrees.

> +instructions may not be allowed.
> +
> +Usually this will be used to describe MMIO addresses, or other non

non-cacheable

> +cachable register addresses. When DMA mapping this sort of address we

> +call the operation Peer to Peer as a one device is DMA'ing to another
> +device. For PCI devices the p2pdma APIs must be used to determine if
> +DMA_ATTR_MMIO is appropriate.
> +
> +For architectures that require cache flushing for DMA coherence
> +DMA_ATTR_MMIO will not perform any cache flushing. The address
> +provided must never be mapped cachable into the CPU.
again.

thanks.
-- 
~Randy

