Received: from mail-oi2-f1.google.com (mail-oi2-f1.google.com [74.125.231.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FE8175A62
	for <linux-block@vger.kernel.org>; Sat, 22 Aug 2026 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357432; cv=none; b=UiffgSzdNwDipP/lhT4pVViALqrBUysuviydAWNPSf2A//iSndU1B2DVYDgfLCSSC9/ogg8JDdplcCz7TDFyGCFzTpv2i8al6wVFqQC37R3yT/kTy9SHvNPNM1RtppqQAWePT6UR3iSdQyuUMMHp4Bh40j0UAg+BRo6dQEDRk8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357432; c=relaxed/simple;
	bh=US6qBTxDIZ25hqmT+CwEfOlI5bitHCUGYkSGedaJTEY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nPc2L+pl7uh0lXC5wyF3ahOwtEA6vEkKelw5NKP8trP5vYfHZ/rBsH1toxlq/8rqhrYD2R3JvYv3Z4/Ujap2JQC5pD+bIpgUXjOo/vUpEHslEDihj4jrrR/cXwGycmPptMJb6Q/ZUECazGgShqKU8ShderyhpyxGaOEyyKC4S1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f1.google.com with SMTP id 5614622812f47-495f936d5ecso519760b6e.0
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 17:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787357429; x=1787962229;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wmwTFST+CH1Rgf9d7FhqM1MPDApV+0RyAM9RTdnhIms=;
        b=Jbuy6uPyVMI+DC1kPNbmHRR7lER03cP3FN0zGKOfZp2DHsdWqn5tm4sAHxHwA9Oins
         49RD1RPDkgkKIGSfQZnwfNxDWwUnPsJ2Zt7dHuOftHsI17Gbn3LXKyWY/4Od5z++TIjm
         hVgxcAtspRyCVuMKamJvYEpuKoOBdXDz/dOgcXOPUTd1AavOo05h1+rtxY8EPbjO7ZgG
         yEdADz8IQhv+cSwNu9TgQyaUG9DJ5Y82QZlVvIf2TVDFRY9IVP79e90OwT/6SJZTnPNv
         dDDpPPwTvDt4M5dDvVMJ4GcV5pegXl6xSUWKsQq0oknQia3xGeorqrkmrr8O09iK8xNl
         cTFA==
X-Forwarded-Encrypted: i=1; AHgh+RonFOSCW/prwSPYGGg/ZtGslhOuSUEfX3K58XzuHaQcpaTPjKOG+i6ECFiiFbUE0lFPJjBZQh312zOqMw==@vger.kernel.org
X-Gm-Message-State: AFuF++nLg98RC4SK2F6VONP9Z7Z8sAJQL96rrOSXsHDdhM9MLGfq6gqr
	AGm5QQdUfYP9fydkrClUtXBq6b0QH7QySrIs8qQnY88r9MAVX/+z4TcpDU8hngrUncF36CTdLc9
	n9y5OvqmFU+rEJ66MK2xhutSuFdfHgJlvEtO4C/vxh+YkH9sUxAToa5jLkvw=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c1e1:b0:4b2:e9d9:f13f with SMTP id
 5614622812f47-4b309b93384mr3523786b6e.17.1787357429727; Fri, 21 Aug 2026
 17:10:29 -0700 (PDT)
Date: Fri, 21 Aug 2026 17:10:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a88e8f5.91706f20.16b6e3.02ad.GAE@google.com>
Subject: [syzbot] [block?] WARNING in blk_mq_dispatch_rq_list
From: syzbot <syzbot+49b69d460fb5134ee1d7@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    21d6ac051080 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17fb5e79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1128bc53f2ef7f3
dashboard link: https://syzkaller.appspot.com/bug?extid=49b69d460fb5134ee1d7
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/88380e2ddcb9/disk-21d6ac05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5dba5c2896b7/vmlinux-21d6ac05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/52ac739e37e0/Image-21d6ac05.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+49b69d460fb5134ee1d7@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: block/blk-mq.c:2107 at blk_mq_dispatch_rq_list+0x960/0x13a8 block/blk-mq.c:2107, CPU#0: kworker/0:1H/4345
Modules linked in:
CPU: 0 UID: 0 PID: 4345 Comm: kworker/0:1H Tainted: G             L      syzkaller #0 PREEMPT 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/07/2026
Workqueue: kblockd blk_mq_run_work_fn
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : blk_mq_dispatch_rq_list+0x960/0x13a8 block/blk-mq.c:2107
lr : blk_mq_dispatch_rq_list+0x960/0x13a8 block/blk-mq.c:2107
sp : ffff8000988b77e0
x29: ffff8000988b78c0 x28: 0000000000000000 x27: 0000000000000000
x26: 1fffe0001918f242 x25: ffff0000c8c79248 x24: ffff0000c8a75800
x23: dfff800000000000 x22: ffff0000c8c79210 x21: ffff8000988b7a48
x20: ffff8000988b7a40 x19: ffff0000c8a75948 x18: 00000000ffffffff
x17: ffff80008a7d6000 x16: 0000000000000004 x15: ffff80008a35fda0
x14: ffff80008a5d5e28 x13: 0000000000000002 x12: 0000000000000000
x11: 0000000000000000 x10: ffff700013116f12 x9 : 0000000000000000
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff80008ab02a68 x4 : 0000000000000000 x3 : 0000000000000010
x2 : 0000000000000000 x1 : ffff0000d4098000 x0 : 0000000000000000
Call trace:
 blk_mq_dispatch_rq_list+0x960/0x13a8 block/blk-mq.c:2107 (P)
 __blk_mq_sched_dispatch_requests+0x250/0x10e8 block/blk-mq-sched.c:299
 blk_mq_sched_dispatch_requests+0xa8/0x158 block/blk-mq-sched.c:329
 blk_mq_run_work_fn+0x214/0x2e4 block/blk-mq.c:2532
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0x788/0x10b8 kernel/workqueue.c:3405
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3486
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
irq event stamp: 5080
hardirqs last  enabled at (5079): [<ffff8000869308a8>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:187 [inline]
hardirqs last  enabled at (5079): [<ffff8000869308a8>] _raw_spin_unlock_irq+0x30/0x80 kernel/locking/spinlock.c:206
hardirqs last disabled at (5080): [<ffff80008690b3d0>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:445
softirqs last  enabled at (0): [<ffff8000802ec674>] copy_process+0x13a4/0x32e8 kernel/fork.c:2238
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: block/blk.h:703 at req_ref_put_and_test block/blk.h:703 [inline], CPU#0: kworker/0:1H/4345
WARNING: block/blk.h:703 at blk_mq_free_request+0x190/0x210 block/blk-mq.c:829, CPU#0: kworker/0:1H/4345
Modules linked in:
CPU: 0 UID: 0 PID: 4345 Comm: kworker/0:1H Tainted: G        W    L      syzkaller #0 PREEMPT 
Tainted: [W]=WARN, [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/07/2026
Workqueue: kblockd blk_mq_run_work_fn
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : req_ref_put_and_test block/blk.h:703 [inline]
pc : blk_mq_free_request+0x190/0x210 block/blk-mq.c:829
lr : req_ref_put_and_test block/blk.h:703 [inline]
lr : blk_mq_free_request+0x190/0x210 block/blk-mq.c:829
sp : ffff8000988b7730
x29: ffff8000988b7730 x28: ffff700013116f0c x27: ffff0000c8c79200
x26: ffff0000d4098000 x25: 1fffe0001918f243 x24: 1fffe0001918f260
x23: dfff800000000000 x22: dfff800000000000 x21: ffff0000c8c7929c
x20: 000000000000007f x19: ffff0000c8c79200 x18: 00000000ffffffff
x17: ffff80008a7d6000 x16: 0000000000000004 x15: ffff80008a35fda0
x14: ffff80008a5d5e28 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff60001918f254 x9 : 0000000000000000
x8 : 0000000000000000 x7 : ffff8000817b1a10 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008178be24
x2 : 000000000000007f x1 : ffff0000d4098000 x0 : 0000000000000000
Call trace:
 req_ref_put_and_test block/blk.h:703 [inline] (P)
 blk_mq_free_request+0x190/0x210 block/blk-mq.c:829 (P)
 __blk_mq_end_request+0x32c/0x434 block/blk-mq.c:-1
 blk_mq_end_request+0x68/0x8c block/blk-mq.c:1149
 blk_mq_dispatch_rq_list+0x410/0x13a8 block/blk-mq.c:2129
 __blk_mq_sched_dispatch_requests+0x250/0x10e8 block/blk-mq-sched.c:299
 blk_mq_sched_dispatch_requests+0xa8/0x158 block/blk-mq-sched.c:329
 blk_mq_run_work_fn+0x214/0x2e4 block/blk-mq.c:2532
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0x788/0x10b8 kernel/workqueue.c:3405
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3486
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
irq event stamp: 5256
hardirqs last  enabled at (5255): [<ffff800080557c84>] seqcount_lockdep_reader_access+0x7c/0xf8 include/linux/seqlock.h:75
hardirqs last disabled at (5256): [<ffff80008690b3d0>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:445
softirqs last  enabled at (5248): [<ffff80008030e6e4>] softirq_handle_end kernel/softirq.c:468 [inline]
softirqs last  enabled at (5248): [<ffff80008030e6e4>] handle_softirqs+0xc28/0xd98 kernel/softirq.c:650
softirqs last disabled at (5083): [<ffff8000800204c0>] __do_softirq+0x14/0x20 kernel/softirq.c:656
---[ end trace 0000000000000000 ]---


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
