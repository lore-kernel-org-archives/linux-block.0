Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809515E5DC
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503710; cv=none; b=CQQ3sn11cwW8mlFMCDLB9S0d+Np9dqwLncbaAaeb4B7f1n4CBB0nSZWI1qMWGjqglcxvImbSttrkdieOX219Z3sLFX5kSfHlITHksEOLgug/zV20L9M0vvZVkuiknpvskyZkD/B9aqqBhXCGtUujkSylgonBPmd2fqNGSFHQEro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503710; c=relaxed/simple;
	bh=GIcJyjVE9QXvNyMLGN5MR/9NOdLBqq5K6m1VPsn9ZXc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Nf1TrKSV72K39LTwOoRblTFj3zhr5MacinlCSKFlcx0WQbZ6W4Ftrd5WNJz13YmN5ACm3rbi315uAzertDN+U2FXCH6D+7iuZN4El/tjeDPjmACtjBiDHOskd067deq3I9eQnGEPW10P7J5SMmXG3rIbRva7r7Fi6HfChuAiTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d81bc8ebc8so11628205ab.2
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 07:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745503708; x=1746108508;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7RhSriLOhs53nUa6Jt3KOnRleTlrCpK0HB+OykHogjo=;
        b=UJhlUqhfB7nR8m5DdfJesH+qeFbPsKrGIJLCcllkjN3ybKOZEy2mafiUKDlPtzt6O5
         DNPLMXzE6gPBTirZd/hFIlPoE3MaGpDKE1ed7dBWvmtIFYANwgii/a8SkTBGH2YRifnh
         Diy7UNYKpuCAR1JBfdv2JxddAhQh+4nFD7KQYo4o+QiEVe2eaDiCbBYF07Yqy/ivPYjF
         ay5Iu+6+r6cVLUj+j/P0rQqXufcf/jyxRHAYuAe2Opp8YWfmorH2RDG4ptQJajljZ9bj
         7rXSqR1ZUF6uuXq4AC/vDdHTLLQfSjH2S/msoO8Rz46VTDzdmNm59n/0mXySNqOgaRvu
         UmzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL+L1pN/oD9fUiznof0IogzMxjibtZB5hhuwVxk/SIgISQs2o5B//kyPozXu0z3f4SFzaRckCIwhzW6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcEyLKk2sPWqXluTyyuHPrrmG7gbtx++utN+s9jAbfMOtJB8hM
	BjFgOA6O3Et45Oasa7724VT+qGX/anotgsamqjQ8u/0OAJFgcCGqQ9VcltU8UlcIuulRyJhLsQn
	HnagwZxs6YkgjSvYnT9VbDkpycDAeOOLfUcIWXCxke3kyZC8URhW7ZtA=
X-Google-Smtp-Source: AGHT+IGglOtcgTfuSuz1kG93dSZbd7GhY7gT/KZdoUcGNi8rweM0oC2rNNcXPLD2qftLJ0fW7E6Qc50+E94hdBUSv6dSGhHznJCI
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188f:b0:3d6:cbed:330c with SMTP id
 e9e14a558f8ab-3d9303b7774mr26950505ab.11.1745503707896; Thu, 24 Apr 2025
 07:08:27 -0700 (PDT)
Date: Thu, 24 Apr 2025 07:08:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680a45db.050a0220.10d98e.000a.GAE@google.com>
Subject: [syzbot] [block?] BUG: unable to handle kernel NULL pointer
 dereference in lo_rw_aio
From: syzbot <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    119009db2674 Merge tag 'vfs-6.15-rc3.fixes.2' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c93fe4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a7c679f880028f0
dashboard link: https://syzkaller.appspot.com/bug?extid=6af973a3b8dfd2faefdc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179aeccc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100b5b98580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-119009db.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1cd1adb50b98/vmlinux-119009db.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d1e790c57be7/bzImage-119009db.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 0 P4D 0 
Oops: Oops: 0010 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 12 Comm: kworker/u32:0 Not tainted 6.15.0-rc2-syzkaller-00471-g119009db2674 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: loop8 loop_rootcg_workfn
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc900000f7a38 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffff8beceec0 RCX: ffffffff86084265
RDX: 1ffffffff17d9ddd RSI: ffffc900000f7b28 RDI: ffff8880261b3128
RBP: ffff8880261b3128 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000002be0 R12: ffffc900000f7b28
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880d69b2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000000e180000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lo_rw_aio.isra.0+0x9c2/0xd90 drivers/block/loop.c:393
 do_req_filebacked drivers/block/loop.c:424 [inline]
 loop_handle_cmd drivers/block/loop.c:1866 [inline]
 loop_process_work+0x8a4/0x10d0 drivers/block/loop.c:1901
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc900000f7a38 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffff8beceec0 RCX: ffffffff86084265
RDX: 1ffffffff17d9ddd RSI: ffffc900000f7b28 RDI: ffff8880261b3128
RBP: ffff8880261b3128 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000002be0 R12: ffffc900000f7b28
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880d69b2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000000e180000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
