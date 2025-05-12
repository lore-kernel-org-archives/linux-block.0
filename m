Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187D3CF58
	for <linux-block@vger.kernel.org>; Mon, 12 May 2025 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747012793; cv=none; b=QvhP8Ie7+WpueG/VI3n+MbyXKLdNm0/sFqaZKtbnr0w1MfPP6j8SeZSJxelcrShUyu07TRUkZ4Q9t4Hp/rMAx2HjvwmwDdrQB2ZpQIlms60bRzuame7viU/CQQ6/qtIMzpX8Hjy6B22oIgM+qaegLPQmfyO2Ke1+Ne3SKcjTuwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747012793; c=relaxed/simple;
	bh=MqPkSFPQXwhaNQe0DmcesZKX5t4qJS8StKL9X9g86RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dn/30aoDeYJahpK19sMTJN6ghg+2Ml1AH9PtSSZZzZDnmVMickMZKN2bGyUiT/AljkK7aCVhI+zcoyOpn3lX91g765qsZ8iE9XHxuL0CaeTPR5jGjlwAjCKbTvhqDgB+Eniv8aNRogMLMF+hmU238UF8GFMsrt7SDY8NlQ4gR5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZwhbF4LQvz4f3jXg
	for <linux-block@vger.kernel.org>; Mon, 12 May 2025 09:19:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4BC581A1488
	for <linux-block@vger.kernel.org>; Mon, 12 May 2025 09:19:46 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl+uTCFoBbyVMA--.49770S3;
	Mon, 12 May 2025 09:19:44 +0800 (CST)
Message-ID: <e9ea6f2f-1aad-49b3-a9d7-95aa17baf49c@huaweicloud.com>
Date: Mon, 12 May 2025 09:20:00 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 0/7] blk-throttle: Split the blkthrotl queue to solve
 the IO delay issue
To: axboe@kernel.dk, linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, yukuai3@huawei.com, ming.lei@redhat.com,
 tj@kernel.org
References: <20250506020935.655574-1-wozizhi@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20250506020935.655574-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl+uTCFoBbyVMA--.49770S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWDAFW7WryDAr45AF13urg_yoW5ZF1Dpr
	WfWw4Yka1kJFsrK34fWr12qaySq397Jryakr97Jr43Jan5Zry0qF4SkrW8ZFWxAF9Iga1a
	gryUtF93CF1UZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

friendly ping

在 2025/5/6 10:09, Zizhi Wo 写道:
> Changes since V4:
> Patch 6 was modified to resolve the conflict.
> 
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
>   block/blk-throttle.c      | 300 ++++++++++++++++++++++++--------------
>   block/blk-throttle.h      |  17 ++-
>   include/linux/blk_types.h |   8 +
>   3 files changed, 213 insertions(+), 112 deletions(-)
> 

