Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6FF1EB5E3
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 02:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768531372; cv=none; b=bropaHQd0jaPLd4ZX4O3ergUakZOmEgHElhnCDAA6pCacVcdkn8mMof9dlSTq3TA/QOcAX12P02fEsSlkGYoKw+FjcFmXUJPop8N1td4apkp/cu5A7ycikMzaDNFK7QUu9aPzlLqewUCBA+qoBYq+hQyvOLbgIAlS4+t/INgAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768531372; c=relaxed/simple;
	bh=rLsYooGVNze0v/4LsySEpsJCMM+QEqV+kZ+KESbHc8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m41r2BJKBu4bQHHPgZ9i00vVymTefgaIRg+yJeruXAlQIPvnBQQIYeApuGSHU14u1QdkeFhkm36PmHn4c3/5xYh9w3bn27LRVLbuufRhaaEe+5lTlYbc2SBIlNQG4SostRzDVCZSKRbbS59Wjawkw744VrevSLCyVb7w9cp7184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dskdV06ctzKHLy1
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 10:41:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7F4894058A
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 10:42:44 +0800 (CST)
Received: from [10.174.178.72] (unknown [10.174.178.72])
	by APP4 (Coremail) with SMTP id gCh0CgAXePiepWlp3zbbDw--.18371S3;
	Fri, 16 Jan 2026 10:42:40 +0800 (CST)
Message-ID: <f259092e-0ee3-4bcd-ab49-25cbb46edf66@huaweicloud.com>
Date: Fri, 16 Jan 2026 10:42:36 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] blk-cgroup: skip dying blkg in
 blkcg_activate_policy()
To: Yu Kuai <yukuai@fnnas.com>
Cc: mkoutny@suse.com, hch@infradead.org, axboe@kernel.dk,
 linux-block@vger.kernel.org, tj@kernel.org, nilay@linux.ibm.com,
 ming.lei@redhat.com, Zheng Qixing <zhengqixing@huawei.com>
References: <20260115163818.162968-1-yukuai@fnnas.com>
 <20260115163818.162968-5-yukuai@fnnas.com>
From: Zheng Qixing <zhengqixing@huaweicloud.com>
In-Reply-To: <20260115163818.162968-5-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXePiepWlp3zbbDw--.18371S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr43AF45CF43Kr4xZFyxKrg_yoW8CFy3pr
	ZxG3Z0kr9rKFyIka129a47X340vF4ftr1UG3yak3yY9rZxA3WSyFnrurn8JFWxAFs3AFWr
	Z3ZIqFyUKw48K3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/


在 2026/1/16 0:38, Yu Kuai 写道:
> From: Zheng Qixing <zhengqixing@huawei.com>
>
> When switching IO schedulers on a block device, blkcg_activate_policy()
> can race with concurrent blkcg deletion, leading to a use-after-free in
> rcu_accelerate_cbs.
>
> T1:                               T2:
>                                    blkg_destroy
>                                    kill(&blkg->refcnt) // blkg->refcnt=1->0
>                                    blkg_release // call_rcu(__blkg_release)
>                                    ...
>                                    blkg_free_workfn
>                                    ->pd_free_fn(pd)
> elv_iosched_store
> elevator_switch
> ...
> iterate blkg list
> blkg_get(blkg) // blkg->refcnt=0->1
>                                    list_del_init(&blkg->q_node)
> blkg_put(pinned_blkg) // blkg->refcnt=1->0
> blkg_release // call_rcu again
> rcu_accelerate_cbs // uaf
>
> Fix this by checking hlist_unhashed(&blkg->blkcg_node) before getting
> a reference to the blkg. This is the same check used in blkg_destroy()
> to detect if a blkg has already been destroyed. If the blkg is already
> unhashed, skip processing it since it's being destroyed.
>
> Link: https://lore.kernel.org/all/20260108014416.3656493-4-zhengqixing@huaweicloud.com/
> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---
>   block/blk-cgroup.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index a6ac6ba9430d..8d9273f61dd5 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1625,6 +1625,8 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>   			 * GFP_NOWAIT failed.  Free the existing one and
>   			 * prealloc for @blkg w/ GFP_KERNEL.
>   			 */
> +			if (hlist_unhashed(&blkg->blkcg_node))
> +				continue;
>   			if (pinned_blkg)
>   				blkg_put(pinned_blkg);
>   			blkg_get(blkg);

Looks good.


Thanks,

Qixing

