Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB241DD894
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779353; cv=none; b=RqssMmIuvNtxkTcKDqmJXaj7gu2VXJAIM3wFoRW2ro5QgXNv+J8key8IFqD9o+c5MDDCAlw/U3HPGe2U+xPPS6bVG1xPl/HHLIUx8Xp5squ3ZoFngeOW6PzlifguQ3v8NNOBI59PI+qPrNvdbO08OOWnxLVFraxbSBRp+q7nMHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779353; c=relaxed/simple;
	bh=0CwawsYdGJ38lylhUYJ+s09TTUHWO7/OLef7+FEbnFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDKWOccR8PxFn7efT/xhaluQl2NjD1kN4PZnhHnFUHqRQs7mJzp/WqSJJtcivM7SWNZjMQFapLYi1Z7YEWjuarbnLITBBDy0O6znP77qSKVlQA8iSPgSxQEdcouVk9kCDdCbdx6i9FrmpbEutYx+BNliUS4eul8tppk2H0kWsWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43998deed24so24778645e9.2
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 13:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740779349; x=1741384149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GbrE6sb4UeGDl7K5+otlVxZrEY3W+JDbV58Pfvw1l8=;
        b=T4JHDguMO9G6Oq88fWQLjj4x8EzFAjUlkyk9E9XTv3UF1eFeBpnDM2sLq2Unz2RX3b
         9XsD+7dG0WH8w4lH71qvPeAw2cQkcUXL3Yl1wcOoBPXz8V8ORKE9Fhaob+o3j4/P9rra
         QJM0PETafGPU9WbvYhjcN9ScQCtscwK8yRebuAqibOKy9irw20xVJfzZ397SeNhkVHhu
         4uvS6vbh+Auu1qkM5Bye7peH/aYUsUh3UsN9wisKl+WJd7BIgChez52IyvQ3XbxfHfYy
         +cKlMslYoB+K7nc18LMgJTppWVB4MF4JNYT1vU+hbPPhZjZpBR+iaOe4KJMpBoW2KkXV
         cp1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUULgmF2pJlTMIbBtcAhLK5gxRXBnGERHwpUmgvYjHFIuU1TBKpIiCjkFfbvQbh03gGMoDt10YBFcs2Gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdDUb4EDNHcokC4krv2rJDYDkPnJ0zdMvvSJuuETPsBbRBbEv8
	P+ViUJawGwUgxHtCVrzjLKCmMck2g+wIwvuI56bJpZsnbzzJQxT9zFWfrg==
X-Gm-Gg: ASbGnctShOglHBcVn+FbQBLiwoLjp4lVpRHGEM+nbpolHVchzb/T7rVCZ6MhsWd8NHn
	qYoQbIMzKpOYx1EGxh3tXvNCnXEwJBArlEimuUnvwIHXT5PlZAnFz0/Q5uJ/QQIcVeFUiE12Gr8
	ugkKSrbsn9QDADEdUyCvetFNPBwLQ2NmB435Xkl03hc38geXWRoOaSxGzd2zsveva9acAqVSIg9
	U/gGFCKP0B9E6jbaMh3P/rlihfqxvP32rQlFQGYqzjlfRjZuh7w/s1q79snc+9GbdpldDcCyC6Z
	rPHrEpeLkbfMVW/rtksB5cJE35kpBdVr1UmloqQ9ny/JWZWS7wdInvTODRt3FQ==
X-Google-Smtp-Source: AGHT+IEqheT8tvX0BSx6lvpC0hMCuL7UNjM5cgRO8mAaEEi6zSHY6DfI8zfPuwu/dSb+mK2GSFb4Cg==
X-Received: by 2002:a05:600c:3596:b0:439:84ba:5760 with SMTP id 5b1f17b1804b1-43ba66dff51mr45886135e9.5.1740779349061;
        Fri, 28 Feb 2025 13:49:09 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5393e5sm99506635e9.20.2025.02.28.13.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 13:49:08 -0800 (PST)
Message-ID: <eae340ca-0ed0-4e22-846d-ec438255f9db@grimberg.me>
Date: Fri, 28 Feb 2025 23:49:07 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
To: Hannes Reinecke <hare@suse.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28/02/2025 12:47, Hannes Reinecke wrote:
> Hi Sagi,
>
> enabling TLS on latest linus tree reliably crashes my system:
>
> [  487.018058] ------------[ cut here ]------------
> [  487.024046] WARNING: CPU: 9 PID: 6159 at mm/slub.c:4719 
> free_large_kmalloc+0x15/0xa0

Is this the warning on order == 0 ?
the admin connect data is a 4k buffe, I'm not sure why it would end up 
here...

> [ 487.033549] Modules linked in: tls(E) nvme_tcp(E) af_packet(E) 
> iscsi_ibft(E) iscsi_boot_sysfs(E) amd_atl(E) intel_rapl_msr(E) 
> intel_rapl_common(E) amd64_edac(E) edac_mce_amd(E) nls_iso8859_1(E) 
> nls_cp437(E) dax_hmem(E) vfat(E) cxl_acpi(E) fat(E) kvm_amd(E) 
> ipmi_ssif(E) cxl_port(E) xfs(E) tg3(E) cxl_core(E) ipmi_si(E) i40e(E) 
> kvm(E) einj(E) wmi_bmof(E) acpi_cpufreq(E) ipmi_devintf(E) libphy(E) 
> k10temp(E) libie(E) i2c_piix4(E) i2c_smbus(E) ipmi_msghandler(E) 
> i2c_designware_platform(E) i2c_designware_core(E) button(E) 
> nvme_fabrics(E) nvme_keyring(E) fuse(E) efi_pstore(E) configfs(E) 
> dmi_sysfs(E) ip_tables(E) x_tables(E) ahci(E) libahci(E) 
> ghash_clmulni_intel(E) libata(E) sha512_ssse3(E) sd_mod(E) 
> sha256_ssse3(E) ast(E) sha1_ssse3(E) drm_client_lib(E) scsi_dh_emc(E) 
> i2c_algo_bit(E) aesni_intel(E) drm_shmem_helper(E) scsi_dh_rdac(E) 
> crypto_simd(E) cryptd(E) xhci_pci(E) drm_kms_helper(E) scsi_dh_alua(E) 
> nvme(E) sg(E) xhci_hcd(E) nvme_core(E) scsi_mod(E) drm(E) nvme_auth(E) 
> scsi_common(E) usbcore(E) sp5100_tco(E) ccp(E)
> [  487.033696]  wmi(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) 
> efivarfs(E)
> [  487.033707] CPU: 9 UID: 0 PID: 6159 Comm: nvme Kdump: loaded 
> Tainted: G        W   E      6.14.0-rc4-default+ #292 
> f1e35f01b401c038558e67f3c2d644747de50dbd
> [  487.033713] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE
> [  487.033715] Hardware name: Lenovo ThinkSystem SR655V3/SB27B09914, 
> BIOS KAE111E-2.10 04/11/2023
> [  487.033717] RIP: 0010:free_large_kmalloc+0x15/0xa0
> [  487.033722] Code: 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 
> 90 90 90 90 90 0f 1f 44 00 00 55 53 48 89 fb 48 83 ec 08 48 8b 07 a8 
> 40 75 4b <0f> 0b 80 3d 24 4e 8e 01 00 ba 00 f0 ff ff 74 5d 9c 58 0f 1f 
> 40 00
> [  487.205280] RSP: 0018:ff4de44e432a7b70 EFLAGS: 00010246
> [  487.205284] RAX: 000fffffc0000000 RBX: ffd659b280210b80 RCX: 
> ff42118489e0cd80
> [  487.205286] RDX: 0000000000000000 RSI: ff4211848842e000 RDI: 
> ffd659b280210b80
> [  487.205288] RBP: ff4de44e432a7be0 R08: 0000000000000001 R09: 
> 0000000000000002
> [  487.205289] R10: ff4de44e432a7c00 R11: 0000000000000104 R12: 
> ffd659b280210b80
> [  487.205291] R13: ff4211848842e000 R14: ff421186d0696520 R15: 
> ff421186e19c4000
> [  487.205292] FS:  00007f66b8ffd800(0000) GS:ff4211874d980000(0000) 
> knlGS:0000000000000000
> [  487.205294] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  487.205296] CR2: 00007f66b9150d7e CR3: 0000000281a5e005 CR4: 
> 0000000000771ef0
> [  487.205298] PKRU: 55555554
> [  487.205306] Call Trace:
> [  487.205309]  <TASK>
> [  487.205314]  ? __warn+0x85/0x130
> [  487.296763]  ? free_large_kmalloc+0x15/0xa0
> [  487.296772]  ? report_bug+0xf8/0x1e0
> [  487.296779]  ? handle_bug+0x50/0xa0
> [  487.296783]  ? exc_invalid_op+0x13/0x60
> [  487.296786]  ? asm_exc_invalid_op+0x16/0x20
> [  487.296796]  ? free_large_kmalloc+0x15/0xa0
> [  487.296801]  kfree+0x234/0x320
> [  487.332065]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  487.332075]  ? nvmf_connect_admin_queue+0x105/0x1a0 [nvme_fabrics 
> 34d997d53c805aa2fae8e8baee6a736e8da38358]
> [  487.332081]  ? nvmf_connect_admin_queue+0xa1/0x1a0 [nvme_fabrics 
> 34d997d53c805aa2fae8e8baee6a736e8da38358]
> [  487.332084]  nvmf_connect_admin_queue+0x105/0x1a0 [nvme_fabrics 
> 34d997d53c805aa2fae8e8baee6a736e8da38358]
> [  487.332093]  nvme_tcp_start_queue+0x18f/0x310 [nvme_tcp 
> 68f6be106f52ac467179f8a0922f02aeb6fa1f1c]
> [  487.332102]  nvme_tcp_setup_ctrl+0xf8/0x700 [nvme_tcp 
> 68f6be106f52ac467179f8a0922f02aeb6fa1f1c]
> [  487.394479]  ? nvme_change_ctrl_state+0x99/0x1b0 [nvme_core 
> 22f0ce18ead628230226a9b87ebf48eb576bf299]
> [  487.394495]  nvme_tcp_create_ctrl+0x2e3/0x4d0 [nvme_tcp 
> 68f6be106f52ac467179f8a0922f02aeb6fa1f1c]
> [  487.394503]  nvmf_dev_write+0x323/0x3d0 [nvme_fabrics 
> 34d997d53c805aa2fae8e8baee6a736e8da38358]
> [  487.394508]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  487.394514]  vfs_write+0xd9/0x430
> [  487.394521]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  487.394523]  ? __handle_mm_fault+0x7da/0xca0
> [  487.394531]  ksys_write+0x68/0xe0
> [  487.394536]  do_syscall_64+0x74/0x160
> [  487.394543]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  487.394545]  ? __count_memcg_events+0x98/0x130
> [  487.394550]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  487.476947]  ? count_memcg_events.constprop.163+0x1a/0x30
> [  487.476956]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  487.476960]  ? handle_mm_fault+0xa1/0x290
> [  487.476966]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  487.476968]  ? do_user_addr_fault+0x56b/0x830
> [  487.476975]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  487.476977]  ? exc_page_fault+0x68/0x150
> [  487.476983]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  487.476989] RIP: 0033:0x7f66b91216f0
> [  487.476994] Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 
> 90 90 90 90 90 90 90 90 90 90 80 3d 19 c3 0e 00 00 74 17 b8 01 00 00 
> 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 
> 48 89
> [  487.551619] RSP: 002b:00007ffef5393ed8 EFLAGS: 00000202 ORIG_RAX: 
> 0000000000000001
> [  487.551623] RAX: ffffffffffffffda RBX: 000055e61c2113b0 RCX: 
> 00007f66b91216f0
> [  487.551625] RDX: 00000000000000ed RSI: 000055e61c2113b0 RDI: 
> 0000000000000003
> [  487.551627] RBP: 0000000000000003 R08: 00000000000000ed R09: 
> 000055e61c2113b0
> [  487.551628] R10: 0000000000000000 R11: 0000000000000202 R12: 
> 00000000000000ed
> [  487.551630] R13: 00007f66b9380008 R14: 000055e61c20a980 R15: 
> 000055e61c20b100
> [  487.551637]  </TASK>
> [  487.551639] ---[ end trace 0000000000000000 ]---
> [  487.551642] object pointer: 0x00000000346cb6fc
> [  487.554112] nvme nvme1: creating 32 I/O queues.
> [  489.396262] nvme nvme1: mapped 32/0/0 default/read/poll queues.
> [  489.405197] Oops: general protection fault, probably for 
> non-canonical address 0xdead000000000100: 0000 [#1] PREEMPT SMP NOPTI
> [  489.418790] CPU: 9 UID: 0 PID: 6159 Comm: nvme Kdump: loaded 
> Tainted: G        W   E      6.14.0-rc4-default+ #292 
> f1e35f01b401c038558e67f3c2d644747de50dbd
> [  489.435212] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE
> [  489.441381] Hardware name: Lenovo ThinkSystem SR655V3/SB27B09914, 
> BIOS KAE111E-2.10 04/11/2023
> [  489.451841] RIP: 0010:__rmqueue_pcplist+0xe1/0xc80
> [  489.458016] Code: 06 48 83 e8 08 48 89 44 24 70 48 8b 45 00 48 39 
> c5 0f 84 72 01 00 00 48 8b 55 00 48 8b 32 48 8b 4a 08 48 8d 42 f8 48 
> 89 4e 08 <48> 89 31 48 b9 00 01 00 00 00 00 ad de 48 89 0a 48 8b 4c 24 
> 20 48
> [  489.479905] RSP: 0018:ff4de44e432a7688 EFLAGS: 00010293
> [  489.486567] RAX: ffd659b280210a00 RBX: ff4211874d9bf400 RCX: 
> dead000000000100
> [  489.495370] RDX: ffd659b280210a08 RSI: ffd659b281ed7e08 RDI: 
> ff421184fffd60c0
> [  489.504174] RBP: ff4211874d9bf4b0 R08: ff4211874d9bf400 R09: 
> ff4211874d9bf4b0
> [  489.512976] R10: 0000000000002acd R11: 0000000000000002 R12: 
> 0000000000000003
> [  489.521779] R13: 0000000000000003 R14: 0000000000252800 R15: 
> ff421184fffd60c0
> [  489.530584] FS:  00007f66b8ffd800(0000) GS:ff4211874d980000(0000) 
> knlGS:0000000000000000
> [  489.540460] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  489.547700] CR2: 00007f66b9150d7e CR3: 0000000281a5e005 CR4: 
> 0000000000771ef0
> [  489.556502] PKRU: 55555554
> [  489.560337] Call Trace:
> [  489.563876]  <TASK>
> [  489.567022]  ? __die_body+0x1a/0x60
> [  489.571728]  ? die_addr+0x38/0x60
> [  489.576241]  ? exc_general_protection+0x19e/0x430
> [  489.582325]  ? asm_exc_general_protection+0x22/0x30
> [  489.588603]  ? __rmqueue_pcplist+0xe1/0xc80
> [  489.594092]  ? __rmqueue_pcplist+0x51b/0xc80
> [  489.599687]  get_page_from_freelist+0xe10/0x1680
> [  489.605675]  __alloc_frozen_pages_noprof+0x171/0x340
> [  489.612048]  new_slab+0x90/0x4d0
> [  489.616466]  ___slab_alloc+0x6f3/0xb20
> [  489.621469]  ? sbitmap_init_node+0x77/0x1a0
> [  489.626961]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  489.633134]  ? _get_random_bytes.part.18+0x90/0x120
> [  489.639409]  ? __slab_alloc.isra.98+0x22/0x40
> [  489.645101]  __slab_alloc.isra.98+0x22/0x40
> [  489.650597]  __kmalloc_node_noprof+0x218/0x510
> [  489.656380]  ? sbitmap_init_node+0x77/0x1a0
> [  489.661874]  ? sbitmap_init_node+0x77/0x1a0
> [  489.667362]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  489.673534]  sbitmap_init_node+0x77/0x1a0
> [  489.678830]  sbitmap_queue_init_node+0x24/0x150
> [  489.684709]  blk_mq_init_tags+0x7e/0x110
> [  489.689915]  blk_mq_alloc_map_and_rqs+0x44/0x320
> [  489.695898]  __blk_mq_alloc_map_and_rqs+0x3b/0x60
> [  489.701973]  blk_mq_alloc_tag_set+0x1f1/0x380
> [  489.707662]  nvme_alloc_io_tag_set+0xc2/0x1a0 [nvme_core 
> 22f0ce18ead628230226a9b87ebf48eb576bf299]
> [  489.718534]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  489.724707]  ? nvme_tcp_alloc_queue+0x293/0x7b0 [nvme_tcp 
> 68f6be106f52ac467179f8a0922f02aeb6fa1f1c]
> [  489.735676]  ? __pfx_nvme_tcp_tls_done+0x10/0x10 [nvme_tcp 
> 68f6be106f52ac467179f8a0922f02aeb6fa1f1c]
> [  489.746737]  nvme_tcp_setup_ctrl+0x3ee/0x700 [nvme_tcp 
> 68f6be106f52ac467179f8a0922f02aeb6fa1f1c]
> [  489.757401]  nvme_tcp_create_ctrl+0x2e3/0x4d0 [nvme_tcp 
> 68f6be106f52ac467179f8a0922f02aeb6fa1f1c]
> [  489.768165]  nvmf_dev_write+0x323/0x3d0 [nvme_fabrics 
> 34d997d53c805aa2fae8e8baee6a736e8da38358]
> [  489.778732]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  489.784906]  vfs_write+0xd9/0x430
> [  489.789422]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  489.795591]  ? __handle_mm_fault+0x7da/0xca0
> [  489.801183]  ksys_write+0x68/0xe0
> [  489.805700]  do_syscall_64+0x74/0x160
> [  489.810616]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  489.816794]  ? __count_memcg_events+0x98/0x130
> [  489.822580]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  489.828750]  ? count_memcg_events.constprop.163+0x1a/0x30
> [  489.835606]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  489.841777]  ? handle_mm_fault+0xa1/0x290
> [  489.847070]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  489.853241]  ? do_user_addr_fault+0x56b/0x830
> [  489.858928]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  489.865101]  ? exc_page_fault+0x68/0x150
> [  489.870302]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  489.876769] RIP: 0033:0x7f66b91216f0
> [  489.881573] Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 
> 90 90 90 90 90 90 90 90 90 90 80 3d 19 c3 0e 00 00 74 17 b8 01 00 00 
> 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 
> 48 89
> [  489.903462] RSP: 002b:00007ffef5393ed8 EFLAGS: 00000202 ORIG_RAX: 
> 0000000000000001
> [  489.912761] RAX: ffffffffffffffda RBX: 000055e61c2113b0 RCX: 
> 00007f66b91216f0
> [  489.921564] RDX: 00000000000000ed RSI: 000055e61c2113b0 RDI: 
> 0000000000000003
> [  489.930366] RBP: 0000000000000003 R08: 00000000000000ed R09: 
> 000055e61c2113b0
> [  489.939169] R10: 0000000000000000 R11: 0000000000000202 R12: 
> 00000000000000ed
> [  489.947970] R13: 00007f66b9380008 R14: 000055e61c20a980 R15: 
> 000055e61c20b100
> [  489.956783]  </TASK>
> [  489.960024] Modules linked in: tls(E) nvme_tcp(E) af_packet(E) 
> iscsi_ibft(E) iscsi_boot_sysfs(E) amd_atl(E) intel_rapl_msr(E) 
> intel_rapl_common(E) amd64_edac(E) edac_mce_amd(E) nls_iso8859_1(E) 
> nls_cp437(E) dax_hmem(E) vfat(E) cxl_acpi(E) fat(E) kvm_amd(E) 
> ipmi_ssif(E) cxl_port(E) xfs(E) tg3(E) cxl_core(E) ipmi_si(E) i40e(E) 
> kvm(E) einj(E) wmi_bmof(E) acpi_cpufreq(E) ipmi_devintf(E) libphy(E) 
> k10temp(E) libie(E) i2c_piix4(E) i2c_smbus(E) ipmi_msghandler(E) 
> i2c_designware_platform(E) i2c_designware_core(E) button(E) 
> nvme_fabrics(E) nvme_keyring(E) fuse(E) efi_pstore(E) configfs(E) 
> dmi_sysfs(E) ip_tables(E) x_tables(E) ahci(E) libahci(E) 
> ghash_clmulni_intel(E) libata(E) sha512_ssse3(E) sd_mod(E) 
> sha256_ssse3(E) ast(E) sha1_ssse3(E) drm_client_lib(E) scsi_dh_emc(E) 
> i2c_algo_bit(E) aesni_intel(E) drm_shmem_helper(E) scsi_dh_rdac(E) 
> crypto_simd(E) cryptd(E) xhci_pci(E) drm_kms_helper(E) scsi_dh_alua(E) 
> nvme(E) sg(E) xhci_hcd(E) nvme_core(E) scsi_mod(E) drm(E) nvme_auth(E) 
> scsi_common(E) usbcore(E) sp5100_tco(E) ccp(E)
> [  489.960207]  wmi(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) 
> efivarfs(E)
>
> Haven't found a culprit for that one for now, started bisecting.
> Just wanted to report that as a heads-up, maybe you have some idea.

I don't.
