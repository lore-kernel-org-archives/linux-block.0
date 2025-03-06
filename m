Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46E1DE4EC
	for <linux-block@vger.kernel.org>; Thu,  6 Mar 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286400; cv=none; b=mWshiJRwlPn8pXsEATAcB2UvV7bafvEC4Buvxu8EFu1HbA/KBKEuSBHAQKnC/+oUcRKs6pDW08LPwmSfEaCMfVt5nM+FkWY3lKI4uUSOJ/aFw1BTbk9hPpJwkpCCrL/w/BhGpXFpXAseMwNKLZZMYMsHKnzn47UVNsXLR+d3T1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286400; c=relaxed/simple;
	bh=2VADS6s3kjJiBocvDhk8hFEg79xaOXDP2At9HSKtPt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmBlvs4z6EcEjNa2KkrQdbHp8QYWQpx555SAxaKEFP4clUG/HhDDayQZURUxieVQ0a6qijRvLuxXTgElCSFzgS4BnuICNO0IgtOzzKk5wOVVUpq4dndmhrCocUgSDGxLd2FeZEt6kygDGZqygwF60eG0EZIOJtQf5QdN2YZe4Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jyw+1nY6; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jyw+1nY6"
Date: Thu, 6 Mar 2025 13:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741286395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TFfstaBlNEfLcMLYxXQf1Hl9Qzdzi50aC/F0YKZsvXw=;
	b=Jyw+1nY6+ZQg3G4R0DrjiDqpvqHVyUl4gv16T5Oe1RTFc3l9+FRi8KknOXOkQ829y2GVTg
	uCfgfApkjCrK0CEgrhIpO+GG32I+QQf0/6QKNLgYdN98omiKD3tNT7LYJQS6+Ml212M4h2
	ZSbPIRIbINc8Hz+jTL0vkOWPr2k9t88=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brauner@kernel.org, hare@suse.de, willy@infradead.org, 
	david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org, john.g.garry@oracle.com, 
	hch@lst.de, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com, 
	kernel@pankajraghav.com
Subject: Re: [PATCH] bdev: add back PAGE_SIZE block size validation for
 sb_set_blocksize()
Message-ID: <bgqqfjiumcr5csde4qzom2vs2ktnneok3gdffvu6tlyc3ih7x3@tioflbnatc5w>
References: <20250305015301.1610092-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305015301.1610092-1-mcgrof@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 04, 2025 at 05:53:01PM -0800, Luis Chamberlain wrote:
> The commit titled "block/bdev: lift block size restrictions to 64k"
> lifted the block layer's max supported block size to 64k inside the
> helper blk_validate_block_size() now that we support large folios.
> However in lifting the block size we also removed the silly use
> cases many filesystems have to use sb_set_blocksize() to *verify*
> that the block size < PAGE_SIZE. The call to sb_set_blocksize() can
> happen in-kernel given mkfs utilities *can* create for example an
> ext4 32k block size filesystem on x86_64, the issue we want to prevent
> is mounting it on x86_64 unless the filesystem supports LBS.
> 
> While, we could argue that such checks should be filesystem specific,
> there are much more users of sb_set_blocksize() than LBS enabled
> filesystem on linux-next, so just do the easier thing and bring back
> the PAGE_SIZE check for sb_set_blocksize() users.
> 
> This will ensure that tests such as generic/466 when run in a loop
> against say, ext4, won't try to try to actually mount a filesystem with
> a block size larger than your filesystem supports given your PAGE_SIZE
> and in the worst case crash.
> 
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

bcachefs doesn't use sb_set_blocksize() - but it appears it should, and
it does also support bs > ps in -next.

Can we get a proper helper for lbs filesystems?

> ---
> 
> Christian, a small fixup for a crash when running generic/466 on ext4
> in a loop. The issue is obvious, and we just need to ensure we don't
> break old filesystem expectations of sb_set_blocksize().
> 
> This still allows XFS with 32k block size and I even tested with XFS
> with 32k block size and a 32k sector size set.
> 
>  block/bdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 3bd948e6438d..de9ebc3e5d15 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -181,7 +181,7 @@ EXPORT_SYMBOL(set_blocksize);
>  
>  int sb_set_blocksize(struct super_block *sb, int size)
>  {
> -	if (set_blocksize(sb->s_bdev_file, size))
> +	if (size > PAGE_SIZE || set_blocksize(sb->s_bdev_file, size))
>  		return 0;
>  	/* If we get here, we know size is validated */
>  	sb->s_blocksize = size;
> -- 
> 2.47.2
> 
