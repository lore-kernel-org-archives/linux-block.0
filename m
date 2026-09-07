Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034BD4B04BA
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797493; cv=none; b=iJfJFGFIFFtBXeLFw+BZImPiXEk/VhYnlYskhEcUwloc+VpbS6SgMaAMVnnXYxmZJIwJwp8WrcckQvLLGCcXuEjoJBbE8sfp5s9Ytft4uD3Kx3hSgDIre49f7dkqN3ZfcjfjgexsIoVVGAU50mWK6MSRXbb4ftSB45E5PIRGQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797493; c=relaxed/simple;
	bh=VincKhBKBEVAfVDcaHicp1GuEytETGoqpCCzPmhI+YQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UeA54aw5CRZUrNVOk6t0aJ1Q7TLp2jnwdGeCK7WbmMU/YHHbZL91EK7aR8+1/Kbj8niD264ohb7IQ6odBRat1i734GCWWxWY0lsuQZpqoQ06WmsB9agq/mcUPTF39AUXMUJD61IHu+fLcwUkv71wPJhnnuicXr/Dhv2+BTeqg9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-455efbd6e96so1059165fac.1
        for <linux-block@vger.kernel.org>; Mon, 07 Sep 2026 09:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788797491; x=1789402291;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ViS7hCfXYJXTTTfGntTvlHMt9oWGJwuI0Tbh8BxPtI=;
        b=RtfcYUJTMFU/0m5TyHB6gnyG5L2nXFSJm4F7fcS2tzBLLc8tag4WZq+0zGy64I8qjh
         da+3B1t+UKlhdDB6f/eQ1Vk7v5CRseDo//GZxAEv3hOcqFA8cYGbiza5WIwoS3K9KJr7
         YJ5JX/HfloxdN5Rg6oLmerElc/WrUxOZ7Z3u5E5C8cYmgLB56qgbXYw7XNa+lwk4FnVd
         grK/JWsr95R7nS3gIw3pGNCD056qEgusCsEhacYJWox7q6v1nASfxb9pbQrQtzHjXe50
         CG7xl0GD4jvIlT4z7frQngidegfypAAoM1p6E14pdW/bSppdJYIDI9fo+Eex6JnA5MeF
         1jKA==
X-Forwarded-Encrypted: i=1; AKwUvBzqKmelhDpGqhA1bei/DW9FWn0eL/iVVxNxRnZ8oDjSDpWIFzaoXBU8jOUYawMQb29pWoQjgbE44M2vjw==@vger.kernel.org
X-Gm-Message-State: AFuF++mtOlHfDNBC6ih5MuGulRiLE8yB+oS5SN9Bb6ZgoQexZB+CnysZ
	0a7v0YOcBdR/oQVSHnfC2RWQqYX637Nh8LXypAJfz3WueRRZcohYcYoXZ3pD2RbTUYLFWLUyM8G
	MwItG39o2iD7QLpJlZUQguKn6SnZVVBMMUcmhxt41/KxtPHZhjsZPRIIpaNo=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4cc5:b0:6b7:83d6:2938 with SMTP id
 006d021491bc7-6b783d62f7amr10430227eaf.59.1788797490975; Mon, 07 Sep 2026
 09:11:30 -0700 (PDT)
Date: Mon, 07 Sep 2026 09:11:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9ee232.2bb5a69c.24b23c.0005.GAE@google.com>
Subject: [syzbot] [block?] WARNING in blk_mq_unquiesce_queue
From: syzbot <syzbot+9ab4656e96793f987052@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    32b6ef9a5d0e Add linux-next specific files for 20260902
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1740f0f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32ceed1c94c11059
dashboard link: https://syzkaller.appspot.com/bug?extid=9ab4656e96793f987052
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/23067747792b/disk-32b6ef9a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/30cb2facc601/vmlinux-32b6ef9a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a4907bc6c937/bzImage-32b6ef9a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ab4656e96793f987052@syzkaller.appspotmail.com

------------[ cut here ]------------
q->quiesce_depth <= 0
WARNING: block/blk-mq.c:321 at blk_mq_unquiesce_queue+0xdf/0x120 block/blk-mq.c:321, CPU#1: kworker/u8:3/50
Modules linked in:
CPU: 1 UID: 0 PID: 50 Comm: kworker/u8:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work
RIP: 0010:blk_mq_unquiesce_queue+0xdf/0x120 block/blk-mq.c:321
Code: 48 8b 34 24 e8 f2 04 2b 07 4c 89 ff be 01 00 00 00 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d e9 77 ed ff ff e8 02 92 09 fd 90 <0f> 0b 90 eb a2 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 5a ff ff ff
RSP: 0000:ffffc90000bb7a08 EFLAGS: 00010093
RAX: ffffffff84be42ae RBX: ffff88802a03e738 RCX: ffff88801b171f40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000176f2c R12: 1ffff11005407cef
R13: dffffc0000000000 R14: ffff88802a03e778 R15: ffff88802a03e670
FS:  0000000000000000(0000) GS:ffff888124dcb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555584f52a88 CR3: 0000000058f50000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 blk_mq_unquiesce_tagset+0x134/0x220 block/blk-mq.c:357
 nvme_loop_destroy_io_queues drivers/nvme/target/loop.c:313 [inline]
 nvme_loop_shutdown_ctrl drivers/nvme/target/loop.c:412 [inline]
 nvme_loop_reset_ctrl_work+0x1c7/0x810 drivers/nvme/target/loop.c:447
 process_one_work kernel/workqueue.c:3399 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3482
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3563
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
