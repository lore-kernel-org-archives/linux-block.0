Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3ED1AD3EF
	for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 23:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886858; cv=none; b=rGfvfxVYC+GfydYoYFkIvXXBMGhDxx+msrK7OJnxSsY5fC6jJgFX0ukau+0CnTtBzol6dkwUSmhsr9ZrS7FQ6vtzuJC1eRZ/x3WHPRSdHTKp6KLiylENiHG1oFSf4Eog4uI19qeBiQCOEBboMxd4o3dnWMZ066MgdxBNCvv2t34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886858; c=relaxed/simple;
	bh=TAfbCxquRif/qdYzukrgJEOR05LH1QDxbKWWKJZy4SM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SD/aAS6Vgg48g6KfPahnnbYNlKAnFUVV4ygT9oEMn18nwelLyrXonwYaTE0hsbx0JRN6ntDoflcpEYWAHeJd2STfNvgamWSYba5NmYgSxroOwuv76leGaZfYOuy/gsh5Gm702khECoTc+MRK3gpAZZAYvjXqLU0+gJvaoBXbKpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=N6aPCMK5; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=TcQAIn8d; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="N6aPCMK5";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="TcQAIn8d"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724886857; x=1756422857;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=TAfbCxquRif/qdYzukrgJEOR05LH1QDxbKWWKJZy4SM=;
  b=N6aPCMK5yzWNkpj5wYG/ForykPMhhju5eFvBHCm7ogjjPcCjo4SfbJ0N
   jS4WBeOrjB2Qkg7OBHkHME7eXrqKnfVFodOVd2En0Z/mmF9a7ZuW94xMG
   gfy4etW5NCUIbzm4VSSeDevB0wib1KGUGkjbJ5L/BfH4wSLi3cGwQDRjJ
   Z42EVtA9xw4WGHIGwaxeekvtEaQvCSGDO5/3HFcXrrQsHPeJ7wZ5auUVh
   TbmJENU/ujooNibnhmpun0XSIp6Wc6WjuHZIbysx8W+5Ty8gzf+FuMnGc
   lYPtLij7i6p1OezI3jZo/FZpnNEEasscEKBiyzVs1FQZSwaeggxuBQXB5
   Q==;
X-CSE-ConnectionGUID: 8AGfRqWUQ1GDufeunO5LjA==
X-CSE-MsgGUID: /WAsmTJ/R7WMHNm+1D+fZg==
Received: from mail-pj1-f70.google.com ([209.85.216.70])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:14:17 -0700
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d3bd8a0bd4so51888a91.0
        for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 16:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724886856; x=1725491656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ubakShXwxYDXEyQ5e6SBH3Tmky3hd4bNnHQvhjFLc+0=;
        b=TcQAIn8dhswgAjHAnOWy6/nuMK7J/C0MA3xFclfWHRFid05fkcBo2vHpuGd9BS/N2O
         gz4XO2FKKyHwtF3izWAHTYm/Ov/iQk0h7b90ZZlyfMXC95mpi2HY/5pG4YbaSB1jGD0H
         KmfGMhFM1sFK3H9m+eAVljSPjBi/iPKadBBbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724886856; x=1725491656;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubakShXwxYDXEyQ5e6SBH3Tmky3hd4bNnHQvhjFLc+0=;
        b=JMWoPoHUmnRcU7sd/gZq5UZYCTCfYETVJ5m3ha97KOQFAMo5IP9VI85GPAaf7GyGHz
         hScGz85XqDebV8xPOryw0pj1Hkb02nbLKdPOa3+WA7xUVWl6JkNOsKXPdblYefEbcETN
         z3JmiMs0KnXZSUBvi+pkVTKqov1Aelk6Fk9iI5M6LcaCoaoo9pxa5zS4IGWgjHn0PM7s
         XYq8B3sq5BbSQOjcLoMtNPQYRW+/2rm1M0vcyyHUc3PD0diWmkyuLAByTw+/E4mo7sMD
         /QSPI/rj7szAzQdclbFxMvR40+2BtsqXN1iTf09CZOalfLUBlFfALg8UfhUX2I12K8hh
         0NFg==
X-Forwarded-Encrypted: i=1; AJvYcCW8EsxfdtVdO2QmMPVq0wiW+tEy2PnajFyg70MMHVpiRUDDxMk1ng0cc5FnG1pPnW9+Ti838sZuopNmEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkc799UeUEjX5wFTE/PF9Ws/8Mx5QUgAGLQ7Mt7DLeSYwPuOzk
	UnyTO3Lc9O6XCktrDLb/xewIXs53GW9huganCtmaIbAV8gFjTwXB4x4Jj/B5f2kzYRi+b5Nm1k+
	esa88lPophOOCf8hIEcjXfLFJgArQq7BKTuSdWpOInBiZSGhyqVpqgnwrVIAijLkU9im6+YXD1C
	0HcJYstaQOuGpX/RDEwb86F8HO6lAeLqkTPS3X
X-Received: by 2002:a17:90a:7186:b0:2d3:cc3e:4d6d with SMTP id 98e67ed59e1d1-2d85618aa28mr866419a91.9.1724886855960;
        Wed, 28 Aug 2024 16:14:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELZUwDCC0XSsHLt2ynmKXe4TqsNr5t7zRZYRT3R66MQC6OI2xc2a2ro5R9vBhjSnNKvtK6QmdvVw7UVGytTXc=
X-Received: by 2002:a17:90a:7186:b0:2d3:cc3e:4d6d with SMTP id
 98e67ed59e1d1-2d85618aa28mr866401a91.9.1724886855476; Wed, 28 Aug 2024
 16:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:14:05 -0700
Message-ID: <CALAgD-6miPB6F2=89m90HzEGT4dmCX_ws1r26w7Vr8rtD8Z96Q@mail.gmail.com>
Subject: BUG: general protection fault in blk_mq_put_tag
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a  null
pointer dereference bug.
The reprodcuer is
https://gist.github.com/freexxxyyy/6f85bd6f69381fa00d04745376261c75

The bug report is:

Syzkaller hit 'general protection fault in blk_mq_put_tag' bug.

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 8453 Comm: kworker/0:5 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events_freezable_pwr_efficient disk_events_workfn
RIP: 0010:blk_mq_tag_is_reserved block/blk-mq.h:214 [inline]
RIP: 0010:blk_mq_put_tag+0x2b/0x130 block/blk-mq-tag.c:228
Code: 41 57 41 56 41 54 53 41 89 d7 49 89 f6 48 89 fb 49 bc 00 00 00
00 00 fc ff df e8 70 de 54 fd 48 8d 6b 04 48 89 e8 48 c1 e8 03 <42> 8a
04 20 84 c0 0f 85 9a 00 00 00 8b 6d 00 89 ef 44 89 fe e8 ec
RSP: 0018:ffffc9000b0cf6b0 EFLAGS: 00010247
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888018601e00
RDX: 0000000000000000 RSI: ffffe8ffffc0e9c0 RDI: 0000000000000000
RBP: 0000000000000004 R08: ffffffff843a3f0b R09: 1ffff11003a14613
R10: dffffc0000000000 R11: ffffffff8133c740 R12: dffffc0000000000
R13: ffff88801d195000 R14: ffffe8ffffc0e9c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555587d9e7a8 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __blk_mq_free_request+0x311/0x440 block/blk-mq.c:720
 scsi_execute_cmd+0xf07/0x1090 drivers/scsi/scsi_lib.c:351
 sr_get_events drivers/scsi/sr.c:177 [inline]
 sr_check_events+0x220/0xd30 drivers/scsi/sr.c:218
 cdrom_update_events drivers/cdrom/cdrom.c:1468 [inline]
 cdrom_check_events+0x66/0x100 drivers/cdrom/cdrom.c:1478
 disk_check_events+0x10f/0x5e0 block/disk-events.c:193
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:blk_mq_tag_is_reserved block/blk-mq.h:214 [inline]
RIP: 0010:blk_mq_put_tag+0x2b/0x130 block/blk-mq-tag.c:228
Code: 41 57 41 56 41 54 53 41 89 d7 49 89 f6 48 89 fb 49 bc 00 00 00
00 00 fc ff df e8 70 de 54 fd 48 8d 6b 04 48 89 e8 48 c1 e8 03 <42> 8a
04 20 84 c0 0f 85 9a 00 00 00 8b 6d 00 89 ef 44 89 fe e8 ec
RSP: 0018:ffffc9000b0cf6b0 EFLAGS: 00010247
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888018601e00
RDX: 0000000000000000 RSI: ffffe8ffffc0e9c0 RDI: 0000000000000000
RBP: 0000000000000004 R08: ffffffff843a3f0b R09: 1ffff11003a14613
R10: dffffc0000000000 R11: ffffffff8133c740 R12: dffffc0000000000
R13: ffff88801d195000 R14: ffffe8ffffc0e9c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd730046078 CR3: 000000001921e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 41 57                 push   %r15
   2: 41 56                 push   %r14
   4: 41 54                 push   %r12
   6: 53                   push   %rbx
   7: 41 89 d7             mov    %edx,%r15d
   a: 49 89 f6             mov    %rsi,%r14
   d: 48 89 fb             mov    %rdi,%rbx
  10: 49 bc 00 00 00 00 00 movabs $0xdffffc0000000000,%r12
  17: fc ff df
  1a: e8 70 de 54 fd       call   0xfd54de8f
  1f: 48 8d 6b 04           lea    0x4(%rbx),%rbp
  23: 48 89 e8             mov    %rbp,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 8a 04 20           mov    (%rax,%r12,1),%al <-- trapping instruction
  2e: 84 c0                 test   %al,%al
  30: 0f 85 9a 00 00 00     jne    0xd0
  36: 8b 6d 00             mov    0x0(%rbp),%ebp
  39: 89 ef                 mov    %ebp,%edi
  3b: 44 89 fe             mov    %r15d,%esi
  3e: e8                   .byte 0xe8
  3f: ec                   in     (%dx),%al

-- 
Yours sincerely,
Xingyu
