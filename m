Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA3833C9;
	Mon, 21 Apr 2025 05:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745213061; cv=none; b=B/R78+3VmiqYpp5QMjxHMsIhlErj0XEUU4KtlHQ1J+sAvptZTO5e1I3z5QlHbHwWdQ2cRk1BkIsAuDQpYvuKOuo3be1ZXYJuehwC6p4a+eKR8pS0rxsewZnVt/O/BEWiBb8WD3flmBrt7DPakIPCLhU1bMK+UI1Rs0eTPJfANU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745213061; c=relaxed/simple;
	bh=Qeq5WqVxaFDaRoTkztFiKE40xs6GMLmhBv5Y4Aqqt7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLgkQ1S13oz6aAWNup12yVFhxK/dWBKZgCROBYq3/gWngIRGb5mQ03BbZPImrCtET8jxPtjsqxS+Uqh7q6wAHgMmjdmpVrnhp9AOXFhGQP6rIqTEqMQUFyP10dqQUWY9rtnMDPRT+6lRB9rEp5QUz+MMH0YmwS+fvhsT9AvOOAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xYtNrgAr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xYtNrgAr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GxHzeYU0ESgyT7pY6a0fJaZH26/6wg/kl4YXtmtWJjY=; b=xYtNrgArJb/s8Py7QbRO8+ZQdU
	Dk8Gx1eBJ5x0TGVsAlpQ+Eeul+nSkCPt8E9gwzPRKgeAKhxl3+gtY39QdXeZIDCMO+LrPaXYK26IM
	8ei+cDRus0eLNSlTTFGGPtnvauP+1K2secM6eLGqva1YW4wK3tCDps1qdKWCQXRv77l76suMUr6oP
	ZQF4yQPILoPmjc47AkNPTZDhVOEbvD98hocW99x4ohrIdUPXkrhhh91kWDBqFkXSxlp99VACaHGw9
	0XpA6I/B3nxA0jX7HV1/H4175GJ2BVCvcQb3jdhd48F1RwD7yLiAN0wOe8j9cz8SapQa/7Z64za3J
	y+i5qPHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6jdi-00000003cqw-2iYx;
	Mon, 21 Apr 2025 05:24:18 +0000
Date: Sun, 20 Apr 2025 22:24:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/5] brd: synchronize using page and free page with rcu
Message-ID: <aAXWgjauEVvw5183@infradead.org>
References: <20250418093826.3149293-1-yukuai1@huaweicloud.com>
 <20250418093826.3149293-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418093826.3149293-3-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 18, 2025 at 05:38:23PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, after fetching the page by xa_load() in IO path, there is no
> protection and page can be freed concurrently by discard:

Ah, I guess this helps with the race I mentioned in reply to the
previous patch.  Is the rcu_head in struct page available for use
by subsystems freeing the page?

> 
> cpu0
> brd_submit_bio
>  brd_do_bvec
>   page = brd_lookup_page
>                           cpu1
>                           brd_submit_bio
>                            brd_do_discard
>                             page = __xa_erase()
>                             __free_page()
>   // page UAF
> 
> Fix the problem by protecting page with rcu.
> 
> Fixes: 9ead7efc6f3f ("brd: implement discard support")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/block/brd.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index a6e4f005cb76..740ed13faaff 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -208,6 +208,7 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
>  			goto out;
>  	}
>  
> +	rcu_read_lock();
>  	mem = kmap_local_page(page);
>  	if (!op_is_write(opf)) {
>  		copy_from_brd(mem + off, brd, sector, len);
> @@ -217,11 +218,19 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
>  		copy_to_brd(brd, mem + off, sector, len);
>  	}
>  	kunmap_local(mem);
> +	rcu_read_unlock();
>  
>  out:
>  	return err;
>  }
>  
> +static void brd_free_one_page(struct rcu_head *head)
> +{
> +	struct page *page = container_of(head, struct page, rcu_head);
> +
> +	__free_page(page);
> +}
> +
>  static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
>  {
>  	sector_t aligned_sector = (sector + PAGE_SECTORS) & ~PAGE_SECTORS;
> @@ -232,7 +241,7 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
>  	while (size >= PAGE_SIZE && aligned_sector < rd_size * 2) {
>  		page = __xa_erase(&brd->brd_pages, aligned_sector >> PAGE_SECTORS_SHIFT);
>  		if (page) {
> -			__free_page(page);
> +			call_rcu(&page->rcu_head, brd_free_one_page);
>  			brd->brd_nr_pages--;
>  		}
>  		aligned_sector += PAGE_SECTORS;
> -- 
> 2.39.2
> 
> 
---end quoted text---
