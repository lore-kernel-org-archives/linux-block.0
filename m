Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93710197A7E
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217541; cv=none; b=a/JW1CqVqgX6dMDMi3EqiJiuwv0wy/1Mco+DBjkPQsphdOOgYXPHge3z51gW4z84fPpbFyMWJu6pBfeDXfEFugCKDCa8Z9SQvKnOipGb+dhcZrV2zd8/QABWCOkgKiyrAvD3vGZcxGeiiBFe55z/SESkoVgp1GGRBqftbk3mdFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217541; c=relaxed/simple;
	bh=9rxRnvMHKieuIPgSZR2KhvHzI6LksLWfD6moc6GGmjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKJoaGkYYTXW7X/BImhwuIVs7ZSgUoYKwWD/nJcgrhzvjiNk9AnJmul47XXm4snTBP4tF8/YPz9LChyEg5rRNwzhBamUCjls8lJDpX/ZGLCcn+yyhQ7XohuzdlzxyYu+t8OwStQvsm4OLR92aYY28O0EBRLVVxMj5egmK+3/bmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfDyD2Qh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfDyD2Qh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730217537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G07csj/HNKUG9US1sa0uMRjt/spEWmkQbZuUCy73fiM=;
	b=PfDyD2Qhy8vtsmj8jjfhh+cNaWZWI1vJGu89f6ukFbT2kDW7oHqJ/JjvTIuRKpSnM2FWLG
	gsDCbxJmJzGgFhnU0omgnae8KaotXx1u9YDQSq6IbXC3/THf2nGBnoMjsIjmSRxBIzkpPh
	l0QkcLk38eEGyCRbaXd2RRjk2rZBlrc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-qCLRboBOMDyvyh6TIhE8JA-1; Tue,
 29 Oct 2024 11:58:54 -0400
X-MC-Unique: qCLRboBOMDyvyh6TIhE8JA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7F201955D50;
	Tue, 29 Oct 2024 15:58:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.26])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B9CD19560AA;
	Tue, 29 Oct 2024 15:58:43 +0000 (UTC)
Date: Tue, 29 Oct 2024 23:58:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
Message-ID: <ZyEGLdg744U_xBjp@fedora>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
 <20241025003722.3630252-4-ming.lei@redhat.com>
 <CGME20241029111338eucas1p2bd56c697b825eef235604e892569207e@eucas1p2.samsung.com>
 <ca16370e-d646-4eee-b9cc-87277c89c43c@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca16370e-d646-4eee-b9cc-87277c89c43c@samsung.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Oct 29, 2024 at 12:13:35PM +0100, Marek Szyprowski wrote:
> On 25.10.2024 02:37, Ming Lei wrote:
> > Recently we got several deadlock report[1][2][3] caused by
> > blk_mq_freeze_queue and blk_enter_queue().
> >
> > Turns out the two are just like acquiring read/write lock, so model them
> > as read/write lock for supporting lockdep:
> >
> > 1) model q->q_usage_counter as two locks(io and queue lock)
> >
> > - queue lock covers sync with blk_enter_queue()
> >
> > - io lock covers sync with bio_enter_queue()
> >
> > 2) make the lockdep class/key as per-queue:
> >
> > - different subsystem has very different lock use pattern, shared lock
> >   class causes false positive easily
> >
> > - freeze_queue degrades to no lock in case that disk state becomes DEAD
> >    because bio_enter_queue() won't be blocked any more
> >
> > - freeze_queue degrades to no lock in case that request queue becomes dying
> >    because blk_enter_queue() won't be blocked any more
> >
> > 3) model blk_mq_freeze_queue() as acquire_exclusive & try_lock
> > - it is exclusive lock, so dependency with blk_enter_queue() is covered
> >
> > - it is trylock because blk_mq_freeze_queue() are allowed to run
> >    concurrently
> >
> > 4) model blk_enter_queue() & bio_enter_queue() as acquire_read()
> > - nested blk_enter_queue() are allowed
> >
> > - dependency with blk_mq_freeze_queue() is covered
> >
> > - blk_queue_exit() is often called from other contexts(such as irq), and
> > it can't be annotated as lock_release(), so simply do it in
> > blk_enter_queue(), this way still covered cases as many as possible
> >
> > With lockdep support, such kind of reports may be reported asap and
> > needn't wait until the real deadlock is triggered.
> >
> > For example, lockdep report can be triggered in the report[3] with this
> > patch applied.
> >
> > [1] occasional block layer hang when setting 'echo noop > /sys/block/sda/queue/scheduler'
> > https://bugzilla.kernel.org/show_bug.cgi?id=219166
> >
> > [2] del_gendisk() vs blk_queue_enter() race condition
> > https://lore.kernel.org/linux-block/20241003085610.GK11458@google.com/
> >
> > [3] queue_freeze & queue_enter deadlock in scsi
> > https://lore.kernel.org/linux-block/ZxG38G9BuFdBpBHZ@fedora/T/#u
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> This patch landed yesterday in linux-next as commit f1be1788a32e 
> ("block: model freeze & enter queue as lock for supporting lockdep").  
> In my tests I found that it introduces the following 2 lockdep warnings:
> 
> 1. On Samsung Exynos 4412-based Odroid U3 board (ARM 32bit), observed 
> when booting it:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.12.0-rc4-00037-gf1be1788a32e #9290 Not tainted
> ------------------------------------------------------
> find/1284 is trying to acquire lock:
> cf3b8534 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0x30/0x70
> 
> but task is already holding lock:
> c203a0c8 (&sb->s_type->i_mutex_key#2){++++}-{3:3}, at: 
> iterate_dir+0x30/0x140
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #4 (&sb->s_type->i_mutex_key#2){++++}-{3:3}:
>         down_write+0x44/0xc4
>         start_creating+0x8c/0x170
>         debugfs_create_dir+0x1c/0x178
>         blk_register_queue+0xa0/0x1c0
>         add_disk_fwnode+0x210/0x434
>         brd_alloc+0x1cc/0x210
>         brd_init+0xac/0x104
>         do_one_initcall+0x64/0x30c
>         kernel_init_freeable+0x1c4/0x228
>         kernel_init+0x1c/0x12c
>         ret_from_fork+0x14/0x28
> 
> -> #3 (&q->debugfs_mutex){+.+.}-{3:3}:
>         __mutex_lock+0x94/0x94c
>         mutex_lock_nested+0x1c/0x24
>         blk_mq_init_sched+0x140/0x204
>         elevator_init_mq+0xb8/0x130
>         add_disk_fwnode+0x3c/0x434

The above chain can be cut by the following patch because disk state
can be thought as DEAD in add_disk(), can you test it?

diff --git a/block/elevator.c b/block/elevator.c
index 4122026b11f1..efa6ff941a25 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -600,12 +600,14 @@ void elevator_init_mq(struct request_queue *q)
 	 * requests, then no need to quiesce queue which may add long boot
 	 * latency, especially when lots of disks are involved.
 	 */
-	blk_mq_freeze_queue(q);
+	if (__blk_freeze_queue_start(q))
+		blk_freeze_acquire_lock(q, true, false);
 	blk_mq_cancel_work_sync(q);
 
 	err = blk_mq_init_sched(q, e);
 
-	blk_mq_unfreeze_queue(q);
+	if (__blk_mq_unfreeze_queue(q, false))
+		blk_unfreeze_release_lock(q, true, false);
 
 	if (err) {
 		pr_warn("\"%s\" elevator initialization failed, "

...

> 2 locks held by find/1284:
>   #0: c3df1e88 (&f->f_pos_lock){+.+.}-{3:3}, at: fdget_pos+0x88/0xd0
>   #1: c203a0c8 (&sb->s_type->i_mutex_key#2){++++}-{3:3}, at: 
> iterate_dir+0x30/0x140
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 1284 Comm: find Not tainted 
> 6.12.0-rc4-00037-gf1be1788a32e #9290
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Call trace:
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x68/0x88
>   dump_stack_lvl from print_circular_bug+0x31c/0x394
>   print_circular_bug from check_noncircular+0x16c/0x184
>   check_noncircular from __lock_acquire+0x158c/0x2970
>   __lock_acquire from lock_acquire+0x130/0x384
>   lock_acquire from __might_fault+0x50/0x70
>   __might_fault from filldir64+0x94/0x28c
>   filldir64 from dcache_readdir+0x174/0x260
>   dcache_readdir from iterate_dir+0x64/0x140
>   iterate_dir from sys_getdents64+0x60/0x130
>   sys_getdents64 from ret_fast_syscall+0x0/0x1c
> Exception stack(0xf22b5fa8 to 0xf22b5ff0)
> 5fa0:                   004b4fa0 004b4f80 00000004 004b4fa0 00008000 
> 00000000
> 5fc0: 004b4fa0 004b4f80 00000001 000000d9 00000000 004b4af0 00000000 
> 000010ea
> 5fe0: 004b1eb4 bea05af0 b6da4b08 b6da4a28
> 
> --->8---
> 
> 
> 2. On QEMU's ARM64 virt machine, observed during system suspend/resume 
> cycle:
> 
> # time rtcwake -s10 -mmem
> rtcwake: wakeup from "mem" using /dev/rtc0 at Tue Oct 29 11:54:30 2024
> PM: suspend entry (s2idle)
> Filesystems sync: 0.004 seconds
> Freezing user space processes
> Freezing user space processes completed (elapsed 0.007 seconds)
> OOM killer disabled.
> Freezing remaining freezable tasks
> Freezing remaining freezable tasks completed (elapsed 0.004 seconds)
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.12.0-rc4+ #9291 Not tainted
> ------------------------------------------------------
> rtcwake/1299 is trying to acquire lock:
> ffff80008358a7f8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x1c/0x28
> 
> but task is already holding lock:
> ffff000006136d68 (&q->q_usage_counter(io)#5){++++}-{0:0}, at: 
> virtblk_freeze+0x24/0x60
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:

This one looks a real thing, at least the added lockdep code works as
expected, also the blk_mq_freeze_queue() use in virtio-blk's ->suspend()
is questionable. I will take a further look.


Thanks,
Ming

