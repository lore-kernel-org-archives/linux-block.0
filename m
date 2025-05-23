Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE7D5BAF0
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004639; cv=none; b=MeuKTXRTLReKkmEkG8NadSvkUWImI+krHujgx6hR3u3qA7v4QmMFdRamrDOjxmNxy9z2SVF6az3ekPdVfsam6gs5dGjq07d6IZ4PANRh8su40JVHIrma+3vZAka8a1VOiHPvo6zu7U3Ysh5mbYSXfqowty9GMZ7HYXpbTp+0iZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004639; c=relaxed/simple;
	bh=id1WVfAEPeO1bsGuoE1t1S8tX46lKlwzwNyNGbRSB08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbm6RCf3PQq/SjACdRkecH63fWnfEprsfjQ8BxZdXVwttLCuGDfYqu94CPQ5kyB4vTutbCA+GPZcU9XVYOUUCNbwuiYADZuWRVcld8CiqZbvlwiPzTwTGNcRwA2ryYTZCGxEQ9NNswXGCbMSY+XCaiUbv7QaZcdeS/NZTRw7nIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xY0tzInz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xY0tzInz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RDL/zlXkplPEdMo04Hba0MRZk13Bli8euVOVKemeqZE=; b=xY0tzInzrEY6NFzcc586NgYqLw
	0a/OdB7qxdR8FJSmwWyJZNaDw2tm5PenK6izYji1gPkQ5HsSqBQuB9F0aA7nbrTjAzdAbs3HdnaX5
	gxbPKl26OKoHDcvK3M55kTG/5HXKvGuiZELNw5IjbWoSo+ZlqBNYHGj8QfP1Q501LPFH3ftuVtdo7
	Vk6I07POTzVTVhCu7WVFzqDgeVa/ZUU+PVm5EO6z/75O61J0cZkUPXW6nhB1taSd0INvnkZHXxXp4
	K5ufcwgJK+f4OTXlfAprEZyR3jdeRmZXGylENiTz0FXblFWHY4UaPukLCoxtRldGOXciXSznZ+SEU
	bPRPSR5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIRrB-00000003r8Q-1qze;
	Fri, 23 May 2025 12:50:37 +0000
Date: Fri, 23 May 2025 05:50:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
Message-ID: <aDBvHWPjYQwJQx7N@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-4-kbusch@meta.com>
 <7aab2c6c-4cd8-4f23-b61b-153f6e9c2ce7@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aab2c6c-4cd8-4f23-b61b-153f6e9c2ce7@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 22, 2025 at 03:54:46PM +0200, Hannes Reinecke wrote:
> > +	if (req->cmd_flags & REQ_FUA)
> > +	        control |= NVME_RW_FUA;
> > +	if (req->cmd_flags & REQ_FAILFAST_DEV)
> > +	        control |= NVME_RW_LR;
> 
> FAILFAST_DEV? Is that even set anywhere?

That is a good question, but this is consistent with what we do for
other I/O commands.

