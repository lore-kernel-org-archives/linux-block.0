Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0FF1C6B4;
	Wed,  2 Jul 2025 01:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418740; cv=none; b=Ob223oFXCCpVvFnnMIIXHhHU3xInQtnV/YvErcrHM3wFMb6BO4HrGSYNl/UmqhaNv9guH62BieMM4i47GDKPpJ51KTIvhqlM141oKaxtPLhD8UZIAxVAORebJ3oQodWtXQvH9LpwSe82temdqgg8LFtVv68+MykDmiBxy2gD9Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418740; c=relaxed/simple;
	bh=N5+gz5om4Byi90spvxYFYA2quL0W1CQzGIFb7DubHi4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gQgJjZLMM1XyMJ+uYaFaD180fY0Lz6V5ZIxBp6oBbvgw1L2ADFbx03n6GRiGKXubOIopErQionouwD7oEUeJtaB8zbaYSeD47L0e6OH5JETIMbT6Us6Hizseg/0XZ0u5luK0I+idWS13DakCHOqiLHeUeLq5J8GEACKr4g7usb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bX21W0QgpzYQvCD;
	Wed,  2 Jul 2025 09:12:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E50021A08DC;
	Wed,  2 Jul 2025 09:12:13 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP3 (Coremail) with SMTP id _Ch0CgB3JSNph2RotTN7AQ--.3691S3;
	Wed, 02 Jul 2025 09:12:11 +0800 (CST)
Subject: Re: [PATCH] nbd: fix false lockdep deadlock warning
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, hch@infradead.org, hare@suse.de,
 linux-block@vger.kernel.org, nbd@other.debian.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250627092348.1527323-1-yukuai1@huaweicloud.com>
 <aF56oVEzTygIOUTN@fedora>
 <c2fbaacc-62a1-4a98-4157-2637b7f242b7@huaweicloud.com>
 <197b6dca-56be-438d-a60f-21011367c5ed@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <99b4afce-de05-ddcb-2634-b19214cf4534@huaweicloud.com>
Date: Wed, 2 Jul 2025 09:12:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <197b6dca-56be-438d-a60f-21011367c5ed@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3JSNph2RotTN7AQ--.3691S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urW7Ww4xAFWfZrW5WrWfKrg_yoW8Xr45pF
	ZYkFW7GrW5K3ZYq34jkw1UCFWrCr1DJa1Dtr1UWa47CrWUZrZY9r40qrnIgryUJrWkJr1U
	ta4YyF43uw43ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2025/07/01 21:28, Nilay Shroff 写道:
> 
> 
> On 6/28/25 6:18 AM, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/06/27 19:04, Ming Lei 写道:
>>> I guess the patch in the following link may be simper, both two take
>>> similar approach:
>>>
>>> https://lore.kernel.org/linux-block/aFjbavzLAFO0Q7n1@fedora/
>>
>> I this the above approach has concurrent problems if nbd_start_device
>> concurrent with nbd_start_device:
>>
>> t1:
>> nbd_start_device
>> lock
>> num_connections = 1
>> unlock
>>      t2:
>>      nbd_add_socket
>>      lock
>>      config->num_connections++
>>      unlock
>>          t3:
>>          nbd_start_device
>>          lock
>>          num_connections = 2
>>          unlock
>>          blk_mq_update_nr_hw_queues
>>
>> blk_mq_update_nr_hw_queues
>> //nr_hw_queues updated to 1 before failure
>> return -EINVAL
>>
> 
> In the above case, yes I see that t1 would return -EINVAL (as
> config->num_connections doesn't match with num_connections)
> but then t3 would succeed to update nr_hw_queue (as both
> config->num_connections and num_connections set to 2 this
> time). Isn't it? If yes, then the above patch (from Ming)
> seems good.

Emm, I'm confused, If you agree with the concurrent process, then
t3 update nr_hw_queues to 2 first and return sucess, later t1 update
nr_hw_queues back to 1 and return failure.

Thanks,
Kuai

> 
> Thanks,
> --Nilay
> .
> 

