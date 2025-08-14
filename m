Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3982EA155
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163287; cv=none; b=IEpWCy/OKm9/fhIriUJ7goAlJvWiV/t5ym5VLil+yVGD/mUmFhNlk0KRaEFFAkQwIDCdjdcdWeIC/4Zb4mlmrZJuv2GvvldWQaRnvA74JH3+qiKAibiZmFz16eBb2OSA+2GCQ8259zekCZJCNKqXc53SaHjydGgP6j36PAGvZLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163287; c=relaxed/simple;
	bh=cWRx3PUKi39zaVQ07WjNaQt4do6T1kys+9jkfSXNGxs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qazxwcCT8vFhfPUGabHMUXYhdhwkerEUlOxYA1xBQy2ZzxhHTltSMI0iYoGV8Dppxtl9BJKBGS0/E7K0yun+Yv3kZxdMOOa0flGGWhyDEYEpZaBgfO09M8O27qQUgpA1I6P3eC0PAy0Wp2wf8XJCzbyANv8gz58wmQj6vkjwUOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2fr31gfGzYQv5J
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 17:21:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D01041A0359
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 17:21:21 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXkxOPqp1osdiSDg--.13215S3;
	Thu, 14 Aug 2025 17:21:20 +0800 (CST)
Subject: Re: [PATCHv3 3/3] block: avoid cpu_hotplug_lock depedency on
 freeze_lock
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, ming.lei@redhat.com, yukuai1@huaweicloud.com,
 hch@lst.de, shinichiro.kawasaki@wdc.com, kch@nvidia.com, gjoyce@ibm.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
 <20250814082612.500845-4-nilay@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c7bb59f1-9ba9-8f91-0945-94c3c709e6da@huaweicloud.com>
Date: Thu, 14 Aug 2025 17:21:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250814082612.500845-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXkxOPqp1osdiSDg--.13215S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWDKw17urWrGF18CF4xXrb_yoW8Kryrpa
	93Wr43CF4DWFn2gan3Kw4UAFy5Cws5ur17JFnxWr1Sva4UZw129FySvw1rtF9avrZ2y3ZY
	va1UJr92gw1UG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/08/14 16:24, Nilay Shroff Ð´µÀ:
> A recent lockdep[1] splat observed while running blktest block/005
> reveals a potential deadlock caused by the cpu_hotplug_lock dependency
> on ->freeze_lock. This dependency was introduced by commit 033b667a823e
> ("block: blk-rq-qos: guard rq-qos helpers by static key").
> 
> That change added a static key to avoid fetching q->rq_qos when
> neither blk-wbt nor blk-iolatency is configured. The static key
> dynamically patches kernel text to a NOP when disabled, eliminating
> overhead of fetching q->rq_qos in the I/O hot path. However, enabling
> a static key at runtime requires acquiring both cpu_hotplug_lock and
> jump_label_mutex. When this happens after the queue has already been
> frozen (i.e., while holding ->freeze_lock), it creates a locking
> dependency from cpu_hotplug_lock to ->freeze_lock, which leads to a
> potential deadlock reported by lockdep [1].
> 
> To resolve this, replace the static key mechanism with q->queue_flags:
> QUEUE_FLAG_QOS_ENABLED. This flag is evaluated in the fast path before
> accessing q->rq_qos. If the flag is set, we proceed to fetch q->rq_qos;
> otherwise, the access is skipped.
> 
> Since q->queue_flags is commonly accessed in IO hotpath and resides in
> the first cacheline of struct request_queue, checking it imposes minimal
> overhead while eliminating the deadlock risk.
> 
> This change avoids the lockdep splat without introducing performance
> regressions.
> 
> [1]https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> 
> Reported-by: Shinichiro Kawasaki<shinichiro.kawasaki@wdc.com>
> Closes:https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
> Tested-by: Shin'ichiro Kawasaki<shinichiro.kawasaki@wdc.com>
> Signed-off-by: Nilay Shroff<nilay@linux.ibm.com>
> ---
>   block/blk-mq-debugfs.c |  1 +
>   block/blk-rq-qos.c     |  9 ++++---
>   block/blk-rq-qos.h     | 54 ++++++++++++++++++++++++------------------
>   include/linux/blkdev.h |  1 +
>   4 files changed, 37 insertions(+), 28 deletions(-)

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

