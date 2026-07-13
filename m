Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFAA2E8E09
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958099; cv=none; b=TBo7erI4/1ZbcYAVEZqQAt3AtmQQkHoa4nHGIX2cvJq6gRUWs8VQfxO4mnaPA/1JVP9ZEbEgW23iB9RXs7sjjyUuHd6IaMwsRRwfd+XhF08YNr6uhSn+pkY21H8wSjU52p9BKXQUy59TyVeCWc8b2cgt6lqTcVofNOVTs/nn56s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958099; c=relaxed/simple;
	bh=eZaLAgpVTriyrYy6UrgfO1sc4Soy7uN2W7pPEPfZeB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8iBWJkTAMDIPc9mJLF/ygh32wH312YHVuDv4U1TNoMrMbQANBQiL0Rc0pcRoTUCRleuAtOZxjrFn1PfZnV8NNgef9Eca2Szw7JCPbFENpcfsjHTeezdRYyg45oaJlUQbhK7JPsq+I/AIJxpyInAquBmNUiEDi5QHZ6QzlQ/MSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 59CAB68C4E; Mon, 13 Jul 2026 17:54:53 +0200 (CEST)
Date: Mon, 13 Jul 2026 17:54:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, z1281552865@gmail.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix aligning of bounced dio read bios
Message-ID: <20260713155452.GA4005@lst.de>
References: <20260713152912.2333321-1-hch@lst.de> <alUGlVDWkZNyUE4N@kbusch-mbp> <alUH3a7hP1tytq4a@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alUH3a7hP1tytq4a@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 13, 2026 at 09:44:29AM -0600, Keith Busch wrote:
> On Mon, Jul 13, 2026 at 09:39:01AM -0600, Keith Busch wrote:
> > On Mon, Jul 13, 2026 at 05:29:11PM +0200, Christoph Hellwig wrote:
> > > bio_iov_iter_align_down expects the "normal" biovec layout from vector 0,
> > > while bio_iov_iter_bounce_read abuses vector 0 for a bounce buffer
> > > allocation.  Pass an explicit bvec to bio_iov_iter_align_down to deal
> > > with this case to avoid a double unpin.
> > 
> > Can you instead just have bio_iov_iter_bounce_read() align down the size
> > it extracts rather than letting it over-extract and reverting the excess?
> 
> Oh sorry, nevermind. We can do partial extractions, so we don't
> necessarily know where we're going to end, so have to align after
> constructing the bio vec.

Yeah.  Although we could try to do this in the iov_iter_extract_bvecs
similar to your recent fix.  Which is proobably the better idea
here.  Let me give that version a spin.

