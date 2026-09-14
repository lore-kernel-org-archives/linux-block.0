Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3803E638D
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417892; cv=none; b=V5ZhL2yv1qmEMR6ssdWBf4ff0o9p2FT/Trb127vW4PBt9z26N8Tjde2wxm5h4LMRyS9XdZwnwW6NHqbhGSFZj/QPxw8UM97OqZb3M7Rh3WkRMtmJC8ps+YE+9aSpRWtVm6XaPHivo5rrOfNtGEXct31q6qe72pCu3A5VU7Re05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417892; c=relaxed/simple;
	bh=6iBzsjoBtWWmoldobUN5bdqzX0y2YES92P8Oizd8Gx4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PPRGYPzBcKCeJ3PUAQQzI6FZ0mecITv5X5XPAXdDzwYWdpt35sIsTwEybJ54LZtSvGfoycAH+CQsX3lX/0jWYz4y10PPvq8FG5H14gShFLBpNNu8rUIVyAxKt21BLCKGXZZTuashP8iEyoXbiD/ZW8CQ7AJE0aaf/lDp1ZkJHQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4b94bb43008so592372b6e.0
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 13:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789417889; x=1790022689;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KOGOHRXCuZUmqt3sI3FJ8F95W8lFaeOExB/dnA01mNU=;
        b=eseiAJetR5VlmqyUY0Ck7cMlZSEIr9WhoKk70s2r1Qb7Rt/qStq3lNdYmDUbAxyuuY
         NaNoFpt7Xb083ZNa7wDkGudYyzdxT2C8p6FSmKXiWvCvEa7SdFbZBbI1orVyNd4eEp4+
         yRlYLK6XGs4xPGqFBhD8/1Ua3Z+ESi/A8f+l0fX0apxJHLYYgjNnzt8LBWYbHnMftcuj
         jTyFhMDjH4/vCiM3lAGj0zqiRMvwlVt+VuAlsi6XMgqrCgdnXOm5fYLeAFhISdZpFTGJ
         5fMM/WcgSHZVv9sZeSFVExza6MRMiiwENgmNwi7DbPsprqMzYKmi4FCxiqAxCeVw8yjS
         7ITg==
X-Forwarded-Encrypted: i=1; AKwUvBwzNn2omrthr5VlfO0W/NpxnyuVYmfEUBW0lIi3KKsVmrMG7DdMtoIxjMHqKEzvPGyMk2fc+0iALMKYDg==@vger.kernel.org
X-Gm-Message-State: AFuF++m5OMhuDtNx2ZNfMugp6L3BmsyaH/LeYx+Z9RdjYTs5l83MB/JS
	fc24/dLWTEypkIpgkKSW8k/95Y90f1NC02aK19VrsTbavFgmnSj1wn4r9y31HQiNjiXUeJJqa0S
	mixV3KTzCC1hcjxI/YMnGCRCKhEy0xTI1UwqvK022nlvHLFfg9HCClvNgTh4=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:17a3:b0:4c3:e93e:e331 with SMTP id
 5614622812f47-4c7b58949d9mr2428088b6e.30.1789417889725; Mon, 14 Sep 2026
 13:31:29 -0700 (PDT)
Date: Mon, 14 Sep 2026 13:31:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa859a1.a211d2ce.1a5198.029b.GAE@google.com>
Subject: [syzbot] [block?] WARNING: zero-size vmalloc in trace_suspend_resume
From: syzbot <syzbot+e3c61afd6e6729cd33dc@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	minchan@kernel.org, senozhatsky@chromium.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0f23d56f17fd Merge tag 'linux_kselftest-next-7.3-rc1' of g..
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux master
console output: https://syzkaller.appspot.com/x/log.txt?x=12e8d615580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78e810c74248bbb
dashboard link: https://syzkaller.appspot.com/bug?extid=e3c61afd6e6729cd33dc
compiler:       arm-linux-gnueabi-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11014925580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140621f9580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98a89b9f34e4/non_bootable_disk-0f23d56f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29f1f81851f8/vmlinux-0f23d56f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d12ab50ae201/zImage-0f23d56f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e3c61afd6e6729cd33dc@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: mm/vmalloc.c:4037 at __vmalloc_node_range_noprof+0x610/0x6a4 mm/vmalloc.c:4037, CPU#0: syz.1.17/4031
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 UID: 0 PID: 4031 Comm: syz.1.17 Not tainted syzkaller #0 PREEMPT 
Hardware name: ARM-Versatile Express
Call trace: 
[<80201998>] (dump_backtrace) from [<80201a8c>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:82a20f78 r6:00000000 r5:82336570 r4:00000001
[<80201a74>] (show_stack) from [<8021ec68>] (__dump_stack lib/dump_stack.c:94 [inline])
[<80201a74>] (show_stack) from [<8021ec68>] (dump_stack_lvl+0x5c/0x70 lib/dump_stack.c:120)
[<8021ec0c>] (dump_stack_lvl) from [<8021ec94>] (dump_stack+0x18/0x1c lib/dump_stack.c:129)
 r7:82a20f78 r6:00000000 r5:839f1880 r4:82c85d40
[<8021ec7c>] (dump_stack) from [<80202590>] (vpanic+0x114/0x320 kernel/panic.c:651)
[<8020247c>] (vpanic) from [<802027d0>] (trace_suspend_resume+0x0/0x100 kernel/panic.c:788)
 r7:805241d4
[<8020279c>] (panic) from [<80251b50>] (check_panic_on_warn kernel/panic.c:525 [inline])
[<8020279c>] (panic) from [<80251b50>] (get_taint+0x0/0x1c kernel/panic.c:520)
 r3:82a0b144 r2:00000001 r1:8231c298 r0:82323c10
[<80251ad8>] (check_panic_on_warn) from [<80251ccc>] (__warn+0x98/0x1a4 kernel/panic.c:1104)
[<80251c34>] (__warn) from [<80251f50>] (warn_slowpath_fmt+0x178/0x1f4 kernel/panic.c:1136)
 r8:00000009 r7:82352930 r6:dfb7dd4c r5:839f1880 r4:00000000
[<80251ddc>] (warn_slowpath_fmt) from [<805241d4>] (__vmalloc_node_range_noprof+0x610/0x6a4 mm/vmalloc.c:4037)
 r10:ffffffff r9:ff800000 r8:00000dc0 r7:00000002 r6:10000000 r5:df800000
 r4:00000000
[<80523bc4>] (__vmalloc_node_range_noprof) from [<805244d0>] (__vmalloc_node_noprof mm/vmalloc.c:4165 [inline])
[<80523bc4>] (__vmalloc_node_range_noprof) from [<805244d0>] (vzalloc_noprof+0x6c/0x74 mm/vmalloc.c:4243)
 r10:84dd6e10 r9:00000000 r8:83970c24 r7:00000002 r6:10000000 r5:83970c00
 r4:00000000
[<80524464>] (vzalloc_noprof) from [<80c2086c>] (zram_meta_alloc drivers/block/zram/zram_drv.c:1990 [inline])
[<80524464>] (vzalloc_noprof) from [<80c2086c>] (disksize_store+0x80/0x1dc drivers/block/zram/zram_drv.c:2880)
 r4:00000000
[<80c207ec>] (disksize_store) from [<80bd68c0>] (dev_attr_store+0x1c/0x28 drivers/base/core.c:2505)
 r10:84dd6e10 r9:00000000 r8:83578478 r7:854dc1c0 r6:81d5b598 r5:80bd68a4
 r4:80c207ec r3:00000002
[<80bd68a4>] (dev_attr_store) from [<8067e3b4>] (sysfs_kf_write+0x70/0x7c fs/sysfs/file.c:145)
 r5:80bd68a4 r4:00000002
[<8067e344>] (sysfs_kf_write) from [<8067c450>] (kernfs_fop_write_iter+0x134/0x214 fs/kernfs/file.c:345)
 r9:00000000 r8:00000000 r7:dfb7df08 r6:84dd6e00 r5:00000002 r4:854dc1c0
[<8067c31c>] (kernfs_fop_write_iter) from [<805a1390>] (new_sync_write fs/read_write.c:595 [inline])
[<8067c31c>] (kernfs_fop_write_iter) from [<805a1390>] (vfs_write fs/read_write.c:687 [inline])
[<8067c31c>] (kernfs_fop_write_iter) from [<805a1390>] (vfs_write+0x27c/0x42c fs/read_write.c:667)
 r10:81c2d60c r9:839f1880 r8:8067c31c r7:dfb7df68 r6:20000140 r5:8602aa00
 r4:00000002
[<805a1114>] (vfs_write) from [<805a16b4>] (ksys_write+0x74/0xec fs/read_write.c:739)
 r10:00000004 r9:839f1880 r8:8020029c r7:00000000 r6:00000000 r5:8602aa00
 r4:8602aa00
[<805a1640>] (ksys_write) from [<805a173c>] (__do_sys_write fs/read_write.c:750 [inline])
[<805a1640>] (ksys_write) from [<805a173c>] (sys_write+0x10/0x14 fs/read_write.c:747)
 r7:00000004 r6:00356310 r5:00000000 r4:00000000
[<805a172c>] (sys_write) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:67)
Exception stack(0xdfb7dfa8 to 0xdfb7dff0)
dfa0:                   00000000 00000000 00000003 20000140 00000002 00000000
dfc0: 00000000 00000000 00356310 00000004 003562d8 00000000 00000008 00000000
dfe0: 7eb777a0 7eb77790 00018fa0 00130a50
Rebooting in 86400 seconds..


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
