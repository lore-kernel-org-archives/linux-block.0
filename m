Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A525783C;
	Mon, 13 Oct 2025 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384130; cv=none; b=bmrlplE10kjbmwOY6V9epeNjoMGelS6UAiL44DEnm5tF6dphuHBMmPFXilHg2JDdaK/FSMsG4//AZYlS7hoZgdoA2iVHjukPHRwksUWEwCkP8Az3QFTeb9LFjM5rYBjqkVz4ogCXffrkBJSGeptFIMfFXIRJKg4Gsc4APXVSzVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384130; c=relaxed/simple;
	bh=PDb/9QSmnfc9gdH61UyK4f+MBTlIYS2e0YlFH2q7c3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRk/JCoJxiRx7CJTNY22Ey5yo91JUeCFBGACXhZ5ZSxZXrfQkljgNLj0saIXe3tfysoU19pB64eQis9r7ntUbF8qsbFfnFBYyPPip8kyEZuQ5KmIU/mpn6iaJryGeH1p/E33PixR21Irvbn/L9o0POfLofnAIe/vlnIuG3ww4NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W597waVY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W597waVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA01C4CEE7;
	Mon, 13 Oct 2025 19:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760384129;
	bh=PDb/9QSmnfc9gdH61UyK4f+MBTlIYS2e0YlFH2q7c3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W597waVYS8NqjFkFpcAEzQ0yXJsQua2oaQbGXwesKEmyI86rGnOWEgSzgL9FBiMwM
	 2xNG220+PBCwFfynAwT0hOrXJvH4QGnvg5O/sdxTN7AfeTarzLAuG0Py6P3hMN/gvA
	 I6RWa65wJ9S4uKS3qF/oWVqKEvG5vu5ZlJ2UC6gveM7j+KwamUjZRnx8XJ7ZgsBWVG
	 MFj+vcEpe+99RcsTQBAYIQHuyV36KYDlt5xJSqfYlstzoWaqb8qxZP+uWRSY9mLCbb
	 impCsRC9ARPclTlVCOeA9R5qwI3adi+sECArMrt/MgCtmK6IOZyQ9LrcLrLlNWMFAk
	 cpQITFN+5yjzw==
Date: Mon, 13 Oct 2025 22:35:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/4] blk-mq-dma: unify DMA unmap routine
Message-ID: <20251013193525.GD14552@unreal>
References: <cover.1760369219.git.leon@kernel.org>
 <04baf1fdff8a04197d5f64c2653c29e7482a2840.1760369219.git.leon@kernel.org>
 <aO1Ku5DCIMVRirdu@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO1Ku5DCIMVRirdu@kbusch-mbp>

On Mon, Oct 13, 2025 at 12:53:47PM -0600, Keith Busch wrote:
> On Mon, Oct 13, 2025 at 06:34:10PM +0300, Leon Romanovsky wrote:
> > +bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
> > +		struct dma_iova_state *state, size_t mapped_len)
> > +{
> > +	struct bio_integrity_payload *bip = bio_integrity(req->bio);
> > +
> > +	if ((!bip && req->cmd_flags & REQ_P2PDMA) ||
> > +	    bio_integrity_flagged(req->bio, BIP_P2P_DMA))
> > +		return true;
> 
> I don't think you can unify it at this part here because the data
> payload might not be P2P but the integrity payload could be. The data
> payload needs to proceed to the next unmapping step in that case, but
> this change would have it return true early.

I was under wrong impression that request has or data payload or
integrity, but never both :(.

Thanks
