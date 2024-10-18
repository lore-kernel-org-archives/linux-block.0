Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ECB20370D
	for <linux-block@vger.kernel.org>; Fri, 18 Oct 2024 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729270060; cv=none; b=hLdQD8gDDadlLOSEYLzcPdsL6S3GtQG5uV7x2YiTvLPw6qQ6hCSL1Spc99awGFZUiE40MJRfXkkVg7D/5negpCi3rcuk9c9+f5K4dgG9NdXWuaOKbpZI513kvXDmncVhPjphXKMlkgYp9OGl6lH4jqSq3SK1WYfzWx0W1sC3OHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729270060; c=relaxed/simple;
	bh=Y2jeobnX1iWV7gp5qx460isYye9G5XNi2Qkw6IMTw+U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PDW1aTdc+Yst5bc4MKU2l+2/MpznFMU0cEGqxmzmbWUUYQS965cdFR6UOXAETf5hiQ3d/mmBvpJREhWEz+mfFvex7hICFJu2CiX0S6rCthccOASHwD/o2hbF9SOBewXD0xIZs0BmWxWatoHT2Q+fSVN+oasS6mHWDiURhJ4jjYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b506c87cso23806895ab.1
        for <linux-block@vger.kernel.org>; Fri, 18 Oct 2024 09:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729270057; x=1729874857;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ossrGvIXLNejsCP1OLU5UdowpnfKZ/bO7egCrAJ1z1M=;
        b=qjZkHWZbPOM31Dc40Breu7SQ7KJOfghTmWv/AO1Sbra8o4m6J1choNHJ97xMI+8ict
         z4zUGvesTRtVXRCko6qz22FwmtLJVvYpAb9drsMbfQ0vl7IDH1lgmvueu3pOK5KxJxi/
         +A2rKeSGPyO0Pu5z5TSV488t28IZMP/Dky+gQ3I3bSwE+p8Wgp1zVeCYtg2rFLTgQmfv
         gJe19NvreDGU/n/rxjzxNu9TsxwxP0Y/dqF7US7bDEAL2HfKKx1sIHCW1sBvTA8ICiEI
         wtOf0E7a4MQ0ro99/YCNPP76o3ISUwbwNL9nl3mqOOnHIIMCFlkTMLQwHiPFtpdSo0+x
         AVoA==
X-Forwarded-Encrypted: i=1; AJvYcCVpZcrMwwac8ZhdL0kXL0r+sFkJ02egqyqJ99ExealpJVNsR9V7KTmVcyYlqPgRB+iHXuFR4HLkWb0Ymw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgXOqfaTY5rVeBQ1NvM2hNAFDqV66MqGuC7Nyfk9BvT+g3WuaW
	fH/56KCS0ssKfrVQo/Be8m8FKnalw1ONDfA0L40pIyDimeVFX7nySfHAymi5OLfI8MqP/dCTB7q
	VmH7/IQ4WKO+1ewiI0fapYUJ3TT+IDrhXuTSAzUTOqzP2l8gAbYNDTlI=
X-Google-Smtp-Source: AGHT+IGoNLlGRgjz+rACvhsPY2Q7ld6b9VRXWW1C7fRMUXOXqMNRLSrUtvUWKcfNoa66YxgKX7SjzkOZE8V+LcQVHnLlxU/5Hv4w
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a83:b0:3a3:b1c4:8176 with SMTP id
 e9e14a558f8ab-3a3f40b728fmr28271365ab.24.1729270057064; Fri, 18 Oct 2024
 09:47:37 -0700 (PDT)
Date: Fri, 18 Oct 2024 09:47:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67129129.050a0220.1e4b4d.0017.GAE@google.com>
Subject: [syzbot] [block?] INFO: task hung in blk_mq_update_tag_set_shared
From: syzbot <syzbot+d6e9e199299dade9c496@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    07b887f8236e xhci: add helper to stop endpoint and wait fo..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=17629830580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9878fe11046ea2c6
dashboard link: https://syzkaller.appspot.com/bug?extid=d6e9e199299dade9c496
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c447438ae517/disk-07b887f8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1430abb44ca1/vmlinux-07b887f8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/53e62be3705b/bzImage-07b887f8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6e9e199299dade9c496@syzkaller.appspotmail.com

INFO: task kworker/1:4:4968 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00051-g07b887f8236e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:4     state:D stack:20512 pid:4968  tgid:4968  ppid:2      flags:0x00004000
Workqueue: events_freezable usb_stor_scan_dwork
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 blk_mq_freeze_queue_wait+0x146/0x190 block/blk-mq.c:139
 blk_freeze_queue block/blk-mq.c:166 [inline]
 blk_mq_freeze_queue block/blk-mq.c:175 [inline]
 blk_mq_update_tag_set_shared+0xba/0x160 block/blk-mq.c:4035
 blk_mq_add_queue_tag_set block/blk-mq.c:4069 [inline]
 blk_mq_init_allocated_queue+0xd59/0x11f0 block/blk-mq.c:4343
 blk_mq_alloc_queue+0x1f8/0x2f0 block/blk-mq.c:4158
 scsi_alloc_sdev+0x897/0xd90 drivers/scsi/scsi_scan.c:337
 scsi_probe_and_add_lun+0x525/0x7b0 drivers/scsi/scsi_scan.c:1210
 scsi_sequential_lun_scan drivers/scsi/scsi_scan.c:1393 [inline]
 __scsi_scan_target+0x42c/0x4e0 drivers/scsi/scsi_scan.c:1764
 scsi_scan_channel drivers/scsi/scsi_scan.c:1845 [inline]
 scsi_scan_channel+0x149/0x1e0 drivers/scsi/scsi_scan.c:1821
 scsi_scan_host_selected+0x2ae/0x370 drivers/scsi/scsi_scan.c:1874
 do_scsi_scan_host+0x1ef/0x260 drivers/scsi/scsi_scan.c:2013
 scsi_scan_host drivers/scsi/scsi_scan.c:2043 [inline]
 scsi_scan_host+0x3a7/0x440 drivers/scsi/scsi_scan.c:2031
 usb_stor_scan_dwork+0xad/0x280 drivers/usb/storage/usb.c:998
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
6 locks held by kworker/0:1/9:
 #0: ffff888105adf548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000009fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109b4b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888109b4b190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: 
ffff88811d170190
 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff888118050160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888118050160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffff8881328e8d20 (&dev->phy_mutex){+.+.}-{3:3}, at: mcs7830_write_phy+0xa6/0x2d0 drivers/net/usb/mcs7830.c:227
4 locks held by kworker/u8:0/11:
 #0: ffff888100abf948 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900000bfd80 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888105b36378 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888105b36378 (&dev->mutex){....}-{3:3}, at: __device_attach_async_helper+0x84/0x290 drivers/base/dd.c:973
 #3: ffff888105f9bd60 (&q->limits_lock){+.+.}-{3:3}, at: queue_limits_start_update include/linux/blkdev.h:926 [inline]
 #3: ffff888105f9bd60 (&q->limits_lock){+.+.}-{3:3}, at: sd_revalidate_disk.isra.0+0x27a/0xa420 drivers/scsi/sd.c:3727
1 lock held by khungtaskd/30:
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
2 locks held by getty/2607:
 #0: ffff888108afe0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
4 locks held by udevd/4907:
 #0: ffff8881327c30a0 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff88811c18e888 (&of->mutex){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff88812ea73e18 (kn->active#18){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88811cb6f190 (&dev->mutex){....}-{3:3}
, at: device_lock_interruptible include/linux/device.h:1019 [inline]
, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
5 locks held by kworker/0:4/4927:
4 locks held by udevd/4962:
 #0: ffff88811bafcd58 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff888118208c88 (&of->mutex){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff888116fd1e18 (kn->active#18){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff888118647190 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:1019 [inline]
 #3: ffff888118647190 (&dev->mutex){....}-{3:3}, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
4 locks held by kworker/1:4/4968:
 #0: ffff888100081548 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90002f77d80 ((work_completion)(&(&us->scan_dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88811f2c40e0 (&shost->scan_mutex){+.+.}-{3:3}, at: scsi_scan_host_selected+0x160/0x370 drivers/scsi/scsi_scan.c:1866
 #3: ffff88811f2c42d0 (&set->tag_list_lock){+.+.}-{3:3}, at: blk_mq_add_queue_tag_set block/blk-mq.c:4060 [inline]
 #3: ffff88811f2c42d0 (&set->tag_list_lock){+.+.}-{3:3}, at: blk_mq_init_allocated_queue+0x7bc/0x11f0 block/blk-mq.c:4343
2 locks held by kworker/u8:1/8285:
 #0: ffff88811b967148 ((wq_completion)scsi_tmf_1){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90011d47d80 ((work_completion)(&(&cmd->abort_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
6 locks held by kworker/1:2/9465:
5 locks held by kworker/1:3/19696:
 #0: ffff888105adf548
 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000662fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88810978b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff88810978b190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88810bfd9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88810bfd9190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff8881323cb160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff8881323cb160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff8881323cb160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
1 lock held by usb-storage/21984:
 #0: ffff88811f2c4d08 (&us_interface_key[i]){+.+.}-{3:3}, at: usb_stor_control_thread+0xd6/0xac0 drivers/usb/storage/usb.c:394
5 locks held by kworker/1:5/22023:
1 lock held by syz.0.4668/23009:
 #0: ffffffff88ec69f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329
1 lock held by syz.4.4669/23011:
 #0: ffffffff88ec69f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc3-syzkaller-00051-g07b887f8236e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf0c/0x1240 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc3-syzkaller-00051-g07b887f8236e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:rol32 include/linux/bitops.h:127 [inline]
RIP: 0010:iterate_chain_key kernel/locking/lockdep.c:448 [inline]
RIP: 0010:__lock_acquire+0xc4e/0x3ce0 kernel/locking/lockdep.c:5190
Code: d8 8b 5c 24 68 89 c2 29 c1 c1 c2 06 31 ca 01 d8 29 d3 89 d9 89 d3 01 c2 c1 c3 08 31 cb 89 d9 29 d8 01 d3 c1 c1 10 89 de 31 c8 <89> c1 29 c2 01 d8 c1 c9 0d 31 d1 89 ca 29 ce 01 c8 c1 c2 04 89 c0
RSP: 0018:ffffc900000078c8 EFLAGS: 00000082
RAX: 00000000ebe4eeae RBX: 00000000ff533bd4 RCX: 00000000eb48ff53
RDX: 00000000ffff508c RSI: 00000000ff533bd4 RDI: ffffffff8fad10f8
RBP: 0000000000000022 R08: 0000000000000000 R09: fffffbfff1f55dbe
R10: ffffffff8faaedf7 R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff88c2d258 R14: 0000000000000002 R15: ffffffff88c2c7c0
FS:  0000000000000000(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555574e294a8 CR3: 0000000120378000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 kcov_remote_stop+0x8e/0x5f0 kernel/kcov.c:1007
 kcov_remote_stop_softirq include/linux/kcov.h:98 [inline]
 __usb_hcd_giveback_urb+0x4d9/0x6e0 drivers/usb/core/hcd.c:1651
 usb_hcd_giveback_urb+0x396/0x450 drivers/usb/core/hcd.c:1734
 dummy_timer+0x17c3/0x38d0 drivers/usb/gadget/udc/dummy_hcd.c:1988
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1755
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1772
 handle_softirqs+0x206/0x8d0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xac/0x110 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1037
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:92 [inline]
RIP: 0010:acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:112
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 65 48 8b 05 b8 0b 15 79 48 8b 00 a8 08 75 0c 66 90 0f 00 2d c8 2e 61 00 fb f4 <fa> c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffffff88c07d70 EFLAGS: 00000246
RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffffffff86ee9b79
RDX: 0000000000000001 RSI: ffff8881052a9800 RDI: ffff8881052a9864
RBP: ffff8881052a9864 R08: 0000000000000001 R09: ffffed103eb06fd9
R10: ffff8881f5837ecb R11: 0000000000000000 R12: ffff88810bec2000
R13: ffffffff89340ca0 R14: 0000000000000000 R15: 0000000000000000
 acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:702
 cpuidle_enter_state+0xaa/0x4f0 drivers/cpuidle/cpuidle.c:264
 cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:385
 cpuidle_idle_call kernel/sched/idle.c:230 [inline]
 do_idle+0x313/0x3f0 kernel/sched/idle.c:326
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:424
 rest_init+0x16b/0x2b0 init/main.c:747
 start_kernel+0x3df/0x4c0 init/main.c:1105
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:488
 common_startup_64+0x12c/0x138
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
