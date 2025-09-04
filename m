Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FEC2EE614;
	Thu,  4 Sep 2025 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977527; cv=none; b=nuWFIUL1tKH8fgSXDSNFld4UUYGFaz4U80jwqUGIn8KT5GcddvOHKBcdHsE82oPhEJr9suCw2yVuRnsg0QiUVbJBhtPqsJQAIpRRi511guhdi1rdBaXX8hlDxiRu01i6YduyHxGEYYWRzwarb4381txiO1SxyP0UWxVP8fWFvds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977527; c=relaxed/simple;
	bh=61gNEaI3lEFoOXIORqIcW24LJz+TydmIDQrX1wRKd0c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PWyw268V5vRT+CkwhULkLwfGmANQO/AzWg9Ei8JxTc3boArqu7DVve2eZadXFfhayJWVRsxqt21ALEdHkFsilfJE0irpIUxK4S2TPvhc4h+oIDWjjaud40ZFC88pZslH2HAtt9UmnhLk1Fj/iZDIznOjLppDzlyHAFEcYEQOGwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cHYnF4DP1zKHN1N;
	Thu,  4 Sep 2025 17:18:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 818561A0AE4;
	Thu,  4 Sep 2025 17:18:41 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCX4o5vWbloN7lnBQ--.14941S3;
	Thu, 04 Sep 2025 17:18:41 +0800 (CST)
Subject: Re: [PATCH v2] blk-throttle: fix access race during throttle policy
 activation
To: Han Guangjiang <gj.han@foxmail.com>, yukuai1@huaweicloud.com,
 Jens Axboe <axboe@kernel.dk>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: hanguangjiang@lixiang.com, fanggeng@lixiang.com, yangchen11@lixiang.com,
 liangjie@lixiang.com, "yukuai (C)" <yukuai3@huawei.com>
References: <59464ad0-856c-4ec3-b5b7-e7799c337a84@yukuai.org.cn>
 <tencent_2B678DA920124B08854638A6BE68746CCC05@qq.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1f9c674a-9f5b-6c89-0504-1f6985095fa0@huaweicloud.com>
Date: Thu, 4 Sep 2025 17:18:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <tencent_2B678DA920124B08854638A6BE68746CCC05@qq.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCX4o5vWbloN7lnBQ--.14941S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1DXryrCr1rXr1rXryUAwb_yoWrXr17pr
	W3Wr45Kr4ktFsrGw45Jr13ZFWUta1kAFWUA393G343AF1j9w1UJw1UJFW8C34kAFs7WFy7
	AF4DXw40kF1UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/09/04 16:17, Han Guangjiang Ð´µÀ:
> From: Han Guangjiang <hanguangjiang@lixiang.com>
> 
> On repeated cold boots we occasionally hit a NULL pointer crash in
> blk_should_throtl() when throttling is consulted before the throttle
> policy is fully enabled for the queue. Checking only q->td != NULL is
> insufficient during early initialization, so blkg_to_pd() for the
> throttle policy can still return NULL and blkg_to_tg() becomes NULL,
> which later gets dereferenced.
> 
>   Unable to handle kernel NULL pointer dereference
>   at virtual address 0000000000000156
>   ...
>   pc : submit_bio_noacct+0x14c/0x4c8
>   lr : submit_bio_noacct+0x48/0x4c8
>   sp : ffff800087f0b690
>   x29: ffff800087f0b690 x28: 0000000000005f90 x27: ffff00068af393c0
>   x26: 0000000000080000 x25: 000000000002fbc0 x24: ffff000684ddcc70
>   x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
>   x20: 0000000000080000 x19: ffff000684ddcd08 x18: ffffffffffffffff
>   x17: 0000000000000000 x16: ffff80008132a550 x15: 0000ffff98020fff
>   x14: 0000000000000000 x13: 1fffe000d11d7021 x12: ffff000688eb810c
>   x11: ffff00077ec4bb80 x10: ffff000688dcb720 x9 : ffff80008068ef60
>   x8 : 00000a6fb8a86e85 x7 : 000000000000111e x6 : 0000000000000002
>   x5 : 0000000000000246 x4 : 0000000000015cff x3 : 0000000000394500
>   x2 : ffff000682e35e40 x1 : 0000000000364940 x0 : 000000000000001a
>   Call trace:
>    submit_bio_noacct+0x14c/0x4c8
>    verity_map+0x178/0x2c8
>    __map_bio+0x228/0x250
>    dm_submit_bio+0x1c4/0x678
>    __submit_bio+0x170/0x230
>    submit_bio_noacct_nocheck+0x16c/0x388
>    submit_bio_noacct+0x16c/0x4c8
>    submit_bio+0xb4/0x210
>    f2fs_submit_read_bio+0x4c/0xf0
>    f2fs_mpage_readpages+0x3b0/0x5f0
>    f2fs_readahead+0x90/0xe8
> 
> Tighten blk_throtl_activated() to also require that the throttle policy
> bit is set on the queue:
> 
>    return q->td != NULL &&
>           test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);
> 
> This prevents blk_should_throtl() from accessing throttle group state
> until policy data has been attached to blkgs.
> 
> Fixes: a3166c51702b ("blk-throttle: delay initialization until configuration")
> Co-developed-by: Liang Jie <liangjie@lixiang.com>
> Signed-off-by: Liang Jie <liangjie@lixiang.com>
> Signed-off-by: Han Guangjiang <hanguangjiang@lixiang.com>
> ---
> v2:
>   - remove the comment about freeze queue in blk_should_throtl()
>   - Retitle: "blk-throttle: fix access race during throttle policy activation"
> ---
>   block/blk-throttle.h | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index 3b27755bfbff..fbf97c531c48 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -156,7 +156,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk);
>   
>   static inline bool blk_throtl_activated(struct request_queue *q)
>   {
> -	return q->td != NULL;
> +	return q->td != NULL && test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);
>   }

You can just remove the fist checking, p->td must be set if policy is
enabled. And please make blkcg_policy_enabled() inline function in
blk-cgroup.h and use it here.

>   
>   static inline bool blk_should_throtl(struct bio *bio)
> @@ -164,11 +164,6 @@ static inline bool blk_should_throtl(struct bio *bio)
>   	struct throtl_grp *tg;
>   	int rw = bio_data_dir(bio);
>   
> -	/*
> -	 * This is called under bio_queue_enter(), and it's synchronized with
> -	 * the activation of blk-throtl, which is protected by
> -	 * blk_mq_freeze_queue().
> -	 */
>   	if (!blk_throtl_activated(bio->bi_bdev->bd_queue))
>   		return false;
>   
> 

Please also remove the comment in blk_throtl_init() about freeze_queue,
and add comments in both blk_throtl_init() and blk_throtl_bio() about
synchronization.

Thanks,
Kuai

