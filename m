Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E0536D4EC
	for <linux-block@vger.kernel.org>; Tue, 17 Feb 2026 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357774; cv=none; b=cVW52DYPihnIIF26f9qy2mWMy9v1S3wTRLsLYE5N426Pekcx9Mai0m+W0g+5RQXMxkN6pLKuP5JUPMGXSS/TGlM9siB5/PEP9EReajVPAfgBbckWHOt8NiyU5kOIfz+xpo0ijwaDxNkSbAkQmeMTw3WVsSdrC5lEf0uMQPRw8QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357774; c=relaxed/simple;
	bh=HTnMAddskUhHkKMIpW73k9V8tiGUfdqbQilYYA73G/s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EVP45Z5idQYEdeCC1XfMal1Ntli/wScQC0A1NLEY7frATeP6EUOS8s0cB5l3e+UsCzTLOzuuBuk/cRk1An240jZq6GFKS3Qxt5tICgEX/SkY30RoO4qqDE1egCfk3ZdkQQbRKPCVuVZzWeqWB5/5GxItrARhydYzX/ISx83IGXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-45f16aa81a8so2532690b6e.1
        for <linux-block@vger.kernel.org>; Tue, 17 Feb 2026 11:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771357771; x=1771962571;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J7oG1PEXR6aRwD08qjBpn3IaU8PvlEnIDt61McOrYLU=;
        b=giea8Y6oYgEkKWHJMGGd6LdWn8QPIsNZdczB0vV5sx5avJYYDQN6BtRdF81b0TMMeK
         3QQ6wTxW0n1UrnpI+z6CnNLh6UgipReMgGrroLCM+kgM4skY2bAJ5+XKd9or/3QgGl0a
         HE9HJIlyKdjVxXlfJ7KBu4/4GMyRKIKCoi+0qwc4/PaL4EqotiAR+MuLauaRMGbKHotj
         KCTIpfGZNiyquPWeu9ExKLONmh3xWgXA5fqkbpskHGXkgyjsXW2Efj1j/wHFPG60UP7A
         Xk5kQ6G7w6kkRYXXUqrnAceAzlNnpXVwFE/qUwbgF+3ViZf3QajkBVGiYq9rN7dkuH9p
         PFaw==
X-Forwarded-Encrypted: i=1; AJvYcCWI5TTShks5wwQ+hgH7Ds08A5JjiZMXzaObg78Bw3zzqxshRTAn17vpnW6Yv2X9xOJ+/laMCar6+4pzMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeHW8S0n/N3pI3KscAEd1lsU+oCZapeQaTYw3CO5ELmDi7OUVV
	Ov0JawbaREbCsAJFNzE1Yfh68MdZawzvCLjjcylaYlbE+mfG434Yjc2Ni14nUMa7eS2SgHdUHED
	wRlLdRnhNpU7dCTBYXkis+lMw+DgVOWJoKoOBK+QOwEfcSMkcm2MIeZzuhco=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:86d7:b0:464:5a7:7cd6 with SMTP id
 5614622812f47-46405a7c2famr715814b6e.15.1771357771631; Tue, 17 Feb 2026
 11:49:31 -0800 (PST)
Date: Tue, 17 Feb 2026 11:49:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6994c64b.a70a0220.2c38d7.010a.GAE@google.com>
Subject: [syzbot] [nbd?] possible deadlock in nbd_disconnect_and_put
From: syzbot <syzbot+3add0454d5a2619b8e80@syzkaller.appspotmail.com>
To: axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    635c467cc14e Add linux-next specific files for 20260213
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=136df15a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61690c38d1398936
dashboard link: https://syzkaller.appspot.com/bug?extid=3add0454d5a2619b8e80
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/78b3d15ca8e6/disk-635c467c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a95f3d108ef4/vmlinux-635c467c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e58086838b24/bzImage-635c467c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3add0454d5a2619b8e80@syzkaller.appspotmail.com

block nbd1: NBD_DISCONNECT
block nbd1: Disconnected due to user request.
block nbd1: shutting down sockets
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.1.1462/9805 is trying to acquire lock:
ffff8880271c7948 ((wq_completion)nbd1-recv){+.+.}-{0:0}, at: touch_wq_lockdep_map+0xb5/0x180 kernel/workqueue.c:3994

but task is already holding lock:
ffff888027014278 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_disconnect_and_put+0x2f/0x2c0 drivers/block/nbd.c:2256

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&nbd->config_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x19f/0x1300 kernel/locking/mutex.c:776
       refcount_dec_and_mutex_lock+0x30/0xa0 lib/refcount.c:118
       nbd_config_put+0x2c/0x580 drivers/block/nbd.c:1434
       recv_work+0x1cc1/0x1d90 drivers/block/nbd.c:1026
       process_one_work+0x949/0x1650 kernel/workqueue.c:3279
       process_scheduled_works kernel/workqueue.c:3362 [inline]
       worker_thread+0xb46/0x1140 kernel/workqueue.c:3443
       kthread+0x388/0x470 kernel/kthread.c:467
       ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 ((work_completion)(&args->work)#3){+.+.}-{0:0}:
       process_one_work+0x895/0x1650 kernel/workqueue.c:3255
       process_scheduled_works kernel/workqueue.c:3362 [inline]
       worker_thread+0xb46/0x1140 kernel/workqueue.c:3443
       kthread+0x388/0x470 kernel/kthread.c:467
       ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 ((wq_completion)nbd1-recv){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
       touch_wq_lockdep_map+0xcb/0x180 kernel/workqueue.c:3994
       __flush_workqueue+0x14b/0x14f0 kernel/workqueue.c:4036
       nbd_disconnect_and_put+0x9e/0x2c0 drivers/block/nbd.c:2264
       nbd_genl_disconnect+0x4a9/0x590 drivers/block/nbd.c:2303
       genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
       __sock_sendmsg net/socket.c:752 [inline]
       ____sys_sendmsg+0x589/0x8c0 net/socket.c:2610
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2664
       __sys_sendmsg net/socket.c:2696 [inline]
       __do_sys_sendmsg net/socket.c:2701 [inline]
       __se_sys_sendmsg net/socket.c:2699 [inline]
       __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2699
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  (wq_completion)nbd1-recv --> (work_completion)(&args->work)#3 --> &nbd->config_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&nbd->config_lock);
                               lock((work_completion)(&args->work)#3);
                               lock(&nbd->config_lock);
  lock((wq_completion)nbd1-recv);

 *** DEADLOCK ***

3 locks held by syz.1.1462/9805:
 #0: ffffffff8fe5ba70 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fe5b888 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fe5b888 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fe5b888 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1209
 #2: ffff888027014278 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_disconnect_and_put+0x2f/0x2c0 drivers/block/nbd.c:2256

stack backtrace:
CPU: 0 UID: 0 PID: 9805 Comm: syz.1.1462 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
 touch_wq_lockdep_map+0xcb/0x180 kernel/workqueue.c:3994
 __flush_workqueue+0x14b/0x14f0 kernel/workqueue.c:4036
 nbd_disconnect_and_put+0x9e/0x2c0 drivers/block/nbd.c:2264
 nbd_genl_disconnect+0x4a9/0x590 drivers/block/nbd.c:2303
 genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
 __sock_sendmsg net/socket.c:752 [inline]
 ____sys_sendmsg+0x589/0x8c0 net/socket.c:2610
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2664
 __sys_sendmsg net/socket.c:2696 [inline]
 __do_sys_sendmsg net/socket.c:2701 [inline]
 __se_sys_sendmsg net/socket.c:2699 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2699
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f496959bf79
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f496a4cd028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f4969816090 RCX: 00007f496959bf79
RDX: 00000000000000c0 RSI: 0000200000000280 RDI: 0000000000000004
RBP: 00007f49696327e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4969816128 R14: 00007f4969816090 R15: 00007ffd35895958
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
