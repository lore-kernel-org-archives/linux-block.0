Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C5121A453;
	Tue, 26 Aug 2025 06:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189666; cv=none; b=OUDh8o7VF5V3KuPC1dynhzy2J1X80Xs4Yi5R6sYR3rdsTcDnQnZTBC1uMj3yMLyFifxUkDDJm0D/FGrUQdQ3WifETPgFPDXTVmlvA3SmVZ4AfjvHeH5utERA/KRGgwKyPuomOnYw9WlCzPqoLI5kg160bqM4HlFNlSQuB/pfz7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189666; c=relaxed/simple;
	bh=r0h+91TIIPBHTec6V3ZjgapP7MwF3HiLZxw0A69u1oQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bTZJVYxzvGiQ+JM3HIqIXGDySfmCm40t8LCsVCzd54s0p0h8/KMlKzZg0G5gXmb2cxAkfOQhWdOQ0G70MEsav6yFpxLKlaHl29f0HmmjK1sungxY8tqJpQ2LEZJkbG5iay3NkvyVdhBqnrxkqJdxvJjNg+rHZY7VwazDrMO565Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c9yQ55jk9zYQvf1;
	Tue, 26 Aug 2025 14:27:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 557411A084D;
	Tue, 26 Aug 2025 14:27:40 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Y3YU61o3MNUAQ--.23294S3;
	Tue, 26 Aug 2025 14:27:38 +0800 (CST)
Subject: Re: [PATCH v3 0/2] blk-mq: fix update nr_requests regressions
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
 ming.lei@redhat.com, nilay@linux.ibm.com, hare@suse.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <95389918-b809-f81b-5fd0-2e350154ca01@huaweicloud.com>
Date: Tue, 26 Aug 2025 14:27:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8Y3YU61o3MNUAQ--.23294S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4rtrWDJryrCrW8Cr45Wrg_yoW8Wry3pr
	W3tFsIkr18Kr4xXF4fAw17Xr1rAw4kXw15uFsxtw1rJ3s09r1xGF10gF18WF9FqrWSgrsF
	grn0q34DWw1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU52NtDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Jens

ÔÚ 2025/08/21 14:06, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v3:
>   - call depth_updated() directly in init_sched() method in patch 1;
>   - fix typos in patch 2;
>   - add review for patch 2;
> Changes in v2:
>   - instead of refactor and cleanups and fix updating nr_requests
>   thoroughly, fix the regression in patch 2 the easy way, and dealy
>   refactor and cleanups to next merge window.
> 
> patch 1 fix regression that elevator async_depth is not updated correctly
> if nr_requests changes, first from error path and then for mq-deadline,
> and recently for bfq and kyber.
> 
> patch 2 fix regression that if nr_requests grow, kernel will panic due
> to tags double free.
> 
> Yu Kuai (2):
>    blk-mq: fix elevator depth_updated method
>    blk-mq: fix blk_mq_tags double free while nr_requests grown
> 
>   block/bfq-iosched.c   | 22 +++++-----------------
>   block/blk-mq-sched.h  | 11 +++++++++++
>   block/blk-mq-tag.c    |  1 +
>   block/blk-mq.c        | 23 ++++++++++++-----------
>   block/elevator.h      |  2 +-
>   block/kyber-iosched.c | 19 +++++++++----------
>   block/mq-deadline.c   | 16 +++-------------
>   7 files changed, 42 insertions(+), 52 deletions(-)
> 

Friendly ping, please consider this set in this merge window.

BTW, I see that for-6.18/block branch was created, however, I have
a pending set[1] for the next merge window that will have conflicts with
this set, not sure if you want to rebase for-6.18/block with block-6.17
or handle conflicts later for 6.18-rc1.

[1] 
https://lore.kernel.org/all/20250815080216.410665-1-yukuai1@huaweicloud.com/

Thanks,
Kuai

