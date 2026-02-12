Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A830B30E0E5
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770928892; cv=none; b=VSDIBSv1LBQpHOELWfH48+BCKzq+yNKWbNykqdVdVZsDxMBMOb7rDgsBrQkgVnVp5hLkA10Y91FsrQc6svyi3VhZ1/x1wqDJcviWu6AUS610mtThRo/ozByGv7R6XsxONd7Z8u69UnuHB6V7J2SchwMUyVqYw8HTcUgI3nbIUjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770928892; c=relaxed/simple;
	bh=2rJc9284bfT0wClE628kg22SZbLGXbOyKOVWW8Ck5QE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ftx8QDNeR7CtPtJZVt8xdtJCCJqtKLkZkVhBLsXZ3MQGOXU1K8/JpvjMm3jggL0uMm5ix3WsjupttqlD18unTUmpNkdsCNgMg0pZdyjE8i+xHdXSyS3i1yfuyBo3jNBncyW05g4/q3Nb88VoF9UlwH3TiA/vyiqYuw0PPXRO2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-4081db82088so2352632fac.1
        for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 12:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770928890; x=1771533690;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNLeUUUoeeCWrw2wdb5o3YAkYZ655djCQOfadDovkk4=;
        b=ftkE4in8e5tdY5P/st5bfUbEWu+CtvQVH/cymXjmqjNMoixwOhwCNAPaOQxNuM81Ft
         kJSloFzJGRksSbEHW4yD8LQADEnZ8WzoM6gUqmN+Kee7XKAyFzCsg08cqt5oLe8b6ObE
         NDTHhCeRt8gRO+oiMd47AjbLU0GwKI5RrZrf3Bz0+1vcFHtkHmMtQji5H48YUUTh5Ekj
         TyywVmXppekGqY16aB1jGw4NZZLP9H/dLlutom9n8lbpVq1IoEFRblGFDiUUVeQdW503
         piydiupuw/oIX3XO57E1F/WgCm64v8XwLHlmEeGQrviBHRdbYMW+7vsTyymZdwe0tPJQ
         sVww==
X-Forwarded-Encrypted: i=1; AJvYcCVB8pnZ0LgSLtdEPOg5nnKQaac9pK5Q/plwMNRSBaWJjcvdiJI3dTEtd62MeJbKTnyz2IcOWA8fO5Q41g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzABxtQZ9KJOFgL0+sKJesMAo8NtinVSpgfN5c/gLmv5rKs6VK1
	BbHh4a3PkRCiJOclGSIcGoMnPoZlEajQNBZun+aDe/gzKpq56oaGT3UX0o4FuehkbKam9tJNMGs
	Ej8yyUDqC0CKSjeRUKHtkBfJfT1OXgd7UCENw+xy85wNrRPERJBu2xi4F2oQ=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4c10:b0:662:f543:5d4b with SMTP id
 006d021491bc7-67724e6750cmr47454eaf.75.1770928890693; Thu, 12 Feb 2026
 12:41:30 -0800 (PST)
Date: Thu, 12 Feb 2026 12:41:30 -0800
In-Reply-To: <694ce8fd.050a0220.35954c.0035.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698e3afa.a70a0220.2c38d7.00a2.GAE@google.com>
Subject: Re: [syzbot] [block?] WARNING in wbt_init_enable_default
From: syzbot <syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    37a93dd5c49b Merge tag 'net-next-7.0' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14342c02580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a512b4a06724b76a
dashboard link: https://syzkaller.appspot.com/bug?extid=71fcf20f7c1e5043d78c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ffbdb2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11542eef980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0dedaafff2ad/disk-37a93dd5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aa7fae081497/vmlinux-37a93dd5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9096b39b53e1/bzImage-37a93dd5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com

0x000000000001-0x000000020000 : ""
ftl_cs: FTL header corrupt!
"mq-deadline" elevator initialization, failed -12, falling back to "none"
------------[ cut here ]------------
!rwb
WARNING: block/blk-wbt.c:784 at wbt_init_enable_default+0xcb/0x120 block/blk-wbt.c:784, CPU#0: syz.0.23/6066
Modules linked in:
CPU: 0 UID: 0 PID: 6066 Comm: syz.0.23 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
RIP: 0010:wbt_init_enable_default+0xcb/0x120 block/blk-wbt.c:784
Code: df e8 d9 cc a2 06 4c 89 e7 e8 e1 38 00 00 48 89 df e8 29 56 a2 06 e8 04 76 2b fd 5b 5d 41 5c e9 9b 22 a4 06 e8 f6 75 2b fd 90 <0f> 0b 90 eb 81 e8 eb 75 2b fd 90 0f 0b 90 48 b8 00 00 00 00 00 fc
RSP: 0018:ffffc90003b3f590 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88803364e000 RCX: 0000000000000040
RDX: ffff88802e719e40 RSI: ffffffff84daf70a RDI: ffffffff8bfa9120
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff82708ed4 R12: ffff88802b37a620
R13: ffff88803364e390 R14: ffff88802b37a630 R15: ffff88803364e090
FS:  00007f472043f6c0(0000) GS:ffff8881245a5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000da000 CR3: 000000007affe000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 blk_register_queue+0x39e/0x4e0 block/blk-sysfs.c:942
 __add_disk+0x73f/0xe40 block/genhd.c:528
 add_disk_fwnode+0x118/0x5c0 block/genhd.c:597
 add_mtd_blktrans_dev+0xd0b/0x1520 drivers/mtd/mtd_blkdevs.c:382
 mtdblock_add_mtd+0x1cc/0x270 drivers/mtd/mtdblock.c:333
 blktrans_notify_add drivers/mtd/mtd_blkdevs.c:464 [inline]
 blktrans_notify_add+0xa2/0xf0 drivers/mtd/mtd_blkdevs.c:456
 add_mtd_device+0xbe3/0x1750 drivers/mtd/mtdcore.c:820
 mtd_add_partition+0x30a/0x660 drivers/mtd/mtdpart.c:279
 mtdchar_blkpg_ioctl+0x207/0x250 drivers/mtd/mtdchar.c:562
 mtdchar_ioctl+0x1670/0x1fd0 drivers/mtd/mtdchar.c:1218
 mtdchar_unlocked_ioctl+0xb0/0xf0 drivers/mtd/mtdchar.c:1241
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f471f59bf79
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f472043f028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f471f816090 RCX: 00007f471f59bf79
RDX: 0000000000000000 RSI: 0000000000001269 RDI: 0000000000000004
RBP: 00007f471f6327e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f471f816128 R14: 00007f471f816090 R15: 00007ffe9ebc84a8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
