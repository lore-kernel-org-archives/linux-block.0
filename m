Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A82701B2
	for <linux-block@vger.kernel.org>; Fri, 16 May 2025 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422879; cv=none; b=mUROrxTfXN2ftHY5ssRMaUozpevJK85XjPmipKnIc7K/Ty5UwBozL64zBOp71i6Ptw7ljTC5iKVrfUCMsKv4npkVCZDEJ3u5N2ufwXkKsqhcrBK4/r9s46S8oJOkGvFPREvaeYG8JNFzoi+ipNvShvR+EwXYnT/oCx4HQiyjEBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422879; c=relaxed/simple;
	bh=YqSJ6woo5H1zi5dibdPMxFwRlXf1TjH4+9yExyTdMXw=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=CiolqmAYtntYOSY/bqNWQ0hrBllE9Kello2miXKkKJh7c+7FaVaUw1wlqLfwUIiLP7YkwbkECMKFtx4KFObL2SjSDj2pBrp22Kk7bsjl1JbGp+NqlXaY8nUTngpu6IwsMoW3eIEDjdGWO/rEF8Hk6wmekzSZ3ct6pDbP+2hQ2lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PN4rLugP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PN4rLugP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747422876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ssb/oCRCb6+ZzFD2fa9qy8bsMNYL4+6JKdv8E1IA3tk=;
	b=PN4rLugPsYAoe+gNI8KXq8E5lcodcuNCfJR7KYuj9ikwxVVfp9E76r79zbqKdLfW2E1cOp
	XF123d+nMr2VxkY+5ZkVPIFX4GD3G3DMXzk4jUPntzlWC1oEDg36UG/esC6SuUwq+g+Bsi
	7jL6mTLwP5LpcTjcHn4LeItbZGbGM6c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-xvI7DCrJPbqg1I8Doohr5Q-1; Fri,
 16 May 2025 15:14:33 -0400
X-MC-Unique: xvI7DCrJPbqg1I8Doohr5Q-1
X-Mimecast-MFC-AGG-ID: xvI7DCrJPbqg1I8Doohr5Q_1747422872
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E84B1956096;
	Fri, 16 May 2025 19:14:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F059530075D5;
	Fri, 16 May 2025 19:14:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: dhowells@redhat.com, linux-block@vger.kernel.org
Subject: Still seeing q->elevator_lock circular locking warning
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2654613.1747422869.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 May 2025 20:14:29 +0100
Message-ID: <2654614.1747422869@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Jens,

I just realised that I'm still seeing a warning about circular locking
involving q->elevator_lock in -rc6.  Do you know if there's a fix for this
yet?

David
---

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
 WARNING: possible circular locking dependency detected
 6.15.0-rc6-build2+ #1293 Not tainted
 ------------------------------------------------------
 (udev-worker)/4602 is trying to acquire lock:
 ffff88810c5585c0 (&q->elevator_lock){+.+.}-{4:4}, at: elv_iosched_store+0=
xf9/0x210
 =

 but task is already holding lock:
 ffff88810c5580a8 (&q->q_usage_counter(io)#9){++++}-{0:0}, at: blk_mq_free=
ze_queue_nomemsave+0xf/0x20
 =

 which lock already depends on the new lock.

 =

 the existing dependency chain (in reverse order) is:
 =

 -> #2 (&q->q_usage_counter(io)#9){++++}-{0:0}:
        validate_chain+0x1dc/0x280
        __lock_acquire+0x5b6/0x720
        lock_acquire.part.0+0xb4/0x1f0
        blk_alloc_queue+0x38b/0x420
        blk_mq_alloc_queue+0xd4/0x150
        scsi_alloc_sdev+0x47e/0x5e0
        scsi_probe_and_add_lun+0x15c/0x370
        __scsi_add_device+0x123/0x190
        ata_scsi_scan_host+0x94/0x1d0
        async_run_entry_fn+0x4b/0x130
        process_one_work+0x485/0x7b0
        process_scheduled_works+0x73/0x90
        worker_thread+0x1c8/0x2a0
        kthread+0x2f9/0x310
        ret_from_fork+0x24/0x40
        ret_from_fork_asm+0x1a/0x30
 =

 -> #1 (fs_reclaim){+.+.}-{0:0}:
        validate_chain+0x1dc/0x280
        __lock_acquire+0x5b6/0x720
        lock_acquire.part.0+0xb4/0x1f0
        __fs_reclaim_acquire+0x21/0x30
        fs_reclaim_acquire+0x2d/0x70
        might_alloc+0x8/0x40
        kmem_cache_alloc_noprof+0x42/0x230
        __kernfs_new_node+0xc6/0x3e0
        kernfs_new_node+0x89/0xc0
        kernfs_create_dir_ns+0x27/0xa0
        sysfs_create_dir_ns+0xf5/0x170
        kobject_add_internal+0x141/0x2c0
        kobject_add+0xfd/0x140
        elv_register_queue+0x74/0x100
        blk_register_queue+0x16a/0x240
        add_disk_fwnode+0x371/0x710
        sd_probe+0x50d/0x620
        really_probe+0x167/0x320
        __driver_probe_device+0x121/0x160
        driver_probe_device+0x4a/0xd0
        __device_attach_driver+0x99/0xd0
        bus_for_each_drv+0x104/0x140
        __device_attach_async_helper+0xdb/0x140
        async_run_entry_fn+0x4b/0x130
        process_one_work+0x485/0x7b0
        process_scheduled_works+0x73/0x90
        worker_thread+0x1c8/0x2a0
        kthread+0x2f9/0x310
        ret_from_fork+0x24/0x40
        ret_from_fork_asm+0x1a/0x30
 =

 -> #0 (&q->elevator_lock){+.+.}-{4:4}:
        check_noncircular+0x96/0xc0
        check_prev_add+0x115/0x2f0
        validate_chain+0x1dc/0x280
        __lock_acquire+0x5b6/0x720
        lock_acquire.part.0+0xb4/0x1f0
        __mutex_lock+0x16d/0x5e0
        elv_iosched_store+0xf9/0x210
        queue_attr_store+0xcb/0x1c0
        kernfs_fop_write_iter+0x194/0x210
        vfs_write+0x220/0x310
        ksys_write+0xb8/0x120
        do_syscall_64+0x9f/0x100
        entry_SYSCALL_64_after_hwframe+0x76/0x7e
 =

 other info that might help us debug this:

 Chain exists of:
   &q->elevator_lock --> fs_reclaim --> &q->q_usage_counter(io)#9

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&q->q_usage_counter(io)#9);
                                lock(fs_reclaim);
                                lock(&q->q_usage_counter(io)#9);
   lock(&q->elevator_lock);
 =

  *** DEADLOCK ***

 5 locks held by (udev-worker)/4602:
  #0: ffff88810e4a4408 (sb_writers#4){.+.+}-{0:0}, at: vfs_write+0xfc/0x31=
0
  #1: ffff888112e2b888 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_it=
er+0x125/0x210
  #2: ffff88810c8062d8 (kn->active#55){.+.+}-{0:0}, at: kernfs_fop_write_i=
ter+0x135/0x210
  #3: ffff88810c5580a8 (&q->q_usage_counter(io)#9){++++}-{0:0}, at: blk_mq=
_freeze_queue_nomemsave+0xf/0x20
  #4: ffff88810c5580e0 (&q->q_usage_counter(queue)){++++}-{0:0}, at: blk_m=
q_freeze_queue_nomemsave+0xf/0x20
 =

 stack backtrace:
 CPU: 3 UID: 0 PID: 4602 Comm: (udev-worker) Not tainted 6.15.0-rc6-build2=
+ #1293 PREEMPT(voluntary) =

 Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x57/0x80
  print_circular_bug+0xb5/0xd0
  check_noncircular+0x96/0xc0
  ? _find_first_zero_bit+0x1e/0x50
  check_prev_add+0x115/0x2f0
  validate_chain+0x1dc/0x280
  __lock_acquire+0x5b6/0x720
  lock_acquire.part.0+0xb4/0x1f0
  ? elv_iosched_store+0xf9/0x210
  ? rcu_is_watching+0x34/0x60
  ? lock_acquire+0x88/0xf0
  __mutex_lock+0x16d/0x5e0
  ? elv_iosched_store+0xf9/0x210
  ? preempt_count_sub+0x18/0xc0
  ? elv_iosched_store+0xf9/0x210
  ? __pfx___mutex_lock+0x10/0x10
  ? blk_mq_freeze_queue_wait+0xe6/0x130
  ? lock_acquire.part.0+0xc4/0x1f0
  ? __pfx_autoremove_wake_function+0x10/0x10
  ? lock_acquire+0x88/0xf0
  ? elv_iosched_store+0xf9/0x210
  elv_iosched_store+0xf9/0x210
  ? __pfx_elv_iosched_store+0x10/0x10
  ? __pfx___mutex_trylock_common+0x10/0x10
  queue_attr_store+0xcb/0x1c0
  ? mark_lock+0x2e/0x110
  ? __pfx_queue_attr_store+0x10/0x10
  ? __lock_acquire+0x5b6/0x720
  ? lock_is_held_type+0xbe/0x110
  ? find_held_lock+0x2b/0x80
  ? sysfs_file_kobj+0x129/0x140
  ? __lock_release.isra.0+0x5a/0x150
  ? sysfs_file_kobj+0x129/0x140
  ? lock_release+0xe3/0x120
  ? __rcu_read_unlock+0x4c/0x70
  ? sysfs_file_kobj+0x133/0x140
  ? __pfx_sysfs_kf_write+0x10/0x10
  kernfs_fop_write_iter+0x194/0x210
  vfs_write+0x220/0x310
  ? __pfx_vfs_write+0x10/0x10
  ? ktime_get_coarse_real_ts64+0x19/0x70
  ? files_lookup_fd_raw+0x40/0x50
  ? __fget_light+0x5b/0x90
  ksys_write+0xb8/0x120
  ? __pfx_ksys_write+0x10/0x10
  ? syscall_trace_enter+0x10c/0x150
  do_syscall_64+0x9f/0x100
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f033d80e044
 Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f=
3 0f 1e fa 80 3d 65 a0 10 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 f=
f ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
 RSP: 002b:00007ffe41add9f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f033d80e044
 RDX: 0000000000000003 RSI: 00007ffe41addd00 RDI: 0000000000000027
 RBP: 00007ffe41adda20 R08: 00007f033d90f1c8 R09: 00007ffe41addad0
 R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
 R13: 00007ffe41addd00 R14: 00005626a9b65980 R15: 00007f033d90ee80
  </TASK>

