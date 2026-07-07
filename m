Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09EE3AA4F1;
	Tue,  7 Jul 2026 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406722; cv=none; b=ip4ipwGr6SY0TH2wUIiEjlszD66P7B9oqeiklNtnpUMTyDJFBtUdKRjwd429NKUFgWmJsSO+mSmdj/qfHgoYs8Q3CcSPmUsylkRuM8JwyFMG8JMYOHW7YWpQh63/b6eEwVs+WqWhG1KBlxO3nYF9bc5+D1F86SA9QRxynOoqSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406722; c=relaxed/simple;
	bh=rVP+x0JR8+SrfMdSsmgCEQpEcbXdIaJP/7o2AUK68bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gWQHkjB5c1C/BOhQ7JQgLUkTx+3OFepvuOixJz0p4uQgF1Qiu24TiGvzgG9dSoCRuWl/mQYK9fC8BjaMKWO9G+PsxqZjuAvMmnmVfe24i7iI7QoivPK/gQMuvbWSfHiguLUGepyFNFYQb8yxQjwsNC3Y/mLn4feguiLTEQrJLqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ajD3cvOQ; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ajD3cvOQ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=t3kJZ5r5fjnVaPTUFHaE9BMRrmj49AfYvv3BAFcJ57g=;
	b=ajD3cvOQyoIUrIlTqV9mDRabgFPPA8Pdc2k3xuIr+gIUyF6w1VMlw0Vviq/Rn1biTxLfMhi58
	xDF8TLmwzvZ3Ma7ZQiXnHIDgF827zfqllOKiMAY5ZIJh34NUzONM79h1jMB7jQKVh9P+fAanyeN
	LAO1HqK4CDKs4HTkIK91jmQ=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gvWhb5r4Jz1T4G5;
	Tue,  7 Jul 2026 14:36:15 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id E4D1340538;
	Tue,  7 Jul 2026 14:45:14 +0800 (CST)
Received: from [10.174.176.179] (10.174.176.179) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Jul 2026 14:45:14 +0800
Message-ID: <75bc556a-a01d-4864-a296-61cfff3aab98@huawei.com>
Date: Tue, 7 Jul 2026 14:45:13 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/6] null_blk: give the file-scope mutex a descriptive
 name
To: Damien Le Moal <dlemoal@kernel.org>, Zizhi Wo <wozizhi@huaweicloud.com>,
	<axboe@kernel.dk>, <nilay@linux.ibm.com>, <linux-block@vger.kernel.org>,
	<kch@nvidia.com>, <johannes.thumshirn@wdc.com>, <kbusch@kernel.org>,
	<bvanassche@acm.org>
CC: <linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>,
	<chengzhihao1@huawei.com>
References: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
 <20260707025542.1299859-3-wozizhi@huaweicloud.com>
 <0ab391b1-20e2-4ae9-a606-7111014e489c@kernel.org>
 <5dd82788-aa48-4f11-907f-6f21b57a27fa@huaweicloud.com>
 <017a3a24-2b9a-4567-b2d6-a496a86da0fe@kernel.org>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <017a3a24-2b9a-4567-b2d6-a496a86da0fe@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2026/7/7 14:28, Damien Le Moal 写道:
> On 7/7/26 15:24, Zizhi Wo wrote:
>>
>>
>> 在 2026/7/7 12:16, Damien Le Moal 写道:
>>> On 7/7/26 11:55, Zizhi Wo wrote:
>>>> From: Zizhi Wo <wozizhi@huawei.com>
>>>>
>>>> The file-scope lock mutex serializes access to global null_blk state,
>>>> including the nullb_list and device creation/removal. Rename it to
>>>> "nullb_global_lock" to make its purpose clear. No functional change.
>>>>
>>>> Suggested-by: Bart Van Assche <bvanassche@acm.org>
>>>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>>>> ---
>>>>    drivers/block/null_blk/main.c | 32 ++++++++++++++++----------------
>>>>    1 file changed, 16 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>>> index eba204b27785..98f6935bb502 100644
>>>> --- a/drivers/block/null_blk/main.c
>>>> +++ b/drivers/block/null_blk/main.c
>>>> @@ -66,7 +66,7 @@ struct nullb_page {
>>>>    #define NULLB_PAGE_FREE (MAP_SZ - 2)
>>>>    
>>>>    static LIST_HEAD(nullb_list);
>>>> -static DEFINE_MUTEX(lock);
>>>> +static DEFINE_MUTEX(nullb_global_lock);
>>>
>>> Since this seem to protect only the device list, why not simply call this
>>> nullb_list_lock ?
>>>
>>>>    static int null_major;
>>>>    static DEFINE_IDA(nullb_indexes);
>>>>    static struct blk_mq_tag_set tag_set;
>>>> @@ -423,9 +423,9 @@ static int nullb_apply_submit_queues(struct nullb_device *dev,
>>>>    {
>>>>    	int ret;
>>>>    
>>>> -	mutex_lock(&lock);
>>>> +	mutex_lock(&nullb_global_lock);
>>>>    	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
>>>> -	mutex_unlock(&lock);
>>>> +	mutex_unlock(&nullb_global_lock);
>>>
>>> Nothing in nullb_update_nr_hw_queues() touches the device list. So it is very
>>> odd that nullb_global_lock is used for serialization here instead of a
>>> nullb_device mutex. If you change this, why not a prep patch to introduce such a
>>> mutex ?
>>>
>>
>> Thanks for pointing this out. The rename really belongs together with
>> the locking rework, so I'll drop this patch from v3 and fold the rename
>> into a separate series that splits the locking (introducing a per-
>> nullb_device mutex for the updates).
> 
> Please carefully check if the use of the global lock in these function is not to
> serialize with power on/off. The code is a little (uselessly) complicated in
> that area and I may not be seeing something. But it seems that on/off control
> could also use a device lock, with proper ordering: device lock first, then list
> lock.

Thanks for the suggestion. At a first glance this does look doable, and
I will check it carefully. :)

Thanks,
Zizhi Wo

> 
> 

