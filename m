Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BD9262BE
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406028; cv=none; b=XbhzHzDd/mCRLx2A6l3VDvhJUBdPf2QxXF+uFQTkOVOquK3aLPEaNIa92VIPHUkbxX2JK9p7H7PravwITCSgeuvOg4ysj/32iLEeziUNhVyui0y4a/fAACJMxyU0BytxiLzgJQNFO6XNgwb/692IW1r16b5Y212KLT3iTkejszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406028; c=relaxed/simple;
	bh=i/LP2QYSLsTri6UTNScmYZIcLS26VCraKqJqqks0OR8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gqEVFPuqIS1wEQFQw/HOB2eRAHrE0wPydzai9YFZjHUJoJYIF+AzTY3b/ViZmsZEkAmdj2QWEr1O93ONnOcv/4UVPEMGkFczzz9wS15EdKDFNw9vy9MjjhIHk2+q0Ep/Gn8qwTfPLu8VDAD/hIhIf1dqjwNWIAyfsod4+tSFxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bp8yc1wR1zKHMrr
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 09:13:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 07F2E1A0C4D
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 09:13:43 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHERJD2oJo8gyTBQ--.1291S3;
	Fri, 25 Jul 2025 09:13:40 +0800 (CST)
Subject: Re: [PATCHv3] block: restore two stage elevator switch while running
 nr_hw_queue update
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: yi.zhang@redhat.com, hch@lst.de, ming.lei@redhat.com,
 yukuai1@huaweicloud.com, axboe@kernel.dk, shinichiro.kawasaki@wdc.com,
 gjoyce@ibm.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250724102540.1366308-1-nilay@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c7b3ad81-dff8-078a-df02-65a0df7f62d1@huaweicloud.com>
Date: Fri, 25 Jul 2025 09:13:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250724102540.1366308-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHERJD2oJo8gyTBQ--.1291S3
X-Coremail-Antispam: 1UD129KBjvAXoWfGF43XrWrGFW7ArW5uF17KFg_yoW8Jr1DCo
	WfWrs2yw4kKw18GrykJw1kZrWrXr18Way3ZryUu3W5Xa1UKw4IkFyUGr43AryfGF1F9F10
	93srKw1ftayftF95n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYX7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/07/24 18:01, Nilay Shroff 写道:
> The kmemleak reports memory leaks related to elevator resources that
> were originally allocated in the ->init_hctx() method. The following
> leak traces are observed after running blktests block/040:
> 
> unreferenced object 0xffff8881b82f7400 (size 512):
>    comm "check", pid 68454, jiffies 4310588881
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace (crc 5bac8b34):
>      __kvmalloc_node_noprof+0x55d/0x7a0
>      sbitmap_init_node+0x15a/0x6a0
>      kyber_init_hctx+0x316/0xb90
>      blk_mq_init_sched+0x419/0x580
>      elevator_switch+0x18b/0x630
>      elv_update_nr_hw_queues+0x219/0x2c0
>      __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>      blk_mq_update_nr_hw_queues+0x3a/0x60
>      0xffffffffc09ceb80
>      0xffffffffc09d7e0b
>      configfs_write_iter+0x2b1/0x470
>      vfs_write+0x527/0xe70
>      ksys_write+0xff/0x200
>      do_syscall_64+0x98/0x3c0
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff8881b82f6000 (size 512):
>    comm "check", pid 68454, jiffies 4310588881
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace (crc 5bac8b34):
>      __kvmalloc_node_noprof+0x55d/0x7a0
>      sbitmap_init_node+0x15a/0x6a0
>      kyber_init_hctx+0x316/0xb90
>      blk_mq_init_sched+0x419/0x580
>      elevator_switch+0x18b/0x630
>      elv_update_nr_hw_queues+0x219/0x2c0
>      __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>      blk_mq_update_nr_hw_queues+0x3a/0x60
>      0xffffffffc09ceb80
>      0xffffffffc09d7e0b
>      configfs_write_iter+0x2b1/0x470
>      vfs_write+0x527/0xe70
>      ksys_write+0xff/0x200
>      do_syscall_64+0x98/0x3c0
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff8881b82f5800 (size 512):
>    comm "check", pid 68454, jiffies 4310588881
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace (crc 5bac8b34):
>      __kvmalloc_node_noprof+0x55d/0x7a0
>      sbitmap_init_node+0x15a/0x6a0
>      kyber_init_hctx+0x316/0xb90
>      blk_mq_init_sched+0x419/0x580
>      elevator_switch+0x18b/0x630
>      elv_update_nr_hw_queues+0x219/0x2c0
>      __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>      blk_mq_update_nr_hw_queues+0x3a/0x60
>      0xffffffffc09ceb80
>      0xffffffffc09d7e0b
>      configfs_write_iter+0x2b1/0x470
>      vfs_write+0x527/0xe70
> 
>      ksys_write+0xff/0x200
>      do_syscall_64+0x98/0x3c0
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The issue arises while we run nr_hw_queue update,  Specifically, we first
> reallocate hardware contexts (hctx) via __blk_mq_realloc_hw_ctxs(), and
> then later invoke elevator_switch() (assuming q->elevator is not NULL).
> The elevator switch code would first exit old elevator (elevator_exit)
> and then switches to the new elevator. The elevator_exit loops through
> each hctx and invokes the elevator’s per-hctx exit method ->exit_hctx(),
> which releases resources allocated during ->init_hctx().
> 
> This memleak manifests when we reduce the num of h/w queues - for example,
> when the initial update sets the number of queues to X, and a later update
> reduces it to Y, where Y < X. In this case, we'd loose the access to old
> hctxs while we get to elevator exit code because __blk_mq_realloc_hw_ctxs
> would have already released the old hctxs. As we don't now have any
> reference left to the old hctxs, we don't have any way to free the
> scheduler resources (which are allocate in ->init_hctx()) and kmemleak
> complains about it.
> 
> This issue was caused due to the commit 596dce110b7d ("block: simplify
> elevator reattachment for updating nr_hw_queues"). That change unified
> the two-stage elevator teardown and reattachment into a single call that
> occurs after __blk_mq_realloc_hw_ctxs() has already freed the hctxs.
> 
> This patch restores the previous two-stage elevator switch logic during
> nr_hw_queues updates. First, the elevator is switched to 'none', which
> ensures all scheduler resources are properly freed. Then, the hardware
> contexts (hctxs) are reallocated, and the software-to-hardware queue
> mappings are updated. Finally, the original elevator is reattached. This
> sequence prevents loss of references to old hctxs and avoids the scheduler
> resource leaks reported by kmemleak.
> 
> Reported-by : Yi Zhang <yi.zhang@redhat.com>
> Fixes: 596dce110b7d ("block: simplify elevator reattachment for updating nr_hw_queues")
> Closes: https://lore.kernel.org/all/CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> Changes from v2:
>      - Simplified error handling by combining WARN_ON_ONCE() and the
>        return value check of xa_insert() into a single statement.
>        This makes code more concise and easier to read without changing
>        the behavior. (Yu Kuai)
>      - Reduced the scope of ->elevator_lock in elv_update_nr_hw_queues().
>        Since elevator_type does not need protection, the lock now only
>        covers the critical section where elevator_switch() is called.
>        (Yu Kuai)
> 
> Changes from v1:
>      - Updated commit message with kmemleak trace generated using null-blk
>        (Yi Zhang)
>      - The elevator module could be removed while nr_hw_queue update is
>        running, so protect elevator switch using elevator_get() and
>        elevator_put() (Ming Lei)
>      - Invoke elv_update_nr_hw_queues() from blk_mq_elv_switch_back() and
>        that way avoid elevator code restructuring in a patch which fixes
>        a regression. (Ming Lei)
> 
> ---
>   block/blk-mq.c   | 84 ++++++++++++++++++++++++++++++++++++++++++------
>   block/blk.h      |  2 +-
>   block/elevator.c | 10 +++---
>   3 files changed, 81 insertions(+), 15 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4806b867e37d..dec1cd4f1f5b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4966,6 +4966,60 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>   	return ret;
>   }
>   
> +/*
> + * Switch back to the elevator type stored in the xarray.
> + */
> +static void blk_mq_elv_switch_back(struct request_queue *q,
> +		struct xarray *elv_tbl)
> +{
> +	struct elevator_type *e = xa_load(elv_tbl, q->id);
> +
> +	/* The elv_update_nr_hw_queues unfreezes the queue. */
> +	elv_update_nr_hw_queues(q, e);
> +
> +	/* Drop the reference acquired in blk_mq_elv_switch_none. */
> +	if (e)
> +		elevator_put(e);
> +}
> +
> +/*
> + * Stores elevator type in xarray and set current elevator to none. It uses
> + * q->id as an index to store the elevator type into the xarray.
> + */
> +static int blk_mq_elv_switch_none(struct request_queue *q,
> +		struct xarray *elv_tbl)
> +{
> +	int ret = 0;
> +
> +	lockdep_assert_held_write(&q->tag_set->update_nr_hwq_lock);
> +
> +	/*
> +	 * Accessing q->elevator without holding q->elevator_lock is safe here
> +	 * because we're called from nr_hw_queue update which is protected by
> +	 * set->update_nr_hwq_lock in the writer context. So, scheduler update/
> +	 * switch code (which acquires the same lock in the reader context)
> +	 * can't run concurrently.
> +	 */
> +	if (q->elevator) {
> +Emptly line here. Otherweise LGTM

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> +		ret = xa_insert(elv_tbl, q->id, q->elevator->type, GFP_KERNEL);
> +		if (WARN_ON_ONCE(ret))
> +			return ret;
> +
> +		/*
> +		 * Before we switch elevator to 'none', take a reference to
> +		 * the elevator module so that while nr_hw_queue update is
> +		 * running, no one can remove elevator module. We'd put the
> +		 * reference to elevator module later when we switch back
> +		 * elevator.
> +		 */
> +		__elevator_get(q->elevator->type);
> +
> +		elevator_set_none(q);
> +	}
> +	return ret;
> +}
> +
>   static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   							int nr_hw_queues)
>   {
> @@ -4973,6 +5027,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   	int prev_nr_hw_queues = set->nr_hw_queues;
>   	unsigned int memflags;
>   	int i;
> +	struct xarray elv_tbl;
>   
>   	lockdep_assert_held(&set->tag_list_lock);
>   
> @@ -4984,6 +5039,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   		return;
>   
>   	memflags = memalloc_noio_save();
> +
> +	xa_init(&elv_tbl);
> +
>   	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>   		blk_mq_debugfs_unregister_hctxs(q);
>   		blk_mq_sysfs_unregister_hctxs(q);
> @@ -4992,11 +5050,17 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   	list_for_each_entry(q, &set->tag_list, tag_set_list)
>   		blk_mq_freeze_queue_nomemsave(q);
>   
> -	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0) {
> -		list_for_each_entry(q, &set->tag_list, tag_set_list)
> -			blk_mq_unfreeze_queue_nomemrestore(q);
> -		goto reregister;
> -	}
> +	/*
> +	 * Switch IO scheduler to 'none', cleaning up the data associated
> +	 * with the previous scheduler. We will switch back once we are done
> +	 * updating the new sw to hw queue mappings.
> +	 */
> +	list_for_each_entry(q, &set->tag_list, tag_set_list)
> +		if (blk_mq_elv_switch_none(q, &elv_tbl))
> +			goto switch_back;
> +
> +	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
> +		goto switch_back;
>   
>   fallback:
>   	blk_mq_update_queue_map(set);
> @@ -5016,12 +5080,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   		}
>   		blk_mq_map_swqueue(q);
>   	}
> -
> -	/* elv_update_nr_hw_queues() unfreeze queue for us */
> +switch_back:
> +	/* The blk_mq_elv_switch_back unfreezes queue for us. */
>   	list_for_each_entry(q, &set->tag_list, tag_set_list)
> -		elv_update_nr_hw_queues(q);
> +		blk_mq_elv_switch_back(q, &elv_tbl);
>   
> -reregister:
>   	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>   		blk_mq_sysfs_register_hctxs(q);
>   		blk_mq_debugfs_register_hctxs(q);
> @@ -5029,6 +5092,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   		blk_mq_remove_hw_queues_cpuhp(q);
>   		blk_mq_add_hw_queues_cpuhp(q);
>   	}
> +
> +	xa_destroy(&elv_tbl);
> +
>   	memalloc_noio_restore(memflags);
>   
>   	/* Free the excess tags when nr_hw_queues shrink. */
> diff --git a/block/blk.h b/block/blk.h
> index 37ec459fe656..fae7653a941f 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -321,7 +321,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
>   
>   bool blk_insert_flush(struct request *rq);
>   
> -void elv_update_nr_hw_queues(struct request_queue *q);
> +void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e);
>   void elevator_set_default(struct request_queue *q);
>   void elevator_set_none(struct request_queue *q);
>   
> diff --git a/block/elevator.c b/block/elevator.c
> index ab22542e6cf0..9d81a06db6ec 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -689,21 +689,21 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>    * The I/O scheduler depends on the number of hardware queues, this forces a
>    * reattachment when nr_hw_queues changes.
>    */
> -void elv_update_nr_hw_queues(struct request_queue *q)
> +void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_type *e)
>   {
>   	struct elv_change_ctx ctx = {};
>   	int ret = -ENODEV;
>   
>   	WARN_ON_ONCE(q->mq_freeze_depth == 0);
>   
> -	mutex_lock(&q->elevator_lock);
> -	if (q->elevator && !blk_queue_dying(q) && blk_queue_registered(q)) {
> -		ctx.name = q->elevator->type->elevator_name;
> +	if (e && !blk_queue_dying(q) && blk_queue_registered(q)) {
> +		ctx.name = e->elevator_name;
>   
> +		mutex_lock(&q->elevator_lock);
>   		/* force to reattach elevator after nr_hw_queue is updated */
>   		ret = elevator_switch(q, &ctx);
> +		mutex_unlock(&q->elevator_lock);
>   	}
> -	mutex_unlock(&q->elevator_lock);
>   	blk_mq_unfreeze_queue_nomemrestore(q);
>   	if (!ret)
>   		WARN_ON_ONCE(elevator_change_done(q, &ctx));
> 

