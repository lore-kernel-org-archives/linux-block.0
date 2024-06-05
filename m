Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26121755A
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717597646; cv=none; b=RL6eFzFLN8bzGUHZbhJursHXdXZwqCVHgj2/xFJpiDsegXxaopG9c0avy+hPrikQqZpFoI1EhS2Jwx++vsYRexUDYMg2ixJOxNRG/HQK0wJmFQAUF19SfLg0JSsjvKughrkGq/KANU9OC9c4n5ARP4SIdz9sQrysAddg1hGmAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717597646; c=relaxed/simple;
	bh=90D3auDK3WcXsX7TKCAyKV0KwfqmFAGuEW7dW1JYvLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q18Sfn5eBcVF9fjvWaQIOxe696rZm/X5Of0xUxSfyJfSsk1uUzgjL7mVUWtd6/GPyXZQBrlZwtDvCMvep4bJMthJw5Xma3njsgsB2aKZoxXIoKAdj92R66QPw0k2/LbNia4Ecae4+q6bGMKNje++jarO9qkcVKojYBs3FIT0zps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pU+/3saq; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pU+/3saq"
X-Envelope-To: f.weber@proxmox.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717597641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ko9Xb067+XeTJSQmpXx37lrgx0pHjdOn4v8/Lptp5VY=;
	b=pU+/3saq4RCm9zXTUWkf4REijLOh+B5BxW/WNYA3tFRUdAZeILcrVm9MLVdPbmaaQpOaJM
	wvBvkqHTy2uJu8DwSBimt2R2F5zorTmR8bN3gcg4snTK/dHvtiaJi8vUx5ZBy5RhMH4ESf
	9WCTcSF9Sbry94Y/2WJIrAw8EORDK+g=
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: ming.lei@redhat.com
X-Envelope-To: hch@lst.de
X-Envelope-To: bvanassche@acm.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: t.lamprecht@proxmox.com
Message-ID: <448721f2-8e0b-4c5a-9764-bde65a5ee981@linux.dev>
Date: Wed, 5 Jun 2024 22:27:11 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] block: fix request.queuelist usage in flush
Content-Language: en-US
To: Friedrich Weber <f.weber@proxmox.com>, axboe@kernel.dk,
 ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com, Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20240604064745.808610-1-chengming.zhou@linux.dev>
 <c9d03ff7-27c5-4ebd-b3f6-5a90d96f35ba@proxmox.com>
 <1344640f-b22d-4791-aed4-68fc62fb6e36@linux.dev>
 <ec27da86-b84a-430b-98aa-9971f90c8c87@proxmox.com>
 <7193e02e-7347-48db-b1a0-67b44730480b@proxmox.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <7193e02e-7347-48db-b1a0-67b44730480b@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/5 21:34, Friedrich Weber wrote:
> On 05/06/2024 12:54, Friedrich Weber wrote:
>> On 05/06/2024 12:30, Chengming Zhou wrote:
>>> On 2024/6/5 16:45, Friedrich Weber wrote:
>>>> [...]
>>>> Unfortunately, with this patch applied to kernel 6.9 I get a different
>>>> crash [2] on a Debian 12 (virtual) machine with root on LVM on boot (no
>>>> software RAID involved). See [1] for lsblk and findmnt output. addr2line
>>>> says:
>>>
>>> Sorry, which commit is your kernel? Is mainline tag v6.9 or at some commit?
>>
>> Yes, by "kernel 6.9" I meant mainline tag v6.9, so commit a38297e3fb01.
>>
>> If I boot this mainline kernel v6.9 in a Debian (virtual) machine with
>> root on LVM, I do not get a crash. If I apply the patch "block: fix
>> request.queuelist usage in flush" on top of this mainline kernel v6.9,
>> and boot the Debian machine into that patched kernel, I get a crash on boot.
>>
>>> And is it reproducible using the mainline kernel v6.10-rc2?
>>
>> I'll test mainline kernel v6.10-rc2, and "block: fix request.queuelist
>> usage in flush" applied on top of v6.10-rc2, and get back to you.
> 
> My results:
> 
> Booting the Debian (virtual) machine with mainline kernel v6.10-rc2
> (c3f38fa61af77b49866b006939479069cd451173):
> works fine, no crash
> 
> Booting the Debian (virtual) machine with patch "block: fix
> request.queuelist usage in flush" applied on top of v6.10-rc2: The
> Debian (virtual) machine crashes during boot with [1].
> 
> Hope this helps! If I can provide anything else, just let me know.

Thanks for your help, I still can't reproduce it myself, don't know why.

Could you help to test with this diff?

diff --git a/block/blk-flush.c b/block/blk-flush.c
index e7aebcf00714..cca4f9131f79 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -263,6 +263,7 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
                unsigned int seq = blk_flush_cur_seq(rq);

                BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);
+               list_del_init(&rq->queuelist);
                blk_flush_complete_seq(rq, fq, seq, error);
        }


I don't know if the request can have PREFLUSH and POSTFLUSH set but no DATA,
maybe in some special cases? Hope someone can give me some hints BTW.

The panic below seems something very bad happened, hctx(maybe ctx)->lock got
from the request is NULL.

Thanks!

> 
> Best wishes,
> 
> Friedrich
> 
> [1]
> 
> [    1.091562] BUG: kernel NULL pointer dereference, address:
> 0000000000000000
> [    1.092097] #PF: supervisor write access in kernel mode
> [    1.092469] #PF: error_code(0x0002) - not-present page
> [    1.092880] PGD 0 P4D 0
> [    1.093064] Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
> [    1.093193] systemd[1]: Finished systemd-sysusers.service - Create
> System Users.
> [    1.093422] CPU: 1 PID: 130 Comm: kworker/1:1H Tainted: G
> E      6.10.0-rc2-patch0604-6-10rc2+ #37
> [    1.095178] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [    1.096005] Workqueue: kblockd blk_mq_requeue_work
> [    1.096342] RIP: 0010:_raw_spin_lock+0x13/0x60
> [    1.096707] Code: 31 db c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90
> 90 90 90 90 90 90 0f 1f 44 00 00 65 ff 05 3c 42 4a 6f 31 c0 ba 01 00 00
> 00 <f0> 0f b1 17 75 1b 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9
> [    1.098021] RSP: 0000:ffffb5ebc0343d78 EFLAGS: 00010246
> [    1.098381] RAX: 0000000000000000 RBX: ffff9326c8c8c800 RCX:
> 00000000ffffffe0
> [    1.098917] RDX: 0000000000000001 RSI: 0000000000000001 RDI:
> 0000000000000000
> [    1.099409] RBP: ffffb5ebc0343d98 R08: 0000000000000000 R09:
> 0000000000000000
> [    1.099944] R10: 0000000000000000 R11: 0000000000000000 R12:
> 0000000000000000
> [    1.100440] R13: 0000000000000001 R14: ffff9327f7cc2180 R15:
> ffff9326c8c91894
> [    1.100969] FS:  0000000000000000(0000) GS:ffff9327f7c80000(0000)
> knlGS:0000000000000000
> [    1.101526] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.101950] CR2: 0000000000000000 CR3: 0000000100eaa005 CR4:
> 0000000000370ef0
> [    1.102443] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [    1.102951] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [    1.103447] Call Trace:
> [    1.103626]  <TASK>
> [    1.103805]  ? show_regs+0x6c/0x80
> [    1.104053]  ? __die+0x24/0x80
> [    1.104055]  ? page_fault_oops+0x175/0x5e0
> [    1.104059]  ? do_user_addr_fault+0x325/0x690
> [    1.104062]  ? exc_page_fault+0x82/0x1b0
> [    1.105390]  ? asm_exc_page_fault+0x27/0x30
> [    1.105716]  ? _raw_spin_lock+0x13/0x60
> [    1.106033]  ? blk_mq_request_bypass_insert+0x20/0xe0
> [    1.106385]  blk_mq_insert_request+0x120/0x1e0
> [    1.106704]  blk_mq_requeue_work+0x18f/0x230
> [    1.107033]  process_one_work+0x196/0x3e0
> [    1.107316]  worker_thread+0x32a/0x500
> [    1.107587]  ? __pfx_worker_thread+0x10/0x10
> [    1.107915]  kthread+0xe1/0x110
> [    1.108140]  ? __pfx_kthread+0x10/0x10
> [    1.108409]  ret_from_fork+0x44/0x70
> [    1.108662]  ? __pfx_kthread+0x10/0x10
> [    1.108952]  ret_from_fork_asm+0x1a/0x30
> [    1.109228]  </TASK>
> [    1.109386] Modules linked in: efi_pstore(E) dmi_sysfs(E)
> qemu_fw_cfg(E) ip_tables(E) x_tables(E) autofs4(E) crc32_pclmul(E)
> bochs(E) drm_vram_helper(E) drm_ttm_helper(E) psmouse(E) uhci_hcd(E)
> ttm(E) ehci_hcd(E) i2c_piix4(E) pata_acpi(E) floppy(E)
> [    1.110910] CR2: 0000000000000000
> [    1.111161] ---[ end trace 0000000000000000 ]---
> [    1.111489] RIP: 0010:_raw_spin_lock+0x13/0x60
> [    1.111802] Code: 31 db c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90
> 90 90 90 90 90 90 0f 1f 44 00 00 65 ff 05 3c 42 4a 6f 31 c0 ba 01 00 00
> 00 <f0> 0f b1 17 75 1b 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9
> [    1.113119] RSP: 0000:ffffb5ebc0343d78 EFLAGS: 00010246
> [    1.113489] RAX: 0000000000000000 RBX: ffff9326c8c8c800 RCX:
> 00000000ffffffe0
> [    1.114001] RDX: 0000000000000001 RSI: 0000000000000001 RDI:
> 0000000000000000
> [    1.114497] RBP: ffffb5ebc0343d98 R08: 0000000000000000 R09:
> 0000000000000000
> [    1.114998] R10: 0000000000000000 R11: 0000000000000000 R12:
> 0000000000000000
> [    1.115508] R13: 0000000000000001 R14: ffff9327f7cc2180 R15:
> ffff9326c8c91894
> [    1.115997] FS:  0000000000000000(0000) GS:ffff9327f7c80000(0000)
> knlGS:0000000000000000
> [    1.116578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.116975] CR2: 0000000000000000 CR3: 0000000100eaa005 CR4:
> 0000000000370ef0
> [    1.117494] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [    1.117982] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [    1.118526] note: kworker/1:1H[130] exited with irqs disabled
> [    1.118947] note: kworker/1:1H[130] exited with preempt_count 1
> 
> 
