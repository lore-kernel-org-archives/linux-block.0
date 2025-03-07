Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784B021771B
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348354; cv=none; b=GGE6skXTxCjblni/oOqTFd0wTiOs9GBv9j/2Ohuj8oGlXbKIEUku2fBVqIRbTx0ow7Z6+KOOTSeT6SnZkpziy0UKkdr6OuvWZYI1DFzwgyG8zz9ZxT3Z6Q6EYRt3RHIYfghW1mSSsuBOAP2pkRpabNBMqSyuFfW5SlZj1Pho8Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348354; c=relaxed/simple;
	bh=KY3XNvpIqqodv+H/0yMBf1NJV0oAgK4uZr3G2TWi0Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBvKof1MdkkDlQlaxYY5v0FSpBvD+hHuc/x/WDNBH9gPEs+Ar0qQhJP/5fuBJW3A85jNR0o7SkawmxA+TEuKEud6fujFhHCeJaUwTCPQr6x6I/HcTj30Ol+RSH4YrfL8iI5juvCpl267MKpMcRxhq4R5ttrEnKI9a8SMFp1AJQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Drp5yUOl; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Drp5yUOl"
Date: Fri, 7 Mar 2025 06:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741348350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AR8Kl6IuJYg26NfT4ABsZ98hzvEkHvnC4uDjdCNtrp0=;
	b=Drp5yUOltMdXZePcWi3SmAhYlAin2u+vF1z2nLAQvw4UBXYff59nHFQQMd/2v/hcYcMxCA
	y6lrluVbwQ8T5q1QY4zgxyzaNM+hcPwDblvqP4dBRoAPe1mHL8CO+1Z+f4ggL8m6DF/RIi
	PMh69TeS6Ou6G9KtL4j76JdZ/z5RS8s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brauner@kernel.org, hare@suse.de, willy@infradead.org, 
	david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org, john.g.garry@oracle.com, 
	hch@lst.de, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com, 
	kernel@pankajraghav.com
Subject: Re: [PATCH v2] bdev: add back PAGE_SIZE block size validation for
 sb_set_blocksize()
Message-ID: <p2aj32dbt7dwvedsfno6nehah4fdhwweclgvin3thip4gqeezk@f7ctgb7cis3w>
References: <20250307020403.3068567-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307020403.3068567-1-mcgrof@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 06, 2025 at 06:04:03PM -0800, Luis Chamberlain wrote:
> The commit titled "block/bdev: lift block size restrictions to 64k"
> lifted the block layer's max supported block size to 64k inside the
> helper blk_validate_block_size() now that we support large folios.
> However in lifting the block size we also removed the silly use
> cases many filesystems have to use sb_set_blocksize() to *verify*
> that the block size <= PAGE_SIZE. The call to sb_set_blocksize() was
> used to check the block size <= PAGE_SIZE since historically we've
> always supported userspace to create for example 64k block size
> filesystems even on 4k page size systems, but what we didn't allow
> was mounting them. Older filesystems have been using the check with
> sb_set_blocksize() for years.
> 
> While, we could argue that such checks should be filesystem specific,
> there are much more users of sb_set_blocksize() than LBS enabled
> filesystem on upstream, so just do the easier thing and bring back
> the PAGE_SIZE check for sb_set_blocksize() users and only skip it
> for LBS enabled filesystems.
> 
> This will ensure that tests such as generic/466 when run in a loop
> against say, ext4, won't try to try to actually mount a filesystem with
> a block size larger than your filesystem supports given your PAGE_SIZE
> and in the worst case crash.
> 
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>

> ---
>  block/bdev.c       | 2 ++
>  fs/bcachefs/fs.c   | 2 +-
>  fs/xfs/xfs_super.c | 3 ++-
>  include/linux/fs.h | 1 +
>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 3bd948e6438d..4844d1e27b6f 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -181,6 +181,8 @@ EXPORT_SYMBOL(set_blocksize);
>  
>  int sb_set_blocksize(struct super_block *sb, int size)
>  {
> +	if (!(sb->s_type->fs_flags & FS_LBS) && size > PAGE_SIZE)
> +		return 0;
>  	if (set_blocksize(sb->s_bdev_file, size))
>  		return 0;
>  	/* If we get here, we know size is validated */
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index 8b3be33a1f7a..8624b3b1601f 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -2414,7 +2414,7 @@ static struct file_system_type bcache_fs_type = {
>  	.name			= "bcachefs",
>  	.init_fs_context	= bch2_init_fs_context,
>  	.kill_sb		= bch2_kill_sb,
> -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_LBS,
>  };
>  
>  MODULE_ALIAS_FS("bcachefs");
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 37898f89b3ea..54a353f52ffb 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -2134,7 +2134,8 @@ static struct file_system_type xfs_fs_type = {
>  	.init_fs_context	= xfs_init_fs_context,
>  	.parameters		= xfs_fs_parameters,
>  	.kill_sb		= xfs_kill_sb,
> -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME |
> +				  FS_LBS,
>  };
>  MODULE_ALIAS_FS("xfs");
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 110d95d04299..62440a9383dc 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2614,6 +2614,7 @@ struct file_system_type {
>  #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
>  #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
>  #define FS_MGTIME		64	/* FS uses multigrain timestamps */
> +#define FS_LBS			128	/* FS supports LBS */
>  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
>  	int (*init_fs_context)(struct fs_context *);
>  	const struct fs_parameter_spec *parameters;
> -- 
> 2.47.2
> 
