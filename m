Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7D621ABBB
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 01:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220907; cv=none; b=DHASGaV0wwE8kFmmqCjnJtDnIvkCs4PZCwW11KJ3VJrfAIp0NP9crd9dvqWY96yf6BqXp5haq3uoeMLoMXzT1fBsv+UuIymK6rx7TpLrXKka/Bea5cin7Teato52g2O5NDNqxCA1Peuu1Dk/19tavlb16rstrZbPEKSq3qzZm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220907; c=relaxed/simple;
	bh=iESwTjXCHKR9TA7qRuFxglzkTki0UWNg/EpVBD76+B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PrQp50cjNkqlS3SIg4KjbeH3OOTIQ+WGjD+QaZdlKKvXkGQPqj34gbNzDdglPOlJlJY7E4b4v7/LVM+uw8rz27st19Crc1S8vgeut73cdeSs6fIZxjBht/goA3lbMqbne76JjK/v/D4KKP1k3s6FXTJrQf0OCb2SPowNKNuGWi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNnvCAlc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNnvCAlc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD94C4CEE7;
	Tue,  4 Nov 2025 01:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220907;
	bh=iESwTjXCHKR9TA7qRuFxglzkTki0UWNg/EpVBD76+B8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PNnvCAlc1TZhJ0ygYkwmsRnRqI9tEY8gTXhfBBmIv/EEk09gsgqlrCLXmF1TGTgqh
	 IEq1Jx9LRvRFiIKr2zo0HM0mLu1tP+L4TYbJG9i2cQD0VoaHq12u8kVxlj3iBcB4cQ
	 +KKc34QjhXT21YHiX0i5CYNy8i8wnnyGRkl8ZGjNAQVZaJb3DXI2r01HGrVlYJRXZB
	 7V4v41d++tzA0FQ9oN66JpijS9P6GkE/5fsRIvb8y34pYPz7uppewkxnhE5/Pxh0lU
	 VtJg7CIh6sBWV5WgE0ol6XOZnS9rXB9ypHs7K20ixisxK8oVkEDzHYIUdIykZtLRf+
	 /5Ckxe/gswxfw==
Message-ID: <5d3b6e33-e22d-4388-910d-d58526c6fe6b@kernel.org>
Date: Tue, 4 Nov 2025 10:48:25 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: allow byte aligned memory offsets
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk, hans.holmberg@wdc.com
Cc: Keith Busch <kbusch@kernel.org>
References: <20251103172854.746263-1-kbusch@meta.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251103172854.746263-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 02:28, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Allowing byte aligned memory provides a nice testing ground for
> direct-io. This has an added benefit of a single kmap/kumap per bio
> segment rather than multiple times for each multi-page segment.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Overall looks good to me. A few nits below.

> +static int copy_to_nullb(struct nullb *nullb, void *source, loff_t pos,
> +			 size_t n, bool is_fua)
>  {
>  	size_t temp, count = 0;
>  	unsigned int offset;
>  	struct nullb_page *t_page;
> +	sector_t sector;
>  
>  	while (count < n) {
> +		sector = pos >> SECTOR_SHIFT;
>  		temp = min_t(size_t, nullb->dev->blocksize, n - count);
>  
>  		if (null_cache_active(nullb) && !is_fua)
>  			null_make_cache_space(nullb, PAGE_SIZE);
>  
> -		offset = (sector & SECTOR_MASK) << SECTOR_SHIFT;
> +		offset = pos & (PAGE_SIZE - 1);

Offset is only used in the memcpy_to_page() call below, so maybe move this line
down, or just completely remove that local variable as it has little value ?

>  		t_page = null_insert_page(nullb, sector,
>  			!null_cache_active(nullb) || is_fua);
>  		if (!t_page)
>  			return -ENOSPC;

[...]

> -static int copy_from_nullb(struct nullb *nullb, struct page *dest,
> -	unsigned int off, sector_t sector, size_t n)
> +static int copy_from_nullb(struct nullb *nullb, void *dest, loff_t pos, size_t n)
>  {
>  	size_t temp, count = 0;
>  	unsigned int offset;
> @@ -1171,28 +1173,22 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
>  	while (count < n) {
>  		temp = min_t(size_t, nullb->dev->blocksize, n - count);
>  
> -		offset = (sector & SECTOR_MASK) << SECTOR_SHIFT;
> -		t_page = null_lookup_page(nullb, sector, false,
> +		offset = pos & (PAGE_SIZE - 1);

Same comment here.

> +		t_page = null_lookup_page(nullb, pos >> SECTOR_SHIFT, false,
>  			!null_cache_active(nullb));
>  
>  		if (t_page)
> -			memcpy_page(dest, off + count, t_page->page, offset,
> -				    temp);
> +			memcpy_from_page(dest, t_page->page, offset, temp);
>  		else
> -			memzero_page(dest, off + count, temp);
> +			memset(dest, 0, temp);
>  
> +		dest += temp;
>  		count += temp;
> -		sector += temp >> SECTOR_SHIFT;
> +		pos += temp;
>  	}
>  	return 0;
>  }

[...]

> -static int null_transfer(struct nullb *nullb, struct page *page,
> -	unsigned int len, unsigned int off, bool is_write, sector_t sector,
> +static int null_transfer(struct nullb *nullb, void *p,
> +	unsigned int len, bool is_write, loff_t pos,
>  	bool is_fua)
>  {
>  	struct nullb_device *dev = nullb->dev;
> @@ -1243,23 +1239,26 @@ static int null_transfer(struct nullb *nullb, struct page *page,
>  	int err = 0;
>  
>  	if (!is_write) {
> -		if (dev->zoned)
> +		if (dev->zoned) {
>  			valid_len = null_zone_valid_read_len(nullb,
> -				sector, len);
> +				pos >> SECTOR_SHIFT, len);
> +
> +			if (valid_len && valid_len != len)
> +				valid_len -= (pos & (SECTOR_SIZE - 1));

I do not think you need the outer parenthesis here.

> +		}
>  
>  		if (valid_len) {
> -			err = copy_from_nullb(nullb, page, off,
> -				sector, valid_len);
> -			off += valid_len;
> +			err = copy_from_nullb(nullb, p, pos, valid_len);

Not your fault, but if this fails, we will still do the nullb_fill_pattern()
below which I do not think is correct... ? May be we should have:

			if (err)
				return err;

here ? But not sure if we should still call flush_dcache_page() even on error
though.

> +			p += valid_len;
>  			len -= valid_len;
>  		}
>  
>  		if (len)
> -			nullb_fill_pattern(nullb, page, len, off);
> -		flush_dcache_page(page);
> +			memset(p, 0xff, len);
> +		flush_dcache_page(virt_to_page(p));
>  	} else {
> -		flush_dcache_page(page);
> -		err = copy_to_nullb(nullb, page, off, sector, len, is_fua);
> +		flush_dcache_page(virt_to_page(p));
> +		err = copy_to_nullb(nullb, p, pos, len, is_fua);

Nit: this could be "return copy_to_nullb();"

>  	}
>  
>  	return err;
> @@ -1276,25 +1275,26 @@ static blk_status_t null_handle_data_transfer(struct nullb_cmd *cmd,
>  	struct nullb *nullb = cmd->nq->dev->nullb;
>  	int err = 0;
>  	unsigned int len;
> -	sector_t sector = blk_rq_pos(rq);
> -	unsigned int max_bytes = nr_sectors << SECTOR_SHIFT;
> -	unsigned int transferred_bytes = 0;
> +	loff_t pos = blk_rq_pos(rq) << SECTOR_SHIFT;
> +	unsigned int nr_bytes = nr_sectors << SECTOR_SHIFT;

Overflow potential here ?

>  	struct req_iterator iter;
>  	struct bio_vec bvec;
>  
>  	spin_lock_irq(&nullb->lock);
>  	rq_for_each_segment(bvec, rq, iter) {
> +		void *p = bvec_kmap_local(&bvec);;
> +
>  		len = bvec.bv_len;
> -		if (transferred_bytes + len > max_bytes)
> -			len = max_bytes - transferred_bytes;
> -		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
> -				     op_is_write(req_op(rq)), sector,
> -				     rq->cmd_flags & REQ_FUA);
> +		if (len > nr_bytes)
> +			len = nr_bytes;
> +		err = null_transfer(nullb, p, nr_bytes, op_is_write(req_op(rq)),
> +				    pos, rq->cmd_flags & REQ_FUA);
> +		kunmap_local(p);
>  		if (err)
>  			break;
> -		sector += len >> SECTOR_SHIFT;
> -		transferred_bytes += len;
> -		if (transferred_bytes >= max_bytes)
> +		pos += len;
> +		nr_bytes -= len;
> +		if (!nr_bytes)
>  			break;
>  	}
>  	spin_unlock_irq(&nullb->lock);



-- 
Damien Le Moal
Western Digital Research
