Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A0121506B
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736289; cv=none; b=uGp5jW6wp/ZKxlYWHg1niXLyS4+Q6GBAPFNdpbxdU0P3l1uikLMl+RFCjp/R9fOpa4ayynV0TnG4ohYTe6ObAKqX5cLePJauHfzgSP786BZLqHVVP+z/O4jqTGfux3yZJKCG5b6MWOvLMqlshbEuA2TpzxhyjUQ+4H7T4RjN5pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736289; c=relaxed/simple;
	bh=TUsagDV9/wdNEzVFePJNWVeueDIZb51YRTdUT48YdMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsvqjOIfTrNTTta/mgdc/sIPJ5/XzYwLa9sjXyyOwHvyu8HsIyymDHYW71R8UnXgC96dP/TvPWAdyUbVfEtP/Dg0I0OhQzdL7LNi3kV+td+LIGEOk39b9Sm/c+u7IZQ2obu4nh2r0/JcBIMhZxwxEhMtY3tCZqkk3/vjHuEmbhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y6Gf423wWz4f3jtG
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 17:24:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 754621A0359
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 17:24:42 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgA3XoJYt1Zn_6JjEA--.47156S3;
	Mon, 09 Dec 2024 17:24:42 +0800 (CST)
Message-ID: <bf8f5f52-7ba2-679b-ddf5-efe2b952de9d@huaweicloud.com>
Date: Mon, 9 Dec 2024 17:24:40 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] block: retry call probe after request_module in
 blk_request_module
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, yangerkun@huaweicloud.com
References: <20241209022033.288596-1-yangerkun@huawei.com>
 <20241209081443.GA25304@lst.de>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20241209081443.GA25304@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3XoJYt1Zn_6JjEA--.47156S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF47Cw1kKFy7Wr4xuF1xXwb_yoW8uw48pr
	W7Ja98KrsF9r4DWa1xXFy7X3WF934aqFWSqwn8JFyfXr95K3ySvrW7t3ya93W7Jrn3Xa1x
	Za1UWr98Cay0vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUU
	U==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/12/9 16:14, Christoph Hellwig 写道:
> On Mon, Dec 09, 2024 at 10:20:33AM +0800, Yang Erkun wrote:
>> Before commit e418de3abcda ("block: switch gendisk lookup to a simple
>> xarray"), open loop0 will success. lookup_gendisk will first use
>> base_probe to load module loop, and then the retry will call loop_probe
>> to prepare the loop disk. Finally open for this disk will success.
>> However, after this commit, we lose the retry logic, and open will fail
>> with ENXIO. Block device autoloading is deprecated and will be removed
>> soon, but maybe we should keep open success until we really remove it.
>> So, give a retry to fix it.
> 
> This looks sensible.  But can we clean the logic up a bit by adding
> a helper to make it easier to understand?  Something like the untested
> patch below:

Thanks for the suggest, your advice looks good to me and pass the test, 
I will resend this patch soon!

> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 6fcb09b8371d..654c2cc5d8e5 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -797,7 +797,7 @@ static ssize_t disk_badblocks_store(struct device *dev,
>   }
>   
>   #ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
> -void blk_request_module(dev_t devt)
> +static bool blk_probe_dev(dev_t devt)
>   {
>   	unsigned int major = MAJOR(devt);
>   	struct blk_major_name **n;
> @@ -807,14 +807,26 @@ void blk_request_module(dev_t devt)
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

