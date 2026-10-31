Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793438804;
	b=CFlx+ZSrxz4CvIKgGquHbBN7P37Y9IG1eRbOVoj9IuBeGwr3Qaqp+acordMbWE+3i8Vp
	 RewYD/8QV8GfqWTyxVooNfGTYFYhrzkvRgOxXi/p3KayvuF1S/c/o5qu1yphy/3h/p/ee
	 PAx76f6/sJ7P8ediin1ln7iwKDI5nuYzps2YSr+ANCDmTITZLT2NeaTq/BlW5T3ikN78e
	 1+u59spwQiMQKN3uO2FdP2oCB00thVpiw0wvhnMSOHNNqYkvJUjk/iXdKtc+FD2wqbUO0
	 00BQpGgm5h0mmqXWhnNPCgPL3HLBAVXEcK9IUBTL+CHGuq5qK9g5GepKM7JKwGnOF0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793438804;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=lYUXLDsuH0kOjSZHyOASfKtU+4hD7I+9skjy+tMb1e0=;
	b=wBCIZfQlc/Sby8hkFaNbj7h3zev/fWHqZXaUcJgJxVUIcgr1lDUrVL7pDuKTxe/yEKEt
	 C4qYzp5FS2s1E5SxXsynieQz0zokXxKoK4Kil/5jvey+M1/waOhibEeDH0J21cSPz3hUm
	 evsYYkN7kwlsUu8a1u7UkF37BPRJkeDawSkqXhVRWdr+PMYf29dADruj/SYp48rwqPf7F
	 iSk4rs794e3MQV4/aXf/UaAuFuf8/2l41ZpcnKaDAbF/niznH670sjHyIjqQ8iwB7/D0d
	 fKGwMipLBxFGC0McvMBRDlY6g/LiHTXIRgV2peIc+9PHghN5GngxN5NpAePQAkxjNrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.69
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0809606A31D
	for <linux-block@vger.kernel.org>; Sat, 31 Oct 2026 09:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0809606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-85c6a056128so1527717a34.3
        for <linux-block@vger.kernel.org>; Sat, 31 Oct 2026 02:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793438803; x=1794043603;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lYUXLDsuH0kOjSZHyOASfKtU+4hD7I+9skjy+tMb1e0=;
        b=JzuGKL0cECvFPwwWo3+UYQc2LGP3WGnu34N/S1A2U8llPt8FhCOUZuCyj2t+709MLc
         xpAL9cX++ZFZ6VTSuHDxWnVYBI1J3QlJNF6DFxoQFhPnkd7dwFr5+J+dAKeHXPQWXQXf
         FfdS70cRAkHsrVJbiJ+nIQQr0Q2iPw9Mg8YfWVQIbUXeNWssHlpTg8YapQtr6ojqAYik
         02l45Aa3CUJWwMYT1wPQCjAnG3VcigqqgkToOsNged0w92/pjYS4c/BeHF0K88Jv1vTF
         KfobdAtAaWco0CIfPRQlVvaPMZjS/crzUYzw9tWp39az+3P35XDv0Rw6f6xqY7GuhPIG
         Xo9w==
X-Gm-Message-State: AFq9FYK8CMrTdMVcmhr/uA8ZiocBh0eX2hg11IEyntjD7VCICqAFVDPG
	tfKmGEYSFwDWBEcqFUvENIaUuK5VJfOskSRgjS8XNOIo0+L7Qesh19zUrNZcw1eX6wklxHzKUql
	L3P3odVtLmxacHbcAxIKI5K7s+l9qwHz/n4V1Z+7c6AAT1NqeW8DkuYJCkJk=
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6718:b0:557:308a:9e9a with SMTP id
 5614622812f47-5640dcfd646mr3138139b6e.21.1793438802958; Sat, 31 Oct 2026
 02:26:42 -0700 (PDT)
Date: Sat, 31 Oct 2026 02:26:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae5b452.88e51036.1515fd.0004.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in md_alloc
From: syzbot <syzbot+cd254889291ef8666036@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a39c95080621 Add linux-next specific files for 20261029
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1406117f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=82467d52d846ff27
dashboard link: https://syzkaller.appspot.com/bug?extid=cd254889291ef8666036
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16477d31580000

AI-generated root cause summary:
A circular locking dependency exists between major_names_lock, md's internal
disks_mutex, and mddev->reconfig_mutex. In blk_probe_dev(), major_names_lock is
held while invoking the driver's autoload probe callback md_probe(), which calls
md_alloc() and acquires disks_mutex followed by mddev->reconfig_mutex.
Concurrently, md ioctls (such as ADD_NEW_DISK) hold mddev->reconfig_mutex while
calling bdev_file_open_by_dev(), which triggers block device autoloading and
attempts to acquire major_names_lock via blk_request_module() / blk_probe_dev(),
resulting in a potential ABBA deadlock.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=cd254889291ef8666036

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cd254889291ef8666036@syzkaller.appspotmail.com

md: could not open device unknown-block(8,200).
md: error, md_import_device() returned -6
md: could not open device unknown-block(8,250).
md: error, md_import_device() returned -6
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz-executor140/6002 is trying to acquire lock:
ffffffff91329200 (disks_mutex){+.+.}-{4:4}, at: md_alloc+0x40/0xf40 drivers/md/md.c:6355

but task is already holding lock:
ffffffff9096c060 (major_names_lock){+.+.}-{4:4}, at: blk_probe_dev block/genhd.c:885 [inline]
ffffffff9096c060 (major_names_lock){+.+.}-{4:4}, at: blk_request_module+0x35/0x2a0 block/genhd.c:901

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (major_names_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       blk_probe_dev block/genhd.c:885 [inline]
       blk_request_module+0x35/0x2a0 block/genhd.c:901
       blkdev_get_no_open+0x3f/0xe0 block/bdev.c:870
       bdev_file_open_by_dev+0xa0/0x240 block/bdev.c:1091
       md_import_device+0x2e9/0x650 drivers/md/md.c:3861
       md_add_new_disk+0x522/0x1850 drivers/md/md.c:7681
       md_ioctl+0x2027/0x2630 drivers/md/md.c:8525
       blkdev_ioctl+0x5e3/0x740 block/ioctl.c:798
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&mddev->reconfig_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       mddev_lock_nointr drivers/md/md.h:734 [inline]
       md_alloc+0x81e/0xf40 drivers/md/md.c:6413
       md_alloc_and_put+0x1a/0x1f0 drivers/md/md.c:6452
       add_named_array+0x240/0x350 drivers/md/md.c:-1
       param_attr_store+0x214/0x310 kernel/params.c:591
       module_attr_store+0x65/0x90 kernel/params.c:906
       kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x612/0xba0 fs/read_write.c:687
       ksys_write+0x150/0x270 fs/read_write.c:1036
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (disks_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3209 [inline]
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       md_alloc+0x40/0xf40 drivers/md/md.c:6355
       md_alloc_and_put+0x1a/0x1f0 drivers/md/md.c:6452
       blk_probe_dev block/genhd.c:888 [inline]
       blk_request_module+0x27d/0x2a0 block/genhd.c:-1
       blkdev_get_no_open+0x3f/0xe0 block/bdev.c:870
       blkdev_open+0x1d7/0x600 block/fops.c:678
       do_dentry_open+0x80e/0x1360 fs/open.c:1000
       vfs_open_consume+0x4a/0x350 fs/open.c:1131
       do_open fs/namei.c:4845 [inline]
       path_openat+0x16fc/0x20f0 fs/namei.c:5010
       do_file_open+0x23e/0x4a0 fs/namei.c:5039
       do_sys_openat2+0x115/0x200 fs/open.c:1442
       do_sys_open fs/open.c:1448 [inline]
       __do_sys_openat fs/open.c:1788 [inline]
       __se_sys_openat fs/open.c:1783 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1783
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  disks_mutex --> &mddev->reconfig_mutex --> major_names_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(major_names_lock);
                               lock(&mddev->reconfig_mutex);
                               lock(major_names_lock);
  lock(disks_mutex);

 *** DEADLOCK ***

locks held by syz-executor140/6002: 1, last CPU#1:
 #0: ffffffff9096c060 (major_names_lock){+.+.}-{4:4}, at: blk_probe_dev block/genhd.c:885 [inline]
 #0: ffffffff9096c060 (major_names_lock){+.+.}-{4:4}, at: blk_request_module+0x35/0x2a0 block/genhd.c:901

stack backtrace:
CPU: 1 UID: 0 PID: 6002 Comm: syz-executor140 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2087
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2219
 check_prev_add kernel/locking/lockdep.c:3209 [inline]
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
 md_alloc+0x40/0xf40 drivers/md/md.c:6355
 md_alloc_and_put+0x1a/0x1f0 drivers/md/md.c:6452
 blk_probe_dev block/genhd.c:888 [inline]
 blk_request_module+0x27d/0x2a0 block/genhd.c:-1
 blkdev_get_no_open+0x3f/0xe0 block/bdev.c:870
 blkdev_open+0x1d7/0x600 block/fops.c:678
 do_dentry_open+0x80e/0x1360 fs/open.c:1000
 vfs_open_consume+0x4a/0x350 fs/open.c:1131
 do_open fs/namei.c:4845 [inline]
 path_openat+0x16fc/0x20f0 fs/namei.c:5010
 do_file_open+0x23e/0x4a0 fs/namei.c:5039
 do_sys_openat2+0x115/0x200 fs/open.c:1442
 do_sys_open fs/open.c:1448 [inline]
 __do_sys_openat fs/open.c:1788 [inline]
 __se_sys_openat fs/open.c:1783 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1783
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9cb93efb37
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffd0a7a14d0 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055558698d400 RCX: 00007f9cb93efb37
RDX: 0000000000000002 RSI: 00007ffd0a7a15f0 RDI: ffffffffffffff9c
RBP: 00007ffd0a7a15b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd0a7a15f0
R13: 00000000ffffffff R14: 00007f9cb942909a R15: 0000000000000002
 </TASK>
md: async del_gendisk mode will be removed in future, please upgrade to mdadm-4.5+
block device autoloading is deprecated and will be removed.
md: async del_gendisk mode will be removed in future, please upgrade to mdadm-4.5+
block device autoloading is deprecated and will be removed.


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
