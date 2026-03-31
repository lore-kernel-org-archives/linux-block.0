Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755AA2DC792
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986536; cv=none; b=q/XeTjBWM03jgpNct6ZSRDKNYYDp3dtVTZcYITsugCALIU5xe0UZwO4+VG+GrDsjZcTuoh/hlKrndZOoNonBV0Ls93mmHt4sRIb6/oar8z8gcDRQFCpkbZAToXwYh0WBPG6n+zf/2ugFRcKwaMj7drjdsOpu1WshF31mQAtd++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986536; c=relaxed/simple;
	bh=6AZT03RZSGa2oeRI14tqhM0/gsyWP2Q8/qcrQFdAcjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLpSS5ZqLH16tqDqwv/3WQOQan58hVDp3xPhfX8ZoKe5YNrr/AFc9A5fhHnEjaM6s0jpWYJzPrs1y0qSac+UsDBCufmVoNCXknIA6L9FslRfN1SCfT9cduiLVXcO4Y1yKQ6BWC+gy1gS5bampFJlbAqHKd4HiRDCRO+0ttn4VaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+/tNUhJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+/tNUhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491CDC19423;
	Tue, 31 Mar 2026 19:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774986536;
	bh=6AZT03RZSGa2oeRI14tqhM0/gsyWP2Q8/qcrQFdAcjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d+/tNUhJ2Tqm8HpO5GJBULrH1b7Xj1B2YpPLZ3BVF9gTJRFGPq9pEdRqjSjj9Vun4
	 DyyGin18pTn/LokGij+A8KzBUQb6pQDhWMmv/tsxCjd1c3Zns0thdn21ln6Sqn/CSL
	 QMlkGJ0+hzgZpIxLB66T3tEmLXb14dKnU1j/lLgUeWekZN7DUxx8gn8e9tNh3u3sqg
	 yRSri1XXqXZq/gE25xT1WoI/clbw2YMZTfKM9KCxFnlpNh/ZmpQryZGs7uHxXbT9i7
	 fNNcf0DLOMC43U2N3ziZFeClhzTfioN0YtqnD5EvyBLxhBlzjJSpSLwIFQK4DW/i6w
	 sOyx4z1tykDfA==
Message-ID: <ff5e2877-840b-4eb6-b449-bb64fb2e4097@kernel.org>
Date: Wed, 1 Apr 2026 04:48:53 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
To: Mira Limbeck <m.limbeck@proxmox.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
 martin.petersen@oracle.com, Friedrich Weber <f.weber@proxmox.com>
References: <20250618060045.37593-1-dlemoal@kernel.org>
 <291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 21:02, Mira Limbeck wrote:
> Hi,
> 
> 
> Some of our Proxmox VE users started seeing `unable to handle page
> fault` after switching to our downstream kernel 6.17, and after
> bisecting with the mainline kernel we've identified this patch as the
> first commit (9b8b84879d4adc506b0d3944e20b28d9f3f6994b) where we see
> those errors.

Please test with the current mainline kernel. We do not deal with non-standard
kernels.

> It requires a certain combination of hardware though, so far we've seen
> this with a combination of:
> Broadcom/LSI HBAs with NVMe support (9400, 9500)
> KIOXIA KCD8 NVMes
> 
> The Hardware of our test machine consists of:
> 
> 81:00.0 Serial Attached SCSI controller [0107]: Broadcom / LSI
> Fusion-MPT 12GSAS/PCIe Secure SAS38xx [1000:00e6]
> 	Subsystem: Broadcom / LSI 9500-16i Tri-Mode HBA [1000:4050]
> 	Kernel driver in use: mpt3sas
> 	Kernel modules: mpt3sas
> 
> FW Package Ver(37.00.00.00)
> SAS3816: FWVersion(37.00.00.00), ChipRevision(0x00)
> 
> and
> 
> Mar 31 10:52:44 pve-test-hba kernel: scsi 16:2:0:0: Direct-Access
> NVMe     KIOXIA KCD8XRUG7 0105 PQ: 0 ANSI: 6
> 
> The 4 NVMes are exposed as SCSI devices via the Broadcom controller.
> 
> ```
> Mar 27 15:03:11 pve-test-hba kernel: sd 3:2:2:0: [sdc] tag#2463 page boundary curr_buff: 0x000000002ce04d26
> Mar 27 15:03:11 pve-test-hba kernel: BUG: unable to handle page fault for address: ff76b049c31fe000
> Mar 27 15:03:11 pve-test-hba kernel: #PF: supervisor write access in kernel mode
> Mar 27 15:03:11 pve-test-hba kernel: #PF: error_code(0x0002) - not-present page
> Mar 27 15:03:11 pve-test-hba kernel: PGD 100010067 P4D 1008c7067 PUD 1008c8067 PMD 11cd9f067 PTE 0
> Mar 27 15:03:11 pve-test-hba kernel: Oops: Oops: 0002 [#1] SMP NOPTI
> Mar 27 15:03:11 pve-test-hba kernel: CPU: 7 UID: 0 PID: 4385 Comm: dmcrypt_write/2 Tainted: G E 6.16.0-rc4-step14-00001-g9b8b84879d4a #16 PREEMPT(voluntary)
> Mar 27 15:03:11 pve-test-hba kernel: Tainted: [E]=UNSIGNED_MODULE
> Mar 27 15:03:11 pve-test-hba kernel: Hardware name: <snip>
> Mar 27 15:03:11 pve-test-hba kernel: RIP: 0010:_base_build_sg_scmd_ieee+0x478/0x590 [mpt3sas]
> Mar 27 15:03:11 pve-test-hba kernel: Code: 20 48 83 c3 20 48 89 d1 48 83 e1 fc 83 e2 01 48 0f 45 d9 4c 8b 73 10 44 8b 63 18 4c 89 e9 4c 8d 69 08 44 85 e8 74 31 45 29 d7 <4c> 89 31 49 83 c1 08 41 83 c0 01 45 29 d4 45 85 ff 7f af 4c 8b 75
> Mar 27 15:03:11 pve-test-hba kernel: RSP: 0018:ff76b049c170b8a8 EFLAGS: 00010206
> Mar 27 15:03:11 pve-test-hba kernel: RAX: 0000000000000fff RBX: ff220bd05e8a0270 RCX: ff76b049c31fe000
> Mar 27 15:03:11 pve-test-hba kernel: RDX: ff76b049c31fe008 RSI: 0000000000000000 RDI: 0000000000000000
> Mar 27 15:03:11 pve-test-hba kernel: RBP: ff76b049c170b908 R08: 0000000000000200 R09: 00000000ff161000
> Mar 27 15:03:11 pve-test-hba kernel: R10: 0000000000001000 R11: 0000000000001000 R12: 00000000001a0000
> Mar 27 15:03:11 pve-test-hba kernel: R13: ff76b049c31fe008 R14: 00000000f9600000 R15: 000000000019f000
> Mar 27 15:03:11 pve-test-hba kernel: FS: 0000000000000000(0000) GS:ff220bd3d1ee7000(0000) knlGS:0000000000000000
> Mar 27 15:03:11 pve-test-hba kernel: CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Mar 27 15:03:11 pve-test-hba kernel: CR2: ff76b049c31fe000 CR3: 0000000109f8c007 CR4: 0000000000f71ef0
> Mar 27 15:03:11 pve-test-hba kernel: PKRU: 55555554
> Mar 27 15:03:11 pve-test-hba kernel: Call Trace:
> Mar 27 15:03:11 pve-test-hba kernel: <TASK>
> Mar 27 15:03:11 pve-test-hba kernel: scsih_qcmd+0x37c/0x620 [mpt3sas]
> Mar 27 15:03:11 pve-test-hba kernel: scsi_queue_rq+0x3ec/0xd30
> Mar 27 15:03:11 pve-test-hba kernel: blk_mq_dispatch_rq_list+0x118/0x740
> Mar 27 15:03:11 pve-test-hba kernel: ? sbitmap_get+0x73/0x180
> Mar 27 15:03:11 pve-test-hba kernel: ? sbitmap_get+0x73/0x180
> Mar 27 15:03:11 pve-test-hba kernel: __blk_mq_sched_dispatch_requests+0x3fc/0x5b0
> Mar 27 15:03:11 pve-test-hba kernel: ? elv_attempt_insert_merge+0xa6/0x100
> Mar 27 15:03:11 pve-test-hba kernel: blk_mq_sched_dispatch_requests+0x2d/0x70
> Mar 27 15:03:11 pve-test-hba kernel: blk_mq_run_hw_queue+0x250/0x340
> Mar 27 15:03:11 pve-test-hba kernel: blk_mq_dispatch_list+0x16c/0x450
> Mar 27 15:03:11 pve-test-hba kernel: blk_mq_flush_plug_list+0x62/0x1e0
> Mar 27 15:03:11 pve-test-hba kernel: blk_add_rq_to_plug+0xff/0x1f0
> Mar 27 15:03:11 pve-test-hba kernel: blk_mq_submit_bio+0x616/0x7e0
> Mar 27 15:03:11 pve-test-hba kernel: __submit_bio+0x74/0x290
> Mar 27 15:03:11 pve-test-hba kernel: submit_bio_noacct_nocheck+0x1a2/0x3b0
> Mar 27 15:03:11 pve-test-hba kernel: submit_bio_noacct+0x1a0/0x5b0
> Mar 27 15:03:11 pve-test-hba kernel: dm_submit_bio_remap+0x49/0xb0
> Mar 27 15:03:11 pve-test-hba kernel: dmcrypt_write+0x120/0x150 [dm_crypt]
> Mar 27 15:03:11 pve-test-hba kernel: ? __pfx_dmcrypt_write+0x10/0x10 [dm_crypt]
> Mar 27 15:03:11 pve-test-hba kernel: kthread+0x10a/0x230
> Mar 27 15:03:11 pve-test-hba kernel: ? __pfx_kthread+0x10/0x10
> Mar 27 15:03:11 pve-test-hba kernel: ret_from_fork+0x1d1/0x200
> Mar 27 15:03:11 pve-test-hba kernel: ? __pfx_kthread+0x10/0x10
> Mar 27 15:03:11 pve-test-hba kernel: ret_from_fork_asm+0x1a/0x30
> Mar 27 15:03:11 pve-test-hba kernel: </TASK>
> Mar 27 15:03:11 pve-test-hba kernel: Modules linked in: dm_crypt(E) ebtable_filter(E) ebtables(E) ip_set(E) ip6table_raw(E) ip6table_filter(E) ip6_tables(E) iptable_filter(E) nf_tables(E) sunrpc(E) iptable_raw(E) xt_CT(E) iptable_nat(E) xt>
> Mar 27 15:03:11 pve-test-hba kernel: blake2b_generic(E) xor(E) raid6_pq(E) dm_thin_pool(E) dm_persistent_data(E) dm_bio_prison(E) dm_bufio(E) hid_generic(E) usbmouse(E) rndis_host(E) usbhid(E) cdc_ether(E) hid(E) usbnet(E) mii(E) xhci_pci>
> Mar 27 15:03:11 pve-test-hba kernel: CR2: ff76b049c31fe000
> Mar 27 15:03:11 pve-test-hba kernel: ---[ end trace 0000000000000000 ]---
> Mar 27 15:03:11 pve-test-hba kernel: RIP: 0010:_base_build_sg_scmd_ieee+0x478/0x590 [mpt3sas]
> Mar 27 15:03:11 pve-test-hba kernel: Code: 20 48 83 c3 20 48 89 d1 48 83 e1 fc 83 e2 01 48 0f 45 d9 4c 8b 73 10 44 8b 63 18 4c 89 e9 4c 8d 69 08 44 85 e8 74 31 45 29 d7 <4c> 89 31 49 83 c1 08 41 83 c0 01 45 29 d4 45 85 ff 7f af 4c 8b 75
> Mar 27 15:03:11 pve-test-hba kernel: RSP: 0018:ff76b049c170b8a8 EFLAGS: 00010206
> Mar 27 15:03:11 pve-test-hba kernel: RAX: 0000000000000fff RBX: ff220bd05e8a0270 RCX: ff76b049c31fe000
> Mar 27 15:03:11 pve-test-hba kernel: RDX: ff76b049c31fe008 RSI: 0000000000000000 RDI: 0000000000000000
> Mar 27 15:03:11 pve-test-hba kernel: RBP: ff76b049c170b908 R08: 0000000000000200 R09: 00000000ff161000
> Mar 27 15:03:11 pve-test-hba kernel: R10: 0000000000001000 R11: 0000000000001000 R12: 00000000001a0000
> Mar 27 15:03:11 pve-test-hba kernel: R13: ff76b049c31fe008 R14: 00000000f9600000 R15: 000000000019f000
> Mar 27 15:03:11 pve-test-hba kernel: FS: 0000000000000000(0000) GS:ff220bd3d1ee7000(0000) knlGS:0000000000000000
> Mar 27 15:03:11 pve-test-hba kernel: CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Mar 27 15:03:11 pve-test-hba kernel: CR2: ff76b049c31fe000 CR3: 0000000109f8c007 CR4: 0000000000f71ef0
> Mar 27 15:03:11 pve-test-hba kernel: PKRU: 55555554
> Mar 27 15:03:11 pve-test-hba kernel: note: dmcrypt_write/2[4385] exited with irqs disabled
> Mar 27 15:03:11 pve-test-hba kernel: ------------[ cut here ]------------
> Mar 27 15:03:11 pve-test-hba kernel: WARNING: CPU: 7 PID: 4385 at kernel/exit.c:902 do_exit+0x7d3/0xa30
> Mar 27 15:03:11 pve-test-hba kernel: Modules linked in: dm_crypt(E) ebtable_filter(E) ebtables(E) ip_set(E) ip6table_raw(E) ip6table_filter(E) ip6_tables(E) iptable_filter(E) nf_tables(E) sunrpc(E) iptable_raw(E) xt_CT(E) iptable_nat(E) xt>
> Mar 27 15:03:11 pve-test-hba kernel: blake2b_generic(E) xor(E) raid6_pq(E) dm_thin_pool(E) dm_persistent_data(E) dm_bio_prison(E) dm_bufio(E) hid_generic(E) usbmouse(E) rndis_host(E) usbhid(E) cdc_ether(E) hid(E) usbnet(E) mii(E) xhci_pci>
> Mar 27 15:03:11 pve-test-hba kernel: CPU: 7 UID: 0 PID: 4385 Comm: dmcrypt_write/2 Tainted: G D E 6.16.0-rc4-step14-00001-g9b8b84879d4a #16 PREEMPT(voluntary)
> Mar 27 15:03:11 pve-test-hba kernel: Tainted: [D]=DIE, [E]=UNSIGNED_MODULE
> Mar 27 15:03:11 pve-test-hba kernel: Hardware name: <snip>
> Mar 27 15:03:11 pve-test-hba kernel: RIP: 0010:do_exit+0x7d3/0xa30
> Mar 27 15:03:11 pve-test-hba kernel: Code: 48 89 45 c0 48 8b 83 50 0d 00 00 e9 44 fe ff ff 48 8b bb 10 0b 00 00 31 f6 e8 69 e2 ff ff e9 f7 fd ff ff 0f 0b e9 6b f8 ff ff <0f> 0b e9 72 f8 ff ff 4c 89 e6 bf 05 06 00 00 e8 49 46 01 00 e9 ab
> Mar 27 15:03:11 pve-test-hba kernel: RSP: 0018:ff76b049c170bec0 EFLAGS: 00010282
> Mar 27 15:03:11 pve-test-hba kernel: RAX: 0000000000000246 RBX: ff220bd04a4e0000 RCX: 0000000000000000
> Mar 27 15:03:11 pve-test-hba kernel: RDX: 000000000000270f RSI: 0000000000002710 RDI: 0000000000000009
> Mar 27 15:03:11 pve-test-hba kernel: RBP: ff76b049c170bf10 R08: 0000000000000000 R09: 0000000000000000
> Mar 27 15:03:11 pve-test-hba kernel: R10: 0000000000001000 R11: 0000000000001000 R12: 00000000001a0000
> Mar 27 15:03:11 pve-test-hba kernel: R13: ff76b049c31fe008 R14: 00000000f9600000 R15: 000000000019f000
> Mar 27 15:03:11 pve-test-hba kernel: FS: 0000000000000000(0000) GS:ff220bd3d1ee7000(0000) knlGS:0000000000000000
> Mar 27 15:03:11 pve-test-hba kernel: CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Mar 27 15:03:11 pve-test-hba kernel: CR2: ff76b049c31fe000 CR3: 0000000109f8c007 CR4: 0000000000f71ef0
> Mar 27 15:03:11 pve-test-hba kernel: PKRU: 55555554
> Mar 27 15:03:11 pve-test-hba kernel: note: dmcrypt_write/2[4385] exited with irqs disabled
> Mar 27 15:03:11 pve-test-hba kernel: ------------[ cut here ]------------
> Mar 27 15:03:11 pve-test-hba kernel: WARNING: CPU: 7 PID: 4385 at kernel/exit.c:902 do_exit+0x7d3/0xa30
> Mar 27 15:03:11 pve-test-hba kernel: Modules linked in: dm_crypt(E) ebtable_filter(E) ebtables(E) ip_set(E) ip6table_raw(E) ip6table_filter(E) ip6_tables(E) iptable_filter(E) nf_tables(E) sunrpc(E) iptable_raw(E) xt_CT(E) iptable_nat(E) xt>
> Mar 27 15:03:11 pve-test-hba kernel: blake2b_generic(E) xor(E) raid6_pq(E) dm_thin_pool(E) dm_persistent_data(E) dm_bio_prison(E) dm_bufio(E) hid_generic(E) usbmouse(E) rndis_host(E) usbhid(E) cdc_ether(E) hid(E) usbnet(E) mii(E) xhci_pci>
> Mar 27 15:03:11 pve-test-hba kernel: CPU: 7 UID: 0 PID: 4385 Comm: dmcrypt_write/2 Tainted: G D E 6.16.0-rc4-step14-00001-g9b8b84879d4a #16 PREEMPT(voluntary)
> Mar 27 15:03:11 pve-test-hba kernel: Tainted: [D]=DIE, [E]=UNSIGNED_MODULE
> Mar 27 15:03:11 pve-test-hba kernel: Hardware name: <snip>
> Mar 27 15:03:11 pve-test-hba kernel: RIP: 0010:do_exit+0x7d3/0xa30
> Mar 27 15:03:11 pve-test-hba kernel: Code: 48 89 45 c0 48 8b 83 50 0d 00 00 e9 44 fe ff ff 48 8b bb 10 0b 00 00 31 f6 e8 69 e2 ff ff e9 f7 fd ff ff 0f 0b e9 6b f8 ff ff <0f> 0b e9 72 f8 ff ff 4c 89 e6 bf 05 06 00 00 e8 49 46 01 00 e9 ab
> Mar 27 15:03:11 pve-test-hba kernel: RSP: 0018:ff76b049c170bec0 EFLAGS: 00010282
> Mar 27 15:03:11 pve-test-hba kernel: RAX: 0000000000000246 RBX: ff220bd04a4e0000 RCX: 0000000000000000
> Mar 27 15:03:11 pve-test-hba kernel: RDX: 000000000000270f RSI: 0000000000002710 RDI: 0000000000000009
> Mar 27 15:03:11 pve-test-hba kernel: RBP: ff76b049c170bf10 R08: 0000000000000000 R09: 0000000000000000
> Mar 27 15:03:11 pve-test-hba kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000009
> Mar 27 15:03:11 pve-test-hba kernel: R13: ff220bd04a4e0000 R14: ff220bd04a4e0000 R15: 0000000000000000
> Mar 27 15:03:11 pve-test-hba kernel: FS: 0000000000000000(0000) GS:ff220bd3d1ee7000(0000) knlGS:0000000000000000
> Mar 27 15:03:11 pve-test-hba kernel: CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Mar 27 15:03:11 pve-test-hba kernel: CR2: ff76b049c31fe000 CR3: 0000000109f8c007 CR4: 0000000000f71ef0
> Mar 27 15:03:11 pve-test-hba kernel: PKRU: 55555554
> Mar 27 15:03:11 pve-test-hba kernel: Call Trace:
> Mar 27 15:03:11 pve-test-hba kernel: <TASK>
> Mar 27 15:03:11 pve-test-hba kernel: make_task_dead+0x81/0x160
> Mar 27 15:03:11 pve-test-hba kernel: rewind_stack_and_make_dead+0x16/0x20
> Mar 27 15:03:11 pve-test-hba kernel: </TASK>
> Mar 27 15:03:11 pve-test-hba kernel: ---[ end trace 0000000000000000 ]---
> ```
> 
> Please note that the kernel used here was the last build during
> bisecting, having this patch as the last commit.
> The stack trace looks similar in all tested (bad) versions.
> We've also tested 7.0-rc5, which also triggered the issue.
> 
> The easiest way we found to trigger this was to create a Ceph OSD on the
> disks. When they were started on boot, the error was triggered.
> 
> So far we are not sure if it's the Broadcom controller, or the disk that
> is causing it in the end.
> 
> Since we saw the quirks added for certain devices [0][1], we also tried
> changing the sector size on an unaffected kernel to 8191, 8192 and
> 16384, but could not trigger the issue.
> 
> Any ideas what could be the cause for this, or how to troubleshoot this
> further?
> 
> Happy to provide any further information if needed.
> 
> 
> Thanks,
> Mira
> 
> [0]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2e983271363108b3813b38754eb96d9b1cb252bb
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5f64ae1ef639a2bab7e39497c55f76cc0682f108
> 


-- 
Damien Le Moal
Western Digital Research
