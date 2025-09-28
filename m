Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E6134BA2F;
	Sun, 28 Sep 2025 01:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759024512; cv=none; b=N4JDMS3KWC3Ms4e1J8yZihehEVBp8K55Zgc93KcvDdznzGrLyK6M4JwLdFEjblgoQo7vd2KhrXX8dTHjYK1mGGhnn9eaFPc1r4w1me9hei2/Y5QTbrXzSN9EqDe9sSDlm8FmGcrXDp3UDcEaZRw0JfuC8Xg1dpv+iyE7Bgy6cbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759024512; c=relaxed/simple;
	bh=UBzLjl9vOPHrj7GG7OTDMyD7mSfz4kT2+wUORsW4WWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hfqyMfPhgAL9FbTO74TB4W9WjXwzhdvigcKW/1EYLWNC3nbvTKfiuahDmCYbs2L8mGhHTXqIgMO1znvr7HQiqpvKcAJHFougA85SeiwPNyacRZ0/chmJV0Ju4WwIE/nVJyAshKRdkZE874c+EcA98EWPY7N99h3Hp4Hjru+rPqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fte0LGGj; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fte0LGGj"
Received: from canpmsgout02.his.huawei.com (unknown [172.19.92.185])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cZ6nq55tCzvX0R;
	Sun, 28 Sep 2025 09:54:39 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6lauux70eaWDW7h1PqrB3OC0l1L9tFQolPMqG7s1gzI=;
	b=fte0LGGj9CbyBhu79Eg1UHtRzWJiMDZOP1F21N8uPcDZ7RNmIOGDHBWw8fR1b+OvdmIIer6dA
	33FRnFicSdjPMCRugKpHeXfd86YPftV0TAQr4zu5rNjj2mu1t2ee8Pqlouth32VL8JZhqc1TSNn
	wnRHZISe4SeXMOMQkb9V36I=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cZ6nZ0Gb8zcZyF;
	Sun, 28 Sep 2025 09:54:26 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id B6F4014027A;
	Sun, 28 Sep 2025 09:54:52 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 28 Sep 2025 09:54:52 +0800
Message-ID: <342f5e80-40a6-0fd3-7ac2-9b4dcd5461d6@huawei.com>
Date: Sun, 28 Sep 2025 09:54:51 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] loop: fix backing file reference leak on validation error
To: Li Chen <me@linux.beauty>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250926121231.32549-1-me@linux.beauty>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <20250926121231.32549-1-me@linux.beauty>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2025/9/26 20:12, Li Chen 写道:
> loop_change_fd() and loop_configure() call loop_check_backing_file()
> to validate the new backing file. If validation fails, the reference
> acquired by fget() was not dropped, leaking a file reference.
> 
> Fix this by calling fput(file) before returning the error.
> 
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>

You'd better add a fix tag:

Fixes: f5c84eff634b ("loop: Add sanity check for read/write_iter")

Or this patch looks good to me.

Reviewed-by: Yang Erkun <yangerkun@huawei.com>

> ---
>   drivers/block/loop.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 053a086d547e..94ec7f747f36 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -551,8 +551,10 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>   		return -EBADF;
>   
>   	error = loop_check_backing_file(file);
> -	if (error)
> +	if (error) {
> +		fput(file);
>   		return error;
> +	}
>   
>   	/* suppress uevents while reconfiguring the device */
>   	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
> @@ -993,8 +995,10 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>   		return -EBADF;
>   
>   	error = loop_check_backing_file(file);
> -	if (error)
> +	if (error) {
> +		fput(file);
>   		return error;
> +	}
>   
>   	is_loop = is_loop_device(file);
>   
