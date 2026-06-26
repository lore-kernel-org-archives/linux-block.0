Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01F3BFE20
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509373; cv=none; b=NgOuYsioKtIm1MkSIxGXF5qLFAwaE2rMa5BvUzRM0aTYcFD8T5QKlACBy8ukLqJbaUaSLaqstCjmVJUuDJ/OAxDEevpMiTjC8u7mL7paf8Md+JdbGzj5NYp4X4mkTBPeSxpCYBrm+9307+3GNaRLW8zGwQkqo5IfEXK/rdCMUls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509373; c=relaxed/simple;
	bh=GxirZLt+ZDzV7aXaElsSivvVg1R97jfHi4uHEiG4QuE=;
	h=Message-ID:Date:Subject:To:Cc:Content-Type:MIME-Version:From; b=NDzXrRWF5a83PVLBVhuloBtHzxs0oTP9gn/2op3B0r6j1QSUCQBLrfPMC42Pq8aJHfZJyazzXeIHcjEbQ96tqxd5E9cuxQiQDEMJSsw7LBAWHhWaHkjy3K9PAbqmvlLFUA6AXosNZ8Tu8z1JL8xNlLzVm/kRUEC3r4hIpNZs214=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T91TslxA; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T91TslxA"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5bd6d636ac8so44883e0c.2
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 14:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782509371; x=1783114171; darn=vger.kernel.org;
        h=from:mime-version:content-transfer-encoding:content-type:cc:to
         :subject:date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V0kQpCCGud/GAqVFH7m016Z7CnccToStBrwL1GZy8Ng=;
        b=T91TslxA/JJdbAFBvESsNAqvOYEGoOAfxv3KW85Ush2e4a2+DOaBHrWEj2qasyTr+x
         jYZ/zqlO6bjwvXJ9OABBEAMMNkR24KlpJpcTNZuW08bwF+OQ8bHnjuDho9j1MFu5wIeI
         znSecK9tzjV2fpeUfeqOF1koSqSRZd30HGCI6pLrQpOPL09qiz4Eyi9f4c3R3VheVrF7
         /G0U61N+gI50MznjEj41LtD30bnsCtdWsY6eYLu/50HqZfji0KFWDx5wxsyVxJ5aovA7
         YkF9lp8DCpCJVfTlalVW3ogLqFitm3kIJDcFOvebHTR5JMWfzCM9UtclGmJjcYdElQnU
         SFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509371; x=1783114171;
        h=from:mime-version:content-transfer-encoding:content-type:cc:to
         :subject:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V0kQpCCGud/GAqVFH7m016Z7CnccToStBrwL1GZy8Ng=;
        b=GrAm3/leuCr7yEEQz7eYbEuuVuzGrzAmo+0TUnGUHTTa2F7J+3tArO6cdWyRhag3I1
         Js+ctdcsOK0NGxTsvdRSFoEUd2+TSVXgIwJ30YyUjHQ8e7ky9b/zijGq8DGzpzoXi9kM
         t+hWy6pvBDXpPa9ENxzH9zAPcrlNEvnfbIFPqf+oXjpbJ7hj6SHKWdbasPa/B2msG4kW
         crAHBI3KoyE9Kj7uLvzHC//DtmUo7368Uh/oPpMUzVVXwDY6WWj6dwYsydF3rzjYxx1b
         GcrWfZro3A692TJ4rZ3RL8TBFgVBAXNo8hQJgMCDH2kuxLSS2wpwsPqr0a8zNEAoH3lX
         mGXg==
X-Forwarded-Encrypted: i=1; AHgh+RqUUHlTsbsg15xNHoyWQwDYlWyqwfPGUaMwo/bRjjtCaDTJn7lNbVt+FteI8r+s9ma1lFTzQT/PA1HxDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHC8YgcZuJbZAyyFBa4sGlcV9O8GFxNjejWe98lM7XwGLxxnd1
	zb8uEREOWwed4c0hZkDIZFaDRl2uUE2DulQd9NSMejcDFQ+jn+B5pkSGSKhwbrHu
X-Gm-Gg: AfdE7clwf9hpKESvBzmgJPiuzR1xlyhzPMlnar7CwTLtgnzIgQKfe9Q4lTVE0mO7ojq
	TzXm2ojhH0vP5RqycxoLzLUQD0garv1IFwLhBZ+ErYSYkCyzVWbSSvPKzxFvNKv9ukToMpgTuOl
	yevU/Uyc8ioYw5pGnSCaDTV2E2Oq/HPsygm40SoMfAijevloYCeT/fk55yBN6kVWC8fM7/JkhB8
	ZF6yxRUiUcWuMk6mDCYgW4cwZyQIMDvYA5A5sfARiy6rM0p3hBj9sp+G/2umYvITs5p2h8dBvtY
	T33B85wN/uhCf0r1nGfBSUOzUELTwBkeI6ER06omS91k++MtgKB8qgc8a35VT3tOdgmciYIZol6
	DB+SkWnCCchPFGxvEoJvFuPJuPS9Kp1HKR6/8rlWvyhgg7YrsPaTjmVqoOsDBbSKhA5L3O5oaET
	kkjqz0P7FpailraPLZEIuwZ3Po9YiYduhHfLiMhBs4ly2XkZNcI+kxLy734xNfsADktAlT2H3V2
	m1EksiLilNg
X-Received: by 2002:a05:6122:4d8a:b0:5bd:7446:e3ff with SMTP id 71dfb90a1353d-5bd7446e43amr1216837e0c.0.1782509370955;
        Fri, 26 Jun 2026 14:29:30 -0700 (PDT)
Received: from [192.168.10.115] ([132.170.207.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bd790c4931sm1850372e0c.14.2026.06.26.14.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:29:30 -0700 (PDT)
Message-ID: <6a3eef3a.e743daa7.24bfe1.c86e@mx.google.com>
Date: Fri, 26 Jun 2026 14:29:30 -0700 (PDT)
Subject: general protection fault in reset_interrupt
To: efremov@linux.com, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, contact@pgazz.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: sanan.hasanou@gmail.com

Good day, dear maintainers,

We found a bug using a modified version of syzkaller.

Kernel Branch: 7.0-rc1
Kernel Config: <https://drive.google.com/open?id=1pfjd_xagvCCoLD4kK7OQIvvdEBYpavwn>
Unfortunately, we don't have any reproducer for this bug yet.
Thank you!

Best regards,
Sanan Hasanov

floppy0: floppy_shutdown: timeout handler died.  
floppy0: get result error. Fdc=0 Last status=ffffffff Read bytes=0
floppy driver state
-------------------
now=4294939504 last interrupt=4294939495 diff=9 last called handler=reset_interrupt
timeout_message=do wakeup
last output bytes:
 0  0 0
 0  0 0
 0  0 0
 0  0 0
 0  0 0
 0  0 0
 8 80 4294938128
 8 80 4294938128
 8 80 4294938128
 8 80 4294938128
 e 80 4294938128
13 80 4294938128
 0 90 4294938128
1a 90 4294938128
 0 90 4294938128
12 80 4294938128
 0 90 4294938128
14 80 4294938128
18 80 4294938128
 8 80 4294939495
last result at 4294939495
last redo_fd_request at 4294939495
status=d0
fdc_busy=0
cont=0000000000000000
current_req=0000000000000000
command_status=-1
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 UID: 0 PID: 39 Comm: kworker/u8:3 Not tainted 7.0.0-rc1 #1 PREEMPT(full) 
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: floppy floppy_work_workfn
RIP: 0010:reset_interrupt+0x136/0x1b0 drivers/block/floppy.c:1790
Code: 62 8d 48 c7 c2 60 ff b9 8b e8 86 98 22 fb e9 3e ff ff ff e8 9c 23 c7 fb 48 8b 1d c5 52 d5 0d 48 83 c3 10 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 6b d4 32 fc 48 8b 33 48 c7 c7 80
RSP: 0018:ffffc90000297ab0 EFLAGS: 00010212
RAX: 0000000000000002 RBX: 0000000000000010 RCX: ffff888015b53a00
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffffc90000297ac0 R08: ffffffff8f76bd77 R09: 1ffffffff1eed7ae
R10: dffffc0000000000 R11: fffffbfff1eed7af R12: ffff888015718818
R13: ffffffff819609fe R14: dffffc0000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880dbbbb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000db2b000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 floppy_work_workfn+0x18/0x20 drivers/block/floppy.c:993
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xa30/0x13d0 kernel/workqueue.c:3358
 worker_thread+0xacb/0x1060 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x5e4/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:reset_interrupt+0x136/0x1b0 drivers/block/floppy.c:1790
Code: 62 8d 48 c7 c2 60 ff b9 8b e8 86 98 22 fb e9 3e ff ff ff e8 9c 23 c7 fb 48 8b 1d c5 52 d5 0d 48 83 c3 10 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 6b d4 32 fc 48 8b 33 48 c7 c7 80
RSP: 0018:ffffc90000297ab0 EFLAGS: 00010212
RAX: 0000000000000002 RBX: 0000000000000010 RCX: ffff888015b53a00
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffffc90000297ac0 R08: ffffffff8f76bd77 R09: 1ffffffff1eed7ae
R10: dffffc0000000000 R11: fffffbfff1eed7af R12: ffff888015718818
R13: ffffffff819609fe R14: dffffc0000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880dbbbb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000db2b000 CR4: 00000000000006f0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	8d 48 c7             	lea    -0x39(%rax),%ecx
   3:	c2 60 ff             	ret    $0xff60
   6:	b9 8b e8 86 98       	mov    $0x9886e88b,%ecx
   b:	22 fb                	and    %bl,%bh
   d:	e9 3e ff ff ff       	jmp    0xffffff50
  12:	e8 9c 23 c7 fb       	call   0xfbc723b3
  17:	48 8b 1d c5 52 d5 0d 	mov    0xdd552c5(%rip),%rbx        # 0xdd552e3
  1e:	48 83 c3 10          	add    $0x10,%rbx
  22:	48 89 d8             	mov    %rbx,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 6b d4 32 fc       	call   0xfc32d4a3
  38:	48 8b 33             	mov    (%rbx),%rsi
  3b:	48                   	rex.W
  3c:	c7                   	.byte 0xc7
  3d:	c7                   	.byte 0xc7
  3e:	80                   	.byte 0x80

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>
