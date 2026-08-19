Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1D74078EA
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166823; cv=none; b=SnXN0ViVSSxSv5A4NcCgmimiuazMuxXiJ4KGpeALVcrSdrPNlYC4Q76e/8lpj6PSQNQObVBDLton94J1g8Z53r/4X+5EKIW9ZydFACAX3jwhlzlwgqwyvfB+clb9n3AP53yYCI+J43WziwLfnI3kUcNL6IM8DUewroBawKtzz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166823; c=relaxed/simple;
	bh=ieogkfwiCiEOQ1vzQxTYK6pdX7LT6p5oiQJY9EHoFkM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TedCT3z4mcfGWSNre8LSmDuJpbzG+Gzk1W5VQ/DjZEKjM0gu3Yxl3lQDmhyuj359k3JH+fxLfHajmr4DU51IXagquCfAcLibcyXmSFNq9JSH3EkJnFK4UvfRLF+FR6qYF6eAW+bYEj5rXlNLToSoouWtNYzKbMAisORlZ0tkamM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f8.google.com with SMTP id 006d021491bc7-6b132681374so340091eaf.1
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 12:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787166817; x=1787771617;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SYXOdD+HISPrrOEprW/usKJcVvCNr9hTtMu/L2+qF90=;
        b=A+2Q5+gyg5ywauY4hdFNyLhi2mw5tNWTFsoxe3SibeuJXSPY1ohj251xtg2Zi3jqtG
         9CUiplSi8dpVnSwliTRXw0Y7VnkbApUmP+7IgKGiAY2qEJckc2PgGBG+fkGD0j7SeeAX
         pn6ThaZyYfImR8/7y1sNeCuIjrH2ej++0h7Y/WKYZ5fN7jLbiocXJQhuTGdMv8ze/nWF
         dcH7WhkfvvvmMzcCSHKXS5NQNy6Y3vpNtqtpTreI5r1smow6huJgf2eYYWsd+HkgqHFK
         7sqXeqHeNj/mXk4vsSWyfvkar5zq/hbMnhUyTKRtoIARX9HJeDv08RzdkLJxOkEhJwSh
         i5Ww==
X-Forwarded-Encrypted: i=1; AHgh+RpqirMaTORzYHfSyPRgKDzG5b5cmIO59q8Ju/t3iav/9+rR/TWLW/XPxwNSjL0670+K83gpy5uZLVuKNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrX0Ja/B8NTSoZn5cxUTxRR+4dGzlxZdyT6057Lz6ZskXBj0GN
	gYhR1P18JDM040EjfcuHHIQKRuF7IXrPyrNIT3JjJMfihv0K5nZhNA14P6ByaKsS1pnfHop5WUL
	yZXQMMB/pkU+KHfUagjeP1b/hCvXIBenSOy750ARnB5upREOIsUXjps4cs3o=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b82:b0:6b0:4199:3cc4 with SMTP id
 006d021491bc7-6b13c5d6b97mr7175092eaf.27.1787166817673; Wed, 19 Aug 2026
 12:13:37 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:13:37 -0700
In-Reply-To: <6a74a7ea.01d0871a.3a0d52.0024.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a860061.ae6ddae5.3da009.0010.GAE@google.com>
Subject: Re: [syzbot] [block?] WARNING in null_report_zones
From: syzbot <syzbot+67f80b67c0cfaa3bb3bb@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    bd5f485f3f02 Merge tag 'soc-arm-7.3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1168219e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d6c2a05eaadaf10
dashboard link: https://syzkaller.appspot.com/bug?extid=67f80b67c0cfaa3bb3bb
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15767815580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-bd5f485f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5a13ddf1c1fa/vmlinux-bd5f485f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0dc17a20da2c/bzImage-bd5f485f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+67f80b67c0cfaa3bb3bb@syzkaller.appspotmail.com

null_blk: nullb1: using native zone append
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: kernel/locking/mutex.c:625 at __mutex_lock_common kernel/locking/mutex.c:625 [inline], CPU#0: syz.0.17/5967
WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x944/0x1bc0 kernel/locking/mutex.c:821, CPU#0: syz.0.17/5967
Modules linked in:
CPU: 0 UID: 0 PID: 5967 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:625 [inline]
RIP: 0010:__mutex_lock+0x94b/0x1bc0 kernel/locking/mutex.c:821
Code: 0f b6 14 11 38 d0 7c 08 84 d2 0f 85 b4 10 00 00 44 8b 05 08 bf 81 05 45 85 c0 75 13 48 8d 3d 5c 1d 85 05 48 c7 c6 a0 df ef 8b <67> 48 0f b9 3a 90 e9 1b f8 ff ff 4d 8d a7 f0 0a 00 00 4c 89 e7 e8
RSP: 0018:ffffc9000634f680 EFLAGS: 00010246
RAX: 0000000000000003 RBX: ffff888047c00000 RCX: 1ffffffff2284a30
RDX: 0000000000000000 RSI: ffffffff8befdfa0 RDI: ffffffff9145afe0
RBP: ffffc9000634f7f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffffed100ab768d4
FS:  00007fd5599d66c0(0000) GS:ffff8880d5bd4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000059f3c000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 null_lock_zone drivers/block/null_blk/zoned.c:39 [inline]
 null_lock_zone drivers/block/null_blk/zoned.c:33 [inline]
 null_report_zones+0x4af/0x6f0 drivers/block/null_blk/zoned.c:219
 blk_revalidate_disk_zones+0x492/0xce0 block/blk-zoned.c:2384
 null_add_dev+0x125f/0x1df0 drivers/block/null_blk/main.c:2047
 nullb_device_power_store+0x29d/0x350 drivers/block/null_blk/main.c:501
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd558b9e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd5599d6028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fd558e25fa0 RCX: 00007fd558b9e0d9
RDX: 0000000000000001 RSI: 0000200000000700 RDI: 0000000000000004
RBP: 00007fd558c35024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd558e26038 R14: 00007fd558e25fa0 R15: 00007fffab806348
 </TASK>
----------------
Code disassembly (best guess):
   0:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
   4:	38 d0                	cmp    %dl,%al
   6:	7c 08                	jl     0x10
   8:	84 d2                	test   %dl,%dl
   a:	0f 85 b4 10 00 00    	jne    0x10c4
  10:	44 8b 05 08 bf 81 05 	mov    0x581bf08(%rip),%r8d        # 0x581bf1f
  17:	45 85 c0             	test   %r8d,%r8d
  1a:	75 13                	jne    0x2f
  1c:	48 8d 3d 5c 1d 85 05 	lea    0x5851d5c(%rip),%rdi        # 0x5851d7f
  23:	48 c7 c6 a0 df ef 8b 	mov    $0xffffffff8befdfa0,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	90                   	nop
  30:	e9 1b f8 ff ff       	jmp    0xfffff850
  35:	4d 8d a7 f0 0a 00 00 	lea    0xaf0(%r15),%r12
  3c:	4c 89 e7             	mov    %r12,%rdi
  3f:	e8                   	.byte 0xe8


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
