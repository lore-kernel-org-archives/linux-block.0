Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F23F9C3
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196838; cv=none; b=nMcApIi79E+uUh+hRzlOyFGU3H7YOhvSYx1m24gq2uL9hHTLL8HOPQEdnfF+tJUFKqEcjn/H5X5gtTT2D+e73p8W9+QDzJVmZdsLv4P3fPJIdZAsKQc7XHw5pE1RSC+Gn8MIotZKB87nF2+ix+ZglpjvhbWcbLp6vrpUb419Y0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196838; c=relaxed/simple;
	bh=ZjDnJ3kpMwZCrj3j0RVBT5SAsAvH5SUvsxhjpjGmQ9g=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jTQZidgSWe6KgM8mvUR9HwzJEmBUdhXCcMulkicyVH4faKhDwt/J1qdnnWJoivK+2t7vyY9JdonMlg9hv+dcC7k1R+oYm87t19n+Y5Bm+4r95SJG2FAoa7HdcTVfU2vE3N8vklA83tPUAy/i6G/i+SfLB2WI1SbjFX9ZdcuN0CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5WU50o2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5WU50o2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715196833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjDnJ3kpMwZCrj3j0RVBT5SAsAvH5SUvsxhjpjGmQ9g=;
	b=B5WU50o2dm/z+cFrmJoNfu3mh6o/LZMDajunJ012zCjMkqzqecx6Rfs6XN2InPW2VnYwS7
	BOOeFQtMrrKtJdLBXaGXYQVCPLBtY+EW6Tu/0LDMcifqgLa4vgmJAy2SQGz0kDBCfLhX+Z
	5iYDS6PaAhgO26jYvD4HmPzZOKaH0lg=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531--pTkYKxwNeONFmf2P1cxQw-1; Wed, 08 May 2024 15:33:51 -0400
X-MC-Unique: -pTkYKxwNeONFmf2P1cxQw-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c61300a19dso138542b6e.1
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 12:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715196830; x=1715801630;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZjDnJ3kpMwZCrj3j0RVBT5SAsAvH5SUvsxhjpjGmQ9g=;
        b=dDG9cXCK/IiHTh0lvdtJz2uDPhWc+WSAPaJdlLDo7YK8uGyNhJlBdCUxMOPshBaUnB
         V0XryKkAfG/e/pOikt0fX/Z5oekulmNz/G72jKnhdnsfUO+hqoeyaoBHXrF9LEzkZ/DS
         g0lGhypIxuA79ht9KRs1Ti1vEzn/6ogoBmsTt3SWASBYck7gK+6fDnA6VD9IrW/y8JHL
         6dVK43t8ySBYP0oGhF72VmQ/0RLfXzAthLZOeO3y7NOHCsMxbrERzlJ073jschXVmSK1
         SDZ9o/W2mhFz4xeyOBxfs9S1snALh2GADDCNn7lhrCyVvDz66HQPyb/Ov8mtLC7zBQbu
         P8uw==
X-Forwarded-Encrypted: i=1; AJvYcCUBfeIMlgJXDowiLFHyxLPpZ6P2KWEAdXD53PdMiKtJjDWyndmyoz6yzyQj7dSOqkfvmL3w97PkHg6i9LsRCFa8bmrSANyckuL5IDQ=
X-Gm-Message-State: AOJu0YzOcCZtbfHwfDAstwiuNjYme0QjHnFRaj8sImp3VwkS//Z6PsP1
	+ROoMFoPwaLNxu73ssOEr856qLl6wKaBoCuAJsWqJoVIyZOx+zLYS2SiecIW7hK1oEedrZJ8s7m
	JzOIIu7lcsOQL9GuvkYEwJCFm/vCO9qlY2HE061pNaIYOrIb8zOW4WkrF1evC
X-Received: by 2002:a05:6808:b39:b0:3c9:68bf:b5d0 with SMTP id 5614622812f47-3c9852c0469mr3608834b6e.14.1715196829290;
        Wed, 08 May 2024 12:33:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8ykmbS8tJOxXTJmUt5Ssklf06RwzpLG607lxD57Kng5P48BssVwpRe5odGr9x1uQ5d2/vzQ==
X-Received: by 2002:a05:6808:b39:b0:3c9:68bf:b5d0 with SMTP id 5614622812f47-3c9852c0469mr3608781b6e.14.1715196828282;
        Wed, 08 May 2024 12:33:48 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:2613:173:a68a:fce8? ([2600:6c64:4e7f:603b:2613:173:a68a:fce8])
        by smtp.gmail.com with ESMTPSA id cn23-20020a056808351700b003c97ba0b7c2sm634872oib.23.2024.05.08.12.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:33:47 -0700 (PDT)
Message-ID: <c2c4c5f6593193db95c67be06ead366010af5754.camel@redhat.com>
Subject: Re: [syzbot] [block?] [usb?] INFO: rcu detected stall in aoecmd_cfg
 (2)
From: Laurence Oberman <loberman@redhat.com>
To: syzbot <syzbot+1e6e0b916b211bee1bd6@syzkaller.appspotmail.com>, 
	axboe@kernel.dk, justin@coraid.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Date: Wed, 08 May 2024 15:33:46 -0400
In-Reply-To: <0000000000008de5720617f64aae@google.com>
References: <0000000000008de5720617f64aae@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-08 at 12:27 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:=C2=A0=C2=A0=C2=A0 9221b2819b8a Add linux-next specific files=
 for
> 20240503
> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-next
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=3D1276b22f180000
> kernel config:=C2=A0
> https://syzkaller.appspot.com/x/.config?x=3D8ab537f51a6a0d98
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3D1e6e0b916b211bee1bd6
> compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Debian clang version 15.0.6=
, GNU ld (GNU Binutils for
> Debian) 2.40
> syz repro:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.syz?x=3D15661898980000
> C reproducer:=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.c?x=3D161a5d1f180000
>=20
> Downloadable assets:
> disk image:
> https://storage.googleapis.com/syzbot-assets/3e67dbdc3c37/disk-9221b281.r=
aw.xz
> vmlinux:
> https://storage.googleapis.com/syzbot-assets/ade618fa19f8/vmlinux-9221b28=
1.xz
> kernel image:
> https://storage.googleapis.com/syzbot-assets/df12e5073c97/bzImage-9221b28=
1.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+1e6e0b916b211bee1bd6@syzkaller.appspotmail.com
>=20
> rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
> =C2=A01-.... } 2645 jiffies s: 869 root: 0x2/.
> rcu: blocking rcu_node structures (internal RCU debug):
> Sending NMI from CPU 0 to CPUs 1:
> yealink 3-1:36.0: unexpected response 0
> NMI backtrace for cpu 1
> CPU: 1 PID: 45 Comm: kworker/1:1 Not tainted 6.9.0-rc6-next-20240503-
> syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 03/27/2024
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:__sanitizer_cov_trace_const_cmp8+0x0/0x90 kernel/kcov.c:310
> Code: 10 48 89 74 0a 18 4c 89 44 0a 20 c3 cc cc cc cc 66 2e 0f 1f 84
> 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3>
> 0f 1e fa 4c 8b 04 24 65 48 8b 0c 25 00 d5 03 00 65 8b 05 30 ba
> RSP: 0018:ffffc90000a16fa8 EFLAGS: 00000046
> RAX: ffffffff8b831214 RBX: 00000000000b31d2 RCX: ffff88801b6c0000
> RDX: 0000000000010103 RSI: 00000000000b31d2 RDI: 0000000005f5e0ff
> RBP: ffffc90000a170f0 R08: ffffffff8b8364ea R09: 0000000000000000
> R10: ffffc90000a17060 R11: fffff52000142e0f R12: 00000000ffff0a00
> R13: dffffc0000000000 R14: ffffc90000a17060 R15: ffffc90000a17447
> FS:=C2=A0 0000000000000000(0000) GS:ffff8880b9500000(0000)
> knlGS:0000000000000000
> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffdfebaf00c CR3: 000000000e132000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> =C2=A0<NMI>
> =C2=A0</NMI>
> =C2=A0<IRQ>
> =C2=A0put_dec+0x21/0xe0 lib/vsprintf.c:292
> =C2=A0number+0x337/0xf90 lib/vsprintf.c:511
> =C2=A0vsnprintf+0x1542/0x1da0 lib/vsprintf.c:2890
> =C2=A0sprintf+0xda/0x120 lib/vsprintf.c:3028
> =C2=A0print_time kernel/printk/printk.c:1327 [inline]
> =C2=A0info_print_prefix+0x16b/0x310 kernel/printk/printk.c:1353
> =C2=A0record_print_text kernel/printk/printk.c:1402 [inline]
> =C2=A0printk_get_next_message+0x6da/0xbe0 kernel/printk/printk.c:2855
> =C2=A0console_emit_next_record kernel/printk/printk.c:2895 [inline]
> =C2=A0console_flush_all+0x410/0xfd0 kernel/printk/printk.c:2994
> =C2=A0console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3063
> =C2=A0vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2345
> =C2=A0dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4942
> =C2=A0dev_printk_emit+0xdd/0x120 drivers/base/core.c:4953
> =C2=A0_dev_err+0x122/0x170 drivers/base/core.c:5008
> =C2=A0urb_irq_callback+0x3b7/0x5b0 drivers/input/misc/yealink.c:433
> =C2=A0__usb_hcd_giveback_urb+0x373/0x530 drivers/usb/core/hcd.c:1648
> =C2=A0dummy_timer+0x830/0x45d0 drivers/usb/gadget/udc/dummy_hcd.c:1987
> =C2=A0__run_hrtimer kernel/time/hrtimer.c:1687 [inline]
> =C2=A0__hrtimer_run_queues+0x5a5/0xd50 kernel/time/hrtimer.c:1751
> =C2=A0hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1813
> =C2=A0local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline=
]
> =C2=A0__sysvec_apic_timer_interrupt+0x110/0x3f0
> arch/x86/kernel/apic/apic.c:1049
> =C2=A0instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043
> [inline]
> =C2=A0sysvec_apic_timer_interrupt+0x52/0xc0
> arch/x86/kernel/apic/apic.c:1043
> =C2=A0asm_sysvec_apic_timer_interrupt+0x1a/0x20
> arch/x86/include/asm/idtentry.h:702
> RIP: 0010:__sanitizer_cov_trace_switch+0x8/0x120 kernel/kcov.c:317
> Code: cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90
> 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 <41>
> 54 53 4c 8b 16 48 8b 46 08 48 83 c0 f8 48 c1 c0 3d 48 83 f8 02
> RSP: 0018:ffffc90000a18430 EFLAGS: 00000202
> RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff88801b6c0000
> RDX: ffffffff903b5974 RSI: ffffffff8e1a1290 RDI: 0000000000000002
> RBP: ffffffff903b5979 R08: 0000000000000005 R09: ffffffff8140e71e
> R10: 0000000000000008 R11: ffff88801b6c0000 R12: ffffffff903b5978
> R13: dffffc0000000000 R14: ffffc90000a18570 R15: 1ffff920001430a4
> =C2=A0unwind_next_frame+0xff6/0x2a00 arch/x86/kernel/unwind_orc.c:581
> =C2=A0arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
> =C2=A0stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
> =C2=A0kasan_save_stack mm/kasan/common.c:47 [inline]
> =C2=A0kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> =C2=A0unpoison_slab_object mm/kasan/common.c:312 [inline]
> =C2=A0__kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
> =C2=A0kasan_slab_alloc include/linux/kasan.h:201 [inline]
> =C2=A0slab_post_alloc_hook mm/slub.c:3940 [inline]
> =C2=A0slab_alloc_node mm/slub.c:4000 [inline]
> =C2=A0kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4043
> =C2=A0__alloc_skb+0x1c3/0x440 net/core/skbuff.c:656
> =C2=A0alloc_skb include/linux/skbuff.h:1308 [inline]
> =C2=A0new_skb drivers/block/aoe/aoecmd.c:66 [inline]
> =C2=A0aoecmd_cfg_pkts drivers/block/aoe/aoecmd.c:427 [inline]
> =C2=A0aoecmd_cfg+0x2d3/0xa30 drivers/block/aoe/aoecmd.c:1362
> =C2=A0call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
> =C2=A0expire_timers kernel/time/timer.c:1843 [inline]
> =C2=A0__run_timers kernel/time/timer.c:2417 [inline]
> =C2=A0__run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
> =C2=A0run_timer_base kernel/time/timer.c:2437 [inline]
> =C2=A0run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
> =C2=A0handle_softirqs+0x2d6/0x990 kernel/softirq.c:554
> =C2=A0__do_softirq kernel/softirq.c:588 [inline]
> =C2=A0invoke_softirq kernel/softirq.c:428 [inline]
> =C2=A0__irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
> =C2=A0irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
> =C2=A0instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043
> [inline]
> =C2=A0sysvec_apic_timer_interrupt+0xa6/0xc0
> arch/x86/kernel/apic/apic.c:1043
> =C2=A0</IRQ>
> =C2=A0<TASK>
> =C2=A0asm_sysvec_apic_timer_interrupt+0x1a/0x20
> arch/x86/include/asm/idtentry.h:702
> RIP: 0010:console_flush_all+0xaad/0xfd0 kernel/printk/printk.c:3000
> Code: ff ff e8 56 bb 1f 00 90 0f 0b 90 e9 d8 f8 ff ff e8 48 bb 1f 00
> e8 63 92 13 0a 4d 85 f6 74 b6 e8 39 bb 1f 00 fb 48 8b 44 24 70 <42>
> 0f b6 04 38 84 c0 48 8b 7c 24 30 0f 85 22 02 00 00 0f b6 1f 31
> RSP: 0018:ffffc90000b56600 EFLAGS: 00000293
> RAX: 1ffff9200016ad0c RBX: 0000000000000000 RCX: ffff88801b6c0000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc90000b567b0 R08: ffffffff81765a44 R09: 1ffffffff25f54be
> R10: dffffc0000000000 R11: fffffbfff25f54bf R12: ffffffff8eb21498
> R13: ffffffff8eb21440 R14: 0000000000000200 R15: dffffc0000000000
> =C2=A0console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3063
> =C2=A0vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2345
> =C2=A0dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4942
> =C2=A0dev_printk_emit+0xdd/0x120 drivers/base/core.c:4953
> =C2=A0_dev_err+0x122/0x170 drivers/base/core.c:5008
> =C2=A0usb_probe+0xf41/0x1340 drivers/input/misc/yealink.c:910
> =C2=A0usb_probe_interface+0x645/0xbb0 drivers/usb/core/driver.c:399
> =C2=A0really_probe+0x2b8/0xad0 drivers/base/dd.c:656
> =C2=A0__driver_probe_device+0x1a2/0x390 drivers/base/dd.c:798
> =C2=A0driver_probe_device+0x50/0x430 drivers/base/dd.c:828
> =C2=A0__device_attach_driver+0x2d6/0x530 drivers/base/dd.c:956
> =C2=A0bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:457
> =C2=A0__device_attach+0x333/0x520 drivers/base/dd.c:1028
> =C2=A0bus_probe_device+0x189/0x260 drivers/base/bus.c:532
> =C2=A0device_add+0x856/0xbf0 drivers/base/core.c:3712
> =C2=A0usb_set_configuration+0x1976/0x1fb0 drivers/usb/core/message.c:2210
> =C2=A0usb_generic_driver_probe+0x88/0x140 drivers/usb/core/generic.c:254
> =C2=A0usb_probe_device+0x1b8/0x380 drivers/usb/core/driver.c:294
> =C2=A0really_probe+0x2b8/0xad0 drivers/base/dd.c:656
> =C2=A0__driver_probe_device+0x1a2/0x390 drivers/base/dd.c:798
> =C2=A0driver_probe_device+0x50/0x430 drivers/base/dd.c:828
> =C2=A0__device_attach_driver+0x2d6/0x530 drivers/base/dd.c:956
> =C2=A0bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:457
> =C2=A0__device_attach+0x333/0x520 drivers/base/dd.c:1028
> =C2=A0bus_probe_device+0x189/0x260 drivers/base/bus.c:532
> =C2=A0device_add+0x856/0xbf0 drivers/base/core.c:3712
> =C2=A0usb_new_device+0x104a/0x19a0 drivers/usb/core/hub.c:2652
> =C2=A0hub_port_connect drivers/usb/core/hub.c:5522 [inline]
> =C2=A0hub_port_connect_change drivers/usb/core/hub.c:5662 [inline]
> =C2=A0port_event drivers/usb/core/hub.c:5822 [inline]
> =C2=A0hub_event+0x2d6a/0x5150 drivers/usb/core/hub.c:5904
> =C2=A0process_one_work kernel/workqueue.c:3231 [inline]
> =C2=A0process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
> =C2=A0worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
> =C2=A0kthread+0x2f0/0x390 kernel/kthread.c:389
> =C2=A0ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> =C2=A0ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> =C2=A0</TASK>
> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run:
> 6.706 msecs
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq_callback - urb status -71
> yealink 3-1:36.0: unexpected response 0
> yealink 3-1:36.0: urb_ctl_callback - urb status -71
> yealink 3-1:36.0: urb_irq
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ=C2=A0for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status=C2=A0for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before
> testing.
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup
>=20

This is all the logging to the console that causes this and we have a
had a few suggestions to improve the low level console code.=20
So no fixes right now to fix this type of RCU due to the console that I
think is pretty well known.

Thanks
Laurence

