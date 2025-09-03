Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617D82D97B8;
	Wed,  3 Sep 2025 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884110; cv=none; b=QVQcHUKD+ZirVbNvCjn1tC9Q8JEzRk9dN71A38cnpIQ3TsWcQzAIazgvcytYzgDXv2JuTobYoYrruyF+XFAMf6QsV9HkxYtcB/cYuCJVITrxgOHz4tr9PawoIJ5zU8tALs4bzTZkYhrZO4xJmq+08+MJbcHoGaCfW05Eo4yTUOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884110; c=relaxed/simple;
	bh=lIad0XRh+CKtul0n/eDT+BWn9ujleiGAkIdBf4PZyv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sz5i2cpYB27NMh9O7pZEtPKmhc1ppEq/CH7VbxHuTw73yGouzO2UfZuZvcc+eqUqhvB7Y2Jl+zk/BgWzeMGuWJfRIXg+WHdi0WodIwioZoG42asLmT8JjiVMeoL0S2UTvv08tFW7ii4d1wXBzOCTcCkGknT+x2301ygeIsXZl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HvdezB8q; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HvdezB8q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=kib6b3BkE4UQ52b83A7vFe86p8T0suLWIALRUAfdtu0=;
	b=HvdezB8qDv/XV1QD8BJyNXvAAznUrx83XdmLpj7k18nxccrE0bu9wr2YMyNf7C
	V7JFXrko+EZd9Xlw5aaY5cCrxmllG2p0UtG/iXhaYzS+W/N6vPquqvkk/zr5SPjk
	6C36NCA5s4Ta5dndsYrHySz2NvvGboapwg5K8fOXT44dI=
Received: from hello.company.local (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXfFNo7LdoZmPwFw--.20150S2;
	Wed, 03 Sep 2025 15:21:13 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: yukuai1@huaweicloud.com
Cc: axboe@kernel.dk,
	fanggeng@lixiang.com,
	gj.han@foxmail.com,
	hailan@yukuai.org.cn,
	hanguangjiang@lixiang.com,
	liangjie@lixiang.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangchen11@lixiang.com,
	yukuai3@huawei.com
Subject: Re: [PATCH] blk-throttle: check policy bit in blk_throtl_activated()
Date: Wed,  3 Sep 2025 15:21:12 +0800
Message-Id: <20250903072112.3432190-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c60c0768-2b1b-a26b-db7d-340fd29ff688@huaweicloud.com>
References: <c60c0768-2b1b-a26b-db7d-340fd29ff688@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXfFNo7LdoZmPwFw--.20150S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw18Zry8CrWUXw4kKw4rZrb_yoW5JF1xpF
	W7u3yjkw4UXrZ7Jay2vr1vkFySvw4xCay5Jr1rJr1fAw1qgwnaqw1UKw15CayfXFsaka4x
	Z3Z0qws8Z3WYyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uov3nUUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/1tbioAi3IGiwUJJggAABsE

On Wed, 3 Sep 2025 14:03:37 +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:

>在 2025/09/03 10:55, Han Guangjiang 写道:
>> Hi Kuai,
>> 
>>> Instead of add checking from hot path, do you consider delaying setting q->td
>>> until policy is activated from the slow path? I think this is better solution.
>> 
>> Thank you for your review. You're absolutely right that performance
>> considerations in the hot path are important.
>> 
>> We actually considered delaying the setting of q->td until after policy
>> activation, but we found that q->td is needed by blkcg_activate_policy()
>> during its execution, so it has to be set before calling
>> blkcg_activate_policy().
>
>That's not hard to bypass, q->td is used to initialze tg->td in
>throtl_pd_init(), actually you can just remove it, and add a helper
>tg_to_td() to replace it;
>
>struct throtl_data *tg_to_td(struct throtl_grp *tg)
>{
>	return tg_to_blkg(tg)->q->td;
>}

Hi Kuai,

Thanks for the suggestion. Just a quick note: in throtl_pd_init(), q->td is not
only used to init tg->td, it’s also needed for sq->parent_sq:

 - sq->parent_sq = &td->service_queue;

So if we remove tg->td and delay q->td, throtl_pd_init() won’t have a valid td
to set parent_sq.

>
>Meanwhile, please remove the comment about freeze queue, turns out it
>can't protect blk_throtl_bio() becasue q_usage_coutner is not grabbed
>yet while issuing bio.

You’re right. We’ll remove that comment in patch v2.

Thanks,
Liang Jie

>
>Thanks,
>Kuai
>
>> 
>> We explored several alternative approaches:
>> 
>> 1) Adding a dedicated flag like 'throttle_ready' to struct request_queue:
>>     - Set this flag at the end of blk_throtl_init()
>>     - Check this flag in blk_throtl_activated() to determine if policy
>>       loading is complete
>>     - However, this requires adding a new bool variable to the struct
>> 
>> 2) Reusing the q->td pointer with low-order bit flags:
>>     - Use pointer low-order bits to mark initialization completion status
>>     - This would avoid adding new fields but requires careful handling
>>       and additional processing
>> 
>> Given these constraints, we chose the current approach of checking the
>> policy bit in blk_throtl_activated() as it:
>> - Doesn't require struct changes
>> - Provides a clean, atomic check
>> - Aligns with the existing policy activation mechanism
>> 
>> We would appreciate your suggestions on how to better handle this
>> initialization race condition.
>> 
>> Thanks,
>> Han Guangjiang
>> 

