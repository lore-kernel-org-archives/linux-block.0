Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302919C553;
	Sat, 28 Jun 2025 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751073810; cv=none; b=iOipGgXzQJfugHTS4E6QUFZwFliDUr+MH/A36h3RkkKdT95lAsQj9GPDn3R7KKNgublV7Ju1iV+M4fUWpTPHBGxOXzmM6JNSyZ4uc+vCxyCETmPLZn/8E402azR//NT9nkDGGt3TkPECNFJPTWkZPI0PH35HUtn6Xa626/bcfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751073810; c=relaxed/simple;
	bh=vvDN3ExG/Hj5cCKi4XY4+aSRUw0sMAb+Jk0kBDQH6v8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Rw2vIRDww8S+/I4W+rhpU5fy+0m2g6DBywDO6zJJhkBZLuVsb0wCAeWP8ItBSYG2ljLDH2iU1usw+6S7z0Zp7dJCidQDpwnmnMG4SBeP1+xb2cQDPNmJBRMRZdrAdAjY5UcWerzQg7Ff4fvjzpqRM09nO7LkFlOeXZDys7Ct+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bTZSG4T8QzKHLwN;
	Sat, 28 Jun 2025 09:23:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0474F1A13BB;
	Sat, 28 Jun 2025 09:23:25 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB3218LRF9oLSh+Qw--.8505S3;
	Sat, 28 Jun 2025 09:23:24 +0800 (CST)
Subject: Re: [PATCH] brd: fix leeping function called from invalid context in
 brd_insert_page()
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250628011459.832760-1-yukuai1@huaweicloud.com>
 <20250628011459.832760-2-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5b62eaba-1075-83ca-85b3-7ec1b291c1c7@huaweicloud.com>
Date: Sat, 28 Jun 2025 09:23:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250628011459.832760-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3218LRF9oLSh+Qw--.8505S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4kur13ZFykKFyUJw4ktFb_yoW8XF43pF
	4j9Fy5CryYkry2k3W7u3WDCF1rGa95W3y0kF1Yqw15urW3ArnI9ry8K345X3Z8GFW7AFs8
	ZFs0qr95ArWDZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Sorry that I somehow send this patch twice. Please ignore the redundant
one.

Thanks,
Kuai

ÔÚ 2025/06/28 9:14, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> __xa_cmpxchg() is called with rcu_read_lock(), and it will allocated
> memory if necessary.
> 
> Fix the problem by moving rcu_read_lock() after __xa_cmpxchg, meanwhile,
> it still should be held before xa_unlock(), prevent returned page to be
> freed by concurrent discard.
> 
> Fixes: bbcacab2e8ee ("brd: avoid extra xarray lookups on first write")
> Reported-by: syzbot+ea4c8fd177a47338881a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/685ec4c9.a00a0220.129264.000c.GAE@google.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/block/brd.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index b1be6c510372..0c2eabe14af3 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -64,13 +64,15 @@ static struct page *brd_insert_page(struct brd_device *brd, sector_t sector,
>   
>   	rcu_read_unlock();
>   	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
> -	rcu_read_lock();
> -	if (!page)
> +	if (!page) {
> +		rcu_read_lock();
>   		return ERR_PTR(-ENOMEM);
> +	}
>   
>   	xa_lock(&brd->brd_pages);
>   	ret = __xa_cmpxchg(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT, NULL,
>   			page, gfp);
> +	rcu_read_lock();
>   	if (ret) {
>   		xa_unlock(&brd->brd_pages);
>   		__free_page(page);
> 

