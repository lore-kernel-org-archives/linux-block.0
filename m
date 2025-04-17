Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE89120330
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744857322; cv=none; b=iV7ABe5NR8Ex5Y9cjbW5fD5875gk87MX3E0V3/U/laKizGDH+sPyCNt7mDls4F1wc3eDBecvM1d6G6Trc9/eMW6Hw2sA5T1xOkOPswO8pr0wEwuOJHvLF0/HnCwklGZ21kUpOQhth1AH4aZu1WcTbBKbpeuQ8RniZ9VaZ5ENvVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744857322; c=relaxed/simple;
	bh=hYSdu5+f7ctVKzgxFTIV7fiNg1IcENMYX8wmlhNNMF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h+y6+wzxoZUScTzCXzCJv2e7ROP7bCIE5zvK/D0f1duBgAYaeq4SvLd7dnZR0xoPTbo/ND1yEE867TY+WF45Hh4JmvoFcrYxwwYQXkPEa9HFTnyHRxuTRs89almXuCDXcQ728TTpthNLPH12e0x34Wy7NO0JYLvfKZhjFhYQWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZdMMX07fSzvWtr;
	Thu, 17 Apr 2025 10:31:04 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 53E9A140259;
	Thu, 17 Apr 2025 10:35:10 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Apr 2025 10:35:09 +0800
Message-ID: <5649c4cc-b88f-42ae-ab5d-528df8a4b875@huawei.com>
Date: Thu, 17 Apr 2025 10:35:08 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] blk-throttle: Fix wrong tg->[bytes/io]_disp update in
 __tg_update_carryover()
To: Ming Lei <ming.lei@redhat.com>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <yangerkun@huawei.com>,
	<yukuai3@huawei.com>, <tj@kernel.org>
References: <20250417015033.512940-1-wozizhi@huawei.com>
 <20250417015033.512940-2-wozizhi@huawei.com> <aABnBBp4ZZ6pQAOM@fedora>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <aABnBBp4ZZ6pQAOM@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2025/4/17 10:27, Ming Lei 写道:
> On Thu, Apr 17, 2025 at 09:50:31AM +0800, Zizhi Wo wrote:
>> In commit 6cc477c36875 ("blk-throttle: carry over directly"), the carryover
>> bytes/ios was be carried to [bytes/io]_disp. However, its update mechanism
>> has some issues.
>>
>> In __tg_update_carryover(), we calculate "bytes" and "ios" to represent the
>> carryover, but the computation when updating [bytes/io]_disp is incorrect.
>> This patch fixes the issue.
>>
>> And if the bps/iops limit was previously set to max and later changed to a
>> smaller value, we may not update tg->[bytes/io]_disp to 0 in
>> tg_update_carryover(). Relying solely on throtl_trim_slice() is not
>> sufficient, which can lead to subsequent bio dispatches not behaving as
>> expected. We should set tg->[bytes/io]_disp to 0 in non_carryover case.
>> The same handling applies when nr_queued is 0.
>>
>> Fixes: 6cc477c36875 ("blk-throttle: carry over directly")
>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>> ---
>>   block/blk-throttle.c | 33 +++++++++++++++++++++++++--------
>>   1 file changed, 25 insertions(+), 8 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 91dab43c65ab..df9825eb83be 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -644,20 +644,39 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
>>   	u64 bps_limit = tg_bps_limit(tg, rw);
>>   	u32 iops_limit = tg_iops_limit(tg, rw);
>>   
>> +	/*
>> +	 * If the queue is empty, carryover handling is not needed. In such cases,
>> +	 * tg->[bytes/io]_disp should be reset to 0 to avoid impacting the dispatch
>> +	 * of subsequent bios. The same handling applies when the previous BPS/IOPS
>> +	 * limit was set to max.
>> +	 */
>> +	if (tg->service_queue.nr_queued[rw] == 0) {
>> +		tg->bytes_disp[rw] = 0;
>> +		tg->io_disp[rw] = 0;
>> +		return;
>> +	}
>> +
>>   	/*
>>   	 * If config is updated while bios are still throttled, calculate and
>>   	 * accumulate how many bytes/ios are waited across changes. And
>>   	 * carryover_bytes/ios will be used to calculate new wait time under new
>>   	 * configuration.
>>   	 */
>> -	if (bps_limit != U64_MAX)
>> +	if (bps_limit != U64_MAX) {
>>   		*bytes = calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
>>   			tg->bytes_disp[rw];
>> -	if (iops_limit != UINT_MAX)
>> +		tg->bytes_disp[rw] = -*bytes;
>> +	} else {
>> +		tg->bytes_disp[rw] = 0;
>> +	}
> 
> It should be fine to do	'tg->bytes_disp[rw] = -*bytes;' directly
> because `*bytes` is initialized as zero.

Indeed, I didn't notice that the incoming bytes/io is initialized to 0.

Thanks,
Zizhi Wo

> 
>> +
>> +	if (iops_limit != UINT_MAX) {
>>   		*ios = calculate_io_allowed(iops_limit, jiffy_elapsed) -
>>   			tg->io_disp[rw];
>> -	tg->bytes_disp[rw] -= *bytes;
>> -	tg->io_disp[rw] -= *ios;
>> +		tg->io_disp[rw] = -*ios;
>> +	} else {
>> +		tg->io_disp[rw] = 0;
>> +	}
> 
> Same with above.
> 
> Otherwise, this patch looks fine.
> 
> 
> thanks,
> Ming
> 
> 
