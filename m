Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628373264D5
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030061; cv=none; b=XgIy4Bm39x9lp1gowi4ABvnqvRrIRagOt/GRFSSAhCR4btYvmu92qMt37k2Sbr2Egl43Hax9nDQgYFu3jAj3Q7syjOY1W7YeaaEpKWt2aRVkD6eU55WIgU6i6uWLpTOY9B8dwRK6TFzXijrdDROuNN3RPizmxgxtXMwAKZUS7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030061; c=relaxed/simple;
	bh=romX8sXtSg/y5w8p2pDazqI6DI3NTpeye7auvzhGTi0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iS4SfwUAGeeqkThF/OM6S27fKs7PFA7ZUzXmLJuARr83wdaFt2FBZO2VE494qLX4RYKNN2P0zR7pP/I0aChnFwlSv/W/lZ+WQ1NnFfmxy1+bjZhBDqZQOBzCV5uw+OZEqZdRlFmdwpDc6CHMpQSf/3oAxb/quZcBi4uIxbD5T7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4ab4f78b9f4so2855016b6e.2
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 08:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786030058; x=1786634858;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rsKm+eTVRVD9qo7RFU0vR3VzVQ4B7xDw1eBm4uSHpE4=;
        b=CZ5PpFjsDlBY2uciMpu/X9uYngRlocMUU6sNtByzl2/7wrLpM/eBnN40tUIKBxK5ls
         +HVQVm+XZ6gCNZLz49lb4+xqUKfe9HA98NGig4tj8FV7VWb1/ui8xkhMvjjLy4nWRYxO
         cQGVxXhZ7p4cA1DvXjcCIKr8/CuieqdqbWdxqo7xDAllpIGr/tW8SfqPU1TxMk22KVAP
         9smkzCG7HtvNW9CdLd6vAYLM7rMiHNsLe/4Ko6uWnmgGtmd0+bL4tphKefCAAMHwe+Zh
         Qkr/UH5nyXmYSWlDnIQjRDDu132KvRxopSJqZaPzugyMnTUNmwTwAUAShEVb4RsYsAsn
         X8Ow==
X-Forwarded-Encrypted: i=1; AHgh+RrAQ7VCpc3gBzoGzE90UV9YIaCMIf4xeSBIjOwuDfrUvYYn+WK3BmyxHpk13EGk7e4q5LgN5MkSRSqwaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh5HW1atiYCqNiEP5UvSxKfsAjQVWqmiyMjcMRC7QiLicrVzDq
	pfJuA0wKLVGniydCi8KO0es8WzlSOEN+icZPaY1mJ2kA9g1o2UTS55VWDiTAM8hdnezdqu6y4sy
	emUpNi45EhPKRu73wpwQXY4dbYX4XWka5EZf01wl0xTyZGgIChSCwAvyahDQ=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6aea:b0:6ae:ab01:91a8 with SMTP id
 006d021491bc7-6b0216730b6mr1272376eaf.34.1786030058131; Thu, 06 Aug 2026
 08:27:38 -0700 (PDT)
Date: Thu, 06 Aug 2026 08:27:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a74a7ea.01d0871a.3a0d52.0024.GAE@google.com>
Subject: [syzbot] [block?] WARNING in null_report_zones
From: syzbot <syzbot+67f80b67c0cfaa3bb3bb@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7235a3e71949 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15bfe3b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccf4bea59f67007
dashboard link: https://syzkaller.appspot.com/bug?extid=67f80b67c0cfaa3bb3bb
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd45635beaae/disk-7235a3e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d7d2e6507223/vmlinux-7235a3e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b5b5d8de4cea/Image-7235a3e7.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+67f80b67c0cfaa3bb3bb@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: kernel/locking/mutex.c:625 at __mutex_lock_common kernel/locking/mutex.c:625 [inline], CPU#1: syz.1.49/5028
WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0xd0c/0xf14 kernel/locking/mutex.c:821, CPU#1: syz.1.49/5028
Modules linked in:
CPU: 1 UID: 0 PID: 5028 Comm: syz.1.49 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/02/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __mutex_lock_common kernel/locking/mutex.c:625 [inline]
pc : __mutex_lock+0xd0c/0xf14 kernel/locking/mutex.c:821
lr : __mutex_lock_common kernel/locking/mutex.c:625 [inline]
lr : __mutex_lock+0xd0c/0xf14 kernel/locking/mutex.c:821
sp : ffff8000974c7240
x29: ffff8000974c7390 x28: ffff8000825cb81c x27: ffff8000974c72e0
x26: 0000000000000000 x25: ffff8000974c72e8 x24: 0000000000000000
x23: ffff700012e98e58 x22: ffff8000974c7300 x21: dfff800000000000
x20: ffff8000aac2c0a8 x19: ffff8000aac2c0a8 x18: 1fffe00035bc9e28
x17: 0000000000000003 x16: ffff800088b07000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000080000 x9 : 87bfb99deda4d800
x8 : 87bfb99deda4d800 x7 : 0000000000000000 x6 : ffff80008048e080
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000802f8070
x2 : 0000000100000000 x1 : ffff0000d3c78000 x0 : 0000000000000001
Call trace:
 __mutex_lock_common kernel/locking/mutex.c:625 [inline] (P)
 __mutex_lock+0xd0c/0xf14 kernel/locking/mutex.c:821 (P)
 mutex_lock_nested+0x24/0x30 kernel/locking/mutex.c:874
 null_lock_zone drivers/block/null_blk/zoned.c:39 [inline]
 null_report_zones+0x298/0x878 drivers/block/null_blk/zoned.c:219
 blk_revalidate_disk_zones+0x7a4/0xe64 block/blk-zoned.c:2384
 null_register_zoned_dev+0xe4/0x134 drivers/block/null_blk/zoned.c:184
 null_add_dev+0xeb0/0x1800 drivers/block/null_blk/main.c:2047
 nullb_device_power_store+0x160/0x398 drivers/block/null_blk/main.c:501
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x27c/0x354 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x51c/0xa0c fs/read_write.c:687
 ksys_write+0x12c/0x228 fs/read_write.c:739
 __do_sys_write fs/read_write.c:750 [inline]
 __se_sys_write fs/read_write.c:747 [inline]
 __arm64_sys_write+0x84/0x98 fs/read_write.c:747
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594
irq event stamp: 131463
hardirqs last  enabled at (131463): [<ffff8000803b8b90>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1673 [inline]
hardirqs last  enabled at (131463): [<ffff8000803b8b90>] finish_lock_switch kernel/sched/core.c:5241 [inline]
hardirqs last  enabled at (131463): [<ffff8000803b8b90>] finish_task_switch+0x234/0x858 kernel/sched/core.c:5359
hardirqs last disabled at (131462): [<ffff8000868f535c>] __schedule+0x2f8/0x2d80 kernel/sched/core.c:7087
softirqs last  enabled at (124352): [<ffff80008030ff44>] softirq_handle_end kernel/softirq.c:468 [inline]
softirqs last  enabled at (124352): [<ffff80008030ff44>] handle_softirqs+0xc28/0xd98 kernel/softirq.c:650
softirqs last disabled at (124285): [<ffff8000800204c0>] __do_softirq+0x14/0x20 kernel/softirq.c:656
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address fbd529d5a0000006
KASAN: maybe wild-memory-access in range [0xdead4ead00000030-0xdead4ead00000037]
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0
[fbd529d5a0000006] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 5028 Comm: syz.1.49 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/02/2026
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : owner_on_cpu include/linux/sched.h:2323 [inline]
pc : mutex_can_spin_on_owner+0x1b0/0x300 kernel/locking/mutex.c:442
lr : instrument_atomic_read include/linux/instrumented.h:82 [inline]
lr : atomic_long_read include/linux/atomic/atomic-instrumented.h:3188 [inline]
lr : __mutex_owner kernel/locking/mutex.h:48 [inline]
lr : mutex_can_spin_on_owner+0x188/0x300 kernel/locking/mutex.c:440
sp : ffff8000974c7200
x29: ffff8000974c7200 x28: ffff8000825cb81c x27: ffff8000974c72e0
x26: 0000000000000000 x25: ffff8000974c72e8 x24: 0000000000000000
x23: ffff700012e98e58 x22: ffff8000974c7300 x21: dfff800000000000
x20: dead4ead00000034 x19: dead4ead00000000 x18: 1fffe00035bc9e28
x17: 0000000000000003 x16: ffff800088b07000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff700015585816 x9 : dfff800000000000
x8 : 1bd5a9d5a0000006 x7 : 0000000000000000 x6 : ffff8000825cb81c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800080458ecc
x2 : 0000000000000000 x1 : 0000000000000008 x0 : 0000000000000001
Call trace:
 owner_on_cpu include/linux/sched.h:2323 [inline] (P)
 mutex_can_spin_on_owner+0x1b0/0x300 kernel/locking/mutex.c:442 (P)
 mutex_optimistic_spin kernel/locking/mutex.c:485 [inline]
 __mutex_lock_common kernel/locking/mutex.c:650 [inline]
 __mutex_lock+0x188/0xf14 kernel/locking/mutex.c:821
 mutex_lock_nested+0x24/0x30 kernel/locking/mutex.c:874
 null_lock_zone drivers/block/null_blk/zoned.c:39 [inline]
 null_report_zones+0x298/0x878 drivers/block/null_blk/zoned.c:219
 blk_revalidate_disk_zones+0x7a4/0xe64 block/blk-zoned.c:2384
 null_register_zoned_dev+0xe4/0x134 drivers/block/null_blk/zoned.c:184
 null_add_dev+0xeb0/0x1800 drivers/block/null_blk/main.c:2047
 nullb_device_power_store+0x160/0x398 drivers/block/null_blk/main.c:501
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x27c/0x354 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x51c/0xa0c fs/read_write.c:687
 ksys_write+0x12c/0x228 fs/read_write.c:739
 __do_sys_write fs/read_write.c:750 [inline]
 __se_sys_write fs/read_write.c:747 [inline]
 __arm64_sys_write+0x84/0x98 fs/read_write.c:747
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594
Code: f27df113 54000220 9100d274 d343fe88 (38f56908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f27df113 	ands	x19, x8, #0xfffffffffffffff8
   4:	54000220 	b.eq	0x48  // b.none
   8:	9100d274 	add	x20, x19, #0x34
   c:	d343fe88 	lsr	x8, x20, #3
* 10:	38f56908 	ldrsb	w8, [x8, x21] <-- trapping instruction


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
