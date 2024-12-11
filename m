Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74661FC104;
	Wed, 11 Dec 2024 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733885879; cv=none; b=r6H3jXQx0Xl55EV+IeZyEhN7WXvBVECT1EotOLuDhEaS4VWXpDnslHb8QAAzXJXpPysmD7PGw3qhTHtYotdIK7xfUVTTBNSSYasKbE3IjJIcEAyEy8qLdNU7fDtmHipyL9waTG/1zAZMRhnrn1vWSHxilvjtu6t30yNdE7yiyws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733885879; c=relaxed/simple;
	bh=xDNfLDPziQoE8u5MKueY1acAOA6xYihr0w/rQseo8SM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fZ88JTmvmz1OOio84OcvucTWd6ZsOt9Nmhw3TZbpeVJ2lSekSHF+OwSKgkLfmEnJNfymRB06tYtHX9TrBjMTdDjpcCTqwSo8OqICpvcEBj7JfRH3gm1LRYJuVaHGpkuWMY9t3nQfV6PxRlOkzynNzKG6jKMfvD+BZWg+/8vEDLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y7Kyh44cSz4f3jYW;
	Wed, 11 Dec 2024 10:57:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C905C1A06D7;
	Wed, 11 Dec 2024 10:57:51 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgB3noKt_1hnQ6UJEQ--.10836S3;
	Wed, 11 Dec 2024 10:57:51 +0800 (CST)
Subject: Re: [PATCH RFC 1/3] block/mq-deadline: Revert "block/mq-deadline: Fix
 the tag reservation code"
To: Zhiguo Niu <niuzhiguo84@gmail.com>, Bart Van Assche <bvanassche@acm.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 akpm@linux-foundation.org, yang.yang@vivo.com, ming.lei@redhat.com,
 osandov@fb.com, paolo.valente@linaro.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
 <20241209115522.3741093-2-yukuai1@huaweicloud.com>
 <bef7b96c-a6cc-4b83-99b2-848cecb3d3b1@acm.org>
 <6e384b29-50d2-64bd-0d08-fc0f086c1cbd@huaweicloud.com>
 <7081765f-28d7-f594-1221-6034b9e88899@huaweicloud.com>
 <d9733af5-b16b-4644-9d6d-84fbacf334e0@acm.org>
 <CAHJ8P3J-KwGU_ZffmSmoFkhUX1q=9Q7Dk15yPEXYME_JQHH5tA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <48ee35f1-dbbe-b4ff-2507-9c0e7bd4db0d@huaweicloud.com>
Date: Wed, 11 Dec 2024 10:57:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHJ8P3J-KwGU_ZffmSmoFkhUX1q=9Q7Dk15yPEXYME_JQHH5tA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3noKt_1hnQ6UJEQ--.10836S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KryxCFyruryxXF1kZrWDArb_yoW8tF1rp3
	yUKF4YyrZ8Ja48uw48Zwsagr4Fqr4Sqr13Gwn0grW2k3s8GF1qqF1aq3Z8ur97urWfJw1j
	9Fyqy345ZF1qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/12/11 10:38, Zhiguo Niu 写道:
> Bart Van Assche <bvanassche@acm.org> 于2024年12月11日周三 04:33写道：
>>
>> On 12/9/24 10:22 PM, Yu Kuai wrote:
>>> First of all, are we in the agreement that it's not acceptable to
>>> sacrifice performance in the default scenario just to make sure
>>> functional correctness if async_depth is set to 1?
>>
>> How much does this affect performance? If this affects performance
>> significantly I agree that this needs to be fixed.
>>
>>> If so, following are the options that I can think of to fix this:
>>>
>>> 1) make async_depth read-only, if 75% tags will hurt performance in some
>>> cases, user can increase nr_requests to prevent it.
>>> 2) refactor elevator sysfs api, remove eq->sysfs_lock and replace it
>>> with q->sysfs_lock, so deadline_async_depth_store() will be protected
>>> against changing hctxs, and min_shallow_depth can be updated here.
>>> 3) other options?
>>
>> Another option is to remove the ability to configure async_depth. If it
>> is too much trouble to get the implementation right without causing
>> regressions for existing workloads, one possibility is to remove support
>> for restricting the number of asynchronous requests in flight.
> Hi Bart,
> I think it is very useful to restrict asynchronous requests when IO
> loading is very heavy by aysnc_depth.
> the following is my androidbench experiment in android device(sched_tag=128):
> 1. setting heavy IO
> while true; do fio -directory=/data -direct=0 -rw=write -bs=64M
> -size=1G -numjobs=5 -name=fiotest
> 2. run androidbench  and results：
>                  orignial async_depth
> async_depth=nr_requests*3/4      delta
> seq read             33.176                                216.49
>                        183.314
> seq write             28.57                                  62.152
>                           33.582
> radom read         1.518                                  1.648
>                          0.13
> radom write         3.546                                  4.27
>                            0.724
> and our customer also feedback there is optimization when they test
> APP cold start and benchmark after tunning async_depth.

So do you guys writing async_depth? Looks like you're using
nr_requests*3/4. If this is the case, the above option 1) is still
working for you guys. However, in this test, I think the lower
async_depth is, the better result you'll get.

Thanks,
Kuai


> thanks！
>>
>> Thanks,
>>
>> Bart.
>>
> .
> 

