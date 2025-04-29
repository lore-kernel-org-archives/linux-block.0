Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C09211C
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928041; cv=none; b=GruSNm3CPf5JSaQGibQuDDCpgNdhLa9R9Ai58j5jmESxridwAoxzxT0o0/9lA4McVXGaEvXNuiLnhF3qqO8w0J/sFKP59KL5hSd0Hyrirbsn69ejl9KpSvKRt9oTbHyrGumU33qp+ceiu/WtN0BchJxiD20wG7QCLICIkBhStck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928041; c=relaxed/simple;
	bh=ve+9WjNuWfpdE6KKfR+ryFX+g7yArKG/Cau1R4qoI5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X53kt+2pKIUDb4UZ+9CKmST2aljrj2IGXTssiGJAXMyxMJbdH21DSl7lHtaOc9OCmVg7oOaPORK2avw1nKo5LGbErW+rpSaWc2qnBBOqXz3prB1+Vfs/ZzW1a7/FCM5/2W3HPY1tAmEKIQs5VZEV95IK2/AV4Fusbt5pedfdsiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fxug+4gr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fxug+4gr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4El9K026893;
	Tue, 29 Apr 2025 12:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KlXHtE
	MGNGn6R0VJxWCwrpOzl6/U42EXZvvX5lDsrn4=; b=fxug+4gr4cGN5Gs6cCxN7M
	rZFmwfsLgOkNic7vLt/zqyXjZT6VxHhDDb1i409BGKk7qNNxXf+h/3cu86r+xMu3
	F2GfN0v87T0HciRJmQftshPpaeXZDiVxQXvdMscHDakyEK++wMSMtTHExydWTi/6
	QoOfbn8b43l/B1dVpBauQap9nlhk6IlyGU4mkxR6AIyRyq3bbIE9yXq36O9cWNEp
	+huo7KUmz53qt2/lkxmAwZlf2VQmle1qNUJhmavUmgWOALUEOi4J5cvs2+oimBg3
	9vSh+Yh2LYVUYmsooSvtNHTb8rRIb0DF5cHwCe/4ft5IqOmpewbNoZ+53RL9J0cQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ahtwjrcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 12:00:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53TArRZ1008494;
	Tue, 29 Apr 2025 12:00:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 469ch32raj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 12:00:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TC0ShQ32899568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 12:00:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E40620043;
	Tue, 29 Apr 2025 12:00:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 031B420040;
	Tue, 29 Apr 2025 12:00:28 +0000 (GMT)
Received: from [9.152.212.246] (unknown [9.152.212.246])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 12:00:27 +0000 (GMT)
Message-ID: <0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com>
Date: Tue, 29 Apr 2025 14:00:27 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 00/20] block: unify elevator changing and fix lockdep
 warning
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20250424152148.1066220-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA4NiBTYWx0ZWRfX+mr59cyxk1jI VFH4fNmNi41tutM8gZCJyJa1bCS7LAJQermaf3TywwL3L9cdT7gYDbzfp/aSZa8/SL3kGnEPqtH 9ggfnAbZko/2zWdmSBLAo+bDEd3PgZsJs+Sigu9rMifcyn1Gf0rSVSH998nUbtAmGyTawBzsc1f
 Br6go7CKD2GNMB4FZLF1B/GZgAPvPiM9tqIFGlV485CzwuJF9nwykcwn9sY/Y/qfc/S8Cg0tLeA wSvviuzObJbNxKDVGCamj7xUJCDzAjdtb5JPngp9vqjIRvOKBvXiOSOlUq6b5W9zIq9aGBaz0Ua JfEkjdTa9EwsKhw6HzfA54TLuBUko2prTKg65OeLYgfDVB/jU7FN7G6O0Nz+rL29rkP7sMbzyqZ
 bFOnYj7Jk57wOSQoLTKdiYpv7IEQDH1KvQRlyVtdMzOBt/dPlMMonxLCegaQltWMGtZOwE8M
X-Proofpoint-GUID: 7za0crO_rGh6Zemzss7R5MRKmp9tI0IW
X-Authority-Analysis: v=2.4 cv=KtxN2XWN c=1 sm=1 tr=0 ts=6810bf5e cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=sWKEhP36mHoA:10 a=3--Im_O7JaeRZpZWgPsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7za0crO_rGh6Zemzss7R5MRKmp9tI0IW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290086

Am 24.04.25 um 17:21 schrieb Ming Lei:

> Hello Jens,
>
> This patchset cleans up elevator change code, and unifying it via single
> helper, meantime moves kobject_add/del & debugfs register/unregister out of
> queue freezing & elevator_lock. This way fixes many lockdep warnings
> reported recently, especially since fs_reclaim is connected with freeze lock
> manually by commit ffa1e7ada456 ("block: Make request_queue lockdep splats
> show up earlier").
>
>
> Thanks,
> Ming
>
> V3:
> 	- replace srcu with rw_sem for avoiding race between add/del disk &
> 	  elevator switch and updating nr_hw_queues (Nilay Shoff)
>
> 	- add elv_update_nr_hw_queues() for elevator reattachment in case of
> 	updating nr_hw_queues, meantime keep elv_change_ctx as local structure
> 	(Christoph)
>
> 	- replace ->elevator_lock with disk->rqos_state_mutex for covering wbt
> 	state change
>
> 	- add new patch "block: use q->elevator with ->elevator_lock held in elv_iosched_show()"
>
> 	- small cleanup & commit log improvement
>
> V2:
> 	- retry add/del disk when blk_mq_update_nr_hw_queues() is in-progress
>
> 	- swap blk_mq_add_queue_tag_set() with blk_mq_map_swqueue() in
> 	blk_mq_init_allocated_queue() (Nilay Shroff)
>
> 	- move ELEVATOR_FLAG_DISABLE_WBT to request queue's flags (Nilay Shoff) 
>
> 	- fix race because of delaying elevator unregister
>
> 	- define flags of `elv_change_ctx` as `bool` (Christoph)
>
> 	- improve comment and commit log (Christoph)
>
> Ming Lei (20):
>   block: move blk_mq_add_queue_tag_set() after blk_mq_map_swqueue()
>   block: move ELEVATOR_FLAG_DISABLE_WBT a request queue flag
>   block: don't call freeze queue in elevator_switch() and
>     elevator_disable()
>   block: use q->elevator with ->elevator_lock held in elv_iosched_show()
>   block: add two helpers for registering/un-registering sched debugfs
>   block: move sched debugfs register into elvevator_register_queue
>   block: prevent adding/deleting disk during updating nr_hw_queues
>   block: don't allow to switch elevator if updating nr_hw_queues is
>     in-progress
>   block: simplify elevator reattachment for updating nr_hw_queues
>   block: move blk_unregister_queue() & device_del() after freeze wait
>   block: move queue freezing & elevator_lock into elevator_change()
>   block: add `struct elv_change_ctx` for unifying elevator change
>   block: unifying elevator change
>   block: pass elevator_queue to elv_register_queue & unregister_queue
>   block: fail to show/store elevator sysfs attribute if elevator is
>     dying
>   block: move elv_register[unregister]_queue out of elevator_lock
>   block: move debugfs/sysfs register out of freezing queue
>   block: remove several ->elevator_lock
>   block: move hctx cpuhp add/del out of queue freezing
>   block: move wbt_enable_default() out of queue freezing from sched
>     ->exit()
>
>  block/bfq-iosched.c    |   6 +-
>  block/blk-mq-debugfs.c |  12 +-
>  block/blk-mq-sched.c   |  41 +++---
>  block/blk-mq.c         | 132 +++---------------
>  block/blk-sysfs.c      |  24 ++--
>  block/blk-wbt.c        |  13 +-
>  block/blk.h            |   8 +-
>  block/elevator.c       | 302 ++++++++++++++++++++++++++++-------------
>  block/elevator.h       |   6 +-
>  block/genhd.c          | 129 +++++++++++-------
>  include/linux/blk-mq.h |   3 +
>  include/linux/blkdev.h |   5 +
>  12 files changed, 365 insertions(+), 316 deletions(-)

Hi,
while testing the patchset on s390 I still get the following lockdep splat on each boot:

======================================================
 WARNING: possible circular locking dependency detected
 6.15.0-rc4-gc2b4d8dcb3d2 #3 Not tainted
 ------------------------------------------------------
 (udev-worker)/1810 is trying to acquire lock:
 0000005fb84de3a8 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0x54/0x130

 but task is already holding lock:
 0000005fb84dde18 (&q->q_usage_counter(io)#34){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x26/0x40

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #3 (&q->q_usage_counter(io)#34){++++}-{0:0}:
        __lock_acquire+0x6da/0xcc0
        lock_acquire.part.0+0x10c/0x290
        lock_acquire+0xb0/0x1a0
        blk_alloc_queue+0x306/0x340
        blk_mq_alloc_queue+0x60/0xd0
        scsi_alloc_sdev+0x27c/0x3b0
        scsi_probe_and_add_lun+0x31a/0x480
        scsi_report_lun_scan+0x382/0x430
        __scsi_scan_target+0x11a/0x240
        scsi_scan_target+0xdc/0x100
        fc_scsi_scan_rport+0xc2/0xd0
        process_one_work+0x2a6/0x5d0
        worker_thread+0x220/0x410
        kthread+0x164/0x2d0
        __ret_from_fork+0x3c/0x60
        ret_from_fork+0xa/0x38

 -> #2 (fs_reclaim){+.+.}-{0:0}:
        __lock_acquire+0x6da/0xcc0
        lock_acquire.part.0+0x10c/0x290
        lock_acquire+0xb0/0x1a0
        __fs_reclaim_acquire+0x44/0x50
        fs_reclaim_acquire+0xba/0x100
        __kmalloc_noprof+0xae/0x5e0
        pcpu_alloc_chunk+0x30/0x170
        pcpu_create_chunk+0x22/0x130
        pcpu_alloc_noprof+0x842/0x970
        do_kmem_cache_create+0x1e0/0x4b0
        __kmem_cache_create_args+0x238/0x340
        register_ftrace_graph+0x438/0x460
        trace_selftest_startup_function_graph+0x62/0x260
        run_tracer_selftest+0x116/0x1b0
        register_tracer+0x192/0x260
        do_one_initcall+0x4a/0x180
        do_initcalls+0x146/0x170
        kernel_init_freeable+0x230/0x270
        kernel_init+0x2e/0x188
        __ret_from_fork+0x3c/0x60
        ret_from_fork+0xa/0x38

 -> #1 (pcpu_alloc_mutex){+.+.}-{4:4}:
        __lock_acquire+0x6da/0xcc0
        lock_acquire.part.0+0x10c/0x290
        lock_acquire+0xb0/0x1a0
        __mutex_lock+0xae/0xa20
        mutex_lock_killable_nested+0x32/0x40
        pcpu_alloc_noprof+0x6ea/0x970
        sbitmap_init_node+0x11a/0x230
        sbitmap_queue_init_node+0x3e/0x1c0
        blk_mq_init_tags+0xac/0x140
        blk_mq_alloc_map_and_rqs+0xb0/0x180
        blk_mq_init_sched+0xfc/0x200
        elevator_switch+0x74/0x260
        __elevator_change+0xde/0x150
        elevator_change+0xe4/0x130
        elevator_set_default+0x6c/0xc0
        blk_register_queue+0x188/0x210
        __add_disk_fwnode+0x202/0x420
        add_disk_fwnode+0x7a/0xb0
        sd_probe+0x22e/0x3f0
        really_probe+0x2ac/0x430
        driver_probe_device+0x3c/0xc0
        __device_attach_driver+0xc0/0x140
        bus_for_each_drv+0x90/0xe0
        __device_attach_async_helper+0x94/0xf0
        async_run_entry_fn+0x4a/0x180
        process_one_work+0x2a6/0x5d0
        worker_thread+0x220/0x410
        kthread+0x164/0x2d0
        __ret_from_fork+0x3c/0x60
        ret_from_fork+0xa/0x38

 -> #0 (&q->elevator_lock){+.+.}-{4:4}:
        check_prev_add+0x16c/0xff0
        validate_chain+0x734/0x9f0
        __lock_acquire+0x6da/0xcc0
        lock_acquire.part.0+0x10c/0x290
        lock_acquire+0xb0/0x1a0
        __mutex_lock+0xae/0xa20
        mutex_lock_nested+0x32/0x40
        elevator_change+0x54/0x130
        elv_iosched_store+0xec/0x140
        kernfs_fop_write_iter+0x166/0x230
        vfs_write+0x1ac/0x480
        ksys_write+0x7c/0x100
        __do_syscall+0x156/0x290
        system_call+0x74/0x98

        other info that might help us debug this:

 Chain exists of:
                 &q->elevator_lock --> fs_reclaim --> &q->q_usage_counter(io)#34

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&q->q_usage_counter(io)#34);
                                lock(fs_reclaim);
                                lock(&q->q_usage_counter(io)#34);
   lock(&q->elevator_lock);

                *** DEADLOCK ***

 6 locks held by (udev-worker)/1810:
  #0: 0000005f9d141450 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0x7c/0x100
  #1: 0000005f8ee55090 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x12a/0x230
  #2: 0000005fd0be69a0 (kn->active#68){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x136/0x230
  #3: 00000066feee93c0 (&set->update_nr_hwq_sema/1){.+.+}-{4:4}, at: elv_iosched_store+0xde/0x140
  #4: 0000005fb84dde18 (&q->q_usage_counter(io)#34){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x26/0x40
  #5: 0000005fb84dde58 (&q->q_usage_counter(queue)#11){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x26/0x40

               stack backtrace:
 CPU: 18 UID: 0 PID: 1810 Comm: (udev-worker) Not tainted 6.15.0-rc4-gc2b4d8dcb3d2 #3 PREEMPT
 Hardware name: IBM 9175 ME1 701 (LPAR)
 Call Trace:
  [<00000162f415409a>] dump_stack_lvl+0xa2/0xe8
  [<00000162f424cf9c>] print_circular_bug+0x18c/0x210
  [<00000162f424d198>] check_noncircular+0x178/0x190
  [<00000162f424e57c>] check_prev_add+0x16c/0xff0
  [<00000162f424fb34>] validate_chain+0x734/0x9f0
  [<00000162f4251f8a>] __lock_acquire+0x6da/0xcc0
  [<00000162f425267c>] lock_acquire.part.0+0x10c/0x290
  [<00000162f42528b0>] lock_acquire+0xb0/0x1a0
  [<00000162f525695e>] __mutex_lock+0xae/0xa20
  [<00000162f5257302>] mutex_lock_nested+0x32/0x40
  [<00000162f4c00a54>] elevator_change+0x54/0x130
  [<00000162f4c0136c>] elv_iosched_store+0xec/0x140
  [<00000162f46b6f66>] kernfs_fop_write_iter+0x166/0x230
  [<00000162f45cbe3c>] vfs_write+0x1ac/0x480
  [<00000162f45cc2ac>] ksys_write+0x7c/0x100
  [<00000162f524e956>] __do_syscall+0x156/0x290
  [<00000162f525ff94>] system_call+0x74/0x98
 INFO: lockdep is turned off.


The trigger is a udev rule changing the scheduler for the device.

thanks,
Stefan
