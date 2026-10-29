Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277109;
	b=5hqjYkQ5drM6uv3y3hy9qt16WHd/ha35g2DqUeNLDL9NEWOMlBlV5k4YRR5rmMLsHon2
	 EfmqdOmDWUM4KbQzgOJq0SGPZmrcgExD4Wp1woKmnafFESG6+dBeqlW7/yBkMx9rVydxO
	 ss3n5mk+YYnSZYYWa+BqzAfjAbLsuRW1JNOuVeVa+2Dp8G8xbJGmcsWJr4c6C49iWYZQB
	 iFK3jS7UawdFT7nYKeyo6AT3l7QaQylf0rHNlUbAoV20Nz0JxKtWZFOLdBk2HAgWl1jhl
	 1KpvadnItWIpIht6SXkU0ls+TOjoGOZ8FXJJg2ZZMeaNNFl4yZs18veY6d7uLoRPUvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277109;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=/7kjy5EAs4oKw50wbQP1DYPgZjPJnU0bsNY31e3vehg=;
	b=MGQD13/dOPzPHYBpK4fUPe/dAaaWq/DpY+SHbG4lwIt7yHEgKUgWDcv80sDgRh7QZnxe
	 gF6BYSL7ZqIG8A2X6sLdn6Ks5n2BkLgprNisWpJWQhgjzSgtrzanFTFZ/nkmnk9FFqjWY
	 p6DfjK58hD/0T+iBNTxegipcnKlF8QC+HKIk+XI93KeEeU3bwd6kckZd4GHiYlIsgRAOd
	 quL/HcY/FhuYkAq5DvFn+CHDS2lrynNnIb6eeNDiro2MgrEE+DwnM4M24JgXIX4dZf4rn
	 cKrhsAUT2+Frbf9MckN0aZDQvoz424Vau7nanuGEL6VENe7xgI40toYscWltOF/T0Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eg5DBV4Q;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D2606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 12:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E6D2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eg5DBV4Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/7kjy5EAs4oKw50wbQP1DYPgZjPJnU0bsNY31e3vehg=; b=eg5DBV4Q//Zy7Uh747eN3VGz4J
	ZAg5nz/CXi3rvQ/LPfPlKLrsJIs9Y9fMZOvkpwAsx4xUOYgikTsC/m1sRZrHDvcGo9F1kTM2+WyHk
	wbDFcQqXLevPJQrtI6kzf+TTAUmfuMNLpkDSpk/fZtaqJbajCEUcR62LYrkHwNwP2okqymzgjcNGY
	gi7bUikXh6RrJRFzrFEeiexOZHm19nB3t9dfmCaS6RL7BZwJfumOxYC0sD8XUq5+r3fxajwHIYdN8
	AJxW3FvUiTiFUmtK21vHICmZGqQaVSpobhi+MIxA4ORs+7FU5hK442DT30gsrPR3c7Dnr8tv8e/bs
	yshOt1fA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPIK-00000009AFI-3CNB;
	Thu, 29 Oct 2026 12:31:48 +0000
Date: Thu, 29 Oct 2026 05:31:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 04/98] block: fix use-after-free of the disk in
 sync_bdevs()
Message-ID: <auM8tHIsQDXEedDl@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-5-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028164415.1262013-5-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 28, 2026 at 10:41:07AM -0600, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> sync_bdevs() holds a reference to the bdev inode while it takes
> bd_disk->open_mutex. For a partition the inode doesn't keep the gendisk
> alive, the device reference does: part_release() drops the disk as soon
> as the last reference to the partition device is gone. A sync(2) racing
> with the last close of a partition of an already deleted disk locks a
> freed open_mutex.
> 
> Take a device reference before touching the disk, like
> blkdev_get_no_open() does, and skip the bdev if it's on its way out.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

In the long run I wonder if we should find a way to add the bdevfs
special cases to sync_inodes_sb and reuse the common syncing logic
instead of this.  But some of the special cases might be a bit to
much.

