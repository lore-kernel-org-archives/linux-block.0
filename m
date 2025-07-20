Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195621DDA2D
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753014023; cv=none; b=d8SSTZHd3en+QrNkNb8Z8HbIE42WXnCLHHskS8igRFiisewuVY6naBHTREhEvCjJDGH4NMJgyOdcyLD0n3sEkq3VgXzoTEU3w0gZmnofAhnq0iKlkTDV/EQOJldhehQnioPcwIW/l1Mb4A8aHtWFzXuF5w/mqUqLzaB3RThn3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753014023; c=relaxed/simple;
	bh=7Q8LMWw52E+FeVMkxEu8Fpsx5D3MFDcHroOypoZkG7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRoCVIgtbiH6FVefZyQLFgzsG9P0DA3mz5Sl3eOGEjEbRxniLF7dFuXVqu415Ecqn7KHDQIQ+lo7VmSkE8DhQX7bbCuKfDT/OBdawLBPqdwn6eanSJuCjAqhJuEa+gjcELBKP0Dtb0/FqcVljimjUiGWJrkROnj3bd23T52BP9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yd+iq9Tb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yd+iq9Tb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753014018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OaaTpN80ELWVCFr43ON/lQvN6q8EHmfV6ubk8GxnwgY=;
	b=Yd+iq9TbYSUF7O+0z6R6Rpey6Z6XngciZ8epeEWt9etMa5J9kswHTgg5u7qtIDk1xUYnVY
	8OphuQ/D382RI94uv/+VX3UARg/g0wx6Tyi1F1Hoy6qfS4k+x86J2rLF/1tOX3DMiQzHaZ
	RhEQ+01WViqQ2AlPzDptHWM0x94ffIA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-9LNM6NoQO7SGC3wtEH3Yug-1; Sun,
 20 Jul 2025 08:20:14 -0400
X-MC-Unique: 9LNM6NoQO7SGC3wtEH3Yug-1
X-Mimecast-MFC-AGG-ID: 9LNM6NoQO7SGC3wtEH3Yug_1753014013
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8EB21956096;
	Sun, 20 Jul 2025 12:20:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.10])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7275518016F9;
	Sun, 20 Jul 2025 12:20:04 +0000 (UTC)
Date: Sun, 20 Jul 2025 20:19:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, yi.zhang@redhat.com, hch@lst.de,
	yukuai1@huaweicloud.com, axboe@kernel.dk,
	shinichiro.kawasaki@wdc.com, yukuai3@huawei.com, gjoyce@ibm.com
Subject: Re: [PATCHv2] block: restore two stage elevator switch while running
 nr_hw_queue update
Message-ID: <aHze7aUyAs01ftVU@fedora>
References: <20250718133232.626418-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250718133232.626418-1-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Jul 18, 2025 at 07:02:09PM +0530, Nilay Shroff wrote:
> The kmemleak reports memory leaks related to elevator resources that
> were originally allocated in the ->init_hctx() method. The following
> leak traces are observed after running blktests:
> 
> unreferenced object 0xffff8881b82f7400 (size 512):
>   comm "check", pid 68454, jiffies 4310588881
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 5bac8b34):
>     __kvmalloc_node_noprof+0x55d/0x7a0
>     sbitmap_init_node+0x15a/0x6a0
>     kyber_init_hctx+0x316/0xb90
>     blk_mq_init_sched+0x419/0x580
>     elevator_switch+0x18b/0x630
>     elv_update_nr_hw_queues+0x219/0x2c0
>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>     blk_mq_update_nr_hw_queues+0x3a/0x60
>     0xffffffffc09ceb80
>     0xffffffffc09d7e0b
>     configfs_write_iter+0x2b1/0x470
>     vfs_write+0x527/0xe70
>     ksys_write+0xff/0x200
>     do_syscall_64+0x98/0x3c0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff8881b82f6000 (size 512):
>   comm "check", pid 68454, jiffies 4310588881
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 5bac8b34):
>     __kvmalloc_node_noprof+0x55d/0x7a0
>     sbitmap_init_node+0x15a/0x6a0
>     kyber_init_hctx+0x316/0xb90
>     blk_mq_init_sched+0x419/0x580
>     elevator_switch+0x18b/0x630
>     elv_update_nr_hw_queues+0x219/0x2c0
>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>     blk_mq_update_nr_hw_queues+0x3a/0x60
>     0xffffffffc09ceb80
>     0xffffffffc09d7e0b
>     configfs_write_iter+0x2b1/0x470
>     vfs_write+0x527/0xe70
>     ksys_write+0xff/0x200
>     do_syscall_64+0x98/0x3c0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff8881b82f5800 (size 512):
>   comm "check", pid 68454, jiffies 4310588881
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 5bac8b34):
>     __kvmalloc_node_noprof+0x55d/0x7a0
>     sbitmap_init_node+0x15a/0x6a0
>     kyber_init_hctx+0x316/0xb90
>     blk_mq_init_sched+0x419/0x580
>     elevator_switch+0x18b/0x630
>     elv_update_nr_hw_queues+0x219/0x2c0
>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>     blk_mq_update_nr_hw_queues+0x3a/0x60
>     0xffffffffc09ceb80
>     0xffffffffc09d7e0b
>     configfs_write_iter+0x2b1/0x470
>     vfs_write+0x527/0xe70
> 
>     ksys_write+0xff/0x200
>     do_syscall_64+0x98/0x3c0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
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
> Changes from v1:
>     - Updated commit message with kmemleak trace generated using null-blk
>       (Yi Zhang)
>     - The elevator module could be removed while nr_hw_queue update is
>       running, so protect elevator switch using elevator_get() and 
>       elevator_put() (Ming Lei)
>     - Invoke elv_update_nr_hw_queues() from blk_mq_elv_switch_back() and 
>       that way avoid elevator code restructuring in a patch which fixes
>       a regression. (Ming Lei)
> 
> ---
>  block/blk-mq.c   | 86 +++++++++++++++++++++++++++++++++++++++++++-----
>  block/blk.h      |  2 +-
>  block/elevator.c |  6 ++--
>  3 files changed, 81 insertions(+), 13 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4806b867e37d..fa25d6d36790 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4966,6 +4966,62 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>  	return ret;
>  }
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
> +
> +		ret = xa_insert(elv_tbl, q->id, q->elevator->type, GFP_KERNEL);
> +		if (ret) {
> +			WARN_ON_ONCE(1);
> +			goto out;
> +		}
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
> +out:
> +	return ret;
> +}
> +
>  static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  							int nr_hw_queues)
>  {
> @@ -4973,6 +5029,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  	int prev_nr_hw_queues = set->nr_hw_queues;
>  	unsigned int memflags;
>  	int i;
> +	struct xarray elv_tbl;
>  
>  	lockdep_assert_held(&set->tag_list_lock);
>  
> @@ -4984,6 +5041,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  		return;
>  
>  	memflags = memalloc_noio_save();
> +
> +	xa_init(&elv_tbl);
> +
>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>  		blk_mq_debugfs_unregister_hctxs(q);
>  		blk_mq_sysfs_unregister_hctxs(q);
> @@ -4992,11 +5052,17 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  	list_for_each_entry(q, &set->tag_list, tag_set_list)
>  		blk_mq_freeze_queue_nomemsave(q);
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

The partial `switch_back` need to be careful. If switching to none is
failed for one queue, the other remained will be switched back to none
no matter if the previous scheduler is none or not. Maybe return type of
blk_mq_elv_switch_none() can be defined as 'void' simply for avoiding the
trouble.

Otherwise, this patch looks fine.


Thanks,
Ming

