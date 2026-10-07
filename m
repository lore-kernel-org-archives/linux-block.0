Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BD049BD75
	for <linux-block@vger.kernel.org>; Wed,  7 Oct 2026 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371968; cv=none; b=L7YOHPxj3eAKkDp8KqkTzx/O/77TUoB1jWwufuYNyGdJUh5Aaoxv/1tux1iZQQm7zyfwfxUE5RKeHdqTWO9onAG/Iryn9IRKfsuK2VwTd1QtaankDCEm3/jjrElVGLQk4SeYuU1Gg4+EFWqENpu6FrATl+D9cnqlLSyHmmzCmNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371968; c=relaxed/simple;
	bh=Uh0KC1tniDTZ35j1zZcsBHyilSDljQrY2ag6SEj1v/c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m14w+d2/MKVOYaZazeHHm1uy7AEmgfZnXOYcSByATOGSvktHP4vhCCyo0s9vmYStvcrbNcYCCTrhPd/URz+OTy7U3tQpu0vHeu+32d4URNoZNr4uM68Bj/+Atn5oRp447p7ygzOp2+t1/Qkzn/AP9ZlDaLO8C/X1oiVtLCl6fx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4c307941971so5564129b6e.1
        for <linux-block@vger.kernel.org>; Wed, 07 Oct 2026 04:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791371925; x=1791976725;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qzMt2WAtFdpsaLraZyitCf/VYnBsrpppiLkzzCzFyjA=;
        b=EkMnhQ37Bty0gowh+SAgSE0Jy6KuYhgnSDda7heCDyUgPKHVqcdi+jGvVNneSuJIF6
         H+682au4/OBw9tm2MurnhRdySCRPD7KttaiHL1ec/VoMOHXzp1ymZGdmYMRfpLgh0RNb
         ih9BfUwCOP3I7Z/1Hdn3SdKkiqIr1+UBiX/vN2nCRO9NMpuAllUV6B+KvjaS3C47FmKZ
         xT4yJ+K3ed64C1SSJ/6nP06zAyvp2oDfoPuA97Kq6GxQzD7Qjp1EeA2gEvbsUfG4y99s
         yJ4MCXEJQtZKm2R/zs3Y8U9QNVByflvRJwcAu+om29lMIlisbZd+21eyl1RGIAydT+1t
         36PA==
X-Forwarded-Encrypted: i=1; AKwUvBxMRxnyEYtidv6gXasAVEz8LHYsaLeaM5NQ2kn0/biaTTKpObKKzcaXuCo3VRyZIm2reB/Q0PUERJT0dQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lCdI4im0h8m7ksAjXYVYBJ+Et8Ll5ErVeiAn/IOkQzuHGGEY72
	xS0pSrb7laIoqQGUumZp3rOWnIQH16AUga5yhJGu96tUESu/5hNDwh5q8S3R+t44n+NALr7jSiJ
	D6TP7ruHk/3smtNpCK6XE/YRfn4iqJSfDSvVv225UKRgYf4oZwnIPIV0VsoA=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f09:b0:4c4:5f5b:6918 with SMTP id
 5614622812f47-4fc45d5e76amr2726028b6e.16.1791371925180; Wed, 07 Oct 2026
 04:18:45 -0700 (PDT)
Date: Wed, 07 Oct 2026 04:18:45 -0700
In-Reply-To: <6a900c70.50659fcc.60cd.0013.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac62a95.d03902a3.74d6f.0002.GAE@google.com>
Subject: Re: [syzbot] [block?] BUG: unable to handle kernel paging request in blk_mq_complete_request_remote
From: syzbot <syzbot+2e3bf0bd49acd9b21d4b@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    71c3e5409eef Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13c9400d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7205f05c11fb4dd
dashboard link: https://syzkaller.appspot.com/bug?extid=2e3bf0bd49acd9b21d4b
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c9400d580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14fa21c9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/20ff6159ce99/disk-71c3e540.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1d6172672705/vmlinux-71c3e540.xz
kernel image: https://storage.googleapis.com/syzbot-assets/923d5e083e1b/Image-71c3e540.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e3bf0bd49acd9b21d4b@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address dfff800000000031
KASAN: null-ptr-deref in range [0x0000000000000188-0x000000000000018f]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0
[dfff800000000031] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 41 Comm: pr/ttyAMA-1 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
pstate: 034000c5 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : blk_mq_complete_request_remote+0xc4/0x858 block/blk-mq.c:1310
lr : blk_mq_complete_request_remote+0x88/0x858 block/blk-mq.c:1302
sp : ffff80008eac7ba0
x29: ffff80008eac7c30 x28: ffff80008eac7ba0 x27: 1fffe000190b201c
x26: 0000000000000001 x25: ffff0000c85900ee x24: dfff800000000000
x23: ffff700011d58f74 x22: 1fffe000190c0f24 x21: ffff0000c8607924
x20: 000000000000018e x19: ffff0000c8607800 x18: ffff800125472000
x17: ffff800125472000 x16: ffff80008eac0000 x15: 0000000000000000
x14: 00000000001afe2f x13: 0000000000000005 x12: 0000000000000000
x11: ffff80008eac7d98 x10: ffff8000883f0335 x9 : 1fffe000190c0f02
x8 : 0000000000000031 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffff8000827e349c
x2 : 0000000000000000 x1 : ffff0000c24b9d80 x0 : 0000000000000000
Call trace:
 blk_mq_complete_request_remote+0xc4/0x858 block/blk-mq.c:1310 (P)
 nvme_try_complete_req drivers/nvme/host/nvme.h:839 [inline]
 nvme_handle_cqe drivers/nvme/host/pci.c:1601 [inline]
 nvme_poll_cq+0x544/0xfd8 drivers/nvme/host/pci.c:1632
 nvme_irq+0x9c/0x120 drivers/nvme/host/pci.c:1646
 __handle_irq_event_percpu+0x200/0x8ac kernel/irq/handle.c:209
 handle_irq_event_percpu+0x2c/0xd8 kernel/irq/handle.c:246
 handle_irq_event+0x98/0x188 kernel/irq/handle.c:263
 handle_fasteoi_irq+0x328/0x864 kernel/irq/chip.c:768
 generic_handle_irq_desc include/linux/irqdesc.h:188 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:679 [inline]
 generic_handle_domain_irq+0xe4/0x154 kernel/irq/irqdesc.c:735
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:873 [inline]
 gic_handle_irq+0x6c/0x180 drivers/irqchip/irq-gic-v3.c:917
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:901
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:216
 __el1_irq arch/arm64/kernel/entry-common.c:568 [inline]
 el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:581
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:586
 el1h_64_irq+0x78/0x7c arch/arm64/kernel/entry.S:602
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline] (P)
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:221 (P)
 spin_unlock_irqrestore include/linux/spinlock.h:425 [inline]
 __uart_port_unlock_irqrestore include/linux/serial_core.h:622 [inline]
 pl011_console_device_unlock+0x94/0xcc drivers/tty/serial/amba-pl011.c:2721
 nbcon_emit_one+0x160/0x1e4 kernel/printk/nbcon.c:1165
 nbcon_kthread_func+0x56c/0x6c0 kernel/printk/nbcon.c:1271
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
Code: 97d041fa f9400288 91063914 d343fe88 (38f86908) 
---[ end trace 0000000000000000 ]---
Calling EFI runtime from hardirq context
------------[ cut here ]------------
WARNING: arch/arm64/kernel/traps.c:414 at force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414, CPU#0: pr/ttyAMA-1/41
Modules linked in:
CPU: 0 UID: 0 PID: 41 Comm: pr/ttyAMA-1 Tainted: G      D             syzkaller #0 PREEMPT 
Tainted: [D]=DIE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
pstate: 034000c5 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
lr : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
sp : ffff80008eac71c0
x29: ffff80008eac71c0 x28: ffff80008eac74c0 x27: dfff800000000000
x26: 0000000000000000 x25: ffff80008efe0000 x24: dfff800000000000
x23: 0000000000000005 x22: 0000000000000009 x21: 0000000000000080
x20: 0000000000000000 x19: 0000000000000000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000881 x13: 0000000000000001 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000001000005 x9 : 0000000001000004
x8 : ffff0000c24b9d80 x7 : 0000000000000001 x6 : ffff800080482944
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000801524f4
x2 : 0000000000000005 x1 : ffff0000c24b9d80 x0 : 0000000000000000
Call trace:
 force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414 (P)
 __efi_fpsimd_begin+0xd8/0x21c arch/arm64/kernel/fpsimd.c:2010
 arch_efi_call_virt_setup+0xb4/0x254 arch/arm64/kernel/efi.c:187
 virt_efi_set_variable_nb+0x9c/0x110 drivers/firmware/efi/runtime-wrappers.c:492
 efivar_set_variable_locked+0x1cc/0x208 drivers/firmware/efi/vars.c:231
 efi_pstore_write+0x2d4/0x418 drivers/firmware/efi/efi-pstore.c:227
 pstore_dump+0x57c/0x8e8 fs/pstore/platform.c:355
 kmsg_dump_desc+0x1f4/0x328 kernel/printk/printk.c:4880
 kmsg_dump include/linux/kmsg_dump.h:123 [inline]
 oops_exit+0x34/0x40 kernel/panic.c:1066
 die+0xb8/0x1d4 arch/arm64/kernel/traps.c:224
 die_kernel_fault+0x6c/0x80 arch/arm64/mm/fault.c:358
 __do_kernel_fault+0x55c/0x590 arch/arm64/mm/fault.c:458
 do_bad_area+0x7c/0x148 arch/arm64/mm/fault.c:533
 do_translation_fault+0xdc/0x114 arch/arm64/mm/fault.c:851
 do_mem_abort+0x70/0x194 arch/arm64/mm/fault.c:1012
 el1_abort+0x50/0x74 arch/arm64/kernel/entry-common.c:380
 el1h_64_sync_handler+0xdc/0x130 arch/arm64/kernel/entry-common.c:507
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:601
 blk_mq_complete_request_remote+0xc4/0x858 block/blk-mq.c:1310 (P)
 nvme_try_complete_req drivers/nvme/host/nvme.h:839 [inline]
 nvme_handle_cqe drivers/nvme/host/pci.c:1601 [inline]
 nvme_poll_cq+0x544/0xfd8 drivers/nvme/host/pci.c:1632
 nvme_irq+0x9c/0x120 drivers/nvme/host/pci.c:1646
 __handle_irq_event_percpu+0x200/0x8ac kernel/irq/handle.c:209
 handle_irq_event_percpu+0x2c/0xd8 kernel/irq/handle.c:246
 handle_irq_event+0x98/0x188 kernel/irq/handle.c:263
 handle_fasteoi_irq+0x328/0x864 kernel/irq/chip.c:768
 generic_handle_irq_desc include/linux/irqdesc.h:188 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:679 [inline]
 generic_handle_domain_irq+0xe4/0x154 kernel/irq/irqdesc.c:735
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:873 [inline]
 gic_handle_irq+0x6c/0x180 drivers/irqchip/irq-gic-v3.c:917
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:901
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:216
 __el1_irq arch/arm64/kernel/entry-common.c:568 [inline]
 el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:581
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:586
 el1h_64_irq+0x78/0x7c arch/arm64/kernel/entry.S:602
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline] (P)
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:221 (P)
 spin_unlock_irqrestore include/linux/spinlock.h:425 [inline]
 __uart_port_unlock_irqrestore include/linux/serial_core.h:622 [inline]
 pl011_console_device_unlock+0x94/0xcc drivers/tty/serial/amba-pl011.c:2721
 nbcon_emit_one+0x160/0x1e4 kernel/printk/nbcon.c:1165
 nbcon_kthread_func+0x56c/0x6c0 kernel/printk/nbcon.c:1271
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
irq event stamp: 19610
hardirqs last  enabled at (19609): [<ffff80008688fdec>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline]
hardirqs last  enabled at (19609): [<ffff80008688fdec>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:221
hardirqs last disabled at (19610): [<ffff80008686ba58>] __el1_irq arch/arm64/kernel/entry-common.c:565 [inline]
hardirqs last disabled at (19610): [<ffff80008686ba58>] el1_interrupt+0x28/0x60 arch/arm64/kernel/entry-common.c:581
softirqs last  enabled at (19568): [<ffff80008030a6dc>] softirq_handle_end kernel/softirq.c:491 [inline]
softirqs last  enabled at (19568): [<ffff80008030a6dc>] handle_softirqs+0xb2c/0xcbc kernel/softirq.c:673
softirqs last disabled at (19425): [<ffff8000800203f0>] __do_softirq+0x14/0x20 kernel/softirq.c:679
---[ end trace 0000000000000000 ]---
Calling EFI runtime from hardirq context
------------[ cut here ]------------
WARNING: arch/arm64/kernel/traps.c:414 at force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414, CPU#0: pr/ttyAMA-1/41
Modules linked in:
CPU: 0 UID: 0 PID: 41 Comm: pr/ttyAMA-1 Tainted: G      D W           syzkaller #0 PREEMPT 
Tainted: [D]=DIE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
pstate: 034000c5 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
lr : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
sp : ffff80008eac71c0
x29: ffff80008eac71c0 x28: ffff80008eac74c0 x27: dfff800000000000
x26: 0000000000000000 x25: ffff80008efe0000 x24: dfff800000000000
x23: 0000000000000005 x22: 0000000000000009 x21: 0000000000000080
x20: 0000000000000000 x19: 0000000000000000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 00000000000008e3 x13: 0000000000000001 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000001000005 x9 : 0000000001000004
x8 : ffff0000c24b9d80 x7 : 0000000000000001 x6 : ffff800080482944
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000801524f4
x2 : 0000000000000005 x1 : ffff0000c24b9d80 x0 : 0000000000000000
Call trace:
 force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414 (P)
 __efi_fpsimd_begin+0xd8/0x21c arch/arm64/kernel/fpsimd.c:2010
 arch_efi_call_virt_setup+0xb4/0x254 arch/arm64/kernel/efi.c:187
 virt_efi_set_variable_nb+0x9c/0x110 drivers/firmware/efi/runtime-wrappers.c:492
 efivar_set_variable_locked+0x1cc/0x208 drivers/firmware/efi/vars.c:231
 efi_pstore_write+0x2d4/0x418 drivers/firmware/efi/efi-pstore.c:227
 pstore_dump+0x57c/0x8e8 fs/pstore/platform.c:355
 kmsg_dump_desc+0x1f4/0x328 kernel/printk/printk.c:4880
 kmsg_dump include/linux/kmsg_dump.h:123 [inline]
 oops_exit+0x34/0x40 kernel/panic.c:1066
 die+0xb8/0x1d4 arch/arm64/kernel/traps.c:224
 die_kernel_fault+0x6c/0x80 arch/arm64/mm/fault.c:358
 __do_kernel_fault+0x55c/0x590 arch/arm64/mm/fault.c:458
 do_bad_area+0x7c/0x148 arch/arm64/mm/fault.c:533
 do_translation_fault+0xdc/0x114 arch/arm64/mm/fault.c:851
 do_mem_abort+0x70/0x194 arch/arm64/mm/fault.c:1012
 el1_abort+0x50/0x74 arch/arm64/kernel/entry-common.c:380
 el1h_64_sync_handler+0xdc/0x130 arch/arm64/kernel/entry-common.c:507
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:601
 blk_mq_complete_request_remote+0xc4/0x858 block/blk-mq.c:1310 (P)
 nvme_try_complete_req drivers/nvme/host/nvme.h:839 [inline]
 nvme_handle_cqe drivers/nvme/host/pci.c:1601 [inline]
 nvme_poll_cq+0x544/0xfd8 drivers/nvme/host/pci.c:1632
 nvme_irq+0x9c/0x120 drivers/nvme/host/pci.c:1646
 __handle_irq_event_percpu+0x200/0x8ac kernel/irq/handle.c:209
 handle_irq_event_percpu+0x2c/0xd8 kernel/irq/handle.c:246
 handle_irq_event+0x98/0x188 kernel/irq/handle.c:263
 handle_fasteoi_irq+0x328/0x864 kernel/irq/chip.c:768
 generic_handle_irq_desc include/linux/irqdesc.h:188 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:679 [inline]
 generic_handle_domain_irq+0xe4/0x154 kernel/irq/irqdesc.c:735
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:873 [inline]
 gic_handle_irq+0x6c/0x180 drivers/irqchip/irq-gic-v3.c:917
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:901
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:216
 __el1_irq arch/arm64/kernel/entry-common.c:568 [inline]
 el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:581
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:586
 el1h_64_irq+0x78/0x7c arch/arm64/kernel/entry.S:602
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline] (P)
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:221 (P)
 spin_unlock_irqrestore include/linux/spinlock.h:425 [inline]
 __uart_port_unlock_irqrestore include/linux/serial_core.h:622 [inline]
 pl011_console_device_unlock+0x94/0xcc drivers/tty/serial/amba-pl011.c:2721
 nbcon_emit_one+0x160/0x1e4 kernel/printk/nbcon.c:1165
 nbcon_kthread_func+0x56c/0x6c0 kernel/printk/nbcon.c:1271
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
irq event stamp: 19610
hardirqs last  enabled at (19609): [<ffff80008688fdec>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline]
hardirqs last  enabled at (19609): [<ffff80008688fdec>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:221
hardirqs last disabled at (19610): [<ffff80008686ba58>] __el1_irq arch/arm64/kernel/entry-common.c:565 [inline]
hardirqs last disabled at (19610): [<ffff80008686ba58>] el1_interrupt+0x28/0x60 arch/arm64/kernel/entry-common.c:581
softirqs last  enabled at (19568): [<ffff80008030a6dc>] softirq_handle_end kernel/softirq.c:491 [inline]
softirqs last  enabled at (19568): [<ffff80008030a6dc>] handle_softirqs+0xb2c/0xcbc kernel/softirq.c:673
softirqs last disabled at (19425): [<ffff8000800203f0>] __do_softirq+0x14/0x20 kernel/softirq.c:679
---[ end trace 0000000000000000 ]---
Calling EFI runtime from hardirq context
------------[ cut here ]------------
WARNING: arch/arm64/kernel/traps.c:414 at force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414, CPU#0: pr/ttyAMA-1/41
Modules linked in:
CPU: 0 UID: 0 PID: 41 Comm: pr/ttyAMA-1 Tainted: G      D W           syzkaller #0 PREEMPT 
Tainted: [D]=DIE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
pstate: 034000c5 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
lr : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
sp : ffff80008eac71c0
x29: ffff80008eac71c0 x28: ffff80008eac74c0 x27: dfff800000000000
x26: 0000000000000000 x25: ffff80008efe0000 x24: dfff800000000000
x23: 0000000000000005 x22: 0000000000000009 x21: 0000000000000080
x20: 0000000000000000 x19: 0000000000000000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000945 x13: 0000000000000001 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000001000005 x9 : 0000000001000004
x8 : ffff0000c24b9d80 x7 : 0000000000000001 x6 : ffff800080482944
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000801524f4
x2 : 0000000000000005 x1 : ffff0000c24b9d80 x0 : 0000000000000000
Call trace:
 force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414 (P)
 __efi_fpsimd_begin+0xd8/0x21c arch/arm64/kernel/fpsimd.c:2010
 arch_efi_call_virt_setup+0xb4/0x254 arch/arm64/kernel/efi.c:187
 virt_efi_set_variable_nb+0x9c/0x110 drivers/firmware/efi/runtime-wrappers.c:492
 efivar_set_variable_locked+0x1cc/0x208 drivers/firmware/efi/vars.c:231
 efi_pstore_write+0x2d4/0x418 drivers/firmware/efi/efi-pstore.c:227
 pstore_dump+0x57c/0x8e8 fs/pstore/platform.c:355
 kmsg_dump_desc+0x1f4/0x328 kernel/printk/printk.c:4880
 kmsg_dump include/linux/kmsg_dump.h:123 [inline]
 oops_exit+0x34/0x40 kernel/panic.c:1066
 die+0xb8/0x1d4 arch/arm64/kernel/traps.c:224
 die_kernel_fault+0x6c/0x80 arch/arm64/mm/fault.c:358
 __do_kernel_fault+0x55c/0x590 arch/arm64/mm/fault.c:458
 do_bad_area+0x7c/0x148 arch/arm64/mm/fault.c:533
 do_translation_fault+0xdc/0x114 arch/arm64/mm/fault.c:851
 do_mem_abort+0x70/0x194 arch/arm64/mm/fault.c:1012
 el1_abort+0x50/0x74 arch/arm64/kernel/entry-common.c:380
 el1h_64_sync_handler+0xdc/0x130 arch/arm64/kernel/entry-common.c:507
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:601
 blk_mq_complete_request_remote+0xc4/0x858 block/blk-mq.c:1310 (P)
 nvme_try_complete_req drivers/nvme/host/nvme.h:839 [inline]
 nvme_handle_cqe drivers/nvme/host/pci.c:1601 [inline]
 nvme_poll_cq+0x544/0xfd8 drivers/nvme/host/pci.c:1632
 nvme_irq+0x9c/0x120 drivers/nvme/host/pci.c:1646
 __handle_irq_event_percpu+0x200/0x8ac kernel/irq/handle.c:209
 handle_irq_event_percpu+0x2c/0xd8 kernel/irq/handle.c:246
 handle_irq_event+0x98/0x188 kernel/irq/handle.c:263
 handle_fasteoi_irq+0x328/0x864 kernel/irq/chip.c:768
 generic_handle_irq_desc include/linux/irqdesc.h:188 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:679 [inline]
 generic_handle_domain_irq+0xe4/0x154 kernel/irq/irqdesc.c:735
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:873 [inline]
 gic_handle_irq+0x6c/0x180 drivers/irqchip/irq-gic-v3.c:917
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:901
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:216
 __el1_irq arch/arm64/kernel/entry-common.c:568 [inline]
 el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:581
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:586
 el1h_64_irq+0x78/0x7c arch/arm64/kernel/entry.S:602
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline] (P)
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:221 (P)
 spin_unlock_irqrestore include/linux/spinlock.h:425 [inline]
 __uart_port_unlock_irqrestore include/linux/serial_core.h:622 [inline]
 pl011_console_device_unlock+0x94/0xcc drivers/tty/serial/amba-pl011.c:2721
 nbcon_emit_one+0x160/0x1e4 kernel/printk/nbcon.c:1165
 nbcon_kthread_func+0x56c/0x6c0 kernel/printk/nbcon.c:1271
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
irq event stamp: 19610
hardirqs last  enabled at (19609): [<ffff80008688fdec>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline]
hardirqs last  enabled at (19609): [<ffff80008688fdec>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:221
hardirqs last disabled at (19610): [<ffff80008686ba58>] __el1_irq arch/arm64/kernel/entry-common.c:565 [inline]
hardirqs last disabled at (19610): [<ffff80008686ba58>] el1_interrupt+0x28/0x60 arch/arm64/kernel/entry-common.c:581
softirqs last  enabled at (19568): [<ffff80008030a6dc>] softirq_handle_end kernel/softirq.c:491 [inline]
softirqs last  enabled at (19568): [<ffff80008030a6dc>] handle_softirqs+0xb2c/0xcbc kernel/softirq.c:673
softirqs last disabled at (19425): [<ffff8000800203f0>] __do_softirq+0x14/0x20 kernel/softirq.c:679
---[ end trace 0000000000000000 ]---
Calling EFI runtime from hardirq context
------------[ cut here ]------------
WARNING: arch/arm64/kernel/traps.c:414 at force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414, CPU#0: pr/ttyAMA-1/41
Modules linked in:
CPU: 0 UID: 0 PID: 41 Comm: pr/ttyAMA-1 Tainted: G      D W           syzkaller #0 PREEMPT 
Tainted: [D]=DIE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
pstate: 034000c5 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
lr : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
sp : ffff80008eac71c0
x29: ffff80008eac71c0 x28: ffff80008eac74c0 x27: dfff800000000000
x26: 0000000000000000 x25: ffff80008efe0000 x24: dfff800000000000
x23: 0000000000000005 x22: 0000000000000009 x21: 0000000000000080
x20: 0000000000000000 x19: 0000000000000000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 00000000000009a7 x13: 0000000000000001 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000001000005 x9 : 0000000001000004
x8 : ffff0000c24b9d80 x7 : 0000000000000001 x6 : ffff800080482944
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000801524f4
x2 : 0000000000000005 x1 : ffff0000c24b9d80 x0 : 0000000000000000
Call trace:
 force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414 (P)
 __efi_fpsimd_begin+0xd8/0x21c arch/arm64/kernel/fpsimd.c:2010
 arch_efi_call_virt_setup+0xb4/0x254 arch/arm64/kernel/efi.c:187
 virt_efi_set_variable_nb+0x9c/0x110 drivers/firmware/efi/runtime-wrappers.c:492
 efivar_set_variable_locked+0x1cc/0x208 drivers/firmware/efi/vars.c:231
 efi_pstore_write+0x2d4/0x418 drivers/firmware/efi/efi-pstore.c:227
 pstore_dump+0x57c/0x8e8 fs/pstore/platform.c:355
 kmsg_dump_desc+0x1f4/0x328 kernel/printk/printk.c:4880
 kmsg_dump include/linux/kmsg_dump.h:123 [inline]
 oops_exit+0x34/0x40 kernel/panic.c:1066
 die+0xb8/0x1d4 arch/arm64/kernel/traps.c:224
 die_kernel_fault+0x6c/0x80 arch/arm64/mm/fault.c:358
 __do_kernel_fault+0x55c/0x590 arch/arm64/mm/fault.c:458
 do_bad_area+0x7c/0x148 arch/arm64/mm/fault.c:533
 do_translation_fault+0xdc/0x114 arch/arm64/mm/fault.c:851
 do_mem_abort+0x70/0x194 arch/arm64/mm/fault.c:1012
 el1_abort+0x50/0x74 arch/arm64/kernel/entry-common.c:380
 el1h_64_sync_handler+0xdc/0x130 arch/arm64/kernel/entry-common.c:507
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:601
 blk_mq_complete_request_remote+0xc4/0x858 block/blk-mq.c:1310 (P)
 nvme_try_complete_req drivers/nvme/host/nvme.h:839 [inline]
 nvme_handle_cqe drivers/nvme/host/pci.c:1601 [inline]
 nvme_poll_cq+0x544/0xfd8 drivers/nvme/host/pci.c:1632
 nvme_irq+0x9c/0x120 drivers/nvme/host/pci.c:1646
 __handle_irq_event_percpu+0x200/0x8ac kernel/irq/handle.c:209
 handle_irq_event_percpu+0x2c/0xd8 kernel/irq/handle.c:246
 handle_irq_event+0x98/0x188 kernel/irq/handle.c:263
 handle_fasteoi_irq+0x328/0x864 kernel/irq/chip.c:768
 generic_handle_irq_desc include/linux/irqdesc.h:188 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:679 [inline]
 generic_handle_domain_irq+0xe4/0x154 kernel/irq/irqdesc.c:735
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:873 [inline]
 gic_handle_irq+0x6c/0x180 drivers/irqchip/irq-gic-v3.c:917
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:901
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:216
 __el1_irq arch/arm64/kernel/entry-common.c:568 [inline]
 el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:581
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:586
 el1h_64_irq+0x78/0x7c arch/arm64/kernel/entry.S:602
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline] (P)
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:221 (P)
 spin_unlock_irqrestore include/linux/spinlock.h:425 [inline]
 __uart_port_unlock_irqrestore include/linux/serial_core.h:622 [inline]
 pl011_console_device_unlock+0x94/0xcc drivers/tty/serial/amba-pl011.c:2721
 nbcon_emit_one+0x160/0x1e4 kernel/printk/nbcon.c:1165
 nbcon_kthread_func+0x56c/0x6c0 kernel/printk/nbcon.c:1271
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
irq event stamp: 19610
hardirqs last  enabled at (19609): [<ffff80008688fdec>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline]
hardirqs last  enabled at (19609): [<ffff80008688fdec>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:221
hardirqs last disabled at (19610): [<ffff80008686ba58>] __el1_irq arch/arm64/kernel/entry-common.c:565 [inline]
hardirqs last disabled at (19610): [<ffff80008686ba58>] el1_interrupt+0x28/0x60 arch/arm64/kernel/entry-common.c:581
softirqs last  enabled at (19568): [<ffff80008030a6dc>] softirq_handle_end kernel/softirq.c:491 [inline]
softirqs last  enabled at (19568): [<ffff80008030a6dc>] handle_softirqs+0xb2c/0xcbc kernel/softirq.c:673
softirqs last disabled at (19425): [<ffff8000800203f0>] __do_softirq+0x14/0x20 kernel/softirq.c:679
---[ end trace 0000000000000000 ]---
Calling EFI runtime from hardirq context
------------[ cut here ]------------
WARNING: arch/arm64/kernel/traps.c:414 at force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414, CPU#0: pr/ttyAMA-1/41
Modules linked in:
CPU: 0 UID: 0 PID: 41 Comm: pr/ttyAMA-1 Tainted: G      D W           syzkaller #0 PREEMPT 
Tainted: [D]=DIE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
pstate: 034000c5 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
lr : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
sp : ffff80008eac71c0
x29: ffff80008eac71c0 x28: ffff80008eac74c0 x27: dfff800000000000
x26: 0000000000000000 x25: ffff80008efe0000 x24: dfff800000000000
x23: 0000000000000005 x22: 0000000000000009 x21: 0000000000000080
x20: 0000000000000000 x19: 0000000000000000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000a09 x13: 0000000000000001 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000001000005 x9 : 0000000001000004
x8 : ffff0000c24b9d80 x7 : 0000000000000001 x6 : ffff800080482944
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000801524f4
x2 : 0000000000000005 x1 : ffff0000c24b9d80 x0 : 0000000000000000
Call trace:
 force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414 (P)
 __efi_fpsimd_begin+0xd8/0x21c arch/arm64/kernel/fpsimd.c:2010
 arch_efi_call_virt_setup+0xb4/0x254 arch/arm64/kernel/efi.c:187
 virt_efi_set_variable_nb+0x9c/0x110 drivers/firmware/efi/runtime-wrappers.c:492
 efivar_set_variable_locked+0x1cc/0x208 drivers/firmware/efi/vars.c:231
 efi_pstore_write+0x2d4/0x418 drivers/firmware/efi/efi-pstore.c:227
 pstore_dump+0x57c/0x8e8 fs/pstore/platform.c:355
 kmsg_dump_desc+0x1f4/0x328 kernel/printk/printk.c:4880
 kmsg_dump include/linux/kmsg_dump.h:123 [inline]
 oops_exit+0x34/0x40 kernel/panic.c:1066
 die+0xb8/0x1d4 arch/arm64/kernel/traps.c:224
 die_kernel_fault+0x6c/0x80 arch/arm64/mm/fault.c:358
 __do_kernel_fault+0x55c/0x590 arch/arm64/mm/fault.c:458
 do_bad_area+0x7c/0x148 arch/arm64/mm/fault.c:533
 do_translation_fault+0xdc/0x114 arch/arm64/mm/fault.c:851
 do_mem_abort+0x70/0x194 arch/arm64/mm/fault.c:1012
 el1_abort+0x50/0x74 arch/arm64/kernel/entry-common.c:380
 el1h_64_sync_handler+0xdc/0x130 arch/arm64/kernel/entry-common.c:507
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:601
 blk_mq_complete_request_remote+0xc4/0x858 block/blk-mq.c:1310 (P)
 nvme_try_complete_req drivers/nvme/host/nvme.h:839 [inline]
 nvme_handle_cqe drivers/nvme/host/pci.c:1601 [inline]
 nvme_poll_cq+0x544/0xfd8 drivers/nvme/host/pci.c:1632
 nvme_irq+0x9c/0x120 drivers/nvme/host/pci.c:1646
 __handle_irq_event_percpu+0x200/0x8ac kernel/irq/handle.c:209
 handle_irq_event_percpu+0x2c/0xd8 kernel/irq/handle.c:246
 handle_irq_event+0x98/0x188 kernel/irq/handle.c:263
 handle_fasteoi_irq+0x328/0x864 kernel/irq/chip.c:768
 generic_handle_irq_desc include/linux/irqdesc.h:188 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:679 [inline]
 generic_handle_domain_irq+0xe4/0x154 kernel/irq/irqdesc.c:735
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:873 [inline]
 gic_handle_irq+0x6c/0x180 drivers/irqchip/irq-gic-v3.c:917
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:901
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:216
 __el1_irq arch/arm64/kernel/entry-common.c:568 [inline]
 el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:581
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:586
 el1h_64_irq+0x78/0x7c arch/arm64/kernel/entry.S:602
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline] (P)
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:221 (P)
 spin_unlock_irqrestore include/linux/spinlock.h:425 [inline]
 __uart_port_unlock_irqrestore include/linux/serial_core.h:622 [inline]
 pl011_console_device_unlock+0x94/0xcc drivers/tty/serial/amba-pl011.c:2721
 nbcon_emit_one+0x160/0x1e4 kernel/printk/nbcon.c:1165
 nbcon_kthread_func+0x56c/0x6c0 kernel/printk/nbcon.c:1271
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
irq event stamp: 19610
hardirqs last  enabled at (19609): [<ffff80008688fdec>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline]
hardirqs last  enabled at (19609): [<ffff80008688fdec>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:221
hardirqs last disabled at (19610): [<ffff80008686ba58>] __el1_irq arch/arm64/kernel/entry-common.c:565 [inline]
hardirqs last disabled at (19610): [<ffff80008686ba58>] el1_interrupt+0x28/0x60 arch/arm64/kernel/entry-common.c:581
softirqs last  enabled at (19568): [<ffff80008030a6dc>] softirq_handle_end kernel/softirq.c:491 [inline]
softirqs last  enabled at (19568): [<ffff80008030a6dc>] handle_softirqs+0xb2c/0xcbc kernel/softirq.c:673
softirqs last disabled at (19425): [<ffff8000800203f0>] __do_softirq+0x14/0x20 kernel/softirq.c:679
---[ end trace 0000000000000000 ]---
Calling EFI runtime from hardirq context
------------[ cut here ]------------
WARNING: arch/arm64/kernel/traps.c:414 at force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414, CPU#0: pr/ttyAMA-1/41
Modules linked in:
CPU: 0 UID: 0 PID: 41 Comm: pr/ttyAMA-1 Tainted: G      D W           syzkaller #0 PREEMPT 
Tainted: [D]=DIE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
pstate: 034000c5 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
lr : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
sp : ffff80008eac71c0
x29: ffff80008eac71c0 x28: ffff80008eac74c0 x27: dfff800000000000
x26: 0000000000000000 x25: ffff80008efe0000 x24: dfff800000000000
x23: 0000000000000005 x22: 0000000000000009 x21: 0000000000000080
x20: 0000000000000000 x19: 0000000000000000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000a6b x13: 0000000000000a6b x12: 0000000000000003
x11: 0000000000000001 x10: 0000000001000005 x9 : 0000000001000004
x8 : ffff0000c24b9d80 x7 : 0000000000000001 x6 : ffff800080482944
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000801524f4
x2 : 0000000000000005 x1 : ffff0000c24b9d80 x0 : 0000000000000000
Call trace:
 force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414 (P)
 __efi_fpsimd_begin+0xd8/0x21c arch/arm64/kernel/fpsimd.c:2010
 arch_efi_call_virt_setup+0xb4/0x254 arch/arm64/kernel/efi.c:187
 virt_efi_set_variable_nb+0x9c/0x110 drivers/firmware/efi/runtime-wrappers.c:492
 efivar_set_variable_locked+0x1cc/0x208 drivers/firmware/efi/vars.c:231
 efi_pstore_write+0x2d4/0x418 drivers/firmware/efi/efi-pstore.c:227
 pstore_dump+0x57c/0x8e8 fs/pstore/platform.c:355
 kmsg_dump_desc+0x1f4/0x328 kernel/printk/printk.c:4880
 kmsg_dump include/linux/kmsg_dump.h:123 [inline]
 oops_exit+0x34/0x40 kernel/panic.c:1066
 die+0xb8/0x1d4 arch/arm64/kernel/traps.c:224
 die_kernel_fault+0x6c/0x80 arch/arm64/mm/fault.c:358
 __do_kernel_fault+0x55c/0x590 arch/arm64/mm/fault.c:458
 do_bad_area+0x7c/0x148 arch/arm64/mm/fault.c:533
 do_translation_fault+0xdc/0x114 arch/arm64/mm/fault.c:851
 do_mem_abort+0x70/0x194 arch/arm64/mm/fault.c:1012
 el1_abort+0x50/0x74 arch/arm64/kernel/entry-common.c:380
 el1h_64_sync_handler+0xdc/0x130 arch/arm64/kernel/entry-common.c:507
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:601
 blk_mq_complete_request_remote+0xc4/0x858 block/blk-mq.c:1310 (P)
 nvme_try_complete_req drivers/nvme/host/nvme.h:839 [inline]
 nvme_handle_cqe drivers/nvme/host/pci.c:1601 [inline]
 nvme_poll_cq+0x544/0xfd8 drivers/nvme/host/pci.c:1632
 nvme_irq+0x9c/0x120 drivers/nvme/host/pci.c:1646
 __handle_irq_event_percpu+0x200/0x8ac kernel/irq/handle.c:209
 handle_irq_event_percpu+0x2c/0xd8 kernel/irq/handle.c:246
 handle_irq_event+0x98/0x188 kernel/irq/handle.c:263
 handle_fasteoi_irq+0x328/0x864 kernel/irq/chip.c:768
 generic_handle_irq_desc include/linux/irqdesc.h:188 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:679 [inline]
 generic_handle_domain_irq+0xe4/0x154 kernel/irq/irqdesc.c:735
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:873 [inline]
 gic_handle_irq+0x6c/0x180 drivers/irqchip/irq-gic-v3.c:917
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:901
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:216
 __el1_irq arch/arm64/kernel/entry-common.c:568 [inline]
 el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:581
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:586
 el1h_64_irq+0x78/0x7c arch/arm64/kernel/entry.S:602
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline] (P)
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:221 (P)
 spin_unlock_irqrestore include/linux/spinlock.h:425 [inline]
 __uart_port_unlock_irqrestore include/linux/serial_core.h:622 [inline]
 pl011_console_device_unlock+0x94/0xcc drivers/tty/serial/amba-pl011.c:2721
 nbcon_emit_one+0x160/0x1e4 kernel/printk/nbcon.c:1165
 nbcon_kthread_func+0x56c/0x6c0 kernel/printk/nbcon.c:1271
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
irq event stamp: 19610
hardirqs last  enabled at (19609): [<ffff80008688fdec>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline]
hardirqs last  enabled at (19609): [<ffff80008688fdec>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:221
hardirqs last disabled at (19610): [<ffff80008686ba58>] __el1_irq arch/arm64/kernel/entry-common.c:565 [inline]
hardirqs last disabled at (19610): [<ffff80008686ba58>] el1_interrupt+0x28/0x60 arch/arm64/kernel/entry-common.c:581
softirqs last  enabled at (19568): [<ffff80008030a6dc>] softirq_handle_end kernel/softirq.c:491 [inline]
softirqs last  enabled at (19568): [<ffff80008030a6dc>] handle_softirqs+0xb2c/0xcbc kernel/softirq.c:673
softirqs last disabled at (19425): [<ffff8000800203f0>] __do_softirq+0x14/0x20 kernel/softirq.c:679
---[ end trace 0000000000000000 ]---
Calling EFI runtime from hardirq context
------------[ cut here ]------------
WARNING: arch/arm64/kernel/traps.c:414 at force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414, CPU#0: pr/ttyAMA-1/41
Modules linked in:
CPU: 0 UID: 0 PID: 41 Comm: pr/ttyAMA-1 Tainted: G      D W           syzkaller #0 PREEMPT 
Tainted: [D]=DIE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
pstate: 034000c5 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
lr : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
sp : ffff80008eac71c0
x29: ffff80008eac71c0 x28: ffff80008eac74c0 x27: dfff800000000000
x26: 0000000000000000 x25: ffff80008efe0000 x24: dfff800000000000
x23: 0000000000000005 x22: 0000000000000009 x21: 0000000000000080
x20: 0000000000000000 x19: 0000000000000000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000acd x13: 0000000000000001 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000001000005 x9 : 0000000001000004
x8 : ffff0000c24b9d80 x7 : 0000000000000001 x6 : ffff800080482944
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000801524f4
x2 : 0000000000000005 x1 : ffff0000c24b9d80 x0 : 0000000000000000
Call trace:
 force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414 (P)
 __efi_fpsimd_begin+0xd8/0x21c arch/arm64/kernel/fpsimd.c:2010
 arch_efi_call_virt_setup+0xb4/0x254 arch/arm64/kernel/efi.c:187
 virt_efi_set_variable_nb+0x9c/0x110 drivers/firmware/efi/runtime-wrappers.c:492
 efivar_set_variable_locked+0x1cc/0x208 drivers/firmware/efi/vars.c:231
 efi_pstore_write+0x2d4/0x418 drivers/firmware/efi/efi-pstore.c:227
 pstore_dump+0x57c/0x8e8 fs/pstore/platform.c:355
 kmsg_dump_desc+0x1f4/0x328 kernel/printk/printk.c:4880
 kmsg_dump include/linux/kmsg_dump.h:123 [inline]
 oops_exit+0x34/0x40 kernel/panic.c:1066
 die+0xb8/0x1d4 arch/arm64/kernel/traps.c:224
 die_kernel_fault+0x6c/0x80 arch/arm64/mm/fault.c:358
 __do_kernel_fault+0x55c/0x590 arch/arm64/mm/fault.c:458
 do_bad_area+0x7c/0x148 arch/arm64/mm/fault.c:533
 do_translation_fault+0xdc/0x114 arch/arm64/mm/fault.c:851
 do_mem_abort+0x70/0x194 arch/arm64/mm/fault.c:1012
 el1_abort+0x50/0x74 arch/arm64/kernel/entry-common.c:380
 el1h_64_sync_handler+0xdc/0x130 arch/arm64/kernel/entry-common.c:507
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:601
 blk_mq_complete_request_remote+0xc4/0x858 block/blk-mq.c:1310 (P)
 nvme_try_complete_req drivers/nvme/host/nvme.h:839 [inline]
 nvme_handle_cqe drivers/nvme/host/pci.c:1601 [inline]
 nvme_poll_cq+0x544/0xfd8 drivers/nvme/host/pci.c:1632
 nvme_irq+0x9c/0x120 drivers/nvme/host/pci.c:1646
 __handle_irq_event_percpu+0x200/0x8ac kernel/irq/handle.c:209
 handle_irq_event_percpu+0x2c/0xd8 kernel/irq/handle.c:246
 handle_irq_event+0x98/0x188 kernel/irq/handle.c:263
 handle_fasteoi_irq+0x328/0x864 kernel/irq/chip.c:768
 generic_handle_irq_desc include/linux/irqdesc.h:188 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:679 [inline]
 generic_handle_domain_irq+0xe4/0x154 kernel/irq/irqdesc.c:735
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:873 [inline]
 gic_handle_irq+0x6c/0x180 drivers/irqchip/irq-gic-v3.c:917
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:901
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:216
 __el1_irq arch/arm64/kernel/entry-common.c:568 [inline]
 el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:581
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:586
 el1h_64_irq+0x78/0x7c arch/arm64/kernel/entry.S:602
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline] (P)
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:221 (P)
 spin_unlock_irqrestore include/linux/spinlock.h:425 [inline]
 __uart_port_unlock_irqrestore include/linux/serial_core.h:622 [inline]
 pl011_console_device_unlock+0x94/0xcc drivers/tty/serial/amba-pl011.c:2721
 nbcon_emit_one+0x160/0x1e4 kernel/printk/nbcon.c:1165
 nbcon_kthread_func+0x56c/0x6c0 kernel/printk/nbcon.c:1271
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
irq event stamp: 19610
hardirqs last  enabled at (19609): [<ffff80008688fdec>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline]
hardirqs last  enabled at (19609): [<ffff80008688fdec>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:221
hardirqs last disabled at (19610): [<ffff80008686ba58>] __el1_irq arch/arm64/kernel/entry-common.c:565 [inline]
hardirqs last disabled at (19610): [<ffff80008686ba58>] el1_interrupt+0x28/0x60 arch/arm64/kernel/entry-common.c:581
softirqs last  enabled at (19568): [<ffff80008030a6dc>] softirq_handle_end kernel/softirq.c:491 [inline]
softirqs last  enabled at (19568): [<ffff80008030a6dc>] handle_softirqs+0xb2c/0xcbc kernel/softirq.c:673
softirqs last disabled at (19425): [<ffff8000800203f0>] __do_softirq+0x14/0x20 kernel/softirq.c:679
---[ end trace 0000000000000000 ]---
Calling EFI runtime from hardirq context
------------[ cut here ]------------
WARNING: arch/arm64/kernel/traps.c:414 at force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414, CPU#0: pr/ttyAMA-1/41
Modules linked in:
CPU: 0 UID: 0 PID: 41 Comm: pr/ttyAMA-1 Tainted: G      D W           syzkaller #0 PREEMPT 
Tainted: [D]=DIE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
pstate: 034000c5 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
lr : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
sp : ffff80008eac71c0
x29: ffff80008eac71c0 x28: ffff80008eac74c0 x27: dfff800000000000
x26: 0000000000000000 x25: ffff80008efe0000 x24: dfff800000000000
x23: 0000000000000005 x22: 0000000000000009 x21: 0000000000000080
x20: 0000000000000000 x19: 0000000000000000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000b2f x13: 0000000000000001 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000001000005 x9 : 0000000001000004
x8 : ffff0000c24b9d80 x7 : 0000000000000001 x6 : ffff800080482944
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000801524f4
x2 : 0000000000000005 x1 : ffff0000c24b9d80 x0 : 0000000000000000
Call trace:
 force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414 (P)
 __efi_fpsimd_begin+0xd8/0x21c arch/arm64/kernel/fpsimd.c:2010
 arch_efi_call_virt_setup+0xb4/0x254 arch/arm64/kernel/efi.c:187
 virt_efi_set_variable_nb+0x9c/0x110 drivers/firmware/efi/runtime-wrappers.c:492
 efivar_set_variable_locked+0x1cc/0x208 drivers/firmware/efi/vars.c:231
 efi_pstore_write+0x2d4/0x418 drivers/firmware/efi/efi-pstore.c:227
 pstore_dump+0x57c/0x8e8 fs/pstore/platform.c:355
 kmsg_dump_desc+0x1f4/0x328 kernel/printk/printk.c:4880
 kmsg_dump include/linux/kmsg_dump.h:123 [inline]
 oops_exit+0x34/0x40 kernel/panic.c:1066
 die+0xb8/0x1d4 arch/arm64/kernel/traps.c:224
 die_kernel_fault+0x6c/0x80 arch/arm64/mm/fault.c:358
 __do_kernel_fault+0x55c/0x590 arch/arm64/mm/fault.c:458
 do_bad_area+0x7c/0x148 arch/arm64/mm/fault.c:533
 do_translation_fault+0xdc/0x114 arch/arm64/mm/fault.c:851
 do_mem_abort+0x70/0x194 arch/arm64/mm/fault.c:1012
 el1_abort+0x50/0x74 arch/arm64/kernel/entry-common.c:380
 el1h_64_sync_handler+0xdc/0x130 arch/arm64/kernel/entry-common.c:507
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:601
 blk_mq_complete_request_remote+0xc4/0x858 block/blk-mq.c:1310 (P)
 nvme_try_complete_req drivers/nvme/host/nvme.h:839 [inline]
 nvme_handle_cqe drivers/nvme/host/pci.c:1601 [inline]
 nvme_poll_cq+0x544/0xfd8 drivers/nvme/host/pci.c:1632
 nvme_irq+0x9c/0x120 drivers/nvme/host/pci.c:1646
 __handle_irq_event_percpu+0x200/0x8ac kernel/irq/handle.c:209
 handle_irq_event_percpu+0x2c/0xd8 kernel/irq/handle.c:246
 handle_irq_event+0x98/0x188 kernel/irq/handle.c:263
 handle_fasteoi_irq+0x328/0x864 kernel/irq/chip.c:768
 generic_handle_irq_desc include/linux/irqdesc.h:188 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:679 [inline]
 generic_handle_domain_irq+0xe4/0x154 kernel/irq/irqdesc.c:735
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:873 [inline]
 gic_handle_irq+0x6c/0x180 drivers/irqchip/irq-gic-v3.c:917
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:901
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:216
 __el1_irq arch/arm64/kernel/entry-common.c:568 [inline]
 el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:581
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:586
 el1h_64_irq+0x78/0x7c arch/arm64/kernel/entry.S:602
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline] (P)
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:221 (P)
 spin_unlock_irqrestore include/linux/spinlock.h:425 [inline]
 __uart_port_unlock_irqrestore include/linux/serial_core.h:622 [inline]
 pl011_console_device_unlock+0x94/0xcc drivers/tty/serial/amba-pl011.c:2721
 nbcon_emit_one+0x160/0x1e4 kernel/printk/nbcon.c:1165
 nbcon_kthread_func+0x56c/0x6c0 kernel/printk/nbcon.c:1271
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
irq event stamp: 19610
hardirqs last  enabled at (19609): [<ffff80008688fdec>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline]
hardirqs last  enabled at (19609): [<ffff80008688fdec>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:221
hardirqs last disabled at (19610): [<ffff80008686ba58>] __el1_irq arch/arm64/kernel/entry-common.c:565 [inline]
hardirqs last disabled at (19610): [<ffff80008686ba58>] el1_interrupt+0x28/0x60 arch/arm64/kernel/entry-common.c:581
softirqs last  enabled at (19568): [<ffff80008030a6dc>] softirq_handle_end kernel/softirq.c:491 [inline]
softirqs last  enabled at (19568): [<ffff80008030a6dc>] handle_softirqs+0xb2c/0xcbc kernel/softirq.c:673
softirqs last disabled at (19425): [<ffff8000800203f0>] __do_softirq+0x14/0x20 kernel/softirq.c:679
---[ end trace 0000000000000000 ]---
Calling EFI runtime from hardirq context
------------[ cut here ]------------
WARNING: arch/arm64/kernel/traps.c:414 at force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414, CPU#0: pr/ttyAMA-1/41
Modules linked in:
CPU: 0 UID: 0 PID: 41 Comm: pr/ttyAMA-1 Tainted: G      D W           syzkaller #0 PREEMPT 
Tainted: [D]=DIE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
pstate: 034000c5 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
lr : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
sp : ffff80008eac71c0
x29: ffff80008eac71c0 x28: ffff80008eac74c0 x27: dfff800000000000
x26: 0000000000000000 x25: ffff80008efe0000 x24: dfff800000000000
x23: 0000000000000005 x22: 0000000000000009 x21: 0000000000000080
x20: 0000000000000000 x19: 0000000000000000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000b91 x13: 0000000000000001 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000001000005 x9 : 0000000001000004
x8 : ffff0000c24b9d80 x7 : 0000000000000001 x6 : ffff800080482944
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000801524f4
x2 : 0000000000000005 x1 : ffff0000c24b9d80 x0 : 0000000000000000
Call trace:
 force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414 (P)
 __efi_fpsimd_begin+0xd8/0x21c arch/arm64/kernel/fpsimd.c:2010
 arch_efi_call_virt_setup+0xb4/0x254 arch/arm64/kernel/efi.c:187
 virt_efi_set_variable_nb+0x9c/0x110 drivers/firmware/efi/runtime-wrappers.c:492
 efivar_set_variable_locked+0x1cc/0x208 drivers/firmware/efi/vars.c:231
 efi_pstore_write+0x2d4/0x418 drivers/firmware/efi/efi-pstore.c:227
 pstore_dump+0x57c/0x8e8 fs/pstore/platform.c:355
 kmsg_dump_desc+0x1f4/0x328 kernel/printk/printk.c:4880
 kmsg_dump include/linux/kmsg_dump.h:123 [inline]
 oops_exit+0x34/0x40 kernel/panic.c:1066
 die+0xb8/0x1d4 arch/arm64/kernel/traps.c:224
 die_kernel_fault+0x6c/0x80 arch/arm64/mm/fault.c:358
 __do_kernel_fault+0x55c/0x590 arch/arm64/mm/fault.c:458
 do_bad_area+0x7c/0x148 arch/arm64/mm/fault.c:533
 do_translation_fault+0xdc/0x114 arch/arm64/mm/fault.c:851
 do_mem_abort+0x70/0x194 arch/arm64/mm/fault.c:1012
 el1_abort+0x50/0x74 arch/arm64/kernel/entry-common.c:380
 el1h_64_sync_handler+0xdc/0x130 arch/arm64/kernel/entry-common.c:507
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:601
 blk_mq_complete_request_remote+0xc4/0x858 block/blk-mq.c:1310 (P)
 nvme_try_complete_req drivers/nvme/host/nvme.h:839 [inline]
 nvme_handle_cqe drivers/nvme/host/pci.c:1601 [inline]
 nvme_poll_cq+0x544/0xfd8 drivers/nvme/host/pci.c:1632
 nvme_irq+0x9c/0x120 drivers/nvme/host/pci.c:1646
 __handle_irq_event_percpu+0x200/0x8ac kernel/irq/handle.c:209
 handle_irq_event_percpu+0x2c/0xd8 kernel/irq/handle.c:246
 handle_irq_event+0x98/0x188 kernel/irq/handle.c:263
 handle_fasteoi_irq+0x328/0x864 kernel/irq/chip.c:768
 generic_handle_irq_desc include/linux/irqdesc.h:188 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:679 [inline]
 generic_handle_domain_irq+0xe4/0x154 kernel/irq/irqdesc.c:735
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:873 [inline]
 gic_handle_irq+0x6c/0x180 drivers/irqchip/irq-gic-v3.c:917
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:901
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:216
 __el1_irq arch/arm64/kernel/entry-common.c:568 [inline]
 el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:581
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:586
 el1h_64_irq+0x78/0x7c arch/arm64/kernel/entry.S:602
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline] (P)
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:221 (P)
 spin_unlock_irqrestore include/linux/spinlock.h:425 [inline]
 __uart_port_unlock_irqrestore include/linux/serial_core.h:622 [inline]
 pl011_console_device_unlock+0x94/0xcc drivers/tty/serial/amba-pl011.c:2721
 nbcon_emit_one+0x160/0x1e4 kernel/printk/nbcon.c:1165
 nbcon_kthread_func+0x56c/0x6c0 kernel/printk/nbcon.c:1271
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
irq event stamp: 19610
hardirqs last  enabled at (19609): [<ffff80008688fdec>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline]
hardirqs last  enabled at (19609): [<ffff80008688fdec>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:221
hardirqs last disabled at (19610): [<ffff80008686ba58>] __el1_irq arch/arm64/kernel/entry-common.c:565 [inline]
hardirqs last disabled at (19610): [<ffff80008686ba58>] el1_interrupt+0x28/0x60 arch/arm64/kernel/entry-common.c:581
softirqs last  enabled at (19568): [<ffff80008030a6dc>] softirq_handle_end kernel/softirq.c:491 [inline]
softirqs last  enabled at (19568): [<ffff80008030a6dc>] handle_softirqs+0xb2c/0xcbc kernel/softirq.c:673
softirqs last disabled at (19425): [<ffff8000800203f0>] __do_softirq+0x14/0x20 kernel/softirq.c:679
---[ end trace 0000000000000000 ]---
Calling EFI runtime from hardirq context
------------[ cut here ]------------
WARNING: arch/arm64/kernel/traps.c:414 at force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414, CPU#0: pr/ttyAMA-1/41
Modules linked in:
CPU: 0 UID: 0 PID: 41 Comm: pr/ttyAMA-1 Tainted: G      D W           syzkaller #0 PREEMPT 
Tainted: [D]=DIE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
pstate: 034000c5 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
lr : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
sp : ffff80008eac71c0
x29: ffff80008eac71c0 x28: ffff80008eac74c0 x27: dfff800000000000
x26: 0000000000000000 x25: ffff80008efe0000 x24: dfff800000000000
x23: 0000000000000005 x22: 0000000000000009 x21: 0000000000000080
x20: 0000000000000000 x19: 0000000000000000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000bf3 x13: 0000000000000001 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000001000005 x9 : 0000000001000004
x8 : ffff0000c24b9d80 x7 : 0000000000000001 x6 : ffff800080482944
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000801524f4
x2 : 0000000000000005 x1 : ffff0000c24b9d80 x0 : 0000000000000000
Call trace:
 force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414 (P)
 __efi_fpsimd_begin+0xd8/0x21c arch/arm64/kernel/fpsimd.c:2010
 arch_efi_call_virt_setup+0xb4/0x254 arch/arm64/kernel/efi.c:187
 virt_efi_set_variable_nb+0x9c/0x110 drivers/firmware/efi/runtime-wrappers.c:492
 efivar_set_variable_locked+0x1cc/0x208 drivers/firmware/efi/vars.c:231
 efi_pstore_write+0x2d4/0x418 drivers/firmware/efi/efi-pstore.c:227
 pstore_dump+0x57c/0x8e8 fs/pstore/platform.c:355
 kmsg_dump_desc+0x1f4/0x328 kernel/printk/printk.c:4880
 kmsg_dump include/linux/kmsg_dump.h:123 [inline]
 oops_exit+0x34/0x40 kernel/panic.c:1066
 die+0xb8/0x1d4 arch/arm64/kernel/traps.c:224
 die_kernel_fault+0x6c/0x80 arch/arm64/mm/fault.c:358
 __do_kernel_fault+0x55c/0x590 arch/arm64/mm/fault.c:458
 do_bad_area+0x7c/0x148 arch/arm64/mm/fault.c:533
 do_translation_fault+0xdc/0x114 arch/arm64/mm/fault.c:851
 do_mem_abort+0x70/0x194 arch/arm64/mm/fault.c:1012
 el1_abort+0x50/0x74 arch/arm64/kernel/entry-common.c:380
 el1h_64_sync_handler+0xdc/0x130 arch/arm64/kernel/entry-common.c:507
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:601
 blk_mq_complete_request_remote+0xc4/0x858 block/blk-mq.c:1310 (P)
 nvme_try_complete_req drivers/nvme/host/nvme.h:839 [inline]
 nvme_handle_cqe drivers/nvme/host/pci.c:1601 [inline]
 nvme_poll_cq+0x544/0xfd8 drivers/nvme/host/pci.c:1632
 nvme_irq+0x9c/0x120 drivers/nvme/host/pci.c:1646
 __handle_irq_event_percpu+0x200/0x8ac kernel/irq/handle.c:209
 handle_irq_event_percpu+0x2c/0xd8 kernel/irq/handle.c:246
 handle_irq_event+0x98/0x188 kernel/irq/handle.c:263
 handle_fasteoi_irq+0x328/0x864 kernel/irq/chip.c:768
 generic_handle_irq_desc include/linux/irqdesc.h:188 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:679 [inline]
 generic_handle_domain_irq+0xe4/0x154 kernel/irq/irqdesc.c:735
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:873 [inline]
 gic_handle_irq+0x6c/0x180 drivers/irqchip/irq-gic-v3.c:917
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:901
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:216
 __el1_irq arch/arm64/kernel/entry-common.c:568 [inline]
 el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:581
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:586
 el1h_64_irq+0x78/0x7c arch/arm64/kernel/entry.S:602
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline] (P)
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:221 (P)
 spin_unlock_irqrestore include/linux/spinlock.h:425 [inline]
 __uart_port_unlock_irqrestore include/linux/serial_core.h:622 [inline]
 pl011_console_device_unlock+0x94/0xcc drivers/tty/serial/amba-pl011.c:2721
 nbcon_emit_one+0x160/0x1e4 kernel/printk/nbcon.c:1165
 nbcon_kthread_func+0x56c/0x6c0 kernel/printk/nbcon.c:1271
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
irq event stamp: 19610
hardirqs last  enabled at (19609): [<ffff80008688fdec>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline]
hardirqs last  enabled at (19609): [<ffff80008688fdec>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:221
hardirqs last disabled at (19610): [<ffff80008686ba58>] __el1_irq arch/arm64/kernel/entry-common.c:565 [inline]
hardirqs last disabled at (19610): [<ffff80008686ba58>] el1_interrupt+0x28/0x60 arch/arm64/kernel/entry-common.c:581
softirqs last  enabled at (19568): [<ffff80008030a6dc>] softirq_handle_end kernel/softirq.c:491 [inline]
softirqs last  enabled at (19568): [<ffff80008030a6dc>] handle_softirqs+0xb2c/0xcbc kernel/softirq.c:673
softirqs last disabled at (19425): [<ffff8000800203f0>] __do_softirq+0x14/0x20 kernel/softirq.c:679
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: arch/arm64/kernel/traps.c:414 at force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414, CPU#0: pr/ttyAMA-1/41
Modules linked in:
CPU: 0 UID: 0 PID: 41 Comm: pr/ttyAMA-1 Tainted: G      D W           syzkaller #0 PREEMPT 
Tainted: [D]=DIE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
pstate: 034000c5 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
lr : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
sp : ffff80008eac71c0
x29: ffff80008eac71c0 x28: ffff80008eac74c0 x27: dfff800000000000
x26: 0000000000000000 x25: ffff80008efe0000 x24: dfff800000000000
x23: 0000000000000005 x22: 0000000000000009 x21: 0000000000000080
x20: 0000000000000000 x19: 0000000000000000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff700011153ff6 x9 : 0000000001000004
x8 : ffff0000c24b9d80 x7 : 0000000000000000 x6 : ffff800086845b5c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000801524f4
x2 : 0000000000000005 x1 : ffff0000c24b9d80 x0 : 0000000000000000
Call trace:
 force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414 (P)
 __efi_fpsimd_begin+0xd8/0x21c arch/arm64/kernel/fpsimd.c:2010
 arch_efi_call_virt_setup+0xb4/0x254 arch/arm64/kernel/efi.c:187
 virt_efi_set_variable_nb+0x9c/0x110 drivers/firmware/efi/runtime-wrappers.c:492
 efivar_set_variable_locked+0x1cc/0x208 drivers/firmware/efi/vars.c:231
 efi_pstore_write+0x2d4/0x418 drivers/firmware/efi/efi-pstore.c:227
 pstore_dump+0x57c/0x8e8 fs/pstore/platform.c:355
 kmsg_dump_desc+0x1f4/0x328 kernel/printk/printk.c:4880
 kmsg_dump include/linux/kmsg_dump.h:123 [inline]
 oops_exit+0x34/0x40 kernel/panic.c:1066
 die+0xb8/0x1d4 arch/arm64/kernel/traps.c:224
 die_kernel_fault+0x6c/0x80 arch/arm64/mm/fault.c:358
 __do_kernel_fault+0x55c/0x590 arch/arm64/mm/fault.c:458
 do_bad_area+0x7c/0x148 arch/arm64/mm/fault.c:533
 do_translation_fault+0xdc/0x114 arch/arm64/mm/fault.c:851
 do_mem_abort+0x70/0x194 arch/arm64/mm/fault.c:1012
 el1_abort+0x50/0x74 arch/arm64/kernel/entry-common.c:380
 el1h_64_sync_handler+0xdc/0x130 arch/arm64/kernel/entry-common.c:507
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:601
 blk_mq_complete_request_remote+0xc4/0x858 block/blk-mq.c:1310 (P)
 nvme_try_complete_req drivers/nvme/host/nvme.h:839 [inline]
 nvme_handle_cqe drivers/nvme/host/pci.c:1601 [inline]
 nvme_poll_cq+0x544/0xfd8 drivers/nvme/host/pci.c:1632
 nvme_irq+0x9c/0x120 drivers/nvme/host/pci.c:1646
 __handle_irq_event_percpu+0x200/0x8ac kernel/irq/handle.c:209
 handle_irq_event_percpu+0x2c/0xd8 kernel/irq/handle.c:246
 handle_irq_event+0x98/0x188 kernel/irq/handle.c:263
 handle_fasteoi_irq+0x328/0x864 kernel/irq/chip.c:768
 generic_handle_irq_desc include/linux/irqdesc.h:188 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:679 [inline]
 generic_handle_domain_irq+0xe4/0x154 kernel/irq/irqdesc.c:735
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:873 [inline]
 gic_handle_irq+0x6c/0x180 drivers/irqchip/irq-gic-v3.c:917
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:901
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:216
 __el1_irq arch/arm64/kernel/entry-common.c:568 [inline]
 el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:581
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:586
 el1h_64_irq+0x78/0x7c arch/arm64/kernel/entry.S:602
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline] (P)
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:221 (P)
 spin_unlock_irqrestore include/linux/spinlock.h:425 [inline]
 __uart_port_unlock_irqrestore include/linux/serial_core.h:622 [inline]
 pl011_console_device_unlock+0x94/0xcc drivers/tty/serial/amba-pl011.c:2721
 nbcon_emit_one+0x160/0x1e4 kernel/printk/nbcon.c:1165
 nbcon_kthread_func+0x56c/0x6c0 kernel/printk/nbcon.c:1271
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
irq event stamp: 19610
hardirqs last  enabled at (19609): [<ffff80008688fdec>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline]
hardirqs last  enabled at (19609): [<ffff80008688fdec>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:221
hardirqs last disabled at (19610): [<ffff80008686ba58>] __el1_irq arch/arm64/kernel/entry-common.c:565 [inline]
hardirqs last disabled at (19610): [<ffff80008686ba58>] el1_interrupt+0x28/0x60 arch/arm64/kernel/entry-common.c:581
softirqs last  enabled at (19568): [<ffff80008030a6dc>] softirq_handle_end kernel/softirq.c:491 [inline]
softirqs last  enabled at (19568): [<ffff80008030a6dc>] handle_softirqs+0xb2c/0xcbc kernel/softirq.c:673
softirqs last disabled at (19425): [<ffff8000800203f0>] __do_softirq+0x14/0x20 kernel/softirq.c:679
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: arch/arm64/kernel/traps.c:414 at force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414, CPU#0: pr/ttyAMA-1/41
Modules linked in:
CPU: 0 UID: 0 PID: 41 Comm: pr/ttyAMA-1 Tainted: G      D W           syzkaller #0 PREEMPT 
Tainted: [D]=DIE, [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
pstate: 034000c5 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
lr : force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414
sp : ffff80008eac71c0
x29: ffff80008eac71c0 x28: ffff80008eac74c0 x27: dfff800000000000
x26: 0000000000000000 x25: ffff80008efe0000 x24: dfff800000000000
x23: 0000000000000005 x22: 0000000000000009 x21: 0000000000000080
x20: 0000000000000000 x19: 0000000000000000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff700011153ff6 x9 : 0000000001000004
x8 : ffff0000c24b9d80 x7 : 0000000000000000 x6 : ffff800086845b5c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000801524f4
x2 : 0000000000000005 x1 : ffff0000c24b9d80 x0 : 0000000000000000
Call trace:
 force_signal_inject+0x150/0x168 arch/arm64/kernel/traps.c:414 (P)
 __efi_fpsimd_begin+0xd8/0x21c arch/arm64/kernel/fpsimd.c:2010
 arch_efi_call_virt_setup+0xb4/0x254 arch/arm64/kernel/efi.c:187
 virt_efi_set_variable_nb+0x9c/0x110 drivers/firmware/efi/runtime-wrappers.c:492
 efivar_set_variable_locked+0x1cc/0x208 drivers/firmware/efi/vars.c:231
 efi_pstore_write+0x2d4/0x418 drivers/firmware/efi/efi-pstore.c:227
 pstore_dump+0x57c/0x8e8 fs/pstore/platform.c:355
 kmsg_dump_desc+0x1f4/0x328 kernel/printk/printk.c:4880
 kmsg_dump include/linux/kmsg_dump.h:123 [inline]
 oops_exit+0x34/0x40 kernel/panic.c:1066
 die+0xb8/0x1d4 arch/arm64/kernel/traps.c:224
 die_kernel_fault+0x6c/0x80 arch/arm64/mm/fault.c:358
 __do_kernel_fault+0x55c/0x590 arch/arm64/mm/fault.c:458
 do_bad_area+0x7c/0x148 arch/arm64/mm/fault.c:533
 do_translation_fault+0xdc/0x114 arch/arm64/mm/fault.c:851
 do_mem_abort+0x70/0x194 arch/arm64/mm/fault.c:1012
 el1_abort+0x50/0x74 arch/arm64/kernel/entry-common.c:380
 el1h_64_sync_handler+0xdc/0x130 arch/arm64/kernel/entry-common.c:507
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:601
 blk_mq_complete_request_remote+0xc4/0x858 block/blk-mq.c:1310 (P)
 nvme_try_complete_req drivers/nvme/host/nvme.h:839 [inline]
 nvme_handle_cqe drivers/nvme/host/pci.c:1601 [inline]
 nvme_poll_cq+0x544/0xfd8 drivers/nvme/host/pci.c:1632
 nvme_irq+0x9c/0x120 drivers/nvme/host/pci.c:1646
 __handle_irq_event_percpu+0x200/0x8ac kernel/irq/handle.c:209
 handle_irq_event_percpu+0x2c/0xd8 kernel/irq/handle.c:246
 handle_irq_event+0x98/0x188 kernel/irq/handle.c:263
 handle_fasteoi_irq+0x328/0x864 kernel/irq/chip.c:768
 generic_handle_irq_desc include/linux/irqdesc.h:188 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:679 [inline]
 generic_handle_domain_irq+0xe4/0x154 kernel/irq/irqdesc.c:735
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:825 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:873 [inline]
 gic_handle_irq+0x6c/0x180 drivers/irqchip/irq-gic-v3.c:917
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:901
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:216
 __el1_irq arch/arm64/kernel/entry-common.c:568 [inline]
 el1_interrupt+0x3c/0x60 arch/arm64/kernel/entry-common.c:581
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:586
 el1h_64_irq+0x78/0x7c arch/arm64/kernel/entry.S:602
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:210 [inline]

---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
