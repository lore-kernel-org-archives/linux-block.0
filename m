Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784051FB3
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754444683; cv=none; b=ccqGIUzrpljpP6BLwSkgIHyFQAh+kORUM/TEfbjdDr2xN5NsybhLPMOKjNIVVdtr/2lpkdy/zted2gAusl24Am5Hr9WdEPK56+b+yJQU4iWuiZD8x8DS2/H5ZDoIMJUWYmmmkAmH5FfQbtkvUEYzL9i2VXrDKlJvfZbIKlEFmOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754444683; c=relaxed/simple;
	bh=FlyYC6nsVpTvNRX52SXy2/NJQfiFwxsYFyLHp9lEflQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hAcd4CzHjaCPjro2a3uAOI4hCv1BrDZz/6JqNj66IFq8XKziN2S5PrOqGWybJTvPp/Vp2q73hSkk4FQUsRIwK8zS1H14Fgm7Mw5DsPL3cTwRdF9HX/so1OXtdqoYU7RM12ehcIDJh1TLRAjJn6qlDDL8m0/fgSYu5P+z1ofS3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bxY4l4cH4zYQv7R
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 09:44:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4F9DF1A17C0
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 09:44:38 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAHgxODs5Jo4i7gCg--.49106S3;
	Wed, 06 Aug 2025 09:44:37 +0800 (CST)
Subject: Re: [PATCH 0/2] block: blk-rq-qos: replace static key with atomic
 bitop
To: Jens Axboe <axboe@kernel.dk>, Nilay Shroff <nilay@linux.ibm.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, kch@nvidia.com, shinichiro.kawasaki@wdc.com,
 hch@lst.de, gjoyce@ibm.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250804122125.3271397-1-nilay@linux.ibm.com>
 <aJC4tDUsk42Nb9Df@fedora>
 <682f0f43-733a-4c04-91ed-5665815128bc@linux.ibm.com>
 <d4d21177-e49e-4959-b68c-707a15dccf73@kernel.dk>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e00a3951-2cc8-3634-788e-8a174bdc6a8f@huaweicloud.com>
Date: Wed, 6 Aug 2025 09:44:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d4d21177-e49e-4959-b68c-707a15dccf73@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHgxODs5Jo4i7gCg--.49106S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr18CFyUur4DKryfKw1kuFg_yoWrAFWkpa
	yxta42ya18XF4vvFs7tws5C3yUKwsrAFW3Xr15G34fZa4qvr1jyFW0yFyY9F98urs2k3WI
	vr4FvF9rXw15C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/06 9:28, Jens Axboe 写道:
> On 8/4/25 10:58 PM, Nilay Shroff wrote:
>>
>>
>> On 8/4/25 7:12 PM, Ming Lei wrote:
>>> On Mon, Aug 04, 2025 at 05:51:09PM +0530, Nilay Shroff wrote:
>>>> This patchset replaces the use of a static key in the I/O path (rq_qos_
>>>> xxx()) with an atomic queue flag (QUEUE_FLAG_QOS_ENABLED). This change
>>>> is made to eliminate a potential deadlock introduced by the use of static
>>>> keys in the blk-rq-qos infrastructure, as reported by lockdep during
>>>> blktests block/005[1].
>>>>
>>>> The original static key approach was introduced to avoid unnecessary
>>>> dereferencing of q->rq_qos when no blk-rq-qos module (e.g., blk-wbt or
>>>> blk-iolatency) is configured. While efficient, enabling a static key at
>>>> runtime requires taking cpu_hotplug_lock and jump_label_mutex, which
>>>> becomes problematic if the queue is already frozen — causing a reverse
>>>> dependency on ->freeze_lock. This results in a lockdep splat indicating
>>>> a potential deadlock.
>>>>
>>>> To resolve this, we now gate q->rq_qos access with a q->queue_flags
>>>> bitop (QUEUE_FLAG_QOS_ENABLED), avoiding the static key and the associated
>>>> locking altogether.
>>>>
>>>> I compared both static key and atomic bitop implementations using ftrace
>>>> function graph tracer over ~50 invocations of rq_qos_issue() while ensuring
>>>> blk-wbt/blk-iolatency were disabled (i.e., no QoS functionality). For
>>>> easy comparision, I made rq_qos_issue() noinline. The comparision was
>>>> made on PowerPC machine.
>>>>
>>>> Static Key (disabled : QoS is not configured):
>>>> 5d0: 00 00 00 60     nop    # patched in by static key framework (not taken)
>>>> 5d4: 20 00 80 4e     blr    # return (branch to link register)
>>>>
>>>> Only a nop and blr (branch to link register) are executed — very lightweight.
>>>>
>>>> atomic bitop (QoS is not configured):
>>>> 5d0: 20 00 23 e9     ld      r9,32(r3)     # load q->queue_flags
>>>> 5d4: 00 80 29 71     andi.   r9,r9,32768   # check QUEUE_FLAG_QOS_ENABLED (bit 15)
>>>> 5d8: 20 00 82 4d     beqlr                 # return if bit not set
>>>>
>>>> This performs an ld and and andi. before returning. Slightly more work,
>>>> but q->queue_flags is typically hot in cache during I/O submission.
>>>>
>>>> With Static Key (disabled):
>>>> Duration (us): min=0.668 max=0.816 avg≈0.750
>>>>
>>>> With atomic bitop QUEUE_FLAG_QOS_ENABLED (bit not set):
>>>> Duration (us): min=0.684 max=0.834 avg≈0.759
>>>>
>>>> As expected, both versions are almost similar in cost. The added latency
>>>> from an extra ld and andi. is in the range of ~9ns.
>>>>
>>>> There're two patches in the series. The first patch replaces static key
>>>> with QUEUE_FLAG_QOS_ENABLED. The second patch ensures that we disable
>>>> the QUEUE_FLAG_QOS_ENABLED when the queue no longer has any associated
>>>> rq_qos policies.
>>>>
>>>> As usual, feedback and review comments are welcome!
>>>>
>>>> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>
>>>
>>> Another approach is to call memalloc_noio_save() in cpu hotplug code...
>>>
>> Yes that would help fix this. However per the general usage of GFP_NOIO scope in
>> kernel, it is used when we're performing memory allocations in a context where I/O
>> must not be initiated, because doing so could cause deadlocks or recursion.
>>
>> So we typically, use GFP_NOIO in a code path that is already doing I/O, such as:
>> - In block layer context: during request submission
>> - Filesystem writeback, or swap-out.
>> - Memory reclaim or writeback triggered by memory pressure.
>>
>> The cpu hotplug code may not be running in any of the above context. So
>> IMO, adding memalloc_noio_save() in the cpu hotplug code would not be
>> a good idea, isn't it?
> 
> Please heed Ming's advice, moving this from a static key to an atomic
> queue flags ops is pointless, may as well kill it at that point.

Nilay already tested and replied this is a dead end :(

I don't quite understand why it's pointless, if rq_qos is never enabled,
an atmoic queue_flag is still minor optimization, isn't it?

Thanks,
Kuai

> 
> I see v2 is out now with the exact same approach.
> 

