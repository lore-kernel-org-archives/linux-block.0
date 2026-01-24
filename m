Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEA2E55C
	for <linux-block@vger.kernel.org>; Sat, 24 Jan 2026 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769260234; cv=none; b=VtrgcAgzO9KH1dGCDl5tnBTREEMB0P54U4Z5ntzLFtQ7aRvQMLkyk5sCBeWSfF2Xg7suEAKRKBK+Dk+c5RKki6jsl9zPBETvFqnBMfjYMQUlSz112CcW0Ga2IC4yQC8l/zZb7/WCzidvy49+8UBCeR4/TQP+SuNjrud24GiKfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769260234; c=relaxed/simple;
	bh=7RTkZ474UUJD+ra2YETzVu0cNSTzU1/InW4Sh1qhHmA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PLba3ihBvKulFfBPVtg1oVIMdFA4/VYdlyj0luTTdcCAkf9elGJgzlHZesNhYfP79iBpC0zLfEDBkrTLrwRU59mrLd0d7aGdljVsBwTVUHfFuVlfBYbMcanVfOm3kFToleu9w4zzOe281TUFlRLUqHSuJAfU2e3weVehPo8IhA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-662c9283415so7402982eaf.1
        for <linux-block@vger.kernel.org>; Sat, 24 Jan 2026 05:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769260231; x=1769865031;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XNSu4w3Lz6YTuBjgjK93YawmOK5beBEdSh0ZnfnLRS0=;
        b=QmhvrinR2tMEeX7OjJSebORCxEmaSBp2+HT7ttN5Vwk9zh9qoMiksFsLxnp1vOcDQZ
         dM3Y3suDsRQCj88Faai0OJNG0memldZsIhr+8kQOf83iD+Kxq22ND3sglDHhtFt3cBt0
         l2PgMeyI/OQDSRK6Lv9q/ZCcaN0NDsKkZoEDooDHQ6qZvX0DDaX6E3QH6LMBD9kizOLx
         6lM8H2/T5Yfp9EyK1VSWuUT0nz9v12uGodIC8GBXfcY70KYVqwT4CWYszfbfGmyTAyxO
         cejvBD5RNZL1nOUfMLUY9P0LnqbsIWHKPE/Zl0Jl+LPEsxA6qy5D2X1ZK1nxz4l3c3cx
         6RQA==
X-Forwarded-Encrypted: i=1; AJvYcCXnSTyAIOfRnFoqPyEmMlFVGU0XN2/gm30LN9KTRw/Hdu9NTXdMhPp1kkXPbh9s4PUn/Jnlza5HCkJx+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6FxBIv7J0NF9gN7ryrCbHXfek5DgCVZjcRuIsCzMIKbsDBfpy
	ZZ6xdjCgw0B3fmv37Lx9jgJFzFgLKFe1F/I5WC6X0tR9qa7GAxUDvs6m/Kiw0IcQB5oeu0TY2+5
	CPdwvkySDR3x+lsVwgcRBr5yExYwXrn7HLmbgxoWm937kIB6QAdzYuwMcdC4=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:22a6:b0:65d:22b:415a with SMTP id
 006d021491bc7-662cab7e8e8mr3128180eaf.66.1769260231458; Sat, 24 Jan 2026
 05:10:31 -0800 (PST)
Date: Sat, 24 Jan 2026 05:10:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6974c4c7.a00a0220.33ccc7.000a.GAE@google.com>
Subject: [syzbot] [block?] INFO: task hung in read_cache_folio (5)
From: syzbot <syzbot+90f65e574fb85432db68@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    24d479d26b25 Linux 6.19-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1248cd22580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ec857cfb59de463
dashboard link: https://syzkaller.appspot.com/bug?extid=90f65e574fb85432db68
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-24d479d2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f4a697aeae5b/vmlinux-24d479d2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df285e089d77/zImage-24d479d2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+90f65e574fb85432db68@syzkaller.appspotmail.com

INFO: task udevd:6058 blocked for more than 430 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:0     pid:6058  tgid:6058  ppid:3136   task_flags:0x400140 flags:0x00000019
Call trace:
 __switch_to+0x208/0x4f0 arch/arm64/kernel/process.c:742 (T)
 context_switch kernel/sched/core.c:5260 [inline]
 __schedule+0xcfc/0x2fec kernel/sched/core.c:6867
 __schedule_loop kernel/sched/core.c:6949 [inline]
 schedule+0xd0/0x344 kernel/sched/core.c:6964
 io_schedule+0xac/0x114 kernel/sched/core.c:7791
 folio_wait_bit_common+0x2a4/0x630 mm/filemap.c:1323
 folio_put_wait_locked mm/filemap.c:1487 [inline]
 do_read_cache_folio+0x240/0x3f4 mm/filemap.c:4078
 read_cache_folio+0x44/0x6c mm/filemap.c:4128
 read_mapping_folio include/linux/pagemap.h:1017 [inline]
 read_part_sector+0xac/0x5f4 block/partitions/core.c:722
 msdos_partition+0xe4/0x1f3c block/partitions/msdos.c:592
 check_partition block/partitions/core.c:141 [inline]
 blk_add_partitions block/partitions/core.c:589 [inline]
 bdev_disk_changed+0x504/0xf08 block/partitions/core.c:693
 blkdev_get_whole+0x144/0x1e4 block/bdev.c:765
 bdev_open+0x1dc/0xa84 block/bdev.c:974
 blkdev_open+0x270/0x3dc block/fops.c:698
 do_dentry_open+0x3f4/0x10e4 fs/open.c:962
 vfs_open+0x5c/0x2fc fs/open.c:1094
 do_open fs/namei.c:4637 [inline]
 path_openat+0x17f0/0x28cc fs/namei.c:4796
 do_filp_open+0x184/0x360 fs/namei.c:4823
 do_sys_openat2+0xe0/0x188 fs/open.c:1430
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_openat fs/open.c:1452 [inline]
 __se_sys_openat fs/open.c:1447 [inline]
 __arm64_sys_openat+0x12c/0x1bc fs/open.c:1447
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x2b0 arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Showing all locks held in the system:
1 lock held by khungtaskd/32:
 #0: ffff800087552ae0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x18/0x1c4 kernel/locking/lockdep.c:6769
4 locks held by kworker/1:2/912:
 #0: ffff00000dc29948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x6f8/0x18d4 kernel/workqueue.c:3232
 #1: ffff80008ec17c90 ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at: psi_task_switch+0x60/0x804 kernel/sched/psi.c:933
 #2: ffff00000fb4e160 (&helper->damage_lock){....}-{3:3}, at: drm_fb_helper_fb_dirty drivers/gpu/drm/drm_fb_helper.c:340 [inline]
 #2: ffff00000fb4e160 (&helper->damage_lock){....}-{3:3}, at: drm_fb_helper_damage_work+0x188/0x5d8 drivers/gpu/drm/drm_fb_helper.c:372
 #3: ffff00001489a128 (&dev->master_mutex){+.+.}-{4:4}, at: drm_master_internal_acquire+0x24/0x6c drivers/gpu/drm/drm_auth.c:435
1 lock held by syslogd/3121:
2 locks held by getty/3259:
 #0: ffff00001373d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff80008d8eb2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x3e8/0xdd0 drivers/tty/n_tty.c:2211
1 lock held by syz-executor/3321:
2 locks held by kworker/u8:10/4327:
 #0: ffff00000dc31148 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: process_one_work+0x6f8/0x18d4 kernel/workqueue.c:3232
 #1: ffff80008f437c90 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x71c/0x18d4 kernel/workqueue.c:3232
2 locks held by kworker/u8:11/4332:
 #0: ffff00000dc31148 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: process_one_work+0x6f8/0x18d4 kernel/workqueue.c:3232
 #1: ffff80008f417c90 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x71c/0x18d4 kernel/workqueue.c:3232
1 lock held by udevd/6058:
 #0: ffff000015305358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0x2c4/0xa84 block/bdev.c:962
2 locks held by kworker/u8:1/6356:
 #0: ffff00000dc31148 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: process_one_work+0x6f8/0x18d4 kernel/workqueue.c:3232
 #1: ffff8000a1f27c90 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x71c/0x18d4 kernel/workqueue.c:3232
1 lock held by syz.0.1250/7258:
 #0: ffff000015305358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0x84/0xa84 block/bdev.c:962
3 locks held by modprobe/7800:
2 locks held by modprobe/7802:
2 locks held by kworker/u8:11/7804:

=============================================

INFO: task udevd:6058 blocked for more than 451 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:0     pid:6058  tgid:6058  ppid:3136   task_flags:0x400140 flags:0x00000019
Call trace:
 __switch_to+0x208/0x4f0 arch/arm64/kernel/process.c:742 (T)
 context_switch kernel/sched/core.c:5260 [inline]
 __schedule+0xcfc/0x2fec kernel/sched/core.c:6867
 __schedule_loop kernel/sched/core.c:6949 [inline]
 schedule+0xd0/0x344 kernel/sched/core.c:6964
 io_schedule+0xac/0x114 kernel/sched/core.c:7791
 folio_wait_bit_common+0x2a4/0x630 mm/filemap.c:1323
 folio_put_wait_locked mm/filemap.c:1487 [inline]
 do_read_cache_folio+0x240/0x3f4 mm/filemap.c:4078
 read_cache_folio+0x44/0x6c mm/filemap.c:4128
 read_mapping_folio include/linux/pagemap.h:1017 [inline]
 read_part_sector+0xac/0x5f4 block/partitions/core.c:722
 msdos_partition+0xe4/0x1f3c block/partitions/msdos.c:592
 check_partition block/partitions/core.c:141 [inline]
 blk_add_partitions block/partitions/core.c:589 [inline]
 bdev_disk_changed+0x504/0xf08 block/partitions/core.c:693
 blkdev_get_whole+0x144/0x1e4 block/bdev.c:765
 bdev_open+0x1dc/0xa84 block/bdev.c:974
 blkdev_open+0x270/0x3dc block/fops.c:698
 do_dentry_open+0x3f4/0x10e4 fs/open.c:962
 vfs_open+0x5c/0x2fc fs/open.c:1094
 do_open fs/namei.c:4637 [inline]
 path_openat+0x17f0/0x28cc fs/namei.c:4796
 do_filp_open+0x184/0x360 fs/namei.c:4823
 do_sys_openat2+0xe0/0x188 fs/open.c:1430
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_openat fs/open.c:1452 [inline]
 __se_sys_openat fs/open.c:1447 [inline]
 __arm64_sys_openat+0x12c/0x1bc fs/open.c:1447
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x2b0 arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Showing all locks held in the system:
1 lock held by rcu_preempt/15:
1 lock held by khungtaskd/32:
 #0: ffff800087552ae0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x18/0x1c4 kernel/locking/lockdep.c:6769
1 lock held by syslogd/3121:
2 locks held by dhcpcd/3165:
 #0: ffff800088b7e8a8 (vlan_ioctl_mutex){+.+.}-{4:4}, at: sock_ioctl+0x418/0x5d4 net/socket.c:1337
 #1: ffff800088ba83c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x1c/0x28 net/core/rtnetlink.c:80
2 locks held by getty/3259:
 #0: ffff00001373d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff80008d8eb2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x3e8/0xdd0 drivers/tty/n_tty.c:2211
5 locks held by kworker/u8:11/4332:
 #0: ffff00000e16b948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x6f8/0x18d4 kernel/workqueue.c:3232
 #1: ffff80008f417c90 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x71c/0x18d4 kernel/workqueue.c:3232
 #2: ffff800088b93230 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xdc/0x75c net/core/net_namespace.c:670
 #3: ffff800088ba83c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x1c/0x28 net/core/rtnetlink.c:80
 #4: ffff80008755b5f8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock+0x250/0x364 kernel/rcu/tree_exp.h:311
3 locks held by kworker/u8:0/5452:
1 lock held by udevd/6058:
 #0: ffff000015305358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0x2c4/0xa84 block/bdev.c:962
1 lock held by syz.0.1250/7258:
 #0: ffff000015305358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0x84/0xa84 block/bdev.c:962
3 locks held by kworker/u8:6/7811:
 #0: ffff00000dc31948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x6f8/0x18d4 kernel/workqueue.c:3232
 #1: ffff80008e307c90 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x71c/0x18d4 kernel/workqueue.c:3232
 #2: ffff800088ba83c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x1c/0x28 net/core/rtnetlink.c:80

=============================================



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
