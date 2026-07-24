Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA0F2F5A0E;
	Fri, 24 Jul 2026 04:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784868773; cv=none; b=rI0cUUGX7d8eZzLvZbQ72EKyQQ4/Edvk0SB1QtsaWaSR/2EuEnKSQOqphaJ/aX2kb7GgkevBXBVv8FUJLMppwx/ej4iY5znvHtSmrB4LS/0dl2A2mwKZLhsTeHWwA3Ri5g1qIxY03TPUTyIGKgX23ADRcyMxj729TgKNtgrXf4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784868773; c=relaxed/simple;
	bh=Ji0OUeK5LjhHr2BY2BhGX0ZtbxvAiysXWOwBRdN8LkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWSTaH3apgCNBU6uii5QcnZBQFzrVnpbQwHeheZlayS+7U1y9zanLoz3D6DlOCZbBCwYRyj5fAGBVjQSrlu3QDjPuan9rx0KrzIkVExXEf5O79gP6XLCivjEeVN3Z2KG1NmtEE6P3Wo7vJYBkTH4U5MqHD16sQ++ivc7dsrW5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YQVUFVVy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YQVUFVVy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UoF9wcDUPRYb4adbhXStn8laZZegKLaKlhduz8Oo6fg=; b=YQVUFVVyCjA/gjxaPvMFP22Uwk
	ZCrjWCI13ZbnYQ7C6wMzzqSvwq3nQzyfvJFfLVt5ODEj1D2EyLC0glBmZvcWoQ/RvQnIn1KrF+Ewp
	clzewvHhePP70hgOB/bl8rSjXv5yfk1+OY/E1Ao/0UvS9w42g1PQVycXjM7TO0iu+LnkEEaPvPLvR
	e3D/5eshmeFXzjjJNrCmEIOi9O/JOOU9eLLk5vjtnlJy7zdZ02o+jjwR1PrlIfhb7t/Pp3PA3Xhy9
	a01ZpWDXsFjtf52t2KWvv9flblWeR1YQP192UxBVL5YIBMvIpBPUCcM85hEA8/7PfbIXf835MFw0V
	8wl7DcQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn7tq-0000000FTjv-2P2J;
	Fri, 24 Jul 2026 04:52:42 +0000
Date: Thu, 23 Jul 2026 21:52:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yangerkun@huawei.com,
	chengzhihao1@huawei.com, wozizhi@huawei.com
Subject: Re: [PATCH] block: fix BLKSECDISCARD zero-length range causing page
 cache invalidation
Message-ID: <amLvmjCNwF8Ftobe@infradead.org>
References: <20260704073942.3760597-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704073942.3760597-1-wozizhi@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jul 04, 2026 at 03:39:42PM +0800, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> Commit 697ba0b6ec4a ("block: fix integer overflow in BLKSECDISCARD") fixed
> the start+len overflow via check_add_overflow() but did not handle the
> start=0, len=0 case. There, start + len = 0, so end = 0 passes all checks,
> and truncate_bdev_range()->truncate_inode_pages_range() is then called with
> lend=UINT64_MAX, whitch is the "truncate to the end of file" sentinel, so
> the entire page cache is invalidated.
> 
> Fix this by replacing the validation with blk_validate_byte_range(), which
> already rejects a zero-length range and is what BLKDISCARD uses. This also
> switches the alignment check from a hardcoded 512 to
> bdev_logical_block_size().

I though I had reviewed this before?  But either way it looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

