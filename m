Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F145038
	for <linux-block@vger.kernel.org>; Sat, 12 Apr 2025 00:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744418265; cv=none; b=ptL9ezDgxXc3v/0T1aKTnzVk3vZy5/ODicILd3kP0fWVsNPZKaXKLTltS5N4vXlcCAYVum+6SwvC5CX3vsPQvHvW3se9yqZF5kPpBELmt8NXdoaCU82SFQ5cijicVRv6jQhZkxboKCEThnpyeXnUmiU/7PnKf1sOfoCqt9P5BfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744418265; c=relaxed/simple;
	bh=BinyXpgB3XwwQ3SVRCChBLa2LDj2/SMbJ+IXxlh4GbQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QSEc6voiJqlURyvPj5hpmgUC6B+BfXOQcP4EPy/TLT8SdZ9XALF/zo+wM31XnnMYq8/peU2zOIroJJpZUkLGaejPAKJIO73E417nAL6GSCfri3UDTaUL/nFIflbFXeSXnLwEv0r+8zlz0MZJCd1TBjdXU/ElpIpeU4v6Lmj8U+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZZF4K1vVyz4f3lCm
	for <linux-block@vger.kernel.org>; Sat, 12 Apr 2025 08:37:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5A09E1A058E
	for <linux-block@vger.kernel.org>; Sat, 12 Apr 2025 08:37:30 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7Itfln_iTdJA--.54600S3;
	Sat, 12 Apr 2025 08:37:30 +0800 (CST)
Subject: Re: [PATCH 3/3] blk-throttle: carry over directly
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 WoZ1zh1 <wozizhi@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250305043123.3938491-1-ming.lei@redhat.com>
 <20250305043123.3938491-4-ming.lei@redhat.com>
 <14e6c54f-d0d9-0122-1e47-c8a56adbd5db@huaweicloud.com>
 <Z_ku5L3sVZbHdbQ_@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <646e8bdd-9186-2c54-4962-be3b4962b959@huaweicloud.com>
Date: Sat, 12 Apr 2025 08:37:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z_ku5L3sVZbHdbQ_@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul7Itfln_iTdJA--.54600S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw45Ww43ZFW8XF1UXw18Zrb_yoWxZFy7pF
	WfAFsrKw4kXF17G3ZxZ3ZIyFyFq3yUZryDGrW5Kw1rAFn8CryrKF1DurZY9ayxZryxCayI
	yw1jvr9xAr40yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
	r21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/04/11 23:01, Ming Lei 写道:
> On Fri, Apr 11, 2025 at 10:53:12AM +0800, Yu Kuai wrote:
>> Hi, Ming
>>
>> 在 2025/03/05 12:31, Ming Lei 写道:
>>> Now ->carryover_bytes[] and ->carryover_ios[] only covers limit/config
>>> update.
>>>
>>> Actually the carryover bytes/ios can be carried to ->bytes_disp[] and
>>> ->io_disp[] directly, since the carryover is one-shot thing and only valid
>>> in current slice.
>>>
>>> Then we can remove the two fields and simplify code much.
>>>
>>> Type of ->bytes_disp[] and ->io_disp[] has to change as signed because the
>>> two fields may become negative when updating limits or config, but both are
>>> big enough for holding bytes/ios dispatched in single slice
>>>
>>> Cc: Tejun Heo <tj@kernel.org>
>>> Cc: Josef Bacik <josef@toxicpanda.com>
>>> Cc: Yu Kuai <yukuai3@huawei.com>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    block/blk-throttle.c | 49 +++++++++++++++++++-------------------------
>>>    block/blk-throttle.h |  4 ++--
>>>    2 files changed, 23 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>>> index 7271aee94faf..91dab43c65ab 100644
>>> --- a/block/blk-throttle.c
>>> +++ b/block/blk-throttle.c
>>> @@ -478,8 +478,6 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
>>>    {
>>>    	tg->bytes_disp[rw] = 0;
>>>    	tg->io_disp[rw] = 0;
>>> -	tg->carryover_bytes[rw] = 0;
>>> -	tg->carryover_ios[rw] = 0;
>>>    	/*
>>>    	 * Previous slice has expired. We must have trimmed it after last
>>> @@ -498,16 +496,14 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
>>>    }
>>>    static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw,
>>> -					  bool clear_carryover)
>>> +					  bool clear)
>>>    {
>>> -	tg->bytes_disp[rw] = 0;
>>> -	tg->io_disp[rw] = 0;
>>> +	if (clear) {
>>> +		tg->bytes_disp[rw] = 0;
>>> +		tg->io_disp[rw] = 0;
>>> +	}
>>>    	tg->slice_start[rw] = jiffies;
>>>    	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
>>> -	if (clear_carryover) {
>>> -		tg->carryover_bytes[rw] = 0;
>>> -		tg->carryover_ios[rw] = 0;
>>> -	}
>>>    	throtl_log(&tg->service_queue,
>>>    		   "[%c] new slice start=%lu end=%lu jiffies=%lu",
>>> @@ -617,20 +613,16 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>>>    	 */
>>>    	time_elapsed -= tg->td->throtl_slice;
>>>    	bytes_trim = calculate_bytes_allowed(tg_bps_limit(tg, rw),
>>> -					     time_elapsed) +
>>> -		     tg->carryover_bytes[rw];
>>> -	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed) +
>>> -		  tg->carryover_ios[rw];
>>> +					     time_elapsed);
>>> +	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed);
>>>    	if (bytes_trim <= 0 && io_trim <= 0)
>>>    		return;
>>> -	tg->carryover_bytes[rw] = 0;
>>>    	if ((long long)tg->bytes_disp[rw] >= bytes_trim)
>>>    		tg->bytes_disp[rw] -= bytes_trim;
>>>    	else
>>>    		tg->bytes_disp[rw] = 0;
>>> -	tg->carryover_ios[rw] = 0;
>>>    	if ((int)tg->io_disp[rw] >= io_trim)
>>>    		tg->io_disp[rw] -= io_trim;
>>>    	else
>>> @@ -645,7 +637,8 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>>>    		   jiffies);
>>>    }
>>> -static void __tg_update_carryover(struct throtl_grp *tg, bool rw)
>>> +static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
>>> +				  long long *bytes, int *ios)
>>>    {
>>>    	unsigned long jiffy_elapsed = jiffies - tg->slice_start[rw];
>>>    	u64 bps_limit = tg_bps_limit(tg, rw);
>>> @@ -658,26 +651,28 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw)
>>>    	 * configuration.
>>>    	 */
>>>    	if (bps_limit != U64_MAX)
>>> -		tg->carryover_bytes[rw] +=
>>> -			calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
>>> +		*bytes = calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
>>>    			tg->bytes_disp[rw];
>>>    	if (iops_limit != UINT_MAX)
>>> -		tg->carryover_ios[rw] +=
>>> -			calculate_io_allowed(iops_limit, jiffy_elapsed) -
>>> +		*ios = calculate_io_allowed(iops_limit, jiffy_elapsed) -
>>>    			tg->io_disp[rw];
>>> +	tg->bytes_disp[rw] -= *bytes;
>>> +	tg->io_disp[rw] -= *ios;
>>
>> This patch is applied before I get a chance to review. :( I think the
>> above update should be:
> 
> oops, your review period takes too long(> 1 month), :-(

Yes, I just didn't review in detail when I see this set is applied...
> 
>>
>> tg->bytes_disp[rw] = -*bytes;
>> tg->io_disp[rw] = -*ios;
> 
> I think the above is wrong since it simply override the existed dispatched
> bytes/ios.
> 
> The calculation can be understood from two ways:
> 
> 1) delta = calculate_bytes_allowed(bps_limit, jiffy_elapsed) - tg->bytes_disp[rw];
> 
> `delta` represents difference between theoretical and actual dispatch bytes.
> 
> If `delta` > 0, it means we dispatch too less in past, and we have to subtract
> `delta` from ->bytes_disp, so that in future we can dispatch more.

But the problem is that in this patch, slice_start is set to *jiffies*,
keep the old disp filed that is between old slice_start to jiffies does
not make sense.
> 
> Similar with 'delta < 0'.
> 
> 2) from consumer viewpoint:
> 
> tg_within_bps_limit(): patched
> 
> 	...
> 	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd);
> 	if (bytes_allowed > 0 && tg->bytes_disp[rw] + bio_size <= bytes_allowed)
> 		...
> 
> tg_within_bps_limit(): before patched
> 	...
>      bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd) +
> 		tg->carryover_bytes[rw];
> 	if (bytes_allowed > 0 && tg->bytes_disp[rw] + bio_size <= bytes_allowed)
> 		...
> 
> So if `delta` is subtracted from `bytes_allowed` in patched code, we should
> subtract same bytes from ->byte_disp[] side for maintaining the relation.
> 

In the original carryover calculation, bytes_disp is always set to 0,
while slice start is set to jiffies. Patched version actually will be
less than old version if bytes_disp is not 0;
> 
>>
>> Otherwise, the result is actually (2 * disp - allowed), which might be a
>> huge value, causing long dealy for the next dispatch.
>>
>> This is what the old carryover fileds do, above change will work, but
>> look wried.
> 
> As I explained, the patched code follows the original carryover calculation, and it
> passes all throt blktests.

BTW, there is another case that this patch broken, if bps_limit is set
while iops_limit is not, and BIO is throttled, io_disp will be recored.

And if user set iops_limit as well, before this set, io_disp will set to
0, however, this set will keep the old io_disp which will also cause
long delay.

tg_conf_updated
  throtl_start_new_slice
> 
> Or do you have test case broken by this patch?

Yes, we can change test/005 a bit for this problem, currently the test
just issue one BIO and bytes_disp/io_disp is zero when config is
chagned.

Thanks,
Kuai

> 
> 
> 
> Thanks.
> Ming
> 
> 
> .
> 

