Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93DF32E6B1
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901628; cv=none; b=eo9BGwT6A+c/hG6oNPot+UxOLeLZrRSV2PZ7U4cJTsOvGU7Gl7iTpzwRO5/JidhbjtetKhlXUIDR5bZ0SK+NFGiW7++hC1d9ils18SXfzUbTHGErlJjJlAb7h99XhdVwj+7Bu4OqMGM7Nw27C9vuEz3J0eNd6KF82APPJS8dF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901628; c=relaxed/simple;
	bh=+tl9q/wmm17P2IPCDEOcWkfc8efoNdzhYd+Xfo+WG7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svSg7jmmalhC4VZlRLf/X06NKe6YFXmx/b/wwVDDOaTcxKFgmWpq6al0UbsyjfOUZDovIOS/3DvnZh4LqYWuVxlxC3kSGmZ5qGzM/Y568hTMhqZ3wCWJh+ELuXGItIfgErRh7TcWLLkJ7VBkYChxK4c8XLgKjNvhFOJdPyr/q3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A61E227A88; Fri, 31 Oct 2025 10:07:02 +0100 (CET)
Date: Fri, 31 Oct 2025 10:07:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hans Holmberg <hans.holmberg@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v2] null_blk: set dma alignment to logical block size
Message-ID: <20251031090702.GA9335@lst.de>
References: <20251031090209.131536-1-hans.holmberg@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031090209.131536-1-hans.holmberg@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 31, 2025 at 10:02:09AM +0100, Hans Holmberg wrote:
> This driver assumes that bio vectors are memory aligned to the logical
> block size, so set the queue limit to reflect that.
> 
> Unless we set up the limit based on the logical block size, we will go
> out of page bounds in copy_to_nullb / copy_from_nullb.

Please also add something like:

Apparently this wasn't noticed so far because none of the tests generate
such buffers, but since 851c4c96db00 ("xfs: implement XFS_IOC_DIOINFO in
terms of vfs_getattr"), xfstests generates unaligned I/O, which now lead
to memory corruption when using null_blk.

> Fixes: bf8d08532bc1 ("iomap: add support for dma aligned direct-io")
> Fixes: b1a000d3b8ec ("block: relax direct io memory alignment")
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> ---
> 
> Changes in v2:
> * Added fixes tags from Christoph
> * Added reviewed-bys from Keith and Christoph

I don't actually see the Reviewed-by tags above..

