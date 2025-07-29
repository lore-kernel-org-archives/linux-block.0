Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C796D26F477;
	Tue, 29 Jul 2025 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775571; cv=none; b=A5O6pUwHEptT49K0+LB/Nm0xfTie4FQNvj4YwGy+M/J/To8dyzgKMzg7mGLfypqCcbX5iV0sDP2qLD5aNSJVbN+RGNTQ+UvQFEXtTfww1E3huA18PNxq8hn8NeXASIJSJ/hDmtKxlNups3l3kLZR8yi88EcfCPgCJ5/WCefuam4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775571; c=relaxed/simple;
	bh=nBY7GcFcyHw/CjzanAYkmLGn1DHCElIl+hoVOunp/98=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tDHOIJxGaGVP7v3NUnFDeshiS8ibet+ncDPBXnN11edpdnxUhHmArNzTOuL4TxZjpHVIWj/NUVzQDzAhDQoTH7evSVX/vWNmihetbAYw/PWB0+Wiev1L78UlqwwFnBKVRGCNpMs/ppjhPhKrep0sEhXNeu3vdk2t87m6jBgndxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4brnd95NKmzYQv7J;
	Tue, 29 Jul 2025 15:52:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6FD5D1A0BC5;
	Tue, 29 Jul 2025 15:52:44 +0800 (CST)
Received: from [10.174.177.163] (unknown [10.174.177.163])
	by APP1 (Coremail) with SMTP id cCh0CgDnoq7GfYhou8tPBw--.15685S2;
	Tue, 29 Jul 2025 15:52:42 +0800 (CST)
Subject: Re: [PATCH] brd: use page reference to protect page lifetime
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250729070915.487189-1-yukuai1@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <51c0afe6-decc-67bd-0336-177a250acb3b@huaweicloud.com>
Date: Tue, 29 Jul 2025 15:52:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250729070915.487189-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDnoq7GfYhou8tPBw--.15685S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4fur43Gr4UJryDCF18AFb_yoWruw17pF
	WUJFyfA3y5Jr4ayw17Xwn8uFyFq34IqayxK34fJ3yFkr1fWr9Iya40y34Sq3W5CrW8CrWD
	AFsxtr1DCrZ0v3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 7/29/2025 3:09 PM, Yu Kuai wrote:
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
>  drivers/block/brd.c | 56 +++++++++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 0c2eabe14af3..ce311d054cab 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -44,45 +44,55 @@ struct brd_device {
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
> +
> +	rcu_read_lock();
> +	page = xa_load(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
> +	if (page)
> +		get_page(page);

get_page_unless_zero() instead ? Er, it seems even with
get_page_unless_zero(), it is not enough, becausethe page may be reused.
Maybe we need to read the brd_pages xarray to ensure the page is still
there.
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

If I understand correctly, the initial ref-count after alloc_page() is 1
instead of 0, so I think the get_page(page) here and get_page(ret) below
is unnecessary and it will lead to memory leak.
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
> @@ -95,7 +105,7 @@ static void brd_free_pages(struct brd_device *brd)
>  	pgoff_t idx;
>  
>  	xa_for_each(&brd->brd_pages, idx, page) {
> -		__free_page(page);
> +		put_page(page);
>  		cond_resched();
>  	}
>  
> @@ -117,7 +127,6 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
>  
>  	bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
>  
> -	rcu_read_lock();
>  	page = brd_lookup_page(brd, sector);
>  	if (!page && op_is_write(opf)) {
>  		page = brd_insert_page(brd, sector, opf);
> @@ -135,13 +144,13 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
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
> @@ -149,13 +158,6 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
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
> @@ -170,7 +172,7 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
>  	while (aligned_sector < aligned_end && aligned_sector < rd_size * 2) {
>  		page = __xa_erase(&brd->brd_pages, aligned_sector >> PAGE_SECTORS_SHIFT);
>  		if (page) {
> -			call_rcu(&page->rcu_head, brd_free_one_page);
> +			put_page(page);
>  			brd->brd_nr_pages--;
>  		}
>  		aligned_sector += PAGE_SECTORS;

