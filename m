Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECE33A8723;
	Mon,  7 Sep 2026 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765146; cv=none; b=cfVhDlNKCd0mW7gQiwALNegD30WIGsIx4gSxmtldjgUptqmyiAMunbi7Nbg7UVrDPybOMsEaUMuqa3+UK+LxfTJdQ3bYKdgscrPo1lfkvJBFWKjQZSlL9nswD28kluEYdD9+KWdCe+pBAmFV1MzgGjMbZCrEXkg+mCv375F2LPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765146; c=relaxed/simple;
	bh=mgaGlpyJLkXCfjU8aW70/YpNiry1bMdDSD9ilv20MpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRrXx+QlqJM1Qvr5952B6jNQpYcX9VLPAEeiRvboeZ1dJWQ8XcW4PwBtsVU5Qf2b0W9oLCl02eSNC1e+txINOX/O6NdHuIolgSe8WOy7M749BwoVfJJlvwdEMBnHf3nNujCMKh3XZGoSgpJ+WDjU+lXOo6mdt9evnzyWa8vurRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 39FFE68BFE; Mon,  7 Sep 2026 09:12:18 +0200 (CEST)
Date: Mon, 7 Sep 2026 09:12:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 5/7] block: fail atomic writes instead of falling
 back to buffered I/O
Message-ID: <20260907071217.GD934@lst.de>
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu> <20260828-blkdev-fixes-v2-5-32f3f40cebed@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-blkdev-fixes-v2-5-32f3f40cebed@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 28, 2026 at 09:49:54AM -0400, Tal Zussman wrote:
> An IOCB_ATOMIC direct write to a block device can silently lose its
> torn-write guarantee in two ways:
> 
>   1. blkdev_direct_write() turns an -EBUSY from page cache invalidation
>      into a 0 return, so the whole write is retried through
>      blkdev_buffered_write(), with no atomicity guarantee.
> 
>   2. On a partial page pin, __blkdev_direct_IO_simple() and
>      __blkdev_direct_IO_async() submit what was pinned with REQ_ATOMIC
>      set and leave the rest to the buffered fallback.
> 
> The second case can be triggered deterministically. A 16K
> pwritev2(RWF_ATOMIC) whose last page is PROT_NONE, on a scsi_debug
> device with atomic_wr=1, completes short with only three of the four
> pages written, violating RWF_ATOMIC semantics.
> 
> Fail the I/O instead. Return -EAGAIN when page cache invalidation fails
> for IOCB_ATOMIC rather than retrying through the page cache, matching
> __iomap_dio_rw(), which treats the failure as transient and lets the
> caller retry. Release a short atomic pin and return -EFAULT before
> submission, which is what a direct write already returns when none of
> the buffer can be pinned. A sync atomic write can then never return
> short with a remainder, so the buffered fallback is never reached.
> 
> ext4 has the same fallback and only warns in it. For block devices both
> ways in can be detected before any I/O is submitted, so fail early instead.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

The fallback in ext4 looks dangerous, it might be worth bringing
that to the maintainers attention.

