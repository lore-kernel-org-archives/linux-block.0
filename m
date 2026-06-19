Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB41734404E
	for <linux-block@vger.kernel.org>; Fri, 19 Jun 2026 06:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781851406; cv=none; b=dk7ysrvIhidqS+0t8BUjqODSxfMLVJWF6AvFk0m3NogewzAVTz4snQWoI3zF5xHd6e61R6BdkZlPyRhC8aepHaFRZ99/UEawzzDuDa/wdOBEIgYvt3t8egvWXmQuHirFIlg6slsoYy+D1l8K5El3/Pz1NkWa+F8Ovbtgksa/+l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781851406; c=relaxed/simple;
	bh=5BBzsIvmyc/zgbEhppG5huRJsMEJcvrkfrtiqQUDuhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjIughIu3vEA3NUUPCihV3S3VABu24vESAIhBUuIr94JnTL832NUAUZf2UacoKznLhSUryzkVtyz8QpKXMeAYGwU6FAwWmyJOBvzU2v4IDRaGtgrL7/mI1xKtTHa1gqGvXZ6X/1LB2QZmlZgfSuR/nH241H7sKuCdS2TmxMizD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so5865205e9.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2026 23:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781851403; x=1782456203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCsbXUGkyJyt5cLqTftZJxCpEr0ouE6jeAEnIdAT8W4=;
        b=PL0VbMIfbBgvnz02hOhoeHAghxMPDST7ZBLelpmZnFJNrEWZD77YPjZw7TiXrQGnEV
         /QNkQ/It9106bfATGu1aX9cUP32YpyMSnhPCzDWmxrnSgY8ay+REcJSnu+oKQ5tGmjCq
         ENZF8ys+n5rlROtAyjwgNJVZW9Unifp7HAy2kQ9MhNrGj8X0kkrY//4KuYZ1SFhNCUWH
         0YgvH1YfgndNjbXqO6q+Ny0qX/PbBs4XEY6cgVoxreN5nb3JzgMApuvEK8qTeCGcqwIP
         MiFg53E+yus8fgNWticnMzCdbIJ+1v/mwTpvd8rofSAtBufyVrPfuyih+mfHfY79vlqt
         GrnA==
X-Forwarded-Encrypted: i=1; AFNElJ9dpO956EdLBu4l+JRv5ojqX00vjXR1z95n2NQQxUIjtdVTyNEDVpV6JTHAvN9FY240tG9EHtievi11YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyaSnI3GCOVytioES/h3JwlhYmCr2iawLwCiEk/ewtWvv1wNFI
	XtnfdGBn7qOZ2ubBvzFaEjyqL40R5WTM1OPZj0GMiciqfNdjhZYD54e8
X-Gm-Gg: AfdE7cm9vwMBm5WIYDnwtURoVQTVJsStexOoAfzCA0I3mLuiF9qIRUSbp7ZLimpk0n1
	cYYnEVsxkFE8l5Jtqa2cqeVtyRn7k1zGkGlMIeH3qtkjAJGUFq6UqR6VCaoBiczhOZ/seogevrI
	DUu8CJKJw8rQs92wjFegJl3Wv00wOcrf7TqVsQf4OHGsPUhFaw/A0KXZpqv96eFZTHAJ8aIj4vS
	rZQMr4t+Ywunxlw/fob3u+woXAkPaI4FichdViU0nWZH+7RjZLmBN5/o0wvTpBtiDwFjP6y/Qdi
	OeJpF2oy2NMkbavTGI//kimwHu7QieFnUropHe+X2VaM0yhxU/6ShU+0C6agIIcxGmK2xGAppCE
	y6vea59vwNigNjg6CpF9emJFwJURaCgi5xm6ABnmT5B7vmUCfope4Bhr2yF6x4OSStF/MSOKG9x
	fz2oj6xz1hWNB9j0X35xJRd3IYKVQmHLmtsgdEXBgtrvq4POY=
X-Received: by 2002:a05:600c:1d29:b0:492:3fc4:bd6b with SMTP id 5b1f17b1804b1-49242314120mr21713975e9.7.1781851402942;
        Thu, 18 Jun 2026 23:43:22 -0700 (PDT)
Received: from [10.68.32.41] (bba-176-205-20-16.alshamil.net.ae. [176.205.20.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240ee9bc2sm26203125e9.1.2026.06.18.23.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 23:43:22 -0700 (PDT)
Message-ID: <4e3a04ab-58d4-4204-b97d-6ef163e1a1b6@linux.com>
Date: Fri, 19 Jun 2026 10:43:18 +0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: WARNING: at floppy_interrupt, CPU: swapper/NUM/NUM
To: sanan.hasanou@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, contact@pgazz.com
References: <6a34707b.25ac79d9.2b1a46.0a67@mx.google.com>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <6a34707b.25ac79d9.2b1a46.0a67@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Thank you for the report. This is a known warning that only happens in a virtualized
environment. You may want to add this piece of a config to your modified syzkaller
dashboard/config/linux/bits/unmaintained.yml

Thanks,
Denis

On 19/06/2026 02:26, sanan.hasanou@gmail.com wrote:
> Good day, dear maintainers,
> 
> We found a bug using a modified version of syzkaller.
> 
> Kernel Branch: 7.0-rc1
> Kernel Config: <https://drive.google.com/open?id=173DLEAEPKPhhR1TcqofdnkLpdoK7PMFl>
> Unfortunately, we don't have any reproducer for this bug yet.
> Thank you!
> 
> Best regards,
> Sanan Hasanov
> 
> ------------[ cut here ]------------
> WARNING: at schedule_bh drivers/block/floppy.c:1000 [inline], CPU#0: swapper/0/1
> WARNING: at floppy_interrupt+0x51b/0x560 drivers/block/floppy.c:1766, CPU#0: swapper/0/1
> Modules linked in:
> CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc1 #1 PREEMPT(full) 
> Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:schedule_bh drivers/block/floppy.c:1000 [inline]
> RIP: 0010:floppy_interrupt+0x51b/0x560 drivers/block/floppy.c:1766
> Code: 35 3a c8 54 0c 48 c7 c7 80 fa 4b 8c 48 c7 c2 c0 f7 4b 8c 48 c7 c1 40 f9 4b 8c e8 a0 4a 3b fb e9 af fe ff ff e8 66 d9 d5 fb 90 <0f> 0b 90 e9 e8 fc ff ff 44 89 f9 80 e1 07 38 c1 0f 8c 27 fc ff ff
> RSP: 0018:ffffc90000007af8 EFLAGS: 00010006
> RAX: ffffffff85ec786a RBX: ffffffff85ecf380 RCX: ffff888016aeba80
> RDX: 0000000000010100 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff8f3e2467 R09: 1ffffffff1e7c48c
> R10: dffffc0000000000 R11: fffffbfff1e7c48d R12: dffffc0000000000
> R13: 0000000000000000 R14: 0000000002000011 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880d98df000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff888012801000 CR3: 000000000e6ff000 CR4: 00000000000006f0
> Call Trace:
>  <IRQ>
>  __handle_irq_event_percpu+0x1d9/0x5d0 kernel/irq/handle.c:209
>  handle_irq_event_percpu kernel/irq/handle.c:246 [inline]
>  handle_irq_event+0x90/0x1e0 kernel/irq/handle.c:263
>  handle_edge_irq+0x239/0x9e0 kernel/irq/chip.c:855
>  generic_handle_irq_desc include/linux/irqdesc.h:186 [inline]
>  handle_irq arch/x86/kernel/irq.c:262 [inline]
>  call_irq_handler arch/x86/kernel/irq.c:286 [inline]
>  __common_interrupt+0xc5/0x170 arch/x86/kernel/irq.c:333
>  common_interrupt+0x4a/0xc0 arch/x86/kernel/irq.c:326
>  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688
> RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:188 [inline]
> RIP: 0010:_raw_spin_unlock_irq+0x19/0x30 kernel/locking/spinlock.c:202
> Code: 00 02 00 00 75 db eb da e8 74 c0 a8 f5 5b c3 66 90 f3 0f 1e fa 0f 1f 44 00 00 e8 f2 b4 12 f6 e8 4d 86 41 f6 fb bf 01 00 00 00 <e8> d2 2a 07 f6 65 8b 05 8b 59 88 06 85 c0 74 01 c3 e8 41 c0 a8 f5
> RSP: 0018:ffffc90000007d58 EFLAGS: 00000246
> RAX: 0000000000000001 RBX: ffffffff85358ab0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
> RBP: ffffc90000007ef8 R08: ffff88806ba2f683 R09: 1ffff1100d745ed0
> R10: dffffc0000000000 R11: ffffed100d745ed1 R12: ffff88801d085478
> R13: dffffc0000000000 R14: ffff88806ba2f680 R15: ffff88806ba2f698
>  expire_timers kernel/time/timer.c:1798 [inline]
>  __run_timers kernel/time/timer.c:2373 [inline]
>  __run_timer_base+0x700/0xa30 kernel/time/timer.c:2385
>  run_timer_base kernel/time/timer.c:2394 [inline]
>  run_timer_softirq+0xbc/0x190 kernel/time/timer.c:2404
>  handle_softirqs+0x1ed/0x700 kernel/softirq.c:622
>  __do_softirq kernel/softirq.c:656 [inline]
>  invoke_softirq kernel/softirq.c:496 [inline]
>  __irq_exit_rcu+0x8e/0x270 kernel/softirq.c:723
>  irq_exit_rcu+0xe/0x30 kernel/softirq.c:739
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
>  sysvec_apic_timer_interrupt+0x92/0xb0 arch/x86/kernel/apic/apic.c:1056
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
> RIP: 0010:clear_pages arch/x86/include/asm/page_64.h:103 [inline]
> RIP: 0010:clear_page arch/x86/include/asm/page_64.h:114 [inline]
> RIP: 0010:clear_highpage_kasan_tagged include/linux/highmem.h:344 [inline]
> RIP: 0010:kernel_init_pages mm/page_alloc.c:1265 [inline]
> RIP: 0010:post_alloc_hook+0x3ff/0x480 mm/page_alloc.c:1887
> Code: 03 49 c7 c7 20 2e 43 8e 49 c1 ef 03 eb 2f 48 8b 3d c6 74 21 0c 49 c1 e5 06 4c 29 ef 4c 01 e7 b9 00 10 00 00 31 c0 48 c1 e9 03 <f3> 48 ab 49 81 c4 00 10 00 00 49 ff ce 0f 84 31 fd ff ff 48 b8 00
> RSP: 0018:ffffc9000001eed8 EFLAGS: 00000216
> RAX: 0000000000000000 RBX: 1ffffffff1c865c6 RCX: 0000000000000200
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801dc20000
> RBP: 0000000000000003 R08: ffffffff9049fd6f R09: 0000000000000000
> R10: ffffed1003b84000 R11: fffffbfff2093fae R12: fffa80001dc20000
> R13: fffa800000000000 R14: 0000000000000008 R15: 1ffffffff1c865c4
>  prep_new_page mm/page_alloc.c:1897 [inline]
>  get_page_from_freelist+0x2240/0x2330 mm/page_alloc.c:3962
>  __alloc_frozen_pages_noprof+0x20e/0x3d0 mm/page_alloc.c:5250
>  __alloc_pages_noprof+0xf/0x30 mm/page_alloc.c:5284
>  vm_area_alloc_pages mm/vmalloc.c:-1 [inline]
>  __vmalloc_area_node mm/vmalloc.c:3876 [inline]
>  __vmalloc_node_range_noprof+0x79f/0x1580 mm/vmalloc.c:4064
>  __vmalloc_node_noprof mm/vmalloc.c:4124 [inline]
>  vzalloc_noprof+0xdf/0x120 mm/vmalloc.c:4202
>  allocate_partitions block/partitions/core.c:101 [inline]
>  check_partition block/partitions/core.c:123 [inline]
>  blk_add_partitions block/partitions/core.c:590 [inline]
>  bdev_disk_changed+0x628/0x1810 block/partitions/core.c:694
>  blkdev_get_whole+0x37e/0x500 block/bdev.c:764
>  bdev_open+0x35b/0xdc0 block/bdev.c:973
>  bdev_file_open_by_dev+0x1c3/0x240 block/bdev.c:1075
>  disk_scan_partitions+0x1be/0x2c0 block/genhd.c:387
>  add_disk_final block/genhd.c:416 [inline]
>  add_disk_fwnode+0x31e/0x470 block/genhd.c:610
>  add_disk include/linux/blkdev.h:785 [inline]
>  brd_alloc+0x5de/0x810 drivers/block/brd.c:340
>  brd_init+0xc6/0x120 drivers/block/brd.c:420
>  do_one_initcall+0x1a1/0x530 init/main.c:1382
>  do_initcall_level+0x117/0x1a0 init/main.c:1444
>  do_initcalls+0xe1/0x150 init/main.c:1460
>  kernel_init_freeable+0x207/0x310 init/main.c:1692
>  kernel_init+0x22/0x1d0 init/main.c:1582
>  ret_from_fork+0x608/0xc40 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:245
>  </TASK>
> ----------------
> Code disassembly (best guess):
>    0:	00 02                	add    %al,(%rdx)
>    2:	00 00                	add    %al,(%rax)
>    4:	75 db                	jne    0xffffffe1
>    6:	eb da                	jmp    0xffffffe2
>    8:	e8 74 c0 a8 f5       	call   0xf5a8c081
>    d:	5b                   	pop    %rbx
>    e:	c3                   	ret
>    f:	66 90                	xchg   %ax,%ax
>   11:	f3 0f 1e fa          	endbr64
>   15:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>   1a:	e8 f2 b4 12 f6       	call   0xf612b511
>   1f:	e8 4d 86 41 f6       	call   0xf6418671
>   24:	fb                   	sti
>   25:	bf 01 00 00 00       	mov    $0x1,%edi
> * 2a:	e8 d2 2a 07 f6       	call   0xf6072b01 <-- trapping instruction
>   2f:	65 8b 05 8b 59 88 06 	mov    %gs:0x688598b(%rip),%eax        # 0x68859c1
>   36:	85 c0                	test   %eax,%eax
>   38:	74 01                	je     0x3b
>   3a:	c3                   	ret
>   3b:	e8 41 c0 a8 f5       	call   0xf5a8c081
> 
> <<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

