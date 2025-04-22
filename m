Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCBE221289
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320225; cv=none; b=LkSztosAPpSjM0O/7Ia0/lpJ6lHRC5ZgK1DePfNKrFCTkST6b0hKmLBjECzQTdwGaqQ694SoBFW5+/ZHFdiKlNnwrOYcR0Zb9yxos7artHWDKxuisRTgEbF/jtt20c5WOlfWhPOzwx2yj8BkIz5ktenF01jRcfRVQSoNZa4NMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320225; c=relaxed/simple;
	bh=u9X5G22mbOuh3IoP54m8RydIdZO+lHSPRqJInzvWJpc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jjyWy1K1x7vpg3Fxy0gX3zJaGJJsqwDqzUNZJJuebhTIbd96rnK83kD80R5XqXObFgz41RtZ3e9llEVZCVE6jnBmqDjgjmnkwAFf+JuxoX2HxgqFXy/a4owstTSf6R+V4uYiflyKeKfZDETTGxaezP7+WqEARAp5L5d7yyacvEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zhfds5qgbz4f3jdK
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 19:09:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B89681A06D7
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 19:10:17 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl8YeQdo6lvsKA--.14977S3;
	Tue, 22 Apr 2025 19:10:17 +0800 (CST)
Subject: Re: [PATCH 4/5] brd: split I/O at page boundaries
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250421072641.1311040-1-hch@lst.de>
 <20250421072641.1311040-5-hch@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <65d83da5-c2af-99bf-fa39-26f94e77c180@huaweicloud.com>
Date: Tue, 22 Apr 2025 19:10:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250421072641.1311040-5-hch@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKl8YeQdo6lvsKA--.14977S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr1fuFWrKF1fWw1ftr48tFb_yoW7Cw1fpF
	Z3A3yfArZ8Jr1rt3ZrWFZ5ua4F93s7Jay8XrWrC3WrWrn3uwnrtF18AFyIq3W5CrWUCFs3
	AFZayrWDCrs5JwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUjuHq7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/04/21 15:26, Christoph Hellwig Ð´µÀ:
> A lot of complexity in brd stems from the fact that it tries to handle
> I/O spanning two backing pages.  Instead limit the size of a single
> bvec iteration so that it never crosses a page boundary and remove all
> the now unneeded code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/brd.c | 116 +++++++++++++-------------------------------
>   1 file changed, 34 insertions(+), 82 deletions(-)
> 
LGTM

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 0c70d29379f1..580b2d8ce99c 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -99,27 +99,6 @@ static void brd_free_pages(struct brd_device *brd)
>   	xa_destroy(&brd->brd_pages);
>   }
>   
> -/*
> - * copy_to_brd_setup must be called before copy_to_brd. It may sleep.
> - */
> -static int copy_to_brd_setup(struct brd_device *brd, sector_t sector, size_t n,
> -			     gfp_t gfp)
> -{
> -	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
> -	size_t copy;
> -	int ret;
> -
> -	copy = min_t(size_t, n, PAGE_SIZE - offset);
> -	ret = brd_insert_page(brd, sector, gfp);
> -	if (ret)
> -		return ret;
> -	if (copy < n) {
> -		sector += copy >> SECTOR_SHIFT;
> -		ret = brd_insert_page(brd, sector, gfp);
> -	}
> -	return ret;
> -}
> -
>   /*
>    * Copy n bytes from src to the brd starting at sector. Does not sleep.
>    */
> @@ -129,27 +108,13 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
>   	struct page *page;
>   	void *dst;
>   	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
> -	size_t copy;
>   
> -	copy = min_t(size_t, n, PAGE_SIZE - offset);
>   	page = brd_lookup_page(brd, sector);
>   	BUG_ON(!page);
>   
>   	dst = kmap_atomic(page);
> -	memcpy(dst + offset, src, copy);
> +	memcpy(dst + offset, src, n);
>   	kunmap_atomic(dst);
> -
> -	if (copy < n) {
> -		src += copy;
> -		sector += copy >> SECTOR_SHIFT;
> -		copy = n - copy;
> -		page = brd_lookup_page(brd, sector);
> -		BUG_ON(!page);
> -
> -		dst = kmap_atomic(page);
> -		memcpy(dst, src, copy);
> -		kunmap_atomic(dst);
> -	}
>   }
>   
>   /*
> @@ -161,62 +126,60 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
>   	struct page *page;
>   	void *src;
>   	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
> -	size_t copy;
>   
> -	copy = min_t(size_t, n, PAGE_SIZE - offset);
>   	page = brd_lookup_page(brd, sector);
>   	if (page) {
>   		src = kmap_atomic(page);
> -		memcpy(dst, src + offset, copy);
> +		memcpy(dst, src + offset, n);
>   		kunmap_atomic(src);
>   	} else
> -		memset(dst, 0, copy);
> -
> -	if (copy < n) {
> -		dst += copy;
> -		sector += copy >> SECTOR_SHIFT;
> -		copy = n - copy;
> -		page = brd_lookup_page(brd, sector);
> -		if (page) {
> -			src = kmap_atomic(page);
> -			memcpy(dst, src, copy);
> -			kunmap_atomic(src);
> -		} else
> -			memset(dst, 0, copy);
> -	}
> +		memset(dst, 0, n);
>   }
>   
>   /*
> - * Process a single bvec of a bio.
> + * Process a single segment.  The segment is capped to not cross page boundaries
> + * in both the bio and the brd backing memory.
>    */
> -static int brd_rw_bvec(struct brd_device *brd, struct bio_vec *bv,
> -		blk_opf_t opf, sector_t sector)
> +static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
>   {
> +	struct bio_vec bv = bio_iter_iovec(bio, bio->bi_iter);
> +	sector_t sector = bio->bi_iter.bi_sector;
> +	u32 offset = (sector & (PAGE_SECTORS - 1)) << SECTOR_SHIFT;
> +	blk_opf_t opf = bio->bi_opf;
>   	void *mem;
>   
> +	bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
> +
>   	if (op_is_write(opf)) {
> +		int err;
> +
>   		/*
>   		 * Must use NOIO because we don't want to recurse back into the
>   		 * block or filesystem layers from page reclaim.
>   		 */
> -		gfp_t gfp = opf & REQ_NOWAIT ? GFP_NOWAIT : GFP_NOIO;
> -		int err;
> -
> -		err = copy_to_brd_setup(brd, sector, bv->bv_len, gfp);
> -		if (err)
> -			return err;
> +		err = brd_insert_page(brd, sector,
> +				(opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO);
> +		if (err) {
> +			if (err == -ENOMEM && (opf & REQ_NOWAIT))
> +				bio_wouldblock_error(bio);
> +			else
> +				bio_io_error(bio);
> +			return false;
> +		}
>   	}
>   
> -	mem = bvec_kmap_local(bv);
> +	mem = bvec_kmap_local(&bv);
>   	if (!op_is_write(opf)) {
> -		copy_from_brd(mem, brd, sector, bv->bv_len);
> -		flush_dcache_page(bv->bv_page);
> +		copy_from_brd(mem, brd, sector, bv.bv_len);
> +		flush_dcache_page(bv.bv_page);
>   	} else {
> -		flush_dcache_page(bv->bv_page);
> -		copy_to_brd(brd, mem, sector, bv->bv_len);
> +		flush_dcache_page(bv.bv_page);
> +		copy_to_brd(brd, mem, sector, bv.bv_len);
>   	}
>   	kunmap_local(mem);
> -	return 0;
> +
> +	bio_advance_iter_single(bio, &bio->bi_iter, bv.bv_len);
> +	return true;
>   }
>   
>   static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
> @@ -241,8 +204,6 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
>   static void brd_submit_bio(struct bio *bio)
>   {
>   	struct brd_device *brd = bio->bi_bdev->bd_disk->private_data;
> -	struct bio_vec bvec;
> -	struct bvec_iter iter;
>   
>   	if (unlikely(op_is_discard(bio->bi_opf))) {
>   		brd_do_discard(brd, bio->bi_iter.bi_sector,
> @@ -251,19 +212,10 @@ static void brd_submit_bio(struct bio *bio)
>   		return;
>   	}
>   
> -	bio_for_each_segment(bvec, bio, iter) {
> -		int err;
> -
> -		err = brd_rw_bvec(brd, &bvec, bio->bi_opf, iter.bi_sector);
> -		if (err) {
> -			if (err == -ENOMEM && bio->bi_opf & REQ_NOWAIT) {
> -				bio_wouldblock_error(bio);
> -				return;
> -			}
> -			bio_io_error(bio);
> +	do {
> +		if (!brd_rw_bvec(brd, bio))
>   			return;
> -		}
> -	}
> +	} while (bio->bi_iter.bi_size);
>   
>   	bio_endio(bio);
>   }
> 

