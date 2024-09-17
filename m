Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C95915A4B0
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567409; cv=none; b=Xu8WxiJLL87SQY2VDIZ/5qHNPtbkQZssVkLvtSqcJiBPrOPneAaUG2yKM2Mlu7ln7IeYbCRRmxFAwwx/zjVoIbEvnloVKbkVWCd3SNn6CAL5+0Ll+HvtCig0YMgFACfdL4oIOZ2oUoQYugVwpm4ZFbHoP/4R/TEfd/i2TYHCEtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567409; c=relaxed/simple;
	bh=Na+eBIzkI26MAZmjZmrxv8c1uhev6zw3SAPiS40PKtg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pDyXEo1lbyOcvAGBjE8XbcMnc7h5mo4lUECfaSbvefVIHOit3z3ZeNSCnWCnhRBKdC2B3OIUo+0KAJ0WHplJL4OwPu3RND52V2tG03LQ48HLF2cMzquhy/4teAi/PxYkj2+R2ITOhyko/a9rxQD7+AL+DQJZuOvWlnagZMVaIrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a093440d95so56257375ab.2
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 03:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726567407; x=1727172207;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4PZX0METPue9cW+U6xQ2tNlECW3HyF+zXQLnkT6SHc=;
        b=VpwiuLGHchZ+CmA+Oksyq5bFDo8j9Nu5Nvej4V7cr+x4MCfCzrw9X449Muwp+9n70N
         IzfeEWFOK6jBzp7CC5PfRVxtsucIj9KxNMtPTToxDAXTqKYMzHvWPh6Ke9gDml4TUBOD
         sa9D5QxMbRN+z6BkGEzJs8POeh/Cu1i/fuZoObnLTHWvy1OFtn2/mLQmarGPjWOwlDHN
         b0P1O5bNCcsgg/xv9tSgCyfFxgGMZIV8HMH1GGl8BvAsECBnKxxx5kc5JrUfXeDLdHJy
         FZ0KfIlkzTPQhoQYUE1HTMxybUcry5qPYFDTkKC20wUPjzAM0F8jdySrv71j2jZ1n9NH
         lfYw==
X-Forwarded-Encrypted: i=1; AJvYcCWMKasdxany0D+NBqLeLT7kFyxUE0Gq3AYS1VUMZPl1aQ+mZ01U65S/KmoKUAkT/rnCDQEfgMYRh7vyVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzTPdhXYCV3tlOCb1QthETkFyIpyeYdoXUpMdNVUGIgP1VULpY
	VHjZ3ot9hDOqyvb5tizsq+ITfwETGqD9Bqwf9HQIteJdYw+buHpJe+BVNS6XMYbOMlVeTuSIj+G
	aw/dmJg9ebvzGJj/QBjVRSYMS78ynzrf2Fj4R2wYl0XovGbnWgWO7f7U=
X-Google-Smtp-Source: AGHT+IHf6Y+tx5aqAYlWCHBmF2LhEBb7W+HSMYRLKJZ6wl3d0RhbJF/7sMQhDczWD5MAlj3Bu+q2T5NeYwZWzWmaSyQ2pTMmSniR
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168c:b0:3a0:9cd5:92f7 with SMTP id
 e9e14a558f8ab-3a09cd594d9mr60686645ab.17.1726567406600; Tue, 17 Sep 2024
 03:03:26 -0700 (PDT)
Date: Tue, 17 Sep 2024 03:03:26 -0700
In-Reply-To: <0000000000009848bf0620b32ba5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e953ee.050a0220.252d9a.0008.GAE@google.com>
Subject: Re: [syzbot] [nbd?] INFO: task hung in nbd_queue_rq
From: syzbot <syzbot+30c16035531e3248dcbc@syzkaller.appspotmail.com>
To: axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9410645520e9 Merge tag 'net-next-6.12' of git://git.kernel..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=150ee29f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37c006d80708398d
dashboard link: https://syzkaller.appspot.com/bug?extid=30c16035531e3248dcbc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bdbc07980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a368a9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/80466d230dfb/disk-94106455.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba253eabab42/vmlinux-94106455.xz
kernel image: https://storage.googleapis.com/syzbot-assets/569982fb6c88/bzImage-94106455.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30c16035531e3248dcbc@syzkaller.appspotmail.com

INFO: task udevd:5270 blocked for more than 143 seconds.
      Not tainted 6.11.0-syzkaller-01458-g9410645520e9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:21400 pid:5270  tgid:5270  ppid:4686   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2581
 wait_for_reconnect drivers/block/nbd.c:1023 [inline]
 nbd_handle_cmd drivers/block/nbd.c:1065 [inline]
 nbd_queue_rq+0x7cd/0x2f70 drivers/block/nbd.c:1123
 blk_mq_dispatch_rq_list+0xb89/0x1b30 block/blk-mq.c:2032
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0xb8a/0x1840 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0xcb/0x140 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x576/0xae0 block/blk-mq.c:2245
 blk_mq_flush_plug_list+0x1115/0x1880 block/blk-mq.c:2794
 __blk_flush_plug+0x420/0x500 block/blk-core.c:1198
 blk_finish_plug block/blk-core.c:1225 [inline]
 __submit_bio+0x422/0x560 block/blk-core.c:623
 __submit_bio_noacct_mq block/blk-core.c:696 [inline]
 submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:725
 submit_bh fs/buffer.c:2829 [inline]
 block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2456
 filemap_read_folio+0x1a0/0x790 mm/filemap.c:2355
 do_read_cache_folio+0x134/0x820 mm/filemap.c:3789
 read_mapping_folio include/linux/pagemap.h:913 [inline]
 read_part_sector+0xb3/0x330 block/partitions/core.c:712
 adfspart_check_ICS+0xd9/0x9a0 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:138 [inline]
 blk_add_partitions block/partitions/core.c:579 [inline]
 bdev_disk_changed+0x72c/0x13d0 block/partitions/core.c:683
 blkdev_get_whole+0x2d2/0x450 block/bdev.c:700
 bdev_open+0x2d4/0xc60 block/bdev.c:909
 blkdev_open+0x3e8/0x570 block/fops.c:630
 do_dentry_open+0x970/0x1440 fs/open.c:959
 vfs_open+0x3e/0x330 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2b3e/0x3470 fs/namei.c:3886
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa51fb169a4
RSP: 002b:00007ffc16756ab0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000562ce708fe10 RCX: 00007fa51fb169a4
RDX: 00000000000a0800 RSI: 0000562ce706f750 RDI: 00000000ffffff9c
RBP: 0000562ce706f750 R08: 00000000ffffffff R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
R13: 0000562ce7081250 R14: 0000000000000001 R15: 0000562ce706e910
 </TASK>
INFO: task udevd:5932 blocked for more than 144 seconds.
      Not tainted 6.11.0-syzkaller-01458-g9410645520e9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:22032 pid:5932  tgid:5932  ppid:4686   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2581
 wait_for_reconnect drivers/block/nbd.c:1023 [inline]
 nbd_handle_cmd drivers/block/nbd.c:1065 [inline]
 nbd_queue_rq+0x7cd/0x2f70 drivers/block/nbd.c:1123
 blk_mq_dispatch_rq_list+0xb89/0x1b30 block/blk-mq.c:2032
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0xb8a/0x1840 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0xcb/0x140 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x576/0xae0 block/blk-mq.c:2245
 blk_mq_flush_plug_list+0x1115/0x1880 block/blk-mq.c:2794
 __blk_flush_plug+0x420/0x500 block/blk-core.c:1198
 blk_finish_plug block/blk-core.c:1225 [inline]
 __submit_bio+0x422/0x560 block/blk-core.c:623
 __submit_bio_noacct_mq block/blk-core.c:696 [inline]
 submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:725
 submit_bh fs/buffer.c:2829 [inline]
 block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2456
 filemap_read_folio+0x1a0/0x790 mm/filemap.c:2355
 do_read_cache_folio+0x134/0x820 mm/filemap.c:3789
 read_mapping_folio include/linux/pagemap.h:913 [inline]
 read_part_sector+0xb3/0x330 block/partitions/core.c:712
 adfspart_check_ICS+0xd9/0x9a0 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:138 [inline]
 blk_add_partitions block/partitions/core.c:579 [inline]
 bdev_disk_changed+0x72c/0x13d0 block/partitions/core.c:683
 blkdev_get_whole+0x2d2/0x450 block/bdev.c:700
 bdev_open+0x2d4/0xc60 block/bdev.c:909
 blkdev_open+0x3e8/0x570 block/fops.c:630
 do_dentry_open+0x970/0x1440 fs/open.c:959
 vfs_open+0x3e/0x330 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2b3e/0x3470 fs/namei.c:3886
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa51fb169a4
RSP: 002b:00007ffc16756ab0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000562ce7078b20 RCX: 00007fa51fb169a4
RDX: 00000000000a0800 RSI: 0000562ce707e8b0 RDI: 00000000ffffff9c
RBP: 0000562ce707e8b0 R08: 0000000000000001 R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
R13: 0000562ce7081250 R14: 0000000000000001 R15: 0000562ce706e910
 </TASK>
INFO: task udevd:5999 blocked for more than 144 seconds.
      Not tainted 6.11.0-syzkaller-01458-g9410645520e9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:20536 pid:5999  tgid:5999  ppid:4686   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2581
 wait_for_reconnect drivers/block/nbd.c:1023 [inline]
 nbd_handle_cmd drivers/block/nbd.c:1065 [inline]
 nbd_queue_rq+0x7cd/0x2f70 drivers/block/nbd.c:1123
 blk_mq_dispatch_rq_list+0xb89/0x1b30 block/blk-mq.c:2032
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0xb8a/0x1840 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0xcb/0x140 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x576/0xae0 block/blk-mq.c:2245
 blk_mq_flush_plug_list+0x1115/0x1880 block/blk-mq.c:2794
 __blk_flush_plug+0x420/0x500 block/blk-core.c:1198
 blk_finish_plug block/blk-core.c:1225 [inline]
 __submit_bio+0x422/0x560 block/blk-core.c:623
 __submit_bio_noacct_mq block/blk-core.c:696 [inline]
 submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:725
 submit_bh fs/buffer.c:2829 [inline]
 block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2456
 filemap_read_folio+0x1a0/0x790 mm/filemap.c:2355
 do_read_cache_folio+0x134/0x820 mm/filemap.c:3789
 read_mapping_folio include/linux/pagemap.h:913 [inline]
 read_part_sector+0xb3/0x330 block/partitions/core.c:712
 adfspart_check_ICS+0xd9/0x9a0 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:138 [inline]
 blk_add_partitions block/partitions/core.c:579 [inline]
 bdev_disk_changed+0x72c/0x13d0 block/partitions/core.c:683
 blkdev_get_whole+0x2d2/0x450 block/bdev.c:700
 bdev_open+0x2d4/0xc60 block/bdev.c:909
 blkdev_open+0x3e8/0x570 block/fops.c:630
 do_dentry_open+0x970/0x1440 fs/open.c:959
 vfs_open+0x3e/0x330 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2b3e/0x3470 fs/namei.c:3886
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa51fb169a4
RSP: 002b:00007ffc16756ab0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000562ce708fe10 RCX: 00007fa51fb169a4
RDX: 00000000000a0800 RSI: 0000562ce708d1d0 RDI: 00000000ffffff9c
RBP: 0000562ce708d1d0 R08: 00000000ffffffff R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
R13: 0000562ce7083540 R14: 0000000000000001 R15: 0000562ce706e910
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6626
6 locks held by kworker/u8:12/3029:
2 locks held by getty/4988:
 #0: ffff88803022d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031232f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ac/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by udevd/5270:
 #0: ffff888025c964c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0xf0/0xc60 block/bdev.c:897
 #1: ffff888025be7a10 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:151 [inline]
 #1: ffff888025be7a10 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:250 [inline]
 #1: ffff888025be7a10 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x54d/0xae0 block/blk-mq.c:2245
 #2: ffff888025d88180 (&cmd->lock){+.+.}-{3:3}, at: nbd_queue_rq+0xfc/0x2f70 drivers/block/nbd.c:1115
3 locks held by udevd/5932:
 #0: ffff888025db24c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0xf0/0xc60 block/bdev.c:897
 #1: ffff888025c0f090 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:151 [inline]
 #1: ffff888025c0f090 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:250 [inline]
 #1: ffff888025c0f090 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x54d/0xae0 block/blk-mq.c:2245
 #2: ffff888025e10180 (&cmd->lock){+.+.}-{3:3}, at: nbd_queue_rq+0xfc/0x2f70 drivers/block/nbd.c:1115
3 locks held by udevd/5999:
 #0: ffff8880259654c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0xf0/0xc60 block/bdev.c:897
 #1: ffff888021fd1090 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:151 [inline]
 #1: ffff888021fd1090 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:250 [inline]
 #1: ffff888021fd1090 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x54d/0xae0 block/blk-mq.c:2245
 #2: ffff888025df0180 (&cmd->lock){+.+.}-{3:3}, at: nbd_queue_rq+0xfc/0x2f70 drivers/block/nbd.c:1115
3 locks held by udevd/6117:
 #0: ffff888025d594c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0xf0/0xc60 block/bdev.c:897
 #1: ffff888021fd1810 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:151 [inline]
 #1: ffff888021fd1810 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:250 [inline]
 #1: ffff888021fd1810 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x54d/0xae0 block/blk-mq.c:2245
 #2: ffff888025e58180 (&cmd->lock){+.+.}-{3:3}, at: nbd_queue_rq+0xfc/0x2f70 drivers/block/nbd.c:1115
3 locks held by udevd/6526:
 #0: ffff888025d5d4c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0xf0/0xc60 block/bdev.c:897
 #1: ffff888021fd1b10 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:151 [inline]
 #1: ffff888021fd1b10 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:250 [inline]
 #1: ffff888021fd1b10 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x54d/0xae0 block/blk-mq.c:2245
 #2: ffff888025eb0180 (&cmd->lock){+.+.}-{3:3}, at: nbd_queue_rq+0xfc/0x2f70 drivers/block/nbd.c:1115
3 locks held by udevd/6711:
 #0: ffff888025db64c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0xf0/0xc60 block/bdev.c:897
 #1: ffff888025c0fb90 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:151 [inline]
 #1: ffff888025c0fb90 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:250 [inline]
 #1: ffff888025c0fb90 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x54d/0xae0 block/blk-mq.c:2245
 #2: ffff888025f18180 (&cmd->lock){+.+.}-{3:3}, at: nbd_queue_rq+0xfc/0x2f70 drivers/block/nbd.c:1115
3 locks held by udevd/6856:
 #0: ffff888025ee24c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0xf0/0xc60 block/bdev.c:897
 #1: ffff888025d14090 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:151 [inline]
 #1: ffff888025d14090 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:250 [inline]
 #1: ffff888025d14090 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x54d/0xae0 block/blk-mq.c:2245
 #2: ffff888025f50180 (&cmd->lock){+.+.}-{3:3}, at: nbd_queue_rq+0xfc/0x2f70 drivers/block/nbd.c:1115
3 locks held by udevd/6906:
 #0: ffff888025e914c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0xf0/0xc60 block/bdev.c:897
 #1: ffff888022375510 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:151 [inline]
 #1: ffff888022375510 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:250 [inline]
 #1: ffff888022375510 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x54d/0xae0 block/blk-mq.c:2245
 #2: ffff888025fc0180 (&cmd->lock){+.+.}-{3:3}, at: nbd_queue_rq+0xfc/0x2f70 drivers/block/nbd.c:1115
3 locks held by udevd/6907:
 #0: ffff888025e924c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0xf0/0xc60 block/bdev.c:897
 #1: ffff888022375a90 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:151 [inline]
 #1: ffff888022375a90 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:250 [inline]
 #1: ffff888022375a90 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x54d/0xae0 block/blk-mq.c:2245
 #2: ffff888026468180 (&cmd->lock){+.+.}-{3:3}, at: nbd_queue_rq+0xfc/0x2f70 drivers/block/nbd.c:1115
3 locks held by udevd/7007:
 #0: ffff8880264194c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0xf0/0xc60 block/bdev.c:897
 #1: ffff888025d14a10 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:151 [inline]
 #1: ffff888025d14a10 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:250 [inline]
 #1: ffff888025d14a10 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x54d/0xae0 block/blk-mq.c:2245
 #2: ffff888026490180 (&cmd->lock){+.+.}-{3:3}, at: nbd_queue_rq+0xfc/0x2f70 drivers/block/nbd.c:1115
3 locks held by udevd/7074:
 #0: ffff888025e964c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0xf0/0xc60 block/bdev.c:897
 #1: ffff888022399110 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:151 [inline]
 #1: ffff888022399110 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:250 [inline]
 #1: ffff888022399110 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x54d/0xae0 block/blk-mq.c:2245
 #2: ffff8880264c0180 (&cmd->lock){+.+.}-{3:3}, at: nbd_queue_rq+0xfc/0x2f70 drivers/block/nbd.c:1115
3 locks held by udevd/7144:
 #0: ffff888025f924c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0xf0/0xc60 block/bdev.c:897
 #1: ffff888022399710 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:151 [inline]
 #1: ffff888022399710 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:250 [inline]
 #1: ffff888022399710 (set->srcu){.+.+}-{0:0}, at: blk_mq_run_hw_queue+0x54d/0xae0 block/blk-mq.c:2245
 #2: ffff888026528180 (&cmd->lock){+.+.}-{3:3}, at: nbd_queue_rq+0xfc/0x2f70 drivers/block/nbd.c:1115
2 locks held by syz-executor117/13121:
 #0: ffffffff8fcee2b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fcee168 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fcee168 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fcee168 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
3 locks held by syz-executor117/13119:
 #0: ffffffff8fcee2b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fcee168 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fcee168 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fcee168 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
 #2: ffff888027479998 (&nbd->config_lock){+.+.}-{3:3}, at: nbd_genl_connect+0xc26/0x1c80 drivers/block/nbd.c:2025
2 locks held by syz-executor117/13122:
 #0: ffffffff8fcee2b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fcee168 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fcee168 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fcee168 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
2 locks held by syz-executor117/13120:
 #0: ffffffff8fcee2b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fcee168 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fcee168 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fcee168 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
2 locks held by syz-executor117/13123:
 #0: ffffffff8fcee2b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fcee168 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fcee168 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fcee168 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-syzkaller-01458-g9410645520e9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 4668 Comm: syslogd Not tainted 6.11.0-syzkaller-01458-g9410645520e9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:lookup_chain_cache_add kernel/locking/lockdep.c:3781 [inline]
RIP: 0010:validate_chain+0x1cb/0x5900 kernel/locking/lockdep.c:3836
Code: 8d 1c c5 c0 e7 d9 93 48 89 d8 48 c1 e8 03 48 89 44 24 68 42 80 3c 20 00 74 08 48 89 df e8 bd 56 8a 00 48 89 5c 24 48 48 8b 1b <48> 85 db 74 48 48 83 c3 f8 74 42 4c 8d 7b 18 4c 89 f8 48 c1 e8 03
RSP: 0018:ffffc9000307f500 EFLAGS: 00000046
RAX: 1ffffffff27e4352 RBX: ffffffff94237e88 RCX: ffffffff8170803e
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff941de848
RBP: ffffc9000307f800 R08: ffffffff941de84f R09: 1ffffffff283bd09
R10: dffffc0000000000 R11: fffffbfff283bd0a R12: dffffc0000000000
R13: ffff88807a406550 R14: 0df99ad215ac43a2 R15: ffff88807a406550
FS:  00007fd2e7376380(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff85a147d30 CR3: 000000007a73a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 seqcount_lockdep_reader_access+0x13f/0x220 include/linux/seqlock.h:73
 ktime_get_coarse_real_ts64+0x3a/0x120 kernel/time/timekeeping.c:2390
 current_time+0x8f/0x2b0 fs/inode.c:2610
 inode_needs_update_time fs/inode.c:2178 [inline]
 file_update_time+0x5a/0x430 fs/inode.c:2232
 shmem_file_write_iter+0xd3/0x120 mm/shmem.c:3071
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd2e74cabf2
Code: 89 c7 48 89 44 24 08 e8 7b 34 fa ff 48 8b 44 24 08 48 83 c4 28 c3 c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 6f 48 8b 15 07 a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffc5cfee9c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd2e74cabf2
RDX: 000000000000005f RSI: 000055a451d5ec50 RDI: 0000000000000003
RBP: 000055a451d5ec50 R08: 0000000000000001 R09: 0000000000000000
R10: 00007fd2e76693a3 R11: 0000000000000246 R12: 000000000000005f
R13: 00007fd2e7376300 R14: 0000000000000004 R15: 000055a451d5ea60
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.402 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
