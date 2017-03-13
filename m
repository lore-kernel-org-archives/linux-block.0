Subject: Re: NULL deref in cpu hot unplug on jens for-linus branch
To: Sagi Grimberg <sagi@grimberg.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>
References: <a4e0cb7c-c779-b681-e66c-2159c5f2b09f@grimberg.me>
From: Jens Axboe <axboe@fb.com>
Message-ID: <54f833f1-ab98-5d22-e7d4-5e6059a4c467@fb.com>
Date: Mon, 13 Mar 2017 09:42:09 -0600
MIME-Version: 1.0
In-Reply-To: <a4e0cb7c-c779-b681-e66c-2159c5f2b09f@grimberg.me>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 03/13/2017 09:24 AM, Sagi Grimberg wrote:
> Hey Jens,
> 
> After some fixes to nvme-rdma in the area of cpu hot unplug and
> rebase to jens for-linus branch I get the following NULL deref [1]
> 
> This crash did not happen before I rebased to for-linus (unless I
> screwed up something).
> 
> I'm on my way out so I just send it out in hope that someone can
> figure it out before I do...
> 
> After I offlined a cpu, I got the nvmf target to disconnect
> from the host, the host then schedules a reconnect. after the
> host reconnects it issues a namespace scanning which removes
> an old namespace. Then we get to blk_cleanup_queue which
> then triggers the NULL deref.
> 
> The strange thing is that we pass the
>   (blk_mq_hw_queue_mapped(hctx)) condition but still hit a NULL...
> 
> [1]
> --
> [   55.865818] BUG: unable to handle kernel NULL pointer dereference at 
> 0000000000000008
> [   55.867094] IP: __blk_mq_tag_idle+0x19/0x30
> [   55.867825] PGD 0
> 
> [   55.868477] Oops: 0002 [#1] SMP
> [   55.869010] Modules linked in: nvme_rdma nvme_fabrics nvme_core 
> mlx5_ib ppdev kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul 
> ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd glue_helper 
> cryptd joydev input_leds serio_raw i2c_piix4 parport_pc parport mac_hid 
> ib_iser rdma_cm iw_cm ib_cm ib_core configfs iscsi_tcp libiscsi_tcp 
> libiscsi sunrpc scsi_transport_iscsi autofs4 cirrus ttm drm_kms_helper 
> syscopyarea sysfillrect sysimgblt mlx5_core fb_sys_fops ptp psmouse drm 
> floppy pps_core pata_acpi
> [   55.876358] CPU: 0 PID: 21 Comm: kworker/0:1 Not tainted 4.11.0-rc1+ #136
> [   55.877492] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
> BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> [   55.879055] Workqueue: events nvme_scan_work [nvme_core]
> [   55.879940] task: ffffa0b13e1d9080 task.stack: ffffad2000244000
> [   55.880921] RIP: 0010:__blk_mq_tag_idle+0x19/0x30
> [   55.881713] RSP: 0018:ffffad2000247c70 EFLAGS: 00010203
> [   55.882582] RAX: 0000000000000000 RBX: ffffa0b13376f400 RCX: 
> ffffa0b13fc11d00
> [   55.883808] RDX: 0000000000000001 RSI: ffffa0b13376f400 RDI: 
> ffffa0b13376f400
> [   55.884983] RBP: ffffad2000247c70 R08: 0000000000000000 R09: 
> ffffffffbee42e20
> [   55.886168] R10: ffffad2000247b88 R11: 0000000000000008 R12: 
> ffffa0b1384c6018
> [   55.887343] R13: 0000000000000001 R14: 0000000000000080 R15: 
> 0000000000000000
> [   55.888517] FS:  0000000000000000(0000) GS:ffffa0b13fc00000(0000) 
> knlGS:0000000000000000
> [   55.889816] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   55.890738] CR2: 0000000000000008 CR3: 000000003ba2f000 CR4: 
> 00000000003406f0
> [   55.891878] Call Trace:
> [   55.892285]  blk_mq_exit_hctx.isra.41+0xc4/0xd0
> [   55.893020]  blk_mq_free_queue+0x110/0x130
> [   55.893693]  blk_cleanup_queue+0xe0/0x150
> [   55.894346]  nvme_ns_remove+0x78/0xd0 [nvme_core]
> [   55.895109]  nvme_validate_ns+0x8c/0x290 [nvme_core]
> [   55.895911]  ? nvme_scan_work+0x28a/0x370 [nvme_core]
> [   55.896726]  nvme_scan_work+0x2ad/0x370 [nvme_core]
> [   55.897523]  process_one_work+0x16b/0x480
> [   55.898174]  worker_thread+0x4b/0x500
> [   55.898771]  kthread+0x101/0x140
> [   55.899299]  ? process_one_work+0x480/0x480
> [   55.899977]  ? kthread_create_on_node+0x40/0x40
> [   55.900711]  ? start_kernel+0x3bc/0x461
> [   55.901336]  ? acpi_early_init+0x83/0xf9
> [   55.901980]  ? acpi_load_tables+0x31/0x85
> [   55.902632]  ret_from_fork+0x2c/0x40
> [   55.903215] Code: 74 09 48 8d 7b 48 e8 67 4b 06 00 5b 41 5c 5d c3 66 
> 90 0f 1f 44 00 00 48 8b 87 08 01 00 00 f0 0f ba 77 18 01 72 01 c3 55 48 
> 89 e5 <f0> ff 48 08 48 8d 78 10 e8 3a 4b 06 00 5d c3 0f 1f 84 00 00 00
> [   55.906220] RIP: __blk_mq_tag_idle+0x19/0x30 RSP: ffffad2000247c70
> [   55.907209] CR2: 0000000000000008
> [   55.907750] ---[ end trace f016dee1082237cf ]---

Are you saying your code works on top of 4.11-rc2, but not on top of my
for-linus? That seems odd. Looking at the oops, you are crashing with
!tags in __blk_mq_tag_idle. The below should work around it, but I'm
puzzled why this is new. Is it related to the other path you fixed in
this patch:

commit 0067d4b020ea07a58540acb2c5fcd3364bf326e0
Author: Sagi Grimberg <sagi@grimberg.me>
Date:   Mon Mar 13 16:10:11 2017 +0200

    blk-mq: Fix tagset reinit in the presence of cpu hot-unplug

Since that's also handling hctx->tags == NULL.


diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9d97bfc4d465..1283f74bfdfb 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -54,9 +54,11 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	if (!test_and_clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 		return;
 
-	atomic_dec(&tags->active_queues);
+	if (tags) {
+		atomic_dec(&tags->active_queues);
 
-	blk_mq_tag_wakeup_all(tags, false);
+		blk_mq_tag_wakeup_all(tags, false);
+	}
 }
 
 /*

-- 
Jens Axboe
