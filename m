Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA913D53B
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752628290; cv=none; b=FpOxKdgfKK6ZjPM41QPPzXjm6Xxbrxn0ZVbzlZWZ4b1Pd2kg4oofwzXSHbUtcoRqzEQu71V8wXI6R/SrUo7AJ54MUpMaPse1bfI9ultNUGoiKcki2gSZ7DAti5ob7VhTJ3Mia8EwLeg8c/76+46U/doSWanRUbJXKlO62AAE5VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752628290; c=relaxed/simple;
	bh=eJl+0a3QwG090klt5oDPAjIiurBOkv4TyReyX0MnpYc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hjuGX1mSKeBdQh4JLCsYAyGOS6j6SChZRcbFgJsia7i6aj//2J8OGuX0u0tYtjf/ceiToE87cH87fS6807qgVYofuojxqMumQVQwN8FA3+UIXy0DI0+s8PBossdnUy0Iv/OzwQ9cs+1/RB5vdednTWb0Gt/NbFDyFzutaGnv2bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bhdL53JtlzYQvZ9
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 09:11:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3AD0D1A1712
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 09:11:24 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3chM6_HZo8VqhAQ--.59592S3;
	Wed, 16 Jul 2025 09:11:24 +0800 (CST)
Subject: Re: [PATCH 1/5] block, bfq: Remove a superfluous cast
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250715165249.1024639-1-bvanassche@acm.org>
 <20250715165249.1024639-2-bvanassche@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a614f086-d44e-8a36-b1b4-40a1611dd666@huaweicloud.com>
Date: Wed, 16 Jul 2025 09:11:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250715165249.1024639-2-bvanassche@acm.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3chM6_HZo8VqhAQ--.59592S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XFWkXr47Zr15Kr1fCr47twb_yoWDJwbEyw
	4ktF48Wrs5JFy0yF1rAF13JayayFW5X3WqgFy5Xrn8Xa1xtanIv3s7Krs8ZFs8Cw4fJF1Y
	qFn0vw13Jr9IgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/07/16 0:52, Bart Van Assche Ð´µÀ:
> sector_t is a synonym for u64 and all architectures define u64 as unsigned
> long long. Hence, it is not necessary to cast type sector_t to unsigned
> long long. Remove a superfluous cast to improve compile-time type checking.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/bfq-iosched.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Thanks
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0cb1e9873aab..74f03bf27d82 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -769,8 +769,7 @@ bfq_rq_pos_tree_lookup(struct bfq_data *bfqd, struct rb_root *root,
>   	if (rb_link)
>   		*rb_link = p;
>   
> -	bfq_log(bfqd, "rq_pos_tree_lookup %llu: returning %d",
> -		(unsigned long long)sector,
> +	bfq_log(bfqd, "rq_pos_tree_lookup %llu: returning %d", sector,
>   		bfqq ? bfqq->pid : 0);
>   
>   	return bfqq;
> .
> 

