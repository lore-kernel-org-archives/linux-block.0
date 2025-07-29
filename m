Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1642C18A;
	Tue, 29 Jul 2025 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753774325; cv=none; b=ssC25Aj2rePFfUz00BjaBWaOmjALCMFpHVnmT3F+qUJ7+YaiPZlAO4/hh6CmC3UE9+OXWLU1ulnSWzxGqaj+6bMivQN+XvlZqYEoGOgMSVdswVOq6VhVDNm/iQaUc1PMa0q3QTnBsF0FxjbQ3RWIQ9z59fGbIbDogIo+KR6EAyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753774325; c=relaxed/simple;
	bh=mXawYNblOKHI8Qe1OGM3cwRbMY2bG+jXMmmwUkywnmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ae6iAaT2wiDZ9Ol/Uu+rNKpJVoy/cUm0jXl/th0FW1cmvKL9BuTV6V+pqfcRKn8Ti/opGkYDeqkH0teVD7N7KpsJJplI96slMPbiMXLEvqQdO9druQIpNNNvi9XrFvU6SzjaMZ4rZopKCTtHcOGfWL80KtNa5qF1ZRtLZGTy9oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rwCNUScz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rwCNUScz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C7K39Q4zkz0EcQTxtEs8Hc0N30C7j7wtFgFSP9Y6lZ8=; b=rwCNUSczo8Voc9WrXJJ7gMvSoM
	KUFMSnYlokEaYwzMKBTAqnqJsnsUMMrs6bCHoGIxB0T3YXACWhBF5JxV7TneFtaGb73NXkKYMEyrS
	IRJEQyQVbSrnT+u+oLeGoyEDqpgg+aBenBQr6ubYSPatBBKNZ5CkeoxGtqIqOvh48XA+mCJLX8/r7
	eURBFAfy2Kx0IYU3/iByRID1WoEC+3xnYdRG0U7CvEItJlxdWH4rfQxYAozkUpAvSXjrL+eUrWQu6
	4cuj+WUi6AYwYKnSwN8XOhT24BdecOMm5TT4Bk1xuQ9rqNzyoXB3zrgUgjHNDDmqSNHURpDK0cC/C
	/Z9y1gsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugeoW-0000000G7s2-4B6C;
	Tue, 29 Jul 2025 07:31:57 +0000
Date: Tue, 29 Jul 2025 00:31:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Klara Modin <klarasmodin@gmail.com>
Cc: brauner@kernel.org, anuj20.g@samsung.com, arnd@kernel.org,
	martin.petersen@oracle.com, joshi.k@samsung.com, hch@infradead.org,
	arnd@arndb.de, naresh.kamboju@linaro.org, anders.roxell@linaro.org,
	axboe@kernel.dk, kbusch@kernel.org, csander@purestorage.com,
	asml.silence@gmail.com, adobriyan@gmail.com, djwong@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: change blk_get_meta_cap() stub return -ENOIOCTLCMD
Message-ID: <aIh47Ncx5lY1vc9F@infradead.org>
References: <20250725164334.9606-1-klarasmodin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725164334.9606-1-klarasmodin@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 25, 2025 at 06:43:34PM +0200, Klara Modin wrote:
> When introduced in commit 9eb22f7fedfc ("fs: add ioctl to query metadata
> and protection info capabilities") the stub of blk_get_meta_cap() for
> !BLK_DEV_INTEGRITY always returns -EOPNOTSUPP. The motivation was that
> while the command was unsupported in that configuration it was still
> recognized.
> 
> A later change instead assumed -ENOIOCTLCMD as is required for unknown
> ioctl commands per Documentation/driver-api/ioctl.rst. The result being
> that on !BLK_DEV_INTEGRITY configs, any ioctl which reaches
> blkdev_common_ioctl() will return -EOPNOTSUPP.

FYI, I still think we should not fail the command for
!BLK_DEV_INTEGRITY, but just report no capabilities.

