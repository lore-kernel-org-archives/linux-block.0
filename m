Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34602197A8E;
	Sat,  9 Aug 2025 02:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754706535; cv=none; b=bjTYeeGvYc2q6Talvj+LG7lTtVMFXKTm/PxU0Z9tDi6Y7H2mH0J3OxBM3ca4WNqE+9UFnPCSQO3pqN2gPsrrL4h2VHmXGnx0vGVlmvHuoMT/L7Klnweud6AtTTteRDPMpSshBfPreWFQo+Ws2gnw/rndm+2a8TOY+zPkExVVPbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754706535; c=relaxed/simple;
	bh=gWg6Q9GS2s508llCjhcIyMi4CF9o463J0gly9Pfm8uA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RVl0JSSCCfPdaMvrUdkhAJdhUBw6RoHJzN798IZxQpnKoZdYGt9PK4iC7sVF8+Y1w9ZUq1J/Eyrs2zKYQUY4DXVOqjsYXp3C0XXbB4f6droEHceLh9NKJnYN5PQpV0GZaBLf7tozCHF6TB/faJi1r/flE+W+yh8nlhnky8hzFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bzPwG6PCMzKHMbj;
	Sat,  9 Aug 2025 10:28:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0D6A21A18C7;
	Sat,  9 Aug 2025 10:28:46 +0800 (CST)
Received: from [10.174.177.163] (unknown [10.174.177.163])
	by APP1 (Coremail) with SMTP id cCh0CgCXU69XspZocRQADA--.4939S2;
	Sat, 09 Aug 2025 10:28:43 +0800 (CST)
Subject: Re: [PATCH v2] brd: use page reference to protect page lifetime
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250729090616.1008288-1-yukuai1@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <00473627-a594-dd5c-2100-eaf2df84ff7d@huaweicloud.com>
Date: Sat, 9 Aug 2025 10:28:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250729090616.1008288-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCXU69XspZocRQADA--.4939S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4fur43Jw45XF4rXr45GFg_yoWrKF45pF
	WUJFyxA3y5Jry3tw17X3Z8uFyF934IgayfK343G3ySkr1fGr9Iya4UKry0qw45CrWUCrWU
	AFsxtw4DCrZ0q3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 7/29/2025 5:06 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>
> As discussed [1], hold rcu for copying data from/to page is too heavy.
> it's better to protect page with rcu around for page lookup and then
> grab a reference to prevent page to be freed by discard.
>
> [1] https://lore.kernel.org/all/eb41cab3-5946-4fe3-a1be-843dd6fca159@kernel.dk/
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> Changes from v1:
>  - refer to filemap_get_entry(), use xas_load + xas_reload to fix
>  concurrent problems.
>
>  drivers/block/brd.c | 73 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 0c2eabe14af3..b7a0448ca928 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -44,45 +44,72 @@ struct brd_device {
>  };
>  
>  /*
> - * Look up and return a brd's page for a given sector.
> + * Look up and return a brd's page with reference grabbed for a given sector.
>   */
>  static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
>  {
> -	return xa_load(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
> +	struct page *page;
> +	XA_STATE(xas, &brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
> +
> +	rcu_read_lock();
> +repeat:
> +	xas_reset(&xas);

Is it better to move xas_reset() to the failing branches instead of
adding an extra xas_reset() for the success branch ?
> +	page = xas_load(&xas);
> +	if (xas_retry(&xas, page))
> +		goto repeat;
> +
> +	if (!page || xa_is_value(page)) {
> +		page = NULL;
> +		goto out;
> +	}

brd will not store special value in the xarray, so xa_is_value() is
unnecessary.
> +
> +	if (!get_page_unless_zero(page))
> +		goto repeat;
> +
> +	if (unlikely(page != xas_reload(&xas))) {
> +		put_page(page);
> +		goto repeat;
> +	}
> +out:
> +	rcu_read_unlock();
> +
> +	return page;
>  }
>  
>  /*
>   * Insert a new page for a given sector, if one does not already exist.
> + * The returned page will grab reference.
>   */
>  static struct page *brd_insert_page(struct brd_device *brd, sector_t sector,
>  		blk_opf_t opf)
> -	__releases(rcu)
> -	__acquires(rcu)
>  {
>  	gfp_t gfp = (opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO;
>  	struct page *page, *ret;
>  
> -	rcu_read_unlock();
>  	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
> -	if (!page) {
> -		rcu_read_lock();
> +	if (!page)
>  		return ERR_PTR(-ENOMEM);
> -	}
>  
>  	xa_lock(&brd->brd_pages);
>  	ret = __xa_cmpxchg(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT, NULL,
>  			page, gfp);
> -	rcu_read_lock();
> -	if (ret) {
> +	if (!ret) {
> +		brd->brd_nr_pages++;
> +		get_page(page);
>  		xa_unlock(&brd->brd_pages);
> -		__free_page(page);
> -		if (xa_is_err(ret))
> -			return ERR_PTR(xa_err(ret));
> +		return page;
> +	}
> +
> +	if (!xa_is_err(ret)) {
> +		get_page(ret);
> +		xa_unlock(&brd->brd_pages);
> +		put_page(page);
>  		return ret;
>  	}
> -	brd->brd_nr_pages++;
> +
>  	xa_unlock(&brd->brd_pages);
> -	return page;
> +	put_page(page);
> +	return ERR_PTR(xa_err(ret));
>  }
>  
>  /*
> @@ -95,7 +122,7 @@ static void brd_free_pages(struct brd_device *brd)
>  	pgoff_t idx;
>  
>  	xa_for_each(&brd->brd_pages, idx, page) {
> -		__free_page(page);
> +		put_page(page);
>  		cond_resched();
>  	}
>  
> @@ -117,7 +144,6 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
>  
>  	bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
>  
> -	rcu_read_lock();
>  	page = brd_lookup_page(brd, sector);
>  	if (!page && op_is_write(opf)) {
>  		page = brd_insert_page(brd, sector, opf);
> @@ -135,13 +161,13 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
>  			memset(kaddr, 0, bv.bv_len);
>  	}
>  	kunmap_local(kaddr);
> -	rcu_read_unlock();
>  
>  	bio_advance_iter_single(bio, &bio->bi_iter, bv.bv_len);
> +	if (page)
> +		put_page(page);
>  	return true;
>  
>  out_error:
> -	rcu_read_unlock();
>  	if (PTR_ERR(page) == -ENOMEM && (opf & REQ_NOWAIT))
>  		bio_wouldblock_error(bio);
>  	else
> @@ -149,13 +175,6 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
>  	return false;
>  }
>  
> -static void brd_free_one_page(struct rcu_head *head)
> -{
> -	struct page *page = container_of(head, struct page, rcu_head);
> -
> -	__free_page(page);
> -}
> -
>  static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
>  {
>  	sector_t aligned_sector = round_up(sector, PAGE_SECTORS);
> @@ -170,7 +189,7 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
>  	while (aligned_sector < aligned_end && aligned_sector < rd_size * 2) {
>  		page = __xa_erase(&brd->brd_pages, aligned_sector >> PAGE_SECTORS_SHIFT);
>  		if (page) {
> -			call_rcu(&page->rcu_head, brd_free_one_page);
> +			put_page(page);
>  			brd->brd_nr_pages--;
>  		}
>  		aligned_sector += PAGE_SECTORS;

