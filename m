Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBA13FD4
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686224; cv=none; b=C9YoXDnxDtag5X2ECbGW0rZzzLDGpDl+UOw99ysBqR24R6sE7BKiPG4qts10vytGEuQFHj23t+RqL6n3Zxgu6SO8v9lWY9KJrkOud18WDYuec44ZFQw7MTDlixlaldSQekuH81y+jQTs0kMUeQtT9fkgCjozGcrKs0rwZucpj+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686224; c=relaxed/simple;
	bh=LhxOY1Kq1cIFUejyvGSobU7EZjsHErVXF3cLCmgyOWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eio8e504HfuCMcA5KX/PL2s3IUDlYQTmNHzhRX1FXQthvQ7nqSzsMQ7XxphRwu9vJ8L6IqpWc7VUEEdL57inJWP+PbQo3nzkXBwG9My4QbFNEZVRQEfbdHRyocwNN6oBz4ZTe8AyibZ4/bwlBRD8NvJGmiOqDqQEpEUzC/zHOLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 27D1E227A88; Wed, 23 Oct 2024 14:23:40 +0200 (CEST)
Date: Wed, 23 Oct 2024 14:23:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [Regression] b1a000d3b8ec ("block: relax direct io memory
 alignment")
Message-ID: <20241023122338.GD28777@lst.de>
References: <Zw6a7SlNGMlsHJ19@fedora> <20241016080419.GA30713@lst.de> <Zw958YtMExrNhUxy@fedora> <Zxd9XyqqA604F1Rn@arm.com> <20241023061233.GA2612@lst.de> <ZxiwaupwAkf1u8VE@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxiwaupwAkf1u8VE@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 23, 2024 at 04:14:34PM +0800, Ming Lei wrote:
> On Wed, Oct 23, 2024 at 08:12:33AM +0200, Christoph Hellwig wrote:
> > On Tue, Oct 22, 2024 at 11:24:31AM +0100, Catalin Marinas wrote:
> > > > > We should not allow smaller than cache line alignment on architectures
> > > > > that are not cache coherent indeed.
> > > 
> > > Even on architectures that are not fully coherent, the coherency is a
> > > property of the device. You may need to somehow pass this information in
> > > struct queue_limits if you want it to be optimal.
> > 
> > Well, devices set the queue limits.  So this would be a fix in the
> > drivers that set the queue limits.  SCSI already does this in the
> > midlayer code,
> 
> I guess it isn't true:
> 
> [linux]# cat /sys/block/sda/queue/dma_alignment

Is that a SCSI HBA that is on a not DMA coherent bus?  If not that
is expected.

