Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975852F56
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349032; cv=none; b=iq7D96ML8viUmFURzXH4AdlO6gc5PC+7pNx9VetYd7eKgnZlgn2/9PJKRNIwZVO8sr+U1GifjrRYYb0hLhN8Rn6xNiam1I6zyM8g4Qiho7jIR2EV/91k4YXJ5VwLllkiXArxOh5L/9/PRidNQ4Q24qWKXhFDtLJkkZYUlHYL0H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349032; c=relaxed/simple;
	bh=LsRPpoO9bQWKNf3UYUVEMz6EqdSzwliLus2DT6TMjmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TF6+F2QjFZBthWCHHpqNh9lF6RAXy70EpsUcbwUNI+VgHf/EMLI8Ei53VCKVswEZ0JtY0TGc+IzvDwnF2n+pNQaHM0svO1kvXm/YxUXNPfoexcQAWKGqC2n/vCJCXekCFdkgpDASMercMpafgZ1szFdkW+NlKJwM14kkYCtYm08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB9A7227AAA; Wed,  5 Nov 2025 14:23:45 +0100 (CET)
Date: Wed, 5 Nov 2025 14:23:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: Re: make block layer auto-PI deadlock safe v3
Message-ID: <20251105132345.GA19731@lst.de>
References: <20251103101653.2083310-1-hch@lst.de> <afe10b17-245b-4b21-81ee-ff5589a7ca47@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afe10b17-245b-4b21-81ee-ff5589a7ca47@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 04, 2025 at 12:47:09PM -0700, Jens Axboe wrote:
> > Fix this by adding a mempool, and capping the maximum I/O size on PI
> > capable devices to not exceed the allocation size of the mempool.
> > 
> > This is against the block-6.18 branch as it has a contextual dependency
> > on the PI fix merged there yesterday.
> 
> Yesterday? Guessing this got copy/pasted from the v1 posting, as it must
> be this one:

Yesterday as of the first post of the series, I should have updated this,
sorry.

> 
> commit 4c8cf6bd28d6fea23819f082ddc8063fd6fa963a (tag: block-6.18-20251023)
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Wed Oct 22 10:33:31 2025 +0200
> 
>     block: require LBA dma_alignment when using PI
> 
> which is a bit longer ago.
> 
> But why? Surely this is 6.19 material?

This is 6.19 material.  That's just a heads up that you need a merge
(or rebase which I was hoping for as of the first round, but it's probably
too late now)

