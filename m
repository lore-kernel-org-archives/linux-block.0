Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7915BB
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711070094; cv=none; b=AC4So8fYIT0WVl+M2WJl46o/bZicYVF3DKalfyT5fN+GjVWnI5ykPGIUM6+8IRK4kcToGr/3REJEm3hzJJyAH6/JqMBvjSarnBNhv6TIo7v2mYyMu70nPyaRfJNVPVnaa+uqJxzNlJSOO6g/PWfnKY9oldBeTMrszIvRDoHB5MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711070094; c=relaxed/simple;
	bh=2JFQktj5AWgoOBK9SGTojkeJLTtfyLcUoUngn8N0N2Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jduiLvJGKD5EbUOnG8gXfPjn9rjrCo+ZPcjSB9UfiUcNqxm5QV3sIKFdTQsrv4cTm+Rlb4OuuO08DxnsCkoylb9HLGtFvdyxO3Z/OS+8vFzCLPEt7igqRB8EB4nLVWtrzogiQKxz1p/hk0OSqVsLzyIEC4df0jYPZgL74LPEWJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V149t0xw5z4f3l6h
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 09:14:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2F4F51A0DC7
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 09:14:48 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g6G2_xlZpXCHg--.14849S3;
	Fri, 22 Mar 2024 09:14:48 +0800 (CST)
Subject: Re: [PATCH] block: Improve IOPS by removing the fairness code
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240321224605.107783-1-bvanassche@acm.org>
 <20240321224814.GA23127@lst.de>
 <13f47d63-2140-4927-8933-009dae21f7e6@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <33581b6a-c350-b523-b31e-787f74d97e71@huaweicloud.com>
Date: Fri, 22 Mar 2024 09:14:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <13f47d63-2140-4927-8933-009dae21f7e6@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g6G2_xlZpXCHg--.14849S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1rZryUKrWfZr17XF4ktFb_yoW8Xw43pF
	WUKa1jkw4kGan8Xw4xGwsrXr1Sywn7Jr17GrnYqwnYkr98ZrnIvr93KF4UWF1IvFn3Z34U
	uayS93sxWr1jvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/03/22 7:03, Bart Van Assche 写道:
> On 3/21/24 15:48, Christoph Hellwig wrote:
>> On Thu, Mar 21, 2024 at 03:46:05PM -0700, Bart Van Assche wrote:
>>> There is an algorithm in the block layer for maintaining fairness
>>> across queues that share a tag set. The sbitmap implementation has
>>> improved so much that we don't need the block layer fairness algorithm
>>> anymore and that we can rely on the sbitmap implementation to guarantee
>>> fairness.
>>
>> IFF that was true it would be awesome.  But do you have proof for that
>> assertation?
> 
> Hi Christoph,
> 
> Is the test in this pull request sufficient as evidence that we don't
> need the request queue fairness code anymore:
> https://github.com/osandov/blktests/pull/135?
> 
> That test does the following:
> * Create two request queues with a shared tag set and with different
>    completion times (1 ms and 100 ms).
> * Submit I/O to both request queues simultaneously and set the queue
>    depth for both tests to the number of tags. This creates contention
>    on tag allocation.
> * After I/O finished, check that the fio job with the shortest
>    completion time submitted the most requests.

This test is a little one-sided, I'm curious how the following test
shows as well:

- some queue is under heavy IO pressure with lots of thread, and they
can use up all the drivers tags;
- one queue only issue one IO at a time, then how does IO latency shows
for this queue? I assume this can be bad with this patch because sbitmap
implementation can't gurantee this.

Thanks,
Kuai

> 
> Thanks,
> 
> Bart.
> 
> .
> 

