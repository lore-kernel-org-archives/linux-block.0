Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2E437AA7B
	for <linux-block@vger.kernel.org>; Fri, 20 Mar 2026 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774046671; cv=none; b=mB1xthHA33M1R8MdNBxZ43RkvpQtZAAiNR3WIrYLVA5oFUYFAuZLLW04Ij5r2i+NYLKFlTd7iVDjDi63YQNE8SjJMfgBjAAu3tfPrf9VQ/oTFM5YTFa2HkXrFN3SxSeiiBdWCo6ZuadLqA8sis/ifZxTJ7ZcaEWbmeOd9CL+7rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774046671; c=relaxed/simple;
	bh=71+6rPxV38tKQCXTAOSxlJ4fOM7egh5AGwrolqOOrzc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RO85HmW0Q1LCOxK30YTOb6GslJpvMqsfdkh+cX3QnR+99AkQRFxMUuRM1I0jT6he76JlGFklIbvaD34xypJOsVhUuQm9XKWCRTZ1ft3O9mhQ6NOqMR9pQE7GRWBBeIQUH++BSIWT7/Q3shCwnYW84NqM/2n+iuWNBOCWggzl6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-466ed1116a9so17601907b6e.1
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2026 15:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774046669; x=1774651469;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpgJQDYl0QYA07PCuCEGS3ZmmaZbZt11WBzsH3N9tSo=;
        b=bvWDvSHwE0Kqi3fiITOugplXeYJmmBXO7SXuoplu8FZFKCpAQl8SZfbVTJP9LqaqJJ
         /RN0Mbhi3bXn9cIKZSz4ptohC21Vl3SRAtHsvKC7vqh8HXIX2cV2Zz566Go668+Q/TeC
         QqdDNqWHkGr7ofln9i4ekGfdDPEoIhj8cWsM0ciSg5150JGqbjrpbb2n8lob8FH8qNLv
         bvajqHQluwjuZlyORvy/v4veJf31Kpf0eGstzn6Q8YjYTheQ0LRpJAuiw0JlA8whKbQM
         ZHcvOHHyYM1gZut4DaS9Nl5NzDTtntF6KN5raYaU1buvzeCUudiab/kPiOg92POGJ72d
         DmFA==
X-Forwarded-Encrypted: i=1; AJvYcCXwQOI1Xh8JrQvVr+/kIlfdbu5Yhcwajz2nYP/2JquQpJ4mdjYdu9ECyH+I3gcA9zfjked4uyxnAvrICQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4x4eNyfMcGY9xyj8cl/144961HyEomNmYu5DkL01rmFq3GWMS
	v9E/i6+cDRn/d+HUQg24HmNHoOMGwS5KBV0rBM48ib2Ss6iks3/85iAJ+Mg4nuPST46DJUmHeAB
	a9KZK0ieina4q8MoItyBBu1D9xjbGi7Z7ZmZ2pYa7j5xwdiw4EZh/w2mwjFk=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1405:b0:455:7fe4:b215 with SMTP id
 5614622812f47-467e600f5a4mr2767714b6e.53.1774046669288; Fri, 20 Mar 2026
 15:44:29 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:44:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69bdcdcd.050a0220.3bf4de.002f.GAE@google.com>
Subject: [syzbot] [block?] general protection fault in bio_alloc_bioset
From: syzbot <syzbot+09ddb593eea76a158f42@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8e42d2514a7e Add linux-next specific files for 20260318
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10b35ed6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1da705b17f2649a3
dashboard link: https://syzkaller.appspot.com/bug?extid=09ddb593eea76a158f42
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1325a06a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/64c940773401/disk-8e42d251.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aa7a94376665/vmlinux-8e42d251.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5a7ab603c859/bzImage-8e42d251.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+09ddb593eea76a158f42@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 1116 Comm: kworker/u8:9 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:bio_init block/bio.c:214 [inline]
RIP: 0010:bio_init_inline include/linux/bio.h:435 [inline]
RIP: 0010:bio_alloc_bioset+0x664/0xc10 block/bio.c:593
Code: 04 24 00 00 00 00 41 8d 46 ff 0f b7 d8 bf 04 00 00 00 89 de e8 6d b0 3a fd 66 83 fb 04 0f 83 db 00 00 00 4c 89 f8 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 ff e8 3e 27 a4 fd 49 c7 07 00 00 00 00 49
RSP: 0000:ffffc9000576efe8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802998bd00 RSI: 0000000000000000 RDI: 0000000000000004
RBP: dffffc0000000000 R08: ffffffff905435f7 R09: 1ffffffff20a86be
R10: dffffc0000000000 R11: fffffbfff20a86bf R12: 0000000000092800
R13: ffffffff9a8dc840 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124de1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f51b88511d0 CR3: 0000000072570000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 bio_alloc include/linux/bio.h:373 [inline]
 submit_bh_wbc+0x22d/0x650 fs/buffer.c:2816
 __block_write_full_folio+0x810/0xe10 fs/buffer.c:1930
 blkdev_writepages+0xef/0x1b0 block/fops.c:486
 do_writepages+0x32e/0x550 mm/page-writeback.c:2554
 __writeback_single_inode+0x133/0x11a0 fs/fs-writeback.c:1750
 writeback_sb_inodes+0x992/0x1a20 fs/fs-writeback.c:2042
 __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2118
 wb_writeback+0x46a/0xb70 fs/fs-writeback.c:2229
 wb_check_start_all fs/fs-writeback.c:2355 [inline]
 wb_do_writeback fs/fs-writeback.c:2381 [inline]
 wb_workfn+0x95b/0xf50 fs/fs-writeback.c:2414
 process_one_work+0x9ab/0x1780 kernel/workqueue.c:3288
 process_scheduled_works kernel/workqueue.c:3379 [inline]
 worker_thread+0xba8/0x11e0 kernel/workqueue.c:3465
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bio_init block/bio.c:214 [inline]
RIP: 0010:bio_init_inline include/linux/bio.h:435 [inline]
RIP: 0010:bio_alloc_bioset+0x664/0xc10 block/bio.c:593
Code: 04 24 00 00 00 00 41 8d 46 ff 0f b7 d8 bf 04 00 00 00 89 de e8 6d b0 3a fd 66 83 fb 04 0f 83 db 00 00 00 4c 89 f8 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 ff e8 3e 27 a4 fd 49 c7 07 00 00 00 00 49
RSP: 0000:ffffc9000576efe8 EFLAGS: 00010246

RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802998bd00 RSI: 0000000000000000 RDI: 0000000000000004
RBP: dffffc0000000000 R08: ffffffff905435f7 R09: 1ffffffff20a86be
R10: dffffc0000000000 R11: fffffbfff20a86bf R12: 0000000000092800
R13: ffffffff9a8dc840 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124de1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564154e50330 CR3: 000000005d868000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	04 24                	add    $0x24,%al
   2:	00 00                	add    %al,(%rax)
   4:	00 00                	add    %al,(%rax)
   6:	41 8d 46 ff          	lea    -0x1(%r14),%eax
   a:	0f b7 d8             	movzwl %ax,%ebx
   d:	bf 04 00 00 00       	mov    $0x4,%edi
  12:	89 de                	mov    %ebx,%esi
  14:	e8 6d b0 3a fd       	call   0xfd3ab086
  19:	66 83 fb 04          	cmp    $0x4,%bx
  1d:	0f 83 db 00 00 00    	jae    0xfe
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 ff             	mov    %r15,%rdi
  33:	e8 3e 27 a4 fd       	call   0xfda42776
  38:	49 c7 07 00 00 00 00 	movq   $0x0,(%r15)
  3f:	49                   	rex.WB


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
