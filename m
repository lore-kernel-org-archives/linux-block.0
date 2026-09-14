Received: from mail-oo2-f1.google.com (mail-oo2-f1.google.com [74.125.231.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C831337F726
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789421189; cv=none; b=cDf1KP9oCEMYsm+Dfk5rR3gNaYPeAjtCFpdP3Ykq9FNdZ0zmOke0vQCV9uxeJK8LZ6DjrPmerzda0K2TBFP4MiQIDJyhvqmTwropSUwrUj9q7yNQDdH4DhDN/krP9CeTzcEA3Wv3WIEjrfl5cM8I/7+T4DPmb5Iq5jg59w8et6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789421189; c=relaxed/simple;
	bh=dWWNsdjuysMJ/2085tK0NW4f9jW++Y+Re2ydq5/YTrs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pjjHYxaNgdAfGg5XX3CF+OC/8F1Rp2SlrlEi0ZIAUCXXXDIAReR2znjDDCdSfQ/+ABfdMWPunSC2onIJqJUjR3NEsOaprHAyaj4QtToi3ECoX+9zThowvEdE/TGbZvV2YAO8Fli5Qv7o/6h2VnBmzNPvekmV+oxj0bR8LlJ1v8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f1.google.com with SMTP id 006d021491bc7-6bc93a7858fso161810eaf.1
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 14:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789421186; x=1790025986;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vvjwSBjsoRZGABnGVp2dTMSYiqE1jQGUEtvi1+gEewA=;
        b=SvbgDL3ps6w9eZ5O14utJAdWervWZVanZnOh/hoeR9f2BEAz1ChnRS9FQngj0b939F
         z4B3xJZmJUMtiRoaetSg/OeXDQedCYqQyJBahpeXzRx7ztZM7x2jiHy6/a24Ae9EQqDY
         ugedOw4LtAiPGLFIZCFKKsHGViOaYVtXS9YKVe5nk/avPv23f4H3l0c8yZkYn9tlO3J7
         jdo8uQRIYpJocPIM0eD5Vow7SZiahMX+eKMltdNFttoK1lzonWqCYHDKSu1OimK9Rr6X
         YlaB/XcMGp5Usdx9QyQw6z4r7+rsmIh7NQbv+vKJUw2rA87I5imz/TVviuAS+j1NvKn2
         grjw==
X-Forwarded-Encrypted: i=1; AKwUvByRbag1yahz6wd5tBK3j2nUZfMG1IxbxLhNZszjAdGoZbQ+Rz1bqHJ0+DdyJmt8c9U3DJlLytw8PB9L+A==@vger.kernel.org
X-Gm-Message-State: AFuF++nJa+Hx6bNd4ETKUntuJBxt4rfJDINORu8LUfJqsk/DYULsCsdV
	Wjk+sp5Sf8GlhWMfBSl4ISN/dmbmMUovp9Yq4ndi0O1Smef1oFsg6RJaiTdeE8qwnEH+5EvBETh
	Ce0FUxwwmdkIgvWJ8dYlCdRG5QSsQY3ibjeDoz4Jz7aokcWmrQI8PhLIeYdQ=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3084:b0:6b7:83d6:292d with SMTP id
 006d021491bc7-6c542831440mr2450704eaf.48.1789421186537; Mon, 14 Sep 2026
 14:26:26 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:26:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa86682.f81106d8.2ab401.0056.GAE@google.com>
Subject: [syzbot] [block?] WARNING: suspicious RCU usage in mas_start (2)
From: syzbot <syzbot+b48868c46e62c1c4cb2c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tom.leiming@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    704340f1cd0d Merge tag 'x86_urgent_for_7.3-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16091925580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=b48868c46e62c1c4cb2c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120f305e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117fb5f9580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-704340f1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e02afc1c5927/vmlinux-704340f1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09cb4a8b3309/bzImage-704340f1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b48868c46e62c1c4cb2c@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
lib/maple_tree.c:720 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
locks held by syz.0.17/5926: 1, last CPU#0:
 #0: ffff888034a420a0 (&ctx->uring_lock){+.+.}-{4:4}, at: tctx_task_work_run+0x1cd/0xbf0 io_uring/tw.c:92

stack backtrace:
CPU: 0 UID: 0 PID: 5926 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 lockdep_rcu_suspicious.cold+0x4f/0xb2 kernel/locking/lockdep.c:6972
 mas_root lib/maple_tree.c:720 [inline]
 mas_start+0x621/0x7c0 lib/maple_tree.c:1250
 mas_state_walk lib/maple_tree.c:3006 [inline]
 mas_walk+0x82/0x310 lib/maple_tree.c:4458
 ublk_try_buf_match+0x469/0x7e0 drivers/block/ublk_drv.c:5639
 ublk_init_iod+0x4a4/0x5b0 drivers/block/ublk_drv.c:521
 ublk_setup_iod+0x145/0x2f0 drivers/block/ublk_drv.c:1536
 ublk_dispatch_req+0x4e/0xb00 drivers/block/ublk_drv.c:1776
 ublk_cmd_tw_cb+0xbe/0x110 drivers/block/ublk_drv.c:2067
 tctx_task_work_run+0xabe/0xbf0 io_uring/tw.c:96
 tctx_task_work+0x7a/0xa0 io_uring/tw.c:133
 task_work_run+0x150/0x240 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x951/0x2ae0 kernel/exit.c:1011
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1154
 __do_sys_exit_group kernel/exit.c:1165 [inline]
 __se_sys_exit_group kernel/exit.c:1163 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1163
 x64_sys_call+0x1567/0x1570 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f35df99e159
Code: Unable to access opcode bytes at 0x7f35df99e12f.
RSP: 002b:00007ffcaa2c82b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f35df99e159
RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: 0000000000000000 R09: 00007f35dfbec3e0
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f35dfbec3e0 R14: 0000000000000003 R15: 00007ffcaa2c8370
 </TASK>
I/O error, dev ublkb0, sector 0 op 0x0:(READ) flags 0x800000 phys_seg 1 prio class 2
Buffer I/O error on dev ublkb0, logical block 0, async page read


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
