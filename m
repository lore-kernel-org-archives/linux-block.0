Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044CB1429B
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716869427; cv=none; b=I1gZB9nFQ85fvoc6XaUABaYSFU3h556y+FoWbt1FlaC8JtNqdgOdsKhSLT+Fi8M8FokBQPwNubOSHZK6Mt6DjUZRE/DxzKFbGdJD2+DvJhwyeIS0X0m3McUZlyccJBTodHNO3Hlagd+6rngOQNIybVXgnKIZiY/gBpijP8uqcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716869427; c=relaxed/simple;
	bh=0cvZepUIvNJXoV7lW6K9xAhU2kcSdcBqVcvBUB6Iwh0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QMbLXr6Hlf19kLUgRuh7jD/DybFmoiBHxkpTG4A8xSCsCWe4DjzkYPYs8KV3uFv44ySwtwEiIDQjEpbjc9qNpJ+3OKuORIYaOFJvn6TDlskh8t09Lg4JWRLIelzGBKELgYo6gzYosChqUPn5iv2nvCimA4HxM9v7EucYCv0Vq7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e94cac3c71so50503339f.2
        for <linux-block@vger.kernel.org>; Mon, 27 May 2024 21:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716869425; x=1717474225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nOHnGS86ObooVRSXIaAI7W3Fp4Nqiw6Bm7kqUuJil0=;
        b=C4a48XrjeFHXm+YHMX8J45bHhHW95gUuIbwGk0SgLfTXQ+02HIbNXJJNxNRWF+PWpd
         NoP9VcNruS28HzYUgq4TIm/Okx7PHkNP/h0ZMLS/+/S6RrMy9B1CjYSFEz9ibt1/NIsr
         QGf2sls38HZf4j2rZUaTptBhEFnwewSZ5b7HodnZ8K3lCticdl3Td+47EAG8++9h7u2u
         NW01D+k+/feLTYigrcWJMnq7vAOnMySBsk2Eke7cG9SjVIXKVVP6EHgncmuXMXqajDZ/
         W7O+mEnI1mOU4w0lR+V9yVjqwXOcBIlvPrLztUmCDWz/p1+eSiOUPLjOaf/hQEOV6kD5
         xpcA==
X-Forwarded-Encrypted: i=1; AJvYcCWT/yHXp95Ga6Vu90LB+xTy097HNhLBNbhmlmlfYv7bmUjm3dddu03eihE9yJLIZzYoqHAV/HByacjvYt9ll285kMgcdm9fbvuipSI=
X-Gm-Message-State: AOJu0YxmQeV1vHMx7UC4pTqD0xzRnBMBwYqceD3JNqwF8cZ9EfJvrMnf
	aH82sU5Djm+sLtAZ2n0PuBcE1B59IZ7wsg8Ucgy3QdCWl+oiK8BAMPyhosiIkKtUF6MO5P+h5w0
	B1ZrAKUffYiXv4KoPToaACf1vWNvlZtEwxmpcVfaFYlbvOOolsX74LGc=
X-Google-Smtp-Source: AGHT+IF/wjHJpGze8sQyAJ3okRfBV5NbehwLwnkkI/fPSgAOr804e4B/PiigRWuLxgBbCsnIMcuMIdunbN2ytB0L5cDV1+q3FO6x
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0d:0:b0:36c:4b17:e05d with SMTP id
 e9e14a558f8ab-3737b3fe339mr10509935ab.4.1716869425110; Mon, 27 May 2024
 21:10:25 -0700 (PDT)
Date: Mon, 27 May 2024 21:10:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035b2ce06197bd027@google.com>
Subject: [syzbot] [block?] INFO: task hung in bdev_open
From: syzbot <syzbot+5c6179f2c4f1e111df11@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6fbf71854e2d Merge tag 'perf-tools-fixes-for-v6.10-1-2024-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b4942c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee7b962709a5f5a5
dashboard link: https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/91effa72f285/disk-6fbf7185.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c6afe2efff99/vmlinux-6fbf7185.xz
kernel image: https://storage.googleapis.com/syzbot-assets/46aae93f5511/bzImage-6fbf7185.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c6179f2c4f1e111df11@syzkaller.appspotmail.com

INFO: task udevd:16174 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-12400-g6fbf71854e2d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:23920 pid:16174 tgid:16174 ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 bdev_open+0xe5/0xc60 block/bdev.c:897
 blkdev_open+0x20d/0x2e0 block/fops.c:615
 do_dentry_open+0x95a/0x1720 fs/open.c:955
 do_open fs/namei.c:3650 [inline]
 path_openat+0x289f/0x3280 fs/namei.c:3807
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7f09b169a4
RSP: 002b:00007fffaaf9cc90 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055bf84d3cdb0 RCX: 00007f7f09b169a4
RDX: 00000000000a0800 RSI: 000055bf84d19770 RDI: 00000000ffffff9c
RBP: 000055bf84d19770 R08: 0000000000000001 R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
R13: 000055bf84d2b2c0 R14: 0000000000000001 R15: 000055bf84d18910
 </TASK>
INFO: task syz-executor.1:16345 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-12400-g6fbf71854e2d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:21168 pid:16345 tgid:16344 ppid:15599  flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 bdev_release+0x184/0x700 block/bdev.c:1080
 blkdev_release+0x15/0x20 block/fops.c:623
 __fput+0x406/0x8b0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 get_signal+0x15e6/0x1740 kernel/signal.c:2681
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f297527cee9
RSP: 002b:00007f297608b0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f29753abf80 RCX: 00007f297527cee9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000006
RBP: 00007f29752c949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f29753abf80 R15: 00007ffd34ac6de8
 </TASK>
INFO: task syz-executor.1:16353 blocked for more than 144 seconds.
      Not tainted 6.9.0-syzkaller-12400-g6fbf71854e2d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:18712 pid:16353 tgid:16344 ppid:15599  flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745


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
