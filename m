Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
To: Jens Axboe <axboe@fb.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Subject: nvmf regression with mq-deadline
Message-ID: <8384a5c8-c8e6-4e46-65d6-208b802f6957@grimberg.me>
Date: Mon, 27 Feb 2017 15:00:44 +0200
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Hey Jens,

I'm getting a regression in nvme-rdma/nvme-loop with for-linus [1]
with a small script to trigger it.

The reason seems to be that the sched_tags does not take into account
the tag_set reserved tags.

This solves it for me, any objections on this?
--
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 98c7b061781e..46ca965fff5c 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -454,7 +454,8 @@ int blk_mq_sched_setup(struct request_queue *q)
          */
         ret = 0;
         queue_for_each_hw_ctx(q, hctx, i) {
-               hctx->sched_tags = blk_mq_alloc_rq_map(set, i, 
q->nr_requests, 0);
+               hctx->sched_tags = blk_mq_alloc_rq_map(set, i,
+                               q->nr_requests, set->reserved_tags);
                 if (!hctx->sched_tags) {
                         ret = -ENOMEM;
                         break;
--

[1]:
--
[   94.819701] ------------[ cut here ]------------
[   94.821639] WARNING: CPU: 0 PID: 729 at block/blk-mq-tag.c:114 
blk_mq_get_tag+0x21e/0x260
[   94.825201] Modules linked in: nvme_loop nvme_fabrics nvme_core 
nvmet_rdma nvmet rdma_cm iw_cm null_blk mlx5_ib iscsi_target_mod ib_srpt 
ib_cm ib_core tcm_loop tcm_fc libfc tcm_qla2xxx qla2xxx 
scsi_transport_fc usb_f_tcm tcm_usb_gadget libcomposite udc_core 
vhost_scsi vhost target_core_file target_core_iblock target_core_pscsi 
target_core_mod configfs ppdev kvm_intel kvm irqbypass crct10dif_pclmul 
crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd 
glue_helper cryptd input_leds joydev serio_raw parport_pc i2c_piix4 
parport mac_hid sunrpc autofs4 8139too cirrus ttm psmouse drm_kms_helper 
syscopyarea floppy sysfillrect mlx5_core ptp pps_core sysimgblt 
fb_sys_fops 8139cp drm mii pata_acpi
[   94.849215] CPU: 0 PID: 729 Comm: bash Not tainted 4.10.0+ #114
[   94.850761] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   94.853183] Call Trace:
[   94.853183]  dump_stack+0x63/0x90
[   94.853183]  __warn+0xcb/0xf0
[   94.853183]  warn_slowpath_null+0x1d/0x20
[   94.853183]  blk_mq_get_tag+0x21e/0x260
[   94.853183]  ? wake_atomic_t_function+0x60/0x60
[   94.853183]  __blk_mq_alloc_request+0x1b/0xc0
[   94.853183]  blk_mq_sched_get_request+0x1d4/0x290
[   94.853183]  blk_mq_alloc_request+0x63/0xb0
[   94.853183]  nvme_alloc_request+0x53/0x60 [nvme_core]
[   94.853183]  __nvme_submit_sync_cmd+0x31/0xd0 [nvme_core]
[   94.853183]  nvmf_connect_admin_queue+0x11d/0x180 [nvme_fabrics]
[   94.853183]  ? blk_mq_init_allocated_queue+0x472/0x4a0
[   94.853183]  nvme_loop_configure_admin_queue+0xf5/0x1c0 [nvme_loop]
[   94.853183]  nvme_loop_create_ctrl+0x13c/0x550 [nvme_loop]
[   94.853183]  ? nvmf_dev_write+0x50c/0x8de [nvme_fabrics]
[   94.853183]  nvmf_dev_write+0x75a/0x8de [nvme_fabrics]
[   94.853183]  __vfs_write+0x28/0x140
[   94.853183]  ? apparmor_file_permission+0x1a/0x20
[   94.853183]  ? security_file_permission+0x3b/0xc0
[   94.853183]  ? rw_verify_area+0x4e/0xb0
[   94.853183]  vfs_write+0xb8/0x1b0
[   94.853183]  SyS_write+0x46/0xa0
[   94.853183]  ? __close_fd+0x96/0xc0
[   94.853183]  entry_SYSCALL_64_fastpath+0x1e/0xad
[   94.853183] RIP: 0033:0x7f7be3e74a10
[   94.853183] RSP: 002b:00007ffca6ac59c8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[   94.853183] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007f7be3e74a10
[   94.853183] RDX: 000000000000001c RSI: 0000000001b90808 RDI: 
0000000000000001
[   94.853183] RBP: 0000000000000001 R08: 00007f7be4143780 R09: 
00007f7be478b700
[   94.853183] R10: 000000000000001b R11: 0000000000000246 R12: 
0000000000000000
[   94.853183] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[   94.875340] ---[ end trace b820e053982d7057 ]---
--

[2]:
--
#!/bin/bash

CFGFS=/sys/kernel/config/nvmet
NQN=test

modprobe nvme_loop

mkdir $CFGFS/ports/1
echo "loop" >  $CFGFS/ports/1/addr_trtype

mkdir $CFGFS/subsystems/$NQN
echo 1 > $CFGFS/subsystems/$NQN/attr_allow_any_host
ln -s $CFGFS/subsystems/$NQN $CFGFS/ports/1/subsystems/

echo "transport=loop,nqn=test" > /dev/nvme-fabrics
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
