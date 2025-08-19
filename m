Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79157219A81;
	Tue, 19 Aug 2025 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633506; cv=none; b=JwsKf8qwwVmugXroJ69KSsFRGUV4gQ75750/Fw7ZKAdee0ggrvfP+CbF9a+9pX1rEulL9euOeMvLhvpLin6xh6vNgEpGcEaK1rCYqwIiPINLnZUpqSnmNkg6KqVAmQ/3SU5vlGbhojh/Ls4FxnOCHt8ugMvx9vNloDx3PvlrvAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633506; c=relaxed/simple;
	bh=nA9A0H3LrJ78fHP6AI7J40nKWuK6fskQEP9rQ9tJOXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWc2HsYxf7v7mr+pa8zxCVP63CH6CLv534WNQt4ReyblVd1umjW9JsSwSDmcxzIidq3Q4UP5Njhuk0B+3ZUSLEaRncX7D5kZdphZjlOWJE9vjJzvijutNqbftAGrWiOykLcJlXyHgza4XeU41lY+xmuoMuBI3IsM0Spu5qBeMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3cV0Sxj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3cV0Sxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D9EC4CEF1;
	Tue, 19 Aug 2025 19:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755633506;
	bh=nA9A0H3LrJ78fHP6AI7J40nKWuK6fskQEP9rQ9tJOXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3cV0SxjdjsbyAxLQAHXL9YQoVkd3oE/w0tg8f+/28wYPFIcCuOtf+n31sKJ+LyN1
	 6N7biz9o/yCuPtFBnn8ELyTNlP5RA151eN7wKi8pNSNB92o83ezmb7znz1ImNM7cWr
	 xClDJ2+EAIi/fyYTQNzUsM/2eAKArOgzFRoBwUKtf83SqZF5p6itYTMDZFBizPzyOj
	 cmndtkVjtFJFxZFPGtELV1/fpgrqmBEwX35+EsRatiowr0CXr7OcQuw39qyPoRCSeg
	 uQXDSW9Z/GPeI4IjUnpByoqXUrISGom24QKuNeZMIoK+/Modr6dLR2faOTSocU7qPz
	 FiaHtir3WFZ4Q==
Date: Tue, 19 Aug 2025 13:58:22 -0600
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
Subject: Re: [PATCH v4 16/16] nvme-pci: unmap MMIO pages with appropriate
 interface
Message-ID: <aKTXXv7kE0pGGn_8@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <545fffb8c364f36102919a5a1d57137731409f3c.1755624249.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <545fffb8c364f36102919a5a1d57137731409f3c.1755624249.git.leon@kernel.org>

On Tue, Aug 19, 2025 at 08:37:00PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Block layer maps MMIO memory through dma_map_phys() interface
> with help of DMA_ATTR_MMIO attribute. There is a need to unmap
> that memory with the appropriate unmap function, something which
> wasn't possible before adding new REQ attribute to block layer in
> previous patch.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
