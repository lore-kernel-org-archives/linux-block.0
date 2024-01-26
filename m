Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EED1C288;
	Fri, 26 Jan 2024 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706278226; cv=none; b=Y3QFh6rf9uD422g2/T1k+mSy6FitWBdUn68QUcrYUtNwpZf1dBCjIL5MpimFaXZMo1kZcHtPCAm50ttb9E9caekINp6ljpSiRFWNEScsS7EXPZhb2e99C1zznnZARhCAd5c3xb7yEpMCRxBc3CivenBIJPrZXD2xDBV6Juw2Vy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706278226; c=relaxed/simple;
	bh=MykmnO9HV6IjII9R2g3Ou8LLTx2rdztZty2Z00er/vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVdF5CdFe31j38/YaeIUbdEV1TMcfV9VB2XYnF3SIumAY68FRMg1n2bLbUnvVXObYTmj+2jWGsRmEm7qwSVRoR+tvVtBslMPQ30B3iR0RhqRit1Pb5CvOFLD5wn79gt9IkCFyxFZtx8f+sijMbCUMAiDsKMOibnj15XD3y5tjKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G1E/hYub; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G1E/hYub"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aWghsPDUn/IN+W3NhZuzm6LeybYPZZSldlm2p3BseMI=; b=G1E/hYubI34g4U0L6hysb7Mlc8
	x9MrZ8NW/143uLozoqwlZv4PCaOX7GDDGKc9s9aFRB4ql4VHpqVtnHoOglJqipYcTXOl+X7T2w7s0
	gADg+YComMnZmN9hJC1ImfK+vQzUJ69TCm2JBiGHgUJBbu7nHqv4LVgOs0/8rmrhGsiDGG1mLS/h3
	fCd47R6sRQqE/tY8cUb4O75IIhE83XJQLvNDFDiP8PN1HgBbHYXKA8r/6MZHwZUD8Qx0t2mViRV4i
	2mR+Vtkglab9cXn32oHYiCRal8dedo/kAjPtKJx0EfTl18d/qdEPCKw2NERsVo9aLfbx64mnVbADg
	APb37Deg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTMuV-00000004I0D-2yhd;
	Fri, 26 Jan 2024 14:10:23 +0000
Date: Fri, 26 Jan 2024 06:10:23 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [Report] requests are submitted to hardware in reverse order
 from nvme/virtio-blk queue_rqs()
Message-ID: <ZbO9T_R4lN_7WkwQ@infradead.org>
References: <ZbD7ups50ryrlJ/G@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbD7ups50ryrlJ/G@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 24, 2024 at 07:59:54PM +0800, Ming Lei wrote:
> Hello,
> 
> Requests are added to plug list in reverse order, and both virtio-blk
> and nvme retrieves request from plug list in order, so finally requests
> are submitted to hardware in reverse order via nvme_queue_rqs() or
> virtio_queue_rqs, see:

> May this reorder be one problem for virtio-blk and nvme-pci?

It it isn't really a problem for the drivers, but de-serializing
I/O patterns tends to be not good.  I know at least a couple cases
where this would hurt:

 - SSDs with sequential write detection
 - zoned SSDs with zoned append, as this now turns a sequential
   user write pattern into one that is fairly random
 - HDDs much prefer real sequential I/O, although until nvme HDDs
   go beyong the prototype stage that's probably not hitting this
   case yet

So yes, we should fix this.

> 
> 
> Thanks,
> Ming
> 
> 
---end quoted text---
