Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1212E1F0;
	Fri, 24 May 2024 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566859; cv=none; b=nMlLAU/x/gx8h7QvCm/5lcqm8Y2jcnnch4GjJkz6msM/31p8ElD6LwbkH4qX03atEQDmeExFk2S7K9mnmlJiqpzrklmmGAaRI6M8MwJU86q+YP6qDg2O2lYIzFQQcgBSfXmmvaVXp16ZZiytMVSMFf8pwXfuzKvoXtu88a9dLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566859; c=relaxed/simple;
	bh=EiWnoKUfBxUr8AoTJrjrbQr3X8q8arZr327Zo2Zz9Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMK0vGNIbqnI3n7iY4dhb3FA/lzChuGlmV9MrKOxxCKui5IaEzVvzCUEyYtG2+Xi+n+Drmdx8f4/7z0HhMukbaF1vQEHnQVjAuF9cD4ZG4bAhdvmWBZ3Xbu5AlaHJlS2yyVsZ32nuxM2UbMY8B+aqt2P/ooPqMqNty/ovJqfJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 302B543BD7;
	Fri, 24 May 2024 18:07:32 +0200 (CEST)
Message-ID: <14b89dfb-505c-49f7-aebb-01c54451db40@proxmox.com>
Date: Fri, 24 May 2024 18:07:30 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] blk-flush: reuse rq queuelist in flush state
 machine
To: chengming.zhou@linux.dev, axboe@kernel.dk, ming.lei@redhat.com,
 hch@lst.de, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20230717040058.3993930-1-chengming.zhou@linux.dev>
 <20230717040058.3993930-5-chengming.zhou@linux.dev>
Content-Language: en-US
From: Friedrich Weber <f.weber@proxmox.com>
In-Reply-To: <20230717040058.3993930-5-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

some of our (Proxmox VE) users have been reporting crashes [1] with NULL
pointer dereferences in blk_flush_complete_seq. AFAICT, all systems
crashing in blk_flush_complete_seq used software RAID1, and ran our
downstream kernel based on (Ubuntu) kernel 6.8.

On mainline kernel 6.9, I can reproduce the crash [1] by:

* compiling the kernel with CONFIG_FAIL_MAKE_REQUEST enabled
* setting up root on software RAID1
* enabling the write-intent bitmap with `mdadm --grow --bitmap=internal
/dev/md0`. So far, I have not been able to reproduce the crash with the
write-intent bitmap disabled.
* injecting write faults via CONFIG_FAIL_MAKE_REQUEST on one of the
RAID1 disks
* generating IO in a KVM guest with fio
* waiting ~5 minutes

I've used this reproducer for a bisect, which produced

 81ada09cc25e (blk-flush: reuse rq queuelist in flush state machine)

as the first commit with which I can reproduce the crashes. I'm not 100%
sure it is this one because the reproducer is a bit flaky. But it does
sound plausible, as the commit is included in our 6.8 kernel, and
touches `queuelist` which is AFAICT where blk_flush_complete_seq
dereferences the NULL pointer.

Does anyone have an idea what could be the cause for the crash, or how
to further debug this? Happy to provide more information if needed, as
well as the complete reproducer (I'd need to clean it up a little bit
first).

Do you think this could also affect setups without software RAID?

Best,

Friedrich

[1]

[  132.292488] BUG: kernel NULL pointer dereference, address:
0000000000000008
[  132.293594] #PF: supervisor write access in kernel mode
[  132.294408] #PF: error_code(0x0002) - not-present page
[  132.295187] PGD 0 P4D 0
[  132.295609] Oops: 0002 [#1] PREEMPT SMP NOPTI
[  132.296285] CPU: 0 PID: 776 Comm: kvm Tainted: G            E
6.5.0-rc2-bisect11+ #22
[  132.297556] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  132.299292] RIP: 0010:blk_flush_complete_seq+0x296/0x2e0
[  132.300122] Code: 0f b6 f6 49 8d 56 01 49 c1 e6 04 4d 01 ee 48 c1 e2
04 49 8b 4e 10 4c 01 ea 48 39 ca 74 2b 48 8b 4b 50 48 8b 7b 48 48 8d 73
48 <48> 89 4f 08 48 89 39 49 8b 4e 18 49 89 76 18 48 89 53 48 48 89 4b
[  132.302946] RSP: 0018:ffffa431407a39b8 EFLAGS: 00010046
[  132.303765] RAX: 0000000000000000 RBX: ffff92d00c2fd000 RCX:
ffff92d00c2fd048
[  132.304856] RDX: ffff92d0036dfaa0 RSI: ffff92d00c2fd048 RDI:
0000000000000000
[  132.305948] RBP: ffffa431407a39f8 R08: 0000000000000000 R09:
0000000000000000
[  132.307043] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000000801
[  132.308120] R13: ffff92d0036dfa80 R14: ffff92d0036dfa90 R15:
ffff92d00ba09e00
[  132.309216] FS:  0000727d191b86c0(0000) GS:ffff92d137c00000(0000)
knlGS:0000000000000000
[  132.310457] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  132.311355] CR2: 0000000000000008 CR3: 000000018f088006 CR4:
0000000000372ef0
[  132.312444] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  132.313535] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  132.314633] Call Trace:
[  132.315016]  <TASK>
[  132.315381]  ? show_regs+0x6d/0x80
[  132.315921]  ? __die+0x24/0x80
[  132.316421]  ? page_fault_oops+0x176/0x500
[  132.317049]  ? do_user_addr_fault+0x31d/0x6a0
[  132.317744]  ? exc_page_fault+0x83/0x1b0
[  132.318368]  ? asm_exc_page_fault+0x27/0x30
[  132.319008]  ? blk_flush_complete_seq+0x296/0x2e0
[  132.319759]  ? __blk_mq_alloc_requests+0x383/0x3a0
[  132.320505]  ? wbt_wait+0xb3/0x100
[  132.321041]  blk_insert_flush+0xd1/0x220
[  132.321664]  blk_mq_submit_bio+0x564/0x690
[  132.322294]  __submit_bio+0xb3/0x1c0
[  132.322859]  submit_bio_noacct_nocheck+0x2b7/0x390
[  132.323622]  submit_bio_noacct+0x18a/0x6b0
[  132.324241]  submit_bio+0x6c/0x80
[  132.324774]  md_super_write+0xd1/0x120
[  132.325376]  write_page+0x23b/0x3f0
[  132.325915]  ? md_bitmap_wait_writes+0xda/0xf0
[  132.326624]  md_bitmap_unplug+0x9f/0x140
[  132.327251]  flush_bio_list+0x102/0x110 [raid1]
[  132.327963]  raid1_unplug+0x3c/0xe0 [raid1]
[  132.328626]  __blk_flush_plug+0xc1/0x130
[  132.329238]  blk_finish_plug+0x31/0x50
[  132.329819]  io_submit_sqes+0x53e/0x680
[  132.330426]  __do_sys_io_uring_enter+0x59a/0xc10
[  132.331149]  ? vfs_read+0x20a/0x360
[  132.331699]  __x64_sys_io_uring_enter+0x22/0x40
[  132.332414]  do_syscall_64+0x58/0x90
[  132.332979]  ? ksys_read+0xe6/0x100
[  132.333530]  ? exit_to_user_mode_prepare+0x49/0x220
[  132.334292]  ? syscall_exit_to_user_mode+0x1b/0x50
[  132.335032]  ? do_syscall_64+0x67/0x90
[  132.335627]  ? syscall_exit_to_user_mode+0x1b/0x50
[  132.336381]  ? do_syscall_64+0x67/0x90
[  132.336958]  ? syscall_exit_to_user_mode+0x1b/0x50
[  132.337707]  ? do_syscall_64+0x67/0x90
[  132.338296]  ? syscall_exit_to_user_mode+0x1b/0x50
[  132.339045]  ? do_syscall_64+0x67/0x90
[  132.339646]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  132.340426] RIP: 0033:0x727d26282b95
[  132.341011] Code: 00 00 00 44 89 d0 41 b9 08 00 00 00 83 c8 10 f6 87
d0 00 00 00 01 8b bf cc 00 00 00 44 0f 45 d0 45 31 c0 b8 aa 01 00 00 0f
05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 41 83 e2 02 74 c2 f0 48 83 0c 24
[  132.343837] RSP: 002b:0000727d191b2fd8 EFLAGS: 00000246 ORIG_RAX:
00000000000001aa
[  132.344990] RAX: ffffffffffffffda RBX: 0000727d0c0039d0 RCX:
0000727d26282b95
[  132.346079] RDX: 0000000000000000 RSI: 0000000000000003 RDI:
0000000000000033
[  132.347176] RBP: 0000727d0c0039d8 R08: 0000000000000000 R09:
0000000000000008
[  132.348272] R10: 0000000000000000 R11: 0000000000000246 R12:
0000727d0c003ac0
[  132.349376] R13: 0000000000000000 R14: 00005a5a2313bc68 R15:
00005a5a25cf0450
[  132.350472]  </TASK>
[  132.350828] Modules linked in: veth(E) cmac(E) nls_utf8(E) cifs(E)
cifs_arc4(E) rdma_cm(E) iw_cm(E) ib_cm(E) ib_core(E) cifs_md4(E)
ebtable_filter(E) ebtables(E) ip_set(E) ip6table_raw(E) iptable_raw(E)
ip6table_filter(E) ip6_tables(E) iptable_filter(E) nf_tables(E)
sunrpc(E) softdog(E) binfmt_misc(E) bonding(E) tls(E) nfnetlink_log(E)
nfnetlink(E) intel_rapl_msr(E) intel_rapl_common(E) intel_pmc_core(E)
kvm_intel(E) kvm(E) irqbypass(E) crct10dif_pclmul(E) polyval_clmulni(E)
polyval_generic(E) ghash_clmulni_intel(E) aesni_intel(E) crypto_simd(E)
cryptd(E) rapl(E) pcspkr(E) vmgenid(E) joydev(E) input_leds(E)
mac_hid(E) serio_raw(E) vhost_net(E) vhost(E) vhost_iotlb(E) tap(E)
efi_pstore(E) dmi_sysfs(E) qemu_fw_cfg(E) ip_tables(E) x_tables(E)
autofs4(E) hid_generic(E) usbhid(E) hid(E) raid10(E) raid456(E)
async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E)
async_tx(E) xor(E) raid6_pq(E) libcrc32c(E) raid0(E) raid1(E)
crc32_pclmul(E) bochs(E) drm_vram_helper(E) psmouse(E) drm_ttm_helper(E)
uhci_hcd(E) ttm(E)
[  132.350919]  ehci_hcd(E) i2c_piix4(E) pata_acpi(E) floppy(E)
[  132.365204] CR2: 0000000000000008
[  132.365747] ---[ end trace 0000000000000000 ]---
[  132.366468] RIP: 0010:blk_flush_complete_seq+0x296/0x2e0
[  132.367290] Code: 0f b6 f6 49 8d 56 01 49 c1 e6 04 4d 01 ee 48 c1 e2
04 49 8b 4e 10 4c 01 ea 48 39 ca 74 2b 48 8b 4b 50 48 8b 7b 48 48 8d 73
48 <48> 89 4f 08 48 89 39 49 8b 4e 18 49 89 76 18 48 89 53 48 48 89 4b
[  132.370119] RSP: 0018:ffffa431407a39b8 EFLAGS: 00010046
[  132.370935] RAX: 0000000000000000 RBX: ffff92d00c2fd000 RCX:
ffff92d00c2fd048
[  132.372015] RDX: ffff92d0036dfaa0 RSI: ffff92d00c2fd048 RDI:
0000000000000000
[  132.373115] RBP: ffffa431407a39f8 R08: 0000000000000000 R09:
0000000000000000
[  132.374193] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000000801
[  132.375286] R13: ffff92d0036dfa80 R14: ffff92d0036dfa90 R15:
ffff92d00ba09e00
[  132.376385] FS:  0000727d191b86c0(0000) GS:ffff92d137c00000(0000)
knlGS:0000000000000000
[  132.377600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  132.378486] CR2: 0000000000000008 CR3: 000000018f088006 CR4:
0000000000372ef0
[  132.379564] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  132.380638] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  132.381738] note: kvm[776] exited with irqs disabled
[  132.382631] note: kvm[776] exited with preempt_count 1
[  132.383469] ------------[ cut here ]------------
[  132.384193] WARNING: CPU: 0 PID: 776 at kernel/exit.c:818
do_exit+0x8db/0xae0
[  132.385307] Modules linked in: veth(E) cmac(E) nls_utf8(E) cifs(E)
cifs_arc4(E) rdma_cm(E) iw_cm(E) ib_cm(E) ib_core(E) cifs_md4(E)
ebtable_filter(E) ebtables(E) ip_set(E) ip6table_raw(E) iptable_raw(E)
ip6table_filter(E) ip6_tables(E) iptable_filter(E) nf_tables(E)
sunrpc(E) softdog(E) binfmt_misc(E) bonding(E) tls(E) nfnetlink_log(E)
nfnetlink(E) intel_rapl_msr(E) intel_rapl_common(E) intel_pmc_core(E)
kvm_intel(E) kvm(E) irqbypass(E) crct10dif_pclmul(E) polyval_clmulni(E)
polyval_generic(E) ghash_clmulni_intel(E) aesni_intel(E) crypto_simd(E)
cryptd(E) rapl(E) pcspkr(E) vmgenid(E) joydev(E) input_leds(E)
mac_hid(E) serio_raw(E) vhost_net(E) vhost(E) vhost_iotlb(E) tap(E)
efi_pstore(E) dmi_sysfs(E) qemu_fw_cfg(E) ip_tables(E) x_tables(E)
autofs4(E) hid_generic(E) usbhid(E) hid(E) raid10(E) raid456(E)
async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E)
async_tx(E) xor(E) raid6_pq(E) libcrc32c(E) raid0(E) raid1(E)
crc32_pclmul(E) bochs(E) drm_vram_helper(E) psmouse(E) drm_ttm_helper(E)
uhci_hcd(E) ttm(E)
[  132.385396]  ehci_hcd(E) i2c_piix4(E) pata_acpi(E) floppy(E)
[  132.399854] CPU: 0 PID: 776 Comm: kvm Tainted: G      D     E
6.5.0-rc2-bisect11+ #22
[  132.401165] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  132.402987] RIP: 0010:do_exit+0x8db/0xae0
[  132.403661] Code: e9 44 f8 ff ff 48 8b bb d8 09 00 00 31 f6 e8 fc d7
ff ff e9 f0 fd ff ff 4c 89 ee bf 05 06 00 00 e8 4a 2e 01 00 e9 70 f8 ff
ff <0f> 0b e9 9e f7 ff ff 0f 0b e9 57 f7 ff ff 48 89 df e8 bf 7d 13 00
[  132.406622] RSP: 0018:ffffa431407a3ec8 EFLAGS: 00010282
[  132.407487] RAX: 0000000000000000 RBX: ffff92d08d53a940 RCX:
0000000000000000
[  132.408637] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  132.409791] RBP: ffffa431407a3f20 R08: 0000000000000000 R09:
0000000000000000
[  132.410961] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff92d0031cba80
[  132.412102] R13: 0000000000000009 R14: ffff92d090d53180 R15:
0000000000000000
[  132.413256] FS:  0000727d191b86c0(0000) GS:ffff92d137c00000(0000)
knlGS:0000000000000000
[  132.414582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  132.415512] CR2: 0000000000000008 CR3: 000000018f088006 CR4:
0000000000372ef0
[  132.416670] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  132.417842] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  132.418998] Call Trace:
[  132.419430]  <TASK>
[  132.419788]  ? show_regs+0x6d/0x80
[  132.420352]  ? __warn+0x89/0x160
[  132.420891]  ? do_exit+0x8db/0xae0
[  132.421477]  ? report_bug+0x17e/0x1b0
[  132.422063]  ? handle_bug+0x46/0x90
[  132.422655]  ? exc_invalid_op+0x18/0x80
[  132.423299]  ? asm_exc_invalid_op+0x1b/0x20
[  132.423975]  ? do_exit+0x8db/0xae0
[  132.424565]  ? do_exit+0x72/0xae0
[  132.425131]  ? _printk+0x60/0x90
[  132.425666]  make_task_dead+0x86/0x180
[  132.426297]  rewind_stack_and_make_dead+0x17/0x20
[  132.427056] RIP: 0033:0x727d26282b95
[  132.427681] Code: 00 00 00 44 89 d0 41 b9 08 00 00 00 83 c8 10 f6 87
d0 00 00 00 01 8b bf cc 00 00 00 44 0f 45 d0 45 31 c0 b8 aa 01 00 00 0f
05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 41 83 e2 02 74 c2 f0 48 83 0c 24
[  132.430663] RSP: 002b:0000727d191b2fd8 EFLAGS: 00000246 ORIG_RAX:
00000000000001aa
[  132.431895] RAX: ffffffffffffffda RBX: 0000727d0c0039d0 RCX:
0000727d26282b95
[  132.433049] RDX: 0000000000000000 RSI: 0000000000000003 RDI:
0000000000000033
[  132.434203] RBP: 0000727d0c0039d8 R08: 0000000000000000 R09:
0000000000000008
[  132.435372] R10: 0000000000000000 R11: 0000000000000246 R12:
0000727d0c003ac0
[  132.436529] R13: 0000000000000000 R14: 00005a5a2313bc68 R15:
00005a5a25cf0450
[  132.437685]  </TASK>
[  132.438056] ---[ end trace 0000000000000000 ]---

