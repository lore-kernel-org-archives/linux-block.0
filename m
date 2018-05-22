Return-Path: <v.mayatskih@gmail.com>
MIME-Version: 1.0
From: Vitaly Mayatskih <v.mayatskih@gmail.com>
Date: Tue, 22 May 2018 10:29:13 -0400
Message-ID: <CAGF4SLg42Ni3gXAyVZOxZcaYVOBBS3qaTK9u=0NCAxPGwQLt-g@mail.gmail.com>
Subject: softirq->blk_mq_make_request deadlocks
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi,

I'm working on a new network block device and see occasional deadlocks
when trying to submit_bio from softirq (network rcv handler). This may
be a new use case for blk-mq, but I think context spinlock should be
really taken with bh disabled. I *seem* can avoid the deadlock if bio
has BIO_NOMERGE set, but I need to merge bios for better network
utilization (no merge costs about 15% of bandwidth). Did I miss
something, or the lock indeed needs no bh for that case (recursive
ctx->lock in softirq)?

Thanks!

[255304.467229] watchdog: BUG: soft lockup - CPU#2 stuck for 22s!
[kworker/2:1H:104086]
[255304.559710] Modules linked in: aoe_mq(OE) openvswitch
nf_conntrack_ipv6 nf_nat_ipv6 nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 nf_defrag_ipv6 nf_nat nf_conntrack libcrc32c zfs(POE)
zunicode(POE) zavl(PO) icp(POE) zcommon(POE) znvpair(POE) spl(OE)
intel_rapl skx_edac x86_pkg_temp_thermal intel_powerclamp coretemp
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc mgag200 ttm
drm_kms_helper snd_pcsp snd_pcm drm kvm_intel ipmi_ssif i2c_algo_bit
nvme snd_timer fb_sys_fops rdma_cm aesni_intel syscopyarea aes_x86_64
ipmi_si sysfillrect crypto_simd mei_me snd iw_cm sysimgblt glue_helper
fm10k(OE) cryptd nvme_core uio ahci ipmi_devintf kvm dcdbas soundcore
i2c_i801 lpc_ich libahci mei intel_rapl_perf shpchp ib_cm
ipmi_msghandler nfit tpm_crb mac_hid irqbypass acpi_pad
acpi_power_meter ib_core iscsi_tcp
[255304.559752]  libiscsi_tcp libiscsi scsi_transport_iscsi 8021q garp
mrp stp llc autofs4 [last unloaded: aoe_mq]
[255304.559759] CPU: 2 PID: 104086 Comm: kworker/2:1H Tainted: P
 W  OE   4.13.0-21-generic #24~16.04.1-Ubuntu
[255304.559760] Hardware name: Dell Inc. DCS 9660/0NM63C, BIOS 1.3.4 12/15/2017
[255304.559770] Workqueue: kblockd blk_mq_run_work_fn
[255304.559771] task: ffff8ebd51285ac0 task.stack: ffffb6459de68000
[255304.559777] RIP: 0010:native_queued_spin_lock_slowpath+0x17a/0x1a0
[255304.559778] RSP: 0018:ffff8ebe1f043a90 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff10
[255304.559780] RAX: 0000000000000101 RBX: ffffd62d3f853d40 RCX:
0000000000000001
[255304.559780] RDX: 0000000000000101 RSI: 0000000000000001 RDI:
ffffd62d3f853d40
[255304.559781] RBP: ffff8ebe1f043a90 R08: 0000000000000101 R09:
0000000000000008
[255304.559782] R10: ffff8ebe1f043be8 R11: ffff8ed1ebf18f00 R12:
ffff8ebdcbd2b180
[255304.559782] R13: ffff8ed1ebf18f00 R14: ffff8ebd8ce1adc0 R15:
ffff8ebb4c7f60b0
[255304.559783] FS:  0000000000000000(0000) GS:ffff8ebe1f040000(0000)
knlGS:0000000000000000
[255304.559784] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[255304.559785] CR2: 00007ffdb373efa8 CR3: 0000001bba809000 CR4:
00000000007406e0
[255304.559786] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[255304.559787] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[255304.559787] PKRU: 55555554
[255304.559788] Call Trace:
[255304.559789]  <IRQ>
[255304.559796]  _raw_spin_lock+0x20/0x30
[255304.559800]  __blk_mq_sched_bio_merge+0x9e/0x190
[255304.559802]  blk_mq_make_request+0x222/0x5e0
[255304.559808]  generic_make_request+0x125/0x300
[255304.559809]  submit_bio+0x73/0x150
[255304.559811]  ? submit_bio+0x73/0x150
[255304.559816]  aoe_mq_target_cmd_ata_rw+0x254/0x560 [aoe_mq]
[255304.559818]  aoe_mq_target_cmd_ata+0x46/0x90 [aoe_mq]
[255304.559820]  aoe_mq_network_recv+0x2d5/0x4a0 [aoe_mq]
[255304.559825]  __netif_receive_skb_core+0x522/0xaa0
[255304.559826]  __netif_receive_skb+0x18/0x60
[255304.559827]  ? __netif_receive_skb+0x18/0x60
[255304.559829]  netif_receive_skb_internal+0x3f/0x3f0
[255304.559832]  ? __build_skb+0x2a/0xe0
[255304.559833]  napi_gro_receive+0xcd/0xf0
[255304.559838]  fm10k_poll+0x71f/0xca0 [fm10k]
[255304.559839]  net_rx_action+0x248/0x380
[255304.559841]  ? fm10k_msix_clean_rings+0x36/0x40 [fm10k]
[255304.559844]  __do_softirq+0xed/0x278
[255304.559849]  irq_exit+0xb6/0xc0
[255304.559850]  do_IRQ+0x4f/0xd0
[255304.559852]  common_interrupt+0x89/0x89
[255304.559854] RIP: 0010:_raw_spin_lock+0x10/0x30
[255304.559854] RSP: 0018:ffffb6459de6bd58 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff38
[255304.559855] RAX: 0000000000000000 RBX: ffffd62d3f853d40 RCX:
0000000000000003
[255304.559856] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
ffffd62d3f853d40
[255304.559857] RBP: ffffb6459de6bd70 R08: 0000000000000000 R09:
0000000000000001
[255304.559857] R10: 0000000000000000 R11: 000000000000000e R12:
ffffb6459de6bd88
[255304.559858] R13: ffff8ebdc8dfd4d8 R14: ffff8ebdc5a6f000 R15:
ffff8ebdc8dfd400
[255304.559859]  </IRQ>
[255304.559862]  ? dequeue_entity+0xed/0x4b0
[255304.559864]  ? flush_busy_ctx+0x47/0x90
[255304.559865]  blk_mq_flush_busy_ctxs+0x84/0xe0
[255304.559866]  blk_mq_sched_dispatch_requests+0x18e/0x1d0
[255304.559868]  __blk_mq_run_hw_queue+0x8e/0xa0
[255304.559870]  blk_mq_run_work_fn+0x2c/0x30
[255304.559874]  process_one_work+0x156/0x410
[255304.559875]  worker_thread+0x4b/0x460
[255304.559877]  kthread+0x109/0x140
[255304.559878]  ? process_one_work+0x410/0x410
[255304.559879]  ? kthread_create_on_node+0x70/0x70
[255304.559880]  ? kthread_create_on_node+0x70/0x70
[255304.559881]  ret_from_fork+0x25/0x30
[255304.559882] Code: 41 39 c0 74 e6 4d 85 c9 c6 07 01 74 30 41 c7 41
08 01 00 00 00 e9 51 ff ff ff 83 fa 01 0f 84 af fe ff ff 8b 07 84 c0
74 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 5d c3 f3 90 4c
8b 09
 --
wbr, Vitaly
