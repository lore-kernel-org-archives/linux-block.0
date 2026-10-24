Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877860;
	b=pgOj0LDtYYVRucYLQ+3nYQW5z3AI6BTbZzIV73uxaKcGLZbwOvD+VYUgoYDFqBaeoGJd
	 hWmwW+4trzO6atUY5ylnOq2dSfMQj4f2t4ChSI+GQi8Jojrx44CI2HJd79ameG4u75ISo
	 +XT2diRutqi2cmnkaKAT0NZep+kwItw5xJBnVV+/WC1d4iE0Tg8IiEOD/mha8q+bu0FcJ
	 Rs3OVM8fdpMQnpeFdvsWFyEzn2A3um7lNwx2Zu891rHEGH+5uMCx7J/B6CV899xycOTlw
	 nJ955m28RNw5x71I8srWyp/C5eZ1YJVSdeV0pkEBjtIE8C2CBYXsAA/nrAVBja7Q1yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877860;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=inEsS9nbcpTgkeCSOGOUUKXdMLg8FwgF66+Jfa/MKck=;
	b=49lwVwLLf8MqR+2lOZJ1oC0TYjuOh794ogVojowaRAmKHSkOVUeQNfv+95npvZ898trz
	 6FZDKuSlmBEFnRymIgzcTu45ZzYFaQViRepUixjQG34MKo222ulaO0qGqBsvc0a9ZQXEM
	 2QIKbmxzxZtuWmus8Z/fOSxqw6UesIlj0Kleud0mqaszYe3/SFSSp/lUAp8+J4QCvGoiZ
	 CyBty99+oJIem9tIwIDQub1a6mJR3DRpQJSd73lSG3laxhw02a+MIK61z9n5TSOo4iEhm
	 GCPe5lmKN8qBWce3M7s3c5C/tARAyGwAeYclASVc44FwR3Mb3fOOqUG6ZMXEDwKzWMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF262606A31A
	for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 21:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF262606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-8468290b866so2971176a34.1
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 14:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792877859; x=1793482659;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=inEsS9nbcpTgkeCSOGOUUKXdMLg8FwgF66+Jfa/MKck=;
        b=owf+4UMn79CAg2qV7aUT6uhTUaxvmZpga74+WkA10SCYWE8CwcqT7Cy6HEH3RrtzRN
         g7qOURMfL7lPAtp0p8Zz2AG9MZuVsJUJS2KbRFaRtQ+2fYMd4dewLkTbTwpMu1jj+AIJ
         909ApAfdimg0QLzc3ZcVsksXXGfQispbLbO9bTCMKR3+sdRmerHCV1mcAj+aU39cn8xx
         kj5qqRRKla3vL1dm8hDkNlLFGGv9e3PopnMI1bMr1FBoX1OV9lJOZJnV+Bp6d1JghyYb
         jNxMlG/CtGqeYVbBVVnEmPdelE36Fm9PjNXfuTtwKKNq+bONM5DHqfS77Db+ocvZS+hF
         33WA==
X-Forwarded-Encrypted: i=1; AKwUvByWaRCXjncsKm4NExR3Zn1tpnkxQZGssKFaw4uYfK95T3ksa1cX8UYfcQgSNqTTrcqVBk8dbV90znEHHg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLl2MhGMBmDwVoTv1XxGTjALwv8Vqx0aJrUjGRaktDSn5vArjO6
	I3rzjkA8pempGKRW21mzbTPeYzx03OjVfugp5dQH7QkxYG2tSBxHqWjNCdSVbp9jYhL2M5YEZkr
	Trv71stpDbY5qglt5x88A41OckoIepBGF8vr4V043NWDkcw9vEnKvoVWJb+E=
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b06:b0:4e7:d180:7719 with SMTP id
 5614622812f47-55c002ec926mr1614544b6e.42.1792877858879; Sat, 24 Oct 2026
 14:37:38 -0700 (PDT)
Date: Sat, 24 Oct 2026 14:37:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6add2522.a26421ad.3bb4f4.0014.GAE@google.com>
Subject: [syzbot] [block?] divide error in blk_stack_limits
From: syzbot <syzbot+1288484b13bf6af3620d@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f47d223627f8 Merge tag 'vfs-7.4-rc1.sync_close' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1633b921580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=97e47414c855a3d8
dashboard link: https://syzkaller.appspot.com/bug?extid=1288484b13bf6af3620d
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177c720d580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c0f4e1580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f47d2236.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a94d6307dbbf/vmlinux-f47d2236.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f114012b9c35/bzImage-f47d2236.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1288484b13bf6af3620d@syzkaller.appspotmail.com

Oops: divide error: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5481 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:queue_limit_discard_alignment block/blk-settings.c:645 [inline]
RIP: 0010:blk_stack_limits+0x1105/0x2d00 block/blk-settings.c:916
Code: 68 48 4c 89 e8 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 7c 18 00 00 45 8b 65 00 c7 44 24 10 00 00 00 00 eb 5f 48 8b 44 24 48 31 d2 <41> f7 f5 44 01 e9 29 d1 89 c8 31 d2 41 f7 f5 48 8b 44 24 08 4c 8d
RSP: 0018:ffffc90001c0f4f8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: ffffc90001c0f850 R08: ffffc90001c0f7e0 R09: 1ffffffff37b4dc0
R10: dffffc0000000000 R11: ffffffff88a11a10 R12: 00000000ffffffff
R13: 0000000000000000 R14: 1ffff92000381f0a R15: ffffc90001c0f854
FS:  0000555570175500(0000) GS:ffff88808b0b0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa930071220 CR3: 000000003cf9f000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 dm_calculate_queue_limits+0x70c/0x1510 drivers/md/dm-table.c:1823
 dm_setup_md_queue+0x199/0x4f0 drivers/md/dm.c:2618
 table_load+0x4fd/0x8a0 drivers/md/dm-ioctl.c:1661
 ctl_ioctl drivers/md/dm-ioctl.c:2221 [inline]
 dm_ctl_ioctl+0x9ec/0xe10 drivers/md/dm-ioctl.c:2243
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa93019f559
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffce7b56638 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa930425fa0 RCX: 00007fa93019f559
RDX: 0000200000000640 RSI: 00000000c138fd09 RDI: 0000000000000003
RBP: 00007fa930236b20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa930425fac R14: 00007fa930425fa0 R15: 00007fa930425fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:queue_limit_discard_alignment block/blk-settings.c:645 [inline]
RIP: 0010:blk_stack_limits+0x1105/0x2d00 block/blk-settings.c:916
Code: 68 48 4c 89 e8 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 7c 18 00 00 45 8b 65 00 c7 44 24 10 00 00 00 00 eb 5f 48 8b 44 24 48 31 d2 <41> f7 f5 44 01 e9 29 d1 89 c8 31 d2 41 f7 f5 48 8b 44 24 08 4c 8d
RSP: 0018:ffffc90001c0f4f8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: ffffc90001c0f850 R08: ffffc90001c0f7e0 R09: 1ffffffff37b4dc0
R10: dffffc0000000000 R11: ffffffff88a11a10 R12: 00000000ffffffff
R13: 0000000000000000 R14: 1ffff92000381f0a R15: ffffc90001c0f854
FS:  0000555570175500(0000) GS:ffff88808b0b0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa930071220 CR3: 000000003cf9f000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	68 48 4c 89 e8       	push   $0xffffffffe8894c48
   5:	48 c1 e8 03          	shr    $0x3,%rax
   9:	0f b6 04 18          	movzbl (%rax,%rbx,1),%eax
   d:	84 c0                	test   %al,%al
   f:	0f 85 7c 18 00 00    	jne    0x1891
  15:	45 8b 65 00          	mov    0x0(%r13),%r12d
  19:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%rsp)
  20:	00
  21:	eb 5f                	jmp    0x82
  23:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
  28:	31 d2                	xor    %edx,%edx
* 2a:	41 f7 f5             	div    %r13d <-- trapping instruction
  2d:	44 01 e9             	add    %r13d,%ecx
  30:	29 d1                	sub    %edx,%ecx
  32:	89 c8                	mov    %ecx,%eax
  34:	31 d2                	xor    %edx,%edx
  36:	41 f7 f5             	div    %r13d
  39:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  3e:	4c                   	rex.WR
  3f:	8d                   	.byte 0x8d


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
