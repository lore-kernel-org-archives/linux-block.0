Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F032026B2CE;
	Sun, 10 Aug 2025 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754838910; cv=none; b=WgHMz45GAIBF4UG1GI25CNIYCU1SZrDpcDxFZZrziABZ0CoQ1PHMFIzE5bmVLHqtRBvDfV2xRlHNoUAJeNL5kTxqaq+tizrjeqyBoyB/p/B8ZbErmUuMHK0hpQkpWH+N3vTLaIkC2IztB8cbjtzik1z4yFcsKJYGTE86Yn3Biio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754838910; c=relaxed/simple;
	bh=4py5CiaEqZCxsBjzLqsWWptAKmnXu0QuOgMZZwuHK7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkFh6Pc7F5BzIgtA+kZ/iAxHVocHlSt0UlKjQNyjty1gOLyYWdJA41NwySPHsdpw+aJuun9O5BuuxSkf87WEQ790hqpzAiYNFqZQsCds2hgfIXzxIMJRJPtyd5cywoL/wnZY9TcEMubQTgnXh97n/8FKj1kSlqPfxFxcWvQ8s0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3kRrcm9o; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3kRrcm9o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KCZ5r6bLjXiaZzh+JC2eqEL4QryolyvFac905CpBFhY=; b=3kRrcm9ois4tc4AmmgL8vGPwAT
	jUtJBK1VKIQVZeuuBEOQLPQUijfLJhl7u2K3LtTGjAr4OHb5hAboE1y4eauF9qIIUQ6CPyWxbGbl4
	yS0MUb+sKAwkQAc8k86Rz2u8LVaqwc5qLV/yyE5e4O6IphgNWf3+WXr+ZUxwLnVW65ejLtm61d3Os
	mVBHHDOmlW2WORHsbBLCIchtnMCjcdlZCLnmdfuZKSUmpEGi97gjKgltX/eNzYbw0JUPSImDtEeZn
	MQ9Z9Hoi9s6mlaY7RmCvLzyI4DJc6gqOMFvY2ulL7ucskZlGtKjMzFctziahr1GBtBI4ND3ycNE2x
	qGXjhf9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul7lM-00000005joe-19Z7;
	Sun, 10 Aug 2025 15:15:08 +0000
Date: Sun, 10 Aug 2025 08:15:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Rajeev Mishra <rajeevm@hpe.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] loop: sync filesystem cache before getting file size
 in get_size()
Message-ID: <aJi3fFwlqb-SfHGg@infradead.org>
References: <20250807232522.192898-1-rajeevm@hpe.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807232522.192898-1-rajeevm@hpe.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 07, 2025 at 11:25:22PM +0000, Rajeev Mishra wrote:
> The get_size() function now uses vfs_getattr_nosec() with AT_STATX_SYNC_AS_STAT
> to ensure filesystem cache is synchronized before retrieving file size. This
> provides more accurate size information, especially when:
> 
> - The backing file size has been changed by another process
> - The file is on a network filesystem (NFS, CIFS, etc.)
> - The file is being modified concurrently
> - The most accurate size is needed for loop device setup
> 

Please wrap your commit messages at 73 (or apparently 75) lines.

Also 'syncing the cache' (what cache?) is at best an implementation
detail.  The VFS semantics simply are that you need a getattr to
retrieve the inode size, and the loop code fails to do this correctly.

> The implementation gracefully falls back to i_size_read() if vfs_getattr_nosec()
> fails, maintaining backward compatibility.

No need to fall back.  If vfs_getattr faills the file systems is
completely toast.

>  static int part_shift;
>  
> +/**
> + * get_size - calculate the effective size of a loop device
> + * @offset: offset into the backing file
> + * @sizelimit: user-specified size limit
> + * @file: the backing file
> + *
> + * Calculate the effective size of the loop device
> + *
> + * Returns: size in 512-byte sectors, or 0 if invalid
> + */

We don't really need a verbose kerneldoc for a static helper with 2
callers.

>  static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
>  {
> +	struct kstat stat;
>  	loff_t loopsize;
> +	int ret;
> +
> +	/*
> +	 * Get file attributes for validation. We use vfs_getattr() to ensure
> +	 * we have up-to-date file size information.
> +	 */

The comment seems a bit misleading or at least not to the point.

I'd say:

	/*
	 * File systems don't have to keep i_size in sync.  While local file
	 * systems typically keep it in sync, remote file system often do not.
	 * Go through ->getattr to retrieve the current value.
	 */

> +	ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 
> +			        AT_STATX_SYNC_AS_STAT);

Most kernel callers just pass 0 instead of AT_STATX_SYNC_AS_STAT here,
which honestly is less confusing as I had to look up
AT_STATX_SYNC_AS_STAT first.

> +	if (ret) {
> +		/*
> +		 * If we can't get attributes, fall back to i_size_read()
> +		 * which should work for most cases.
> +		 */

As said above, there is no need to do this.  Adding a proper error
return chain here is better.

