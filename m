Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CEA1C9DCB;
	Fri,  3 Jan 2025 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735890420; cv=none; b=kJH+FdUGYU2SQ3QKEQxhi81yYKj5GpowEUNBIWKZUzEL+uoW54C9wZEpLNzJPIu7wzQGU9CAqKtjtcSaXzXSHiAqG2k7XOQNpbhwwBe5xBf4ZJXLCsSTT+zzee1mL2DtY6RpFUe6tkPBXfWyRvGef0X6EeAlMTxT8pKKZdsTVIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735890420; c=relaxed/simple;
	bh=VLt9rpwPV38FGYOwb5OaugI89cfATc3txcCVxFgmiMk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=i1pIooaY1UvBCjXZzelcMPQcRWy+IlM/JxQIel8luTkWE8N/rIWk782fjYBae3KiU8TIDW1P5CzA6RnLxW8vQRudsa9B+eGmi4bzbXwFo+BV1F331CKcCJyEoDVQ/W70x+eGwFBJisdD0lZF7wZ/sSisKWw2os7YmXc9csqMqcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgTwUipC; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgTwUipC"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaec111762bso1796608666b.2;
        Thu, 02 Jan 2025 23:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735890416; x=1736495216; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VLt9rpwPV38FGYOwb5OaugI89cfATc3txcCVxFgmiMk=;
        b=RgTwUipC9Eq1QyfY7AvX13gXvPTfFoqPCsPI8AKSxvfNLzglLPafzliDKlNya3TDTq
         oAhu3roXw9c7EKTnelEhd1tPlrTs4VUMwDLdIZkwBjKFykn5Ftst4QqBzByTdPd/wxSG
         +B5/otBqsu9AAr3BGCFA9Txxq14kydF9O+9UitlEEgT+J4VcWj+OA7ccvF7FaMyEyjiO
         B2JtJryRIiFWB3yjmoCSev3Aw34EAlWMl59ar1cNEWFJg9Vtj8E8bWIgr1Szz/Q5TRZD
         3tTWdmIgTFgP13zZ+w/++ZZsspPQBidvgLdysEGNe3lUVIg/bXvsXmGwjCWCGZqkU9yc
         iIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735890416; x=1736495216;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLt9rpwPV38FGYOwb5OaugI89cfATc3txcCVxFgmiMk=;
        b=UUOZvPvXfxspHpSLcHPV7Zey7ogy7HXKe9i3DibhDcNY4AhfV2524fonkb4uCVFX/X
         pdcHbHYqd7Yqg48HoOYUkWv4/TwUlP3kOu548K1vgOFq5k3gJOrn1N3mC2TJjvoMLvmH
         mRwvIB3P+NL+jhJHh2K/mNOIBNI8ZG50jzddanaq6016AX4msw/eQ5buIhQaDODOsTbN
         4GlUTG1LvjepQjv8C+27Y8conbMQ+hQ1BHPeJmxShZFR6jknAhQKVRzoiQf2HhPIiLS+
         69c5BQsqChx/2fNP1eRVyL988WuO6oCRkzdODAydwvTnb6Q3EIkgf1v3Bg8z10TNHcdv
         h86w==
X-Forwarded-Encrypted: i=1; AJvYcCUpL7zIrlnn5kqaejE6IM0PFsQVrv977IfhIn5xcpLF9cqvuTYDSLcS/WrA1NU5P4cXztC3pEyjjeYbsZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3H7AMHwQum6lgQY35gRcmVdXA6fOpjihpoUhz1Mfao76AVDPh
	ZLVDg1IZ8SepBk3fbWr5DH7mWlW9X8WwWhgNdq4WVIXwIRhi5StY1efdKoBLceQTWkqjb74PHkR
	ong1grK3gSUlso7DXBb76GnI3a0qyr8+3
X-Gm-Gg: ASbGnctuSsn7qwPhLTJNsMn2eId/qlHXz6/Mec69QfTFkU8R+8/mWom7w6EVpCKUn9N
	ybdIrF+GFkT3Ab0fEL1SXIpXjhvoVNsEdIf/+dOY=
X-Google-Smtp-Source: AGHT+IEZUPbSlf8xxy/SsQbELadrGeTro9c6B8RiW/xRv0iupRA8J3s5KFLBZqIZKz/2G8pgkC6IxIGVrSyK42i8J5w=
X-Received: by 2002:a17:906:fd87:b0:aae:bd4c:2683 with SMTP id
 a640c23a62f3a-aaebd4c2951mr3913754666b.49.1735890415722; Thu, 02 Jan 2025
 23:46:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Fri, 3 Jan 2025 15:46:43 +0800
Message-ID: <CAKHoSAsdOYRU2BzqyURmfsKqaCLGXnsXGZ=kj+zkt5wjYVAg0g@mail.gmail.com>
Subject: "WARNING in del_gendisk" in Linux kernel version 5.15.169
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 5.15.169. This issue was discovered using our
custom vulnerability discovery tool.

Affected File: block/genhd.c

File: block/genhd.c

Function: del_gendisk

Detailed Call Stack:

------------[ cut here begin]------------

RIP: 0010:del_gendisk+0x63b/0x830 block/genhd.c:586
Code: 3c 03 0f 8e df 01 00 00 8b ab a0 00 00 00 31 ff 81 e5 00 04 00
00 89 ee e8 82 fe 54 ff 85 ed 0f 85 a8 fa ff ff e8 d5 fb 54 ff <0f> 0b
e9 71 ff ff ff e8 c9 fb 54 ff 48 8b 14 24 48 b8 00 00 00 00
netlink: 'syz.4.3926': attribute type 4 has an invalid length.
RSP: 0018:ffff888113ff7df8 EFLAGS: 00010216
RAX: 000000000000008c RBX: ffff88810af7c800 RCX: ffffc9000749c000
RDX: 0000000000040000 RSI: ffffffff81ed737b RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff888113ff7dbf
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88810af7c8a0
R13: ffff88810b351400 R14: ffff88810b351000 R15: ffff88810a70b1c0
FS: 00007f620e2b66c0(0000) GS:ffff88811af80000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001090f6000 CR4: 0000000000350ee0
Call Trace:
<TASK>
loop_remove+0x39/0xf0 drivers/block/loop.c:2452
loop_control_remove drivers/block/loop.c:2509 [inline]
loop_control_ioctl+0x44d/0x4d0 drivers/block/loop.c:2547
vfs_ioctl fs/ioctl.c:51 [inline]
__do_sys_ioctl fs/ioctl.c:874 [inline]
__se_sys_ioctl fs/ioctl.c:860 [inline]
__x64_sys_ioctl+0x19a/0x210 fs/ioctl.c:860
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x33/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x6c/0xd6
RIP: 0033:0x7f620f6e89c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f620e2b6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f620f904f80 RCX: 00007f620f6e89c9
RDX: 0000000020002540 RSI: 0000000000004c81 RDI: 0000000000000003
RBP: 00007f620f7951b6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f620f904f80 R15: 00007ffe5d3a2638
</TASK>
irq event stamp: 553
hardirqs last enabled at (559): [<ffffffff812b32ca>]
console_trylock_spinning kernel/printk/printk.c:1891 [inline]
hardirqs last enabled at (559): [<ffffffff812b32ca>]
vprintk_emit+0x3da/0x420 kernel/printk/printk.c:2273
hardirqs last disabled at (710): [<ffffffff812acf9d>]
__up_console_sem+0x5d/0x80 kernel/printk/printk.c:255
softirqs last enabled at (244): [<ffffffff81166c99>] __do_softirq
kernel/softirq.c:592 [inline]
softirqs last enabled at (244): [<ffffffff81166c99>] invoke_softirq
kernel/softirq.c:432 [inline]
softirqs last enabled at (244): [<ffffffff81166c99>] __irq_exit_rcu
kernel/softirq.c:641 [inline]
softirqs last enabled at (244): [<ffffffff81166c99>]
irq_exit_rcu+0xe9/0x130 kernel/softirq.c:653
softirqs last disabled at (187): [<ffffffff81166c99>] __do_softirq
kernel/softirq.c:592 [inline]
softirqs last disabled at (187): [<ffffffff81166c99>] invoke_softirq
kernel/softirq.c:432 [inline]
softirqs last disabled at (187): [<ffffffff81166c99>] __irq_exit_rcu
kernel/softirq.c:641 [inline]
softirqs last disabled at (187): [<ffffffff81166c99>]
irq_exit_rcu+0xe9/0x130 kernel/softirq.c:653

------------[ cut here end]------------

Root Cause:

The kernel crash is triggered by the del_gendisk function within the
block/genhd.c file at line 586. The root cause appears to be an
improperly formatted netlink message, specifically an attribute of
type 4 that has an invalid length. This malformed netlink message is
processed by the loop device driver (drivers/block/loop.c),
particularly during the removal of a loop device (loop_remove and
loop_control_remove functions). The invalid attribute leads to
incorrect handling within the loop device's ioctl operations
(loop_control_ioctl), ultimately causing del_gendisk to malfunction.
This sequence results in a kernel oops, crashing the system. The issue
likely stems from the loop device driver not adequately validating the
length of netlink message attributes before processing them, allowing
malformed data to disrupt kernel operations.

Thank you for your time and attention.

Best regards

Wall
