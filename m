Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E92BD02;
	Wed,  8 Jul 2026 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501900; cv=none; b=lUgFS0RzuLhWAa/DaXPJW4SytTucQ7s5pZEnXu7tcN1xDiJ8j/aLQURCAJ6hL18s/aRoFWG2Uycnfhbsca+sXhdU8fOUuZi0U9zeKzXfrBBI4W7wy02gNaMstvJyw0ENmowSTtgp1ciGtpEfoPswHyomSVPY+84Bk20au5wNjbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501900; c=relaxed/simple;
	bh=3Mj9ReisUkiWd28eZaa77m8bphJYgoK+YwIFjKRvfZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6hUJN4A7jNRVs527weQq8l4gZ6G/aIMfB0/YNj9bpr7+dsWCVrLvcqvwyJ1FySWGUWAepcSvRsAKBGHfMPLZ6IgvcKDciT654IwafXYhH+EsjoM64NbzkpSj7uYJA8PtI+WSU+gab7gu3pKxzTvOvhTocxAB7AnElD/Ys5Tv6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gwC5D3mlfzYQtmJ;
	Wed,  8 Jul 2026 17:11:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4DDC14060A;
	Wed,  8 Jul 2026 17:11:33 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgAHZHBDFE5qt_7rAQ--.45104S3;
	Wed, 08 Jul 2026 17:11:33 +0800 (CST)
Message-ID: <c863e032-33bd-4977-bd07-afcfa583fa75@huaweicloud.com>
Date: Wed, 8 Jul 2026 17:11:31 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 5/6] null_blk: serialize configfs attribute stores with
 device setup
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, bvanassche@acm.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com
References: <20260708073917.2172392-1-wozizhi@huaweicloud.com>
 <20260708073917.2172392-6-wozizhi@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20260708073917.2172392-6-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAHZHBDFE5qt_7rAQ--.45104S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWrurW3uFyDuF4kJw43Wrg_yoW5urW5pF
	Z5Gay3C348KF4fX3yDCw1DuF9xZ3W8Z343KrWfJ348C347Zrn3ZryDtF45Xr48Ja98Ca1f
	ZanrWFZYyayUXFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2026/7/8 15:39, Zizhi Wo 写道:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> The NULLB_DEVICE_ATTR _store takes no lock: apply_fn attributes
> (submit_queues, poll_queues) get dev->NAME written again after apply_fn
> returns, outside its lock; APPLY=NULL attributes are entirely lockless.
> configfs only serializes stores per-open-file, so concurrent stores on
> separate fds race.
> 
> For apply_fn attributes the loser can overwrite dev->NAME after the
> winner's apply_fn reconfigured hardware, mismatching dev->submit_queues
> with the live queue count (null_map_queues WARN_ON_ONCE). For APPLY=NULL
> attributes, a store during power_store's null_add_dev() (validates and
> builds the device under "lock" but sets CONFIGURED only afterwards) can
> change a field mid-setup -- e.g. zone_nr_conv pushed above nr_zones after
> clamping, causing out-of-bounds dev->zones[] access.
> 
> Take "lock" in the macro around the apply_fn call, the CONFIGURED test and
> the field write, and move it out of nullb_apply_submit_queues()/
> nullb_apply_poll_queues() so both paths are covered once. This serializes
> stores with power_store's setup and with each other.
> 
> _show still takes no lock; its data races are handled by READ_ONCE/
> WRITE_ONCE in a follow-up.
> 
> Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after an instance has been configured")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   drivers/block/null_blk/main.c | 21 ++++++---------------
>   1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index df85189f0b69..9e0002e4aeec 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -360,13 +360,16 @@ nullb_device_##NAME##_store(struct config_item *item, const char *page,	\
>   	ret = nullb_device_##TYPE##_attr_store(&new_value, page, count);\
>   	if (ret < 0)							\
>   		return ret;						\
> +	mutex_lock(&lock);						\
>   	if (apply_fn)							\
>   		ret = apply_fn(dev, new_value);				\
>   	else if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags)) 	\
>   		ret = -EBUSY;						\
> +	if (!ret)							\

Sorry for the noise. The condition here should be ret >= 0; I'll fix
this in the next version. :(

> +		dev->NAME = new_value;					\
> +	mutex_unlock(&lock);						\
>   	if (ret < 0)							\
>   		return ret;						\
> -	dev->NAME = new_value;						\
>   	return count;							\
>   }									\
>   CONFIGFS_ATTR(nullb_device_, NAME);
> @@ -421,25 +424,13 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
>   static int nullb_apply_submit_queues(struct nullb_device *dev,
>   				     unsigned int submit_queues)
>   {
> -	int ret;
> -
> -	mutex_lock(&lock);
> -	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
> -	mutex_unlock(&lock);
> -
> -	return ret;
> +	return nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
>   }
>   
>   static int nullb_apply_poll_queues(struct nullb_device *dev,
>   				   unsigned int poll_queues)
>   {
> -	int ret;
> -
> -	mutex_lock(&lock);
> -	ret = nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
> -	mutex_unlock(&lock);
> -
> -	return ret;
> +	return nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
>   }
>   
>   NULLB_DEVICE_ATTR(size, ulong, NULL);

