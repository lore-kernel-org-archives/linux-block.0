Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1877385539
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122605; cv=none; b=bh8VBaTndTm+W3I/yNIF1NIo9k5B2DDFSEIWGgnAzrOCrbyqQpWJedog5nLNZB8o8CHE4AZSRxNglmz2JHiGSLVnLcS+UU07/Ly/i6hhUZhf32v9K+ZzNdbgRTzlJtR5Y8mjxrHO2qTLwg4+CXT4eNifUvgyKYQh4Hi1bspYSXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122605; c=relaxed/simple;
	bh=De9yRt8guB9YUvGafncAnLeY+bPrDnWwGRD0nAEKtUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ry8YVSFRMOOfu4FF9HckUdlALxDbT4NYFdtZjBiET3ym52ft9MBrYiyUpOYEbnyjxefuckXqUCuiX+1ytk5xHAW4yMbd0JH9cirEvy7WSE0bKRenaNrzoK+631tGKeXZH6vua+jxy5OzWRKwwoBJkXzUzCgC6b4Vun3LJyMNAeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yThMwMsT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yThMwMsT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zl0c/OTCU3aDGRneTzZFf46To6bND3jhtp2WN4sd4BQ=; b=yThMwMsT8p/rfRNZ85cDR2yFnh
	zU4Y2HMXZ09dmZPResQwu/F8PVMUpT4LFiOHLRMBpnVIOry+8VkgRv0cIsXvy5gWo7Ss8JuGahb0g
	9nqw+qp7+nzd0XAtduP/ndm5bdLqYCVb4aFFCFpgTO4ajYadlY/nd+yjJYqwe78+jX9P6xw9BdVue
	cjFe/pU6rMwFTAJsReLcz8zZ7QpbiL7qbQqrrhVMUdBLVo7SgMys9UKaAJrJEGdZqb4udpe9lMlQZ
	0cLZRXAs40u+e0VfO2bWF5MDTx7lrnkdXvSD1vrKtbaIQo8ihwQl44j0yLI51qTtwklue0FWW7t0y
	2w+v9frA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vve2e-00000006iK9-1Bq7;
	Thu, 26 Feb 2026 16:16:44 +0000
Date: Thu, 26 Feb 2026 08:16:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 5/7] block: allow submitting all zone writes from a
 single context
Message-ID: <aaBx7GMLpFGjON_a@infradead.org>
References: <20260226041024.2154806-1-dlemoal@kernel.org>
 <20260226041024.2154806-6-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226041024.2154806-6-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 26, 2026 at 01:10:22PM +0900, Damien Le Moal wrote:
> limits the maximum size of commands to a small value, e.g. HBAs
> controlled with the mpi3mr driver limit commands to a maximum of 1 MiB.
> In such case, the write throughput gains are over 40%.

Nice numbers!  Although it's a bit sad that HBA capabilities are
actually degrading with new products.

> +static ssize_t queue_zoned_qd1_writes_store(struct gendisk *disk,
> +					    const char *page, size_t count)
> +{
> +	struct request_queue *q = disk->queue;
> +	unsigned long qd1_writes;
> +	unsigned int memflags;
> +	ssize_t ret;
> +
> +	if (!blk_queue_is_zoned(q))
> +		return -EOPNOTSUPP;

I think with the attr visibility check the non-zoned case here can't
actually happen.

Otherwise this looks beautiful, thanks!

Reviewed-by: Christoph Hellwig <hch@lst.de>
