Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF77125D9
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670566; cv=none; b=Ix0bqZ4Fg0Fx6OQTi2+jJi3UnJPBYUjy3P/+dX54LbtQw1rUQeTyWvGQ4oXaXVU5QW6dxg8u5m1VqFyBNnnDc7Rq/+VPkUJ2ixKNLgKuR9BSKvDuBPIjK1VE9I3pvvngHFfoz//b8u28NGty2fqwMjTlEe79hWMkU79qj/1/xuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670566; c=relaxed/simple;
	bh=YwJbyEz6iXLfIh8dN4xFIS/fAFOxpQg0Kw14pjJgnXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qseYRH+tTL3Hf1LeJ1X0sORyYf13cpUk8Tii9zFp3+FOXeIEet9soUT/bOSC9loe8zEMsIiX3rJqalwFLsEvQbbexMuDnouP/KuVio5EBeb6pn20nT5XqcLQMTLQ6Fw7+awd1ZxIsDMOkOauqUVzqym6P9AtTcSGoM2giP9B97U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eWSlvJah; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eWSlvJah"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a091k/Rf/XXxpaFCmqQvEsiJ03ZzeqHLG2Izn6+gBjA=; b=eWSlvJah0P5QNgoj5pcSkri2ab
	mDIpOKaWTSpJW+t4W6RJE90+ld2GBuvnA8Z7hv/rJ2GiWUEbkPG1xhVj9IHKVrdAKCJnycnJzfT6X
	fHuWFINmLx/WHgbu7QrwPbCqbifpWJkgaQ4LxvSvetdcH1eFtAF9YRpFCBsyrvCAuLpxkzPnmz81+
	UUl9xvJlTDgkYStvSUbHM68iMs9cMORtDpl0lIyGOQJz6hW2g0PBRMvKYi/MmKeonVGX2KCPxHK0l
	h6I3I+3jV8z7ibAA/fWcA3opWaT8ehvM7qHX4oFOHx/wQ6rascLFJXHVpEzpbyr779GNy5HvKosyf
	msttf3BQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdPGe-00000008D48-1FzS;
	Fri, 23 Feb 2024 06:42:44 +0000
Date: Thu, 22 Feb 2024 22:42:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.org, ming.lei@redhat.com,
	nilay@linux.ibm.com, chaitanyak@nvidia.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 2/4] block: __blkdev_issue_write_zeroes cleanup
Message-ID: <Zdg-ZGQDj3GolTJI@infradead.org>
References: <20240222191922.2130580-1-kbusch@meta.com>
 <20240222191922.2130580-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222191922.2130580-3-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 22, 2024 at 11:19:20AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Use min to calculate the next number of sectors like everyone else.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-lib.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 91770da2239f2..d4c476cf3784a 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -132,19 +132,16 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
>  		return -EOPNOTSUPP;
>  
>  	while (nr_sects) {
> +		unsigned int len = min_t(sector_t, nr_sects, max_write_zeroes_sectors);

Please avoid the overly long line.

> +		bio->bi_iter.bi_size = len << 9;

And if you touch this anyway use SECTOR_SHIFT here.

Otherwise this looks good.

