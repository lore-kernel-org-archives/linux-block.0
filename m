Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4633A1BA
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744681438; cv=none; b=ZA1HFn/fR7DEJXHGxYN6ZzTWGIZJlO62j+v8iuImnNlQTHRTrLEz0UO6Ocb1vyfkWp2B2tL//FWS/9a5ahvTMup9zQ/UY0YpiBHmyDpQn6L8wELUYPGObm4MwW+2kNY3jy5ErXDEZW9blDLfZfaXscDQbg5M22Xf10USYlkPQxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744681438; c=relaxed/simple;
	bh=Dt8WxWb4WRd2i7AOWVZlGDbElOhiVhREcXRM3Hj8hg4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fPsG6CjzXdP7YAsL21KJ1Egv138Y5SbYXWSwHe215v/8lUkXzr5YtQw+pss3MtQ5VzJIcKkt2CwoqX5QAt+LvT2hJSyeXoO+Wua/6Qf8Uqq6idKdaMVK0jb9x7bLiur5eB5dNMTlTbLSfT4zPmuwhUZGT4QGvNKKlO9zc3CK4Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zc6Pd0kYLz4f3jt8
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 09:43:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5E1AA1A06D7
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 09:43:51 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDHK2DUuf1nOuoOJg--.42767S3;
	Tue, 15 Apr 2025 09:43:49 +0800 (CST)
Subject: Re: [PATCH 0/7] blk-throttle: Split the blkthrotl queue to solve the
 IO delay issue
To: Zizhi Wo <wozizhi@huawei.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, ming.lei@redhat.com, tj@kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250414132731.167620-1-wozizhi@huawei.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <49ba168b-1f8d-cbff-4d4e-0f913a0d264b@huaweicloud.com>
Date: Tue, 15 Apr 2025 09:43:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250414132731.167620-1-wozizhi@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHK2DUuf1nOuoOJg--.42767S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCrWkuw43AF4DZF18WryrCrg_yoW5WrWxpr
	WfWa1Yka1kAFsrK34fWr1aqaySq3yxJry3Cr97Jr43JrykZry0qF4ftrW8ZFWxAF9Iga1a
	gryUtF93u3WUZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/04/14 21:27, Zizhi Wo Ð´µÀ:
> [BUG]
> The current blkthrotl code provides two types of throttling: BPS limit and
> IOPS limit. When both limits are enabled, an IO is only dispatched if it
> meets both the BPS and IOPS restrictions. However, when both BPS and IOPS
> are limited simultaneously, an IO delayed dispatch issue can occur due to
> IO splitting. For example, if two 1MB IOs are issued with a BPS limit of
> 1MB/s and a very high IOPS limit, the IO splitting will cause both IOs to
> complete almost "simultaneously" in 2 seconds.
> 
> [CAUSE]
> The root cause of this issue is that blkthrotl mixes BPS and IOPS into a
> single queue. When issuing multiple IOs sequentially, the continuously
> split IOs will repeatedly enter the same queue. As they alternately go
> through the throtl process, IOs that have already been throttled will have
> to wait for IOs that have not yet been throttled. As a result, all IOs will
> eventually complete almost together.
> 
> [FIX]
> Since IO requests that have already been split no longer need to go through
> BPS throttling but still require IOPS control, this patchset splits the
> existing blkthrotl queue into two separate queues: BPS and IOPS.
> 1) IO requests must first pass through the BPS queue.
> 2) Once they meet the BPS limit, they proceed to the IOPS queue before
> being dispatched.
> 3) Already split IO requests bypass the BPS queue and go directly to the
> IOPS queue.
> 
> [OVERVIEW]
> This patchset consists of 7 patches:
> 1) Patch 1 is a simple clean_up.
> 2) Patch 2-4, to facilitate the subsequent splitting of queues. Patch 2-3
> separate the -dispatch- and -charge- functions based on the BPS and IOPS.
> Patch 4 introduce a new flag to prevent double counting.
> 3) Patch 5-6 splits the original single queue into two separate queues(BPS
> and IOPS) without altering the existing code logic.
> 4) Patch 7 ensures that split IO requests bypass the BPS queue, preventing
> unnecessary throttling and eliminating the delay issue.
> 
> Zizhi Wo (7):
>    blk-throttle: Rename tg_may_dispatch() to tg_dispatch_time()
>    blk-throttle: Refactor tg_dispatch_time by extracting
>      tg_dispatch_bps/iops_time
>    blk-throttle: Split throtl_charge_bio() into bps and iops functions
>    blk-throttle: Introduce flag "BIO_TG_BPS_THROTTLED"
>    blk-throttle: Split the blkthrotl queue
>    blk-throttle: Split the service queue
>    blk-throttle: Prevents the bps restricted io from entering the bps
>      queue again
> 
>   block/blk-throttle.c      | 288 +++++++++++++++++++++++++-------------
>   block/blk-throttle.h      |  14 +-
>   include/linux/blk_types.h |   5 +
>   3 files changed, 202 insertions(+), 105 deletions(-)
> 

Noted, a regression test is posted earlier:

https://lore.kernel.org/all/20250307080318.3860858-3-yukuai1@huaweicloud.com/

Thanks,
Kuai

