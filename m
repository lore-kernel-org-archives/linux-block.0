Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Feb 2018 07:39:40 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Fix race between resetting the timer and
 completion handling
Message-ID: <20180208153940.GM695913@devbig577.frc2.facebook.com>
References: <20180207011133.25957-1-bart.vanassche@wdc.com>
 <20180207170612.GB695913@devbig577.frc2.facebook.com>
 <1518024428.2870.35.camel@wdc.com>
 <20180207173531.GC695913@devbig577.frc2.facebook.com>
 <1518027251.2870.53.camel@wdc.com>
 <20180207200724.GD695913@devbig577.frc2.facebook.com>
 <1518047297.2870.80.camel@wdc.com>
 <1518052193.2870.90.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518052193.2870.90.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Feb 08, 2018 at 01:09:57AM +0000, Bart Van Assche wrote:
> On Wed, 2018-02-07 at 23:48 +0000, Bart Van Assche wrote:
> > With this patch applied I see requests for which it seems like the timeout handler
> > did not get invoked: [ ... ]
> 
> I just noticed the following in the system log, which is probably the reason why some
> requests got stuck:
> 
> Feb  7 15:16:26 ubuntu-vm kernel: BUG: unable to handle kernel NULL pointer dereference at           (null)
> Feb  7 15:16:26 ubuntu-vm kernel: IP: scsi_times_out+0x17/0x2c0 [scsi_mod]
> Feb  7 15:16:26 ubuntu-vm kernel: PGD 0 P4D 0  
> Feb  7 15:16:26 ubuntu-vm kernel: Oops: 0000 [#1] PREEMPT SMP
> Feb  7 15:16:26 ubuntu-vm kernel: Modules linked in: dm_service_time ib_srp libcrc32c crc32c_generic scsi_transport_srp target_core_pscsi target_core_file ib_srpt target_core_iblock target_core_mod
> rdma_rxe ip6_udp_tunnel udp_tunnel ib_umad ib_uverbs scsi_debug brd mq_deadline kyber_iosched deadline_iosched cfq_iosched bfq crct10dif_pclmul crc32_pclmul af_packet ghash_clmulni_intel pcbc
> aesni_intel aes_x86_64 crypto_simd cryptd glue_helper serio_raw virtio_console virtio_balloon sg button i2c_piix4 dm_multipath dm_mod dax scsi_dh_rdac scsi_dh_emc scsi_dh_alua ib_iser rdma_cm iw_cm
> ib_cm ib_core configfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables x_tables ipv6 autofs4 ext4 crc16 mbcache jbd2 sd_mod virtio_net virtio_blk virtio_scsi sr_mod cdrom ata_generic
> pata_acpi psmouse crc32c_intel i2c_core atkbd
> Feb  7 15:16:26 ubuntu-vm kernel: uhci_hcd ehci_hcd intel_agp ata_piix intel_gtt agpgart libata virtio_pci usbcore virtio_ring virtio scsi_mod usb_common unix
> Feb  7 15:16:26 ubuntu-vm kernel: CPU: 0 PID: 146 Comm: kworker/0:1H Not tainted 4.15.0-dbg+ #1
> Feb  7 15:16:26 ubuntu-vm kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
> Feb  7 15:16:26 ubuntu-vm kernel: Workqueue: kblockd blk_mq_timeout_work
> Feb  7 15:16:26 ubuntu-vm kernel: RIP: 0010:scsi_times_out+0x17/0x2c0 [scsi_mod]
> Feb  7 15:16:26 ubuntu-vm kernel: RSP: 0018:ffff98f0c02abd58 EFLAGS: 00010246
> Feb  7 15:16:26 ubuntu-vm kernel: RAX: 0000000000000000 RBX: ffff965de2b3a2c0 RCX: 0000000000000000
> Feb  7 15:16:26 ubuntu-vm kernel: RDX: ffffffffc0094740 RSI: 0000000000000000 RDI: ffff965de2b3a2c0
> Feb  7 15:16:26 ubuntu-vm kernel: RBP: ffff965de2b3a438 R08: fffffffffffffffc R09: 0000000000000007
> Feb  7 15:16:26 ubuntu-vm kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
> Feb  7 15:16:26 ubuntu-vm kernel: R13: 0000000000000000 R14: ffff965de2a44218 R15: ffff965de2a48728
> Feb  7 15:16:26 ubuntu-vm kernel: FS:  0000000000000000(0000) GS:ffff965dffc00000(0000) knlGS:0000000000000000
> Feb  7 15:16:26 ubuntu-vm kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Feb  7 15:16:26 ubuntu-vm kernel: CR2: 0000000000000000 CR3: 000000003ce0f003 CR4: 00000000003606f0
> Feb  7 15:16:26 ubuntu-vm kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Feb  7 15:16:26 ubuntu-vm kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Feb  7 15:16:26 ubuntu-vm kernel: Call Trace:
> Feb  7 15:16:26 ubuntu-vm kernel: blk_mq_terminate_expired+0x42/0x80
> Feb  7 15:16:26 ubuntu-vm kernel: bt_iter+0x3d/0x50
> Feb  7 15:16:26 ubuntu-vm kernel: blk_mq_queue_tag_busy_iter+0xe9/0x200
> Feb  7 15:16:26 ubuntu-vm kernel: blk_mq_timeout_work+0x181/0x2e0
> Feb  7 15:16:26 ubuntu-vm kernel: process_one_work+0x21c/0x6d0
> Feb  7 15:16:26 ubuntu-vm kernel: worker_thread+0x35/0x380
> Feb  7 15:16:26 ubuntu-vm kernel: kthread+0x117/0x130
> Feb  7 15:16:26 ubuntu-vm kernel: ret_from_fork+0x24/0x30
> Feb  7 15:16:26 ubuntu-vm kernel: Code: ff ff 0f ff e9 fd fe ff ff 90 66 2e 0f 1f 84 00 00 00 00 00 41 55 41 54 55 48 8d af 78 01 00 00 53 48 8b 87 b0 01 00 00 48 89 fb <4c> 8b 28 0f 1f 44 00 00 65
> 8b 05 6a b5 f8 3f 83 f8 0f 0f 87 ed  
> Feb  7 15:16:26 ubuntu-vm kernel: RIP: scsi_times_out+0x17/0x2c0 [scsi_mod] RSP: ffff98f0c02abd58
> Feb  7 15:16:26 ubuntu-vm kernel: CR2: 0000000000000000
> Feb  7 15:16:26 ubuntu-vm kernel: ---[ end trace ce6c20d95bab450e ]---

So, that's dereferencing %rax which is NULL.  That gotta be the ->host
deref in the following.

  enum blk_eh_timer_return scsi_times_out(struct request *req)
  {
	  struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
	  enum blk_eh_timer_return rtn = BLK_EH_NOT_HANDLED;
	  struct Scsi_Host *host = scmd->device->host;
  ...

That sounds more like a scsi hotplug but than an issue in the timeout
code unless we messed up @req pointer to begin with.

Thanks.

-- 
tejun
