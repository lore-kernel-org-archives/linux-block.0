Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70305F4F1;
	Tue,  7 Jul 2026 03:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783395529; cv=none; b=PW0YjaYUr66jML4Gvifx5dD8WTHffEwNEmk9DhvvoiA8InN1eOxODHRHWKCtZ7NjhV9QdPs0uJlEUq43bOYBe9JN8DTGvd7n+NI23lowOajVY27QMLVVyTCxydGejKaJZoOKJNvmJ5jLGQDgKt7zG99VOucJYL/YOJiX4TPTVY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783395529; c=relaxed/simple;
	bh=cNtNVO7MDGb6slHxsV5beSW8YoCnFHIlbuyLEkJQVsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ztqu9Qn/WYaJmK/zdVgdNwHFS+wV1kcLonnTYppmF03XTunYJ1SaAu/JJA/oievbCnVcVxAtFasj4Dd+SA+ImwfJwd2ub88lJ1FJ7139eUE9W8dJfg8sHvTsB4dCl/k2zwLZzQs7Rqjbs79EQ0sdZvE4v1n5+dxJ0uCm/yhjXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gvRlh1jWszYQtgS;
	Tue,  7 Jul 2026 11:38:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E0A594057D;
	Tue,  7 Jul 2026 11:38:42 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCntnLAdExq6ZtXAQ--.61672S3;
	Tue, 07 Jul 2026 11:38:42 +0800 (CST)
Message-ID: <69f7dd0c-f621-4344-9a83-19fd60297ded@huaweicloud.com>
Date: Tue, 7 Jul 2026 11:38:40 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/6] null_blk: don't locklessly overwrite dev state
 after apply_fn
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, linux-block@vger.kernel.org, kch@nvidia.com,
 johannes.thumshirn@wdc.com, kbusch@kernel.org, bvanassche@acm.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com
References: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
 <20260707025542.1299859-6-wozizhi@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20260707025542.1299859-6-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCntnLAdExq6ZtXAQ--.61672S3
X-Coremail-Antispam: 1UD129KBjvJXoWxurW8Jw48XF4kArWxAFy3XFb_yoW5JFWkpF
	Z5GFWYkr18ZF4agwsFqw4UXF95Z3W8XrWY9rW5G348u34DArn3Ar97Ga4Yq3WUJ39xCr4S
	vF4a9FWrJa17WFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2026/7/7 10:55, Zizhi Wo 写道:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> The NULLB_DEVICE_ATTR macro unconditionally writes dev->NAME = new_value
> after apply_fn() returns. For attributes with an apply_fn (submit_queues,
> poll_queues), apply_fn already sets dev->NAME under &nullb_list_lock.
> 
> configfs serializes writes via a per-open-file mutex (buffer->mutex), so
> two threads writing to the same attribute through separate open file
> descriptions run the store callback concurrently. The macro's write is
> redundant and lockless, so a concurrent store's losing thread can overwrite
> the winner's value after apply_fn set it, making dev->submit_queues
> mismatch the hardware state. null_map_queues() then hits a WARN_ON_ONCE and
> falls back to a single queue.
> 
> Restructure the macro so that apply_fn attributes return directly after
> apply_fn, and only non-apply_fn attributes write dev->NAME -- those are
> only changeable while not CONFIGURED and have no live hardware state to
> mismatch.
> 
> Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after an instance has been configured")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   drivers/block/null_blk/main.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index cab51301560e..e7555c47b671 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -360,13 +360,15 @@ nullb_device_##NAME##_store(struct config_item *item, const char *page,	\
>   	ret = nullb_device_##TYPE##_attr_store(&new_value, page, count);\
>   	if (ret < 0)							\
>   		return ret;						\
> -	if (apply_fn)							\
> +	if (apply_fn) {							\
>   		ret = apply_fn(dev, new_value);				\
> -	else if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags)) 	\
> -		ret = -EBUSY;						\
> -	if (ret < 0)							\
> -		return ret;						\
> -	dev->NAME = new_value;						\
> +		if (ret < 0)						\
> +			return ret;					\
> +	} else {							\
> +		if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags))	\
> +			return -EBUSY;					\
> +		dev->NAME = new_value;					\
> +	}								\
>   	return count;							\
>   }									\
>   CONFIGFS_ATTR(nullb_device_, NAME);

Sorry for the noise. I missed that nullb_update_nr_hw_queues() returns
early without storing the value when !dev->nullb, so dropping the
macro's trailing write would silently discard pre-power-on
configuration. I'll add the update logic on the !dev->nullb path in v3.

Any further comments are welcome.

Thanks,
Zizhi Wo



