Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07133346E68;
	Tue, 16 Dec 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871199; cv=none; b=g0hUOhMQwRloAITTYsuxQML7Oa1Fvnd+f3dc5p3tJM/KrSbzMIsqXEKl9XsuuNKUUEp32YN2HuHHDJ60t5dsxFwHLX+HUJXzO3sYlqDIpSlK0nefldW5gnmhfGFcqfzoc3PpUqsu6YR7GtP3WtXnZekEyadwDUgMmMSwxi6f48A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871199; c=relaxed/simple;
	bh=7B3JwfmGBR+BEPYLnUkeLMkSXAvTgYR8pHeohhSDkcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxRXQTVjYRB5ZuzckZxuXBq9F66PxfMWpY9W4m9bdpoaAwxMf3SjD7rxZV411ZxABs/jy3G70ZgfysgaT7vXBmCCGlrLlyR/Qlh80IzGbnQbzKvrT9JwclD+hR/saoa2GpSK8a4J2OB5rtnS59YvHg2FSMxIJr4EtWkgXM9MhrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cm2/7w1X; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cm2/7w1X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ip9LXQ/vJraZQ0ZlPKhapnkhIU5iQLC7Dcck00UjvEY=; b=Cm2/7w1XrZq2/CvRVMugSSxWeI
	uDr6QfBIAafFVlYdEWDblezoYWfnbtn7J3GBuPIv/CZZWXWIvMOZ0xxqOuYlQJ4UHtA/Lfj4KEcFX
	uHGseKjWhFn284WUUAfa6sbvP0Pcz3LmQPEMOTkfuNBshIxkxDz3j/LqKqPu3/HKxqi9q962VwZMv
	THqeIljrez5sQmvKcyEHP4MzRLfZuF9buxsyziAdYEcagOQ8K1IVbUIstAuJLfoIVeLaOTZSx4YGK
	tIamKn2smK0zK4h4GfWUE2RcNZ4hqRx5BGvnCngRq8sUrnme9JyeAalmCDD6QQYPPgX8ozBnqq1S7
	78BqkGoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVPlQ-00000004sMf-32et;
	Tue, 16 Dec 2025 07:46:32 +0000
Date: Mon, 15 Dec 2025 23:46:32 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, stefanha@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] block: add allocation size check in
 blkdev_pr_read_keys()
Message-ID: <aUEOWFY3d3vsA1EI@infradead.org>
References: <20251216051147.12818-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216051147.12818-1-kartikey406@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 16, 2025 at 10:41:47AM +0530, Deepanshu Kartikey wrote:
> blkdev_pr_read_keys() takes num_keys from userspace and uses it to
> calculate the allocation size for keys_info via struct_size(). While
> there is a check for SIZE_MAX (integer overflow), there is no upper
> bound validation on the allocation size itself.
> 
> A malicious or buggy userspace can pass a large num_keys value that
> doesn't trigger overflow but still results in an excessive allocation
> attempt, causing a warning in the page allocator when the order exceeds
> MAX_PAGE_ORDER.
> 
> Fix this by introducing PR_KEYS_MAX_NUM to limit the number of keys to
> a sane value. This makes the SIZE_MAX check redundant, so remove it.
> Also switch to kvzalloc/kvfree to handle larger allocations gracefully.
> 
> Fixes: 22a1ffea5f80 ("block: add IOC_PR_READ_KEYS ioctl")
> Tested-by: syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
> Reported-by: syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=660d079d90f8a1baf54d
> Link: https://lore.kernel.org/all/20251212013510.3576091-1-kartikey406@gmail.com/T/ [v1]
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> v2:
>   - Added PR_KEYS_MAX_NUM (64K) limit instead of checking KMALLOC_MAX_SIZE
>   - Removed redundant SIZE_MAX check
>   - Switched to kvzalloc/kvfree
> ---
>  block/ioctl.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 61feed686418..98c4c7b9e7fe 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -18,6 +18,8 @@
>  #include "blk.h"
>  #include "blk-crypto-internal.h"
>  
> +#define PR_KEYS_MAX_NUM		(1u << 16)

I think _NUM is redundant here.  Also this should probably go into
the uapi header.

