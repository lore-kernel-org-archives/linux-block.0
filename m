Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A690F2EFD98;
	Fri, 25 Jul 2025 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465624; cv=none; b=SEXE+CRBeuesSHVet3BqF6aR/vl0y+NK1CJeum+vLkxTyI0t/N5+tBZFBjdOBT8cg3yLPDZam0XY5cIZVukPeN69JeP1ukK7pTpQQnR7IO6faXr9WbwvbOuTqov5c3iVuZUrsG908iNGStyklUqW8SnnEyNSLdC0I8s9xDQoRvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465624; c=relaxed/simple;
	bh=1W6zleCtArLTe9hdYn50/LtRqMpq5z8txkrpYLZe7y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSqh2K0zDEAcn1/URnYoOYIhSzgm/V0SyNjJRimsMHIlyqEK2xhg86PJbjmEW2oiEJkCD4Z81K9Uh2wBAembxInOUhSVZMA2FEHfC1B1G/0Y3ax90OBHiI7l2ZIPzTg1Z4Tpg6czkVmTinnhUUsC2aRYf6j6p2SXztc+S0xl2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clwxhrUj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clwxhrUj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B466C4CEE7;
	Fri, 25 Jul 2025 17:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753465624;
	bh=1W6zleCtArLTe9hdYn50/LtRqMpq5z8txkrpYLZe7y0=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=clwxhrUjZtI25IKuGbeE9ssglevOZKtXT7CfByUOE64r/9zSxgMcsZxaplGSfRdTc
	 5qKHVSxvBrUAsW5iHF/VPZOQa6nJ0hCH3B9IVGFhRSZiKBYuGgHdmtICPRUtBmuMpD
	 nRSMSHGacXrB6Ht1qrPuj+aiP9ufh2rOFHG4uv+nNHLRffbZ+sev7DO4x8nL7v1gmI
	 bLGYncM07V497YatisD28ooAsuUoodjagm9nylsG+6XIuV5rGYjNi0tkglwnHeof3b
	 lsGn1e+Kphu+Nsfrtn4DPYGsHoBRynzR4EPCsYa+Dd2TDrq9whoovS9Um4EnHPH2OW
	 M0QF0odxti9nw==
Message-ID: <d3265e82-3ddb-4396-b1f7-4c69d4b9b7f6@kernel.org>
Date: Sat, 26 Jul 2025 01:46:58 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@kernel.org
Subject: Re: [PATCH 1/3] blk-ioc: add a new helper ioc_lookup_icq_rcu()
To: Jan Kara <jack@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250725070547.3953398-1-yukuai1@huaweicloud.com>
 <20250725070547.3953398-2-yukuai1@huaweicloud.com>
 <3653febf-0c36-48ca-9d51-7cf93e5b25f1@kernel.org>
 <3up6wgkarspq7zo34pe72zd5a5lygdo2sokbstxc63fajrl3gw@tpk3ihmc7k7l>
Content-Language: en-US
From: Yu Kuai <yukuai@kernel.org>
In-Reply-To: <3up6wgkarspq7zo34pe72zd5a5lygdo2sokbstxc63fajrl3gw@tpk3ihmc7k7l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2025/7/25 20:03, Jan Kara 写道:
> On Fri 25-07-25 19:21:06, Damien Le Moal wrote:
>> On 7/25/25 16:05, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> ioc_lookup_icq() is used by bfq to lookup bfqq from IO path, the helper
>>> have to be protected by queue_lock, which is too heavy. Hence add a new
>>> helper that is lookless, this is safe because both request_queue and ioc
>>> can be pinged by IO that is still issuing.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   block/blk-ioc.c | 34 ++++++++++++++++++++++++++++++++++
>>>   block/blk.h     |  1 +
>>>   2 files changed, 35 insertions(+)
>>>
>>> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
>>> index ce82770c72ab..4945b48dfdb6 100644
>>> --- a/block/blk-ioc.c
>>> +++ b/block/blk-ioc.c
>>> @@ -343,6 +343,40 @@ struct io_cq *ioc_lookup_icq(struct request_queue *q)
>>>   }
>>>   EXPORT_SYMBOL(ioc_lookup_icq);
>>>   
>>> +/**
>>> + * ioc_lookup_icq_rcu - lookup io_cq from ioc in io path
>>> + * @q: the associated request_queue
>>> + *
>>> + * Look up io_cq associated with @ioc - @q pair from @ioc. Must be called from
>>> + * io issue path, either return NULL if current issue io to @q for the first
>>> + * time, or return a valid icq.
>>> + */
>>> +struct io_cq *ioc_lookup_icq_rcu(struct request_queue *q)
>>> +{
>>> +	struct io_context *ioc = current->io_context;
>>> +	struct io_cq *icq;
>>> +
>>> +	WARN_ON_ONCE(percpu_ref_is_zero(&q->q_usage_counter));
>> I do not think this is necessary.
This is used to indicate this is from IO issue path, I can remove it.
>>> +
>>> +	if (!ioc)
>>> +		return NULL;
>>> +
>>> +	icq = rcu_dereference(ioc->icq_hint);
>>> +	if (icq && icq->q == q)
>>> +		return icq;
>>> +
>>> +	icq = radix_tree_lookup(&ioc->icq_tree, q->id);
>>> +	if (!icq)
>>> +		return NULL;
>>> +
>>> +	if (WARN_ON_ONCE(icq->q != q))
>>> +		return NULL;
>>> +
>>> +	rcu_assign_pointer(ioc->icq_hint, icq);
>>> +	return icq;
>>> +}
>>> +EXPORT_SYMBOL(ioc_lookup_icq_rcu);
>> Patch 2 calls this function with the rcu_read_lock() held. Why not move that rcu
>> read lock here inside this function ? That is how ioc_lookup_icq() was doing
>> things, with code that is more compact than this.
>>
>> And since ioc_lookup_icq() was already using RCU, it seems that the only change
>> you need is to remove the "lockdep_assert_held(&q->queue_lock);" from that
>> function to endup with the same above functionality. So why all the churn ?
> Yes, I agree, just dropping the assert and updating callers should be fine.
Yes, this is much simpler.
>> Another question is: is it safe to call radix_tree_lookup() without any lock
>> held ? What if this races with a radix tree insertion ? (I may be wrong here as
>> I am not familiar with that code).
> Yes, radix_tree_lookup() is fine to call with just rcu protection.

The insertion is protected by queue_lock, and look up is fine with rcu 
protection.

Thanks,
Kuai

>
> 								Honza

