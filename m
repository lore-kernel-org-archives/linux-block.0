Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D0720B7ED
	for <linux-block@vger.kernel.org>; Sun, 29 Jun 2025 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751197711; cv=none; b=Kwm8PeOvQQLfZw7tB6bKUm62qzWQK4HKdktoNkoN1iMYsBGbvCKWC0ktEIsEUHCIy6TL7bPA3gTibzwWT+gXsaO3R/McgbST/bcLY5VFCee9tVOOjNnB9fp+xT44Y5RP7WFTJrawU2g5iHId100XVdmhEfYugzG59cKjmAu/QLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751197711; c=relaxed/simple;
	bh=hidbxiemyE4/YYCan01WJfZrmTRIJCHn92CAB55Qo6k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mYFZwOBw96GaOH+yWnicB/hzfJ7JVyJquR/EFb2yj8YWISO5BbftMvwpd81Ul38q/kDPtQFb1mRNhIT5Euek9mruJsVvDGKAfjm6PKcklqBxeoTdRqQTQYdOeVsdjQqAKOXKc5bTmRcngag6G3toH+xGgCdxvWjUYomuDWeaZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3de3b5b7703so8149095ab.1
        for <linux-block@vger.kernel.org>; Sun, 29 Jun 2025 04:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751197708; x=1751802508;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MhqOESyoIGnMqZDIV0pmxrjuOcf8HCVLuDtXxhGHmn0=;
        b=g/Z9J3zpA59FQhvaoI87AyV9tm3bh0c1ss5bvwekpjVB4sgGCWtPW00hj/jKFOp9lx
         yw22hO7PycEI4j7HvvGh76dNRDQQ/E4kKvfqegexaVBsLfkr31uTwoNIo3740gb88Qpw
         wZC+3G/1CjfGceIYtsqx+tunjMQg2JpUPXN9nTJo+CDCZXpeSnibYA4CmJKSReDBa7JJ
         MLDU8LfRsTCD0xBey2aXEE6dF9S8tR6y6rG33ZHW4lBxLUK2oUxETZT0rXpx1PsPRfkr
         Nwcjf4/FoAwSjkkFPxECRcoQEo4GQWPslBppg5Ic/oDIDDDLY0peULke+ETDAnDtAPpS
         4f+A==
X-Forwarded-Encrypted: i=1; AJvYcCUj4/JMd0YkDduiBepVNncKN8qqLmphjR5iGQAO0pPq1CvlNazHvU8WPoKB7Rnm9p9RzT8ScjdKBedqLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTgEL9zcXkF/rPqxT4RUuw3R9APnkHCrOgXv4n1PTfDf4crh/g
	7zuoz3HMKEz/d9CAK6Nu1jzRn9FEFaq/HwOo040Q86wqk/f+nUYCwFUXuZpMCDuPp7l4IlDmbrW
	nkpqGC6oopfd+AyOFm0pMQsluKvMFdfqqYq+iGP20+vEaA53lYA2VOdp/Uoo=
X-Google-Smtp-Source: AGHT+IG5LOe8u8nBizKwKQEFDHMigpGvDy9YKACKcVx2O8z+yJvoZpKKt0x06/0I6nmWVehVwq0e1jJxZ7/NNKs8c2MyMIq+TFsB
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e8:b0:3df:154d:aa60 with SMTP id
 e9e14a558f8ab-3df4acf7b61mr106065955ab.22.1751197708161; Sun, 29 Jun 2025
 04:48:28 -0700 (PDT)
Date: Sun, 29 Jun 2025 04:48:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6861280c.a70a0220.2f4de1.001c.GAE@google.com>
Subject: [syzbot] [block?] INFO: task hung in bioset_init
From: syzbot <syzbot+a6810ad79a40f9e34f41@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    48f506ad0b68 Merge tag 'soc-fixes-6.13-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14007cf8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2b862bf4a5409f
dashboard link: https://syzkaller.appspot.com/bug?extid=a6810ad79a40f9e34f41
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/90ab4304aa3d/disk-48f506ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/17993e8b36f8/vmlinux-48f506ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/397ee02a9ad0/bzImage-48f506ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6810ad79a40f9e34f41@syzkaller.appspotmail.com

INFO: task syz.6.545:8334 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc3-syzkaller-00289-g48f506ad0b68 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.6.545       state:D stack:23392 pid:8334  tgid:8333  ppid:7343   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 __mutex_lock_common kernel/locking/mutex.c:665 [inline]
 __mutex_lock+0x7e7/0xee0 kernel/locking/mutex.c:735
 bio_find_or_create_slab block/bio.c:122 [inline]
 bioset_init+0x23f/0x820 block/bio.c:1796
 bch2_fs_alloc fs/bcachefs/super.c:895 [inline]
 bch2_fs_open+0x1e90/0x2f80 fs/bcachefs/super.c:2065
 bch2_fs_get_tree+0x738/0x1710 fs/bcachefs/fs.c:2157
 vfs_get_tree+0x92/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f01777874ca
RSP: 002b:00007f01755f5e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f01755f5ef0 RCX: 00007f01777874ca
RDX: 00000000200058c0 RSI: 0000000020005900 RDI: 00007f01755f5eb0
RBP: 00000000200058c0 R08: 00007f01755f5ef0 R09: 0000000000010000
R10: 0000000000010000 R11: 0000000000000246 R12: 0000000020005900
R13: 00007f01755f5eb0 R14: 00000000000058d9 R15: 0000000020000080
 </TASK>

Showing all locks held in the system:
7 locks held by kworker/0:1/9:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6744
3 locks held by kworker/R-kbloc/43:
4 locks held by kworker/u9:0/54:
 #0: ffff88805b03c148 ((wq_completion)hci5){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88805b03c148 ((wq_completion)hci5){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc90000be7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000be7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff888050c04d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:331
 #3: ffff888050c04078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1e4/0x11f0 net/bluetooth/hci_sync.c:5584
2 locks held by kworker/u8:4/79:
2 locks held by kworker/u8:8/2924:
 #0: ffff88801ac81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc9000c027d00 ((reaper_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000c027d00 ((reaper_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
4 locks held by kworker/u9:1/5139:
 #0: ffff88806b1ef948 ((wq_completion)hci4){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88806b1ef948 ((wq_completion)hci4){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc90010207d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90010207d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff88805b99cd80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:331
 #3: ffff88805b99c078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1e4/0x11f0 net/bluetooth/hci_sync.c:5584
1 lock held by klogd/5189:
2 locks held by dhcpcd/5493:
 #0: ffffffff8fc98288 (vlan_ioctl_mutex){+.+.}-{4:4}, at: sock_ioctl+0x661/0x8e0 net/socket.c:1290
 #1: ffffffff8fcb2bc8 (rtnl_mutex){+.+.}-{4:4}, at: vlan_ioctl_handler+0x112/0x9d0 net/8021q/vlan.c:553
2 locks held by getty/5579:
 #0: ffff8880315310a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
2 locks held by kworker/u9:2/5826:
 #0: ffff888025b35948 ((wq_completion)nbd0-recv){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888025b35948 ((wq_completion)nbd0-recv){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc90003427d00 ((work_completion)(&args->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003427d00 ((work_completion)(&args->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
1 lock held by syz-executor/5828:
 #0: ffffffff8fcb2bc8 (rtnl_mutex){+.+.}-{4:4}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fcb2bc8 (rtnl_mutex){+.+.}-{4:4}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
4 locks held by kworker/u9:4/5833:
 #0: ffff88802ef42948 ((wq_completion)hci6){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88802ef42948 ((wq_completion)hci6){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc90003377d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003377d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff8880213c8d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:331
 #3: ffff8880213c8078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1e4/0x11f0 net/bluetooth/hci_sync.c:5584
4 locks held by kworker/u9:5/5837:
 #0: ffff888011a04148 ((wq_completion)hci0){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888011a04148 ((wq_completion)hci0){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc900044afd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900044afd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff88805b998d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:331
 #3: ffff88805b998078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1e4/0x11f0 net/bluetooth/hci_sync.c:5584
3 locks held by kworker/1:4/5882:
 #0: ffff88801ac79948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac79948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc90003537d00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003537d00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffffffff8fcb2bc8 (rtnl_mutex){+.+.}-{4:4}, at: reg_check_chans_work+0x99/0xfb0 net/wireless/reg.c:2480
3 locks held by kworker/0:6/5887:
 #0: ffff88801ac78948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac78948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc90002e27d00 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90002e27d00 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff888028e2a190 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888028e2a190 (&dev->mutex){....}-{4:4}, at: ath9k_hif_usb_firmware_fail drivers/net/wireless/ath/ath9k/hif_usb.c:1161 [inline]
 #2: ffff888028e2a190 (&dev->mutex){....}-{4:4}, at: ath9k_hif_usb_firmware_cb+0x34a/0x4b0 drivers/net/wireless/ath/ath9k/hif_usb.c:1294
3 locks held by kworker/u8:10/6484:
3 locks held by kworker/u8:11/6795:
 #0: ffff88801ac81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc9001d8afd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9001d8afd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffffffff8fcb2bc8 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:281
3 locks held by kworker/u8:12/7040:
 #0: ffff88814d158148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88814d158148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc9001d88fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9001d88fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffffffff8fcb2bc8 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4215
2 locks held by syz-executor/7363:
 #0: ffffffff8f053ce8 (bio_slab_lock){+.+.}-{4:4}, at: bio_put_slab block/bio.c:140 [inline]
 #0: ffffffff8f053ce8 (bio_slab_lock){+.+.}-{4:4}, at: bioset_exit+0x42f/0x650 block/bio.c:1755
 #1: ffffffff8e93cec0 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barrier+0x4c/0x530 kernel/rcu/tree.c:4565
1 lock held by syz.6.545/8334:
 #0: ffffffff8f053ce8 (bio_slab_lock){+.+.}-{4:4}, at: bio_find_or_create_slab block/bio.c:122 [inline]
 #0: ffffffff8f053ce8 (bio_slab_lock){+.+.}-{4:4}, at: bioset_init+0x23f/0x820 block/bio.c:1796
3 locks held by syz-executor/8366:
 #0: ffffffff8fd15610 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fd154c8 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fd154c8 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fd154c8 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
 #2: ffffffff8fcb2bc8 (rtnl_mutex){+.+.}-{4:4}, at: wiphy_register+0x1a3f/0x27b0 net/wireless/core.c:1009
8 locks held by syz-executor/8460:
 #0: ffff8880312b2420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2964 [inline]
 #0: ffff8880312b2420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x225/0xd30 fs/read_write.c:675
 #1: ffff88807f17ac88 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff88814372b0f8 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f55e868 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 #4: ffff88807e8da0e8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88807e8da0e8 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88807e8da0e8 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
 #5: ffff88807e8db250 (&devlink->lock_key#4){+.+.}-{4:4}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1675
 #6: ffffffff8fcb2bc8 (rtnl_mutex){+.+.}-{4:4}, at: nsim_destroy+0x71/0x5c0 drivers/net/netdevsim/netdev.c:816
 #7: ffffffff8e93cff8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 #7: ffffffff8e93cff8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
2 locks held by syz.2.588/8559:
 #0: ffff888041bac0e0 (&type->s_umount_key#57){+.+.}-{4:4}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff888041bac0e0 (&type->s_umount_key#57){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff888041bac0e0 (&type->s_umount_key#57){+.+.}-{4:4}, at: deactivate_super+0xb5/0xf0 fs/super.c:505
 #1: ffffffff8e93cec0 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barrier+0x4c/0x530 kernel/rcu/tree.c:4565
2 locks held by kworker/u8:13/8564:
 #0: ffff88801ac81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc9000bc4fd00 (connector_reaper_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000bc4fd00 (connector_reaper_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
4 locks held by kworker/u9:3/8607:
 #0: ffff888034878948 ((wq_completion)hci7){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888034878948 ((wq_completion)hci7){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc9000c457d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000c457d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff888024fe4d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:331
 #3: ffff888024fe4078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1e4/0x11f0 net/bluetooth/hci_sync.c:5584

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-rc3-syzkaller-00289-g48f506ad0b68 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:234 [inline]
 watchdog+0xff6/0x1040 kernel/hung_task.c:397
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.13.0-rc3-syzkaller-00289-g48f506ad0b68 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:get_current arch/x86/include/asm/current.h:49 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:245 [inline]
RIP: 0010:__sanitizer_cov_trace_cmp8+0x8/0x90 kernel/kcov.c:294
Code: 44 0a 20 e9 95 ca 50 0a 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 4c 8b 04 24 <65> 48 8b 0c 25 00 d6 03 00 65 8b 05 60 5f 64 7e 25 00 01 ff 00 74
RSP: 0018:ffffc900000e71d8 EFLAGS: 00000207
RAX: 0000778000000000 RBX: ffff8881f0700200 RCX: ffff88801ceb8000
RDX: ffffc9001c7af000 RSI: ffff8881f0700200 RDI: 0000000170700200
RBP: 0000000000000000 R08: ffffffff814d3fdb R09: ffffffff8205ecef
R10: dffffc0000000000 R11: fffffbfff2854917 R12: ffff888170700200
R13: ffffea0000000000 R14: 0000000170700200 R15: ffff88801ac41a00
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3e3dd47ab8 CR3: 00000000352f4000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __phys_addr+0x4b/0x170 arch/x86/mm/physaddr.c:28
 virt_to_folio include/linux/mm.h:1295 [inline]
 virt_to_slab mm/slab.h:211 [inline]
 ___cache_free+0x1a/0xe0 mm/slub.c:4671
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_noprof+0x236/0x4c0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 rh_call_control drivers/usb/core/hcd.c:491 [inline]
 rh_urb_enqueue drivers/usb/core/hcd.c:821 [inline]
 usb_hcd_submit_urb+0x8fc/0x1e80 drivers/usb/core/hcd.c:1529
 usb_start_wait_urb+0x113/0x520 drivers/usb/core/message.c:59
 usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
 usb_control_msg+0x2b1/0x4c0 drivers/usb/core/message.c:154
 get_port_status drivers/usb/core/hub.c:604 [inline]
 hub_ext_port_status+0x11a/0x840 drivers/usb/core/hub.c:621
 usb_hub_port_status drivers/usb/core/hub.c:671 [inline]
 hub_port_debounce+0x336/0x590 drivers/usb/core/hub.c:4656
 hub_port_debounce_be_stable drivers/usb/core/hub.h:183 [inline]
 hub_port_connect drivers/usb/core/hub.c:5373 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1f4f/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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
