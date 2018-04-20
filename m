Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:32812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754399AbeDTJ40 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Apr 2018 05:56:26 -0400
Date: Fri, 20 Apr 2018 11:56:24 +0200
From: Michael Moese <mmoese@suse.de>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: jthumshirn@suse.de
Subject: [BUG REPORT] WARNING at __blk_mq_complete_request+0x105/0x180
Message-ID: <20180420095624.4wirfmhobdi2aw7j@g206.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,
For kernel 4.16.1, I encountered a bug triggering a WARNING using the test code at:
https://github.com/ChaitanayaKulkarni/nvmftests/blob/master/tests/test_nvmf_run_host_traffic.py

NVMF run host traffic and disable target namespace(s):
	1. From the config file create Target.
	2. From the config file create host and connect to target.
	3. Start host traffic parallely on all host ns, disable target ns.
	4. Delete Host.
	5. Delete Target.

I can trigger a kernel warning. 

The resulting error:
[  294.559404] loop: module loaded
[  304.601864] loop: module loaded
[  305.710676] nvmet: adding nsid 1 to subsystem testnqn1
[  305.745667] nvmet: creating controller 1 for subsystem testnqn1 for NQN nqn.2014-08.org.nvmexpress:uuid:8b5e4215-fd40-4bac-9438-3878073e98ad.
[  305.745729] nvme nvme1: creating 4 I/O queues.
[  305.746155] nvme nvme1: new ctrl: "testnqn1"
[  314.025761] WARNING: CPU: 3 PID: 2178 at ../block/blk-mq.c:534 __blk_mq_complete_request+0x105/0x180
[  314.025763] Modules linked in: nvme_loop nvme_fabrics nvmet loop configfs af_packet xt_tcpudp ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc iscsi_ibft iscsi_boot_sysfs ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack libcrc32c iptable_mangle iptable_raw iptable_security ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc 8139too qxl ttm snd_hwdep aesni_intel aes_x86_64 8139cp drm_kms_helper crypto_simd glue_helper pcspkr cryptd
[  314.025789]  drm fb_sys_fops syscopyarea virtio_balloon sysfillrect snd_pcm snd_timer snd soundcore qemu_fw_cfg button sysimgblt mii i2c_piix4 btrfs xor zstd_decompress zstd_compress xxhash raid6_pq sr_mod cdrom ata_generic ata_piix uhci_hcd ehci_pci ehci_hcd crc32c_intel serio_raw floppy usbcore sg [last unloaded: loop]
[  314.025804] CPU: 3 PID: 2178 Comm: dd Not tainted 4.16.1-1-default #1 openSUSE Tumbleweed (unreleased)
[  314.025805] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
[  314.025806] RIP: 0010:__blk_mq_complete_request+0x105/0x180
[  314.025807] RSP: 0018:ffffbeb900d83a00 EFLAGS: 00010297
[  314.025808] RAX: 0000000000000000 RBX: ffff9bd97895c300 RCX: 0000000000000003
[  314.025809] RDX: 0000000000000003 RSI: ffffbeb900d83a24 RDI: ffff9bd97895c300
[  314.025810] RBP: ffffdeb8ffdb2380 R08: ffff9bd9e9a92300 R09: 0000000000000009
[  314.025810] R10: ffffbeb900d83b60 R11: 0000000000010000 R12: ffff9bd9e989d680
[  314.025811] R13: ffff9bd97895c4b8 R14: ffff9bd9e786eaa8 R15: ffff9bd97895c340
[  314.025812] FS:  00007f26b2c09540(0000) GS:ffff9bd9ffd80000(0000) knlGS:0000000000000000
[  314.025813] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  314.025814] CR2: 000055eaf5b20000 CR3: 00000000b14d4005 CR4: 00000000003606e0
[  314.025817] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  314.025817] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  314.025818] Call Trace:
[  314.025829]  blk_mq_complete_request+0x53/0x70
[  314.025832]  nvmet_req_init+0x85/0x130 [nvmet]
[  314.025835]  nvme_loop_queue_rq+0x87/0x210 [nvme_loop]
[  314.025837]  blk_mq_dispatch_rq_list+0x87/0x500
[  314.025838]  ? flush_busy_ctx+0x60/0x90
[  314.025840]  ? blk_mq_flush_busy_ctxs+0xc5/0xe0
[  314.025842]  blk_mq_sched_dispatch_requests+0x167/0x170
[  314.025844]  __blk_mq_run_hw_queue+0x53/0xb0
[  314.025846]  __blk_mq_delay_run_hw_queue+0x83/0xa0
[  314.025847]  blk_mq_run_hw_queue+0x6c/0xd0
[  314.025849]  blk_mq_flush_plug_list+0x1d2/0x250
[  314.025852]  blk_flush_plug_list+0xcb/0x260
[  314.025854]  blk_finish_plug+0x27/0x40
[  314.025857]  __do_page_cache_readahead+0x1b6/0x260
[  314.025860]  ? ondemand_readahead+0x117/0x2c0
[  314.025862]  ondemand_readahead+0x117/0x2c0
[  314.025864]  generic_file_read_iter+0x6bc/0x930
[  314.025867]  ? aa_file_perm+0x196/0x310
[  314.025870]  __vfs_read+0xdb/0x140
[  314.025872]  vfs_read+0x89/0x130
[  314.025874]  SyS_read+0x42/0x90
[  314.025876]  do_syscall_64+0x76/0x140
[  314.025878]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[  314.025880] RIP: 0033:0x7f26b271dbc1
[  314.025881] RSP: 002b:00007fffb1fea8a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  314.025882] RAX: ffffffffffffffda RBX: 000055eaf47fe400 RCX: 00007f26b271dbc1
[  314.025883] RDX: 0000000000001000 RSI: 000055eaf5b20000 RDI: 0000000000000000
[  314.025883] RBP: 0000000000001000 R08: 0000000000000003 R09: 0000007f2074a008
[  314.025884] R10: 00000000000008c6 R11: 0000000000000246 R12: 000055eaf5b20000
[  314.025884] R13: 0000000000000000 R14: 0000000000000000 R15: 000055eaf5b20000
[  314.025886] Code: 00 80 e6 80 74 2c 8b 55 40 44 39 e2 75 3b 48 8b 80 c8 00 00 00 48 89 df e8 39 d9 61 00 65 ff 0d c2 04 c3 71 74 78 5b 5d 41 5c c3 <0f> 0b e9 17 ff ff ff 8b 75 40 44 89 e7 e8 69 db cc ff 8b 55 40 
[  314.025908] ---[ end trace 5c8b379a09b78c31 ]---
[  314.025910] print_req_error: operation not supported error, dev nvme1c1n1, sector 70560
[  314.052741] nvme nvme1: rescanning
[  317.389190] print_req_error: operation not supported error, dev nvme1c1n1, sector 71584
[  317.389812] Buffer I/O error on dev nvme1n1, logical block 8820, async page read

Feel free to request any kind of further information or assistance.

Michael
--
Michael Moese			Kernel QA
mmoese@suse.de
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
