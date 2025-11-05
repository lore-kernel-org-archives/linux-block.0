Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2261991D2
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372019; cv=none; b=LLCWPiiwSyf6S7X8ghSjCthtT7RVW3c9+PfuB0fnqDSNMgNpcPgq9s2S49dHP3yq5l4mebbSNgDJACA5KMVo2E9IHimbnl1n541yuGsmvRffSDoYIb6ZksSNx/fMQc04s6aEqEhPQ3MxPy8xAQ1XSg6X96sz/DxyrY9DIfP8Rvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372019; c=relaxed/simple;
	bh=sTSWP1A/bl2LhDkSN4ieWjlvWKsWFIhQh+oUvXMQtKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxglpG70H+o0ix7nFZ6DwHWDiPSyBKfFtO+E+NsJP2N8qh0YetiVRcUuItTfG+2CdJ3VvcozHNfZi3bT6K/Wr+pzZwQQ4O/XNFGTzV/rUoLWXr2IjK7LPCjV9389N3FDrH6hFzaqyJscFcdAMfmktdvF/zQt5DVLJF7Lyu/tET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 05BFF227A87; Wed,  5 Nov 2025 20:46:53 +0100 (CET)
Date: Wed, 5 Nov 2025 20:46:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: Re: make block layer auto-PI deadlock safe v3
Message-ID: <20251105194652.GB5780@lst.de>
References: <20251103101653.2083310-1-hch@lst.de> <afe10b17-245b-4b21-81ee-ff5589a7ca47@kernel.dk> <20251105132345.GA19731@lst.de> <a18092a0-da9c-430b-80a4-5951501f94ef@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a18092a0-da9c-430b-80a4-5951501f94ef@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 05, 2025 at 08:03:57AM -0700, Jens Axboe wrote:
> > This is 6.19 material.  That's just a heads up that you need a merge
> > (or rebase which I was hoping for as of the first round, but it's probably
> > too late now)
> 
> But why not generate it against the 6.19 tree then? As-is, I have to
> first resolve the conflict in that tree, then resolve it again when
> merging to for-next. Not a huge issue, just don't quite follow the logic
> behind generating it against block-6.18.

Mostly because I though you'd rebase when I did the first version and
then didn't really think about the base more after that.

Btw, we'll need the merge anyway for Keith's unaligned PI patch if we
end up adding that for 6.19.
