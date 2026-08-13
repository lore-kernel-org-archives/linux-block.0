Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B3633993
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786579778; cv=none; b=OfdJ0qFiVUMP6NjPL8uxCkRDZFFh5xHjxl6HqXW6j4wuR+CM75QZAlLADJ1QqpOrTCj/e7+tjfHb3yygm+cYafAkV7HS/oVyXwH7X97Jpf8cANjZQJzqn6tXsPoZr4SCHFFd1OgH7W6Adw8Lj/KgZYt35FkdnM4ztcSc/R9+EFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786579778; c=relaxed/simple;
	bh=W0Q1bpZD3t3n+SGI5Ea8+Gwd9eOwnTOdNnBajhjQB/0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HDAu0nBRbg6kQyc/bopPO3hB8lCVD/cnUGcGLHr4iKUt+JFyHq5xXMuC/FI2TmF67Dq/DNPDN+zF3z8NQMiP0CAqMOsIBirDfoa8XAUtEH7jN+oW9xqQe/k+lZSVjYpUmoLYZuf1NxkJYMNZTLqRzkGc4ZAh3/EFE+lF08Aq6V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7e9dc0f5900so728859a34.0
        for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 17:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786579775; x=1787184575;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hJNI0d+L/kW58SMi8YpL1wxJse/mqRbOAQMOBroOL18=;
        b=h05N+yGNRjZmox853/I35nyZarcf27KDR5EMSSljhi9XpHS4tGjTN7+97SoQxqGmrw
         cRQGFvX66j/A0kOu+3DeFjjKKXf3/LGYVM9uEEfTN110vDQj0CgdTA+vdoOyobiuy7+7
         CFq8mKnkxf3lnb/MBXQ0C5gvWiRv5j1hj93U3S+5tcdAcFOF2eacSnDPNbYVVVxO7X9E
         DUeoLkm/uXY/S/OiHItIvycUvd8k9vDkkmLbtjRuSKs/UArr/jR74Mo+3AJNsr9SuchN
         p/gsDNN+8dozNRLQIQEK55i6/O9/nW+Y+N1BF4VaBjp3ECkMi3GgGhMpGbDVdVjW3fqm
         VgPw==
X-Forwarded-Encrypted: i=1; AHgh+RqfpDwHpvSkzmeWn8BOquDJU4FyA+8xCBbJQOsPl1QE7uSxUODNzg0qRuaViOAR4dkOqyzNQvuSvNv6VQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWX8wkvoFPE0HOE0Fx7P16EvwivVyHU56UmLKiXZaeHex/kaz
	rRHWLcFWeQD8qM2/gK8qcDZlQS6tSnQXzzmCF50CLxKz2ilGWsOjqhOqRnN5EGPd1btDW5YA8jd
	jlEb85uQ/CFSyAyVfMIWoQlQfQQQbmk0OfurUXetl79NvjWF062PvQTB0Zfs=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:198b:b0:6ae:4959:e1ba with SMTP id
 006d021491bc7-6b0c5b8be01mr1559651eaf.10.1786579775508; Wed, 12 Aug 2026
 17:09:35 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:09:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7d0b3f.ac361c09.22ff0a.004c.GAE@google.com>
Subject: [syzbot] [block?] WARNING in blk_revalidate_disk_zones
From: syzbot <syzbot+643a6dd130546afdf1fb@syzkaller.appspotmail.com>
To: axboe@kernel.dk, dlemoal@kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d58772d8520c Merge tag 'regmap-fix-v7.2-rc7' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160ad132580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=643a6dd130546afdf1fb
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cef626cbb901/disk-d58772d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/99faa1c91124/vmlinux-d58772d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cf8806baff68/bzImage-d58772d8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+643a6dd130546afdf1fb@syzkaller.appspotmail.com

null_blk: nullb1: using native zone append
------------[ cut here ]------------
!blk_queue_is_zoned(q)
WARNING: block/blk-zoned.c:2357 at blk_revalidate_disk_zones+0x962/0xce0 block/blk-zoned.c:2357, CPU#1: syz.4.694/8600
Modules linked in:
CPU: 1 UID: 0 PID: 8600 Comm: syz.4.694 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:blk_revalidate_disk_zones+0x962/0xce0 block/blk-zoned.c:2357
Code: e8 73 15 fc fc 49 81 fe 00 f0 ff ff 0f 87 00 02 00 00 e8 c1 1a fc fc 4c 89 f7 e8 c9 c2 c9 fc e9 ce fa ff ff e8 af 1a fc fc 90 <0f> 0b 90 41 be fb ff ff ff e9 d5 fb ff ff e8 2b a9 6c fd e9 5c f7
RSP: 0018:ffffc9000388f918 EFLAGS: 00010287
RAX: 0000000000004d06 RBX: ffff88804bda7000 RCX: ffffc900063c1000
RDX: 0000000000080000 RSI: ffffffff850e58d1 RDI: ffff888079178000
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88802b726670
R13: 0000000000000000 R14: ffff88807e08e018 R15: ffff88804bda7090
FS:  00007f108a7486c0(0000) GS:ffff888123eec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd5511556c8 CR3: 0000000056586000 CR4: 00000000003526f0
DR0: ffffffffffffffff DR1: 00000000000001f8 DR2: 0000000000000083
DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 null_add_dev+0x125f/0x1df0 drivers/block/null_blk/main.c:2047
 nullb_device_power_store+0x29d/0x350 drivers/block/null_blk/main.c:501
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f108979e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f108a748028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f1089a25fa0 RCX: 00007f108979e0d9
RDX: 0000000000000002 RSI: 0000200000000700 RDI: 0000000000000005
RBP: 00007f1089835024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1089a26038 R14: 00007f1089a25fa0 R15: 00007ffc5551d348
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
