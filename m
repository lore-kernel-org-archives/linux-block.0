Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABFB1917E3;
	Wed,  3 Sep 2025 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756879431; cv=none; b=ZHi25CU1tAGw0Un/zw56fSvS5eB6JIrxgb1boq4aUqfUu0SkTzy6We3japKfMPYinCvzDGT70fwDDSF1qPLbZiNFear8wnAiw7ReOzfS/kKJMSJ2gClQUORiFT9k4/3S/lldYupwlln5oBJg2hq21ics/nqgvsVmWviHedVBoL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756879431; c=relaxed/simple;
	bh=N4aqk3+8LdSUEkzUECf2gt7krm9tL9aKk3P7IY/FuHI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VG+0dJFvd8isrsoe3yhNdZ24llQ4CTnAeIKg6tROFdQwpdPsdPa6vGf5cv3/yVDvw2JGViCQChDRVUe/ahkdmUtUtDW/Xcemto6/dGhJ4Jz1Hn8NUY+D+09VJx6WG54KU1Rc+4hj7f0Rh/KiDUSs93BhZAOEXf2YM+ArmfwOPYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cGsVg1g8WzKHMW5;
	Wed,  3 Sep 2025 14:03:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1EB6C1A1280;
	Wed,  3 Sep 2025 14:03:39 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY452rdoBwrmBA--.49888S3;
	Wed, 03 Sep 2025 14:03:38 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: check policy bit in blk_throtl_activated()
To: Han Guangjiang <gj.han@foxmail.com>, hailan@yukuai.org.cn
Cc: axboe@kernel.dk, fanggeng@lixiang.com, hanguangjiang@lixiang.com,
 liangjie@lixiang.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangchen11@lixiang.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <59464ad0-856c-4ec3-b5b7-e7799c337a84@yukuai.org.cn>
 <tencent_9DE422078550681A63BE8AC4C6DE7CB29809@qq.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c60c0768-2b1b-a26b-db7d-340fd29ff688@huaweicloud.com>
Date: Wed, 3 Sep 2025 14:03:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <tencent_9DE422078550681A63BE8AC4C6DE7CB29809@qq.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnMY452rdoBwrmBA--.49888S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urWUAry8Jw4DXry3ZF17Awb_yoW8ZrW5pa
	yUW34Ykw4kZrZ7Ja12yr48CrWS9w1kCw43JryrGrn3Aw1qgwnYvw1UK3yrCayfXFsY9a47
	Z3Wqq398GF1YyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/09/03 10:55, Han Guangjiang Ð´µÀ:
> Hi Kuai,
> 
>> Instead of add checking from hot path, do you consider delaying setting q->td
>> until policy is activated from the slow path? I think this is better solution.
> 
> Thank you for your review. You're absolutely right that performance
> considerations in the hot path are important.
> 
> We actually considered delaying the setting of q->td until after policy
> activation, but we found that q->td is needed by blkcg_activate_policy()
> during its execution, so it has to be set before calling
> blkcg_activate_policy().

That's not hard to bypass, q->td is used to initialze tg->td in
throtl_pd_init(), actually you can just remove it, and add a helper
tg_to_td() to replace it;

struct throtl_data *tg_to_td(struct throtl_grp *tg)
{
	return tg_to_blkg(tg)->q->td;
}

Meanwhile, please remove the comment about freeze queue, turns out it
can't protect blk_throtl_bio() becasue q_usage_coutner is not grabbed
yet while issuing bio.

Thanks,
Kuai

> 
> We explored several alternative approaches:
> 
> 1) Adding a dedicated flag like 'throttle_ready' to struct request_queue:
>     - Set this flag at the end of blk_throtl_init()
>     - Check this flag in blk_throtl_activated() to determine if policy
>       loading is complete
>     - However, this requires adding a new bool variable to the struct
> 
> 2) Reusing the q->td pointer with low-order bit flags:
>     - Use pointer low-order bits to mark initialization completion status
>     - This would avoid adding new fields but requires careful handling
>       and additional processing
> 
> Given these constraints, we chose the current approach of checking the
> policy bit in blk_throtl_activated() as it:
> - Doesn't require struct changes
> - Provides a clean, atomic check
> - Aligns with the existing policy activation mechanism
> 
> We would appreciate your suggestions on how to better handle this
> initialization race condition.
> 
> Thanks,
> Han Guangjiang
> 
> 
> 
> .
> 

