Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3A4A28
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 02:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753151585; cv=none; b=t2eYjtWJYNA+lTNfuEuYL2XIOw8CsJT1IQW/iy2yUKu1Nh38VOM9Cb6EoNzCnn4VeiCVtLzg53Hh+hv8GoidsB09EexVx0Qmvmvpur3FCtgtYQugnb2Bm9nhlQ/htpe0Mosb4Wqq+02vNxNhGyw/kO6jkFQ66BxjIIs34m8olvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753151585; c=relaxed/simple;
	bh=TEe3mFQIdyGZDoil88eRKQyvmUBczLUnUFXLEbOKD8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=No6Cioqa+ZCsu2skAaySQ5ogdy+V2Ez/7qI+ReL7cX0zr3W5Hp8PR2mBnlVWNKpaUdd8JFYdG/cdlGDimWiuELBHlBi+KKRBUv2gs2c67MX2olQ+q0TPrhfgjgCadKjBtZeLNis1iemnQ/AXJYRNfynDD62VqzmOBy5yAnoGLLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZfJQw0I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZfJQw0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA92C4CEF1;
	Tue, 22 Jul 2025 02:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753151584;
	bh=TEe3mFQIdyGZDoil88eRKQyvmUBczLUnUFXLEbOKD8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZfJQw0IyPq3vwpupgh9Rkox4dqUgUzeOKGNTdrWW3PbH/+8L3HmVeohL9SosLRal
	 blhoZqpf+PLezaKbivB+p86PMpt/vDheA/fRrZdNr6xBxZU08nus9wQ7U3fhVnvswQ
	 xylXbj4SnJ97Mxlqo3aJGIzO7ne9ZG/XWuT1eDc1MeccvRPd7vf4IduS4FvgfFGXTR
	 ZNEjSWA5vHWjwL2Pe0DcNljRLECL9vGNEn+28DkiySog/9a1O2UKIkcEayZ1XECjAi
	 7GdqlwEKiLdZA3eBcsP4ZMgY+9WQ2JH/uJUkO/Qz8A2nGsXARyd8mVQBwN+CPiybOl
	 rlwTh42wxBp9w==
Date: Mon, 21 Jul 2025 20:33:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk, leonro@nvidia.com
Subject: Re: [PATCHv2 1/7] blk-mq-dma: move the bio and bvec_iter to
 blk_dma_iter
Message-ID: <aH74XluC0BnerBaQ@kbusch-mbp>
References: <20250720184040.2402790-1-kbusch@meta.com>
 <20250720184040.2402790-2-kbusch@meta.com>
 <20250721074223.GF32034@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721074223.GF32034@lst.de>

On Mon, Jul 21, 2025 at 09:42:23AM +0200, Christoph Hellwig wrote:
> On Sun, Jul 20, 2025 at 11:40:34AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The req_iterator just happens to have a similar fields to what the dma
> > iterator needs, but we're not necessarily iterating a bio_vec here. Have
> > the dma iterator define its private fields directly. It also helps to
> > remove eyesores like "iter->iter.iter".
> 
> Going back to this after looking at the later patches.  The level
> for which this iter exists is only called blk_map_* as there is
> nothing dma specific about, just mapping to physical addresses.
> 
> So maybe call it blk_map_iter instead?

But the structure yields "dma_addr_t" type values to the consumer.
Whether those are physical addresses or remapped io virtual addresses,
they're still used for direct memory access, so I think the name as-is
is a pretty good fit.
