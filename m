Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CED13CF82;
	Wed, 30 Oct 2024 06:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270761; cv=none; b=giKXZFVBgzS+MOYDJaOF6yRPEwxPT+JZEwNee/wwIRDlorNuo7uZRPYVzO9JYaNSXat3gh65dmKHiI1+sYDDT9jrJ3h4KXlZOS+C3aBfTdWOpVY3pLql3OoWje16EzPKnIm/jUiRZJhmEdePT5/JhodeyQzpXmCXhMeiIW4P21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270761; c=relaxed/simple;
	bh=aB82I65NvKXz7UHzxcI/Wr3fEpGKdrY/9yYqCZ10Wto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGBzttgyW8BeSFS/R5DSxNbTPHfJNN49dGmySPF4aLPyF7KWLCmfRWNsnJRwj8/dxCDLYOX/r4oQc9T0RVZHiCkvOx04K/D85FK+Q/qcmKW5CnSOzGKQQmpPkBHHWVhrwjAXrGQCmNU9NB2bWW50NHSaJN1SvpcpSReLVcXu+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHUZxQ2i; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHUZxQ2i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730270757; x=1761806757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aB82I65NvKXz7UHzxcI/Wr3fEpGKdrY/9yYqCZ10Wto=;
  b=gHUZxQ2iXWbuGT/9y5gl9JCuFXtZJUj4kNyGQFCyXaQJKh0YeNIUyaUN
   lSzQwhWOb2aRBGGAvluYycyTgmkHoIVUdOSfb+2l51kKHE93qobs5/rIp
   x9AWrG/hnpVtRYLxWA+7JhtjC0IML0pRKP23R8+SOhOtD4M2R5he4OHDs
   R4ms03CDsp1MaM84coBlgBec/7fZkHxUKApgT8n8Nm81kAjUa7vKiqgSs
   s7bNigle7mp+Zs38C8nk9+pv9e5xYUGf0HWkUv6fN7apt7r1JgwArdiZQ
   I42j39ulWE8GUmSEQgf9UTznig0eGYLdS3b/jNh6jW4R8+Z4v80rEcX+x
   g==;
X-CSE-ConnectionGUID: H+0FkGB3Qz+Mp0ZeL01q6A==
X-CSE-MsgGUID: gFgDqUBvTN66rRMVkxoedQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="32795407"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="32795407"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 23:45:57 -0700
X-CSE-ConnectionGUID: JUwC82jkR9iT0a2q2Z3JIA==
X-CSE-MsgGUID: VwmLTA/ASKmqPdC85W5IYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="82128150"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 23:45:53 -0700
Date: Wed, 30 Oct 2024 14:45:03 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
Message-ID: <ZyHV7xTccCwN8j7b@ly-workstation>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
 <20241025003722.3630252-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025003722.3630252-4-ming.lei@redhat.com>

Hi Ming,

Greetings!

I used Syzkaller and found that there is possible deadlock in __submit_bio in linux-next next-20241029.

After bisection and the first bad commit is:
"
f1be1788a32e block: model freeze & enter queue as lock for supporting lockdep
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241029_183511___submit_bio/bzImage_6fb2fa9805c501d9ade047fc511961f3273cdcb5
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/241029_183511___submit_bio/6fb2fa9805c501d9ade047fc511961f3273cdcb5_dmesg.log

"
[   22.219103] 6.12.0-rc5-next-20241029-6fb2fa9805c5 #1 Not tainted
[   22.219512] ------------------------------------------------------
[   22.219827] repro/735 is trying to acquire lock:
[   22.220066] ffff888010f1a768 (&q->q_usage_counter(io)#25){++++}-{0:0}, at: __submit_bio+0x39f/0x550
[   22.220568] 
[   22.220568] but task is already holding lock:
[   22.220884] ffffffff872322a0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x76b/0x21e0
[   22.221453] 
[   22.221453] which lock already depends on the new lock.
[   22.221453] 
[   22.221862] 
[   22.221862] the existing dependency chain (in reverse order) is:
[   22.222247] 
[   22.222247] -> #1 (fs_reclaim){+.+.}-{0:0}:
[   22.222630]        lock_acquire+0x80/0xb0
[   22.222920]        fs_reclaim_acquire+0x116/0x160
[   22.223244]        __kmalloc_cache_node_noprof+0x59/0x470
[   22.223528]        blk_mq_init_tags+0x79/0x1a0
[   22.223771]        blk_mq_alloc_map_and_rqs+0x1f4/0xdd0
[   22.224127]        blk_mq_init_sched+0x33d/0x6d0
[   22.224376]        elevator_init_mq+0x2b2/0x400
[   22.224619]        add_disk_fwnode+0x11c/0x1300
[   22.224866]        device_add_disk+0x31/0x40
[   22.225097]        sd_probe+0xa79/0x1080
[   22.225324]        really_probe+0x27c/0xac0
[   22.225556]        __driver_probe_device+0x1f3/0x460
[   22.225819]        driver_probe_device+0x56/0x1b0
[   22.226069]        __device_attach_driver+0x1e7/0x300
[   22.226336]        bus_for_each_drv+0x159/0x1e0
[   22.226576]        __device_attach_async_helper+0x1e4/0x2a0
[   22.226871]        async_run_entry_fn+0xa3/0x450
[   22.227127]        process_one_work+0x92e/0x1b50
[   22.227380]        worker_thread+0x68d/0xe90
[   22.227614]        kthread+0x35a/0x470
[   22.227834]        ret_from_fork+0x56/0x90
[   22.228119]        ret_from_fork_asm+0x1a/0x30
[   22.228365] 
[   22.228365] -> #0 (&q->q_usage_counter(io)#25){++++}-{0:0}:
[   22.228739]        __lock_acquire+0x2ff8/0x5d60
[   22.228982]        lock_acquire.part.0+0x142/0x390
[   22.229237]        lock_acquire+0x80/0xb0
[   22.229452]        blk_mq_submit_bio+0x1cbe/0x2590
[   22.229708]        __submit_bio+0x39f/0x550
[   22.229931]        submit_bio_noacct_nocheck+0x647/0xcc0
[   22.230212]        submit_bio_noacct+0x620/0x1e00
[   22.230463]        submit_bio+0xce/0x480
[   22.230677]        __swap_writepage+0x2f1/0xdf0
[   22.230923]        swap_writepage+0x464/0xbc0
[   22.231157]        shmem_writepage+0xdeb/0x1340
[   22.231406]        pageout+0x3bc/0x9b0
[   22.231617]        shrink_folio_list+0x16b9/0x3b60
[   22.231884]        shrink_lruvec+0xd78/0x2790
[   22.232220]        shrink_node+0xb29/0x2870
[   22.232447]        do_try_to_free_pages+0x2e3/0x1790
[   22.232789]        try_to_free_pages+0x2bc/0x750
[   22.233065]        __alloc_pages_slowpath.constprop.0+0x812/0x21e0
[   22.233528]        __alloc_pages_noprof+0x5d4/0x6f0
[   22.233861]        alloc_pages_mpol_noprof+0x30a/0x580
[   22.234233]        alloc_pages_noprof+0xa9/0x180
[   22.234555]        kimage_alloc_pages+0x79/0x240
[   22.234808]        kimage_alloc_control_pages+0x1cb/0xa60
[   22.235119]        do_kexec_load+0x3a6/0x8e0
[   22.235418]        __x64_sys_kexec_load+0x1cc/0x240
[   22.235759]        x64_sys_call+0xf0f/0x20d0
[   22.236058]        do_syscall_64+0x6d/0x140
[   22.236343]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   22.236643] 
[   22.236643] other info that might help us debug this:
[   22.236643] 
[   22.237042]  Possible unsafe locking scenario:
[   22.237042] 
[   22.237359]        CPU0                    CPU1
[   22.237662]        ----                    ----
[   22.237926]   lock(fs_reclaim);
[   22.238098]                                lock(&q->q_usage_counter(io)#25);
[   22.238535]                                lock(fs_reclaim);
[   22.238935]   rlock(&q->q_usage_counter(io)#25);
[   22.239182] 
[   22.239182]  *** DEADLOCK ***
[   22.239182] 
[   22.239521] 1 lock held by repro/735:
[   22.239778]  #0: ffffffff872322a0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x76b/0x21e0
[   22.240320] 
[   22.240320] stack backtrace:
[   22.240550] CPU: 1 UID: 0 PID: 735 Comm: repro Not tainted 6.12.0-rc5-next-20241029-6fb2fa9805c5 #1
[   22.241079] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   22.241780] Call Trace:
[   22.241928]  <TASK>
[   22.242095]  dump_stack_lvl+0xea/0x150
[   22.242351]  dump_stack+0x19/0x20
[   22.242534]  print_circular_bug+0x47f/0x750
[   22.242761]  check_noncircular+0x2f4/0x3e0
[   22.242992]  ? __pfx_check_noncircular+0x10/0x10
[   22.243302]  ? __pfx_lock_release+0x10/0x10
[   22.243586]  ? lockdep_lock+0xd0/0x1d0
[   22.243865]  ? __pfx_lockdep_lock+0x10/0x10
[   22.244103]  __lock_acquire+0x2ff8/0x5d60
[   22.244382]  ? __kernel_text_address+0x16/0x50
[   22.244633]  ? __pfx___lock_acquire+0x10/0x10
[   22.244871]  ? stack_trace_save+0x97/0xd0
[   22.245102]  lock_acquire.part.0+0x142/0x390
[   22.245394]  ? __submit_bio+0x39f/0x550
[   22.245646]  ? __pfx_lock_acquire.part.0+0x10/0x10
"

I hope you find it useful.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

On Fri, Oct 25, 2024 at 08:37:20AM +0800, Ming Lei wrote:
> Recently we got several deadlock report[1][2][3] caused by
> blk_mq_freeze_queue and blk_enter_queue().
> 
> Turns out the two are just like acquiring read/write lock, so model them
> as read/write lock for supporting lockdep:
> 
> 1) model q->q_usage_counter as two locks(io and queue lock)
> 
> - queue lock covers sync with blk_enter_queue()
> 
> - io lock covers sync with bio_enter_queue()
> 
> 2) make the lockdep class/key as per-queue:
> 
> - different subsystem has very different lock use pattern, shared lock
>  class causes false positive easily
> 
> - freeze_queue degrades to no lock in case that disk state becomes DEAD
>   because bio_enter_queue() won't be blocked any more
> 
> - freeze_queue degrades to no lock in case that request queue becomes dying
>   because blk_enter_queue() won't be blocked any more
> 
> 3) model blk_mq_freeze_queue() as acquire_exclusive & try_lock
> - it is exclusive lock, so dependency with blk_enter_queue() is covered
> 
> - it is trylock because blk_mq_freeze_queue() are allowed to run
>   concurrently
> 
> 4) model blk_enter_queue() & bio_enter_queue() as acquire_read()
> - nested blk_enter_queue() are allowed
> 
> - dependency with blk_mq_freeze_queue() is covered
> 
> - blk_queue_exit() is often called from other contexts(such as irq), and
> it can't be annotated as lock_release(), so simply do it in
> blk_enter_queue(), this way still covered cases as many as possible
> 
> With lockdep support, such kind of reports may be reported asap and
> needn't wait until the real deadlock is triggered.
> 
> For example, lockdep report can be triggered in the report[3] with this
> patch applied.
> 
> [1] occasional block layer hang when setting 'echo noop > /sys/block/sda/queue/scheduler'
> https://bugzilla.kernel.org/show_bug.cgi?id=219166
> 
> [2] del_gendisk() vs blk_queue_enter() race condition
> https://lore.kernel.org/linux-block/20241003085610.GK11458@google.com/
> 
> [3] queue_freeze & queue_enter deadlock in scsi
> https://lore.kernel.org/linux-block/ZxG38G9BuFdBpBHZ@fedora/T/#u
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c       | 18 ++++++++++++++++--
>  block/blk-mq.c         | 26 ++++++++++++++++++++++----
>  block/blk.h            | 29 ++++++++++++++++++++++++++---
>  block/genhd.c          | 15 +++++++++++----
>  include/linux/blkdev.h |  6 ++++++
>  5 files changed, 81 insertions(+), 13 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index bc5e8c5eaac9..09d10bb95fda 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -261,6 +261,8 @@ static void blk_free_queue(struct request_queue *q)
>  		blk_mq_release(q);
>  
>  	ida_free(&blk_queue_ida, q->id);
> +	lockdep_unregister_key(&q->io_lock_cls_key);
> +	lockdep_unregister_key(&q->q_lock_cls_key);
>  	call_rcu(&q->rcu_head, blk_free_queue_rcu);
>  }
>  
> @@ -278,18 +280,20 @@ void blk_put_queue(struct request_queue *q)
>  }
>  EXPORT_SYMBOL(blk_put_queue);
>  
> -void blk_queue_start_drain(struct request_queue *q)
> +bool blk_queue_start_drain(struct request_queue *q)
>  {
>  	/*
>  	 * When queue DYING flag is set, we need to block new req
>  	 * entering queue, so we call blk_freeze_queue_start() to
>  	 * prevent I/O from crossing blk_queue_enter().
>  	 */
> -	blk_freeze_queue_start(q);
> +	bool freeze = __blk_freeze_queue_start(q);
>  	if (queue_is_mq(q))
>  		blk_mq_wake_waiters(q);
>  	/* Make blk_queue_enter() reexamine the DYING flag. */
>  	wake_up_all(&q->mq_freeze_wq);
> +
> +	return freeze;
>  }
>  
>  /**
> @@ -321,6 +325,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>  			return -ENODEV;
>  	}
>  
> +	rwsem_acquire_read(&q->q_lockdep_map, 0, 0, _RET_IP_);
> +	rwsem_release(&q->q_lockdep_map, _RET_IP_);
>  	return 0;
>  }
>  
> @@ -352,6 +358,8 @@ int __bio_queue_enter(struct request_queue *q, struct bio *bio)
>  			goto dead;
>  	}
>  
> +	rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
> +	rwsem_release(&q->io_lockdep_map, _RET_IP_);
>  	return 0;
>  dead:
>  	bio_io_error(bio);
> @@ -441,6 +449,12 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
>  				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL);
>  	if (error)
>  		goto fail_stats;
> +	lockdep_register_key(&q->io_lock_cls_key);
> +	lockdep_register_key(&q->q_lock_cls_key);
> +	lockdep_init_map(&q->io_lockdep_map, "&q->q_usage_counter(io)",
> +			 &q->io_lock_cls_key, 0);
> +	lockdep_init_map(&q->q_lockdep_map, "&q->q_usage_counter(queue)",
> +			 &q->q_lock_cls_key, 0);
>  
>  	q->nr_requests = BLKDEV_DEFAULT_RQ;
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 96858fb3b9ff..76f277a30c11 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -120,17 +120,29 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
>  	inflight[1] = mi.inflight[1];
>  }
>  
> -void blk_freeze_queue_start(struct request_queue *q)
> +bool __blk_freeze_queue_start(struct request_queue *q)
>  {
> +	int freeze;
> +
>  	mutex_lock(&q->mq_freeze_lock);
>  	if (++q->mq_freeze_depth == 1) {
>  		percpu_ref_kill(&q->q_usage_counter);
>  		mutex_unlock(&q->mq_freeze_lock);
>  		if (queue_is_mq(q))
>  			blk_mq_run_hw_queues(q, false);
> +		freeze = true;
>  	} else {
>  		mutex_unlock(&q->mq_freeze_lock);
> +		freeze = false;
>  	}
> +
> +	return freeze;
> +}
> +
> +void blk_freeze_queue_start(struct request_queue *q)
> +{
> +	if (__blk_freeze_queue_start(q))
> +		blk_freeze_acquire_lock(q, false, false);
>  }
>  EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
>  
> @@ -176,8 +188,10 @@ void blk_mq_freeze_queue(struct request_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
>  
> -void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
> +bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
>  {
> +	int unfreeze = false;
> +
>  	mutex_lock(&q->mq_freeze_lock);
>  	if (force_atomic)
>  		q->q_usage_counter.data->force_atomic = true;
> @@ -186,13 +200,17 @@ void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
>  	if (!q->mq_freeze_depth) {
>  		percpu_ref_resurrect(&q->q_usage_counter);
>  		wake_up_all(&q->mq_freeze_wq);
> +		unfreeze = true;
>  	}
>  	mutex_unlock(&q->mq_freeze_lock);
> +
> +	return unfreeze;
>  }
>  
>  void blk_mq_unfreeze_queue(struct request_queue *q)
>  {
> -	__blk_mq_unfreeze_queue(q, false);
> +	if (__blk_mq_unfreeze_queue(q, false))
> +		blk_unfreeze_release_lock(q, false, false);
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
>  
> @@ -205,7 +223,7 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
>   */
>  void blk_freeze_queue_start_non_owner(struct request_queue *q)
>  {
> -	blk_freeze_queue_start(q);
> +	__blk_freeze_queue_start(q);
>  }
>  EXPORT_SYMBOL_GPL(blk_freeze_queue_start_non_owner);
>  
> diff --git a/block/blk.h b/block/blk.h
> index c718e4291db0..832e54c5a271 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/bio-integrity.h>
>  #include <linux/blk-crypto.h>
> +#include <linux/lockdep.h>
>  #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
>  #include <linux/sched/sysctl.h>
>  #include <linux/timekeeping.h>
> @@ -35,8 +36,9 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
>  void blk_free_flush_queue(struct blk_flush_queue *q);
>  
>  void blk_freeze_queue(struct request_queue *q);
> -void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
> -void blk_queue_start_drain(struct request_queue *q);
> +bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
> +bool blk_queue_start_drain(struct request_queue *q);
> +bool __blk_freeze_queue_start(struct request_queue *q);
>  int __bio_queue_enter(struct request_queue *q, struct bio *bio);
>  void submit_bio_noacct_nocheck(struct bio *bio);
>  void bio_await_chain(struct bio *bio);
> @@ -69,8 +71,11 @@ static inline int bio_queue_enter(struct bio *bio)
>  {
>  	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>  
> -	if (blk_try_enter_queue(q, false))
> +	if (blk_try_enter_queue(q, false)) {
> +		rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
> +		rwsem_release(&q->io_lockdep_map, _RET_IP_);
>  		return 0;
> +	}
>  	return __bio_queue_enter(q, bio);
>  }
>  
> @@ -734,4 +739,22 @@ void blk_integrity_verify(struct bio *bio);
>  void blk_integrity_prepare(struct request *rq);
>  void blk_integrity_complete(struct request *rq, unsigned int nr_bytes);
>  
> +static inline void blk_freeze_acquire_lock(struct request_queue *q, bool
> +		disk_dead, bool queue_dying)
> +{
> +	if (!disk_dead)
> +		rwsem_acquire(&q->io_lockdep_map, 0, 1, _RET_IP_);
> +	if (!queue_dying)
> +		rwsem_acquire(&q->q_lockdep_map, 0, 1, _RET_IP_);
> +}
> +
> +static inline void blk_unfreeze_release_lock(struct request_queue *q, bool
> +		disk_dead, bool queue_dying)
> +{
> +	if (!queue_dying)
> +		rwsem_release(&q->q_lockdep_map, _RET_IP_);
> +	if (!disk_dead)
> +		rwsem_release(&q->io_lockdep_map, _RET_IP_);
> +}
> +
>  #endif /* BLK_INTERNAL_H */
> diff --git a/block/genhd.c b/block/genhd.c
> index 1c05dd4c6980..6ad3fcde0110 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -581,13 +581,13 @@ static void blk_report_disk_dead(struct gendisk *disk, bool surprise)
>  	rcu_read_unlock();
>  }
>  
> -static void __blk_mark_disk_dead(struct gendisk *disk)
> +static bool __blk_mark_disk_dead(struct gendisk *disk)
>  {
>  	/*
>  	 * Fail any new I/O.
>  	 */
>  	if (test_and_set_bit(GD_DEAD, &disk->state))
> -		return;
> +		return false;
>  
>  	if (test_bit(GD_OWNS_QUEUE, &disk->state))
>  		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
> @@ -600,7 +600,7 @@ static void __blk_mark_disk_dead(struct gendisk *disk)
>  	/*
>  	 * Prevent new I/O from crossing bio_queue_enter().
>  	 */
> -	blk_queue_start_drain(disk->queue);
> +	return blk_queue_start_drain(disk->queue);
>  }
>  
>  /**
> @@ -641,6 +641,7 @@ void del_gendisk(struct gendisk *disk)
>  	struct request_queue *q = disk->queue;
>  	struct block_device *part;
>  	unsigned long idx;
> +	bool start_drain, queue_dying;
>  
>  	might_sleep();
>  
> @@ -668,7 +669,10 @@ void del_gendisk(struct gendisk *disk)
>  	 * Drop all partitions now that the disk is marked dead.
>  	 */
>  	mutex_lock(&disk->open_mutex);
> -	__blk_mark_disk_dead(disk);
> +	start_drain = __blk_mark_disk_dead(disk);
> +	queue_dying = blk_queue_dying(q);
> +	if (start_drain)
> +		blk_freeze_acquire_lock(q, true, queue_dying);
>  	xa_for_each_start(&disk->part_tbl, idx, part, 1)
>  		drop_partition(part);
>  	mutex_unlock(&disk->open_mutex);
> @@ -725,6 +729,9 @@ void del_gendisk(struct gendisk *disk)
>  		if (queue_is_mq(q))
>  			blk_mq_exit_queue(q);
>  	}
> +
> +	if (start_drain)
> +		blk_unfreeze_release_lock(q, true, queue_dying);
>  }
>  EXPORT_SYMBOL(del_gendisk);
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 50c3b959da28..57f1ee386b57 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -25,6 +25,7 @@
>  #include <linux/uuid.h>
>  #include <linux/xarray.h>
>  #include <linux/file.h>
> +#include <linux/lockdep.h>
>  
>  struct module;
>  struct request_queue;
> @@ -471,6 +472,11 @@ struct request_queue {
>  	struct xarray		hctx_table;
>  
>  	struct percpu_ref	q_usage_counter;
> +	struct lock_class_key	io_lock_cls_key;
> +	struct lockdep_map	io_lockdep_map;
> +
> +	struct lock_class_key	q_lock_cls_key;
> +	struct lockdep_map	q_lockdep_map;
>  
>  	struct request		*last_merge;
>  
> -- 
> 2.46.0
> 
