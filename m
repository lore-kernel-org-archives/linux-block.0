Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E5DAD5A
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 02:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753323666; cv=none; b=HsK5ME7LM+ss4AfteP51dTRY6k7vGiCQ1Udg+R4nYZB1UTKqmI58T5VO9cxpOlgJXhLILlK4YX5YjqXCrSuNBn8LBEgPKoooHxUy/aCb0SgQVhx3pC3mjiOu5n2gI9CaRzc1zWKfwQOxTPD6SJ5r3vztrM0X5bf4DbPRWFSnXz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753323666; c=relaxed/simple;
	bh=tkgpg8MSWSzZvxrKtua+rgURRsq5o5jkHPEpAPiu+Ts=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Id367aKOtYPWjnl7K/MskRW2NOEvjJpYP5QYOCWTBDm5B4x/ts0hdsd2u2hKrFUIdz3Nmd9uQkxQ2rr7HFv24zQoqapZGFkGHCRvlgfpk96PxHA1skaZqdExvn+yTGbl8ZBOz1PaMDZlP4FqQITX6ypyIFT9FAZuKUiBKDOi+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bnZVl0GdHzYQtnc
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 10:21:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BC4E31A14CF
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 10:21:01 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3chOMmIFo82QnBQ--.49523S3;
	Thu, 24 Jul 2025 10:21:01 +0800 (CST)
Subject: Re: [PATCHv3 2/2] null_blk: prevent submit and poll queues update for
 shared tagset
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, dlemoal@kernel.org, yukuai1@huaweicloud.com, hare@suse.de,
 ming.lei@redhat.com, axboe@kernel.dk, johannes.thumshirn@wdc.com,
 gjoyce@ibm.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250723134442.1283664-1-nilay@linux.ibm.com>
 <20250723134442.1283664-3-nilay@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <35dda68a-a5c8-02ae-c42d-c498fef6ba8d@huaweicloud.com>
Date: Thu, 24 Jul 2025 10:21:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250723134442.1283664-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3chOMmIFo82QnBQ--.49523S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1DAryxKryDKw4kZryDtrb_yoW5CF4kpF
	WkGa13Cw18JFsxW3srJF1DWF13Z3WkArWfWFyxJ3yFkwnFvryF934DA3Z8Xw48JFykCay8
	ZF1UZr4DtF4UWFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/07/23 21:43, Nilay Shroff Ð´µÀ:
> When a user updates the number of submit or poll queues on a null_blk
> device, the block layer creates new hardware queues (hctxs). However, if
> the device is using a shared tagset, null_blk does not map any software
> queues (ctx) to the newly created hctx (via null_map_queues()), resulting
> in those hardware queues being left unused for I/O. This behavior is
> misleading, as the user may expect the new queues to be functional, even
> though they are effectively ignored. To avoid this confusion and potential
> misconfiguration:
> - Reject runtime updates to submit_queues or poll_queues via sysfs when
>    the device uses a shared tagset by returning -EINVAL.
> - During configuration validation (prior to powering on the device), reset
>    submit_queues and poll_queues to the module parameters (g_submit_queues
>    and g_poll_queues) if the shared tagset is enabled.
> 
> This ensures consistent behavior and avoids creating unused hardware queues
> (hctxs) due to ineffective runtime queue updates.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/block/null_blk/main.c | 32 ++++++++++++++++++++++----------
>   1 file changed, 22 insertions(+), 10 deletions(-)
> 

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Thanks

> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index aa163ae9b2aa..57bd9aeb9aaf 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -388,6 +388,12 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
>   	if (!submit_queues)
>   		return -EINVAL;
>   
> +	/*
> +	 * Cannot update queues with shared tagset.
> +	 */
> +	if (dev->shared_tags)
> +		return -EINVAL;
> +
>   	/*
>   	 * Make sure that null_init_hctx() does not access nullb->queues[] past
>   	 * the end of that array.
> @@ -1884,18 +1890,24 @@ static int null_validate_conf(struct nullb_device *dev)
>   		dev->queue_mode = NULL_Q_MQ;
>   	}
>   
> -	if (dev->use_per_node_hctx) {
> -		if (dev->submit_queues != nr_online_nodes)
> -			dev->submit_queues = nr_online_nodes;
> -	} else if (dev->submit_queues > nr_cpu_ids)
> -		dev->submit_queues = nr_cpu_ids;
> -	else if (dev->submit_queues == 0)
> -		dev->submit_queues = 1;
> -	dev->prev_submit_queues = dev->submit_queues;
> -
> -	if (dev->poll_queues > g_poll_queues)
> +	if (dev->shared_tags) {
> +		dev->submit_queues = g_submit_queues;
>   		dev->poll_queues = g_poll_queues;
> +	} else {
> +		if (dev->use_per_node_hctx) {
> +			if (dev->submit_queues != nr_online_nodes)
> +				dev->submit_queues = nr_online_nodes;
> +		} else if (dev->submit_queues > nr_cpu_ids)
> +			dev->submit_queues = nr_cpu_ids;
> +		else if (dev->submit_queues == 0)
> +			dev->submit_queues = 1;
> +
> +		if (dev->poll_queues > g_poll_queues)
> +			dev->poll_queues = g_poll_queues;
> +	}
> +	dev->prev_submit_queues = dev->submit_queues;
>   	dev->prev_poll_queues = dev->poll_queues;
> +
>   	dev->irqmode = min_t(unsigned int, dev->irqmode, NULL_IRQ_TIMER);
>   
>   	/* Do memory allocation, so set blocking */
> 

