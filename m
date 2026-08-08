Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AA73B42FC
	for <linux-block@vger.kernel.org>; Sat,  8 Aug 2026 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219834; cv=none; b=IBrOgk/J9itN74ml6DDrOr9Bw+CCN00C2wnLb/q4CUuaMTpcwY1Pi0xJaUapaFLSgI0b9LH/6VkoEmOnyRreFMoT4rYCqBreeGg32FK9OJdKokiyYTVgjucMPSx7JfrroxqXz6md8AHfIHKCUEVlAUWo3Nn9Yyyt4raO1nP34Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219834; c=relaxed/simple;
	bh=NStiOU354GC5it+ejw+vFC/g4fHElHp1EZ3xerHRgU0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=spRfdswBvvB5ZPU3QSl1D961Essy4VP2bk1rMqsu5d/CRIFFgQ3TMPUz/0h4vKbtTKds5KDAOk68U/qPsTGfnmXPr+iQHajS9rkxFL2MX5Qv5C6ImK5ie4qrezMLCp8FLUX+5h1qzWYJ7brZ1pR16F1a0iNEBymbQ8dHNAaBKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6a17baa4d18so950928eaf.1
        for <linux-block@vger.kernel.org>; Sat, 08 Aug 2026 13:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786219831; x=1786824631;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNiwaLw3oKHbulRkpF0IWn1/FQIST9xYGlACS1TbjJI=;
        b=klftREnQvBMgzdxNjWmKRgjlwukSTR18B5ZAvLY06jheCWuDvbCMxqA/+6ojdMjI75
         7KFOfhh9MFi3diCtlRXi+tDJujHI9u0hZWIAY0crd3dKmkj22h9eLBRzfhM+oAR3lJWU
         OoCVIUgXFZIjGubVoL5xTJ78GHbrrgCn5H6zUkVDwsZZrmdRL//mJQxau2ZqIjnirec3
         ryDfpWTlyNyL5als4p537N352dcVsfbVVTKT3kaFQu204e7kd0p43/Aj6FDzgFz4zYMa
         KAhTU9B1TSTCAUjhXG0wR57gKWDq8EPK/QogzxD2S0FD4y7cKIC1fwz5rLRAL3z5MI78
         d9Hw==
X-Forwarded-Encrypted: i=1; AHgh+Rqa/mHKq3JWHc+B+dJKbQyOHYhgkECPVKFrh+aMerCA4PCgCl473oOiGBKT+8u9uXfwDg9tbmDgNnfNpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYPLh6kB8d/d9tEZ/Sy1yLT6xWCEHkfBT8W29Yn/v11Jg9VGOC
	cw5kF02ENoY3pUHHe9BLXQjylNCJZ7pK/MuSd/i2egShoMTlj6bf/c6HqgU2/uzT1nnfeWeOHrf
	7zpbTybbyR+Ee9Q3HSRpK6kDMd9YefSQf9zO35s51jXwGdU9KL42pJNXdMQw=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4c0d:b0:6a1:98e6:a8f5 with SMTP id
 006d021491bc7-6ae9709a97fmr18231657eaf.36.1786219830874; Sat, 08 Aug 2026
 13:10:30 -0700 (PDT)
Date: Sat, 08 Aug 2026 13:10:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a778d36.01d0871a.3a0d52.006f.GAE@google.com>
Subject: [syzbot] [block?] WARNING in blk_validate_limits
From: syzbot <syzbot+ac00e7bf7ac8c91af921@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6b8c8af514d7 Add linux-next specific files for 20260807
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=112e0149580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d343b54cc50df0f
dashboard link: https://syzkaller.appspot.com/bug?extid=ac00e7bf7ac8c91af921
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112f6fb9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/71ff4edcb608/disk-6b8c8af5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f5fa331d8f2/vmlinux-6b8c8af5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f993558ec63b/bzImage-6b8c8af5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9a307a7695b3/mount_1.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=15456132580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ac00e7bf7ac8c91af921@syzkaller.appspotmail.com

F2FS-fs (loop0): f2fs_disable_checkpoint: call f2fs_write_checkpoint(), meta: 0, node: 0, data: 0
F2FS-fs (loop0): Start checkpoint disabled!
F2FS-fs (loop0): f2fs_disable_checkpoint finishes, err:0
F2FS-fs (loop0): Mounted with checkpoint version = 48b305e6
------------[ cut here ]------------
lim->dma_alignment > PAGE_SIZE
WARNING: block/blk-settings.c:497 at blk_validate_limits+0x1676/0x2270 block/blk-settings.c:497, CPU#0: syz.0.17/5837
Modules linked in:
CPU: 0 UID: 0 PID: 5837 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:blk_validate_limits+0x1676/0x2270 block/blk-settings.c:497
Code: e8 ef 7e 11 fd 90 0f 0b 90 eb 8f e8 e4 7e 11 fd 90 0f 0b 90 eb 84 e8 d9 7e 11 fd 90 0f 0b 90 e9 76 ff ff ff e8 cb 7e 11 fd 90 <0f> 0b 90 e9 68 ff ff ff e8 bd 7e 11 fd 90 0f 0b 90 e9 81 00 00 00
RSP: 0018:ffffc90003366e60 EFLAGS: 00010293
RAX: ffffffff84b60635 RBX: ffffc900033670f0 RCX: ffff8880320dbe80
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000001000
RBP: 00000000ffffffff R08: ffff88806ffbcb5f R09: 1ffff1100dff796b
R10: dffffc0000000000 R11: ffffed100dff796c R12: ffffc90003367040
R13: dffffc0000000000 R14: 1ffff9200066ce1e R15: dffffc0000000000
FS:  000055557d3c5500(0000) GS:ffff888124f0c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4283f8dd30 CR3: 0000000075748000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 queue_limits_commit_update+0x87/0x390 block/blk-settings.c:552
 loop_configure+0x7f1/0xdc0 drivers/block/loop.c:1086
 lo_ioctl+0xad5/0x2150 drivers/block/loop.c:1564
 blkdev_ioctl+0x5e3/0x740 block/ioctl.c:798
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x510 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f222c19e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffebd792d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f222c425fa0 RCX: 00007f222c19e0d9
RDX: 00002000000005c0 RSI: 0000000000004c0a RDI: 0000000000000003
RBP: 00007f222c235024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f222c425fac R14: 00007f222c425fa0 R15: 00007f222c425fa0
 </TASK>


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
