Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403E2C9D
	for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727079113; cv=none; b=el8hbi6B97XwmzZlzPBv4qsQBTdoCSe/sqZJAfTBlGidWYziGvPH6GPhZr0+2X2OnGR9mweakmGSLbrH5094FmuyQknqCPJ2+9bIKRjXDzgffyfmgaVDS8HN2z0eBYesBXfoTKP5ISoOw9DRWIYpcr/kaLwbkpDs2ybRO7F2H6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727079113; c=relaxed/simple;
	bh=03NipRW4JgfJpIuvYtHeujPOzGtHSh+DPzN3ghCSnjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ab6xTr2ciIAT9sF40v8KnzughubNK3L9rOpgFryuxzp8p2IAcvWc2ImtLTskz+CApvPNK6HG16kwechz+cx3fwH2U0t+7CVpBQF3lThqIeqQLpeL/Bod1yom5ZSt4gFt+c+v20CR4lR2tQIljfMLenZyfOzyype0BmqV5ITEwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf4+55a9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf4+55a9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A61C4CEC4;
	Mon, 23 Sep 2024 08:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727079112;
	bh=03NipRW4JgfJpIuvYtHeujPOzGtHSh+DPzN3ghCSnjE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Hf4+55a9hb6l1vd5Y7ougSquhh+5A/NHra9N9hY2o/hDYhI50ONAq80RkwXhoCof/
	 a/dorN8MJMHTgfa4udDbkeiB0TFxCNHaqgXKMAFVkyw8NDJZ9/NvBSa72OuFDSE8hD
	 GmCoi7RaDfWTq/D/I0YgQG7gImJYGU6WcvIxj2bjoJuuygCYhykjySzkO560pnP3OA
	 FhtqCqsB/4HTAGr6w5MqX5vqKDcYQBkqAfuzaYqSUuZXezqaI7cpRAtMiSg8bI7jT0
	 FIsoWzZSonLNBaqvrsU4i+z0LZ1iVDjGbOkOCS3KwFPvUoVMPhfIKPirby9gmNtFpG
	 6w2GQnJ8QuSZw==
Message-ID: <2bb3f66f-e1a7-4c72-8933-4e6aaf373133@kernel.org>
Date: Mon, 23 Sep 2024 10:11:49 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] null_blk: Use u64 to avoid overflow in
 null_alloc_dev()
To: Zhu Yanjun <yanjun.zhu@linux.dev>, yukuai1@huaweicloud.com,
 amishin@t-argos.ru, shli@fb.com, axboe@kernel.dk, hare@suse.de,
 linux-block@vger.kernel.org
References: <e5807f3c-3173-44e6-b222-fc4679be4680@linux.dev>
 <20240922085941.14832-1-yanjun.zhu@linux.dev>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240922085941.14832-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/22 10:59, Zhu Yanjun wrote:
> The member variable size in struct nullb_device is the type
> unsigned long, and the module parameter g_gb is the type int.
> In 32 bit architecture, unsigned long has 32 bit. This
> introduces overflow risks.
> 
> Use the type u64 in struct nullb_device and configfs. This
> can avoid overflow risks.
> 
> Fixes: 2984c8684f96 ("nullb: factor disk parameters")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/block/null_blk/main.c     | 23 +++++++++++++++++++++--
>  drivers/block/null_blk/null_blk.h |  2 +-
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 2f0431e42c49..88c6d6277d09 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -289,6 +289,11 @@ static inline ssize_t nullb_device_ulong_attr_show(unsigned long val,
>  	return snprintf(page, PAGE_SIZE, "%lu\n", val);
>  }
>  
> +static inline ssize_t nullb_device_u64_attr_show(u64 val, char *page)
> +{
> +	return snprintf(page, PAGE_SIZE, "%llu\n", val);
> +}
> +
>  static inline ssize_t nullb_device_bool_attr_show(bool val, char *page)
>  {
>  	return snprintf(page, PAGE_SIZE, "%u\n", val);
> @@ -322,6 +327,20 @@ static ssize_t nullb_device_ulong_attr_store(unsigned long *val,
>  	return count;
>  }
>  
> +static ssize_t nullb_device_u64_attr_store(u64 *val, const char *page,
> +	size_t count)
> +{
> +	int result;
> +	u64 tmp;
> +
> +	result = kstrtou64(page, 0, &tmp);
> +	if (result < 0)
> +		return result;
> +
> +	*val = tmp;
> +	return count;
> +}
> +
>  static ssize_t nullb_device_bool_attr_store(bool *val, const char *page,
>  	size_t count)
>  {
> @@ -438,7 +457,7 @@ static int nullb_apply_poll_queues(struct nullb_device *dev,
>  	return ret;
>  }
>  
> -NULLB_DEVICE_ATTR(size, ulong, NULL);
> +NULLB_DEVICE_ATTR(size, u64, NULL);
>  NULLB_DEVICE_ATTR(completion_nsec, ulong, NULL);
>  NULLB_DEVICE_ATTR(submit_queues, uint, nullb_apply_submit_queues);
>  NULLB_DEVICE_ATTR(poll_queues, uint, nullb_apply_poll_queues);
> @@ -762,7 +781,7 @@ static struct nullb_device *null_alloc_dev(void)
>  		return NULL;
>  	}
>  
> -	dev->size = g_gb * 1024;
> +	dev->size = (u64)g_gb * 1024;

As already commented on your previous version that was casting to an unsigned
long, this is *not* avoiding an overflow. It is only changing the overflow value
to a bigger one. So as suggested before, if you really want to fix this, fix it
properly using check_mul_overflow().


-- 
Damien Le Moal
Western Digital Research

