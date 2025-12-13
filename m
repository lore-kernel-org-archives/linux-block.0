Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586F2D1319
	for <linux-block@vger.kernel.org>; Sat, 13 Dec 2025 03:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765595933; cv=none; b=fp+QVbIKvhFxHwGWXmMyuXoztm4p1kC54PgZGvicnvwrJYUThaFWC3Ce1qLQGwRny7S/iQDCJrvHX2Kbw9nkOYFqh8OOJM5IR0rY0C7ANJCXpFK5IL7CCOP+9TiT38y5KODuSfS72Baa8vYbyG3pEGYS96t1Gy11E7KvgWriKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765595933; c=relaxed/simple;
	bh=3kXv+7VcyraBqXqXiZcR54b9FYEMfLpS7zTGoLmyYBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBT3sL/YwR4G6a9L9njdoPvf/CfnLfNt4fiM2orSrs7mDuXoQmokqe83XpjOhHoTiOwxS9WW/1yadAFEx4SgQBs5jV/dVK9paFgM1TlDnWNgxl8x4UIz5oleAGhpOMzKZFkoGNLaycljRSPQnJUs0kuhd34AEfahzXs6oIn5V2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFmeaDgs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFmeaDgs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536D1C4CEF7;
	Sat, 13 Dec 2025 03:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765595933;
	bh=3kXv+7VcyraBqXqXiZcR54b9FYEMfLpS7zTGoLmyYBg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TFmeaDgsLFS86Cj9GAedbFqnomYe7xnUGv4KvXb6GfYo/ZxTO4Jb9vtIuYKeL0rxH
	 XnjYNAJnB2ksf6Ertl9yKTUJ/nB5cbmklwQr5lc3ODOAucI2GMCIF53Fj1DMMpUT4Q
	 uh9cZbYQ5iNj6bs+XQWJLymO3C9613c+D2etKnQdRM4gQKOAIaf9lTAuCBDf1wdZaQ
	 szif8EH8na+6Ix8jjoa+FE2PLp8lg94dMf0xf2J0+QSdYeQfyahY4bqJYul6UP7RP0
	 9Bnh3X3BudVvIEm0Nytt91v89uSilNfutuZhmzae8c5XvwlaU2sonDex8uQONhTm4Z
	 zfwyJjd7LzAIg==
Message-ID: <2cc746e6-4a69-4f56-af99-5dc871fce0ad@kernel.org>
Date: Sat, 13 Dec 2025 12:18:49 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] zloop: protect state check with zloop_ctl_mutex
 locked in zloop_queue_rq
To: Yongpeng Yang <yangyongpeng.storage@outlook.com>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 yangyongpeng.storage@gmail.com
References: <20251212144617.887997-2-yangyongpeng.storage@gmail.com>
 <77d57ec3-134f-4667-b260-f8f5ca593339@kernel.dk>
 <JH0PR02MB86885D86B2A34028A160A0F099AFA@JH0PR02MB8688.apcprd02.prod.outlook.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <JH0PR02MB86885D86B2A34028A160A0F099AFA@JH0PR02MB8688.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/12/13 11:59, Yongpeng Yang wrote:
> On 12/13/25 3:52 AM, Jens Axboe wrote:
>> On 12/12/25 7:46 AM, Yongpeng Yang wrote:
>>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>>
>>> zlo->state is not an atomic variable, so checking
>>> 'zlo->state == Zlo_deleting' must be done under zloop_ctl_mutex.
>>>
>>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>> ---
>>>   drivers/block/zloop.c | 7 +++++--
>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
>>> index 77bd6081b244..0f29e419d8e9 100644
>>> --- a/drivers/block/zloop.c
>>> +++ b/drivers/block/zloop.c
>>> @@ -697,9 +697,12 @@ static blk_status_t zloop_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>   	struct zloop_cmd *cmd = blk_mq_rq_to_pdu(rq);
>>>   	struct zloop_device *zlo = rq->q->queuedata;
>>>   
>>> -	if (zlo->state == Zlo_deleting)
>>> +	mutex_lock(&zloop_ctl_mutex);
>>> +	if (zlo->state == Zlo_deleting) {
>>> +		mutex_unlock(&zloop_ctl_mutex);
>>>   		return BLK_STS_IOERR;
>>> -
>>> +	}
>>> +	mutex_unlock(&zloop_ctl_mutex);
>>
>> Probably a better idea to make the state checking atomic, and avoid the
>> mutex in the queue_rq path.
>>
> 
> It is more reasonable, I'll fix this in v2.

Either what Jens proposed, or move the check to zloop_handle_cmd(), since that
is run in work item context, we can block there.

Of note, is that the loop driver does the same thing in loop_queue_rq(): the
device state is checked without the loop device mutex held. So a similar fix
there may also be nice to have.

> 
> Thanks
> Yongpeng,


-- 
Damien Le Moal
Western Digital Research
