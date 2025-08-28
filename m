Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3579220F2C;
	Thu, 28 Aug 2025 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394364; cv=none; b=CNGy+TU4Uoci7uzfLoXZlnoYtLVh4zgeL1LURvZBmue5ZEOGj3JGnMNDDPruToPtPX5TXh3KMkf6N5/+r+EBCsPc72BiOswvMv7EDtY6AV5bqQ4vvmkUmvqrGUutPB6u6U6OU8GKvWpQ2NvlIKHzApedtebPHO17aZobGkHj8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394364; c=relaxed/simple;
	bh=nTKrcpDsshWT34MR4DBCaPN8mPA7gJtcVOPD1NWA+qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1mvEnU2IpNcmYxpK5k8whUxYOjt7HBLnLbwXz6cXLxFOKPgQxf73u630Oys8Ht5yZAI3ONW6Yj29KEKW/4nKDhBHe3YNdFeY7TlCRzEqWdzI3SNh41zw/IxPLiKBOJDrAGWodQzPIc7m0OTNnd/T9H6axFs7gYVfZSt/xl9d3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fiz/IFX/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fiz/IFX/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D216BC4CEEB;
	Thu, 28 Aug 2025 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756394363;
	bh=nTKrcpDsshWT34MR4DBCaPN8mPA7gJtcVOPD1NWA+qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fiz/IFX/cbprksFrwcYLPDvY3Zj3oM+9xj/s3otiwCFW0WEBrDAgB6JRjK+IdqZnC
	 OFN4Z0AL7m05VQmwPYApcrLewjZzB+NKCYXZOIU9ibwe7/P/cr26ecTqFmQEgaS6pv
	 89DgMHR/jfK9TG7bugNXs7ta3ON2u0FFPpRcZMhF8LuBBzR8fYiYNcrkRaeoqL84Pa
	 vG8dcgdTqIBhIwwgWFEaigYJZlxM0LDruE+7Hf8BMGaT2uPwEeDcL2AHvfnUbMmlQ1
	 qic40gUjOmMG1Ib24qu6/1eYpqYTDcYO5/R+Bonh5umwbDCeb4/lCZ33BnqzYEikCq
	 EOso5xuGJTjTg==
Date: Thu, 28 Aug 2025 09:19:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-nvme@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v4 15/16] block-dma: properly take MMIO path
Message-ID: <aLBzeMNT3WOrjprC@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <642dbeb7aa94257eaea71ec63c06e3f939270023.1755624249.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <642dbeb7aa94257eaea71ec63c06e3f939270023.1755624249.git.leon@kernel.org>

On Tue, Aug 19, 2025 at 08:36:59PM +0300, Leon Romanovsky wrote:
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 09b99d52fd36..283058bcb5b1 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -387,6 +387,7 @@ enum req_flag_bits {
>  	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
>  	__REQ_ATOMIC,		/* for atomic write operations */
>  	__REQ_P2PDMA,		/* contains P2P DMA pages */
> +	__REQ_MMIO,		/* contains MMIO memory */
>  	/*
>  	 * Command specific flags, keep last:
>  	 */
> @@ -420,6 +421,7 @@ enum req_flag_bits {
>  #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
>  #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
>  #define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
> +#define REQ_MMIO	(__force blk_opf_t)(1ULL << __REQ_MMIO)

Now that my integrity metadata DMA series is staged, I don't think we
can use REQ flags like this because data and metadata may have different
mapping types. I think we should add a flags field to the dma_iova_state
instead.
