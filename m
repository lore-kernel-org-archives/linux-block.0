Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63926ADE;
	Fri, 14 Jun 2024 05:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718342712; cv=none; b=f6JKJLpY4iT2YS+v9rTx/P/IrTDUM2ByEFiGEAjDFYQa91A8v12MiFmefo3MByA0ZapXhBBim2O0YIoIzXachB+J1QeWwEyz9TkEopcMKj+86y+z6Fk7UMCT03N4jgaK07tqbbJ8bPxZoLjyxXNdSQ5UDWW40YAxEkZdZ8Kf3lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718342712; c=relaxed/simple;
	bh=OaL/YySuS8Lb2/DNnLJjW1FOsvpqsCMKXFp5iTRhbnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptSe5lpPFiZM0HgZcv9s+qw3lYEC+8RONG7dYC1p+zk1a86UKPi2KAh3J5t6CUtEs6227zTLCy5FuAaY5++QM1X6TxOe6zBnTD2uGSoZBQlvElnZqAJND0mcBVpa9oTWwYZIdsdNyWP50AFSdADAHRQ+MDaGSnir3cOMp506cVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xLYm1yjQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xLYm1yjQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Opkxi+gfmcpzITD7sqGaypru2LVXW9LGl2bAVRif/+g=; b=xLYm1yjQQK1/oHw/h7HRGquzgi
	/F2nGUC+s39nUznw+nSZC6jV7EmIfE+NAiUq3+d1fYzPD3enZrddeFMjcgvl6Q0CufOXhZNrcE99w
	c6EPV5AGPB1VA0JqhLg+LhImYNh0CRTgxGG6PoOtACqYf7Mdj0E/RNKSJY4sqzwEJSL9tFG5Sm/4V
	n5Ae49BVImmcUkaBMyVCa8D+q6HaTawsIGThI7hG6zBLk7quvkTtAqVd3NxEZzyH+hROEpXnxpb2O
	2kjE98cL4A0FRGprl93w5LxEzEtVcf8BW6fhm+nOv1ZL1iGs+gRXGQVhbsg6L4f0S5LMS0xl97SQN
	i5aiC7og==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHzQu-00000001V77-0Y8g;
	Fri, 14 Jun 2024 05:25:04 +0000
Date: Thu, 13 Jun 2024 22:25:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: use copy_page for full page copy
Message-ID: <ZmvUMPc1eEOwUo7h@infradead.org>
References: <20240613000422.1918-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613000422.1918-1-jszhang@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 13, 2024 at 08:04:22AM +0800, Jisheng Zhang wrote:
> commit 42e99bd975fd ("zram: optimize memory operations with
> clear_page()/copy_page()") optimize page copy/clean operations, but
> then commit d72e9a7a93e4 ("zram: do not use copy_page with non-page
> aligned address") removes the optimization because there's memory
> corruption at that time, the reason was well explained. But after
> commit 1f7319c74275 ("zram: partial IO refactoring"), partial IO uses
> alloc_page() instead of kmalloc to allocate a page, so we can bring
> back the optimization.
> 
> commit 80ba4caf8ba9 ("zram: use copy_page for full page copy") brings
> back partial optimization, missed one point in zram_write_page().
> optimize the full page copying in zram_write_page() with copy_page()
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/block/zram/zram_drv.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 3acd7006ad2c..4b2b5098062f 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1478,11 +1478,13 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
>  
>  	src = zstrm->buffer;
> -	if (comp_len == PAGE_SIZE)
> +	if (comp_len == PAGE_SIZE) {
>  		src = kmap_local_page(page);
> -	memcpy(dst, src, comp_len);
> -	if (comp_len == PAGE_SIZE)
> +		copy_page(dst, src);
>  		kunmap_local(src);
> +	} else {
> +		memcpy(dst, src, comp_len);
> +	}

I know this is pre-existing code, but why do we need to kmap
for comp_len == PAGE_SIZE and not for the other cases?  Something
feels really obsfucated here.

