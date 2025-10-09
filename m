Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7826E710;
	Thu,  9 Oct 2025 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760041293; cv=none; b=sR+Nj5ep42TE6MQgjwqsqUUb1Q2l8B/HGRG03ZpwZPNLcx57O4TvEVnEK/lYRopan8Ri0opyC7rvRgUMu8PkVubaRonsGJYnJKroDXXH/SR+uP3LSvNg0l7j6RTzbpFFRBF1zQvorhjfXGi/njdnE5ycch7+K0QrBwYB5RHQ6e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760041293; c=relaxed/simple;
	bh=VN/Ui4smGgyWuuJXBUqmus27UIibImS/ZHmC1ccNmD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXBen3K8TsKAf4IemOXUYZnnFxH83lhYY8OhhcBp4qR2ejzl2ie71bckONtFFM80mpMHWCZlY0/oBbs4xlyZk2kX/BJdMD/g8WUJvV4MKL8Hv1ApzLgBvFZQwR2UOQJm/WHlaSD8mg5WMLs/MdiP7QnrbmskeB4W1he5QGrhcm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWlH9ArZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWlH9ArZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39EAC113D0;
	Thu,  9 Oct 2025 20:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760041292;
	bh=VN/Ui4smGgyWuuJXBUqmus27UIibImS/ZHmC1ccNmD8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LWlH9ArZh5+H8Vx79p2l6eTxzlU/7fIvGE2xjMKuHIWWOttwaFxsJYP62KJhnZS1M
	 1dBJXKctq0NMux7MNWGb8f318nBbtv6aevXd1Gj7NPXtKpGbs2axxV6i5C5Qj1HRMs
	 e6ycqVCT3V7lVrlHek7PIZWxMg3Lt5ywvFA8hqyvJk/qGqQwwFc5dybTB1HqZL5jTS
	 /3gTCuW5i4v8Tt13miJdZwWhV+32K1EnuMOMMoMFDPljJVrGcCSyb3pZgikM4BNE3H
	 jSN0wTaWDCPqurCljxJGkJAu7puX/ezW27pNnHChQhD3njvaowr5RJHmPfKFTCttPR
	 9CK3AQuGFsAiQ==
Message-ID: <bb362d12-b942-48f3-8414-e859cebb8862@kernel.org>
Date: Fri, 10 Oct 2025 05:21:30 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block/mq-deadline: adjust the timeout period of the
 per_prio->dispatch
To: Bart Van Assche <bvanassche@acm.org>, chengkaitao <pilgrimtao@gmail.com>,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chengkaitao <chengkaitao@kylinos.cn>
References: <20251009155253.14611-1-pilgrimtao@gmail.com>
 <db87a85d-e433-4daf-97c7-d5156849db0f@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <db87a85d-e433-4daf-97c7-d5156849db0f@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/10 1:50, Bart Van Assche wrote:
> On 10/9/25 8:52 AM, chengkaitao wrote:
>> On the other hand, the Commit (725f22a1477c) merges the effects of
>> fifo_expire and prio_aging_expire on the same code behavior, creating
>> redundant interactions. To address this, our new patch introduces
>> numerical compensation for {dd->fifo_expire[data_dir]} when adding
>> requests to dispatch lists. To maintain original logic as much as
>> possible while enhancing dispatch list priority, we additionally
>> subtract {dd->prio_aging_expire / 2} from the fifo_time, with default
>> values, {dd->prio_aging_expire / 2} equals {dd->fifo_expire[DD_WRITE]}.
> 
> No assumptions should be made about the relative values of
> dd->prio_aging_expire and dd->fifo_expire[DD_WRITE] since these values
> can be modified via sysfs.
> 
>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>> index 3e741d33142d..fedc66187150 100644
>> --- a/block/mq-deadline.c
>> +++ b/block/mq-deadline.c
>> @@ -659,7 +659,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>   
>>   	if (flags & BLK_MQ_INSERT_AT_HEAD) {
>>   		list_add(&rq->queuelist, &per_prio->dispatch);
>> -		rq->fifo_time = jiffies;
>> +		rq->fifo_time = jiffies + dd->fifo_expire[data_dir]
>> +				- dd->prio_aging_expire / 2;
>>   	} else {
>>   		deadline_add_rq_rb(per_prio, rq);
> 
> Thanks for having added a detailed patch description. Please remove
> "/ 2" from the above patch to make sure that BLK_MQ_INSERT_AT_HEAD
> requests are submitted to the block driver before other requests. This
> is important if a request is requeued. Additionally, a comment should be
> added above the modified line of code that explains the purpose of the
> calculation. How about this untested patch?
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 3e741d33142d..566646591ddd 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -659,7 +659,14 @@ static void dd_insert_request(struct blk_mq_hw_ctx 
> *hctx, struct request *rq,
> 
>   	if (flags & BLK_MQ_INSERT_AT_HEAD) {
>   		list_add(&rq->queuelist, &per_prio->dispatch);
> -		rq->fifo_time = jiffies;
> +		/*
> +		 * started_after() subtracts dd->fifo_expire[data_dir] from
> +		 * rq->fifo_time. Hence, add it here. Subtract
> +		 * dd->prio_aging_expire to ensure that AT HEAD requests are
> +		 * submitted before higher priority requests.
> +		 */
> +		rq->fifo_time = jiffies + dd->fifo_expire[data_dir] -
> +				dd->prio_aging_expire;

There is still something bothering me with this: the request is added to the
dispatch list, and *NOT* to the fifo/sort list. So this should be considered as
a scheduling decision in itself, and __dd_dispatch_request() reflects that as
the first thing it does is pick the requests that are in the dispatch list
already. However, __dd_dispatch_request() also has the check:

		if (started_after(dd, rq, latest_start))
                        return NULL;

for requests that are already in the dispatch list. That is what does not make
sense to me. Why ? There is no comment describing this. And I do not understand
why we should bother with any time for requests that are in the dispatch list
already. These should be sent to the drive first, always.

This patch seems to be fixing a problem that is introduced by the above check.
But why this check ? What am I missing here ?

>   	} else {
>   		deadline_add_rq_rb(per_prio, rq);
> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
