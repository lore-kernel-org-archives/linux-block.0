Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB92248124E;
	Tue, 14 Jul 2026 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040636; cv=none; b=BGDrsJroS+VCyrG0s48qAEIh2+/c4V2Bu4cLcfov9ACpaP6UQNtyjN4zpqkBSSeH/WazfXsUyyjTXq6LzqDV+FAP1LKntZqr4mTMuBn/3AMFfBxd4oecRkFpkKCMKuST0YbyciYLYBV8F0xUixMxO197W5rN0Z2uSRPGx6zSW0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040636; c=relaxed/simple;
	bh=T2j91lOrK9CY69PXWFuPcTGfOCvPQblVplT9tZEmQqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8VQYjAwQP/KB0SEEFJtbk5ckcluArbW/hQh8/pN4472CUDiSAnOLc/s0OMn4ksT2CAk7XMir6OXSc3wzXAMvwcdI4TtK7FGTPlk8oT0Fl+pe4bspFNBVkhirvnn5tMKEBD3weGaY1p8/uG0Gq70PUplz5qkJs4ORyAclUcQV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8639368B05; Tue, 14 Jul 2026 16:50:26 +0200 (CEST)
Date: Tue, 14 Jul 2026 16:50:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, Qu Wenruo <wqu@suse.com>,
	Neptune <z1281552865@gmail.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] block,iov_iter: move bio_iov_iter_align_down into
 iov_iter_extract_bvecs
Message-ID: <20260714145026.GA2213@lst.de>
References: <20260714131318.2670042-1-hch@lst.de> <20260714131318.2670042-4-hch@lst.de> <alZHF1wZY58JSU7N@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alZHF1wZY58JSU7N@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 14, 2026 at 08:26:31AM -0600, Keith Busch wrote:
> > -	return size - left;
> > +
> > +	return bvec_iter_align_down(iter, bv, size, nr_vecs, len_align_mask);
> 
> I don't think we can do this alignment inline with building the bio_vec.
> The len_align_mask is usually the logical block size. We can submit
> sub-sector sized vectors so aligning down after extracting such a vector
> will result in a zero size for that iteration.

Yeah, we need to support that.  Kinda interesting that xfstests did
not hit it, though.  So back to the previous version.
