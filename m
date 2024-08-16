Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34704770FB;
	Fri, 16 Aug 2024 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794347; cv=none; b=eV9VdXGbAQ2FB2IjjtV6vJ23dSQhKMTqMVRP4aQwoWNIbBwgeL8PuvWKMQ44PS34BnxFYRuG0mUw8O5JuBBNNfGRY6yUPfjs2q8HhtysMeFvfQuMKRXweU019gSsD+OatA2+kj14F4Z7mI/K7wWZbO6/yofdefcFLIO+e/ImhqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794347; c=relaxed/simple;
	bh=RUj96vOLJUxSrzLdPOmxH/mLx6zpuSMpeIDggAISr5w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=INyfP0F9TA49gVT7u/szEb1+owh9BHQlbzj2b1Y4WhE537hZ7ewIyjNDxThN8IPBgvgz/5Q/Fl0g7lDJ6VvtLoHDBeLvZhFVRbghqdExLjttSgW6Al3MkqyQHT4kd0uW9du8Gicb1zHFHO0rIs6hH6xoeB82smaNa4Y+hOeVKO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WlYtt6pkqz4f3jrt;
	Fri, 16 Aug 2024 15:45:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CAF8D1A07BA;
	Fri, 16 Aug 2024 15:45:40 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgBHboSjA79m+KVYBw--.62612S3;
	Fri, 16 Aug 2024 15:45:40 +0800 (CST)
Subject: Re: [PATCH] block:added printing when bio->bi_status fails
To: 824731276@qq.com, axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 baiguo@kylinos.cn, "yukuai (C)" <yukuai3@huawei.com>
References: <tencent_9A3345EA79C1EE9DC4464BB576C6A602A105@qq.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <01a0fa06-fa8e-81f8-b93f-f4a81b4dc6e0@huaweicloud.com>
Date: Fri, 16 Aug 2024 15:45:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <tencent_9A3345EA79C1EE9DC4464BB576C6A602A105@qq.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHboSjA79m+KVYBw--.62612S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKw15CF1rGw47XrWUZr15XFb_yoWkKFg_t3
	WxuF97Ga4UKF4fC3WDKF18tr9Ykw1xXr4UWr97XF1DJa43AasrCr1DCrn8urnrGFWxWF45
	Z397Zr129r4IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Upyx
	iUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/08/08 17:54, 824731276@qq.com Ð´µÀ:
> From: baiguo <baiguo@kylinos.cn>
> 
>      When ftrace is not enabled and bio is not OK,
>      the system cannot actively record which disk is abnormal.
>      Add a message record to bio_endio.
> 
> Signed-off-by: baiguo <baiguo@kylinos.cn>
> ---
>   block/bio.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index c4053d496..fb07589c8 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1617,6 +1617,11 @@ void bio_endio(struct bio *bio)
>   		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
>   	}
>   
> +	if (bio->bi_status && bio->bi_bdev)
> +		printk(KERN_ERR "bio: %s status is %d, disk[%d:%d]\n",\
> +				__func__, bio->bi_status, bio->bi_bdev->bd_disk->major,\
> +				bio->bi_bdev->bd_disk->first_minor);

I don't understand why you'll need this, bio_endio() will still be
called for unsupported bio from submit_bio_noacct() when the disk is
fine.

For real disks blk_print_req_error() already print message for failed IO
that are submitted to disk.

Thanks,
Kuai

> +
>   	/*
>   	 * Need to have a real endio function for chained bios, otherwise
>   	 * various corner cases will break (like stacking block devices that
> 

