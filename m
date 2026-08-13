Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C633E44ED
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623034; cv=none; b=P5sl//TZHJf/HCDpuTHnrMYbRRNq5Z1t+BZrosYUW8U0zP4VDhKexndac2Yp4AHRCY59I7WnNrNceia8r+4v0CGvvQSNh0Pzl9rinLcpFU+ZN8XNMAfYXq0wk//vFB99FDhhhfl3iKJyhs1ryx4ig1FBMf8TteIBx1a6MfpyLo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623034; c=relaxed/simple;
	bh=p+B3U7RzVHIdi7Ty0+vL9IyMUnZ0Qkh6lfkKiqKSTio=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gnvf/mrGczBLBNwj8bOVoY8kLbqoPNwyQhdDNOZDf3vcNF2lsbhD9kmzuLbOUhAYGbnrhvQUz/Prw1BhYLWXcRC1XKgSluUZ2lfhoCVUh0vQ3ZHKiu7PrvFYU97nEdI6QsDDqHgLapCHxRMQDULpEIAa6mr1nQJIikvXH7PIIzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-456b5122c7cso1185175fac.1
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 05:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786623032; x=1787227832;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YDFRTE6xFK1Z3JHblcHWmrWK2ZvSQtWEiyrZ+/Dn1Bs=;
        b=UTN5KBcGe1TtI7Doxp12tdaDuS+xMzYcZVune6c/DODQSS6V6Dxeev9iSmLy0aBGgL
         6t8+AQvOxKpZxkXurjzv0sPg+f92AX66VjtiANMVTO+X9OfJ20kC/ki4WnsBy2KLWzIt
         N8Vt2o2mftOBvUi2iE1bHAHVDiAaUcqUGRtGqwUEGRa/AIkCd8/DO5sMx4Xp+7HhsgFF
         aEeaZqhv8L4mMcT2zQLfg/Lon/Fb9UH0PkQIP+3WAIBmpWWiKTI/iKnM5LqHeLSK7gRo
         H7KJtoSRz8YT7i42Q2jcwAWxZ8dP9KbXPcstdUz17SMKRM6hHRV+9MH323UZ77VNN3CY
         P2Ug==
X-Forwarded-Encrypted: i=1; AHgh+Rr9xmJrdWWSCbnCsKfyzbRrGkxUun7g5liWZh3Kc5UPFM6ila23kPMhMBIGxHlgc9DbGNRLtjGrOOv+gQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wbXK/Jff5Bx/xjLaTLaXaoB5p0QtTSztGadxBwz6zJ/+LCU3
	VqZ7q7M8vmzF9NL9jDTVOffSv4muli1A0jow0Nteoy49frGhqMudmhrZkrwDwEdNGL4Pz1cDx8p
	8NFMRhyro3YexgL+yCk0xkiACJCYXONMVooHh9qco3uhnRfQKv4cPtCbTjSU=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1524:b0:4a4:cedc:6859 with SMTP id
 5614622812f47-4b227ee0285mr3384838b6e.4.1786623031916; Thu, 13 Aug 2026
 05:10:31 -0700 (PDT)
Date: Thu, 13 Aug 2026 05:10:31 -0700
In-Reply-To: <6a74aa44.01d0871a.3a0d52.0028.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7db437.bc649fcc.f9e73.014c.GAE@google.com>
Subject: Re: [syzbot] [block?] UBSAN: shift-out-of-bounds in null_process_zoned_cmd
From: syzbot <syzbot+abd6a8dca0f2b7726060@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3d6d817622b0 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1767f479580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=abd6a8dca0f2b7726060
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16038ac6580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+abd6a8dca0f2b7726060@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in drivers/block/null_blk/zoned.c:21:14
shift exponent -1 is negative
CPU: 0 UID: 0 PID: 6032 Comm: syz-executor192 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
 null_zone_no drivers/block/null_blk/zoned.c:21 [inline]
 null_process_zoned_cmd.cold+0x17/0x38 drivers/block/null_blk/zoned.c:728
 null_handle_cmd drivers/block/null_blk/main.c:1455 [inline]
 null_queue_rq+0x664/0xfb0 drivers/block/null_blk/main.c:1703
 __blk_mq_issue_directly+0xe2/0x200 block/blk-mq.c:2694
 blk_mq_try_issue_directly+0x21b/0x420 block/blk-mq.c:2754
 blk_mq_submit_bio+0x21ec/0x3000 block/blk-mq.c:3208
 __submit_bio+0x90/0x3d0 block/blk-core.c:673
 __submit_bio_noacct_mq block/blk-core.c:756 [inline]
 submit_bio_noacct_nocheck+0x549/0xc00 block/blk-core.c:790
 submit_bio_noacct+0xd18/0x1ff0 block/blk-core.c:921
 blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
 __bh_submit+0x721/0x950 fs/buffer.c:1225
 bh_submit fs/buffer.c:1239 [inline]
 block_read_full_folio+0x496/0x8c0 fs/buffer.c:2463
 filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2516
 do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4146
 read_mapping_folio include/linux/pagemap.h:1015 [inline]
 read_part_sector+0xd1/0x370 block/partitions/core.c:724
 adfspart_check_ICS+0x91/0x7d0 block/partitions/acorn.c:357
 check_partition block/partitions/core.c:143 [inline]
 blk_add_partitions block/partitions/core.c:591 [inline]
 bdev_disk_changed+0x7b1/0x1260 block/partitions/core.c:695
 blkdev_get_whole+0x187/0x290 block/bdev.c:751
 bdev_open+0x2c7/0xe40 block/bdev.c:960
 bdev_file_open_by_dev block/bdev.c:1062 [inline]
 bdev_file_open_by_dev+0x179/0x210 block/bdev.c:1037
 disk_scan_partitions+0x1ef/0x320 block/genhd.c:387
 add_disk_final block/genhd.c:412 [inline]
 add_disk_fwnode+0x3f4/0x480 block/genhd.c:606
 add_disk include/linux/blkdev.h:800 [inline]
 null_add_dev+0x129d/0x1df0 drivers/block/null_blk/main.c:2052
 nullb_device_power_store+0x29d/0x350 drivers/block/null_blk/main.c:501
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc39344769e
Code: 08 0f 85 f5 e2 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007fc3933ea128 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fc3933ea6c0 RCX: 00007fc39344769e
RDX: 0000000000000002 RSI: 00007fc39348c03a RDI: 0000000000000003
RBP: 0000000000000021 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffd0
R13: 0000000000000011 R14: 00007ffcdf31cc10 R15: 00007ffcdf31ccf8
 </TASK>
---[ end trace ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
