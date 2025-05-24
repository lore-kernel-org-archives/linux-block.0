Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E251E3234
	for <linux-block@vger.kernel.org>; Sat, 24 May 2025 01:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748051553; cv=none; b=R+7pWio7clbceLONgiuEX1s32OQd817oNXAmKVLfY1alzdbS4mr5hcB0zA7nrxsnCw/6Co47LIphKtedlR007V3IwP9XA4Yc7MJlS2YOSeJm+/SPiabai5JvqBUAaJXqaoWHcWwH6xaPH9eVsvlAWPEc5oMFFmm8+yIjty4aSLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748051553; c=relaxed/simple;
	bh=SIrbXMA2jngYiDdg3SOaWcko+lqHbPrQf8IMMmTLPPs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hqbfAvvBz0Vk+mjBXV8eCtgyPTnR/Q1zQwxQWUdbNY0Ll4uvV8Hb4FIfm45sA92V8SMiRQHjZ392pwXJpIoQwcvQLQnLbg8Q7KMua4Y4xE8vO4LHaaIRsusmGXiWNqUNCXyVkqSSL87Sq0SqvaqeMd8jdvQv6JQp460ET+TiH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-86465e3f1c6so136693439f.1
        for <linux-block@vger.kernel.org>; Fri, 23 May 2025 18:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748051551; x=1748656351;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qPo2k/B3eiqsxwoXP1WPRx2t6rR6+uFWaX3ght3GZwk=;
        b=iLOtYP5JczGRWw7pIy8UOEOFY826q8UWdUA53SMl5GP2+ByoMqjKtw0ohYjUsULy+4
         D2r7L1V6GbJ9zKrfKHjYCJoNqx/XGOn6qcgjW+kPOPJ0aU4M363KBpyZpJ158CEru9aA
         g2Zi8jSFxQaV9kKullevNwlajxZ9EdkQkahZz78SwRAYodImFTQOGcaz3hi+FucZeCmV
         WWUdszs9hccNFJNoJzdEkZWf4mP1O/vuM7vtNB9LkERLUSeVXGl53irw0JcgHIbJF6R5
         HGGqlKIjEtS1bEs/VUmkok55wlbXBPJC/ol8y7qCw3aCBuRB9Pa2AOwL0urBLUbNmF5Q
         ydvw==
X-Forwarded-Encrypted: i=1; AJvYcCVhwzdOQ4KMJPGoEASOQ5VdBpKN1bq4a+9EZO44I3PCz6zWdDRXFG335qZNLFZtBTMXAaeLB2MI/edUsg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+76UZOQJQEGh5VehW+V8G+x6dRUGP+8WqHsS8Dmugya7/cjx
	o4jQO34f+spO4fC0KKSDOTCvNhaIQyxerTaWspEZSgEQmqDAarxsmMwUeO4Eualqu6IBmns1NLK
	IS+DGdrh6kD76JnqGqCclZCTTMBD/yg5MCfSnIqv5E3InpXkmQ7VPbwoV+9c=
X-Google-Smtp-Source: AGHT+IHWcnczVi5pwcKkKiUuet6e+nNcoWIn05PWhJ/1xy7Nx9lwkprR04CdTce9jtUr6yGRQ6yblgY7qQE4jMNgOLQ6Qliz840J
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:36c5:b0:864:a1fe:1e4a with SMTP id
 ca18e2360f4ac-86cbb697f0cmr186686139f.3.1748051551008; Fri, 23 May 2025
 18:52:31 -0700 (PDT)
Date: Fri, 23 May 2025 18:52:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6831265e.a70a0220.29d4a0.07f0.GAE@google.com>
Subject: [syzbot] [block?] [bcachefs?] kernel BUG in blk_mq_end_request
From: syzbot <syzbot+a8f903ba15921696861d@syzkaller.appspotmail.com>
To: axboe@kernel.dk, kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5806cd506af Linux 6.15-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=131bde70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1de0d8596cea805
dashboard link: https://syzkaller.appspot.com/bug?extid=a8f903ba15921696861d
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bb32d4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142351f4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d72f8f4a220d/disk-a5806cd5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6567d0e5a4d8/vmlinux-a5806cd5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66e79750c483/bzImage-a5806cd5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7fdb68bab5ea/mount_0.gz

The issue was bisected to:

commit f5095b9f85a1674a92d00e7ab466499a8ba49ce1
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Tue Jan 2 00:42:37 2024 +0000

    bcachefs: dev_usage updated by new accounting

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14897e70580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16897e70580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12897e70580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a8f903ba15921696861d@syzkaller.appspotmail.com
Fixes: f5095b9f85a1 ("bcachefs: dev_usage updated by new accounting")

------------[ cut here ]------------
kernel BUG at block/blk-mq.c:1146!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.15.0-rc7-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:blk_mq_end_request+0x6c/0x70 block/blk-mq.c:1146
Code: e8 79 f1 2b fd 48 89 df 89 ee 5b 5d e9 bd f9 ff ff 89 f9 80 e1 07 80 c1 03 38 c1 7c ce e8 ec c5 8b fd eb c7 e8 55 f1 2b fd 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
RSP: 0018:ffffc90000147bb8 EFLAGS: 00010246
RAX: ffffffff8493ff8b RBX: ffff8880242d1200 RCX: ffff88801c6d3c00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88801c6d3c00 R09: 0000000000000003
R10: 0000000000000009 R11: 0000000000000100 R12: dffffc0000000000
R13: 0000000000000005 R14: ffff8880242d1200 R15: ffffffff8be81688
FS:  0000000000000000(0000) GS:ffff8881260f6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007cdd8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blk_complete_reqs block/blk-mq.c:1220 [inline]
 blk_done_softirq+0x10a/0x160 block/blk-mq.c:1225
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:164
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:blk_mq_end_request+0x6c/0x70 block/blk-mq.c:1146
Code: e8 79 f1 2b fd 48 89 df 89 ee 5b 5d e9 bd f9 ff ff 89 f9 80 e1 07 80 c1 03 38 c1 7c ce e8 ec c5 8b fd eb c7 e8 55 f1 2b fd 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
RSP: 0018:ffffc90000147bb8 EFLAGS: 00010246
RAX: ffffffff8493ff8b RBX: ffff8880242d1200 RCX: ffff88801c6d3c00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88801c6d3c00 R09: 0000000000000003
R10: 0000000000000009 R11: 0000000000000100 R12: dffffc0000000000
R13: 0000000000000005 R14: ffff8880242d1200 R15: ffffffff8be81688
FS:  0000000000000000(0000) GS:ffff8881260f6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007cdd8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
