Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2772F2D
	for <linux-block@vger.kernel.org>; Tue, 31 Dec 2024 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735610492; cv=none; b=CjyP3FkMdY1mwvPsQPEywgUtD2bMYwFCoQpoT1c3WrB3t0DqP7RYuno2w0bkpQ5wY6nD2SH7uA6LXPV07yOJl9cTE5ycmh8vWyI1qkrznBP2El0m5NWmzs903fPCWT7c7hJjBQbBZcfMdqwN72ZEIUTIOakvKMzR9gWGTqo9mE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735610492; c=relaxed/simple;
	bh=DZSyisGK9HeNYH1vGjV06lrZ+vOB2/5/cmaYMn3eHj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MW0V6X+TkE+oGA80WVdFtBtKne0zwrHeFqLNBGXAaNd6/NvBF3y47FPk9FBQ1ao3gySdMvm2xWVVpoJyATykbr+5fkSpJXA3etSiLf+tUQ93h5TzGK4Gb+ZEEHz5QW8p9AEAiw6XWGxMN4MlxnSug7/PC68ZAMlIDixnLI9qCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YMbjR61cDz2DjhH;
	Tue, 31 Dec 2024 09:58:35 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 9890E14010D;
	Tue, 31 Dec 2024 10:01:26 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 31 Dec 2024 10:01:25 +0800
Message-ID: <b50a0dd2-cc6e-9bba-5382-e8e1e159e68e@huawei.com>
Date: Tue, 31 Dec 2024 10:01:25 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] block: retry call probe after request_module in
 blk_request_module
To: Yang Erkun <yangerkun@huaweicloud.com>, <axboe@kernel.dk>, <hch@lst.de>
CC: <linux-block@vger.kernel.org>
References: <20241209110435.3670985-1-yangerkun@huaweicloud.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <20241209110435.3670985-1-yangerkun@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100006.china.huawei.com (7.202.181.220)

ping

在 2024/12/9 19:04, Yang Erkun 写道:
> From: Yang Erkun <yangerkun@huawei.com>
> 
> Set kernel config:
> 
>   CONFIG_BLK_DEV_LOOP=m
>   CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
> 
> Do latter:
> 
>   mknod loop0 b 7 0
>   exec 4<> loop0
> 
> Before commit e418de3abcda ("block: switch gendisk lookup to a simple
> xarray"), lookup_gendisk will first use base_probe to load module loop,
> and then the retry will call loop_probe to prepare the loop disk. Finally
> open for this disk will success. However, after this commit, we lose the
> retry logic, and open will fail with ENXIO. Block device autoloading is
> deprecated and will be removed soon, but maybe we should keep open success
> until we really remove it. So, give a retry to fix it.
> 
> Fixes: e418de3abcda ("block: switch gendisk lookup to a simple xarray")
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>   block/genhd.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> v1->v2:
> Rewrite this patch by adding helper blk_probe_dev to make code looks
> more clear.
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 79230c109fca..8a63be374220 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -798,7 +798,7 @@ static ssize_t disk_badblocks_store(struct device *dev,
>   }
>   
>   #ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
> -void blk_request_module(dev_t devt)
> +static bool blk_probe_dev(dev_t devt)
>   {
>   	unsigned int major = MAJOR(devt);
>   	struct blk_major_name **n;
> @@ -808,14 +808,26 @@ void blk_request_module(dev_t devt)
>   		if ((*n)->major == major && (*n)->probe) {
>   			(*n)->probe(devt);
>   			mutex_unlock(&major_names_lock);
> -			return;
> +			return true;
>   		}
>   	}
>   	mutex_unlock(&major_names_lock);
> +	return false;
> +}
> +
> +void blk_request_module(dev_t devt)
> +{
> +	int error;
> +
> +	if (blk_probe_dev(devt))
> +		return;
>   
> -	if (request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt)) > 0)
> -		/* Make old-style 2.4 aliases work */
> -		request_module("block-major-%d", MAJOR(devt));
> +	error = request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt));
> +	/* Make old-style 2.4 aliases work */
> +	if (error > 0)
> +		error = request_module("block-major-%d", MAJOR(devt));
> +	if (!error)
> +		blk_probe_dev(devt);
>   }
>   #endif /* CONFIG_BLOCK_LEGACY_AUTOLOAD */
>   
