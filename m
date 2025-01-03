Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A1C2563
	for <linux-block@vger.kernel.org>; Fri,  3 Jan 2025 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735917900; cv=none; b=cfmmWuTdZBErWAzmBb5XEIZjC/dRj5vqS7cWqvBvpC2VwEWcKbKr5i+gQohAdmF1p4P7AvMQUoKmU+XEYIFagIPKhLO116wi3kuJ9+GLDAs8657Mw8ULaI3IYYE1CUSLcYcAhruFjstUHA4Y8j4Cl7Dv+apyrpwjRZPwlZgsIvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735917900; c=relaxed/simple;
	bh=vNoO6/RTa0+Cs8SCWZP2GdkyKrBoaUCJuB6YPQLrcrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GN7ZaoAJtp6euVyg5WUptrKUjnA2SsUNWNDZi14XkIJJtEvR1GaLcEufxIVS7q/jhSlBflt0ifSSZG346+x/AWsPyh0GqxDnudjlv6DAki+7TYheubqUHfTLl4DMkKFylGG7C/FHKoXmHKWHGFD5eivkVjbpCxWu6GFryWqceIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nw2qxk5G; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nw2qxk5G"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21619108a6bso160242945ad.3
        for <linux-block@vger.kernel.org>; Fri, 03 Jan 2025 07:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1735917898; x=1736522698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zctGW0WvkBYyGiHlWFyGzlm6qvTACwcFPwZXCT6d7uc=;
        b=Nw2qxk5GxdeNJFxmMV64s1KDAOBvx0Rr34+3LLy17zTlRfdLPR9Hdrxvv1Kr/hI8h9
         bgYXnq0/SztOmQHOveAfLiSrMZIoRpYki87sqYxGMM553L0ABu8vVMH4wG0rcuNgqWnk
         +slEADzKMtCwQrutr7esmV2mX99F8vlgxJOaddrBdxqiYbUQUDUMYVfzdABcG34slvJc
         Tqy8bmd1fbAg2cQgOOqT7hS07UKraaFt4qh6mb7yXDTqcbsRPZNyc3sYwsolM++2MGRr
         juXFWncfE1BkFMKUXfZRszLHPkwXpm1khHwIhNc8batKB2gtDbpT9Yq2sCMhwY4aEcF8
         N8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735917898; x=1736522698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zctGW0WvkBYyGiHlWFyGzlm6qvTACwcFPwZXCT6d7uc=;
        b=qdK25qCPoM6mbRN69AjPVzyklP6LJBN7/VgZzI5Ky5SyjH9ZvV4axkGS75/xDJro0T
         zy+jLrk2kirAUdv4V37A2A1q77n5/mN1MBjn+vhn3J2gqqZ3JfDKNXQkdY96eP+lqUZG
         eBwQiDBBoLA/myRxfKUqVgkFrF5SPIht6uM4k6f+nPF7ZhuyJi5Fp/85qCoBBHqwvkUS
         eXQJk1BHYeBpjKhSltMyc2OgcNUj9rbOY+T9G+stahdXnl+45O/4NmE3cBGIy1ln8O0b
         hHZaxFLfT4wus1/vollPeKKyYbKrUE/1w1XKL4JVa6YODXRwEMD4nlaoL28fpzo7Pt8z
         mxLg==
X-Gm-Message-State: AOJu0YxpMKx6Q9JCDKoX5QijyylFU4d+tiMgL2o0ihHbkEbKTFhz/12b
	Uc17lDLIbYUHaftfkKD5Ipd86F+kicx3fSf3R7MWPaVxgM+gPsVb2/4zRbM/lUA=
X-Gm-Gg: ASbGncscUuQfj1XEPfPAQ9AINHN36t8EarQ1n40oWdG0CHE6Nu4Qbo2Z6bf6fMzhPkc
	BeSgD6ttmJMafJeSgFIK0+9XUfaUNr5/WafbFGQjhxvROZsQoWcxnHEcpzI16cG3asPeJwEF+8o
	AGKd7hBraOYxHGAZhRJHCbgTRl3Y9bY1ICnj9OwrAtVtmhILH8pPSDiRD2TIM96vIRGscUYHUUg
	p/xuJDrKNuSBou+mTPGwz7mOzEu2MEpMkrur1TC8J2uw2UB3JqjkQ==
X-Google-Smtp-Source: AGHT+IHawLdmw6Z6xjOgGX3iTd3wlVJYov0tgtK9a2wvFPRQFW8H5uHpJYePAdZk23JdFu260Mvxjg==
X-Received: by 2002:a05:6a00:4485:b0:724:e80a:33a with SMTP id d2e1a72fcca58-72abdebc149mr77018351b3a.23.1735917897619;
        Fri, 03 Jan 2025 07:24:57 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fd820sm26343502b3a.170.2025.01.03.07.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 07:24:56 -0800 (PST)
Message-ID: <4308c0dd-2c42-4792-8264-4109913fc443@kernel.dk>
Date: Fri, 3 Jan 2025 08:24:55 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "WARNING in del_gendisk" in Linux kernel version 5.15.169
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAKHoSAsdOYRU2BzqyURmfsKqaCLGXnsXGZ=kj+zkt5wjYVAg0g@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAKHoSAsdOYRU2BzqyURmfsKqaCLGXnsXGZ=kj+zkt5wjYVAg0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/25 12:46 AM, cheung wall wrote:
> Hello,
> 
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version 5.15.169. This issue was discovered using our
> custom vulnerability discovery tool.
> 
> Affected File: block/genhd.c
> 
> File: block/genhd.c
> 
> Function: del_gendisk
> 
> Detailed Call Stack:
> 
> ------------[ cut here begin]------------
> 
> RIP: 0010:del_gendisk+0x63b/0x830 block/genhd.c:586
> Code: 3c 03 0f 8e df 01 00 00 8b ab a0 00 00 00 31 ff 81 e5 00 04 00
> 00 89 ee e8 82 fe 54 ff 85 ed 0f 85 a8 fa ff ff e8 d5 fb 54 ff <0f> 0b
> e9 71 ff ff ff e8 c9 fb 54 ff 48 8b 14 24 48 b8 00 00 00 00
> netlink: 'syz.4.3926': attribute type 4 has an invalid length.
> RSP: 0018:ffff888113ff7df8 EFLAGS: 00010216
> RAX: 000000000000008c RBX: ffff88810af7c800 RCX: ffffc9000749c000
> RDX: 0000000000040000 RSI: ffffffff81ed737b RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffff888113ff7dbf
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff88810af7c8a0
> R13: ffff88810b351400 R14: ffff88810b351000 R15: ffff88810a70b1c0
> FS: 00007f620e2b66c0(0000) GS:ffff88811af80000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 00000001090f6000 CR4: 0000000000350ee0
> Call Trace:
> <TASK>
> loop_remove+0x39/0xf0 drivers/block/loop.c:2452
> loop_control_remove drivers/block/loop.c:2509 [inline]
> loop_control_ioctl+0x44d/0x4d0 drivers/block/loop.c:2547
> vfs_ioctl fs/ioctl.c:51 [inline]
> __do_sys_ioctl fs/ioctl.c:874 [inline]
> __se_sys_ioctl fs/ioctl.c:860 [inline]
> __x64_sys_ioctl+0x19a/0x210 fs/ioctl.c:860
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x33/0x80 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x6c/0xd6
> RIP: 0033:0x7f620f6e89c9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f620e2b6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f620f904f80 RCX: 00007f620f6e89c9
> RDX: 0000000020002540 RSI: 0000000000004c81 RDI: 0000000000000003
> RBP: 00007f620f7951b6 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f620f904f80 R15: 00007ffe5d3a2638
> </TASK>
> irq event stamp: 553
> hardirqs last enabled at (559): [<ffffffff812b32ca>]
> console_trylock_spinning kernel/printk/printk.c:1891 [inline]
> hardirqs last enabled at (559): [<ffffffff812b32ca>]
> vprintk_emit+0x3da/0x420 kernel/printk/printk.c:2273
> hardirqs last disabled at (710): [<ffffffff812acf9d>]
> __up_console_sem+0x5d/0x80 kernel/printk/printk.c:255
> softirqs last enabled at (244): [<ffffffff81166c99>] __do_softirq
> kernel/softirq.c:592 [inline]
> softirqs last enabled at (244): [<ffffffff81166c99>] invoke_softirq
> kernel/softirq.c:432 [inline]
> softirqs last enabled at (244): [<ffffffff81166c99>] __irq_exit_rcu
> kernel/softirq.c:641 [inline]
> softirqs last enabled at (244): [<ffffffff81166c99>]
> irq_exit_rcu+0xe9/0x130 kernel/softirq.c:653
> softirqs last disabled at (187): [<ffffffff81166c99>] __do_softirq
> kernel/softirq.c:592 [inline]
> softirqs last disabled at (187): [<ffffffff81166c99>] invoke_softirq
> kernel/softirq.c:432 [inline]
> softirqs last disabled at (187): [<ffffffff81166c99>] __irq_exit_rcu
> kernel/softirq.c:641 [inline]
> softirqs last disabled at (187): [<ffffffff81166c99>]
> irq_exit_rcu+0xe9/0x130 kernel/softirq.c:653
> 
> ------------[ cut here end]------------
> 
> Root Cause:
> 
> The kernel crash is triggered by the del_gendisk function within the
> block/genhd.c file at line 586. The root cause appears to be an
> improperly formatted netlink message, specifically an attribute of
> type 4 that has an invalid length. This malformed netlink message is
> processed by the loop device driver (drivers/block/loop.c),
> particularly during the removal of a loop device (loop_remove and
> loop_control_remove functions). The invalid attribute leads to
> incorrect handling within the loop device's ioctl operations
> (loop_control_ioctl), ultimately causing del_gendisk to malfunction.
> This sequence results in a kernel oops, crashing the system. The issue
> likely stems from the loop device driver not adequately validating the
> length of netlink message attributes before processing them, allowing
> malformed data to disrupt kernel operations.

What kind of nonsense is this? It reads very much like it was
auto-generated, it definitely did not have a real human try and
understand what could possibly be going on here.

If this is the level of effort put into your "custom vulnerability
discovery" tool, then please just don't bother.

-- 
Jens Axboe
