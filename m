Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6471BC3C
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791551; cv=none; b=bcsiPx13efOhUc/LQGfMx5suPJTGfJZcvR+jGCvMEcOTpAWhsiKk1JhWFTRZkR3QmGkcYWQu4RXD3ZM/jOVte1une/PwkPrcAuPGKGyv5IZz+pJ2EinXNdOSMhGfANwwxmfRBskOVHe2a3+T21kNXz2uPxX9YE0QsGYSHNR7DdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791551; c=relaxed/simple;
	bh=VA73YefItL0ChwwUb86OTEsrDPcNSDffKHfTxWSbing=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MpE4QvmohJQTyGLzKyeQWtr3LqZJ2ws79VeLnRmyGRZxEc3VQRHhuYcxuS0DAksiKxnZzDXuB4LOkZoYjWZj19TYH2T8Y/+n3ixZaBe2H+BZjVq7p1Q7RA7givnH99zRI8pWdFbjOcCgyjhwZK2R99HDifhlEfs7Ld7Obs3CjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vnm5n31WTz4f3jLJ
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 14:32:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6307C1A016E
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 14:32:19 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBHxKFRmwtwyNw--.11670S3;
	Mon, 27 May 2024 14:32:19 +0800 (CST)
Subject: Re: [PATCH] null_blk: Fix return value of nullb_device_power_store()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20240527043445.235267-1-dlemoal@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <db98bd1f-9cdf-4a20-0f22-705b5519dfc5@huaweicloud.com>
Date: Mon, 27 May 2024 14:32:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240527043445.235267-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBHxKFRmwtwyNw--.11670S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy3try8ZFyfWw1DKr4xXrb_yoW8Gw1fpF
	s8KF90kry8GF1Uua17Wa1SyFyrCa4xAFWrGryUCryS9ryayr9Ik3sxG3Z8Xa1UJ3yUAr4a
	qFnF9a1rJasxWrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/05/27 12:34, Damien Le Moal Ð´µÀ:
> When powering on a null_blk device that is not already on, the return
> value ret that is initialized to be count is reused to check the return
> value of null_add_dev(), leading to nullb_device_power_store() to return
> null_add_dev() return value (0 on success) instead of "count".
> So make sure to set ret to be equal to count when there are no errors.

Yes, thanks for the patch!

And the reason test did't find this problem is that the "echo" cmd will
write again to the configfs entry, and nullb_device_power_store() will
found the allocated nullb_device.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> Fixes: a2db328b0839 ("null_blk: fix null-ptr-dereference while configuring 'power' and 'submit_queues'")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/block/null_blk/main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index eb023d267369..631dca2e4e84 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -494,6 +494,7 @@ static ssize_t nullb_device_power_store(struct config_item *item,
>   
>   		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
>   		dev->power = newp;
> +		ret = count;
>   	} else if (dev->power && !newp) {
>   		if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
>   			dev->power = newp;
> 

