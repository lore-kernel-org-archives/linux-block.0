Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E301519A2
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 03:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740109166; cv=none; b=m5jPnSUJkfncNO/mTbzpdQn+TS4pwTRk6o2xf4rq0afJMG4tgOlnGEBNiE52Cwm2e4FOUGipnwiSpNuuwpFvsvPJB7hk3+ndrDNSwE+6oJR1WbTjCa9BPwGgRXOiS2avNuP7cdhoZkD+tSDIysPD9iPH8LootqANElkiGXsx06k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740109166; c=relaxed/simple;
	bh=nGl9067iZ+T+QA0yY85loJSGYfTYmft0H8nruKfV2MQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KFcKeSQ8qUEq5h/OvRSZLOKUuN90uPYE4op5BMoutgGGKbstX02xiSxWB4eRtEzLIf9tCRZqu5d2NHtu4YMxNjqgpF4oghqOGzd617GL7zjtIOsH42LCIZ04vAYyJ7yI56tafc/mjktUFPqZxBSKvZoHAdOERgCFjRS9rcbqw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YzbTC72Mbz4f3kvt
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 11:38:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 115DD1A0EF0
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 11:39:19 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl9l9bdnZa7LEQ--.64813S3;
	Fri, 21 Feb 2025 11:39:18 +0800 (CST)
Subject: Re: [PATCH] block: throttle: don't add one extra jiffy mistakenly for
 bps limit
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250220111735.1187999-1-ming.lei@redhat.com>
 <a8f10a51-c9c8-0d1a-296d-f1f542bf8523@huaweicloud.com>
 <Z7frGxuMCTLwH9BW@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <83147b4b-9be8-3a50-6a4f-2ec9b37c8ab8@huaweicloud.com>
Date: Fri, 21 Feb 2025 11:39:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z7frGxuMCTLwH9BW@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl9l9bdnZa7LEQ--.64813S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKr4ktw1DGw43tFy7KF1fXrb_yoW7CF47pF
	W7GF4Y9F4UXFnrK3WfAanYyFyjqws2yFW7G3y7Cr1xAFnYkFnrKF15ZrWF9w48AFn7ua1I
	vw1jqry7GF1qvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/02/21 10:55, Ming Lei 写道:
> Hi Yukuai,
> 
> On Thu, Feb 20, 2025 at 09:38:12PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/02/20 19:17, Ming Lei 写道:
>>> When the current bio needs to be throttled because of bps limit, the wait
>>> time for the extra bytes may be less than 1 jiffy, tg_within_bps_limit()
>>> adds one extra 1 jiffy.
>>>
>>> However, when taking roundup time into account, the extra 1 jiffy
>>> may become not necessary, then bps limit becomes not accurate. This way
>>> causes blktests throtl/001 failure in case of CONFIG_HZ_100=y.
>>>
>>> Fix it by not adding the 1 jiffy in case that the roundup time can
>>> cover it.
>>>
>>> Cc: Tejun Heo <tj@kernel.org>
>>> Cc: Yu Kuai <yukuai3@huawei.com>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    block/blk-throttle.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>>> index 8d149aff9fd0..8348972c517b 100644
>>> --- a/block/blk-throttle.c
>>> +++ b/block/blk-throttle.c
>>> @@ -729,14 +729,14 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
>>>    	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
>>>    	jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
>>> -	if (!jiffy_wait)
>>> -		jiffy_wait = 1;
>>> -
>>>    	/*
>>>    	 * This wait time is without taking into consideration the rounding
>>>    	 * up we did. Add that time also.
>>>    	 */
>>>    	jiffy_wait = jiffy_wait + (jiffy_elapsed_rnd - jiffy_elapsed);
>>> +	if (!jiffy_wait)
>>> +		jiffy_wait = 1;
>>
>> Just wonder, will wait (0, 1) less jiffies is better than wait (0, 1)
>> more jiffies.
>>
>> How about following changes?
>>
>> Thanks,
>> Kuai
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 8d149aff9fd0..f8430baf3544 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -703,6 +703,7 @@ static unsigned long tg_within_bps_limit(struct
>> throtl_grp *tg, struct bio *bio,
>>                                  u64 bps_limit)
>>   {
>>          bool rw = bio_data_dir(bio);
>> +       long long carryover_bytes;
>>          long long bytes_allowed;
>>          u64 extra_bytes;
>>          unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
>> @@ -727,10 +728,11 @@ static unsigned long tg_within_bps_limit(struct
>> throtl_grp *tg, struct bio *bio,
>>
>>          /* Calc approx time to dispatch */
>>          extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
>> -       jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
>> +       jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit,
>> carryover_bytes);
Hi, Thanks for the test.

This is a mistake, carryover_bytes is much bigger than expected :(
That's why the result is much worse. My bad.
>>
> 
> &carryover_bytes
> 
>> +       /* carryover_bytes is dispatched without waiting */
>>          if (!jiffy_wait)
The if condition shound be removed.
>> -               jiffy_wait = 1;
>> +               tg->carryover_bytes[rw] -= carryover_bytes;
>>
>>          /*
>>           * This wait time is without taking into consideration the rounding
>>
>>> +
>>>    	return jiffy_wait;
> 
> Looks result is worse with your patch:
> 
> throtl/001 (basic functionality)                             [failed]
>      runtime  6.488s  ...  28.862s
>      --- tests/throtl/001.out	2024-11-21 09:20:47.514353642 +0000
>      +++ /root/git/blktests/results/nodev/throtl/001.out.bad	2025-02-21 02:51:36.723754146 +0000
>      @@ -1,6 +1,6 @@
>       Running throtl/001
>      +13
>       1
>      -1
>      -1
>      +13
>       1
>      ...
>      (Run 'diff -u tests/throtl/001.out /root/git/blktests/results/nodev/throtl/001.out.bad' to see the entire diff)

And I realize now that throtl_start_new_slice() will just clear
the carryover_bytes, I tested in my VM and with following changes,
throtl/001 never fail with CONFIG_HZ_100.

Thanks,
Kuai

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8d149aff9fd0..4fc005af82e0 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -703,6 +703,7 @@ static unsigned long tg_within_bps_limit(struct 
throtl_grp *tg, struct bio *bio,
                                 u64 bps_limit)
  {
         bool rw = bio_data_dir(bio);
+       long long carryover_bytes;
         long long bytes_allowed;
         u64 extra_bytes;
         unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
@@ -727,10 +728,8 @@ static unsigned long tg_within_bps_limit(struct 
throtl_grp *tg, struct bio *bio,

         /* Calc approx time to dispatch */
         extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
-       jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
-
-       if (!jiffy_wait)
-               jiffy_wait = 1;
+       jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit, 
&carryover_bytes);
+       tg->carryover_bytes[rw] -= div64_u64(carryover_bytes, HZ);

         /*
          * This wait time is without taking into consideration the rounding
@@ -775,10 +774,14 @@ static bool tg_may_dispatch(struct throtl_grp *tg, 
struct bio *bio,
          * long since now. New slice is started only for empty throttle 
group.
          * If there is queued bio, that means there should be an active
          * slice and it should be extended instead.
+        *
+        * If throtl_trim_slice() doesn't clear carryover_bytes, which means
+        * debt is still not paid, don't start new slice in this case.
          */
-       if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
+       if (throtl_slice_used(tg, rw) && 
!(tg->service_queue.nr_queued[rw]) &&
+           tg->carryover_bytes[rw] >= 0) {
                 throtl_start_new_slice(tg, rw, true);
-       else {
+       } else {
                 if (time_before(tg->slice_end[rw],
                     jiffies + tg->td->throtl_slice))
                         throtl_extend_slice(tg, rw,

> 
> 
> thanks,
> Ming
> 
> 
> .
> 

