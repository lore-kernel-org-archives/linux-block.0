Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C3C2D97BE
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869496; cv=none; b=XQ6V1nWVGMTuhppZNhhnJNoO0QAXf6aijLRDhicOyhoCSIyhTqD9OmwDphbddkPAyfiwVSkiARPDNDSO5pu58WDi5+UkSk6EJlPQaeqpeZMUfZ6ls2iHSY42kHCYWl0quyT+mmqo2AAvDnNhKNMhrSOdFrf0fCRHyHL5+M7pG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869496; c=relaxed/simple;
	bh=NeYGnUoe2HIpXfsW79DVH3maFdgfAxvr5lMn/ecyVBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8x73CKDhJP+q/Mmw0DUV0OjqRmIUHgyuB+xM/RNtQAuUE5U7373o/0eoHJqCN0liH1yybY9XAUw+3XSWCnEqi2/uZRcgegAOQFyFFz/IDNYhnOdGpoeGrdJp4ROd8hrTJrTqMK7d4mbasJ6InVAXqVuCTiJp95zGpTRcDyzv3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 196DE227AAA; Tue, 11 Nov 2025 14:58:10 +0100 (CET)
Date: Tue, 11 Nov 2025 14:58:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai@fnnas.com>,
	Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <20251111135809.GA2096@lst.de>
References: <20251014150456.2219261-2-kbusch@meta.com> <aRK67ahJn15u5OGC@casper.infradead.org> <aRLAqyRBY6k4pT2M@kbusch-mbp> <20251111071439.GA4240@lst.de> <024631dc-3c65-49a8-a97a-f9110fd00e9a@fnnas.com> <20251111093903.GB14438@lst.de> <c82cd0f1-f56e-445b-8d78-f55a0c3b2b4c@fnnas.com> <aRM5UoApKZ9_V7PV@kbusch-mbp> <20251111134001.GA708@lst.de> <aRNALUnnxzIuyHng@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRNALUnnxzIuyHng@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 11, 2025 at 08:54:53AM -0500, Keith Busch wrote:
> On Tue, Nov 11, 2025 at 02:40:01PM +0100, Christoph Hellwig wrote:
> > On Tue, Nov 11, 2025 at 08:25:38AM -0500, Keith Busch wrote:
> > > Ah, so we're merging a discard for a device that doesn't support
> > > vectored discard. I think we still want to be able to front/back merge
> > > such requests, though.
> > 
> > Yes, but purely based on bi_sector/bi_size, not based on the payload.
> 
> This should do it:

Yes, that looks sensible.
