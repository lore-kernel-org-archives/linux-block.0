Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7DC17A2F7
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304155; cv=none; b=CLqz0i3ArWJOqdsde/xGFuWgQQ8v7lYxhS9V2OYoQAgapXCr2fCfL7gsVdyaZ6o4kFVCFC585lXwGGzK1//EMVk+WYHANif2dbnfuYs0s/bJIQl5zpVAON4X6KsrAXDVJdxhLzJhOrmJkMwcnT7AooJ4rGBvK6wc6/a1V4pGaMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304155; c=relaxed/simple;
	bh=wz1kc53O0s1oniAPlxA+eHPy3hw9c9YUIWrDkvIV7Yk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MoKqetCDEL2h91n5U8d9mrya9fLd/0HhcAriwFtD4ALkJ1acZo1aeD2IzsKNJmSm+S/vmtINJ5kwTvLuvwLEp5dKnK7BcmnKL72dpFp+C6Uzd7SCOzMghWnpX2sNdsX0HGMbwZ1vZqj4zlWHFMYFq3xE0jB4/fQDcWeXAppXq3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZhXhx4lvKz4f3k5x
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 14:42:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 431C81A06D7
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 14:42:28 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXe19TOgdo1t_ZKA--.11993S3;
	Tue, 22 Apr 2025 14:42:28 +0800 (CST)
Subject: Re: [PATCH 3/5] brd: use bvec_kmap_local in brd_do_bvec
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250421072641.1311040-1-hch@lst.de>
 <20250421072641.1311040-4-hch@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a9789e71-b510-3253-a40c-637cf1d708c5@huaweicloud.com>
Date: Tue, 22 Apr 2025 14:42:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250421072641.1311040-4-hch@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe19TOgdo1t_ZKA--.11993S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4ktrW7Jr15CF1rAF45GFg_yoWkCFX_Cw
	12gr4xurWkAFyYk3WFk3s7ZryFga409rsa9r9rtFWfXFy8J3Z2vrWDZan8J34DJr17Ka9x
	Ar9ru3y8X39rXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbb_-PUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/04/21 15:26, Christoph Hellwig Ð´µÀ:
> Use the proper helper to kmap a bvec in brd_do_bvec instead of directly
> accessing the bvec fields and use the deprecated kmap_atomic API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/brd.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
LGTM

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 91eb50126355..0c70d29379f1 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -207,15 +207,15 @@ static int brd_rw_bvec(struct brd_device *brd, struct bio_vec *bv,
>   			return err;
>   	}
>   
> -	mem = kmap_atomic(bv->bv_page);
> +	mem = bvec_kmap_local(bv);
>   	if (!op_is_write(opf)) {
> -		copy_from_brd(mem + bv->bv_offset, brd, sector, bv->bv_len);
> +		copy_from_brd(mem, brd, sector, bv->bv_len);
>   		flush_dcache_page(bv->bv_page);
>   	} else {
>   		flush_dcache_page(bv->bv_page);
> -		copy_to_brd(brd, mem + bv->bv_offset, sector, bv->bv_len);
> +		copy_to_brd(brd, mem, sector, bv->bv_len);
>   	}
> -	kunmap_atomic(mem);
> +	kunmap_local(mem);
>   	return 0;
>   }
>   
> 

