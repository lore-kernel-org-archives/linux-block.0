Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93FD1D6DA9;
	Wed,  3 Sep 2025 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887893; cv=none; b=nQ6KRMTqNgfXjm2IuLJ0dyrgM8MwqGf8d8BMzLMUhwd8WpMhK6WZwADXNUv/CdJrDGgSEvptUpZF5sg4tt25FzNfFEsWTrm44Y5p2+Sbwi+OMWdpmqrWMO5bOp3s+r5WH/W0aWSPVCBZinOwfHCkx8CdcdAGhuLk84LxSAfnL6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887893; c=relaxed/simple;
	bh=2guZtEvZRRqsDYQoh3OzZoqBnT1rV39dxbVBeNeB88Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rKSl1hU3YW01HvOfqdq+4eS5oUQD9zebO2/HKxbR1ZGVq7upg2LUkQLIr2QcPXWqx+mrWmqwRvysO2cIQ5nENEA9w/RUpqa9SK2w9LyM8PbhkUGrgTBRPZQM8ZqePImazT0Li2FTDSRCFpt046pRK/RYU0nK1UYJU+CXxxOpRRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cGwdW2PVCzKHMhG;
	Wed,  3 Sep 2025 16:24:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 392061A0CA2;
	Wed,  3 Sep 2025 16:24:47 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY1N+7doM1TxBA--.52838S3;
	Wed, 03 Sep 2025 16:24:47 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: check policy bit in blk_throtl_activated()
To: Liang Jie <buaajxlj@163.com>, yukuai1@huaweicloud.com
Cc: axboe@kernel.dk, fanggeng@lixiang.com, gj.han@foxmail.com,
 hailan@yukuai.org.cn, hanguangjiang@lixiang.com, liangjie@lixiang.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangchen11@lixiang.com, "yukuai (C)" <yukuai3@huawei.com>
References: <c60c0768-2b1b-a26b-db7d-340fd29ff688@huaweicloud.com>
 <20250903072112.3432190-1-buaajxlj@163.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f17231f5-61a0-8d2d-eef5-f9b838caad34@huaweicloud.com>
Date: Wed, 3 Sep 2025 16:24:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250903072112.3432190-1-buaajxlj@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3wY1N+7doM1TxBA--.52838S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZry7JFWUXw1rAF13KF4xCrg_yoW5CF1DpF
	WUCa4Ykw4UXrZ7J3W2qr10kryF9w4fCw45Jr1rJryfAw1qgr1fZr1UKw15Ca1fZFsaka4U
	Z3Z0qwsxuF1YyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/03 15:21, Liang Jie 写道:
> On Wed, 3 Sep 2025 14:03:37 +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:
> 
>> 在 2025/09/03 10:55, Han Guangjiang 写道:
>>> Hi Kuai,
>>>
>>>> Instead of add checking from hot path, do you consider delaying setting q->td
>>>> until policy is activated from the slow path? I think this is better solution.
>>>
>>> Thank you for your review. You're absolutely right that performance
>>> considerations in the hot path are important.
>>>
>>> We actually considered delaying the setting of q->td until after policy
>>> activation, but we found that q->td is needed by blkcg_activate_policy()
>>> during its execution, so it has to be set before calling
>>> blkcg_activate_policy().
>>
>> That's not hard to bypass, q->td is used to initialze tg->td in
>> throtl_pd_init(), actually you can just remove it, and add a helper
>> tg_to_td() to replace it;
>>
>> struct throtl_data *tg_to_td(struct throtl_grp *tg)
>> {
>> 	return tg_to_blkg(tg)->q->td;
>> }
> 
> Hi Kuai,
> 
> Thanks for the suggestion. Just a quick note: in throtl_pd_init(), q->td is not
> only used to init tg->td, it’s also needed for sq->parent_sq:
> 
>   - sq->parent_sq = &td->service_queue;
> 
> So if we remove tg->td and delay q->td, throtl_pd_init() won’t have a valid td
> to set parent_sq.

Yes, however, this can be fixed very similar:

Set sq->parent_sq to NULL here, and add a helper parent_sq(q, sq):

if (sq->parent_sq)
	return sq->parent_sq;

td_sq = &q->td->service_queue;
return sq == td_sq ? NULL : td_sq;

And sq_to_tg() need to be changed as well. So far, I'm not sure how many
code changes are required this way. We of course want a simple fix for
stable backport, but we definitely still want this kind of fix in future
release.

Thanks,
Kuai

> 
>>
>> Meanwhile, please remove the comment about freeze queue, turns out it
>> can't protect blk_throtl_bio() becasue q_usage_coutner is not grabbed
>> yet while issuing bio.
> 
> You’re right. We’ll remove that comment in patch v2.
> 
> Thanks,
> Liang Jie
> 
>>
>> Thanks,
>> Kuai
>>
>>>
>>> We explored several alternative approaches:
>>>
>>> 1) Adding a dedicated flag like 'throttle_ready' to struct request_queue:
>>>      - Set this flag at the end of blk_throtl_init()
>>>      - Check this flag in blk_throtl_activated() to determine if policy
>>>        loading is complete
>>>      - However, this requires adding a new bool variable to the struct
>>>
>>> 2) Reusing the q->td pointer with low-order bit flags:
>>>      - Use pointer low-order bits to mark initialization completion status
>>>      - This would avoid adding new fields but requires careful handling
>>>        and additional processing
>>>
>>> Given these constraints, we chose the current approach of checking the
>>> policy bit in blk_throtl_activated() as it:
>>> - Doesn't require struct changes
>>> - Provides a clean, atomic check
>>> - Aligns with the existing policy activation mechanism
>>>
>>> We would appreciate your suggestions on how to better handle this
>>> initialization race condition.
>>>
>>> Thanks,
>>> Han Guangjiang
>>>
> 
> .
> 

