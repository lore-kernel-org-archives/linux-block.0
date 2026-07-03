Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72333F5A2
	for <linux-block@vger.kernel.org>; Fri,  3 Jul 2026 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063525; cv=none; b=qfQH+BM+fKORDr+0bSf/aUHrtAgBOuajPHhbIlOvC3aDvth6X6qoLUS1SRY+VDovR/vkKCwFZTxPs2wN8MgmLxvxapgBI8MAhmY/1E74VTf9mQCA8+pS5weibapAWh/TgL2h/CcUC90HNGsWaXmYlsF1u++fv0hrMpY2ljzINMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063525; c=relaxed/simple;
	bh=89jb9MuNqp964KmxR8Az30Ogx0pZ/TvfU9mqkjYEoAo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bLV6t0NzJJZBXbw8p6huVZJAItIdSV4q/wlN7oOA++e+qVTa6DSmS58uMorZANtr1Vx/ifXDuI5Bk3jp/upnMGzzzb0VAnB0qbZ0NIZC5o+nk4RC2HWYSYMHJh/j1iIMJ4gf/NwFXsum9dmtnBvMPqeLmuNfCkElUTew6JdBBfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6a0f261aeb6so339126eaf.3
        for <linux-block@vger.kernel.org>; Fri, 03 Jul 2026 00:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783063523; x=1783668323;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/wSGveN9fon02211xt9AMAk5CBJ+XndPtNgls5TAzQ=;
        b=aDONdeuMa2FgD2dkumKoXmuXb3BvndKfQIsEKVg1zfondW0JUJVw4VIyKZnb36ZzH+
         e6AQwfr8XuzFPdp1F+LBrd8KpuTxhImK78J9XERvHE501RH5mIDLUN1ncltlZveOiLIj
         u1xq9hftLxiYAFtt24aZMRPJ1upkGFo6DT9DWPGnmJnWrCiuRhNz6viUrT6Lfdhokzt7
         RKrCGw9r96cVuGBaMSaMZTohI2be1SZ6rPtk7srQBkelKkTTddW0/3V/+33YzeqbbouQ
         Tn0IiZkkhhMuPs6qANBDFdmP8hbrH3Ijl9Vz1IZFeDWQbSK3hAPSbUtKVvD7BioGh/l2
         tCAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8H+PiwdwpCKvyqplTzxMJGK+rwlY5wFNuQ60vuBxlJOwYT//0/bFDfXWDaztYPROCTEj0fbqqOnEMqPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc3OPZrFrdGB95jHCyXhFm/AOJ+glj0q9EyH/vU1soNPi9ZYO+
	d/aXfxbl+q3m9nCOsCNhWVu7AbQQgV/rh8Zw5YjiroMVVl+gwIPkEZNMfLvPjfE/XDBQHCgkbsC
	QmAmvh/uWT16Vz9OZw/QX0FPDdxkZ9phFn5EODtVmtrqbmqZs1R5Aw8XUQZg=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3085:b0:6a1:1d7e:438a with SMTP id
 006d021491bc7-6a30d8a7fdcmr5136384eaf.45.1783063523554; Fri, 03 Jul 2026
 00:25:23 -0700 (PDT)
Date: Fri, 03 Jul 2026 00:25:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a4763e3.9dc7bc9d.3d5df4.0007.GAE@google.com>
Subject: [syzbot] [block?] INFO: task hung in read_cache_folio (6)
From: syzbot <syzbot+9db0864859224b833108@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    92e3f6ef4ffb Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=142300d6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4a42e870a0b0ae0
dashboard link: https://syzkaller.appspot.com/bug?extid=9db0864859224b833108
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/75ce25b4a6ef/disk-92e3f6ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14bda28d7d38/vmlinux-92e3f6ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/247283a18992/Image-92e3f6ef.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9db0864859224b833108@syzkaller.appspotmail.com

INFO: task udevd:6979 blocked
INFO: task udevd:6979 blocked in I/O wait for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:0     pid:6979  tgid:6979  ppid:4339   task_flags:0x400140 flags:0x00800011
Call trace:
 __switch_to+0x2b0/0x6e0 arch/arm64/kernel/process.c:810 (T)
 context_switch kernel/sched/core.c:5388 [inline]
 __schedule+0x1c04/0x2db8 kernel/sched/core.c:7189
 __schedule_loop kernel/sched/core.c:7268 [inline]
 schedule+0x13c/0x20c kernel/sched/core.c:7283
 io_schedule+0x1c/0xe0 kernel/sched/core.c:8110
 folio_wait_bit_common+0x6b8/0xa30 mm/filemap.c:1324
 folio_put_wait_locked mm/filemap.c:1493 [inline]
 do_read_cache_folio+0x23c/0x5a8 mm/filemap.c:4089
 read_cache_folio+0x68/0x88 mm/filemap.c:4139
 read_mapping_folio include/linux/pagemap.h:1017 [inline]
 read_part_sector+0xcc/0x708 block/partitions/core.c:724
 adfspart_check_POWERTEC+0x94/0x5b8 block/partitions/acorn.c:450
 check_partition block/partitions/core.c:143 [inline]
 blk_add_partitions block/partitions/core.c:591 [inline]
 bdev_disk_changed+0x6c4/0x11ec block/partitions/core.c:695
 blkdev_get_whole+0x15c/0x240 block/bdev.c:756
 bdev_open+0x2b4/0x880 block/bdev.c:965
 blkdev_open+0x2d4/0x408 block/fops.c:697
 do_dentry_open+0x5c4/0xfb8 fs/open.c:947
 vfs_open+0x44/0x2dc fs/open.c:1079
 do_open fs/namei.c:4699 [inline]
 path_openat+0x22d4/0x2b88 fs/namei.c:4858
 do_file_open+0x1c8/0x2e8 fs/namei.c:4887
 do_sys_openat2+0x114/0x1e8 fs/open.c:1364
 do_sys_open+0xac/0xdc fs/open.c:1370
 __do_sys_openat fs/open.c:1386 [inline]
 __se_sys_openat fs/open.c:1381 [inline]
 __arm64_sys_openat+0xa0/0xbc fs/open.c:1381
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffff800088bf70c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffff800088bf70c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffff800088bf70c0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x4c/0x188 kernel/locking/lockdep.c:6775
2 locks held by pr/ttyAMA-1/41:
2 locks held by getty/4488:
 #0: ffff0000d43c90a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff8000923ab2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x348/0xf70 drivers/tty/n_tty.c:2211
1 lock held by udevd/6979:
 #0: ffff0000c7f2a350 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xc4/0x880 block/bdev.c:953

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
