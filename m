Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EB82741B5
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493493; cv=none; b=hIqjeKb6TSQVWPKGsI52e7e2MqwR+r8MbpiQQyulQ2msU99XnLxvWRKEgsbQ3vUwDmIUneB2ReOdwO24X77W4VwvKm9JS8oBW4PWkuXYFI6Ukjlj6sD95LmAONMXGsz7BAKvrWb66cLKy1sh0sncAKy9xL4CpkP/PWpFOEF4SM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493493; c=relaxed/simple;
	bh=f5k9/PhSgQcfro65mjaeAUfa6dfNMMmDbDbaksjcZ8w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XRVB2wYGaf1aabeTJLJsol5bqLPBWcGuJRKMtJkO1LpEKrrKM4Oly4TF1/Fer54Q0Vw0U7xaQ7cgB7u6JLPZVVq0Rd8CTp7jNOYJR3vEaLzkiE2tZ6iVaPmIAA7sgxzxOD1QYPQJ8s4nRzZ/r+v/ifk6yyPLMnvKudDJzkK7oy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-48e5de5a23cso162026b6e.0
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 17:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786493489; x=1787098289;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/X6cw5Wfbro1zK/qZ0Aq85IiIvVQqv51gnPAqgZUWVs=;
        b=cGwlvBhaHD9jB69VSDFny6RDQjBFCfSoRjejzzUuMaSAPWabMjdnlGvO4L0CETgw22
         8nKPZLddxg6aiK9Q+k/n3QRJ6ZLKphnhQBu2ssW9CE7Uxp8QnowxtMy7r01jeEOGkgp4
         9SRALlAVPBchYf6frofmyMZZpiHZ8fwkjdvUVlgHGWdUX2fwVfs0mwTTCj17djzS600l
         Vmk/Qj5alivmAg3Ir8iJBCCs4inLnziLo9n9Hhlr1L23GsQoqQoVlzlAFMiDb2zzm51N
         Cc0iojgUp/GrPaxxIp2P0T/fAJzuHT5mLjTQ+Btdw6lQ2RJaC9quK6XgNjSGEbWBphQY
         ufww==
X-Forwarded-Encrypted: i=1; AHgh+RpVbd6lgiihp07e+hMj9ayoAMpE/I7w2OEAEFC8gfNhd6Xmq2mQ7UooqgyIQyE45YB+D7qfe1O87AFlGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyxixp+psJT4C+rEGdxzH0W3UXq/P7iYJdUVEeXAFRcw6w+h6o
	ap1Y2Yr+IynGKWkMWbD2sTIdSd/KXXHIbPVVK6yEK/MI5ktjrvjZ1IKdiTQWHceDC9+NarqfIv4
	8Jvxb316YSMq1PetooA+YJNE7fEsQNHjHvo6mpIpYBihJmxwZf6oGCFRCQAE=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:30a1:b0:495:f79d:b08e with SMTP id
 5614622812f47-4b210c95cb5mr1192811b6e.21.1786493489363; Tue, 11 Aug 2026
 17:11:29 -0700 (PDT)
Date: Tue, 11 Aug 2026 17:11:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7bba31.3668565d.e8814.0008.GAE@google.com>
Subject: [syzbot] [block?] kernel BUG in folio_unmap_invalidate
From: syzbot <syzbot+c393fb3e3a7a1bfa5927@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a59f57e2aa12 Merge tag 'watchdog-for-v7.2-rc7' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13196fb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=158601bb8cb292dd
dashboard link: https://syzkaller.appspot.com/bug?extid=c393fb3e3a7a1bfa5927
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/52f4874481e5/disk-a59f57e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bb5cb2b16c65/vmlinux-a59f57e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e5cc16a680f1/bzImage-a59f57e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c393fb3e3a7a1bfa5927@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/truncate.c:632!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 13095 Comm: syz.4.2094 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:folio_unmap_invalidate+0x7ee/0x830 mm/truncate.c:632
Code: c6 c0 71 78 8b e8 a2 e9 1d ff 90 0f 0b e8 3a f4 bb ff 48 89 df 48 c7 c6 c0 71 78 8b e8 8b e9 1d ff 90 0f 0b e8 23 f4 bb ff 90 <0f> 0b e8 1b f4 bb ff 48 89 df 48 c7 c6 c0 71 78 8b e8 6c e9 1d ff
RSP: 0018:ffffc900064a7830 EFLAGS: 00010287
RAX: ffffffff8209d53d RBX: ffffea0000b443c0 RCX: 0000000000080000
RDX: ffffc90013401000 RSI: 0000000000038e38 RDI: 0000000000038e39
RBP: ffffea0000b443c8 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff9400016887f R12: 0000000000000001
R13: dffffc0000000000 R14: 1ffffd4000168879 R15: 1ffffd4000168878
FS:  00007f0ec44146c0(0000) GS:ffff888125c46000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0ec3387ff8 CR3: 0000000061190000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 invalidate_inode_pages2_range+0x62c/0xb30 mm/truncate.c:726
 blkdev_direct_write+0x48/0x140 block/fops.c:690
 blkdev_write_iter+0x530/0x700 block/fops.c:765
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61e/0xbb0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0ec61fe0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0ec4414028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f0ec6486180 RCX: 00007f0ec61fe0d9
RDX: 00000000ffffffdb RSI: 0000000000000000 RDI: 0000000000000008
RBP: 00007f0ec6295024 R08: 0000000000000000 R09: 0000000000000000
R13: 00007f0ec6486218 R14: 00007f0ec6486180 R15: 00007ffc8fc250d8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_unmap_invalidate+0x7ee/0x830 mm/truncate.c:632
Code: c6 c0 71 78 8b e8 a2 e9 1d ff 90 0f 0b e8 3a f4 bb ff 48 89 df 48 c7 c6 c0 71 78 8b e8 8b e9 1d ff 90 0f 0b e8 23 f4 bb ff 90 <0f> 0b e8 1b f4 bb ff 48 89 df 48 c7 c6 c0 71 78 8b e8 6c e9 1d ff
RSP: 0018:ffffc900064a7830 EFLAGS: 00010287
RAX: ffffffff8209d53d RBX: ffffea0000b443c0 RCX: 0000000000080000
RDX: ffffc90013401000 RSI: 0000000000038e38 RDI: 0000000000038e39
RBP: ffffea0000b443c8 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff9400016887f R12: 0000000000000001
R13: dffffc0000000000 R14: 1ffffd4000168879 R15: 1ffffd4000168878
FS:  00007f0ec44146c0(0000) GS:ffff888125d46000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c240003 CR3: 0000000061190000 CR4: 00000000003526f0


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
