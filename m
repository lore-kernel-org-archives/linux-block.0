Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096C42BDC08
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493480; cv=none; b=nxhiI75RRjVZazH5S+dLr8cr3zpi1l69B1zCyqholK0gT0U4CI0WpciM5lfB7TPjA4zKkyohlm5fQHTonttulKXtahOFja90KVQO7mzD395b/QisBEzowt6AeCqg548rSI2lYVRPXqsmYGYomPJhQA1xnEsBlzpJQppta9BPd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493480; c=relaxed/simple;
	bh=VFUL6onMNtytDNtDUiduSSGt9fTEE64HsKgq7DHv9Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pJGAgM222BYF+npKHDSH8qbhG/U+4YruI64EcsrOtPthRv6raFVzECWoQbS+hr97FZEDuCVwFXB4S6+cCX8bid4kLl/BE+9n1KCX6M5gvGj6gVISkDBU2+s5iYVh3SuBT/r4LeHpUcmHRjnOELVoKmfsghgDTYPN7uYqZN9f1no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zs0Rw3qwfzyVH7;
	Tue,  6 May 2025 09:00:12 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 52D73140135;
	Tue,  6 May 2025 09:04:27 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 May 2025 09:04:26 +0800
Message-ID: <7df3b05d-0e44-43b5-9d79-687e6297136c@huawei.com>
Date: Tue, 6 May 2025 09:04:25 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/7] blk-throttle: Split the blkthrotl queue to solve
 the IO delay issue
To: Zizhi Wo <wozizhi@huaweicloud.com>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>
CC: <yangerkun@huawei.com>, <yukuai3@huawei.com>, <ming.lei@redhat.com>,
	<tj@kernel.org>
References: <20250423022301.3354136-1-wozizhi@huaweicloud.com>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <20250423022301.3354136-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)

friendly ping

在 2025/4/23 10:22, Zizhi Wo 写道:
> Changes since V1-3:
> 1) Updated the comments in patches 4 and 6 for greater specificity.
> 2) In patch 6, replaced the @queued parameter with @sq in both
> throtl_qnode_add_bio and throtl_pop_queued to facilitate internal changes.
> And the potential problem of null pointer dereference has been fixed.
> 
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
> Noted, a regression test is posted earlier:
> https://lore.kernel.org/all/20250307080318.3860858-3-yukuai1@huaweicloud.com/
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
>   block/blk-throttle.c      | 302 ++++++++++++++++++++++++--------------
>   block/blk-throttle.h      |  17 ++-
>   include/linux/blk_types.h |   8 +
>   3 files changed, 214 insertions(+), 113 deletions(-)
> 
