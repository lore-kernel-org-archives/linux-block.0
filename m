Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9AE25D52B
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320692; cv=none; b=DF3zmiLbaf24UpszPJ4EqdAZU6tqMs4yClMQyUllyqhyEMCCcygQdk2EKRIboGyUCiuwnmpOJb42Vm8BDPd5RaPs1lOwGMrfc8Iw9ihYVBINTGF/Bg2TjckYJ/yA0HvJy2HT926tsvD927PjNJEjZMrfEQX60q9+pEt7IVneHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320692; c=relaxed/simple;
	bh=kCiPYPWrTERMKQHNnEQYHBU7XIcO/iKI7BDA8BOib1g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=L7iHvqhGDyE+yHa09ZQGpVy0wdIhpgFJNMcbmuxwBy69E/U6PguNYbn2CgXIsqiAHqiUNAZ10MFE4FWvygZ3YJkAtMKskN/zz0oBBiNiMHjCQsWYJnY0DNOB7VyXi7OTe4ILgrKvlYpgAEBpObBHWFlfBGLtCAls1CEQO8B5WHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zhfpt1GL9z4f3jdK
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 19:17:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1C0401A0359
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 19:18:06 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgA3m1_tegdoy+XsKA--.27221S3;
	Tue, 22 Apr 2025 19:18:05 +0800 (CST)
Subject: Re: [PATCH 5/5] brd: use memcpy_{to,from]_page in brd_rw_bvec
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250421072641.1311040-1-hch@lst.de>
 <20250421072641.1311040-6-hch@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1f084ee5-098f-6588-5f13-068240682c8b@huaweicloud.com>
Date: Tue, 22 Apr 2025 19:18:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250421072641.1311040-6-hch@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3m1_tegdoy+XsKA--.27221S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWrAr43tF4fZrWftFy5Arb_yoW5Aw4xpF
	sxX3yfJrZxJFWrWw17Ja9xCa4rC3s7KFW8KFW5Zw1Fgwn3u3ZFkF1kJFyIq345Gr98CF4S
	kw1qyFWkCrs5ZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbhvttUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/04/21 15:26, Christoph Hellwig Ð´µÀ:
> Use the proper helpers to copy to/from potential highmem pages, which
> do a local instead of atomic kmap underneath, and perform
> flush_dcache_page where needed.  This also simplifies the code so much
> that the separate read write helpers are not required any more.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/brd.c | 57 ++++++++++-----------------------------------
>   1 file changed, 12 insertions(+), 45 deletions(-)
> 
LGTM

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 580b2d8ce99c..79e96221f887 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -99,43 +99,6 @@ static void brd_free_pages(struct brd_device *brd)
>   	xa_destroy(&brd->brd_pages);
>   }
>   
> -/*
> - * Copy n bytes from src to the brd starting at sector. Does not sleep.
> - */
> -static void copy_to_brd(struct brd_device *brd, const void *src,
> -			sector_t sector, size_t n)
> -{
> -	struct page *page;
> -	void *dst;
> -	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
> -
> -	page = brd_lookup_page(brd, sector);
> -	BUG_ON(!page);
> -
> -	dst = kmap_atomic(page);
> -	memcpy(dst + offset, src, n);
> -	kunmap_atomic(dst);
> -}
> -
> -/*
> - * Copy n bytes to dst from the brd starting at sector. Does not sleep.
> - */
> -static void copy_from_brd(void *dst, struct brd_device *brd,
> -			sector_t sector, size_t n)
> -{
> -	struct page *page;
> -	void *src;
> -	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
> -
> -	page = brd_lookup_page(brd, sector);
> -	if (page) {
> -		src = kmap_atomic(page);
> -		memcpy(dst, src + offset, n);
> -		kunmap_atomic(src);
> -	} else
> -		memset(dst, 0, n);
> -}
> -
>   /*
>    * Process a single segment.  The segment is capped to not cross page boundaries
>    * in both the bio and the brd backing memory.
> @@ -146,7 +109,8 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
>   	sector_t sector = bio->bi_iter.bi_sector;
>   	u32 offset = (sector & (PAGE_SECTORS - 1)) << SECTOR_SHIFT;
>   	blk_opf_t opf = bio->bi_opf;
> -	void *mem;
> +	struct page *page;
> +	void *kaddr;
>   
>   	bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
>   
> @@ -168,15 +132,18 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
>   		}
>   	}
>   
> -	mem = bvec_kmap_local(&bv);
> -	if (!op_is_write(opf)) {
> -		copy_from_brd(mem, brd, sector, bv.bv_len);
> -		flush_dcache_page(bv.bv_page);
> +	page = brd_lookup_page(brd, sector);
> +
> +	kaddr = bvec_kmap_local(&bv);
> +	if (op_is_write(opf)) {
> +		BUG_ON(!page);
> +		memcpy_to_page(page, offset, kaddr, bv.bv_len);
> +	} else if (page) {
> +		memcpy_from_page(kaddr, page, offset, bv.bv_len);
>   	} else {
> -		flush_dcache_page(bv.bv_page);
> -		copy_to_brd(brd, mem, sector, bv.bv_len);
> +		memset(kaddr, 0, bv.bv_len);
>   	}
> -	kunmap_local(mem);
> +	kunmap_local(kaddr);
>   
>   	bio_advance_iter_single(bio, &bio->bi_iter, bv.bv_len);
>   	return true;
> 

