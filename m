Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D3622F11
	for <linux-block@vger.kernel.org>; Sun,  5 Jan 2025 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736038788; cv=none; b=gpcb3erILWV1+K0y4XX9y7HRtgySjczEJgxrVUqqnZQwmGeKN7glxYo2vBr5cvdRBXlJ55AgYB0FIKaJI2+BlACrVDSBGsdmclxpHUzWVFYaKIJuMfQzqtBRCDYwVT9CRsdRnQ/PoqIFbUxixNjcPue/6QZ3AJovjlRmF03HhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736038788; c=relaxed/simple;
	bh=z0kIylCu2GjlwT3qu7R5tmVWdSooWkIR8RS9q4usGBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSELuNHeMcoTWkYBG9YJanvLe1xq8qNEKrmivyDcLlEUleYhMOWxycOuDOib4BdThZOjqQzash95Bn7Uh3FCP2n6PkbvqEB9gf9XHRnmNveiG8kO8+1Rs2SJxEV6Y5kKW9dyB+OMTN1mK9LsAkY8pGLFGb97IXc9phV+Zyp3mM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKpBkc9f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKpBkc9f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886D6C4CED1;
	Sun,  5 Jan 2025 00:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736038788;
	bh=z0kIylCu2GjlwT3qu7R5tmVWdSooWkIR8RS9q4usGBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKpBkc9fh2mgJGWEeMzdfBqFT/6yZxfvP4GSls2IhhzCBzGq1RgPFjHGB64tfAVZ5
	 4HZ9F90+bvcAUD9z7QYKE20aT/W8JgWOLSvH4pgaIRkWeYJt/L8N3QBomY6jigcCvF
	 D19Y7s51gsd2vJ9k3tx/VTyblNJCHfhS3Qac0TmhXuKxh471jkKl+D9WVf0XWh4cQs
	 xQXgybEZtHde0HDkp6IrESXob4rXfDn1pJfM9M3G5Ohq+IWldrx1zsoIWeMHN9afs5
	 avD19A1pSnrN9T9Bai5L9R5BVR7qsObI+zGeoxe2g6hl3Q5B8hA+IvKnaVCnqoEZtV
	 5pFOp42KsTRtw==
Date: Sat, 4 Jan 2025 16:59:39 -0800
From: Keith Busch <kbusch@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: make queue limits workable in case of 64K
 PAGE_SIZE
Message-ID: <Z3nZe3nRS5KyaLzr@kbusch-mbp>
References: <20250102015620.500754-1-ming.lei@redhat.com>
 <0b423229-f928-4210-9351-dca353071231@acm.org>
 <Z3X-xMeMuF8j0RDA@fedora>
 <0b34bfc9-2cd3-40a8-8153-3207a6d62f8c@acm.org>
 <Z3dFBQIiik6FWLut@fedora>
 <1b1bf316-359a-4bec-8195-0152cd706001@acm.org>
 <Z3iTFSBxKY4Z8xZg@bombadil.infradead.org>
 <386a5388-1b1b-4e5a-ad9c-0da1840f12ee@acm.org>
 <Z3izUEIPTdvRg5Xe@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3izUEIPTdvRg5Xe@bombadil.infradead.org>

On Fri, Jan 03, 2025 at 08:04:32PM -0800, Luis Chamberlain wrote:
> On Fri, Jan 03, 2025 at 06:15:55PM -0800, Bart Van Assche wrote:
> > On 1/3/25 5:47 PM, Luis Chamberlain wrote:
> > > While that addresses a smaller segment then page size this still leaves
> > > open the question of if a dma segment can be larger than page size,
> > Hmm ... aren't max_segment_size values that are larger than the page
> > size supported since day one of the Linux kernel? Or are you perhaps
> > referring to Ming's multi-page bvec patch series that was merged about
> > six years ago?
> 
> Try aiming high for a single 2 MiB for a single IO on x86_64 on NVMe, that is
> currently not possible. At the max 128 NVMe number of DMA segments, and we have
> 4 KiB per DMA segment, for a 512 KiB IO limit. Should multi-page bvec
> enable to lift this?

You need huge pages to guarantee you can reach those transfer sizes in a
single command. Otherwise you need to get lucky with larger contiguous
folios, which can certainly happen but it's just not as desterministic.

There are many nvme devices that absoulutely require 4KiB as the largest
segment, but the driver says it can handle much larger segments anyway.
It's trivial for the driver to split a large bio vec into a bunch of
smaller device specific descriptors.
