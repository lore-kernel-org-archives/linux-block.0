Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F6935973;
	Wed,  2 Jul 2025 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751441463; cv=none; b=ZDlDyeGoUQo5mq5SOpPI+diVQ8vpPrg1uFDTBcdt09j1nYAq9IK56DWXk7hwEOHk7UdxnbJALbU2OCcTMO70eTvxmrPYvaT6Fv8Sxsq17B0ofHjRS5AVO+U9NRdpGBeSZkF3ut3uYxRygWmJfAhomeQWqQyrOmxjfKFVo8ohSjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751441463; c=relaxed/simple;
	bh=5Cc7e/SfJA8EQwxf7TWjfe2YjMfT6TJJub7iPC8tuB4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=A7B+WsXR3u69AClR2ATwz41ax0TakCyOopfyL7mjikwYeJjnRN/zb9pM5crJRyDwXl35Uqho+6s6I3GhpkslCKodYjWVgXBel7iugaS8qx2gAx/gkbzDOKX0SYDJL1LB7NnvO+Vsa4aA2wAF43qke3f5VF9ccbp3w0g85n4fnAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bXBQV1KcFzKHMql;
	Wed,  2 Jul 2025 15:30:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 936911A0E79;
	Wed,  2 Jul 2025 15:30:56 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP3 (Coremail) with SMTP id _Ch0CgAHaCUs4GRo5NyXAQ--.46013S3;
	Wed, 02 Jul 2025 15:30:54 +0800 (CST)
Subject: Re: [PATCH] nbd: fix false lockdep deadlock warning
To: Nilay Shroff <nilay@linux.ibm.com>, Ming Lei <ming.lei@redhat.com>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, hch@infradead.org, hare@suse.de,
 linux-block@vger.kernel.org, nbd@other.debian.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250627092348.1527323-1-yukuai1@huaweicloud.com>
 <aF56oVEzTygIOUTN@fedora>
 <c2fbaacc-62a1-4a98-4157-2637b7f242b7@huaweicloud.com>
 <197b6dca-56be-438d-a60f-21011367c5ed@linux.ibm.com>
 <99b4afce-de05-ddcb-2634-b19214cf4534@huaweicloud.com>
 <aGSaVhiH2DeTvtdr@fedora>
 <7b09167f-bf8d-4d94-9317-3cfbb4f83cd8@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <bc3f20c3-21f8-443b-619f-da7569b37aaf@huaweicloud.com>
Date: Wed, 2 Jul 2025 15:30:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7b09167f-bf8d-4d94-9317-3cfbb4f83cd8@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHaCUs4GRo5NyXAQ--.46013S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCryUAw1UCw1DKF18uFyxGrg_yoW5ZrWrpr
	WkCFWxGrZ8Gw4Fgw1jkw43WFWFyrnrJ3W5Xr18Ga48CrWqvr9Yqr4Fqrs09ryDJrZ3Jr1U
	tayYyF1xZr1UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

在 2025/07/02 14:22, Nilay Shroff 写道:
> 
> 
> On 7/2/25 8:02 AM, Ming Lei wrote:
>> On Wed, Jul 02, 2025 at 09:12:09AM +0800, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2025/07/01 21:28, Nilay Shroff 写道:
>>>>
>>>>
>>>> On 6/28/25 6:18 AM, Yu Kuai wrote:
>>>>> Hi,
>>>>>
>>>>> 在 2025/06/27 19:04, Ming Lei 写道:
>>>>>> I guess the patch in the following link may be simper, both two take
>>>>>> similar approach:
>>>>>>
>>>>>> https://lore.kernel.org/linux-block/aFjbavzLAFO0Q7n1@fedora/
>>>>>
>>>>> I this the above approach has concurrent problems if nbd_start_device
>>>>> concurrent with nbd_start_device:
>>>>>
>>>>> t1:
>>>>> nbd_start_device
>>>>> lock
>>>>> num_connections = 1
>>>>> unlock
>>>>>       t2:
>>>>>       nbd_add_socket
>>>>>       lock
>>>>>       config->num_connections++
>>>>>       unlock
>>>>>           t3:
>>>>>           nbd_start_device
>>>>>           lock
>>>>>           num_connections = 2
>>>>>           unlock
>>>>>           blk_mq_update_nr_hw_queues
>>>>>
>>>>> blk_mq_update_nr_hw_queues
>>>>> //nr_hw_queues updated to 1 before failure
>>>>> return -EINVAL
>>>>>
>>>>
>>>> In the above case, yes I see that t1 would return -EINVAL (as
>>>> config->num_connections doesn't match with num_connections)
>>>> but then t3 would succeed to update nr_hw_queue (as both
>>>> config->num_connections and num_connections set to 2 this
>>>> time). Isn't it? If yes, then the above patch (from Ming)
>>>> seems good.
>>>
>>> Emm, I'm confused, If you agree with the concurrent process, then
>>> t3 update nr_hw_queues to 2 first and return sucess, later t1 update
>>> nr_hw_queues back to 1 and return failure.
>>
>> It should be easy to avoid failure by simple retrying.
>>
> Yeah I think retry should be a safe bet here.
> 

I really not sure about the retry, the above is just a scenario that I
think of with a quick review, and there are still many concurrent
scenarios that need to be checked, I'm kind of lost here.

Except nbd_start_device() and nbd_add_socked(), I'm not confident
other context that is synchronized with config_lock is not broken.
However, I'm ok with the bet.

> On another note, synchronizing nbd_start_device and nbd_add_socket
> using nbd->task_setup looks more complex and rather we may use
> nbd->pid to synchronize both. We need to move setting of nbd->pid
> before we invoke blk_mq_update_nr_hw_queues in nbd_start_device.
> Then in nbd_add_socket we can evaluate nbd->pid and if it's
> non-NULL then we could assume that either nr_hw_queues update is in
> progress or device has been setup and so return -EBUSY. I think
> anyways updating number of connections once device is configured
> would not be possible, so once nbd_start_device is initiated, we
> shall prevent user adding more connections. If we follow this
> approach then IMO we don't need to add retry discussed above.

It's ok for me to forbit nbd_add_socked after nbd is configured, there
is nowhere to use the added sock. And if there really are other contexts
need to be synchronized, I think nbd->pid can be used as well.

> 
> Thanks,
> --Nilay
> .
> 

