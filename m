Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41791F2B88
	for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781488244; cv=none; b=FyOYezgOnOndRy0tH5PD7TBFDwKiXlTXwfAbtTZJIdj4NW+VZ7bnNtz5UVK2RRt0lcvr+QAUBeXl+K9ogGiqUWaSA4XW8p7HCyq6cQZqQEsxQZ1O3wRKAcuhAW+unuzJ3nHSNVq7msPCd96kM+fnu0gzQ9zrBwmxictiRsPychg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781488244; c=relaxed/simple;
	bh=iwPaf5O1p8Bozvyw6mAQYTVebmpFDgP8zVaHzs8U/ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsVM4ah23JwSd2Im38aVBH/L7qJhDiHlXMyR2RMM6lrAJE8TfrJfePYj+cKosopdHyAjl8cBrE6J1nov/+7lQ6v4a9n/yLkndmVMX/r3/pwcZQn6Y7BRXqyOSSRi3BVSr+5AFwOaCmde/0nurs2BEPld9CxcbkTc0pDznbkQLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 15 Jun 2026 10:50:38 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Mon, 15 Jun 2026 10:50:38 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Jianyue Wu <wujianyue000@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Chris Li <chrisl@kernel.org>,
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
	Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/page_io: let block drivers register custom swap
 I/O ops
Message-ID: <ai9abo7GwMl+g43G@yjaykim-PowerEdge-T330>
References: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
 <20260614-zram-swap-ops-block-register-v1-1-6c1a6639c222@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614-zram-swap-ops-block-register-v1-1-6c1a6639c222@gmail.com>

On Sun, Jun 14, 2026 at 11:35:29PM +0800, Jianyue Wu wrote:

...

Hello Jianyue.

Currently, the patch commit log indicates only a single custom swap
registration is supported. Shouldn't we allow multiple block drivers to
register their custom ops simultaneously from the beginning?

>  int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
>  		struct list_head *folio_list);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 284eebc40a70..ebdc96092961 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2849,6 +2849,10 @@ static int setup_swap_extents(struct swap_info_struct *sis,
>  	sis->ops = &swap_bdev_ops;
>
>  	if (S_ISBLK(inode->i_mode)) {
> +		const struct swap_ops *block_ops = lookup_swap_block_ops(sis);

Also, just a personal thought on this part.

Instead of using `block_device_fops` as a lookup key, what if we handle
this similarly to how filesystems use the `a_ops->swap_activate` callback?

We could add a `swap_activate` callback directly into
struct block_device_operations (zram's zram_devops). This way, the
block device itself can set up and replace the swap `ops` directly without
needing a separate registration/lookup mechanism.

What are your thoughts on this approach?

Thanks,
Youngjun Park
