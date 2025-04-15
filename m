Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E5818A6A9
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744697729; cv=none; b=TeweR02FucW6DZxURDNVVJx735D4R3wqnNRGTvm7Vf817yL8k797v3VcvFiB9xqhQuIJhdZCL3xz2OxOx5sdVnM8mee7X88NZFoTwp30pWBpr9zv11OkUjcWiAhsv6eUKnF5zAEwjBLlryJdclqMvTSiiz9S5rcokQHFL1gDyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744697729; c=relaxed/simple;
	bh=ZSbv9qn8eo1sbpS0e02lxkh427QnNN+qdR0T06PI5Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rABSZgeCzmNzpkRkw71l/SNY9Rh8nBMyl0J/bBtPAYOk85ci0ALARm9g0zN9tSkMjqFrec8/i2+NC2R9ZGm4r7kpsxau/HmYEcyxqhEsJqJ4XX+W5Bz02atT2hQ2gy89B2brZuZ6Nrfkg3hdJ34rA8zu2sJczjgTrizgxYHONO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZcDMJ60B9z2CdW9;
	Tue, 15 Apr 2025 14:11:56 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 95C5C140148;
	Tue, 15 Apr 2025 14:15:22 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Apr 2025 14:15:21 +0800
Message-ID: <46cf1372-2014-4e56-a051-8469b318e098@huawei.com>
Date: Tue, 15 Apr 2025 14:15:21 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] blk-throttle: Introduce flag "BIO_TG_BPS_THROTTLED"
To: Yu Kuai <yukuai1@huaweicloud.com>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>
CC: <yangerkun@huawei.com>, <ming.lei@redhat.com>, <tj@kernel.org>, "yukuai
 (C)" <yukuai3@huawei.com>
References: <20250414132731.167620-1-wozizhi@huawei.com>
 <20250414132731.167620-5-wozizhi@huawei.com>
 <692878bd-9f80-537e-0f75-13d0c855e2ce@huaweicloud.com>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <692878bd-9f80-537e-0f75-13d0c855e2ce@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2025/4/15 10:24, Yu Kuai 写道:
> Hi,
> 
> 在 2025/04/14 21:27, Zizhi Wo 写道:
>> Subsequent patches will split the single queue into separate bps and iops
>> queues. To prevent IO that has already passed through the bps queue at a
>> single tg level from being counted toward bps wait time again, we 
>> introduce
>> "BIO_TG_BPS_THROTTLED" flag. Since throttle and QoS operate at different
>> levels, we reuse the value as "BIO_QOS_THROTTLED".
>>
>> We set this flag when charge bps and clear it when charge iops, as the 
>> bio
>> will move to the upper-level tg or be dispatched.
>>
>> This patch does not involve functional changes.
>>
>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>> ---
>>   block/blk-throttle.c      | 9 +++++++--
>>   include/linux/blk_types.h | 5 +++++
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 91ee1c502b41..caae2e3b7534 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -741,12 +741,16 @@ static void throtl_charge_bps_bio(struct 
>> throtl_grp *tg, struct bio *bio)
>>       unsigned int bio_size = throtl_bio_data_size(bio);
>>       /* Charge the bio to the group */
>> -    if (!bio_flagged(bio, BIO_BPS_THROTTLED))
>> +    if (!bio_flagged(bio, BIO_BPS_THROTTLED) &&
>> +        !bio_flagged(bio, BIO_TG_BPS_THROTTLED)) {
>> +        bio_set_flag(bio, BIO_TG_BPS_THROTTLED);
>>           tg->bytes_disp[bio_data_dir(bio)] += bio_size;
>> +    }
>>   }
>>   static void throtl_charge_iops_bio(struct throtl_grp *tg, struct bio 
>> *bio)
>>   {
>> +    bio_clear_flag(bio, BIO_TG_BPS_THROTTLED);
>>       tg->io_disp[bio_data_dir(bio)]++;
>>   }
>> @@ -772,7 +776,8 @@ static unsigned long tg_dispatch_bps_time(struct 
>> throtl_grp *tg, struct bio *bio
>>       /* no need to throttle if this bio's bytes have been accounted */
>>       if (bps_limit == U64_MAX || tg->flags & THROTL_TG_CANCELING ||
>> -        bio_flagged(bio, BIO_BPS_THROTTLED))
>> +        bio_flagged(bio, BIO_BPS_THROTTLED) ||
>> +        bio_flagged(bio, BIO_TG_BPS_THROTTLED))
>>           return 0;
>>       tg_update_slice(tg, rw);
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index dce7615c35e7..f9d1230e27a7 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -296,6 +296,11 @@ enum {
>>                    * of this bio. */
>>       BIO_CGROUP_ACCT,    /* has been accounted to a cgroup */
>>       BIO_QOS_THROTTLED,    /* bio went through rq_qos throttle path */
>> +    /*
>> +     * This bio has undergone rate limiting at the single throtl_grp 
>> level bps
>> +     * queue. Since throttle and QoS are not at the same level, 
>> reused the value.
> resued -> resue

Sorry about that, I missed it. Appreciate the correction.

Thanks,
Zizhi Wo

> 
> Other than the typo, LGTM
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
>> +     */
>> +    BIO_TG_BPS_THROTTLED = BIO_QOS_THROTTLED,
>>       BIO_QOS_MERGED,        /* but went through rq_qos merge path */
>>       BIO_REMAPPED,
>>       BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write 
>> plugging */
>>
> 
