Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA413CA8C
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887399; cv=none; b=QKqgebzaAnwFoGCvgJrqEkacNWBSxipYXC1KZq66l/kmFnefIJ9yNt4JLXpWNUmvvaGXqxhjpilqcItEP7EoSti8kVFTMRqOn4JfNksWUalG06VvCHmWbOhe3QU0OKJ0XbVzI6V/Qb1XK0sokS+wpql4Tp1Z+1BbKNdzmscfFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887399; c=relaxed/simple;
	bh=zTQzgE3eWHg6F6KHEIeloSc0ssU0F/ox1vXq/d8t6q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiAhCXi08O8GSPANtdSsasdxHAjb6VIYlMofIvTdtsvAN+XnWodrX5TlX5wyBpZNvccUjCOv/W4+ydtm1wd+MvumkG+SjZCRAfvzlqr9Ye4bZjOE9sH2wD3PthVw1M0xSMmT/w891scTRAiSua3gIb03NC8cHprH/gAuloWt+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sb63EA02; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sb63EA02"
X-Envelope-To: f.weber@proxmox.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716887393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYoQuN+XqAHkqT8yJ//KWds3rQHxotVteMXz4ukie7I=;
	b=Sb63EA02HY4LQhu3dLVeItQi+FfIyz8qh+2NDcuKeveJQAI7Gil9w9sHBe+2MiV/xqnbpu
	pcdOpeAZfRcR6gYxgfsCxaEPIgfh1UdP0J/FdI2D73bZgegHb6RbeORYXuCalhOt6Tw3au
	z0M1luZMq+i11qiHDJHWPWYWbc6mvP4=
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: ming.lei@redhat.com
X-Envelope-To: hch@lst.de
X-Envelope-To: bvanassche@acm.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: zhouchengming@bytedance.com
Message-ID: <09be2bc6-d16a-4740-908a-f157dcd97ca8@linux.dev>
Date: Tue, 28 May 2024 17:09:47 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/4] blk-flush: reuse rq queuelist in flush state
 machine
Content-Language: en-US
To: Friedrich Weber <f.weber@proxmox.com>, axboe@kernel.dk,
 ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20230717040058.3993930-1-chengming.zhou@linux.dev>
 <20230717040058.3993930-5-chengming.zhou@linux.dev>
 <14b89dfb-505c-49f7-aebb-01c54451db40@proxmox.com>
 <984f1f77-288c-441a-a649-5f320249b576@linux.dev>
 <4d799672-378b-42b1-896b-38df2c5e9c84@proxmox.com>
 <0783d367-4608-4b16-9b88-6eaf5d5706eb@linux.dev>
 <8b1400e6-b35e-486b-8ea0-de76270267c0@linux.dev>
 <87f495c2-7504-4d22-b355-608b13c456cd@linux.dev>
 <cb0fab18-ba27-420f-ace3-b099c74398c6@proxmox.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <cb0fab18-ba27-420f-ace3-b099c74398c6@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/28 16:42, Friedrich Weber wrote:
> Hope I did this correctly. With this, the reproducer triggered a BUG
> pretty quickly, see [0]. If I can provide anything else, just let me know.

Thanks for your patience, it's correct. Then how about this fix?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d98654869615..b2ec5c4c738f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -485,6 +485,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
        if (data->nr_tags > 1) {
                rq = __blk_mq_alloc_requests_batch(data);
                if (rq) {
+                       INIT_LIST_HEAD(&rq->queuelist);
                        blk_mq_rq_time_init(rq, alloc_time_ns);
                        return rq;
                }

> 
> I forgot to mention earlier that I'm running the reproducer against a
> QEMU/KVM guest too, for convenience -- so, the "host" from my previous
> post is in fact running virtualized. I don't think it should be relevant
> here, but I'll try to run the reproducer against real hardware too.

Yeah, I think it should not be relevant.

Thanks.

> 
> Best,
> 
> Friedrich
> 
> [0]
> 
> [   37.543834] kernel BUG at block/blk-mq.c:2991!
> [   37.544458] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [   37.545077] CPU: 4 PID: 795 Comm: kvm Tainted: G            E
> 6.9.0-troubleshoot1-dirty #28
> [   37.546087] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   37.547389] RIP: 0010:blk_mq_submit_bio+0x6f5/0x750
> [   37.547949] Code: ff e9 aa fc ff ff e8 7a 3c a4 ff 48 89 de 4c 89 e7
> e8 9f ef ff ff e8 da 79 a4 ff e9 99 fc ff ff e8 d0 45 a7 ff e9 cd fa ff
> ff <0f> 0b 0f 0b 48 8b 03 48 8b 40 68 48 8b 40 40 e9 8c fb ff ff f6 43
> [   37.550088] RSP: 0018:ffffa2b480863a70 EFLAGS: 00010246
> [   37.550685] RAX: 0000000000000000 RBX: ffff971c0b29d000 RCX:
> 0000000000000000
> [   37.551502] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [   37.552325] RBP: ffffa2b480863ae8 R08: 0000000000000000 R09:
> 0000000000000000
> [   37.553130] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff971c106ee600
> [   37.553934] R13: ffff971c0fb328f0 R14: ffff971c03b330c0 R15:
> 0000000000000001
> [   37.554747] FS:  00007bcc47e006c0(0000) GS:ffff971d37c00000(0000)
> knlGS:0000000000000000
> [   37.555663] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   37.556311] CR2: 000070d06e1a40a0 CR3: 000000010b6f4004 CR4:
> 0000000000372ef0
> [   37.557117] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [   37.557935] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [   37.558789] Call Trace:
> [   37.559080]  <TASK>
> [   37.559355]  ? show_regs+0x6c/0x80
> [   37.560276]  ? die+0x37/0xa0
> [   37.560633]  ? do_trap+0xda/0xf0
> [   37.561023]  ? do_error_trap+0x71/0xb0
> [   37.561486]  ? blk_mq_submit_bio+0x6f5/0x750
> [   37.562008]  ? exc_invalid_op+0x52/0x80
> [   37.562463]  ? blk_mq_submit_bio+0x6f5/0x750
> [   37.562987]  ? asm_exc_invalid_op+0x1b/0x20
> [   37.563492]  ? blk_mq_submit_bio+0x6f5/0x750
> [   37.564007]  __submit_bio+0xb3/0x1c0
> [   37.564439]  submit_bio_noacct_nocheck+0x2fc/0x3d0
> [   37.565019]  submit_bio_noacct+0x1ba/0x6b0
> [   37.565508]  flush_bio_list+0x71/0x110 [raid1]
> [   37.566049]  raid1_unplug+0x3c/0xf0 [raid1]
> [   37.566539]  __blk_flush_plug+0xbe/0x140
> [   37.567016]  blk_finish_plug+0x30/0x50
> [   37.567466]  io_submit_sqes+0x4c4/0x6c0
> [   37.567942]  ? syscall_exit_to_user_mode+0x81/0x270
> [   37.568530]  __do_sys_io_uring_enter+0x2f2/0x640
> [   37.569070]  __x64_sys_io_uring_enter+0x22/0x40
> [   37.569626]  x64_sys_call+0x20b9/0x24b0
> [   37.570071]  do_syscall_64+0x80/0x170
> [   37.570525]  ? vfs_read+0x240/0x380
> [   37.570937]  ? ksys_read+0xe6/0x100
> [   37.571360]  ? syscall_exit_to_user_mode+0x81/0x270
> [   37.571930]  ? do_syscall_64+0x8c/0x170
> [   37.572402]  ? syscall_exit_to_user_mode+0x81/0x270
> [   37.572969]  ? do_syscall_64+0x8c/0x170
> [   37.573438]  ? irqentry_exit+0x43/0x50
> [   37.573878]  ? clear_bhb_loop+0x15/0x70
> [   37.574348]  ? clear_bhb_loop+0x15/0x70
> [   37.574806]  ? clear_bhb_loop+0x15/0x70
> [   37.575282]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   37.575891] RIP: 0033:0x7bcc58f45b95
> [   37.576335] Code: 00 00 00 44 89 d0 41 b9 08 00 00 00 83 c8 10 f6 87
> d0 00 00 00 01 8b bf cc 00 00 00 44 0f 45 d0 45 31 c0 b8 aa 01 00 00 0f
> 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 41 83 e2 02 74 c2 f0 48 83 0c 24
> [   37.578468] RSP: 002b:00007bcc47dfafd8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000001aa
> [   37.579359] RAX: ffffffffffffffda RBX: 00007bcc400039d0 RCX:
> 00007bcc58f45b95
> [   37.580198] RDX: 0000000000000000 RSI: 0000000000000003 RDI:
> 0000000000000033
> [   37.581028] RBP: 00007bcc400039d8 R08: 0000000000000000 R09:
> 0000000000000008
> [   37.581864] R10: 0000000000000000 R11: 0000000000000246 R12:
> 00007bcc40003ac0
> [   37.582695] R13: 0000000000000000 R14: 0000591ad05f5c68 R15:
> 0000591b10198450
> [   37.583534]  </TASK>
> [   37.583812] Modules linked in: veth(E) cmac(E) nls_utf8(E) cifs(E)
> cifs_arc4(E) nls_ucs2_utils(E) rdma_cm(E) iw_cm(E) ib_cm(E) ib_core(E)
> cifs_md4(E) netfs(E) ebtable_filter(E) ebtables(E) ip_set(E)
> ip6table_raw(E) iptable_raw(E) ip6table_filter(E) ip6_tables(E)
> iptable_filter(E) nf_tables(E) softdog(E) sunrpc(E) binfmt_misc(E)
> bonding(E) tls(E) nfnetlink_log(E) nfnetlink(E) intel_rapl_msr(E)
> intel_rapl_common(E) intel_uncore_frequency_common(E) intel_pmc_core(E)
> intel_vsec(E) pmt_telemetry(E) pmt_class(E) kvm_intel(E) kvm(E)
> crct10dif_pclmul(E) polyval_clmulni(E) polyval_generic(E)
> ghash_clmulni_intel(E) sha256_ssse3(E) sha1_ssse3(E) hid_generic(E)
> aesni_intel(E) crypto_simd(E) cryptd(E) usbhid(E) hid(E) rapl(E)
> pcspkr(E) vmgenid(E) joydev(E) input_leds(E) mac_hid(E) serio_raw(E)
> vhost_net(E) vhost(E) vhost_iotlb(E) tap(E) efi_pstore(E) dmi_sysfs(E)
> qemu_fw_cfg(E) ip_tables(E) x_tables(E) autofs4(E) raid10(E) raid456(E)
> async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E)
> async_tx(E) xor(E) raid6_pq(E)
> [   37.583875]  libcrc32c(E) raid0(E) raid1(E) crc32_pclmul(E)
> psmouse(E) bochs(E) drm_vram_helper(E) drm_ttm_helper(E) uhci_hcd(E)
> ttm(E) ehci_hcd(E) i2c_piix4(E) pata_acpi(E) floppy(E)
> [   37.595967] ---[ end trace 0000000000000000 ]---
> [   37.596555] RIP: 0010:blk_mq_submit_bio+0x6f5/0x750
> [   37.597144] Code: ff e9 aa fc ff ff e8 7a 3c a4 ff 48 89 de 4c 89 e7
> e8 9f ef ff ff e8 da 79 a4 ff e9 99 fc ff ff e8 d0 45 a7 ff e9 cd fa ff
> ff <0f> 0b 0f 0b 48 8b 03 48 8b 40 68 48 8b 40 40 e9 8c fb ff ff f6 43
> [   37.599320] RSP: 0018:ffffa2b480863a70 EFLAGS: 00010246
> [   37.599932] RAX: 0000000000000000 RBX: ffff971c0b29d000 RCX:
> 0000000000000000
> [   37.600757] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [   37.601600] RBP: ffffa2b480863ae8 R08: 0000000000000000 R09:
> 0000000000000000
> [   37.602450] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff971c106ee600
> [   37.603299] R13: ffff971c0fb328f0 R14: ffff971c03b330c0 R15:
> 0000000000000001
> [   37.604129] FS:  00007bcc47e006c0(0000) GS:ffff971d37c00000(0000)
> knlGS:0000000000000000
> [   37.605079] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   37.605774] CR2: 000070d06e1a40a0 CR3: 000000010b6f4004 CR4:
> 0000000000372ef0
> [   37.606620] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [   37.607464] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [   37.608335] ------------[ cut here ]------------
> [   37.608885] WARNING: CPU: 4 PID: 795 at kernel/exit.c:827
> do_exit+0x8a2/0xab0
> [   37.609754] Modules linked in: veth(E) cmac(E) nls_utf8(E) cifs(E)
> cifs_arc4(E) nls_ucs2_utils(E) rdma_cm(E) iw_cm(E) ib_cm(E) ib_core(E)
> cifs_md4(E) netfs(E) ebtable_filter(E) ebtables(E) ip_set(E)
> ip6table_raw(E) iptable_raw(E) ip6table_filter(E) ip6_tables(E)
> iptable_filter(E) nf_tables(E) softdog(E) sunrpc(E) binfmt_misc(E)
> bonding(E) tls(E) nfnetlink_log(E) nfnetlink(E) intel_rapl_msr(E)
> intel_rapl_common(E) intel_uncore_frequency_common(E) intel_pmc_core(E)
> intel_vsec(E) pmt_telemetry(E) pmt_class(E) kvm_intel(E) kvm(E)
> crct10dif_pclmul(E) polyval_clmulni(E) polyval_generic(E)
> ghash_clmulni_intel(E) sha256_ssse3(E) sha1_ssse3(E) hid_generic(E)
> aesni_intel(E) crypto_simd(E) cryptd(E) usbhid(E) hid(E) rapl(E)
> pcspkr(E) vmgenid(E) joydev(E) input_leds(E) mac_hid(E) serio_raw(E)
> vhost_net(E) vhost(E) vhost_iotlb(E) tap(E) efi_pstore(E) dmi_sysfs(E)
> qemu_fw_cfg(E) ip_tables(E) x_tables(E) autofs4(E) raid10(E) raid456(E)
> async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E)
> async_tx(E) xor(E) raid6_pq(E)
> [   37.609827]  libcrc32c(E) raid0(E) raid1(E) crc32_pclmul(E)
> psmouse(E) bochs(E) drm_vram_helper(E) drm_ttm_helper(E) uhci_hcd(E)
> ttm(E) ehci_hcd(E) i2c_piix4(E) pata_acpi(E) floppy(E)
> [   37.622013] CPU: 4 PID: 795 Comm: kvm Tainted: G      D     E
> 6.9.0-troubleshoot1-dirty #28
> [   37.623045] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   37.624382] RIP: 0010:do_exit+0x8a2/0xab0
> [   37.624869] Code: 38 0c 00 00 e9 2d fe ff ff 49 8d 7d 18 e8 b6 83 07
> 00 e9 5a f8 ff ff 48 8b bb f8 09 00 00 31 f6 e8 b3 e0 ff ff e9 c1 fd ff
> ff <0f> 0b e9 d4 f7 ff ff 0f 0b e9 8f f7 ff ff 4c 89 e6 bf 05 06 00 00
> [   37.627117] RSP: 0018:ffffa2b480863ec8 EFLAGS: 00010286
> [   37.627780] RAX: 0000000000000000 RBX: ffff971c05458000 RCX:
> 0000000000000000
> [   37.628638] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [   37.629512] RBP: ffffa2b480863f20 R08: 0000000000000000 R09:
> 0000000000000000
> [   37.630379] R10: 0000000000000000 R11: 0000000000000000 R12:
> 000000000000000b
> [   37.631231] R13: ffff971c04c8d100 R14: ffff971c00c28000 R15:
> ffffa2b4808639c8
> [   37.632095] FS:  00007bcc47e006c0(0000) GS:ffff971d37c00000(0000)
> knlGS:0000000000000000
> [   37.633090] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   37.633794] CR2: 000070d06e1a40a0 CR3: 000000010b6f4004 CR4:
> 0000000000372ef0
> [   37.634666] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [   37.635533] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [   37.636387] Call Trace:
> [   37.636692]  <TASK>
> [   37.636963]  ? show_regs+0x6c/0x80
> [   37.637393]  ? __warn+0x88/0x140
> [   37.637801]  ? do_exit+0x8a2/0xab0
> [   37.638197]  ? report_bug+0x182/0x1b0
> [   37.638674]  ? handle_bug+0x46/0x90
> [   37.639094]  ? exc_invalid_op+0x18/0x80
> [   37.639577]  ? asm_exc_invalid_op+0x1b/0x20
> [   37.640090]  ? do_exit+0x8a2/0xab0
> [   37.640537]  ? do_exit+0x6f/0xab0
> [   37.640941]  ? syscall_exit_to_user_mode+0x81/0x270
> [   37.641542]  make_task_dead+0x81/0x160
> [   37.641999]  rewind_stack_and_make_dead+0x16/0x20
> [   37.642586] RIP: 0033:0x7bcc58f45b95
> [   37.643046] Code: 00 00 00 44 89 d0 41 b9 08 00 00 00 83 c8 10 f6 87
> d0 00 00 00 01 8b bf cc 00 00 00 44 0f 45 d0 45 31 c0 b8 aa 01 00 00 0f
> 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 41 83 e2 02 74 c2 f0 48 83 0c 24
> [   37.645251] RSP: 002b:00007bcc47dfafd8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000001aa
> [   37.646213] RAX: ffffffffffffffda RBX: 00007bcc400039d0 RCX:
> 00007bcc58f45b95
> [   37.647117] RDX: 0000000000000000 RSI: 0000000000000003 RDI:
> 0000000000000033
> [   37.648018] RBP: 00007bcc400039d8 R08: 0000000000000000 R09:
> 0000000000000008
> [   37.648916] R10: 0000000000000000 R11: 0000000000000246 R12:
> 00007bcc40003ac0
> [   37.649824] R13: 0000000000000000 R14: 0000591ad05f5c68 R15:
> 0000591b10198450
> [   37.650760]  </TASK>
> [   37.651034] ---[ end trace 0000000000000000 ]---
> 
