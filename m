Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CAD275B0F;
	Tue,  3 Feb 2026 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142030; cv=none; b=HYY9OF5hZZ2bW4B9TaT4yyoh42HEbfGfwhSIly2cHXLrvKIY+OB/KiisYzKi7/twJK8/FX60AJDgNL767skf9FgEoCqsi1vxlMUwR4COt13PyFI5HLmk5o4ltw32BRXAr0WKxrH1tEdHnuI3Ln/Z7KR+RJJsMovNoYRHg3S/UVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142030; c=relaxed/simple;
	bh=zZNSaOg7sCN6Wojly0qzoKQIULU4ACMlUo6Dk+c6PKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f97Pu7CmNeL2yrLXmHbz1BEZqwyF7lIJSanQkLOVsRpoaATnO9TjhQ5dhG+3iv1U/0Jm28hKy9OKrNDgb6/U3+uxQ5uxs6lap0rxKhMIsIAr0fhK1i4IhqhkOkeoSbKKB15pXuRfm+hu16RgS5r+qBmSe9KZZLoJRFt8g8WCjRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jET5Dnse; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jET5Dnse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4323CC116D0;
	Tue,  3 Feb 2026 18:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770142029;
	bh=zZNSaOg7sCN6Wojly0qzoKQIULU4ACMlUo6Dk+c6PKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jET5Dnse80GSDsB+ZN5uKMph0RrRLcxUMzjhoRu1mBsHicvxPy4ivu+303bQI+Z7o
	 Djg5t0SqqsmDXsi02MFpzJhz2r3oNXQka/26pqn9RxTFXI7niFWnz5ussVjDpMHZqc
	 Z9rJz6mO+6Es3gXWgr3uak29jxK3I/ip3WdZ5BUq3a4106YvJidDsMoDhQB6PiJwuE
	 WVXq3woGFmdJyZttAu55Qsg+G1ebC2BtK89+Vre6PthwW86l3stcj+IeYnduCnKO1F
	 /caT+jF1SHzVuJhBAw43oek+IuqjC8bpKmZf1O5EGlCUQ9hag7ySEinp1teEZpNk15
	 nw+EVkQuEiXog==
Date: Tue, 3 Feb 2026 11:07:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Gohad, Tushar" <tushar.gohad@intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
Message-ID: <aYI5S1puAZ-rPvlC@kbusch-mbp>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>

On Tue, Feb 03, 2026 at 02:29:55PM +0000, Pavel Begunkov wrote:
> Good day everyone,
> 
> dma-buf is a powerful abstraction for managing buffers and DMA mappings,
> and there is growing interest in extending it to the read/write path to
> enable device-to-device transfers without bouncing data through system
> memory. I was encouraged to submit it to LSF/MM/BPF as that might be
> useful to mull over details and what capabilities and features people
> may need.
> 
> The proposal consists of two parts. The first is a small in-kernel
> framework that allows a dma-buf to be registered against a given file
> and returns an object representing a DMA mapping. The actual mapping
> creation is delegated to the target subsystem (e.g. NVMe). This
> abstraction centralises request accounting, mapping management, dynamic
> recreation, etc. The resulting mapping object is passed through the I/O
> stack via a new iov_iter type.
> 
> As for the user API, a dma-buf is installed as an io_uring registered
> buffer for a specific file. Once registered, the buffer can be used by
> read / write io_uring requests as normal. io_uring will enforce that the
> buffer is only used with "compatible files", which is for now restricted
> to the target registration file, but will be expanded in the future.
> Notably, io_uring is a consumer of the framework rather than a
> dependency, and the infrastructure can be reused.
> 
> It took a couple of iterations on the list to get it to the current
> design, v2 of the series can be looked up at [1], which implements the
> infrastructure and initial wiring for NVMe. It slightly diverges from
> the description above, as some of the framework bits are block specific,
> and I'll be working on refining that and simplifying some of the
> interfaces for v3. A good chunk of block handling is based on prior work
> from Keith that was pre DMA mapping buffers [2].
> 
> Tushar was helping and mention he got good numbers for P2P transfers
> compared to bouncing it via RAM. Anuj, Kanchan and Nitesh also
> previously reported encouraging results for system memory backed
> dma-buf for optimising IOMMU overhead, quoting Anuj:
> 
> - STRICT: before = 570 KIOPS, after = 5.01 MIOPS
> - LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
> - PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

Thanks for submitting the topic. The performance wins look great, but
I'm a little surpised passthrough didn't show any difference. We're
still skipping a bit of transformations with the dmabuf compared to not
having it, so maybe it's just a matter of crafting the right benchmark
to show the benefit.

Anyway, I look forward to the next version of this feature. I promise to
have more cycles to review and test the v3.
