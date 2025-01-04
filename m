Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A72EC5
	for <linux-block@vger.kernel.org>; Sat,  4 Jan 2025 01:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735955223; cv=none; b=fnIZnBGuh0+jVXIDqSyLyC6BlKa081Di9QAnFT41wuN51VzynP4JOLjWoL9vdp5AJ4me9UprMQWjD/J4CFVQAM1/Mn4upeRN8fiEVSpTsF5eKFFgjWJOmnBCphnnozTYaBaSwLCmnbWilcaNwb3i4YSpeSd7MywflzopDn8D67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735955223; c=relaxed/simple;
	bh=iS3GsS+Bvag0lDhoiuduXF1ScdC0uYQGuTdJJzhAMPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldF1800HjTsSg47tnvs4rg9vG0Sjt2D9LAcj1CAhmJCbpk1TvVvF0pKMcQ7ySCvZ0Zih3V5IPWEwxZ/pAGc3PH9Ub5kJWGqoFGwekZa9M+5XF2B9czp+OQsskNDxfHMKXWFipsJMDJI6oVBPzcXNgAu2LEGYdCGr40mP6zQZyzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldwf7niU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldwf7niU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04254C4CED6;
	Sat,  4 Jan 2025 01:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735955223;
	bh=iS3GsS+Bvag0lDhoiuduXF1ScdC0uYQGuTdJJzhAMPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ldwf7niU/ZgZaJB6+GY0R/UTfx204sTZiGOsSN7RWrzjeZpDUmHlFSIed4PbY4pvp
	 XfsqY4E8XAGHPsSKEFxDtBlrZNDn/m/QuNlsY4wOyADSXfWG3k4ak2zfLS+i3La5ar
	 stkwsRQBdi8sAqDukoSyHE6QfXI0kAfjZgGkLMtrN/URkb3r66xZV1DP0Wt8fGciru
	 TOB4t/21dtIGgp48l83hQOhkdYW/p6o62h7TiMOgVmeIFygwZCfpyKeXjPJ+3ALlCa
	 1c1a2QvUnaWbpF7SRLExpbdAbTp5br3XqFiJFLBINBI8Zs+qqi20yp6CbQ5J4wM14F
	 22v1myzqZxlzA==
Date: Fri, 3 Jan 2025 17:47:01 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: make queue limits workable in case of 64K
 PAGE_SIZE
Message-ID: <Z3iTFSBxKY4Z8xZg@bombadil.infradead.org>
References: <20250102015620.500754-1-ming.lei@redhat.com>
 <0b423229-f928-4210-9351-dca353071231@acm.org>
 <Z3X-xMeMuF8j0RDA@fedora>
 <0b34bfc9-2cd3-40a8-8153-3207a6d62f8c@acm.org>
 <Z3dFBQIiik6FWLut@fedora>
 <1b1bf316-359a-4bec-8195-0152cd706001@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b1bf316-359a-4bec-8195-0152cd706001@acm.org>

On Fri, Jan 03, 2025 at 02:12:36PM -0800, Bart Van Assche wrote:
> On 1/2/25 6:01 PM, Ming Lei wrote:
> > But why does DMA segment size have to be >= PAGE_SIZE(4KB, 64KB)?
> 
> From the description of patch 5/8 of my patch series: "If the segment
> size is smaller than the page size there may be multiple segments per
> bvec even if a bvec only contains a single page." The current block
> layer implementation is based on the assumption that a single page
> fits in a single DMA segment. Please take a look at patch 5/8 of my
> patch series.

While that addresses a smaller segment then page size this still leaves
open the question of if a dma segment can be larger than page size,
given our adoption of folios I don't see why we would constrain
ourselves to a page size. I already have PoC code which enables this.

  Luis
