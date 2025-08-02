Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DAF253B52
	for <linux-block@vger.kernel.org>; Sat,  2 Aug 2025 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754162435; cv=none; b=sjasNPNCdlZQlF4ZpOb3wq+qzpq2l/rJvZ0DVfdaQvyzE9pZaYEOF+zEvQilwBgOGwpAk1TI9eEysC3F31XdfySubBuBubZdMkgH4N8VCn5gvdh3F9GN/VGARbOPkngxnTSs2tAieSB637quLp8ddMTTNMYuBJ2FDrOm5PCvxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754162435; c=relaxed/simple;
	bh=OzYN3c/vR9xEeZMF8IB9ORyTabrQuYk8fNI43pt+iTM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sNWAwzMMg0/B58HCuum0M2qbNtIalyjz0bQd2jaYMkq7tV55kwPHcy/mmF8FLeUfveB6Tp4MRIEl7ppPMVGk8Ml2JkVzIRApDzmgFmaO8FzIBnlJZGQTIL6FxahJ8OFcqVvruecJDvz7yi5iZhOaT3kNJg2S9zZXj732SQTkqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e410d87897so17719335ab.0
        for <linux-block@vger.kernel.org>; Sat, 02 Aug 2025 12:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754162433; x=1754767233;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBtAwyu1aSvzaygWr/xhjUHPu9QFCoUi6C4sbqeWEnI=;
        b=KWk27yvz/fTz9ONtnnlkQRptCKgJnAkurrg1mouqyQEvOKK6KMvWl521LHAEo5ZMa3
         fpdS3MM9gw+x1Q+kRZyTnCsr0n5/EeMvDJumTX2eBXw0Bg/UBWBBagczJBqp1CGKbZ8w
         ybaBlEi0gWgPQ0v/4zbo3qBnJCqlEG1PN1MEbE3jpBUaN4Hlpn4gK93SiwlkkvWIGFvH
         TAPdO/OSSH7TKf09fexCDddZQzoKSzKnnK0B+bKNsEoXPz1cERRrv4u6fDTON01o29yv
         6sOJyibl0vdn6WKGuQFb62LlPHVgTe11+1qe9ujI6X7A0W/r+YZkYKc4VOdwrcEFPPkx
         b38w==
X-Forwarded-Encrypted: i=1; AJvYcCX7rIYxp25iRfNhhFPSeOstDNcsWeIZKhxsGceDPMUP6ifwxP4r7sGa1Ow1/Or1pdyjRvQNbCal0KlneA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfL84MlDN+5bqnueKCGNmnMvrxTLl5c+ag7AL5VMCJrS+BLMwR
	DMqOenUYiD7TtolzJKvx4j849cSGvR8JA53vEkaLJNkWFsZ+sjCtCpgLMNT80447PkvYraYvhJZ
	9pIyQPaGt5paQUOd2cp5cKHBr8FXBLE4AEZXPQDmadsDuopGAMmFa1S57eN0=
X-Google-Smtp-Source: AGHT+IFBlc22xGVxkUsO0Mw0GWNmdmLQ7vqgQnl0o6Sh9XS15RkxsdRAhXlaA0P9N5b4nghIlXrofGX1Zh7YFZCrvbh3bj6I6JNx
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:398e:b0:3e3:d499:73f with SMTP id
 e9e14a558f8ab-3e4161b735cmr92781645ab.18.1754162432751; Sat, 02 Aug 2025
 12:20:32 -0700 (PDT)
Date: Sat, 02 Aug 2025 12:20:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688e6500.050a0220.f0410.0141.GAE@google.com>
Subject: [syzbot] [block?] general protection fault in zcomp_available_show
From: syzbot <syzbot+1a281a451fd8c0945d07@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	minchan@kernel.org, senozhatsky@chromium.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a6923c06a3b2 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155ddcf0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f81cd75c44834c1
dashboard link: https://syzkaller.appspot.com/bug?extid=1a281a451fd8c0945d07
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2a74fc5b80ca/disk-a6923c06.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a2267e0785c/vmlinux-a6923c06.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4dbddcb2f621/bzImage-a6923c06.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a281a451fd8c0945d07@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 16120 Comm: syz.5.1782 Tainted: G     U              6.16.0-syzkaller-11105-ga6923c06a3b2 #0 PREEMPT(full) 
Tainted: [U]=USER
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:strcmp+0x39/0xb0 lib/string.c:283
Code: df 41 54 55 53 48 89 fb 48 83 ec 08 eb 08 40 84 ed 74 61 4c 89 e6 48 89 df 48 83 c3 01 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <42> 0f b6 04 28 38 d0 7f 04 84 c0 75 58 48 89 f0 48 89 f2 0f b6 6b
RSP: 0018:ffffc9000d96f7c0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc9001895a000
RDX: 0000000000000000 RSI: ffffffff8c440580 RDI: 0000000000000000
RBP: ffffffff8c43f520 R08: 0000000000000001 R09: ffffed1004bdca09
R10: ffff888025ee504f R11: 0000000000000000 R12: ffff88807c3f6000
R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  00007f26269916c0(0000) GS:ffff8881247d6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30cffff8 CR3: 000000002a034000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 zcomp_available_show+0x73/0x130 drivers/block/zram/zcomp.c:98
 __comp_algorithm_show drivers/block/zram/zram_drv.c:1234 [inline]
 comp_algorithm_show+0x98/0xd0 drivers/block/zram/zram_drv.c:1391
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2421
 sysfs_kf_seq_show+0x213/0x3e0 fs/sysfs/file.c:65
 seq_read_iter+0x509/0x12c0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x40f/0x5a0 fs/kernfs/file.c:279
 copy_splice_read+0x615/0xba0 fs/splice.c:363
 do_splice_read fs/splice.c:979 [inline]
 do_splice_read+0x285/0x370 fs/splice.c:953
 splice_direct_to_actor+0x2a1/0xa30 fs/splice.c:1083
 do_splice_direct_actor fs/splice.c:1201 [inline]
 do_splice_direct+0x174/0x240 fs/splice.c:1227
 do_sendfile+0xb06/0xe50 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64 fs/read_write.c:1417 [inline]
 __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2628f8eb69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2626991038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f26291b6240 RCX: 00007f2628f8eb69
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 00007f2629011df1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f26291b6240 R15: 00007ffff2fc35d8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strcmp+0x39/0xb0 lib/string.c:283
Code: df 41 54 55 53 48 89 fb 48 83 ec 08 eb 08 40 84 ed 74 61 4c 89 e6 48 89 df 48 83 c3 01 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <42> 0f b6 04 28 38 d0 7f 04 84 c0 75 58 48 89 f0 48 89 f2 0f b6 6b
RSP: 0018:ffffc9000d96f7c0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc9001895a000
RDX: 0000000000000000 RSI: ffffffff8c440580 RDI: 0000000000000000
RBP: ffffffff8c43f520 R08: 0000000000000001 R09: ffffed1004bdca09
R10: ffff888025ee504f R11: 0000000000000000 R12: ffff88807c3f6000
R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  00007f26269916c0(0000) GS:ffff8881247d6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000c5d000 CR3: 000000002a034000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	df 41 54             	filds  0x54(%rcx)
   3:	55                   	push   %rbp
   4:	53                   	push   %rbx
   5:	48 89 fb             	mov    %rdi,%rbx
   8:	48 83 ec 08          	sub    $0x8,%rsp
   c:	eb 08                	jmp    0x16
   e:	40 84 ed             	test   %bpl,%bpl
  11:	74 61                	je     0x74
  13:	4c 89 e6             	mov    %r12,%rsi
  16:	48 89 df             	mov    %rbx,%rdi
  19:	48 83 c3 01          	add    $0x1,%rbx
  1d:	48 89 f8             	mov    %rdi,%rax
  20:	48 89 fa             	mov    %rdi,%rdx
  23:	48 c1 e8 03          	shr    $0x3,%rax
  27:	83 e2 07             	and    $0x7,%edx
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	38 d0                	cmp    %dl,%al
  31:	7f 04                	jg     0x37
  33:	84 c0                	test   %al,%al
  35:	75 58                	jne    0x8f
  37:	48 89 f0             	mov    %rsi,%rax
  3a:	48 89 f2             	mov    %rsi,%rdx
  3d:	0f                   	.byte 0xf
  3e:	b6 6b                	mov    $0x6b,%dh


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
