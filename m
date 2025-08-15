Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050742749DF
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249322; cv=none; b=tCFmzWDtrjObIivw15zWk+oTap23jghaQL5K6A5WHoZyWQBIuKoYd5JqECNF6gX6K0qeAepnElfcqbPDBrzA2gH7jLEu09Qq0qUP0EQ2nyrSz6eJ9oSsoiP5uZRzDymnLrch17Hbx2PxSETDwJRrH6gVs29FX49cSZBuNQ0YaOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249322; c=relaxed/simple;
	bh=XW0gn0ZmzJyCnlim0ziC/JrGDuiDA6P+BwDUSHgjZD8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AbHuZt6JnOPEoKsaacITmqrPFEnBvgUeO5vsig7knopQetw8JxErnHrKVkQ+LIbfSCuQOPrgRddJvaREoncZn0zuQ9hZ2WK/KODF/LteIQgiC+WbahYpentvGk0Zc4DPmwpMhcojnidvcWci+AgfhjVJEiaKiHNj/Q6yGCCKauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c3GfW5R0JzKHMpf
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 17:15:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 156161A0AC3
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 17:15:15 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxSi+p5o70gEDw--.37412S3;
	Fri, 15 Aug 2025 17:15:14 +0800 (CST)
Subject: Re: [PATCH] blk-mq: fix lockdep warning in
 __blk_mq_update_nr_hw_queues
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250815075636.304660-1-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ff5639d3-9a63-e26c-a062-cb8a23c0ed5d@huaweicloud.com>
Date: Fri, 15 Aug 2025 17:15:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250815075636.304660-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnIxSi+p5o70gEDw--.37412S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKF4rKF15ZF1kAFW8ZF13urg_yoW7ur48pF
	W5Gay2kw1vqr48Wa4UJw47W343WwsY9r17Wr1fJa4YkFn7KrZ7Zr18Gr12vFW0yrZ7Crsx
	X3y8tFWkZFZrZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	yE_tUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/15 15:56, Ming Lei Ð´µÀ:
> Commit 5989bfe6ac6b ("block: restore two stage elevator switch while
> running nr_hw_queue update") reintroduced a lockdep warning by calling
> blk_mq_freeze_queue_nomemsave() before switching the I/O scheduler.
> 
> The function blk_mq_elv_switch_none() calls elevator_change_done().
> Running this while the queue is frozen causes a lockdep warning.
> 
> Fix this by reordering the operations: first, switch the I/O scheduler
> to 'none', and then freeze the queue. This ensures that elevator_change_done()
> is not called on an already frozen queue. And this way is safe because
> elevator_set_none() does freeze queue before switching to none.
> 
> Also we still have to rely on blk_mq_elv_switch_back() for switching
> back, and it has to cover unfrozen queue case.
> 
> Cc: Nilay Shroff <nilay@linux.ibm.com>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Fixes: 5989bfe6ac6b ("block: restore two stage elevator switch while running nr_hw_queue update")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c   | 13 +++++++------
>   block/blk.h      |  2 +-
>   block/elevator.c | 12 +++++++++---
>   3 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b67d6c02eceb..9c62781c6b8c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4974,13 +4974,13 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>    * Switch back to the elevator type stored in the xarray.
>    */
>   static void blk_mq_elv_switch_back(struct request_queue *q,
> -		struct xarray *elv_tbl, struct xarray *et_tbl)
> +		struct xarray *elv_tbl, struct xarray *et_tbl, bool frozen)
>   {
>   	struct elevator_type *e = xa_load(elv_tbl, q->id);
>   	struct elevator_tags *t = xa_load(et_tbl, q->id);
>   
>   	/* The elv_update_nr_hw_queues unfreezes the queue. */
> -	elv_update_nr_hw_queues(q, e, t);
> +	elv_update_nr_hw_queues(q, e, t, frozen);
>   
>   	/* Drop the reference acquired in blk_mq_elv_switch_none. */
>   	if (e)
> @@ -5033,6 +5033,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   	unsigned int memflags;
>   	int i;
>   	struct xarray elv_tbl, et_tbl;
> +	bool queues_frozen = false;
>   
>   	lockdep_assert_held(&set->tag_list_lock);
>   
> @@ -5056,9 +5057,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   		blk_mq_sysfs_unregister_hctxs(q);
>   	}
>   
> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> -		blk_mq_freeze_queue_nomemsave(q);
> -
>   	/*
>   	 * Switch IO scheduler to 'none', cleaning up the data associated
>   	 * with the previous scheduler. We will switch back once we are done
> @@ -5068,6 +5066,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   		if (blk_mq_elv_switch_none(q, &elv_tbl))
>   			goto switch_back;
>   
> +	list_for_each_entry(q, &set->tag_list, tag_set_list)
> +		blk_mq_freeze_queue_nomemsave(q);
> +	queues_frozen = true;
>   	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
>   		goto switch_back;
>   
Will it be simpler if we move blk_mq_freeze_queue_nomemsave() into
blk_mq_elv_switch_none(), after elevator is succeed switching to none
then freeze the queue.

Later in blk_mq_elv_switch_back we'll know if xa_load() return valid
elevator_type, related queue is already freezed.

Thanks,
Kuai

> @@ -5092,7 +5093,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   switch_back:
>   	/* The blk_mq_elv_switch_back unfreezes queue for us. */
>   	list_for_each_entry(q, &set->tag_list, tag_set_list)
> -		blk_mq_elv_switch_back(q, &elv_tbl, &et_tbl);
> +		blk_mq_elv_switch_back(q, &elv_tbl, &et_tbl, queues_frozen);
>   
>   	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>   		blk_mq_sysfs_register_hctxs(q);
> diff --git a/block/blk.h b/block/blk.h
> index 0a2eccf28ca4..601db258c00d 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -332,7 +332,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
>   bool blk_insert_flush(struct request *rq);
>   
>   void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e,
> -		struct elevator_tags *t);
> +		struct elevator_tags *t, bool frozen);
>   void elevator_set_default(struct request_queue *q);
>   void elevator_set_none(struct request_queue *q);
>   
> diff --git a/block/elevator.c b/block/elevator.c
> index fe96c6f4753c..0644b2d35ecb 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -706,24 +706,30 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>    * reattachment when nr_hw_queues changes.
>    */
>   void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e,
> -		struct elevator_tags *t)
> +		struct elevator_tags *t, bool frozen)
>   {
>   	struct blk_mq_tag_set *set = q->tag_set;
>   	struct elv_change_ctx ctx = {};
>   	int ret = -ENODEV;
>   
> -	WARN_ON_ONCE(q->mq_freeze_depth == 0);
> +	WARN_ON_ONCE(frozen == (q->mq_freeze_depth == 0));
>   
>   	if (e && !blk_queue_dying(q) && blk_queue_registered(q)) {
>   		ctx.name = e->elevator_name;
>   		ctx.et = t;
>   
> +		/* elevator switch requires queue to be frozen */
> +		if (!frozen) {
> +			blk_mq_freeze_queue_nomemsave(q);
> +			frozen = true;
> +		}
>   		mutex_lock(&q->elevator_lock);
>   		/* force to reattach elevator after nr_hw_queue is updated */
>   		ret = elevator_switch(q, &ctx);
>   		mutex_unlock(&q->elevator_lock);
>   	}
> -	blk_mq_unfreeze_queue_nomemrestore(q);
> +	if (frozen)
> +		blk_mq_unfreeze_queue_nomemrestore(q);
>   	if (!ret)
>   		WARN_ON_ONCE(elevator_change_done(q, &ctx));
>   	/*
> 

