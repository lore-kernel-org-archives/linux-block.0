Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5831357333
	for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732518501; cv=none; b=aZ93W4EQKAes2ZfuzMGfD3oAqVpmeJyqwE06jI8E2dAOQV/1B6csfU092+4DRXsiPsMR4e8RPWY8ktKtn5ANvV1Pxh+l0JHXicG/gqNHjTa1Ubh3yjFdzfJdcvoFhnj+aIKISrmQYSPJ74dz1o+DLLnZhKU8O1qcoFHOhYMmvp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732518501; c=relaxed/simple;
	bh=uovbhN0h5wmGp3X54El5E7O5cQUynFtfCbFTv4NMyB0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZsjKBCY3oObOgIotmiIZT1WgUBhJFFmJLwqp2YxFbYHEUr/5rRK0dCqwBkdvrAnqIYUr+t6/jhFqSzfCUh8VsmjZAClR/7KCVTrDieJvE4Y1zQZk2dAMZmW5dLIcX08vyaExqtSMqZKWEmJ+2R9Jzw0VCzyNYGvkqvu8NH4ZhsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83ab1b39ab1so452533939f.1
        for <linux-block@vger.kernel.org>; Sun, 24 Nov 2024 23:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732518499; x=1733123299;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lquap6AA6m8MW2dZ+Jiu4ZVxZhVJ4eTZMk/svFmEns0=;
        b=kbNK8xiRehz1XKS1zxmR0yY4YLvlBimNjs13Z95p/B0gCAn4RE5tvjC/0Ohr2eN61Q
         9KbgD1TTdlwx1eoZrIh4Pbgi6vvZfxEwuHQyEVHn1SLkmaB75icubCdrGzaSg9pzt/aY
         HqhneY6ri7fH0GNLAybOczqbabsxndIZMTZcq+Q8UZG+tMtbuFExkA16oOeWPUO0XcIN
         UJyu5OXiPsA4SxiKz0vD0QxWIE1h/FEQQEgjz+Au+szDTI+d9KZy7WS+wiGB0b8JQqBu
         Y5jHDfUqO0xH/9ziQm/61WGKpWEJrXHjlkOQFMVTvV8J5swGIFjhMX3OUqG19i9/nhiZ
         ARoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcvaAkJb+JCRcAR1/1ZUQvzQSWsrCYjPkstKUJi4hzzNkYxegETQUAmY30VF1f9CZmJrAvm0ZnRWcdzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8rRZQrwXqD8gdaD195Xxh8Q0YoPqoPhXl/CiZLp3K1BsPl5Ri
	S65ziNYxwpN5IJQlyLKuHa8+EvF1Kx5xOAJCajl6ZvAgbha/m6T8fqkEoX6kPUN8o7wA3pKBUDQ
	VlviVHkSFN9Bt8inrfyvMQfHcShLc5F/iyquJZwsu6FrprmJrkC7uAY0=
X-Google-Smtp-Source: AGHT+IHdktSUN4/+FNfvRkzu8ERVZPJvMp50MUMJOasVFUQv4vqBIbXfhsQ0e7h8RMVIBX6InJtQGDGY5SSMy8RbUpJl4VzS3hP9
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:3a7:8270:3e69 with SMTP id
 e9e14a558f8ab-3a79af75f7fmr129703515ab.15.1732518499499; Sun, 24 Nov 2024
 23:08:19 -0800 (PST)
Date: Sun, 24 Nov 2024 23:08:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67442263.050a0220.1cc393.0069.GAE@google.com>
Subject: [syzbot] [block?] WARNING in dd_exit_sched
From: syzbot <syzbot+f53c29806b4b263165f3@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    43fb83c17ba2 Merge tag 'soc-arm-6.13' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12280ec0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e796b1bf154f93a7
dashboard link: https://syzkaller.appspot.com/bug?extid=f53c29806b4b263165f3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cdcbc016316b/disk-43fb83c1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f82505daa7c2/vmlinux-43fb83c1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/74b0b41d70c6/bzImage-43fb83c1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f53c29806b4b263165f3@syzkaller.appspotmail.com

------------[ cut here ]------------
statistics for priority 0: i 8 m 0 d 8 c 0
WARNING: CPU: 0 PID: 7130 at block/mq-deadline.c:562 dd_exit_sched+0x2a8/0x3a0 block/mq-deadline.c:559
Modules linked in:
CPU: 0 UID: 0 PID: 7130 Comm: kworker/u8:10 Not tainted 6.12.0-syzkaller-03657-g43fb83c17ba2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: nbd-del nbd_dev_remove_work
RIP: 0010:dd_exit_sched+0x2a8/0x3a0 block/mq-deadline.c:559
Code: b6 44 25 00 84 c0 0f 85 dd 00 00 00 44 8b 0b 48 c7 c7 00 3a 5f 8c 8b 74 24 04 8b 54 24 08 44 89 f9 45 89 e8 e8 c9 af b2 fc 90 <0f> 0b 90 90 e9 03 ff ff ff 48 c7 c1 60 e7 1c 90 80 e1 07 80 c1 03
RSP: 0018:ffffc90004247910 EFLAGS: 00010246
RAX: 83929aab89e5bc00 RBX: ffff888024eb5c5c RCX: ffff888027a51e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 1ffff110049d6b8b R08: ffffffff8155f352 R09: fffffbfff1cfa88c
R10: dffffc0000000000 R11: fffffbfff1cfa88c R12: dffffc0000000000
R13: 0000000000000008 R14: ffff888024eb5c00 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe1d01f3f98 CR3: 0000000073672000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 blk_mq_exit_sched+0x2ce/0x4a0 block/blk-mq-sched.c:547
 elevator_exit+0x5e/0x80 block/elevator.c:159
 del_gendisk+0x7a8/0x930 block/genhd.c:735
 nbd_dev_remove drivers/block/nbd.c:264 [inline]
 nbd_dev_remove_work+0x47/0xe0 drivers/block/nbd.c:280
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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
