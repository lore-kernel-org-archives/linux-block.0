Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54541279DBA;
	Tue, 19 Aug 2025 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755627886; cv=none; b=IjvNP353tplCAuYh0OB9YjmUaeDv5vgwVEvVkUXxUTgQV1RTa1rJcT0s7kW/XIbkvgYoJoaeVKr7ZgmLDhXpnQAuxdxkbva2u5PEnaO9SaXCsx8vAFdl4r2C1yXecKCiR333XjW/2qAY/oYnjnwgWLLwG3sJkGDkbgkLWc6OoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755627886; c=relaxed/simple;
	bh=SvC+jn4R/dc0Ind2g0hlwOADBQmeZeKp/GI1XBT+Aws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4f/veaFQdw1h1kuVbbLrVacBL7ipqA0kmOcpuNVJ13WtW0AgC9U0Z87K0GDttnxfLHVlyUATaEgWX08FqJhhMECD6r57UZuWfRC/ketnexwgKRVyd+JIO29ijBlq8/8nERpft3THera+FKDBRoiCo3ErNptl/bSV6HvLYLgw0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwzZComd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwzZComd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53727C4CEF1;
	Tue, 19 Aug 2025 18:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755627885;
	bh=SvC+jn4R/dc0Ind2g0hlwOADBQmeZeKp/GI1XBT+Aws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwzZComdy/Uu53OXhh/BwwXin3VgP9XbYbPukl1+6UUrrmT0/QUgfHPWbl0yeg2IQ
	 anqpbJ7fssVt9ylAxZXZBFI6XmgBFt76Sf9R+5d1q0uCECHn7z6AVgdwiNFmtPzUpZ
	 oIJpPvDGleeIPwFshu0MK91r/Q4vlnE3hv5K/BQn4hYDk2V66e58pXhNfNYLb9ftUC
	 FsprkYGd3dpPDZ4hTpasdYuKUOBt3HQa7ezc4te6CtdhPT3gjHwY76TvaUfRVubpfk
	 /uH6qQQOd5J1UhIfM2bjnt3K6ADP7bZZTesuRvLRHriJ0TMIrB1SG3izjobM9UNSdA
	 OKRS+aPZzKk+g==
Date: Tue, 19 Aug 2025 12:24:42 -0600
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
Message-ID: <aKTBariwz1_XsRv0@kbusch-mbp>
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
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Make sure that CPU is not synced and IOMMU is configured to take
> MMIO path by providing newly introduced DMA_ATTR_MMIO attribute.

We may have a minor patch conflict here with my unmerged dma metadata
series, but not a big deal.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
