Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB38D3BBCF
	for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 04:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688175; cv=none; b=JN18eRziePKUG8SzziDcz0T29LJr8oRM1MM5SZkzzBhZlQkz34VEYCm1PS1vkxgNZCP2dHMRI6kUikBTv8kq2ghVXRc4iLDvZjpbZcfWzZ+f8WxCDCPE/LgvAdi4Ui+S/iyl9FpchDbpza1m5/gAcdtGqUQ32FP+m3VB007lOOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688175; c=relaxed/simple;
	bh=5bxVuTHBcY29Pn0pRzW9d1IPrtR6SP3I956m3WswXaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lvsw92WWxEibQ96MmZJDASW++/bMLTD66TPvT3LuGlLMVWtWTYcptDInlqfBmaOlLHdeUlXrzLbH4uNAf9ofx7xcF0GsGzRJzU2/+clDPbvQWh0M1+9y3H45etvwR9Ycesg4zJjGrh75zEwH7ODwCUyJTg7NO1CXstIxcpO8TLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nf5B2WRs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nf5B2WRs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KeZIReu8xHOaZyt8kji11gJAy/NFES9Tu8bOn2Aj9CI=; b=nf5B2WRsq5OWZtmVCTVExmEhqH
	/rmTCWqoasSayuVcIulV+fa5SclD/6OSYwZ9IxJOz/QfvD1U7NCkmmjq7mhlAwGrRb9pQ6N9TDRxL
	o1MVKKWCNTmM7TOF/Bkd0qUTLZL1pWpPishx/Tpu+WCzWrbQO/AcIvjRNEt3e62e/tCV7fUMXa8Pp
	ouh86Vxd6ElL1Z+6dssZlpnAWzrDstD8TJAEEJXMf5msLgMfZGWVNMVROCcMgvvJr9XYGjmHy4DZa
	MrbsDIXxDAeFCNj2AS8796SCITVaWp+Pn1uZSHomXNdkOunTX3TaLXU9PvfEwxQJurTfdrBhOeguP
	ShbZ5w6g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rq4Hf-000000081vo-47sc;
	Fri, 29 Mar 2024 04:56:08 +0000
Date: Fri, 29 Mar 2024 04:56:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Message-ID: <ZgZJ54rW2JcWsYPA@casper.infradead.org>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner>
 <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>

On Sat, Mar 23, 2024 at 05:11:19PM +0100, Christian Brauner wrote:
> Last kernel release we introduce CONFIG_BLK_DEV_WRITE_MOUNTED. By
> default this option is set. When it is set the long-standing behavior
> of being able to write to mounted block devices is enabled.
> 
> But in order to guard against unintended corruption by writing to the
> block device buffer cache CONFIG_BLK_DEV_WRITE_MOUNTED can be turned
> off. In that case it isn't possible to write to mounted block devices
> anymore.
> 
> A filesystem may open its block devices with BLK_OPEN_RESTRICT_WRITES
> which disallows concurrent BLK_OPEN_WRITE access. When we still had the
> bdev handle around we could recognize BLK_OPEN_RESTRICT_WRITES because
> the mode was passed around. Since we managed to get rid of the bdev
> handle we changed that logic to recognize BLK_OPEN_RESTRICT_WRITES based
> on whether the file was opened writable and writes to that block device
> are blocked. That logic doesn't work because we do allow
> BLK_OPEN_RESTRICT_WRITES to be specified without BLK_OPEN_WRITE.
> 
> So fix the detection logic. Use O_EXCL as an indicator that
> BLK_OPEN_RESTRICT_WRITES has been requested. We do the exact same thing
> for pidfds where O_EXCL means that this is a pidfd that refers to a
> thread. For userspace open paths O_EXCL will never be retained but for
> internal opens where we open files that are never installed into a file
> descriptor table this is fine.
> 
> Note that BLK_OPEN_RESTRICT_WRITES is an internal only flag that cannot
> directly be raised by userspace. It is implicitly raised during
> mounting.
> 
> Passes xftests and blktests with CONFIG_BLK_DEV_WRITE_MOUNTED set and
> unset.
> 
> Fixes: 321de651fa56 ("block: don't rely on BLK_OPEN_RESTRICT_WRITES when yielding write access")
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Link: https://lore.kernel.org/r/ZfyyEwu9Uq5Pgb94@casper.infradead.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>

So v1 of this patch works fine.  I just got round to testing v2, and it
does not.  Indeed, applying 2/2 causes root to fail to mount:

/dev/root: Can't open blockdev
List of all bdev filesystems:
 ext3
 ext2
 ext4
 xfs

Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(254,0)

Applying only 1/2 boots but fails to fix the bug.
