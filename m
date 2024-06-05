Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB96188CAE;
	Wed,  5 Jun 2024 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594456; cv=none; b=H4Om4aA9GVVy/krAyUPpgu/3JL3UxYQS8G65hONmgaVk/RIxQHVurnDgjt2z0sFpp/QUA9tZbvYGbNJfbNAxYk/pwGGGBAW7BG/yQGJPFxDlHHskA5nppSFm7EZyyzqQVtK65eHOi5ZFK46dvwJhi7sN0qQy0YaUf09W4RYUEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594456; c=relaxed/simple;
	bh=wcM2fAuyzQ5hM36kqJPb9ESRd0kNe9AWMS/HI49oAb0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DnF9TNs2drff8GanZOzPQJf8HC6eQ2hVA9hhVQIWK/L2+ejvIl/ANTRDbLCSphz+3UoBAZUnrRh3RXwBGiqWvnA7XuHdeQBiu7u4koOgEWnAzMAy8eQpNun50rbwZ7bSuocndEigQ2mxT83RC/mzFE+HUW2Zbi9PytkGoQHG3G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id AC79144E42;
	Wed,  5 Jun 2024 15:34:03 +0200 (CEST)
Message-ID: <7193e02e-7347-48db-b1a0-67b44730480b@proxmox.com>
Date: Wed, 5 Jun 2024 15:34:02 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix request.queuelist usage in flush
From: Friedrich Weber <f.weber@proxmox.com>
To: Chengming Zhou <chengming.zhou@linux.dev>, axboe@kernel.dk,
 ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com, Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20240604064745.808610-1-chengming.zhou@linux.dev>
 <c9d03ff7-27c5-4ebd-b3f6-5a90d96f35ba@proxmox.com>
 <1344640f-b22d-4791-aed4-68fc62fb6e36@linux.dev>
 <ec27da86-b84a-430b-98aa-9971f90c8c87@proxmox.com>
Content-Language: en-US
In-Reply-To: <ec27da86-b84a-430b-98aa-9971f90c8c87@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/06/2024 12:54, Friedrich Weber wrote:
> On 05/06/2024 12:30, Chengming Zhou wrote:
>> On 2024/6/5 16:45, Friedrich Weber wrote:
>>> [...]
>>> Unfortunately, with this patch applied to kernel 6.9 I get a different
>>> crash [2] on a Debian 12 (virtual) machine with root on LVM on boot (no
>>> software RAID involved). See [1] for lsblk and findmnt output. addr2line
>>> says:
>>
>> Sorry, which commit is your kernel? Is mainline tag v6.9 or at some commit?
> 
> Yes, by "kernel 6.9" I meant mainline tag v6.9, so commit a38297e3fb01.
> 
> If I boot this mainline kernel v6.9 in a Debian (virtual) machine with
> root on LVM, I do not get a crash. If I apply the patch "block: fix
> request.queuelist usage in flush" on top of this mainline kernel v6.9,
> and boot the Debian machine into that patched kernel, I get a crash on boot.
> 
>> And is it reproducible using the mainline kernel v6.10-rc2?
> 
> I'll test mainline kernel v6.10-rc2, and "block: fix request.queuelist
> usage in flush" applied on top of v6.10-rc2, and get back to you.

My results:

Booting the Debian (virtual) machine with mainline kernel v6.10-rc2
(c3f38fa61af77b49866b006939479069cd451173):
works fine, no crash

Booting the Debian (virtual) machine with patch "block: fix
request.queuelist usage in flush" applied on top of v6.10-rc2: The
Debian (virtual) machine crashes during boot with [1].

Hope this helps! If I can provide anything else, just let me know.

Best wishes,

Friedrich

[1]

[    1.091562] BUG: kernel NULL pointer dereference, address:
0000000000000000
[    1.092097] #PF: supervisor write access in kernel mode
[    1.092469] #PF: error_code(0x0002) - not-present page
[    1.092880] PGD 0 P4D 0
[    1.093064] Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
[    1.093193] systemd[1]: Finished systemd-sysusers.service - Create
System Users.
[    1.093422] CPU: 1 PID: 130 Comm: kworker/1:1H Tainted: G
E      6.10.0-rc2-patch0604-6-10rc2+ #37
[    1.095178] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    1.096005] Workqueue: kblockd blk_mq_requeue_work
[    1.096342] RIP: 0010:_raw_spin_lock+0x13/0x60
[    1.096707] Code: 31 db c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 0f 1f 44 00 00 65 ff 05 3c 42 4a 6f 31 c0 ba 01 00 00
00 <f0> 0f b1 17 75 1b 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9
[    1.098021] RSP: 0000:ffffb5ebc0343d78 EFLAGS: 00010246
[    1.098381] RAX: 0000000000000000 RBX: ffff9326c8c8c800 RCX:
00000000ffffffe0
[    1.098917] RDX: 0000000000000001 RSI: 0000000000000001 RDI:
0000000000000000
[    1.099409] RBP: ffffb5ebc0343d98 R08: 0000000000000000 R09:
0000000000000000
[    1.099944] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000000000
[    1.100440] R13: 0000000000000001 R14: ffff9327f7cc2180 R15:
ffff9326c8c91894
[    1.100969] FS:  0000000000000000(0000) GS:ffff9327f7c80000(0000)
knlGS:0000000000000000
[    1.101526] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.101950] CR2: 0000000000000000 CR3: 0000000100eaa005 CR4:
0000000000370ef0
[    1.102443] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[    1.102951] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[    1.103447] Call Trace:
[    1.103626]  <TASK>
[    1.103805]  ? show_regs+0x6c/0x80
[    1.104053]  ? __die+0x24/0x80
[    1.104055]  ? page_fault_oops+0x175/0x5e0
[    1.104059]  ? do_user_addr_fault+0x325/0x690
[    1.104062]  ? exc_page_fault+0x82/0x1b0
[    1.105390]  ? asm_exc_page_fault+0x27/0x30
[    1.105716]  ? _raw_spin_lock+0x13/0x60
[    1.106033]  ? blk_mq_request_bypass_insert+0x20/0xe0
[    1.106385]  blk_mq_insert_request+0x120/0x1e0
[    1.106704]  blk_mq_requeue_work+0x18f/0x230
[    1.107033]  process_one_work+0x196/0x3e0
[    1.107316]  worker_thread+0x32a/0x500
[    1.107587]  ? __pfx_worker_thread+0x10/0x10
[    1.107915]  kthread+0xe1/0x110
[    1.108140]  ? __pfx_kthread+0x10/0x10
[    1.108409]  ret_from_fork+0x44/0x70
[    1.108662]  ? __pfx_kthread+0x10/0x10
[    1.108952]  ret_from_fork_asm+0x1a/0x30
[    1.109228]  </TASK>
[    1.109386] Modules linked in: efi_pstore(E) dmi_sysfs(E)
qemu_fw_cfg(E) ip_tables(E) x_tables(E) autofs4(E) crc32_pclmul(E)
bochs(E) drm_vram_helper(E) drm_ttm_helper(E) psmouse(E) uhci_hcd(E)
ttm(E) ehci_hcd(E) i2c_piix4(E) pata_acpi(E) floppy(E)
[    1.110910] CR2: 0000000000000000
[    1.111161] ---[ end trace 0000000000000000 ]---
[    1.111489] RIP: 0010:_raw_spin_lock+0x13/0x60
[    1.111802] Code: 31 db c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 0f 1f 44 00 00 65 ff 05 3c 42 4a 6f 31 c0 ba 01 00 00
00 <f0> 0f b1 17 75 1b 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9
[    1.113119] RSP: 0000:ffffb5ebc0343d78 EFLAGS: 00010246
[    1.113489] RAX: 0000000000000000 RBX: ffff9326c8c8c800 RCX:
00000000ffffffe0
[    1.114001] RDX: 0000000000000001 RSI: 0000000000000001 RDI:
0000000000000000
[    1.114497] RBP: ffffb5ebc0343d98 R08: 0000000000000000 R09:
0000000000000000
[    1.114998] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000000000
[    1.115508] R13: 0000000000000001 R14: ffff9327f7cc2180 R15:
ffff9326c8c91894
[    1.115997] FS:  0000000000000000(0000) GS:ffff9327f7c80000(0000)
knlGS:0000000000000000
[    1.116578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.116975] CR2: 0000000000000000 CR3: 0000000100eaa005 CR4:
0000000000370ef0
[    1.117494] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[    1.117982] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[    1.118526] note: kworker/1:1H[130] exited with irqs disabled
[    1.118947] note: kworker/1:1H[130] exited with preempt_count 1


