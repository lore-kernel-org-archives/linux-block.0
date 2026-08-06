Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02134534BB
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030663; cv=none; b=Y11jZYaycAsIZ+0BOoOks0z7XAmAjPlnjglrtXXMShkdMiCSaTjewuUTw3RCUTMCTNMoe5XKZn5bOIRHm6ztthrkCm2h+GCzvtE1rT78EZv7Vcgzt6H0zp4Aj2rCT1Y6laltax3XkKeCnC3+uIBRM45ORERJ7AOpAUXoRt8RIvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030663; c=relaxed/simple;
	bh=MffesvM7jvFVl3L/BamvFxLIxRh1iHJ5ehPhlDsZSt4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Yix1Lv6kPz/SAk+O11upYlepluUa2ZfkVDRBPiuu1e3lUDPbFGJ92Z0UOdfUmr2NAeadS9KXfB05GdFYPJEd/mcO+hE7+OL0fSsr9tbChZazwVoEVBJa3tppqD5Tc7wAVMK0UA0748kLmIjwNYXpIqbQiM6mP//rkAhWHfY3o78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7eb641eaf5eso2780894a34.1
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 08:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786030660; x=1786635460;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mB3cGAbtAxO/DIvXJPbKeIDfIPyvqIf49CZie7ZgwzU=;
        b=MTcptMkELjwtuPHlipkDU2Cx9FZverZEV4H9zNNlDvYq0x6nKr/XPXwD18irOQW0gy
         D8/GZREz6um7KbrM4tZq9On9s62mOhvBIk9Bay8FBTvbrL27/bLOaF4fLHZtzDyzEajn
         lQs2aNKETdki9UEuGGopJGZv99SqmwUNd05e9byr89KlULuaUvPOuZ0SkSU+53tPiaqx
         Or4ZPRF4XOabaS+59VQSnmlG+5EPUtSgwSP65/zooDRB4/pGOBPXXSz8T6EuJDy+qkZr
         AXAG69F8PUiQbhxWX2oqUUSs5AbzzL/YfRxtgZNf7GHcTEG4SmB76zxq50c/PEt4U9fi
         7UaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rozb9LBRXC3eBM0s/onbEWXo8mY2m2fX+ixG5Ui0EE5Kf1JYc5fI1j+0iDND4gnMQ0LUUyA84xLqI78CQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjs+0Ntfnprvsol3AavumMp2Va5Kw31hl8rNtpHs00rRyHzFPH
	VWAYMK2CHxOJ/wQZVwVffRVJBe5IEVtu++5Ub9MZST0tzBlRdMYHOgNzydJMlVxhsejA3GpEkOL
	TPC94ArVlWZCZ8exsovhsTcYG0YLGpnXx/RbTot4rSXCqKCoogYV5LyP7rCA=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f06:b0:69e:41d8:f7e8 with SMTP id
 006d021491bc7-6b0211b2633mr1223517eaf.7.1786030660575; Thu, 06 Aug 2026
 08:37:40 -0700 (PDT)
Date: Thu, 06 Aug 2026 08:37:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a74aa44.01d0871a.3a0d52.0028.GAE@google.com>
Subject: [syzbot] [block?] UBSAN: shift-out-of-bounds in null_process_zoned_cmd
From: syzbot <syzbot+abd6a8dca0f2b7726060@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c21bb4193868 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1218ecc6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e38b15c29e6a1d9
dashboard link: https://syzkaller.appspot.com/bug?extid=abd6a8dca0f2b7726060
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf4c0f46390e/disk-c21bb419.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21802e5d4446/vmlinux-c21bb419.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c46db810c9d/bzImage-c21bb419.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+abd6a8dca0f2b7726060@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in drivers/block/null_blk/zoned.c:21:14
shift exponent -1 is negative
CPU: 0 UID: 0 PID: 5906 Comm: syz.0.14 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x36d/0x400 lib/ubsan.c:494
 null_zone_no drivers/block/null_blk/zoned.c:21 [inline]
 null_process_zoned_cmd+0xf76/0xf80 drivers/block/null_blk/zoned.c:728
 null_handle_cmd drivers/block/null_blk/main.c:1455 [inline]
 null_queue_rq+0x8bc/0xe70 drivers/block/null_blk/main.c:1703
 __blk_mq_issue_directly block/blk-mq.c:2694 [inline]
 blk_mq_try_issue_directly+0x3f4/0x880 block/blk-mq.c:2754
 blk_mq_submit_bio+0x20c0/0x2a40 block/blk-mq.c:3208
 __submit_bio_noacct_mq block/blk-core.c:756 [inline]
 submit_bio_noacct_nocheck+0x2f4/0xa40 block/blk-core.c:790
 bh_submit fs/buffer.c:1239 [inline]
 block_read_full_folio+0x7a6/0x810 fs/buffer.c:2463
 filemap_read_folio+0x12c/0x3a0 mm/filemap.c:2510
 do_read_cache_folio+0x354/0x590 mm/filemap.c:4140
 read_mapping_folio include/linux/pagemap.h:1015 [inline]
 read_part_sector+0xb6/0x2b0 block/partitions/core.c:724
 adfspart_check_ICS+0xb1/0x960 block/partitions/acorn.c:357
 check_partition block/partitions/core.c:143 [inline]
 blk_add_partitions block/partitions/core.c:591 [inline]
 bdev_disk_changed+0x851/0x17a0 block/partitions/core.c:695
 blkdev_get_whole+0x372/0x510 block/bdev.c:751
 bdev_open+0x324/0xd70 block/bdev.c:960
 bdev_file_open_by_dev+0x1be/0x240 block/bdev.c:1062
 disk_scan_partitions+0x1bb/0x2c0 block/genhd.c:387
 add_disk_final block/genhd.c:412 [inline]
 add_disk_fwnode+0x24b/0x3a0 block/genhd.c:606
 add_disk include/linux/blkdev.h:800 [inline]
 null_add_dev+0x130b/0x1d70 drivers/block/null_blk/main.c:2052
 nullb_device_power_store+0x240/0x380 drivers/block/null_blk/main.c:501
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x337/0x430 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f444919e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f444a0ae028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f4449425fa0 RCX: 00007f444919e0d9
RDX: 0000000000000002 RSI: 0000200000000700 RDI: 0000000000000004
RBP: 00007f4449235024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4449426038 R14: 00007f4449425fa0 R15: 00007ffc895cc1c8
 </TASK>
---[ end trace ]---


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
