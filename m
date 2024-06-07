Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAF25740;
	Fri,  7 Jun 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773246; cv=none; b=bOv55nVA581nw0Bvgt5V8smXHKJgYAiIX1iNets/kFX34L1VKSRhkWICDNTpwSQiFnUK/Q727i23NayOHjAfYYwpUQEq6CCUYcARONjhbUyEl+f3VmMubZMDCqsqkuki85IHnblyUYc4lKBWrfEHUrI+LmXoPmMBeEKiScdUsC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773246; c=relaxed/simple;
	bh=3SBFZdCxCl9ZWNICMfALjLuGQg+Bq8WnPptWm0mqbFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnIS11x7En2bpH2TmsDi9jyxaWmDGooIIUsQsoIh908QjInbbG6KIEQ63z9VUGvxCKDSV/qi8+kRcA+9/jB8dd5gGNaOCBtblbbMtRu1EmwziW21dPqoaFyoFDfOXcPRVXmm1zDPJ1uq2DlWP8yYhQWLi5z31wDf0cJDyuNLO2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1AE2E44FBA;
	Fri,  7 Jun 2024 17:14:00 +0200 (CEST)
Message-ID: <20666c8d-3515-4864-9a00-3594621cd1ca@proxmox.com>
Date: Fri, 7 Jun 2024 17:13:58 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix request.queuelist usage in flush
To: Chengming Zhou <chengming.zhou@linux.dev>, axboe@kernel.dk,
 ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com, Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20240604064745.808610-1-chengming.zhou@linux.dev>
 <c9d03ff7-27c5-4ebd-b3f6-5a90d96f35ba@proxmox.com>
 <1344640f-b22d-4791-aed4-68fc62fb6e36@linux.dev>
 <ec27da86-b84a-430b-98aa-9971f90c8c87@proxmox.com>
 <7193e02e-7347-48db-b1a0-67b44730480b@proxmox.com>
 <448721f2-8e0b-4c5a-9764-bde65a5ee981@linux.dev>
 <343166f4-ac11-4f0e-ad13-6dc14dbf573d@proxmox.com>
 <dea87c0a-1c36-4737-bea5-cb7fa273b724@linux.dev>
Content-Language: en-US
From: Friedrich Weber <f.weber@proxmox.com>
In-Reply-To: <dea87c0a-1c36-4737-bea5-cb7fa273b724@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/06/2024 04:37, Chengming Zhou wrote:
> On 2024/6/6 16:44, Friedrich Weber wrote:
>> [...]
>>
>> I used mainline kernel v6.10-rc2 as base and applied:
>>
>> - "block: fix request.queuelist usage in flush"
>> - Your `list_del_init` addition from above
>>
>> and if I boot the Debian machine into this kernel, I do not get the
>> crash anymore.
> 
> Good to hear. So can I merge these two diffs into one patch and add
> your Tested-by?

I applied your merged patch [1] on top of mainline v6.10-rc2 (c3f38fa61a):

- I cannot reproduce the crash from [0] anymore in the (virtual) machine
with root (on LVM) on software RAID1

- I cannot reproduce the `blk_mq_requeue_work` crash from this thread
anymore in the Debian VM with root on LVM. With cache=writeback for the
VM disk, I get the expected in-guest WARNING [2] on VM boot.

- No crashes on bare-metal either. If write caching is enabled, I get
the expected WARNING.

So this looks good to me:

Tested-by: Friedrich Weber <f.weber@proxmox.com>

We might backport the merged patch (minus the WARN, possibly) to our
downstream Proxmox VE kernel 6.9 to fix the software RAID crash [0] --
if I understand correctly, the merged patch should be safe for now until
dm is fixed.

Thanks a lot for your work on this!

Best,

Friedrich

[0]
https://lore.kernel.org/all/14b89dfb-505c-49f7-aebb-01c54451db40@proxmox.com/

[1]

diff --git a/block/blk-flush.c b/block/blk-flush.c
index c17cf8ed8113..3d72393a1710 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -185,7 +185,7 @@ static void blk_flush_complete_seq(struct request *rq,
 		/* queue for flush */
 		if (list_empty(pending))
 			fq->flush_pending_since = jiffies;
-		list_move_tail(&rq->queuelist, pending);
+               list_add_tail(&rq->queuelist, pending);
 		break;

 	case REQ_FSEQ_DATA:
@@ -263,6 +263,7 @@ static enum rq_end_io_ret flush_end_io(struct
request *flush_rq,
 		unsigned int seq = blk_flush_cur_seq(rq);

 		BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);
+               list_del_init(&rq->queuelist);
 		blk_flush_complete_seq(rq, fq, seq, error);
 	}

@@ -402,6 +403,12 @@ bool blk_insert_flush(struct request *rq)
 	unsigned int policy = blk_flush_policy(fflags, rq);
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, rq->mq_ctx);

+       /*
+        * PREFLUSH | POSTFLUSH is a weird invalid format,
+        * need to fix in the upper layer, catch it here.
+        */
+       WARN_ON_ONCE(policy == (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH));
+
 	/* FLUSH/FUA request must never be merged */
 	WARN_ON_ONCE(rq->bio != rq->biotail);

[2]

[    2.142204] ------------[ cut here ]------------
[    2.142206] WARNING: CPU: 0 PID: 179 at block/blk-flush.c:410
blk_insert_flush+0xff/0x270
[    2.142211] Modules linked in: efi_pstore(E) dmi_sysfs(E)
qemu_fw_cfg(E) ip_tables(E) x_tables(E) autofs4(E) hid_generic(E)
usbhid(E) hid(E) psmouse(E) bochs(E) drm_vram_helper(E)
drm_ttm_helper(E) ahci(E) ttm(E) i2c_piix4(E) uhci_hcd(E) ehci_hcd(E)
libahci(E) pata_acpi(E) floppy(E)
[    2.142225] CPU: 0 PID: 179 Comm: jbd2/dm-0-8 Tainted: G            E
     6.10.0-rc2-nohardened-patch0607+ #41
[    2.142226] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    2.142227] RIP: 0010:blk_insert_flush+0xff/0x270
[    2.142229] Code: cc cc cc cc a9 00 00 04 00 74 3d 44 89 e2 83 ca 01
4d 85 c0 75 69 a9 00 00 02 00 0f 84 15 01 00 00 45 85 e4 0f 85 59 01 00
00 <0f> 0b 48 39 ce 0f 85 44 01 00 00 25 ff ff f9 ff 41 bc 05 00 00 00
[    2.142230] RSP: 0018:ffffa608c0303a30 EFLAGS: 00010246
[    2.142231] RAX: 0000000000069801 RBX: ffff93b70dc89600 RCX:
ffff93b70dd7baf8
[    2.142233] RDX: 0000000000000001 RSI: ffff93b70dd7baf8 RDI:
ffff93b70d545e00
[    2.142233] RBP: ffffa608c0303a48 R08: 0000000000000000 R09:
0000000000000000
[    2.142234] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000000000
[    2.142235] R13: ffff93b70d127980 R14: 0000000000000000 R15:
ffff93b70dc89600
[    2.142236] FS:  0000000000000000(0000) GS:ffff93b837c00000(0000)
knlGS:0000000000000000
[    2.142237] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.142238] CR2: 00005d28ed347fb8 CR3: 000000010d62e000 CR4:
00000000000006f0
[    2.142240] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[    2.142240] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[    2.142241] Call Trace:
[    2.142244]  <TASK>
[    2.142248]  ? show_regs+0x6c/0x80
[    2.142251]  ? __warn+0x88/0x140
[    2.142253]  ? blk_insert_flush+0xff/0x270
[    2.142254]  ? report_bug+0x182/0x1b0
[    2.142256]  ? handle_bug+0x46/0x90
[    2.142258]  ? exc_invalid_op+0x18/0x80
[    2.142259]  ? asm_exc_invalid_op+0x1b/0x20
[    2.142261]  ? blk_insert_flush+0xff/0x270
[    2.142262]  blk_mq_submit_bio+0x5c9/0x740
[    2.142265]  __submit_bio+0x6e/0x250
[    2.142267]  submit_bio_noacct_nocheck+0x1a3/0x3c0
[    2.142269]  submit_bio_noacct+0x1dc/0x650
[    2.142271]  submit_bio+0xb1/0x110
[    2.142272]  submit_bh_wbc+0x163/0x1a0
[    2.142274]  submit_bh+0x12/0x20
[    2.142275]  journal_submit_commit_record+0x1c5/0x250
[    2.142278]  jbd2_journal_commit_transaction+0x120d/0x1960
[    2.142281]  ? __schedule+0x408/0x15d0
[    2.142284]  kjournald2+0xaa/0x280
[    2.142285]  ? __pfx_autoremove_wake_function+0x10/0x10
[    2.142288]  ? __pfx_kjournald2+0x10/0x10
[    2.142289]  kthread+0xe4/0x110
[    2.142291]  ? __pfx_kthread+0x10/0x10
[    2.142292]  ret_from_fork+0x47/0x70
[    2.142294]  ? __pfx_kthread+0x10/0x10
[    2.142295]  ret_from_fork_asm+0x1a/0x30
[    2.142298]  </TASK>
[    2.142298] ---[ end trace 0000000000000000 ]---

