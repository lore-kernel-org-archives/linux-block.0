Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145F138DE8
	for <linux-block@vger.kernel.org>; Sun,  7 Apr 2024 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712497267; cv=none; b=CZTpL1fH3M5D0mOGHmr92l3VWGgc3Q9l/+6ywhjfgtOdutJpUeXQBurmwV4VRSalbZ9emwWB3LCNRxok1OijJkA+FQ0v0HpqGfTGc7jDhujOhX5ixf9H/ZrgPze/AoDT/Zf1qzsrL6O19QiOuuIwK/CaiBhjFmrxw5A2Y3iHs7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712497267; c=relaxed/simple;
	bh=pfKr2f+5rlaC2chXNhscUfFCe3/+iykU82K5dX9ShY8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rpS16W6XJMLYTq3hIQAdDr/amwPRi7eEoONVQmkwyJSsxoBbJWbKiH4cTC9vSv60B0Cv1yeMIk9DzLRTXNImfP6fF6syHFtMXepR1ClMPI6Aj191CVdxoTqw2bKcjvc6FVG8nUg5IZSjvYbp5eeEftnuQyx7qCdgE6gZ+Sne/JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VCCzN6gfxz4f3jcq
	for <linux-block@vger.kernel.org>; Sun,  7 Apr 2024 21:40:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A15491A0568
	for <linux-block@vger.kernel.org>; Sun,  7 Apr 2024 21:40:55 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g5kohJm4ndlJQ--.55414S3;
	Sun, 07 Apr 2024 21:40:54 +0800 (CST)
Subject: Re: [PATCH] block: fix q->blkg_list corruption during disk rebind
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
References: <20240407125910.4053377-1-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <eaa3d105-f37b-3c3b-9e3d-340ae8f5f252@huaweicloud.com>
Date: Sun, 7 Apr 2024 21:40:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240407125910.4053377-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g5kohJm4ndlJQ--.55414S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW5uw17tFy8Xw4xtw1fWFg_yoWrWrWrpr
	Z8JF45A3yIgF4DuF47Xw47X34Sgw48GryrG393K3yYyry2yr4vvF17ZFnrZFWxAFsrAF45
	ZF4UtFZFkr4jk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/04/07 20:59, Ming Lei Ð´µÀ:
> Multiple gendisk instances can allocated/added for single request queue
> in case of disk rebind. blkg may still stay in q->blkg_list when calling
> blkcg_init_disk() for rebind, then q->blkg_list becomes corrupted.
> 
> Fix the list corruption issue by:
> 
> - add blkg_init_queue() to initialize q->blkg_list & q->blkcg_mutex only
> - move calling blkg_init_queue() into blk_alloc_queue()
> 
> The list corruption should be started since commit f1c006f1c685 ("blk-cgroup:
> synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
> which delays removing blkg from q->blkg_list into blkg_free_workfn().

I'm not familiar with how bind/unbind works yet, however, the patch
itself looks reasonable to me, the initialization of fields related to
queue should not be delayed to disk allocation.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

BTW, it looks like the whole blkcg_init_disk() can go away:
  - init of ioprio and blk-throttle can be delayed to the first user
configuration;
  - root_blkg allocation doesn't rely on disk at all;

Or is there any plan to move the blkcg related field or code path to
gendisk instead of queue? I might missing some previous discussions.

Thanks,
Kuai

> 
> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
> Fixes: 1059699f87eb ("block: move blkcg initialization/destroy into disk allocation/release handler")
> Cc: Yu Kuai <yukuai3@huawei.com>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> blktests:
> 	https://lore.kernel.org/linux-block/20240407125717.4052964-1-ming.lei@redhat.com/
> 
>   block/blk-cgroup.c | 9 ++++++---
>   block/blk-cgroup.h | 2 ++
>   block/blk-core.c   | 2 ++
>   3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index bdbb557feb5a..059467086b13 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1409,6 +1409,12 @@ static int blkcg_css_online(struct cgroup_subsys_state *css)
>   	return 0;
>   }
>   
> +void blkg_init_queue(struct request_queue *q)
> +{
> +	INIT_LIST_HEAD(&q->blkg_list);
> +	mutex_init(&q->blkcg_mutex);
> +}
> +
>   int blkcg_init_disk(struct gendisk *disk)
>   {
>   	struct request_queue *q = disk->queue;
> @@ -1416,9 +1422,6 @@ int blkcg_init_disk(struct gendisk *disk)
>   	bool preloaded;
>   	int ret;
>   
> -	INIT_LIST_HEAD(&q->blkg_list);
> -	mutex_init(&q->blkcg_mutex);
> -
>   	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
>   	if (!new_blkg)
>   		return -ENOMEM;
> diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
> index 78b74106bf10..90b3959d88cf 100644
> --- a/block/blk-cgroup.h
> +++ b/block/blk-cgroup.h
> @@ -189,6 +189,7 @@ struct blkcg_policy {
>   extern struct blkcg blkcg_root;
>   extern bool blkcg_debug_stats;
>   
> +void blkg_init_queue(struct request_queue *q);
>   int blkcg_init_disk(struct gendisk *disk);
>   void blkcg_exit_disk(struct gendisk *disk);
>   
> @@ -482,6 +483,7 @@ struct blkcg {
>   };
>   
>   static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
> +static inline void blkg_init_queue(struct request_queue *q) { }
>   static inline int blkcg_init_disk(struct gendisk *disk) { return 0; }
>   static inline void blkcg_exit_disk(struct gendisk *disk) { }
>   static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
> diff --git a/block/blk-core.c b/block/blk-core.c
> index a16b5abdbbf5..3a6f5603fb44 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -442,6 +442,8 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
>   	init_waitqueue_head(&q->mq_freeze_wq);
>   	mutex_init(&q->mq_freeze_lock);
>   
> +	blkg_init_queue(q);
> +
>   	/*
>   	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
>   	 * See blk_register_queue() for details.
> 

