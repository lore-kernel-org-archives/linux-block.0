Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CD13A380F
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174383; cv=none; b=Va0QQVdK1HcKAma94gKx3qADwIpSFX5ebQ1UVZTId4U6LBmV7gdd1v6w3IfV60ZfIM4WgeMYLI5Oa19m9o9inIng9zh6Llhmabei1aQCvBVatNouvd0RiOqsmeZfVdWjLTE28OYOk8jcuzqdhFNYpVAqPqCGq+jllANydFbfgUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174383; c=relaxed/simple;
	bh=By98vreMwRBAWRHYFpBVDsAx8QsVcSfTG5vfwmarqBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dchUc1ouZL0GPFfTjhdESPA0NszY1rR1bwdvfouQfN1TMla5aEhQDBZ0j2H+4Q4kFZm/drVfyp/SGbpka7wBm3TJypGGsxOn4ZrCJBQ9Z8OD6P53HwhWC13kwVzo2/+zOeXBwgwFWg4rVPYPME0DWvNXBR9JgA8WPMzjDJiTbt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A842468BEB; Wed, 23 Sep 2026 16:39:37 +0200 (CEST)
Date: Wed, 23 Sep 2026 16:39:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K . Petersen" <mkp@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: reject polled dio with user integrity metadata
Message-ID: <20260923143937.GA28622@lst.de>
References: <20260923093732.1504291-1-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923093732.1504291-1-yangxiuwei@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Sep 23, 2026 at 05:37:32PM +0800, Yang Xiuwei wrote:
> IOCB_HAS_METADATA leaves iocb->private as a uio_meta, while
> iocb_bio_iopoll() expects a bio. Since 2729a60bbfb9, metadata I/O
> always uses __blkdev_direct_IO(), which never publishes the bio for
> polling, so IOPOLL calls bio_poll() on the uio_meta.
> 
> Reproducer: io_uring IOPOLL plus a PI attribute on an integrity device
> (scsi_debug dif=1 dix=1). KASAN reports:

Can you add a reproducer for this to blktests?

