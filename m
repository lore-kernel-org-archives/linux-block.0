Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B21DFF5
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081919; cv=none; b=pg8+5G52hwPXvqbPxf5nSsX1abgl0/refHOgRnPCLT5oWVPPoVL2SMhMUMFQGqKYQVLxwCHKnRRpgMyQfa0MwSVNwUngy9LX7sCtvsX3/qWS/+cnmYXzxnybqSCbc259culOgp4Z6PTD2cDQnjcOSrBup2l2KAmImhrIYCsCtCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081919; c=relaxed/simple;
	bh=A9AtV4/+Ki5hZ5/zhF1WS4Wzz59nXv1Naoc81sghaNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gm+rYx0eF430z1BDK6773fqYsysFmFzvKnV2pkxq+katxkWtQrnwQgl9RBZYDZJC5HSsv7uBxOfPuzkT0/ohm0zm+uz0CkmYRCwpMYLq9ZHkZnb3S+PTzYd6JZLdhgPqgCFDn0oEbsf6RE1JP+cCLr9j+nCtMG1T4PQ2dFpniUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 68C76227AAF; Wed, 16 Oct 2024 14:31:53 +0200 (CEST)
Date: Wed, 16 Oct 2024 14:31:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [Regression] b1a000d3b8ec ("block: relax direct io memory
 alignment")
Message-ID: <20241016123153.GA18219@lst.de>
References: <Zw6a7SlNGMlsHJ19@fedora> <20241016080419.GA30713@lst.de> <Zw958YtMExrNhUxy@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw958YtMExrNhUxy@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 16, 2024 at 04:31:45PM +0800, Ming Lei wrote:
> On Wed, Oct 16, 2024 at 10:04:19AM +0200, Christoph Hellwig wrote:
> > On Wed, Oct 16, 2024 at 12:40:13AM +0800, Ming Lei wrote:
> > > Hello Guys,
> > > 
> > > Turns out host controller's DMA alignment is often too relax, so two DMA
> > > buffers may cross same cache line easily, and trigger the warning of
> > > "cacheline tracking EEXIST, overlapping mappings aren't supported".
> > > 
> > > The attached test code can trigger the warning immediately with CONFIG_DMA_API_DEBUG
> > > enabled when reading from one scsi disk which queue DMA alignment is 3.
> > > 
> > 
> > We should not allow smaller than cache line alignment on architectures
> > that are not cache coherent indeed.
> 
> Yes, something like the following change:

We only really need this if the architecture support cache incoherent
DMA.  Maybe even as a runtime setting.

