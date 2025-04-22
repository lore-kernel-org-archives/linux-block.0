Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA80230BDA
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303940; cv=none; b=A1kXUCbD6RmAgfVcLtqdmZ3hHsLZ9Fv/9RmCX+wIkSV5nCQOJk0P/Z2Fjpxk6era/VNz5lVMBqcWH9q6D2taBCxgcwWI9LOZieeiP125qrJ9a5OX16EpUGMvuQciHzvaCWyt+gJFezxizetmg56BBWpxW1kPIe9aggrLN6mJXAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303940; c=relaxed/simple;
	bh=8cwSXAYxLv/OnY1puMmHLbCsg1rgxJhwmY19Iyzm3hA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ShUkEyRyiUs4Dvno5UPYITWDMELRrYvX591NcCFvJGR8DLOK/E1JaqlQs7xhJa48IqCHStqIazxgL9D6N5XliYJsR3OduhuPvhkiKuv5Q8JhgZq4A5dxa9i2YZPLs5PFNTGcWicFaaZTfVOUaaNxgDh6hFLqggvYQh1mortns+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZhXcj02kdz4f3jY6
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 14:38:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E49C11A0359
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 14:38:52 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2B8OQdoo5_ZKA--.14877S3;
	Tue, 22 Apr 2025 14:38:52 +0800 (CST)
Subject: Re: [PATCH 2/5] brd: remove the sector variable in brd_submit_bio
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250421072641.1311040-1-hch@lst.de>
 <20250421072641.1311040-3-hch@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a182d757-14e5-0382-df5a-a644d4467c62@huaweicloud.com>
Date: Tue, 22 Apr 2025 14:38:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250421072641.1311040-3-hch@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnC2B8OQdoo5_ZKA--.14877S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1rAF1xtr15Cr1UuF4kJFb_yoW8Xw48pF
	srC34xArZxJF45K3WUXasxW3s5KayDXa4j9FWUZ3yfWF4Skrnrt3WUAFy0vF15CFyfCrsx
	AFyvy3y8Jrs5urUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
> The bvec iter iterates over the sector already, no need to duplicate the
> work.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/brd.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
LGTM

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index c8974bc545fb..91eb50126355 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -241,12 +241,12 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
>   static void brd_submit_bio(struct bio *bio)
>   {
>   	struct brd_device *brd = bio->bi_bdev->bd_disk->private_data;
> -	sector_t sector = bio->bi_iter.bi_sector;
>   	struct bio_vec bvec;
>   	struct bvec_iter iter;
>   
>   	if (unlikely(op_is_discard(bio->bi_opf))) {
> -		brd_do_discard(brd, sector, bio->bi_iter.bi_size);
> +		brd_do_discard(brd, bio->bi_iter.bi_sector,
> +				bio->bi_iter.bi_size);
>   		bio_endio(bio);
>   		return;
>   	}
> @@ -254,7 +254,7 @@ static void brd_submit_bio(struct bio *bio)
>   	bio_for_each_segment(bvec, bio, iter) {
>   		int err;
>   
> -		err = brd_rw_bvec(brd, &bvec, bio->bi_opf, sector);
> +		err = brd_rw_bvec(brd, &bvec, bio->bi_opf, iter.bi_sector);
>   		if (err) {
>   			if (err == -ENOMEM && bio->bi_opf & REQ_NOWAIT) {
>   				bio_wouldblock_error(bio);
> @@ -263,7 +263,6 @@ static void brd_submit_bio(struct bio *bio)
>   			bio_io_error(bio);
>   			return;
>   		}
> -		sector += bvec.bv_len >> SECTOR_SHIFT;
>   	}
>   
>   	bio_endio(bio);
> 

