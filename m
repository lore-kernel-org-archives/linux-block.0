Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793591260;
	b=m3a1y4pPoYFVuPixARdANHmmNp/ilYQba6iYDqTDqWZ4O9olZS9HONf5lQLCVtOWpfrL
	 HvhSKqS8gTUmPJM2Z3R8UOARyT1dyoR/zhxJjfOvCtbGT9nabGh5SSzmQ9OXnzIK28+h9
	 lzcOvMt/KwL8uB7mVSfpfcL9HGiVLTX83I34R1obNofTsBrZsiZOskjanm49gDGAzOVOq
	 rXMmfBO3YObGjjqaFwzEKKZp2r4HgTacuaciTH8ShjMq5anKSqaUtcbGWm+qA/aPRCMcx
	 UGjXahdB9R43ygFFAJFyGuBrvOdOeaMnaL7LnyLOGdiWUaxX8OaNSeBnHr7Ef4y+7Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793591260;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=uD1LaQG/1TaEbkKm6gESs+bggUugRbwVcxTo29jmQHo=;
	b=kLyY5v3Opca7LBWKDSWJvys5qxTj4Dy2ON1Luka1m8pdF6S8BOyGeXV3XjRBkAQKzO+L
	 +FZMj//pfLPv/87F430BRJqOovw1WptgAxNr5s2wjubQo3NWPF0Q0hGirLxHqvFb3EUd6
	 +a4ZPlbSA4Hdi+tbWcQHF01Fmhj7Ky8u0jWQuYCdH66b0rIeR7UhO1Fo6F+X/wNlPL9zL
	 mB2FqSTXldUhIcmGAMb+eZHPWzvBXxcjzTJRq8NiY9rK+YWxJDpKRFJZkra3Q0qjOVavm
	 1+0GE7L4X1wdNzqEjygYj6S1qPBEl4Q90GUQkzDTR74S6WF2+96meVBc+nPcPOTUlrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.160.69
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1C606A326
	for <linux-block@vger.kernel.org>; Mon,  2 Nov 2026 03:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92E1C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-4a857aa4c35so2778646fac.2
        for <linux-block@vger.kernel.org>; Sun, 01 Nov 2026 19:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793591258; x=1794196058;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uD1LaQG/1TaEbkKm6gESs+bggUugRbwVcxTo29jmQHo=;
        b=RzDOCcpAxnJjie3EAcDWvCmOpW70TDV16QBn/2ibZmbhGvak8rMZ/BYynl1277CNhH
         8DVQNDEnJs2O53hSePro3ohUWYwPnhx2X0/nLeTfyOpdb0XDlRXYoDiEu6gBcWqOS4aD
         ygKLX3STbA8P63fjsHX7R/5HQ8G/4LCtBoX64VFck6Q+7hjHLSgdKZiHbBBw5MYxzIBU
         lOh7qpA6D+9jx0slG/hJhGgUKSTND98Sb21qaMzqJ+fpwn6Ik05a4YBFdHGm+kkHeUer
         n45TlalTT+aeEpknHmWFu8frtjj/NcVbsk2S+Bm+VdMT7RQrSAtBNGH6iSlLOqtwXors
         fR0Q==
X-Forwarded-Encrypted: i=1; AKwUvBytrN4zFo7xLFgAKFPPzCiy3MTcDifxMLNp2X3DZWzQRqLbVNeHWbT2PGJ29AM/ngYXl7y4+r2+l5PRJA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJH/fcJwegPFEbFrw6C3/zuRyyb7usfFhOyNJ6C907sQxagGk9X
	LlBZAOGrq06Sh6fDho77FTMrIAoh7YG2J598LbDmFSrc5ahYG1Am5kSav1g1OWwn61VRG4D6aHV
	d2zDZlkyIm8GwLXn2BsmvoS658jc71FJqM/ZLx7hvWXkXfOXQAtuRpOFoecM=
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2203:b0:6da:9dae:a2b with SMTP id
 006d021491bc7-714f23ffc31mr5062986eaf.18.1793591258615; Sun, 01 Nov 2026
 19:47:38 -0800 (PST)
Date: Sun, 01 Nov 2026 19:47:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae807da.c8ffc79a.e3697.002b.GAE@google.com>
Subject: [syzbot] [block?] INFO: task hung in blk_mq_freeze_queue_nomemsave (3)
From: syzbot <syzbot+a31cda410a4ccd419712@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7a19f0cc94ad Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10d2b5e1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6602d83d2f34eb80
dashboard link: https://syzkaller.appspot.com/bug?extid=a31cda410a4ccd419712
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c11a8d580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10211a8d580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/26f2e4202da9/disk-7a19f0cc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1e23a9081d19/vmlinux-7a19f0cc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b51f551829ee/Image-7a19f0cc.gz.xz

AI-generated root cause summary:
The loop driver's backing file validation in loop_validate_file() and
loop_check_backing_file() only checks for the presence of read_iter/write_iter
operations, S_ISREG/S_ISBLK inode mode, and direct loop-to-loop device
recursion. Because sysfs/kernfs attribute files are regular files (S_IFREG) and
implement read_iter/write_iter, a loop device can be configured with its own
sysfs queue attribute (such as /sys/block/loop0/queue/scheduler) as its backing
file. When an I/O request is submitted to the loop device, loop_workfn processes
the request while holding a reference on the queue's q->q_usage_counter and
writes to the sysfs file via lo_rw_aio(). The sysfs write handler
(elv_iosched_store -> elevator_change -> blk_mq_freeze_queue) then attempts to
freeze the loop device's own queue, waiting indefinitely in
blk_mq_freeze_queue_wait() for q->q_usage_counter to reach zero, causing an
unresolvable self-deadlock.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=a31cda410a4ccd419712

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a31cda410a4ccd419712@syzkaller.appspotmail.com

INFO: task kworker/u8:1:13 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:1    state:D stack:0     pid:13    tgid:13    ppid:2      task_flags:0x4388060 flags:0x00000010
Workqueue: loop0 loop_workfn
Call trace:
 __switch_to+0x2b4/0x6e4 arch/arm64/kernel/process.c:775 (T)
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x135c/0x2b00 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x13c/0x20c kernel/sched/core.c:7376
 blk_mq_freeze_queue_wait+0xe0/0x160 block/blk-mq.c:191
 blk_mq_freeze_queue_nomemsave+0x28/0x38 block/blk-mq.c:207
 blk_mq_freeze_queue include/linux/blk-mq.h:956 [inline]
 elevator_change+0x174/0x35c block/elevator.c:668
 elv_iosched_store+0x2a8/0x3bc block/elevator.c:826
 queue_attr_store+0x1c0/0x24c block/blk-sysfs.c:906
 sysfs_kf_write+0xe0/0x108 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x260/0x3b8 fs/kernfs/file.c:345
 lo_rw_aio+0xaa0/0xd04 include/linux/percpu-rwsem.h:-1
 do_req_filebacked drivers/block/loop.c:-1 [inline]
 loop_handle_cmd drivers/block/loop.c:1949 [inline]
 loop_process_work+0x4c8/0x960 drivers/block/loop.c:1984
 loop_workfn+0x48/0x58 drivers/block/loop.c:2008
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3479
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3560
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
INFO: task syz.0.17:4976 blocked in I/O wait for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:0     pid:4976  tgid:4976  ppid:4887   task_flags:0x400140 flags:0x00800001
Call trace:
 __switch_to+0x2b4/0x6e4 arch/arm64/kernel/process.c:775 (T)
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x135c/0x2b00 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x13c/0x20c kernel/sched/core.c:7376
 io_schedule+0x1c/0xe0 kernel/sched/core.c:8220
 folio_wait_bit_common+0x6b8/0xa30 mm/filemap.c:1329
 folio_wait_bit+0x30/0x40 mm/filemap.c:1473
 folio_wait_writeback+0x9c/0xf8 mm/page-writeback.c:3062
 __filemap_fdatawait_range+0x168/0x260 mm/filemap.c:532
 filemap_write_and_wait_range+0xe0/0x114 mm/filemap.c:692
 filemap_write_and_wait include/linux/pagemap.h:65 [inline]
 sync_blockdev block/bdev.c:275 [inline]
 bdev_release+0x114/0x328 block/bdev.c:1171
 blkdev_release+0x20/0x34 block/fops.c:687
 __fput+0x338/0x74c fs/file_table.c:512
 ____fput+0x20/0x30 fs/file_table.c:541
 task_work_run+0x1cc/0x25c kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x10c/0x17c kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 arm64_syscall_exit_to_user_mode arch/arm64/kernel/entry-common.c:146 [inline]
 el0_svc+0x12c/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:815
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606

Showing all locks held in the system:
locks held by kworker/u8:1/13: 7, on CPU#1:
 #0: ffff0000c3bd9940 ((wq_completion)loop0){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3371 [inline]
 #0: ffff0000c3bd9940 ((wq_completion)loop0){+.+.}-{0:0}, at: process_scheduled_works+0x8c8/0x1250 kernel/workqueue.c:3479
 #1: ffff80008f997c20 ((work_completion)(&worker->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3371 [inline]
 #1: ffff80008f997c20 ((work_completion)(&worker->work)){+.+.}-{0:0}, at: process_scheduled_works+0x8d0/0x1250 kernel/workqueue.c:3479
 #2: ffff0000d6c59c80 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1b0/0x3b8 fs/kernfs/file.c:336
 #3: ffff0000c77fe878 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #3: ffff0000c77fe878 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x1f0/0x3b8 fs/kernfs/file.c:337
 #4: ffff0000c77b83a0 (&set->update_nr_hwq_lock){++++}-{4:4}, at: elv_iosched_store+0x260/0x3bc block/elevator.c:821
 #5: ffff0000c7783810 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x20/0x38 block/blk-mq.c:206
 #6: ffff0000c7783848 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x20/0x38 block/blk-mq.c:206
locks held by khungtaskd/31: 1, last CPU#0:
 #0: ffff8000899e1820 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff8000899e1820 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff8000899e1820 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x4c/0x188 kernel/locking/lockdep.c:6871
locks held by kworker/0:2/875: 3, on CPU#0:
 #0: ffff0000c002b540 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3371 [inline]
 #0: ffff0000c002b540 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x8c8/0x1250 kernel/workqueue.c:3479
 #1: ffff800094497c20 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3371 [inline]
 #1: ffff800094497c20 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_scheduled_works+0x8d0/0x1250 kernel/workqueue.c:3479
 #2: ffff0000e922e250 (&data->fib_lock){+.+.}-{4:4}, at: nsim_fib_event_work+0x198/0x320 drivers/net/netdevsim/fib.c:1490
locks held by getty/4522: 2, on CPU#1:
 #0: ffff0000cf9db0a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff8000931fe2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x348/0xf78 drivers/tty/n_tty.c:2211

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
