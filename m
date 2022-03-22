Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5B5C433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 09:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiCVJez (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 05:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiCVJey (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 05:34:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24881A3AE
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 02:33:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0B80F68B05; Tue, 22 Mar 2022 10:33:23 +0100 (CET)
Date:   Tue, 22 Mar 2022 10:33:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] block: let blkcg_gq grab request queue's refcnt
Message-ID: <20220322093322.GA27283@lst.de>
References: <20220318130144.1066064-1-ming.lei@redhat.com> <20220318130144.1066064-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318130144.1066064-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 18, 2022 at 09:01:43PM +0800, Ming Lei wrote:
> In the whole lifetime of blkcg_gq instance, ->q will be referred, such
> as, ->pd_free_fn() is called in blkg_free, and throtl_pd_free() still
> may touch the request queue via &tg->service_queue.pending_timer which
> is handled by throtl_pending_timer_fn(), so it is reasonable to grab
> request queue's refcnt by blkcg_gq instance.
> 
> Previously blkcg_exit_queue() is called from blk_release_queue, and it
> is hard to avoid the use-after-free. But recently commit 1059699f87eb ("block:
> move blkcg initialization/destroy into disk allocation/release handler")
> is merged to for-5.18/block, it becomes simple to fix the issue by simply
> grabbing request queue's refcnt.
> 
> Reported-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-cgroup.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index fa063c6c0338..d53b0d69dd73 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -82,6 +82,8 @@ static void blkg_free(struct blkcg_gq *blkg)
>  		if (blkg->pd[i])
>  			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
>  
> +	if (blkg->q)
> +		blk_put_queue(blkg->q);

blkg_free can be called from RCU context, while blk_put_queue must
not be called from RCU context.  This causes regular splats when running
xfstests like:

[  693.342774] 
[  693.343585] =============================
[  693.345338] [ BUG: Invalid wait context ]
[  693.347109] 5.17.0-rc7+ #1276 Not tainted
[  693.348870] -----------------------------
[  693.350668] 056/104807 is trying to lock:
[  693.352463] ffff88810716f240 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_shutdown+0x170
[  693.356286] other info that might help us debug this:
[  693.359555] context-{2:2}
[  693.361215] 4 locks held by 056/104807:
[  693.363553]  #0: ffff88810b4ca378 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: bprm_execve+00
[  693.367984]  #1: ffff88810b4ca410 (&sig->exec_update_lock){++++}-{3:3}, at: begin_new_exe0
[  693.372036]  #2: ffff888100936968 (&mm->mmap_lock#2){++++}-{3:3}, at: exit_mmap+0x59/0x250
[  693.375654]  #3: ffffffff83db8360 (rcu_callback){....}-{0:0}, at: rcu_core+0x30e/0x910
[  693.378330] stack backtrace:
[  693.379262] CPU: 0 PID: 104807 Comm: 056 Not tainted 5.17.0-rc7+ #1276
[  693.381271] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/204
[  693.384177] Call Trace:
[  693.384954]  <IRQ>
[  693.385576]  dump_stack_lvl+0x45/0x59
[  693.386485]  __lock_acquire.cold+0x2a2/0x2be
[  693.387533]  ? mark_held_locks+0x49/0x70
[  693.388488]  lock_acquire+0xc9/0x2f0
[  693.389419]  ? blk_trace_shutdown+0x17/0x90
[  693.390525]  ? __slab_free+0x296/0x440
[  693.391451]  ? lockdep_hardirqs_on+0x79/0x100
[  693.392496]  __mutex_lock+0x71/0x8e0
[  693.393359]  ? blk_trace_shutdown+0x17/0x90
[  693.394368]  ? blk_trace_shutdown+0x17/0x90
[  693.395201]  ? lock_is_held_type+0xd7/0x130
[  693.396093]  ? rcu_read_lock_sched_held+0x3a/0x70
[  693.397179]  blk_trace_shutdown+0x17/0x90
[  693.398337]  blk_release_queue+0x85/0x100
[  693.399460]  kobject_put+0x63/0xc0
[  693.400397]  ? rcu_core+0x30e/0x910
[  693.401311]  blkg_free.part.0+0x3c/0x60
[  693.402425]  rcu_core+0x346/0x910
[  693.403430]  ? rcu_core+0x30e/0x910
[  693.404414]  __do_softirq+0x16e/0x4fe
[  693.405457]  __irq_exit_rcu+0xd1/0x120
[  693.406501]  irq_exit_rcu+0x5/0x20
[  693.407464]  sysvec_apic_timer_interrupt+0xa2/0xd0
[  693.408796]  </IRQ>
