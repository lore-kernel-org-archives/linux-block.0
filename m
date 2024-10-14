Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772154670
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 05:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885460; cv=none; b=cg9uIsUktZqM2jad1hzBNWpoKpjsVRaX5Q6lVzlj309dp/F77fb0IA4mLsYSnL/joQT9dv/ZWGwxCCoAswxgxzmziu8IaKDuPy278y/I0SJ5lUQiWKge6kzb1JXv71kgeO8KDZmZJPK8QLZvRHVaPf3lfVQ/+CkuURyKlX59vwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885460; c=relaxed/simple;
	bh=Gd6Ev8peQ9QFugXWLwA7Y7+cMr+hJrQl9nkx4WlGxzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCZsvZG3AsEGOt0YELGMt4n9a5OLW0pp57FF8ML4Bjak76aO73Ymt7b4FFmGxJKH46WbbYDGSu5EP0bFlYg5gpgKZ4RCUwjDrFRn+XIurJOmIRxzqfrAfuKzjX7YJNlvEMpdcbxcTLEOAUi0WMrLVDdcJ0B3JumEM/yaTlXcGso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D/a1tJ/A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D/a1tJ/A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Gd6Ev8peQ9QFugXWLwA7Y7+cMr+hJrQl9nkx4WlGxzU=; b=D/a1tJ/A4WXDcaUmahVRo3Ybm3
	UxZ5HJlWCk4bFZxTqOOgzrAu3CybnMdCwLGWD8+8ZCdhM5zngPtmK8VxNhgxYcngpuQLbb8Vls6of
	3zLBvgfNlRqZjLXOG1xwB/qDgIbt6FNv+9tSM4pwguJdiEiHioaj+7RyVlo2IdTd/QTe2z9XiigRc
	XM8gx/SffhN73Cynw+0OrCivimyRy2Ye1tG+DdD/wND6/7jQH++EMclCUOaf8zx7XKcQH9DTbDyoZ
	wp+yFkFxhjPXbXOi0Fhcw8H7mNepUVS6ql69gjrHIhP5Tqjr2Lz1ojiBSXVp2xNlI0W9gLgVnLqpR
	KYpiFH1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0E5L-00000003ocg-0ENv;
	Mon, 14 Oct 2024 05:57:39 +0000
Date: Sun, 13 Oct 2024 22:57:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Rick Koch <mr.rickkoch@gmail.com>
Subject: Re: [PATCH] blk-mq: setup queue ->tag_set before initializing hctx
Message-ID: <Zwyy05TbnmKWYclG@infradead.org>
References: <20241014005115.2699642-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014005115.2699642-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 14, 2024 at 08:51:15AM +0800, Ming Lei wrote:
> Commit 7b815817aa58 ("blk-mq: add helper for checking if one CPU is mapped to specified hctx")

Overly long line.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
