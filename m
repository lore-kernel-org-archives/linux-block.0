Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E31487F4
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611411; cv=none; b=bpg3GoeUAwIPHhoMGya3xYkJ0B6HgDl9UDyOS+w+pvtUPJD96pPTXJBq5RDdXm9/5940ZKyZLkA5m/mniZPglYwz0Pdg/WpbAIq3XUGnFnYT2+dMHCDnJSV0Uou6pwoefkVHD+sZJnGyfE/svRt8DIzXKQx9CGCmNAtFAcZMe/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611411; c=relaxed/simple;
	bh=97nvyW7RLlqg0aa1o2mXvyH8W6MnnynAR1pEOnZHPRo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GDjzArYujiVrAU0hfAPx5Js3dc7UkmNwK83WClf0oDt17YsXQHg9Hm20r53XjGo0nTr3mfFEoRpeu5l+J1N6IY9xVp35A6w4r/S8emBrYFsVeoBTD6smf26aeVbxq04/OS4D+GZGRWo+F2T+4L/qp8ppsvOSqSy9FvvwKdyc6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4Zsr8h6lGFzYQtGH
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 17:49:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4A7FD1A1ADA
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 17:49:56 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHq1_CLBtoaB7GLg--.46525S3;
	Wed, 07 May 2025 17:49:56 +0800 (CST)
Subject: Re: [PATCH v2] brd: avoid extra xarray lookups on first write
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: yukuai1@huaweicloud.com, kbusch@kernel.org, linux-block@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250507060700.3929430-1-hch@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <01dae38c-e378-b049-823b-ef62497f4783@huaweicloud.com>
Date: Wed, 7 May 2025 17:49:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250507060700.3929430-1-hch@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHq1_CLBtoaB7GLg--.46525S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1UGF4rXr4UJw1Dur13CFg_yoWrGr4xpF
	ZxWFyxArZ8AryfG3W7XFZ09Fy5uw1IqayIga43Jw1rur1fZrnFya4DCw10g345CryDCrWk
	AF4YyryDCrs0qa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	nxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/05/07 14:06, Christoph Hellwig Ð´µÀ:
> The xarray can return the previous entry at a location.  Use this
> fact to simplify the brd code when there is no existing page at
> a location.  This also slighly improves the handling of racy
> discards as we now always have a page under RCU protection by the
> time we are ready to copy the data.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Changes since v1:
>   - use __xa_cmpxchg
>   - keep the brd_insert_page helper
> 
>   drivers/block/brd.c | 76 ++++++++++++++++++++-------------------------
>   1 file changed, 33 insertions(+), 43 deletions(-)
> 
LGRM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index a3725673cf16..b1be6c510372 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -54,32 +54,33 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
>   /*
>    * Insert a new page for a given sector, if one does not already exist.
>    */
> -static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
> +static struct page *brd_insert_page(struct brd_device *brd, sector_t sector,
> +		blk_opf_t opf)
> +	__releases(rcu)
> +	__acquires(rcu)
>   {
> -	pgoff_t idx = sector >> PAGE_SECTORS_SHIFT;
> -	struct page *page;
> -	int ret = 0;
> -
> -	page = brd_lookup_page(brd, sector);
> -	if (page)
> -		return 0;
> +	gfp_t gfp = (opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO;
> +	struct page *page, *ret;
>   
> +	rcu_read_unlock();
>   	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
> +	rcu_read_lock();
>   	if (!page)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>   
>   	xa_lock(&brd->brd_pages);
> -	ret = __xa_insert(&brd->brd_pages, idx, page, gfp);
> -	if (!ret)
> -		brd->brd_nr_pages++;
> -	xa_unlock(&brd->brd_pages);
> -
> -	if (ret < 0) {
> +	ret = __xa_cmpxchg(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT, NULL,
> +			page, gfp);
> +	if (ret) {
> +		xa_unlock(&brd->brd_pages);
>   		__free_page(page);
> -		if (ret == -EBUSY)
> -			ret = 0;
> +		if (xa_is_err(ret))
> +			return ERR_PTR(xa_err(ret));
> +		return ret;
>   	}
> -	return ret;
> +	brd->brd_nr_pages++;
> +	xa_unlock(&brd->brd_pages);
> +	return page;
>   }
>   
>   /*
> @@ -114,36 +115,17 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
>   
>   	bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
>   
> -	if (op_is_write(opf)) {
> -		int err;
> -
> -		/*
> -		 * Must use NOIO because we don't want to recurse back into the
> -		 * block or filesystem layers from page reclaim.
> -		 */
> -		err = brd_insert_page(brd, sector,
> -				(opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO);
> -		if (err) {
> -			if (err == -ENOMEM && (opf & REQ_NOWAIT))
> -				bio_wouldblock_error(bio);
> -			else
> -				bio_io_error(bio);
> -			return false;
> -		}
> -	}
> -
>   	rcu_read_lock();
>   	page = brd_lookup_page(brd, sector);
> +	if (!page && op_is_write(opf)) {
> +		page = brd_insert_page(brd, sector, opf);
> +		if (IS_ERR(page))
> +			goto out_error;
> +	}
>   
>   	kaddr = bvec_kmap_local(&bv);
>   	if (op_is_write(opf)) {
> -		/*
> -		 * Page can be removed by concurrent discard, it's fine to skip
> -		 * the write and user will read zero data if page does not
> -		 * exist.
> -		 */
> -		if (page)
> -			memcpy_to_page(page, offset, kaddr, bv.bv_len);
> +		memcpy_to_page(page, offset, kaddr, bv.bv_len);
>   	} else {
>   		if (page)
>   			memcpy_from_page(kaddr, page, offset, bv.bv_len);
> @@ -155,6 +137,14 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
>   
>   	bio_advance_iter_single(bio, &bio->bi_iter, bv.bv_len);
>   	return true;
> +
> +out_error:
> +	rcu_read_unlock();
> +	if (PTR_ERR(page) == -ENOMEM && (opf & REQ_NOWAIT))
> +		bio_wouldblock_error(bio);
> +	else
> +		bio_io_error(bio);
> +	return false;
>   }
>   
>   static void brd_free_one_page(struct rcu_head *head)
> 

