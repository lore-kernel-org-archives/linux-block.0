Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8BA23A9A0;
	Fri, 15 Aug 2025 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248743; cv=none; b=rJEM+jo3TBIoXznLUinYK4kmETGOP5B0K12dfvpqEqkhu0mGxdQrWcDGrNtzfE5CzGaM6KNGetW+Mm0xa4jiIkHSh1lx+9UJaKHet1cZZyfMK2JVunu0wZAz3UadAf6OkIbksXojEAyFXjDGYYCydfaMavWLO8opkwI/OpUdwE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248743; c=relaxed/simple;
	bh=mKc1P53XG+rCnhVoLPZgdTOwUUOpQ4S+OcCGACdQcfo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PCs3lRrE4tSB2nZrpyxZE9jYG6JLpNbR/sdmEs0w6MPQdiBCrIlmj0d4inarOhfOX3tSRLvDvixdLhvyLoCO7mG3au9FbEjMyDBoFlTZ676KIVCApVQWJEE7p5KtRr5vSGMYUh+qS4gXYPjB4pWCRKCpdRynN1h/821TLVEwseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c3GRP4dy4zYQvDL;
	Fri, 15 Aug 2025 17:05:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 426D61A06D7;
	Fri, 15 Aug 2025 17:05:36 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHwhJe+J5oBoQDDw--.54303S3;
	Fri, 15 Aug 2025 17:05:36 +0800 (CST)
Subject: Re: [PATCH 00/10] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, hare@suse.de, nilay@linux.ibm.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
 <aJ7wMFkuTewlyx1P@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <abde1955-d634-29d4-d229-df8c6ebdc582@huaweicloud.com>
Date: Fri, 15 Aug 2025 17:05:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aJ7wMFkuTewlyx1P@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHwhJe+J5oBoQDDw--.54303S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1kJr4fGF4fWr4rur4fuFg_yoW8ZrWUpw
	4rWayakrs0qw18Jw4xJ34Fqw10yw4v9ryagryFyry8G3Z8XFWIvr4FqFsFqF97ur93GFsF
	9FZ7Xan7ZFZrZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/15 16:30, Ming Lei Ð´µÀ:
> On Fri, Aug 15, 2025 at 04:02:06PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> In the case user trigger tags grow by queue sysfs attribute nr_requests,
>> hctx->sched_tags will be freed directly and replaced with a new
>> allocated tags, see blk_mq_tag_update_depth().
>>
>> The problem is that hctx->sched_tags is from elevator->et->tags, while
>> et->tags is still the freed tags, hence later elevator exist will try to
>> free the tags again, causing kernel panic.
>>
>> patch 1-6 are prep cleanup and refactor patches for updating nr_requests
>> patch 7,8 are the fix patches for the regression
>> patch 9 is cleanup patch after patch 8
>> patch 10 fix the stale nr_requests documentation
> 
> Please do not mix bug(regression) fix with cleanup.
> 
> The bug fix for updating nr_requests should have been simple enough in single
> or two patches, why do you make 10-patches for dealing with the regression?

Ok, in short, my solution is:

- serialize switching elevator with updating nr_requests
- check the case that nr_requests will grow and allocate elevator_tags
before freezing the queue.
- for the grow case, switch to new elevator_tags.

I do tried and I can't find a easy way to fix this without making
related code uncomfortable. Perhaps because I do the cleanups and
refactor first and I can't think outside the box...

> 
> Not mention this way is really unfriendly for stable tree backport.

I checked the last time related code to queue_requests_store() was
changed is commit 3efe7571c3ae ("block: protect nr_requests update using
q->elevator_lock"), and I believe this is what the fixed patch relied
on, so I think backport will not have much conflicts.

Whatever stbale branch that f5a6604f7a44 ("block: fix lockdep warning
caused by lock dependency in elv_iosched_store") is backported, I can
make sure a proper fix is backported as well.

Thanks,
Kuai

> 
> 
> Thanks,
> Ming
> 
> 
> .
> 

