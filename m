Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0C228CBC;
	Mon,  1 Sep 2025 03:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698141; cv=none; b=bziYfymXIu/HRI4+/H198O4SP75adowkACFy079+cxaChy+8Gj2nbdPiKhHvdw0gMi88wiIhFDcnjteWEMDdk/D0OASWtzdt/cC8wc9Wyz+4QYQNqlcoSSY8odo5ZsGxngSX7L20pSrqzlboz+yhPIhcNr1sMIBKfC7fCh+qEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698141; c=relaxed/simple;
	bh=D5HsREXXBOlQACsbNPDaG1ZvmpOQAgV+kmk9jVniKU8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mFWkIoZY5RqiARvJnTb4HZkJ8BR8Zpk6thwSlmBRIRG0R9z8riGhFKWNC6IWZyDsJGDTbVJngzsXqt1pVdMc/B7Kvp4wQFC3zcaXUP/t4eu41wNewUgVqoSHzJXlu7hiKrhLFJyPPs9J7CHlACUZZWJByPOweh4wl4YkD1J1rq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cFZSV1lfKzYQvDq;
	Mon,  1 Sep 2025 11:42:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B9DE81A0C05;
	Mon,  1 Sep 2025 11:42:16 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3QY4WFrVoLX31Aw--.57482S3;
	Mon, 01 Sep 2025 11:42:16 +0800 (CST)
Subject: Re: [PATCH v3] brd: use page reference to protect page lifetime
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, houtao1@huawei.com,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250811065628.1829339-1-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f84e1519-812b-ee19-ddb6-6670a02a0c40@huaweicloud.com>
Date: Mon, 1 Sep 2025 11:42:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250811065628.1829339-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3QY4WFrVoLX31Aw--.57482S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4fAr4rtF45tr4Dtr4Utwb_yoWrtw43pF
	WUJa4fA345Jr17Aw13Xwn8uFyFv34Iga1Sg343G3ySkr1fGr9Iy3WUKry0qa15CrWDCrWD
	AFsxtF1DCrZ0q3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Friendly ping ...

ÔÚ 2025/08/11 14:56, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> As discussed [1], hold rcu for copying data from/to page is too heavy,
> it's better to protect page with rcu around for page lookup and then
> grab a reference to prevent page to be freed by discard.
> 
> [1] https://lore.kernel.org/all/eb41cab3-5946-4fe3-a1be-843dd6fca159@kernel.dk/
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> Changes from v2:
>   - move xas_reset() to error path;
>   - remove unnecessary checking xa_is_value();
> Changes from v1:
>   - refer to filemap_get_entry(), use xas_load + xas_reload to fix
>   concurrent problems.
> 
>   drivers/block/brd.c | 75 +++++++++++++++++++++++++++++----------------
>   1 file changed, 48 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 0c2eabe14af3..9778259b30d4 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -44,45 +44,74 @@ struct brd_device {
>   };
>   
>   /*
> - * Look up and return a brd's page for a given sector.
> + * Look up and return a brd's page with reference grabbed for a given sector.
>    */
>   static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
>   {
> -	return xa_load(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
> +	struct page *page;
> +	XA_STATE(xas, &brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
> +
> +	rcu_read_lock();
> +repeat:
> +	page = xas_load(&xas);
> +	if (xas_retry(&xas, page)) {
> +		xas_reset(&xas);
> +		goto repeat;
> +	}
> +
> +	if (!page)
> +		goto out;
> +
> +	if (!get_page_unless_zero(page)) {
> +		xas_reset(&xas);
> +		goto repeat;
> +	}
> +
> +	if (unlikely(page != xas_reload(&xas))) {
> +		put_page(page);
> +		xas_reset(&xas);
> +		goto repeat;
> +	}
> +out:
> +	rcu_read_unlock();
> +
> +	return page;
>   }
>   
>   /*
>    * Insert a new page for a given sector, if one does not already exist.
> + * The returned page will grab reference.
>    */
>   static struct page *brd_insert_page(struct brd_device *brd, sector_t sector,
>   		blk_opf_t opf)
> -	__releases(rcu)
> -	__acquires(rcu)
>   {
>   	gfp_t gfp = (opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO;
>   	struct page *page, *ret;
>   
> -	rcu_read_unlock();
>   	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
> -	if (!page) {
> -		rcu_read_lock();
> +	if (!page)
>   		return ERR_PTR(-ENOMEM);
> -	}
>   
>   	xa_lock(&brd->brd_pages);
>   	ret = __xa_cmpxchg(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT, NULL,
>   			page, gfp);
> -	rcu_read_lock();
> -	if (ret) {
> +	if (!ret) {
> +		brd->brd_nr_pages++;
> +		get_page(page);
> +		xa_unlock(&brd->brd_pages);
> +		return page;
> +	}
> +
> +	if (!xa_is_err(ret)) {
> +		get_page(ret);
>   		xa_unlock(&brd->brd_pages);
> -		__free_page(page);
> -		if (xa_is_err(ret))
> -			return ERR_PTR(xa_err(ret));
> +		put_page(page);
>   		return ret;
>   	}
> -	brd->brd_nr_pages++;
> +
>   	xa_unlock(&brd->brd_pages);
> -	return page;
> +	put_page(page);
> +	return ERR_PTR(xa_err(ret));
>   }
>   
>   /*
> @@ -95,7 +124,7 @@ static void brd_free_pages(struct brd_device *brd)
>   	pgoff_t idx;
>   
>   	xa_for_each(&brd->brd_pages, idx, page) {
> -		__free_page(page);
> +		put_page(page);
>   		cond_resched();
>   	}
>   
> @@ -117,7 +146,6 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
>   
>   	bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
>   
> -	rcu_read_lock();
>   	page = brd_lookup_page(brd, sector);
>   	if (!page && op_is_write(opf)) {
>   		page = brd_insert_page(brd, sector, opf);
> @@ -135,13 +163,13 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
>   			memset(kaddr, 0, bv.bv_len);
>   	}
>   	kunmap_local(kaddr);
> -	rcu_read_unlock();
>   
>   	bio_advance_iter_single(bio, &bio->bi_iter, bv.bv_len);
> +	if (page)
> +		put_page(page);
>   	return true;
>   
>   out_error:
> -	rcu_read_unlock();
>   	if (PTR_ERR(page) == -ENOMEM && (opf & REQ_NOWAIT))
>   		bio_wouldblock_error(bio);
>   	else
> @@ -149,13 +177,6 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
>   	return false;
>   }
>   
> -static void brd_free_one_page(struct rcu_head *head)
> -{
> -	struct page *page = container_of(head, struct page, rcu_head);
> -
> -	__free_page(page);
> -}
> -
>   static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
>   {
>   	sector_t aligned_sector = round_up(sector, PAGE_SECTORS);
> @@ -170,7 +191,7 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
>   	while (aligned_sector < aligned_end && aligned_sector < rd_size * 2) {
>   		page = __xa_erase(&brd->brd_pages, aligned_sector >> PAGE_SECTORS_SHIFT);
>   		if (page) {
> -			call_rcu(&page->rcu_head, brd_free_one_page);
> +			put_page(page);
>   			brd->brd_nr_pages--;
>   		}
>   		aligned_sector += PAGE_SECTORS;
> 

