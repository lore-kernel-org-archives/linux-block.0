Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCFC2F4A19;
	Fri,  5 Sep 2025 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056809; cv=none; b=XHxVt6KSG3WT+lLlabvcfhAXMvn6LMk3cgSJw4dyDey/G40f6N5oIshznbjEhO41OUcFy8tpaKBEn7kWGw5CLLxIxF6oD9nCD5kRyVGphbbsldWQnbqLEZHjM/1pzgGmvS0w81KfyqxXtS4aqc/Xk6b0Gomjp94amptzu1CWd44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056809; c=relaxed/simple;
	bh=d3MhxYFWdpuDbIbKX3VsMWBE+wEo3XzfqmNa/b9vZgE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uO3eB6DP5PBFefmBf0E1qlyJsNSIlh9zgDLTCzrIMV3uh78U1jlEKFJy8iM/5cGGMLL24eo1udU/oel1IDi67Nn2n2vSP7Hvuop/jF15tKDnWHHNIEYckipEXj4z1UeWchKjsjpcOUklP1Rg7YaOoMK39P3XHlEbJFHFJ+9lEw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cJ75y6bLgzYQvYm;
	Fri,  5 Sep 2025 15:20:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 68C0E1A08FC;
	Fri,  5 Sep 2025 15:20:05 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAncY0kj7povtzQBQ--.42269S3;
	Fri, 05 Sep 2025 15:20:05 +0800 (CST)
Subject: Re: [PATCH v3 0/2] blk-mq: fix update nr_requests regressions
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
 ming.lei@redhat.com, nilay@linux.ibm.com, hare@suse.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
 <95389918-b809-f81b-5fd0-2e350154ca01@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f4231a7f-cc73-c506-e30b-b2bfa9d98dba@huaweicloud.com>
Date: Fri, 5 Sep 2025 15:20:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <95389918-b809-f81b-5fd0-2e350154ca01@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncY0kj7povtzQBQ--.42269S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyUZF4UWw1UuFW5Aw1fZwb_yoW8Cryrpr
	s3Xa13Cr18Wrsaqr4fAw17XryrAw4vqw15Crsxtw1fC34Y9F1xXF18WF10gFyqqrWfWr42
	grn8tryDWr1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Jens

在 2025/08/26 14:27, Yu Kuai 写道:
> Hi, Jens
> 
> 在 2025/08/21 14:06, Yu Kuai 写道:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Changes in v3:
>>   - call depth_updated() directly in init_sched() method in patch 1;
>>   - fix typos in patch 2;
>>   - add review for patch 2;
>> Changes in v2:
>>   - instead of refactor and cleanups and fix updating nr_requests
>>   thoroughly, fix the regression in patch 2 the easy way, and dealy
>>   refactor and cleanups to next merge window.
>>
>> patch 1 fix regression that elevator async_depth is not updated correctly
>> if nr_requests changes, first from error path and then for mq-deadline,
>> and recently for bfq and kyber.
>>
>> patch 2 fix regression that if nr_requests grow, kernel will panic due
>> to tags double free.
>>
>> Yu Kuai (2):
>>    blk-mq: fix elevator depth_updated method
>>    blk-mq: fix blk_mq_tags double free while nr_requests grown
>>
>>   block/bfq-iosched.c   | 22 +++++-----------------
>>   block/blk-mq-sched.h  | 11 +++++++++++
>>   block/blk-mq-tag.c    |  1 +
>>   block/blk-mq.c        | 23 ++++++++++++-----------
>>   block/elevator.h      |  2 +-
>>   block/kyber-iosched.c | 19 +++++++++----------
>>   block/mq-deadline.c   | 16 +++-------------
>>   7 files changed, 42 insertions(+), 52 deletions(-)
>>
> 
> Friendly ping, please consider this set in this merge window.
> 
> BTW, I see that for-6.18/block branch was created, however, I have
> a pending set[1] for the next merge window that will have conflicts with
> this set, not sure if you want to rebase for-6.18/block with block-6.17
> or handle conflicts later for 6.18-rc1.
> 
> [1] 
> https://lore.kernel.org/all/20250815080216.410665-1-yukuai1@huaweicloud.com/ 
> 
Friendly ping ...

Thanks,
Kuai

> 
> Thanks,
> Kuai
> 
> .
> 

