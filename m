Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231B523027C
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 06:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303792; cv=none; b=L6kMWuh/QLhJaav/fsH4bFMo2yQepTvYMkvCQM77NlP2W8pdbUmiGRa4PulKXZUESzNjyTZJYRHktKDjSQHpu8zXNfoXFRyGQ4axD06JWMeo4Ovw1kI4JcyII2ijQCesnnXKQjx7zH6Xq5f4APTGElSE67OZasfKewtehPFoa/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303792; c=relaxed/simple;
	bh=5/yl92Pr8UMCasW/3UoNmxh0gaROuPKmdTT3GmrMrUc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JcC7p87N3kd5ZSVClZAyQmz4glzsyJDSA1qEOF58N4wmBp+LfquDgIz741cdXjocoJrVa4ETDz3/jL2FfRzrpH3NZaBXJsebYVeXOdhBs4pIazyycKgOkC9tu1Ibn1FJAjc13Lhd1w9cs/PIk3osNWkTca4Vxf9BhBVlnyfBIJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZhXYr5JLlz4f3jYH
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 14:36:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A4E871A058E
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 14:36:24 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl_nOAdo4XPZKA--.7433S3;
	Tue, 22 Apr 2025 14:36:24 +0800 (CST)
Subject: Re: [PATCH 1/5] brd; pass a bvec pointer to brd_do_bvec
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250421072641.1311040-1-hch@lst.de>
 <20250421072641.1311040-2-hch@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <261b0310-a3e2-e455-3f60-372e4cd1f7d7@huaweicloud.com>
Date: Tue, 22 Apr 2025 14:36:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250421072641.1311040-2-hch@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl_nOAdo4XPZKA--.7433S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW3JF1DZF47WrWUGry5XFb_yoW5XFyxpa
	9rJ34xJFZ0qrW3J3ZrW3Z0v3WFq342ya409rW3uw1rGr1SkrnFya4UJFyvq3yrCry3CF42
	yFsIyrWUCrs5A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
> Pass the bvec to brd_do_bvec instead of marshalling the information into
> individual arguments.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/brd.c | 35 +++++++++++++----------------------
>   1 file changed, 13 insertions(+), 22 deletions(-)
> 
LGTM

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 292f127cae0a..c8974bc545fb 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -189,12 +189,10 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
>   /*
>    * Process a single bvec of a bio.
>    */
> -static int brd_do_bvec(struct brd_device *brd, struct page *page,
> -			unsigned int len, unsigned int off, blk_opf_t opf,
> -			sector_t sector)
> +static int brd_rw_bvec(struct brd_device *brd, struct bio_vec *bv,
> +		blk_opf_t opf, sector_t sector)
>   {
>   	void *mem;
> -	int err = 0;
>   
>   	if (op_is_write(opf)) {
>   		/*
> @@ -202,24 +200,23 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
>   		 * block or filesystem layers from page reclaim.
>   		 */
>   		gfp_t gfp = opf & REQ_NOWAIT ? GFP_NOWAIT : GFP_NOIO;
> +		int err;
>   
> -		err = copy_to_brd_setup(brd, sector, len, gfp);
> +		err = copy_to_brd_setup(brd, sector, bv->bv_len, gfp);
>   		if (err)
> -			goto out;
> +			return err;
>   	}
>   
> -	mem = kmap_atomic(page);
> +	mem = kmap_atomic(bv->bv_page);
>   	if (!op_is_write(opf)) {
> -		copy_from_brd(mem + off, brd, sector, len);
> -		flush_dcache_page(page);
> +		copy_from_brd(mem + bv->bv_offset, brd, sector, bv->bv_len);
> +		flush_dcache_page(bv->bv_page);
>   	} else {
> -		flush_dcache_page(page);
> -		copy_to_brd(brd, mem + off, sector, len);
> +		flush_dcache_page(bv->bv_page);
> +		copy_to_brd(brd, mem + bv->bv_offset, sector, bv->bv_len);
>   	}
>   	kunmap_atomic(mem);
> -
> -out:
> -	return err;
> +	return 0;
>   }
>   
>   static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
> @@ -255,15 +252,9 @@ static void brd_submit_bio(struct bio *bio)
>   	}
>   
>   	bio_for_each_segment(bvec, bio, iter) {
> -		unsigned int len = bvec.bv_len;
>   		int err;
>   
> -		/* Don't support un-aligned buffer */
> -		WARN_ON_ONCE((bvec.bv_offset & (SECTOR_SIZE - 1)) ||
> -				(len & (SECTOR_SIZE - 1)));
> -
> -		err = brd_do_bvec(brd, bvec.bv_page, len, bvec.bv_offset,
> -				  bio->bi_opf, sector);
> +		err = brd_rw_bvec(brd, &bvec, bio->bi_opf, sector);
>   		if (err) {
>   			if (err == -ENOMEM && bio->bi_opf & REQ_NOWAIT) {
>   				bio_wouldblock_error(bio);
> @@ -272,7 +263,7 @@ static void brd_submit_bio(struct bio *bio)
>   			bio_io_error(bio);
>   			return;
>   		}
> -		sector += len >> SECTOR_SHIFT;
> +		sector += bvec.bv_len >> SECTOR_SHIFT;
>   	}
>   
>   	bio_endio(bio);
> 

