Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550B120330
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744857356; cv=none; b=g1m3anTFhUgB41B3NfdXF8cR5gPaCI8ZOg1OOjpjDCDfRNd6sRC3IV703hWNT56juiuIN2OVi5KnkW2VvWgu7dhyr8B3Z8IFdfar/TxYDrcML2hdv5hbF1a3dCdzIPszCgbLCFYlgjAxH1Nh0Z8o/tUmQ6dQJ8CBaC/G1C0psvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744857356; c=relaxed/simple;
	bh=TWHBUv3ib6qpSe4M4EVdli+aREv2uxYmQd87ARlRcuI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ngIGcBZsCi8d0llWCOJYWKk+2Z66hegtc1OeyQleXNK8jH+WLSjlTJMjRao9POQsSUgd4U9gXLGD+aJr3POM4qXLpMYBesIZslsRhyL0q5WvsROYyr3aBKUsWRcEmINsrg6p5bKlfd7k9IYKMO82PWnjy+lKTwBrNHAhrWzsvvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZdMSX41k3z4f3lWG
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 10:35:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CDF6D1A0359
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 10:35:49 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXe18EaQBonwHZJg--.651S3;
	Thu, 17 Apr 2025 10:35:49 +0800 (CST)
Subject: Re: [PATCH 1/3] blk-throttle: Fix wrong tg->[bytes/io]_disp update in
 __tg_update_carryover()
To: Ming Lei <ming.lei@redhat.com>, Zizhi Wo <wozizhi@huawei.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, yangerkun@huawei.com,
 tj@kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250417015033.512940-1-wozizhi@huawei.com>
 <20250417015033.512940-2-wozizhi@huawei.com> <aABnBBp4ZZ6pQAOM@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5ad661ae-0e16-130a-15cc-1de53a5f7b8f@huaweicloud.com>
Date: Thu, 17 Apr 2025 10:35:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aABnBBp4ZZ6pQAOM@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe18EaQBonwHZJg--.651S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWDWF4UJFyUtFWxWrWrGrg_yoW5CF1Upr
	WxtFsxGw1DXF13G3sxX3WSqFyrX3ykA347JrZ8Gw1rAFn8CrnYgr1rCrZ0krWIvFyfGayv
	vw12q3srCF48ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/04/17 10:27, Ming Lei Ð´µÀ:
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

It took me a while to understand, I think you mean

if ()
  *bytes =xxx;

tg->bytes_disp[rw] = -*bytes;

I'm good with or without this change.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

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
> .
> 

